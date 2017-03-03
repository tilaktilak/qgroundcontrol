/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/


import QtQuick                  2.7
import QtQuick.Controls         2.1
import QtQuick.Controls.Styles  1.2
import QtQuick.Dialogs          1.2
import QtQuick.Layouts          1.1

import QGroundControl.FactSystem    1.0
import QGroundControl.FactControls  1.0
import QGroundControl.Palette       1.0
import QGroundControl.Controls      1.0
import QGroundControl.Controllers   1.0
import QGroundControl.ScreenTools   1.0

/// PX4 Flight Mode configuration. This control will load either the Simple or Advanced Flight Mode config
/// based on current parameter settings.
SetupPage {
    id:             flightModesPage
    pageComponent:  pageComponent

    Component {
        id: pageComponent

        Loader {
            width:  availableWidth
            height: availableHeight
            source: _simpleMode ? "qrc:/qml/PX4SimpleFlightModes.qml" : "qrc:/qml/PX4AdvancedFlightModes.qml"

            property Fact _nullFact
            property bool _rcMapFltmodeExists:  controller.parameterExists(-1, "RC_MAP_FLTMODE")
            property Fact _rcMapFltmode:        _rcMapFltmodeExists ? controller.getParameterFact(-1, "RC_MAP_FLTMODE") : _nullFact
            property Fact _rcMapModeSw:         controller.getParameterFact(-1, "RC_MAP_MODE_SW")
            property bool _simpleMode:          _rcMapFltmodeExists ? _rcMapFltmode.value > 0 || _rcMapModeSw.value == 0 : false

            FactPanelController {
                id:         controller
                factPanel:  flightModesPage.viewPanel
            }

            property var qgcView:       flightModesPage
            property var qgcViewPanel:  flightModesPage.viewPanel
        }
    }
}
