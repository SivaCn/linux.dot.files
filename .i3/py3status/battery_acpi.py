# -*- coding: utf-8 -*-
"""
Display the currently logged in user.

Inspired by i3 FAQ:
    https://faq.i3wm.org/question/1618/add-user-name-to-status-bar/
"""

from time import time
from subprocess import Popen, PIPE


class Py3status:
    """
    """
    # available configuration parameters
    cache_timeout = 1800

    def battery_acpi(self, i3s_output_list, i3s_config):
        """
        We use the getpass module to get the current user.
        """
        out = Popen('acpi', stdout=PIPE, stderr=PIPE)

        output = str(out.communicate()[0]).strip('\n').\
                replace('Discharging', '--').\
                replace('Charging', '++').\
                replace(',', '')

        output = ' '.join(output.split(' ')[2:4])

        response = {
                'full_text': 'BAT: ' + output
        }
        return response

if __name__ == "__main__":
    """
    Test this module by calling it directly.
    """
    from time import sleep
    x = Py3status()
    config = {
        'color_good': '#00FF00',
        'color_bad': '#FF0000',
    }
    while True:
        print(x.battery_acpi([], config))
        sleep(1)
