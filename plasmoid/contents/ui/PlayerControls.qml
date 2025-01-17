/***************************************************************************
 *   Copyright 2013 Sebastian Kügler <sebas@kde.org>                       *
 *   Copyright 2014, 2016 Kai Uwe Broulik <kde@privat.broulik.de>          *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU Library General Public License as       *
 *   published by the Free Software Foundation; either version 2 of the    *
 *   License, or (at your option) any later version.                       *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU Library General Public License for more details.                  *
 *                                                                         *
 *   You should have received a copy of the GNU Library General Public     *
 *   License along with this program; if not, write to the                 *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

import QtQuick 2.4
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3


RowLayout {
    id: playerControls

    property bool enabled: root.canControl
    property bool compactView: false
    property bool canFitPrevNext: true

    property int controlSize: PlasmaCore.Units.iconSizes.huge
    readonly property int controlSmallerSize: Math.min(controlSize,
                                                       Math.max(Math.round(controlSize / 1.25), PlasmaCore.Units.iconSizes.medium))
    readonly property int controlsCount : 1 + (prevButton.visible ? 1 : 0) +  (nextButton.visible ? 1 : 0)

    spacing: compactView ?  0 : PlasmaCore.Units.largeSpacing

    PlasmaComponents3.ToolButton {
        id: prevButton
        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        implicitWidth: controlSmallerSize
        implicitHeight: implicitWidth
        enabled: playerControls.enabled && root.canGoPrevious
        visible: canFitPrevNext && (!compactView
                    || plasmoid.configuration.showPrevNextControls === Qt.Checked
                    || (plasmoid.configuration.showPrevNextControls === Qt.PartiallyChecked && enabled))

        icon.name: LayoutMirroring.enabled ? "media-skip-forward" : "media-skip-backward"
        onClicked: {
            //root.position = 0    // Let the media start from beginning. Bug 362473
            root.action_previous()
        }
    }

    PlasmaComponents3.ToolButton {
        Layout.alignment: Qt.AlignCenter
        implicitWidth: controlSize
        implicitHeight: implicitWidth
        enabled: root.state == "playing" ? root.canPause : root.canPlay
        icon.name: root.state == "playing" ? "media-playback-pause" : "media-playback-start"
        onClicked: root.togglePlaying()
        visible: canFitPrevNext
    }

    PlasmaComponents3.ToolButton {
        id: nextButton
        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        implicitWidth: controlSmallerSize
        implicitHeight: implicitWidth
        enabled: playerControls.enabled && root.canGoNext
        visible: canFitPrevNext && (!compactView
                    || plasmoid.configuration.showPrevNextControls === Qt.Checked
                    || (plasmoid.configuration.showPrevNextControls === Qt.PartiallyChecked && enabled))

        icon.name: LayoutMirroring.enabled ? "media-skip-backward" : "media-skip-forward"
        onClicked: {
            //root.position = 0    // Let the media start from beginning. Bug 362473
            root.action_next()
        }
    }
}
