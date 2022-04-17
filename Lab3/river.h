#ifndef RIVER_H
#define RIVER_H
#include "QString"

class River
{

public:
    River();
    virtual ~River();
    void setID(const QString ID);
    void setName(const QString Name);
    void setFlow(const QString Flow);
    void setLenght(const QString Lenght);
    void setRunoff(const QString Runoff);
    void setArea(const QString Area);

    QString getID() const;
    QString getName() const;
    QString getFlow() const;
    QString getLenght() const;
    QString getRunoff() const;
    QString getArea() const;

private:
    // Индекс реки
    QString id;
    // Название реки
    QString name;
    // Протяжённость реки
    QString lenght;
    // Название реки, куда она впадает
    QString flow;
    // Годовой сток
    QString runoff;
    // Площадь бассейна
    QString area; 
};

#endif // RIVER_H
