#ifndef RIVERLIST_H
#define RIVERLIST_H

#include <QAbstractListModel>
#include <QVariant>
#include <QList>
#include <QModelIndex>
#include <QItemSelectionModel>
#include "river.h"

class RiverList : public QAbstractListModel
{
    Q_OBJECT
    // Мы здесь говорим, что по riverModel можно будет образаться в QML, getModel - позволяет получить значения из модели
    Q_PROPERTY(QAbstractListModel* riverModel READ getModel CONSTANT)

private:
    // Массив с данными
    QList<River> listOfRivers;
    QAbstractListModel *getModel();

public:
    RiverList(QObject *parent = nullptr);
    ~RiverList() override;

    // Перечисление для информации
    enum ResentRoles {
            name = Qt::DisplayRole,
            lenght = Qt::DisplayRole + 1,
            flow = Qt::DisplayRole + 2,
            runoff = Qt::DisplayRole + 3,
            area = Qt::DisplayRole + 4
       };

    // Количество колонок
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    // Возвращение данных модели по указанному индексу и роли
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

    // Это макрос (Q_INVOKABLE), для того, что к этой модели можно обратиться из QML
    Q_INVOKABLE void add(const QString& nameRiv, const QString& lenghtRiv, const QString& flowRiv, const QString& runoffRiv, const QString& areaRiv);
    Q_INVOKABLE void del(const int index);
    Q_INVOKABLE void edit(const QString& nameRiv, const QString& lenghtRiv, const QString& flowRiv, const QString& runoffRiv, const QString& areaRiv, const int index);
    Q_INVOKABLE QString count(const QString& textSelArea);
};

#endif // RIVERLIST_H
