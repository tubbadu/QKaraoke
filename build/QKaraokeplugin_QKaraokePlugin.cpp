// This file is autogenerated by CMake. Do not edit.

#include <QtQml/qqmlextensionplugin.h>

extern void qml_register_types_QKaraoke();
Q_GHS_KEEP_REFERENCE(qml_register_types_QKaraoke)

class QKaraokePlugin : public QQmlEngineExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlEngineExtensionInterface_iid)

public:
    QKaraokePlugin(QObject *parent = nullptr) : QQmlEngineExtensionPlugin(parent)
    {
        volatile auto registration = &qml_register_types_QKaraoke;
        Q_UNUSED(registration)
    }
};



#include "QKaraokeplugin_QKaraokePlugin.moc"
