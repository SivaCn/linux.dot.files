# -*- coding: utf-8 -*-
"""
Display the currently logged in user.

Inspired by i3 FAQ:
    https://faq.i3wm.org/question/1618/add-user-name-to-status-bar/
"""

from time import time
from subprocess import Popen, PIPE, check_output


class Py3status:
    """
    """
    # available configuration parameters
    cache_timeout = 1800

    def uptime(self, i3s_output_list, i3s_config):
        """
        We use the getpass module to get the current user.
        """

        out = Popen(['uptime', '-p'], stdout=PIPE, stderr=PIPE)

        out = check_output(['uptime', '-p'])

        # response = {
        #     'full_text': 'UPTIME: ' + ''.join(str(out.communicate()[0]).split(',')[0].split(' ')[3:])
        # }
        response = {
            'full_text': out[:-1]
        }
        return response

if __name__ == "__main__":
    """
    Test this module by calling it directly.
    """
    from time import sleep
    x = Py3status()
    config = {
        'color_good': '#000000',
        'color_bad': '#FFFFFF',
    }
    while True:
        print(x.uptime([], config))
        sleep(1)
