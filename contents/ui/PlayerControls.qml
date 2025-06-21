import QtQuick
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components 3.0 as PC3
import org.kde.plasma.private.mpris as Mpris
import org.kde.kirigami as Kirigami

RowLayout {
    id: playerControls

    property bool enabled: root.canControl
    property bool compactView: true
    property bool canFitPrevNext: true

    property int controlSize: parent.height + 2
    readonly property int controlSmallerSize: Math.min(controlSize,
                                                       Math.max(Math.round(controlSize / 1.25), Kirigami.Units.iconSizes.small))
    readonly property int controlsCount : 1 + (prevButton.visible ? 1 : 0) +  (nextButton.visible ? 1 : 0)

    spacing: compactView ?  0 : Kirigami.Units.smallSpacing

    Layout.minimumHeight: Layout.minimumHeight


    PC3.ToolButton {
        id: expandButton
        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        implicitWidth: controlSmallerSize
        implicitHeight: implicitWidth
        enabled: Mpris.PlaybackStatus.Playing ? root.canPause : root.canPlay

        icon.name: "overflow-menu-symbolic"
        onClicked: {
            root.expanded = !root.expanded
        }
        Layout.minimumHeight: Layout.minimumHeight
    }

    PC3.ToolButton {
        id: prevButton
        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        implicitWidth: controlSmallerSize
        implicitHeight: implicitWidth
        visible: root.canGoPrevious
        enabled: playerControls.enabled && root.canGoPrevious

        icon.name: LayoutMirroring.enabled ? "media-skip-forward-symbolic" : "media-skip-backward-symbolic"
        onClicked: {
            //root.position = 0    // Let the media start from beginning. Bug 362473
            root.previous()
        }
        Layout.minimumHeight: Layout.minimumHeight
    }

    PC3.ToolButton {
        Layout.alignment: Qt.AlignCenter
        implicitWidth: controlSmallerSize
        implicitHeight: implicitWidth
        enabled: Mpris.PlaybackStatus.Playing ? root.canPause : root.canPlay
        icon.name: root.isPlaying ? "media-playback-pause-symbolic" : "media-playback-start-symbolic"
        onClicked: root.togglePlaying()
        Layout.minimumHeight: Layout.minimumHeight
    }

    PC3.ToolButton {
        id: nextButton
        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        implicitWidth: controlSmallerSize
        implicitHeight: implicitWidth
        visible: root.canGoNext
        enabled: playerControls.enabled && root.canGoNext

        icon.name: LayoutMirroring.enabled ? "media-skip-backward-symbolic" : "media-skip-forward-symbolic"
        onClicked: {
            //root.position = 0    // Let the media start from beginning. Bug 362473
            root.next()
        }
        Layout.minimumHeight: Layout.minimumHeight
    }
}
