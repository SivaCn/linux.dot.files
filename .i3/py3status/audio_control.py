# -*- coding: utf-8 -*-
"""
Control System Volume.

"""

from syslog import syslog, LOG_INFO
from time import time, sleep
import subprocess as sub

try:
    import dbus
    dbus_available = True
except:
    dbus_available = False


def log(msg):
    syslog(LOG_INFO, "audio_control: %s" % msg[:100])


class Py3status:
    """
    """
    def on_click(self, i3s_output_list, i3s_config, event):

        """Runs an instance of `gnome-alsamixer`, if not already running,
        kills an existing instance else.
        """

        _tool = 'gnome-alsamixer'

        try:
            _pid = int(sub.Popen(
                ['pidof', _tool],
                stdout=sub.PIPE
            ).communicate()[0])

            sub.Popen(['kill', '{}'.format(_pid)], stdout=sub.PIPE)

        except:
            sub.Popen([_tool], stdout=sub.PIPE)


    def on_load(self, i3s_output_list, i3s_config):
        response = {
            'color': '#00FF00',
            'full_text': 'SOUND'
        }
        return response


if __name__ == "__main__":
    x = Py3status()
    config = {
        'color_good': '#00FF00',
        'color_bad': '#FF0000',
    }
    while True:
        print(x.on_load([], config))
        sleep(1)
