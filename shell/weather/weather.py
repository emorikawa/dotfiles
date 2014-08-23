#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

# weather.py
# License: Public Domain
#
# Gets the weather and returns a string
# Why? Because I want a cute weather indicator in my prompt
# Requires: python-argparse, Wunderground API Key
# API Key can be obtained for free here: http://www.wunderground.com/weather/api/

import weatherdict
import argparse
import urllib2
import json
import sys
import os

API_KEY = os.environ.get('WUNDERGROUND_APIKEY', None)

if API_KEY is None:
    sys.stderr.write('APIKEY not set in environment!')
    sys.exit(-1)


def main():
    parser = argparse.ArgumentParser(description='Get the weather and return a string')
    parser.add_argument('-f', action="store_true", dest='fahrenheit', default=False,
                        help='Temp in Fahrenheit (default: False)')
    parser.add_argument('-z', action="store", dest="zipcode", default='10006',
                        help='your zipcode or your city name (default: NY)')
    parser.add_argument('-w', action="store_true", dest='show_wind', default=False,
                        help='Show wind speed')
    parser.add_argument('-H', action="store_true", dest='show_humidity', default=False,
                        help='Show relative humidity')
    parser.add_argument('-c', action="store_true", dest='show_city', default=False,
                        help='Show city name before weather data')
    parser.add_argument('-t', action="store_true", dest='show_text', default=False,
                        help='Show condition description')
    parser.add_argument('-a', action="store_true", dest='show_alerts', default=False,
                        help='Show severe weather alerts')

    args = parser.parse_args()

    BASEURL = "http://api.wunderground.com/api/%s/" % (API_KEY)
    WURL = BASEURL + 'conditions/q/'
    alertsurl = BASEURL + 'alerts/q/'
    geourl = BASEURL + "geolookup/q/%s.json" % (args.zipcode)

    try:
        f = urllib2.urlopen(geourl)
    #except urllib2.HTTPError, urllib2.URLError:
    except urllib2.URLError,  err:
        print("")
        sys.exit(-1)

    j = json.loads(str(f.read()))
    state = str(j['location']['state'])
    city = str(j['location']['city']).replace(' ', '_')

    WURL += state + '/' + city + '.json'

    try:
        f = urllib2.urlopen(WURL)
    except urllib2.HTTPError, urllib2.URLError:
        print("")
        sys.exit(-1)

    j = json.loads(urllib2.urlopen(WURL).read())

    # prepare output
    weather = ""

    if args.show_city:
        weather += str(j['current_observation']['display_location']['city']) + " "

    if args.show_text:
        weather += str(j['current_observation']['weather']) + " "

    if args.fahrenheit:
        weather += str(j['current_observation']['temp_f']) + '°F '
    else:
        weather += str(j['current_observation']['temp_c']) + '°C '

    if args.show_wind:
        weather += str(j['current_observation']['wind_dir']) + " " + str(j['current_observation']['wind_mph']) + " MPH "

    if args.show_humidity:
        weather += str(j['current_observation']['relative_humidity']) + ' ϕ '

    # and now the end
    if args.show_alerts:
        alertsurl += state + '/' + city + '.json'
        try:
            f = urllib2.urlopen(alertsurl)
        except urllib2.HTTPError, urllib2.URLError:
            print("")
            sys.exit(-1)

        alerts = json.loads(urllib2.urlopen(alertsurl).read())

        if alerts['alerts'] and str(alerts['alerts'][0]['description']) != "Special Statement":
            print weatherdict.wconditions[j['current_observation']['weather']] + '  ' + weather + "⚠ " + str(alerts['alerts'][0]['description']) + " ⚠ "
        else:
            print weatherdict.wconditions[j['current_observation']['weather']] + '  ' + weather
    else:
        print weatherdict.wconditions[j['current_observation']['weather']] + '  ' + weather

    return(0)

if __name__ == '__main__':
    main()
