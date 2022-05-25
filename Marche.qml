import QtQuick 2.12
import "uma.js" as Uma

Item {
    id:root
    property real angle: 3*Math.PI/180.0
    property real h: 10
    property real dx: 10.0
    property real sy: 3.0
    property real sx: root.dx/2
    property real lx: h/Math.tan(angle)
    property var pts: Uma.generatePts(angle,sx,sy,h,dx)
    property int cnt: root.pts.length
    property var retcs: Uma.generate(angle,sx,sy,h,dx)
    property var ptsStatus: new Array(10000)
    function refresh(){
        canvas.requestPaint()
    }

    onPtsChanged: {
        root.cnt=root.pts.length
        root.ptsStatus.fill(false)
        canvas.requestPaint()
    }
    onPtsStatusChanged: {
        canvas.requestPaint()
        if(ptsStatus.length !== pts.length)
        {
            console.error("ptsStatus and pts dimenssion mismatch")
        }
    }


    Canvas{
        id:canvas
        anchors.fill: parent
        antialiasing: true
        clip:true
        contextType: "2d"
        property real drawing_width: 50+root.lx
        property real drawing_heigth: 1.2*root.h
        property real scaleX:parent.width/drawing_width
        property real scaleY: parent.height/drawing_heigth
        Text{
            text:root.angle*180/Math.PI+"°"
            x:Math.cos(Math.atan2(root.h,root.lx)/2)*(root.h/2/parent.scaleY+10)*parent.scaleX+100
            y:(root.h-(Math.sin(Math.atan2(root.h,root.lx)/2)*(root.h/2/parent.scaleY+10)))*parent.scaleY+100
        }

        function _x(x){
            return x*scaleX
        }
        function _y(y){
            return y*scaleY
        }


        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            ctx.translate(100,100)
            ctx.font="16px ubuntu normal"
            ctx.fillText("\u0394H:"+Number(root.h).toFixed(1)+" mm",scaleX*(root.lx-20),scaleY*root.h/2)
            ctx.fillText("\u0394X:"+Number(root.lx).toFixed(1)+" mm",scaleX*(root.lx/2),-10)
            //ctx.scale(scaleX,scaleY)
            ctx.beginPath()
            ctx.fillStyle = Qt.rgba(1, 0, 0, 1);
            ctx.setLineDash([1 ,0])
            ctx.lineCape="butt"
            ctx.lineWidth=1.25
            ctx.strokeStyle="green"
            //ligne départ gauche
            ctx.moveTo(_x(-200),_y(root.h))
            ctx.lineTo(0,_y(root.h))
            //pente d'usinage
            ctx.moveTo(0,_y(root.h))
            ctx.lineTo(_x(root.lx),0)
            //ligne de fin à droite
            ctx.lineTo(_x(root.lx+200),0)
            ctx.stroke()

            //Arc indicateur d'angle
            ctx.beginPath()
            ctx.lineWidth=1.25
            ctx.strokeStyle="green"
            ctx.setLineDash([4,4])
            ctx.arc(0,_y(root.h),_y(root.h/2),0,-Math.atan2(_y(root.h),_x(root.lx)),true)
            ctx.stroke()
            ctx.closePath()

            //ligne du bas pointillé
            ctx.beginPath()
            ctx.setLineDash([4,4])
            ctx.strokeStyle="green"
            ctx.moveTo(0,_y(root.h))
            ctx.lineTo(_x(root.lx+200),_y(root.h))
            ctx.stroke()


            ctx.beginPath()
            ctx.setLineDash([1 ,0])
            ctx.strokeStyle="red"
            ctx.moveTo(_x(root.lx),0)
            ctx.lineTo(0,0)
            ctx.lineTo(0,_y(root.h))
            ctx.stroke()
            //dessin des passes
            ctx.beginPath()
            ctx.strokeStyle="orange"
            ctx.setLineDash([1 ,0])
            ctx.lineWidth=1.0
            ctx.fillStyle = Qt.rgba(0.5, 0, 0, 0.25);
            Uma.drawRects(root.retcs,root.ptsStatus,ctx,scaleX,scaleY)

        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:1080;width:1920}D{i:1}
}
##^##*/
