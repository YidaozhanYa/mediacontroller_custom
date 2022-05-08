# 媒体播放器·改
KDE Plasma 媒体播放器小组件的三改版本。

它提供了与传统 mediacontroller 部件相同的功能，让你控制系统中的每一个媒体播放器（通过MPRIS2协议），但它适应更多因素的形式和尺寸，让你即使在面板上也能拥有一个漂亮的媒体控制。

三改内容：

- 汉化
- 在不播放媒体时，不显示文字

![mediacontroller+ gallery](screenshot.png)

* Full Representation (_desktop_, _pop-up_):
    - Vertical View (same as in classic mediacontroller)
    - Horizontal View: when the widget gets wider, the album art goes to the left
    - Icon tab bar to select the player in a nicer and quicker way

* Compact Representation (_panel_, _systray_):
    - Different Views:
        - Compact View for panels. It keeps most of the functionallity in a smaller size: icon/album art, track/artist, player controls and progress bar which uses the same style as the taskbar progress jobs.
        - Minimal View for thinner panels, hiding the album art and progress bar
        - Icon View for smaller sizes (same as in classic mediacontroller)
    - Minimum (preferred) / Maximum widths configurable
    - Display options to show/hide progressbar
    
    - Drag and drop any media file or URL to open it
        - on the selected player (the player has to support this option)
        - on default application if no player selected

As a disclaimer, it is one of my first tries on qml and plasmoids, and I just wanted to have a nicer media player applet for my panel, while keeping the most of the classic widget untouched. Of course, my main wish would be for this changes to be integrated in the official mediacontroller applet, which I find kind of visually simple in its current state.
