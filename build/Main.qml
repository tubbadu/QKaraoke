import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Dialogs as Dialogs
import QtQuick.Layouts
import QtMultimedia
import Qt.labs.folderlistmodel
import Qt.labs.platform

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    visibility: Window.FullScreen

    property var files: []
    property var players: ["Ala", "Alesauro", "Baccolino", "Nana", "Kia", "Ali"]
    property int np: players.length
    property var matches: []
    property int index: -1

    Shortcut {
        enabled: karaokeView.visible
        sequence: "Space" // Define the key combination to be captured
        onActivated: {
            console.warn("Space key pressed globally!")
            playpause.clicked()
        }
    }

    function nextSong(){
        index++
        if(index >= files.length){
            // finish
            index = -1
            player.stop()
            return
        }

        let g1 = matches[2*index]
        let g2 = matches[2*index + 1]
        let song = files[index]
        player.setSource(song)
        popup.setPlayers(g1, g2)
        popup.show()
        player.play()
    }

    function previousSong(){
        index--
        if(index < 0){
            // finish
            index = -1
            player.stop()
            return
        }

        let g1 = matches[2*index]
        let g2 = matches[2*index + 1]
        let song = files[index]
        player.setSource(song)
        popup.setPlayers(g1, g2)
        popup.show()
        player.play()
    }

    function createMatches(){
        let N=100; // just to be sure
        let sh = Array.from(players); // copy players array (useless but whatever)
        for(let i=0; i<N; i++){
            shuffle(sh)
            while(matches[0] === sh[np - 1]){ // || matches[0] === sh[np - 2] || matches[1] === sh[np - 1] || matches[1] === sh[np - 2]){ // just check the adjacent ones, otherwise the pairs are always the same
                shuffle(sh)
            }
            matches = sh.concat(matches)
        }
    }

    function shuffle(array) {
      let currentIndex = array.length,  randomIndex;

      // While there remain elements to shuffle.
      while (currentIndex !== 0) {

        // Pick a remaining element.
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex--;

        // And swap it with the current element.
        [array[currentIndex], array[randomIndex]] = [
          array[randomIndex], array[currentIndex]];
      }

      return array;
    }

    function checkRandomicity(){ // testing only!
        let x={}
        for(let i=0; i<100; i=i+2){
            if(x[matches[i] + ", " + matches[i+1]]){
                x[matches[i] + ", " + matches[i+1]] = x[matches[i] + ", " + matches[i+1]] + 1
            } else {
                x[matches[i] + ", " + matches[i+1]] = 1
            }
        }

        console.warn(JSON.stringify(x))
    }

    FolderListModel {
        folder: "file:///home/tubbadu/Music/karaoke"
        nameFilters: [ "*.mp4", "*.mkv", "*.webm", "*.avi" ]
        showDirs: false
        onStatusChanged: {
            if(status == FolderListModel.Ready){
                for(let i=0; i<count; i++){
                    files.push(get(i, "fileUrl"))
                }
                shuffle(files)
                shuffle(files)
                shuffle(files)

                nextSong()
            }
        }
    }

    Rectangle{
        id: windowBackground
        color: "red"
        anchors.fill: parent
    }

    Item{
        id: karaokeView
        anchors.fill: parent
        visible: false

        Text {
            id: popup

            function setPlayers(g1, g2){
                text = "Now singing:<br><h1>" + g1 + " & " + g2 + "</h1><br>"
            }

            anchors.centerIn: parent
            width: parent.width * 0.9
            horizontalAlignment: Text.AlignHCenter
            text : "Now singing:<br><h1>tizio & caio</h1><br>"
            textFormat: Text.RichText
            visible: true
            z: 100
            style: Text.Outline
            styleColor: "black"
            color: "white"
            font.pixelSize: parent.width / 40
            Timer {
                id: timer
                interval: 3000
                repeat: false
                running: false
                onTriggered: {
                    popup.hide()
                }
            }

            function show(){
                opacityAnimator.stop()
                opacityAnimator.from = 0
                opacityAnimator.to = 1
                opacityAnimator.start()
                timer.start()
            }

            function hide(){
                opacityAnimator.stop()
                opacityAnimator.from = 1
                opacityAnimator.to = 0
                opacityAnimator.start()
            }

            OpacityAnimator {
                id: opacityAnimator
                target: popup;
                from: 0;
                to: 1;
                duration: 1000
                running: false
            }
        }

        Item{
            id: player
            anchors.fill: parent

            property var onTrackEnds: function(source) {
                console.warn(source, "just finished playing!")
                // play next one
                root.nextSong()
            }
            function play(){
                mediaPlayer.play()
            }
            function stop(){
                mediaPlayer.stop()
            }
            function pause(){
                mediaPlayer.pause()
            }
            function next(){
                //mediaPlayer.stop()
            }
            function restart(){
                //mediaPlayer.stop()
            }
            function setSource(s){
                mediaPlayer.source = s
            }

            property alias source: mediaPlayer.source
            property alias playbackState: mediaPlayer.playbackState

            MediaPlayer {
                id: mediaPlayer
                source: "file:///home/tubbadu/Music/karaoke/Linkin Park - In The End.webm"
                videoOutput: videoOutput
                audioOutput: AudioOutput {}

                onMediaStatusChanged: {
                    if(mediaStatus == MediaPlayer.EndOfMedia){
                        player.onTrackEnds(source)
                    } else if(mediaStatus == MediaPlayer.LoadedMedia) {
                        // just started a song
                        slider.to = mediaPlayer.duration
                    }
                }

                onPositionChanged: {
                    if(slider.to != mediaPlayer.duration) slider.to = mediaPlayer.duration
                    slider.value = mediaPlayer.position
                }
            }

            VideoOutput {
                id: videoOutput
                anchors.fill: parent
            }
        }

        Item {
            id: toolbaritem
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 35

            ToolBar{
                anchors.fill: parent
                visible: mousehandler.hovered

                RowLayout{
                    anchors.fill: parent
                    ToolButton {
                        id: playpause
                        icon.name: player.playbackState === MediaPlayer.PausedState? "media-playback-start" : "media-playback-pause"
                        onClicked: {
                            if(player.playbackState === MediaPlayer.PausedState) {
                                player.play()
                            } else if(player.playbackState === MediaPlayer.PlayingState){
                                player.pause()
                            }
                        }
                    }

                    ToolButton {
                        icon.name: "go-previous"
                        enabled: index > 0
                        onClicked: {
                            root.previousSong()
                        }
                    }
                    ToolButton {
                        icon.name: "go-next"
                        enabled: index < files.length - 1
                        onClicked: {
                            root.nextSong()
                        }
                    }

                    Slider {
                        id: slider
                        Layout.fillWidth: true
                        from: 0
                        to: 100

                        onMoved: {
                            mediaPlayer.position = value
                        }
                    }
                }
            }

            HoverHandler {
                id: mousehandler
                acceptedDevices: PointerDevice.AllDevices
                cursorShape: Qt.PointingHandCursor
                enabled: true
            }
        }
    }

    Item{
        id: setupView
        anchors.centerIn: parent
        height: parent.height * 0.9
        width: parent.width * 0.7
        visible: true

        ColumnLayout {
            anchors.fill: parent
            Label {
                text: "Karaoke files location:"
            }
            TextField {
                id: musicFolder
                Layout.fillWidth: true
                background: Rectangle{
                    color: "gray"
                    border.color: "white"
                    radius: 5
                }
                text: StandardPaths.standardLocations(StandardPaths.MusicLocation)[0]

                Dialogs.FolderDialog {
                    id: folderDialog
                    currentFolder: musicFolder.text
                    onAccepted: musicFolder.text = selectedFolder
                }

                ToolButton {
                    anchors.right: parent.right
                    height: parent.height
                    width: height
                    onClicked: {
                        folderDialog.open()
                    }
                    icon.name: "document-open-folder"
                }
            }
            Label {
                text: "Singers list:"
            }
            TextArea{
                Layout.fillWidth: true
                Layout.fillHeight: true
                background: Rectangle{
                    color: "gray"
                    border.color: "white"
                    radius: 5
                }
            }
            Button {
                text: "Start"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    Item {
        id: closeButtonItem
        height: 35
        width: 35
        anchors.top: parent.top
        anchors.right: parent.right

        Button {
            id: closeButton
            anchors.fill: parent
            icon.name: "window-close"
            visible: closeButtonMousehandler.hovered
            onClicked: {
                Qt.quit()
            }
        }
        HoverHandler {
            id: closeButtonMousehandler
            acceptedDevices: PointerDevice.AllDevices
            cursorShape: Qt.PointingHandCursor
            enabled: true
        }
    }

    Component.onCompleted: {
        createMatches()
        //checkRandomicity()
    }
}
