import QtQuick 6.0
import QtQuick.Window 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0

import "JsScript.js" as JSLogger // Подключение JS файла

// Соновное окно нашего приложения
Window {
    visible: true // Настройка видимости окна
    width: 800 // Ширина окна
    height: 550 // Высота окна
    title: qsTr("СПРАВОЧНИК ГИДРОЛОГА") // Название окна

    // Объявляется системная палитра
    // Мы сможем с помощью неё задавать цвета елементам
    SystemPalette {
          id: palette;
          colorGroup: SystemPalette.Active
       }

    // Элемент ScrollView можно было засунуть в контейнер в виде Rectangle, ScrollView достаточно простой

    // Добавляем элемент который можно будет прокручивать
    ScrollView {
        // Устанавливаем какие ползунки у нас будут активными
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        // После чего говорим в каком месте должен распологаться элемент
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: butAdd.top

        ListView {
            id: rivList
            // Устанавливаем якори для ListView
            anchors.fill: parent
            // Здесь происходит инициализация нашей модели
            model: riverModel
            // Устанавливаем делегат который улучшает отображение элементов
            delegate: DelegateForRiver{}
            // clip - позволяет не залезать строк таблицы под кнопки
            clip: true
        }
    }


    Button {
        id: butAdd
        // Устанавливаем расположение кнопки
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.rightMargin: 8
        anchors.right:butEdit.left
        // Устанавливаем текст
        text: "Дообавить реку"
        // Устанавливаем размер
        width: 100
        // Устанавливаем функцию, котораю будет вызываться
        onClicked: windowAdd.show()
    }

    Button {
        id: butEdit
        // Устанавливаем расположение кнопки
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: butDel.left
        anchors.rightMargin: 8
        // Устанавливаем текст
        text: "Изменить реку"
        // Устанавливаем размер
        width: 100
        // Указываем условие при котором эта кнопка будет активна
        enabled: rivList.currentIndex >= 0
        // Устанавливаем функцию, котораю будет вызываться
        onClicked: {
            // Закидываем из выбранного желемента в ListView переменные
            var nameRiv = rivList.currentItem.riverData.nameOfRiver
            var lenghtRiv = rivList.currentItem.riverData.lenghtOfRiver
            var flowRiv = rivList.currentItem.riverData.flowOfRiver
            var runoffRiv = rivList.currentItem.riverData.runoffOfRiver
            var areaRiv = rivList.currentItem.riverData.areaOfRiver
            // После чего вызываем окно для редактирования информации
            windowEdit.execute(nameRiv, lenghtRiv, flowRiv, runoffRiv, areaRiv, rivList.currentIndex)
        }
    }

    Button {
        id: butDel
        // Устанавливаем расположение кнопки
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right:parent.right
        anchors.rightMargin: 8
        // Устанавливаем текст
        text: "Удалить реку"
        // Устанавливаем размер
        width: 100
        // Указываем условие при котором эта кнопка будет активна
        enabled: rivList.currentIndex >= 0
        // Устанавливаем функцию, котораю будет вызываться
        onClicked: {
            del(rivList.currentIndex)
            JSLogger.debugLogger("Вызов функции удаления строки")
        }
    }

    Label {
        id: labelArea
        // Устанавливаем расположение надписи
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        anchors.left: parent.left
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        // Выравниваем по правой стороне
        Layout.alignment: Qt.AlignRight
        // Настраиваем текст
        text: qsTr("Введите нужную площадь бассейна:")
    }

    TextField {
        id: textSelArea
        Layout.fillWidth: true
        // Устанавливае что может быть введено в поле
        validator: IntValidator {bottom: 0;}
        // Позволяет установить текст до ввода информации
        placeholderText: qsTr("Введите число >= 0")
        // Устанавливаем расположение кнопки
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.leftMargin: 8
        anchors.left: labelArea.right
        anchors.rightMargin: 8
    }

    Button {
        id: butCount
        // Устанавливаем расположение кнопки
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.left: textSelArea.right
        anchors.leftMargin: 8
        // Устанавливаем текст
        text: "Подсчитать"
        // Устанавливаем ширину кнопки
        width: 100
        // Указываем условие при котором эта кнопка будет активна
        enabled: textSelArea.text != ""
        // Устанавливаем функцию
        onClicked: {
            windowAnswer.countRivers(textSelArea.text)
            JSLogger.debugLogger("Вызов функции подсчёта кол-ва рек бассейн которых больше введёного числа")
        }
    }

    // Создаём классы для диалоговых окон
    DialogForAdd {
        id: windowAdd
    }
    DialogForEdit {
        id: windowEdit
    }
    DialogForAnswer {
        id: windowAnswer
    }
}
