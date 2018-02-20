/*
 * Copyright (C) 2014 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import Ubuntu.Components 1.3
import QtGraphicalEffects 1.0

FastBlur {
    id: overlayBlurEffect
    property var overlayItem
    property var backgroundItem
    property alias live: overlayBlurShader.live
    property var offset: Qt.point(0,0)

    anchors.fill: overlayItem

    Behavior on opacity {UbuntuNumberAnimation {} }
    Behavior on radius {UbuntuNumberAnimation {} }

    Connections {
        target:overlayItem
        onXChanged: overlayBlurShader.updateRect();
        onYChanged: overlayBlurShader.updateRect();
        onWidthChanged: overlayBlurShader.updateRect();
        onHeightChanged: overlayBlurShader.updateRect();
        onScaleChanged: overlayBlurShader.updateRect();
    }

    Connections {
        target:backgroundItem
        onXChanged: overlayBlurShader.updateRect();
        onYChanged: overlayBlurShader.updateRect();
        onWidthChanged: overlayBlurShader.updateRect();
        onHeightChanged: overlayBlurShader.updateRect();
        onScaleChanged: overlayBlurShader.updateRect();
    }

    onOffsetChanged: overlayBlurShader.updateRect();

    radius: units.gu(2)
    source:  ShaderEffectSource {
        id:overlayBlurShader
        clip: true
        sourceItem: backgroundItem
        sourceRect: Qt.rect( overlayItem.mapToItem(backgroundItem).x + offset.x,
                             overlayItem.mapToItem(backgroundItem).y+ offset.y,
                             overlayItem.width,
                             overlayItem.height )
        recursive: true

        function updateRect() {
            sourceRect =  Qt.rect( overlayItem.mapToItem(backgroundItem).x + offset.x,
                                  overlayItem.mapToItem(backgroundItem).y+ offset.y,
                                  overlayItem.width,
                                  overlayItem.height );
        }
    }
}
