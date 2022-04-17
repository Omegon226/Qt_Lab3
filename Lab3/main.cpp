#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <riverlist.h>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    // Создаём GUI нашему приложению
    QGuiApplication app(argc, argv);

    // Создаём модель рек для нашего приложения
    RiverList viewModel;

    // Создаём двидок, который подключит QML к нашему приложению
    QQmlApplicationEngine engine;

    QQmlContext *context = engine.rootContext();
    // Загружаем модель наших данных
    context->setContextObject(&viewModel);
    // Запускаем в движёк наш QML
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    // Запускаем приложение
    return app.exec();
}
