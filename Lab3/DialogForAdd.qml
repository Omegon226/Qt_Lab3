import QtQuick 6.0
import QtQuick.Window 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0

// Диалоговое окно для добавления новой реки
Window {
    id: root
    // Говорим, что это окно является модальным
    modality: Qt.ApplicationModal
    title: qsTr("Ввод новой информации о реке")
    // Задаём максимальные и минимальные размеры окна
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 200
    maximumHeight: 200

    // Создаём Grid в котором будем размещать элементы
    GridLayout {
        // Задаём расстановку нашего Grid
        anchors { left: parent.left;
                  top: parent.top;
                  right: parent.right;
                  bottom: buttonCancel.top;
                  margins: 10 }
        // Задаём 2 колоноки (Слева Label, Справа TextField)
        columns: 2

        Label {
            // Выравнивание элемента по правой стороне
            Layout.alignment: Qt.AlignRight
            // Вставляем текст для элемента
            text: qsTr("Название реки:")
        }
        TextField {
            id: textName
            // Заполнить весь элемент в ширину
            Layout.fillWidth: true
            // Устанавливаем текст до ввода информации
            placeholderText: qsTr("Введите название")
        }
        Label {
            // Выравнивание элемента по правой стороне
            Layout.alignment: Qt.AlignRight
            // Вставляем текст для элемента
            text: qsTr("Протяженность:")
        }
        TextField {
            id: textLenght
            // Заполнить весь элемент в ширину
            Layout.fillWidth: true
            // Устанавливаем текст до ввода информации
            placeholderText: qsTr("Введите длину")
            // Устанавливае что может быть введено в поле
            validator: IntValidator {bottom: 0;}
        }
        Label {
            // Выравнивание элемента по правой стороне
            Layout.alignment: Qt.AlignRight
            // Вставляем текст для элемента
            text: qsTr("Куда впадает?:")
        }
        TextField {
            id: textFlow
            // Заполнить весь элемент в ширину
            Layout.fillWidth: true
            // Устанавливаем текст до ввода информации
            placeholderText: qsTr("Введите, куда впадает река")
        }
        Label {
            // Выравнивание элемента по правой стороне
            Layout.alignment: Qt.AlignRight
            // Вставляем текст для элемента
            text: qsTr("Годовой сток:")
        }
        TextField {
            id: textRunoff
            // Заполнить весь элемент в ширину
            Layout.fillWidth: true
            // Устанавливаем текст до ввода информации
            placeholderText: qsTr("Введите годовой сток")
            // Устанавливае что может быть введено в поле
            validator: IntValidator {bottom: 0;}
        }
        Label {
            // Выравнивание элемента по правой стороне
            Layout.alignment: Qt.AlignRight
            // Вставляем текст для элемента
            text: qsTr("Площадь бассейна:")
        }
        TextField {
            id: textArea
            // Заполнить весь элемент в ширину
            Layout.fillWidth: true
            // Устанавливаем текст до ввода информации
            placeholderText: qsTr("Введите площадь бассейна")
            // Устанавливае что может быть введено в поле
            validator: IntValidator {bottom: 0;}
        }
    }
    // Создаём кнопку добавления информации
    Button {
        // Добавляем условия появления кнопки
        visible: {textName.length>0 && textLenght.length>0}
        // Задаём расположение кнопки и её размеры
        anchors { right: buttonCancel.left;
                  verticalCenter: buttonCancel.verticalCenter;
                  rightMargin: 10 }
        width: 100
        text: qsTr("Добавить в список")
        // Задаём функцию на нажатие (модальное окно закроется, информация добавится)
        onClicked: {
            root.hide()
            add(textName.text, textLenght.text, textFlow.text, textRunoff.text, textArea.text)
        }
    }
    // Создаём кнопку отмены добавления информации
    Button {
        id: buttonCancel
        // Задаём расположение кнопки и её размеры
        anchors { right: parent.right;
                  bottom: parent.bottom;
                  rightMargin: 10;
                  bottomMargin: 10 }
        width: 100
        text: qsTr("Отменить")
        // Задаём функцию на нажатие (модальное окно закроется)
        onClicked: {
             root.hide()
        }
    }
}
