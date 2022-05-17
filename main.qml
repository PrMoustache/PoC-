import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11

import "."
Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Marche{
        id:marche
        anchors.left: parent.left
        anchors.right: columnLayout.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 5
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        antialiasing: true

    }
    GridLayout {
        id: columnLayout
        anchors.left: canvas.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 100
        anchors.rightMargin: 8
        anchors.topMargin: 8
        columns: 2
        Text{
            text:"Angle de la pente [°]"
        }

        TextField {
            id: textField
            focus: true
            placeholderTextColor: "#cc6f0d"
            Layout.fillHeight: false
            Layout.fillWidth: true
            placeholderText: qsTr("Angle pente")
            validator: DoubleValidator{
                bottom: -90
                top:90
            }
            onAccepted: {
                console.log(Number(text))
                marche.angle=Number(text)*Math.PI/180.0
            }
        }
        //
        Text{
            text:"Hauteur demarche [mm]"
        }

        TextField {
            id: textFieldH
            focus: true
            placeholderTextColor: "#cc6f0d"
            Layout.fillHeight: false
            Layout.fillWidth: true
            placeholderText: qsTr("H")
            validator: DoubleValidator{
                bottom: 0.0
                top:15
            }
            onAccepted: {
                marche.h=Number(text)
            }
        }
        //
        Text{
            text:"Profondeur de passe  [mm]"
        }

        TextField {
            id: textFieldSy
            focus: true
            placeholderTextColor: "#cc6f0d"
            Layout.fillHeight: false
            Layout.fillWidth: true
            placeholderText: qsTr("Sy")
            validator: DoubleValidator{
                bottom: 0.0
                top:15
            }
            onAccepted: {
                marche.sy=Number(text)
            }
        }

        //
        Text{
            text:"Largeur de passe  [mm]"
        }

        TextField {
            id: textFieldDx
            focus: true
            placeholderTextColor: "#cc6f0d"
            Layout.fillHeight: false
            Layout.fillWidth: true
            placeholderText: qsTr("Dx")
            validator: DoubleValidator{
                bottom: 0.0
                top:15
            }
            onAccepted: {
                marche.dx=Number(text)
            }
        }
        //
        Text{
            text:"Taux de recouvrement [%]"
        }

        TextField {
            id: textFielX
            focus: true
            placeholderTextColor: "#cc6f0d"
            Layout.fillHeight: false
            Layout.fillWidth: true
            placeholderText: qsTr("tx")
            validator: DoubleValidator{
                bottom: 0.0
                top:95
            }
            onAccepted: {
                marche.sx=(100-Number(text))/100.0*marche.dx
            }
        }
        //
        Text{
            text:"Pas en X  [mm]"
        }

        TextField {
            id: textFieldSx
            focus: true
            readOnly: true
            placeholderTextColor: "#cc6f0d"
            Layout.fillHeight: false
            Layout.fillWidth: true
            placeholderText: qsTr("Sx")
            text:marche.sx+" mm"
        }



        Item {
            id: spacer0
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
         Item {
            id: sapcer1
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.5;height:1080;width:1920}
}
##^##*/
