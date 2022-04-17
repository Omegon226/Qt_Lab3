#include "river.h"

// Это класс реки, который будет хранится в нашей таблице с реками

River::River()
{
}

void River::setID(const QString ID)
{
    id = ID;
}
void River::setName(const QString Name)
{
    name = Name;
}
void River::setFlow(const QString Flow)
{
    flow = Flow;
}
void River::setLenght(const QString Lenght)
{
    lenght = Lenght;
}
void River::setRunoff(const QString Runoff)
{
    runoff = Runoff;
}
void River::setArea(const QString Area)
{
    area = Area;
}

QString River::getID() const
{
    return id;
}
QString River::getName() const
{
    return name;
}
QString River::getFlow() const
{
    return flow;
}
QString River::getLenght() const
{
    return lenght;
}
QString River::getRunoff() const
{
    return runoff;
}
QString River::getArea() const
{
    return area;
}

 River::~River()
{
}
