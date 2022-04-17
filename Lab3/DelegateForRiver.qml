import QtQuick 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0

// Создаём строку для нашаего List и часть визуальной логики
Rectangle {
    id: rivItem
    // Создаём свойства, для определённого выделения цветом элементов
    // Цвет элемента списка на которого наведена мышка
    readonly property color selectedBackgroundColor: "#9400D3"
    // Цвет для четных пунктов списка
    readonly property color evenBackgroundColor: "#F8F8FF"
    // Цвет для нечетных пунктов списка
    readonly property color oddBackgroundColor: "#EEE8AA"

    // Создаём свойство, которое определяет выбран ли наш елемент по щелчку мышки
    property bool isCurrent: rivItem.ListView.view.currentIndex === index
    // Создаём свойство, которое определяет хранит в себе, то навели ли мы на элемент курсор
    property bool selected: rivItemMouseArea.containsMouse || isCurrent

    // Здесь задаётся модель по которой будет браться информация
    property variant riverData: model

    // Берем ширину по родительскому объекту (ListView)
    width: parent ? parent.width : rivList.width
    // И задаём определённую длинну
    height: 160

    // Задаём массив состояний элемента
    states: [
        // Создаём состояние когда элемент выбран
        State {
            when: selected
            // Задаём изменение элемента
            // Если мы щелкнули на сроку ListView, то она меняет цвет на selectedBackgroundColor
            PropertyChanges { target: rivItem;
                color: isCurrent ? palette.highlight : selectedBackgroundColor
            }
        },
        // Создаём состояние когда элемент не выбран
        State {
            when: !selected
            // Задаём изменение элемента
            // Если мы щелкнули на другой элемент ListView, то она меняет цвет на evenBackgroundColor или oddBackgroundColor
            // Зависит от чётности-нечётности индекса строки в ListView
            PropertyChanges { target: rivItem;
                color: isCurrent ? palette.highlight : index % 2 == 0 ? evenBackgroundColor : oddBackgroundColor }
        }
    ]
    // Задаём кликабельность строки ListView
    MouseArea {
        id: rivItemMouseArea
        // Задаём расположение, как у Rectangle
        anchors.fill: parent
        // И говорим, что мы разрешаем изменяться жлементу при наведении на него курсором
        hoverEnabled: true
        // И задаём функцию на клике (задаём индекс выбранной строки и активируем функцию forceActiveFocus)
        onClicked: {
            rivItem.ListView.view.currentIndex = index
            rivItem.forceActiveFocus()
        }
    }

    // А теперьсоздаём то, что в Rectangle будет написано
    Item {
        id: itemOfRivers
        // Задаём ширину и высоту, как у Rectangle
        width: parent.width
        height: parent.height
        // Задаём колонку для названия реки
        Column{
            id: t2
            // Настраиваем её, чтобы она была слева
            anchors.left: parent.left
            anchors.leftMargin: 10
            // И настраиваем её ширину
            width: 240
            // И делаем надписи вертикально по центру
            anchors.verticalCenter: parent.verticalCenter
            // Создаём текстовое поле с обозначением поля
            Text {
                id: t1
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Название реки:"
                color: "Indigo"
                font.pointSize: 16
            }
            // Создаём тестовое поле с названием реки из модели
            Text {
                id: textName
                anchors.horizontalCenter: parent.horizontalCenter
                text: nameOfRiver
                color: "Indigo"
                font.pointSize: 20
                font.bold: true
            }
        }
        // Задаём колонку для подробной информации по реке
        Column{
            // Задаём расположение и отступы для это1 колонки
            anchors.left: t2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            // Задаём текстовые поля для протяжённости реки
            Text {
                text: "Протяженность:"
                color: "Indigo"
                font.pointSize: 10
            }
            Text {
                id: textLenght
                text: lenghtOfRiver
                color: "Indigo"
                font.pointSize: 12
                font.bold: true
            }
            // Задаём текстовые поля для информации куда вподает река
            Text {
                text: "Куда впадает:"
                color: "Indigo"
                font.pointSize: 10
            }
            Text {
                id: textFlow
                color: "Indigo"
                text: flowOfRiver
                font.pointSize: 12
                font.bold: true
            }
            // Задаём текстовые поля для информации о годовом стоке
            Text {
                text: "Годовой сток:"
                color: "Indigo"
                font.pointSize: 10
            }
            Text {
                id: textRunoff
                text: runoffOfRiver
                color: "Indigo"
                font.pointSize: 12
                font.bold: true
            }
            // Задаём текстовые поля для площади бассейна
            Text {
                text: "Площадь бассейна:"
                color: "Indigo"
                font.pointSize: 10
            }
            Text {
                id: textArea
                color: "Indigo"
                text: areaOfRiver
                font.pointSize: 12
                font.bold: true
            }
        }
    }
}
