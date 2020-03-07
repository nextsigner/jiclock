import QtQuick 2.0

Item{
    id:r
    width: parent.width
    height: app.fs*2
    property alias focusTextInput:tiData.focus
    property string label: 'Input: '
    property color fontColor: app.c2
    property int customHeight: -1
    signal seted(string text)
    signal textChanged(string text)
    Row{
        spacing: app.fs*0.5
        Text{
            id: label
            text: r.label
            font.family: unikSettings.fontFamily
            font.pixelSize: app.fs
            color: r.fontColor
            anchors.verticalCenter: parent.verticalCenter
        }
        Rectangle{
                width: r.width-label.contentWidth-parent.spacing
                height: r.customHeight===-1?app.fs*2:r.customHeight
                color: 'transparent'
                border.width: unikSettings.borderWidth
                border.color: r.fontColor
                radius: unikSettings.radius
                TextInput{
                    id: tiData
                    font.pixelSize: app.fs
                    focus: true
                    width: parent.width-app.fs
                    height: app.fs
                    clip: true
                    anchors.centerIn: parent
                    onTextChanged: r.textChanged(text)
                    Keys.onReturnPressed: r.seted(text)
                    color: r.fontColor
                }
        }
    }
}
