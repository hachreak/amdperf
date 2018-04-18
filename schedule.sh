#!/bin/sh

set_profile(){
  DO_PROFILE=$1
  case $2 in
    low)
      $DO_PROFILE 2 80
      ;;
    full)
      $DO_PROFILE 5 100
      ;;
    night)
      $DO_PROFILE 2 65
      ;;
    *)
      echo "No profile found with $2"
      ;;
  esac
}

do_profile(){
  ./set_clock.sh $1
  ./set_fun.sh $2
}

echo_profile(){
  echo "Clock $1 / Fun $2"
}

controller(){
  Hour=$1
  DayOfWeek=$2
  DO_PROFILE=$3

  if [ $DayOfWeek = "Sat" ] || [ $DayOfWeek = "San" ]; then
    IS_F1=y
  fi

  # night mode
  if [ $Hour -le 2 ] || [ $Hour -gt 23 ]; then
    echo "Night mode"
    set_profile $DO_PROFILE night
  fi

  # full power evening
  if [ "$IS_F1" = "y" ]; then
    echo "Full power weekend"
    set_profile $DO_PROFILE full
  else
    if [ $Hour -ge 20 ] && [ $Hour -le 23 ]; then
      echo "Full power evening"
      set_profile $DO_PROFILE full
    fi
    if [ $Hour -ge 3 ] && [ $Hour -lt 8 ]; then
      echo "Full power evening"
      set_profile $DO_PROFILE full
    fi

    # low speed
    if [ $Hour -ge 8 ] && [ $Hour -le 19 ]; then
      echo "Low power day"
      set_profile $DO_PROFILE low
    fi
  fi

}

check_calendar(){
  DayOfWeek=`date +%a`
  DayOfWeek="Sat"
  for Hour in `seq 0 24`; do
    echo "[[ hour $Hour  ]]"
    controller $Hour $DayOfWeek echo_profile
    echo ""
  done
}

check_temp(){
  TEMP=`./get_temp.sh`
  echo "Temperature $TEMP"
  if [ `./get_temp.sh` -ge 85 ]; then
    echo "Reset fun speed"
    ./set_fun.sh auto
  fi
}

schedule_settings(){
  SLEEP_TIME=1800
  INDEX=1
  while true; do
    # Apply profile
    if [ $INDEX -le 1 ]; then
      Hour=`get_date`
      controller $Hour echo_profile
      Hour=`get_date`
      controller $Hour do_profile
    fi

    # Check temp every seconds
    check_temp
    echo ""

    # loop
    sleep 1
    if [ $INDEX -gt $SLEEP_TIME ]; then
      INDEX=1
    else
      INDEX=`expr $INDEX + 1`
    fi
  done
}

get_date(){
  date +"%H %a"
}

###### Menu

# check which profile would activated now
if [ "$1" = "check" ]; then
  Hour=`get_date`
  controller $Hour echo_profile
  exit 0
fi

# show calendar
if [ "$1" = "calendar" ]; then
  check_calendar
  exit 0
fi

# schedule profile
if [ "$1" = "schedule" ]; then
  schedule_settings
  exit 0
fi

# set a profile
if [ "$1" = "profile" ]; then
  set_profile echo_profile $2
  set_profile do_profile $2
  exit 0
fi

# help
echo "Usage: $0 [check|calendar|schedule]"
echo "       $0 profile [low|night|full]"
echo ""
echo " check   : check which profile would activated now"
echo " calendar: show profile calendar"
echo " schedule: schedule profile"
echo " profile : set a specific profile (low|night|full)"
