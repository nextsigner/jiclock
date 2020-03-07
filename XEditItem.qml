import QtQuick 2.0

Rectangle {
    id: r
    width: parent.width
    height: col.height+app.fs
    color: app.c1
    border.width: unikSettings.borderWidth
    border.color: app.c2

    Column{
        id: col
        spacing: app.fs
        anchors.centerIn: parent
        UText{
            text: '<b>Editor de Alarma</b>'
            font.pixelSize: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Row{
            spacing: app.fs
            UTextInput{
                label: 'Hora:'
                width: app.fs*6
            }
            UTextInput{
                label: 'Minuto:'
                width: app.fs*6
            }
        }
        UTextInput{
            label: 'Asunto:'
        }
    }
}
