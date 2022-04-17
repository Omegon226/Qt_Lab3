#include "riverlist.h"
#include <QDebug>
#include <QMessageBox>
#include <QWidget>
#include <QApplication>
#include <QFile>
#include <QTextStream>
#include <QDebug>

// Место для добавления изначально заложенных эдементов, мы считываем их из CSV файла
RiverList::RiverList(QObject* parent):QAbstractListModel(parent)
{
    QFile file("C:/Qt_proj/Lab3/info.csv");
    if ( !file.open(QFile::ReadOnly | QFile::Text) )
    {
        qDebug() << "File not exists";
    }
    else
    {
        QTextStream in(&file);

        while (!in.atEnd())
        {
            QString line = in.readLine();
            QString array[5] = {"", "", "", "", ""};
            int counter = 0;

            for (QString item : line.split(",")) {
                array[counter] = item;
                ++counter;
            }
            add(array[0], array[1], array[2], array[3], array[4]);
        }
        file.close();
    }
}

RiverList::~RiverList()
{

}

// Переопределяемая функция для подсчёта кол-ва строк
int RiverList::rowCount(const QModelIndex&) const
{
    return listOfRivers.size();
}

// Эта переопределяемая функция позволяет нам понять, что находится в нашей модели
QVariant RiverList::data(const QModelIndex &index, int role) const
{
    // Если мы в не диапазона информации то выводим пустой QVariant иначе выводим информацию
    if (index.row() < 0 || index.row() >= listOfRivers.size())
            return QVariant();
      {
        switch (role) {
                case name:
                    return QVariant(listOfRivers.at(index.row()).getName());
                case lenght:
                    return QVariant(listOfRivers.at(index.row()).getLenght());
                case flow:
                    return QVariant(listOfRivers.at(index.row()).getFlow());
                case runoff:
                    return QVariant(listOfRivers.at(index.row()).getRunoff());
                case area:
                    return QVariant(listOfRivers.at(index.row()).getArea());

                default:
                    return QVariant();
            }

    }
}

// Эта функция определяет название переменных в QML для riverlist
QHash<int, QByteArray> RiverList::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[name] = "nameOfRiver";
    roles[lenght] = "lenghtOfRiver";
    roles[flow] = "flowOfRiver";
    roles[runoff] = "runoffOfRiver";
    roles[area] = "areaOfRiver";
       return roles;
}

// Эта переопределяемая функция позволят нам вводить информацию о новых реках
void RiverList::add(const QString& nameRiv, const QString& lenghtRiv, const QString& flowRiv, const QString& runoffRiv, const QString& areaRiv)
{
    // Создаём новый класс реки и определяем туда информацию
    River river;
    river.setName(nameRiv);
    river.setLenght(lenghtRiv);
    river.setFlow(flowRiv);
    river.setRunoff(runoffRiv);
    river.setArea(areaRiv);

    // Добавляем реку в список
    beginInsertRows(QModelIndex(),listOfRivers.size(),listOfRivers.size());
    // Добавление информации в конец списка
    listOfRivers.append(river);
    endInsertRows();
}

// Переопределяемая функция, которая позволяет получить класс модели
QAbstractListModel* RiverList::getModel()
{
    return this;
}

// Эта функция позволяет нам удалить информацию из модели
void RiverList::del(const int index)
{
    // Если у нас есть указанный индекс для удаения, то удаляем элемент из списка
    if (index >= 0 && index < listOfRivers.size())
    {
        // сообщение модели о процессе удаления данных
        beginRemoveRows(QModelIndex(), index, index);
        listOfRivers.removeAt(index);
        endRemoveRows();
    }
    else qDebug() << "Error index";

}

// Эта функция позволяет нам изменять информацию о реках
void RiverList::edit(const QString& nameRiv, const QString& lenghtRiv, const QString& flowRiv, const QString& runoffRiv, const QString& areaRiv, const int index)
{
    // Если существует такой индекс, то произведём изменение информации, иначе выведем в дебаг ошибку
    if(index >= 0 && index < listOfRivers.size() )
    {
        auto& currentRiver = listOfRivers[index];
        if (currentRiver.getName().compare(nameRiv)!=0 || currentRiver.getLenght() != lenghtRiv || currentRiver.getFlow() != flowRiv
            || currentRiver.getRunoff() != runoffRiv || currentRiver.getArea() != areaRiv)
        {
            currentRiver.setName(nameRiv);
            currentRiver.setLenght(lenghtRiv);
            currentRiver.setFlow(flowRiv);
            currentRiver.setRunoff(runoffRiv);
            currentRiver.setArea(areaRiv);

            auto modelIndex = createIndex(index, 0);
            emit dataChanged(modelIndex, modelIndex);
            qDebug() << listOfRivers[index].getArea();
        }

    }
    else qDebug() << "Error index";
}

// Эта функция позволяет поределеить кол-во рек, которые больше по объёму, чем указанное значение
QString RiverList::count(const QString& textSelArea)
{
    int count = 0;
    for(int i = 0; i < listOfRivers.size(); i++)
        if(listOfRivers[i].getArea().toInt() > textSelArea.toInt())
            count++;
    QString c = QString::number(count);
    return c;
}
