/**
    Copyright 2016 Bill Binder <dxtwjb@gmail.com>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.5 as QQC2
import org.kde.plasma.core 2.0 as PlasmaCore

import org.kde.kirigami 2.14 as Kirigami


Item {
    id: compactViewConfig

    property alias cfg_minimumWidthUnits: widthSlider.proxyFirstValue
    property alias cfg_maximumWidthUnits: widthSlider.proxySecondValue
    property alias cfg_showProgressBar: showProgressBar.checked
    property alias cfg_showAlbumArt: showAlbumArt.checked
    property alias cfg_showTrackInfo: showTrackInfo.checked
    property alias cfg_showPlaybackControls: showPlaybackControls.checked
    property int cfg_showPrevNextControls

    Kirigami.FormLayout {

        QQC2.CheckBox {
            id: showAlbumArt
            Kirigami.FormData.label: i18n("在面板视图中显示:")
            text: i18n("专辑封面")
        }

        QQC2.CheckBox {
            id: showTrackInfo
            text: i18n("媒体信息")
        }

        QQC2.CheckBox {
            id: showPlaybackControls
            text: i18n("播放控件")
        }

        QQC2.CheckBox {
            id: showProgressBar
            enabled: showAlbumArt.checked || showTrackInfo.checked || showPlaybackControls.checked
            text: i18n("进度条")
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
        }

        RowLayout {
            Kirigami.FormData.label: i18n("宽度:  ")

            enabled: cfg_showTrackInfo && plasmoid.formFactor === PlasmaCore.Types.Horizontal
            spacing: PlasmaCore.Units.smallSpacing

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            Layout.bottomMargin: PlasmaCore.Units.largeSpacing

            QQC2.Label {
                id: lbl_minWidth
                text: Math.round(widthSlider.proxyFirstValue * PlasmaCore.Units.gridUnit) + "像素"
                Layout.preferredWidth: 50
                horizontalAlignment: Text.AlignRight
            }

            QQC2.RangeSlider {
                id: widthSlider
                Layout.fillWidth: true
                from: 1
                to: 101
                stepSize: 1
                snapMode: QQC2.RangeSlider.SnapAlways
                first.value: 18
                second.value: to

                //On QT 2.5 `RangeSlider` values are not allowed as an alias
                property int proxySecondValue: 0
                property int proxyFirstValue: 1

                first.onValueChanged: proxyFirstValue = first.value
                second.onValueChanged: proxySecondValue = (second.position == 1.0) ? 0 : second.value
                onProxyFirstValueChanged: first.value = proxyFirstValue
                onProxySecondValueChanged: second.value = proxySecondValue ? proxySecondValue : to
            }

            QQC2.Label {
                id: lbl_maximumWidth
                text: (widthSlider.second.position == 1.0) ? i18n("无限")
                                                           : Math.round(widthSlider.proxySecondValue * PlasmaCore.Units.gridUnit) + "像素"
                Layout.preferredWidth: 50
                horizontalAlignment: Text.AlignLeft
            }
        }

        Kirigami.Separator {}

        QQC2.RadioButton {
            id: showPrevNextAlways
            Kirigami.FormData.label: i18n("显示上一曲/下一曲按钮:")
            text: i18n("一直显示")
            enabled: cfg_showPlaybackControls
            checked: cfg_showPrevNextControls === Qt.Checked
        }
        QQC2.RadioButton {
            id: showPrevNextNever
            text: i18n("不显示")
            enabled: cfg_showPlaybackControls
            checked: cfg_showPrevNextControls === Qt.Unchecked
        }
        QQC2.RadioButton {
            id: showPrevNextWhenEnabled
            text: i18n("只在可用时显示")
            enabled: cfg_showPlaybackControls
            checked: cfg_showPrevNextControls === Qt.PartiallyChecked
        }
    }

    QQC2.ButtonGroup {
        id: showPrevNextGroup
        buttons: [showPrevNextAlways, showPrevNextNever, showPrevNextWhenEnabled]

        readonly property int value: {
            switch (checkedButton) {
                case showPrevNextAlways: return Qt.Checked;
                case showPrevNextNever: return Qt.Unchecked;
                case showPrevNextWhenEnabled: return Qt.PartiallyChecked;
            }
        }

        onClicked: { cfg_showPrevNextControls = value }
    }
}
