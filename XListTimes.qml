import QtQuick 2.0

Rectangle {
    id: r
    anchors.fill: parent
    color: app.c1
    property string cFileName: ''
    onCFileNameChanged: {
        loadFile(cFileName)
        let fileName='uFileName'
        unik.setFile(fileName, cFileName)
    }
    Column{
        spacing: app.fs
        width: parent.width
        height: parent.height
        Item{width: 1; height: app.fs*0.5}
        BotonUX{
            text: 'Atras'
            onClicked: xListTimes.visible=false
            height: app.fs*2
        }
        Item{
            id: xSetFile
            width: r.width
            height: app.fs*2
            //color: app.c1
            property bool editing: false
            UTextInput{
                id: tiFileName
                label: '<b>Archivo: </b>'
                width: xSetFile.width-app.fs
                anchors.horizontalCenter: parent.horizontalCenter
                visible: parent.editing
                onSeted: {
                    //uLogView.showLog('Seted: '+text)
                    let fileName=text+'.json'
                    if(!unik.fileExist(fileName)){
                        unik.setFile(fileName, '{}')
                    }else{
                        r.cFileName=fileName
                    }
                    parent.editing=false
                }
            }
            Item{
                width: tiFileName.width
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                visible: !parent.editing
                Row{
                    spacing: app.fs
                    Text {
                        id: labelCurrentFileName
                        text: '<b>Archivo: </b> '+r.cFileName.replace('.json', '')
                        font.pixelSize: app.fs
                        color: app.c2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    BotonUX{
                        text: 'Cambiar'
                        onClicked: xSetFile.editing=true
                        height: app.fs*2
                    }
                }
                /*MouseArea{
                    anchors.fill: parent
                    onClicked: parent.parent.editing=true
                }*/
            }
        }
        Rectangle{
            id: xTit
            width: r.width
            height: app.fs*2
            color: app.c2
            UText{
                text: 'Lista de Horas'
                anchors.centerIn: parent
                color: app.c1
            }
        }
        ListView{
            id: lv
            spacing: app.fs*0.25
            model: lm
            delegate: del
            width: parent.width
            height: r.height-xTit.height-parent.spacing
        }
    }
    ListModel{
        id: lm
        function addItem(h, a, e){
            return {
                hora: h,
                asunto: a,
                habilitado: e
            }
        }
    }
    Component{
        id: del
        Rectangle{
            id: xItem
            width: r.width-app.fs
            height: txtAsunto.contentHeight+app.fs*2
            anchors.horizontalCenter: parent.horizontalCenter
            radius: unikSettings.radius
            border.width: 2
            border.color: app.c2
            color: app.c1
            opacity: habilitado?1.0:0.5
            Row{
                spacing: app.fs*3
                anchors.centerIn: parent
                UText {
                    id: txtHora
                    text: '<b>Hora:</b> '+hora
                    anchors.verticalCenter: parent.verticalCenter
                }
                UText {
                    id: txtAsunto
                    text: '<b>Asunto:</b> '+asunto
                    width: xItem.width-txtHora.contentWidth-app.fs*4
                    wrapMode: Text.WordWrap
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle{
                        width: xItem.border.width
                        height: xItem.height
                        color: xItem.border.color
                        anchors.left: parent.left
                        anchors.leftMargin: 0-app.fs*2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    xEditItem.currentIndex=index
                    let d0=txtHora.text.split(' ')
                    xEditItem.h=d0[1].split(':')[0]
                    xEditItem.m=d0[1].split(':')[1]
                    xEditItem.a=txtAsunto.text.replace('<b>Asunto:</b> ', '')
                    xEditItem.visible=true
                }
            }
        }
    }
    UxBotCirc{
        opacity: labelTit.opacity
        width: app.fs*3
        text: '<b>+</b>'
        animationEnabled: true
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: app.fs*0.5
        onClicked: {
                lm.append(lm.addItem('00:0', '', false))
                xEditItem.currentIndex=lm.count-1
                xEditItem.visible=true
        }
    }
    XEditItem{
        id: xEditItem
        visible: false
        onEditFinished: {
            lm.get(index).hora=h+':'+m
            lm.get(index).asunto=a
            lm.get(index).habilitado=true
            let json='{\n"items":[\n'
            for(var i=0;i<lm.count; i++){
                if(i!==0)json+=','
                json+='{"item":{'
                json+='"hora":"'+lm.get(i).hora+'",'
                json+='"asunto":"'+lm.get(i).asunto+'",'
                json+='"habilitado":'+lm.get(i).habilitado+''
                json+='}}\n'
            }
            json+=']\n}'
            unik.setFile(r.cFileName, json)
            //uLogView.showLog(json)
        }
    }
    Component.onCompleted: {
        let fileName='uFileName'
        if(!unik.fileExist(fileName)){
            unik.setFile(fileName, 'ejemplo.json')
        }else{
            r.cFileName=unik.getFile(fileName)
        }
    }
    function addItem(hora, asunto, habilitado){
        lm.append(lm.addItem(hora, asunto, habilitado))
    }
    function getHoras(){
        let a = []
        for(var i=0;i<lm.count; i++){
            a.push(lm.get(i).hora)
        }
        return a
    }
    function loadFile(fileName){
        let json = JSON.parse(unik.getFile(fileName))
        lm.clear()
        if(Object.keys(json).length===0)return
        for(var i=0;i<Object.keys(json['items']).length;i++){
            //uLogView.showLog(json['items'][i]['item'].hora)
            let h = json['items'][i]['item'].hora
            let a = json['items'][i]['item'].asunto
            let e = json['items'][i]['item'].habilitado
            lm.append(lm.addItem(h, a, e))
        }
    }
}
