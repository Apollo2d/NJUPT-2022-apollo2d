// -*-c++-*-

/*
 *Copyright:

 Copyright (C) Hidehisa AKIYAMA

 This code is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 3, or (at your option)
 any later version.

 This code is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this code; see the file COPYING.  If not, write to
 the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

 *EndCopyright:
 */

/////////////////////////////////////////////////////////////////////

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <rcsc/action/basic_actions.h>
#include <rcsc/action/body_go_to_point.h>
#include <rcsc/action/neck_scan_field.h>
#include <rcsc/action/neck_turn_to_ball_or_scan.h>
#include <rcsc/common/logger.h>
#include <rcsc/common/server_param.h>
#include <rcsc/player/player_agent.h>

#include "bhv_go_to_moving_ball.h"
#include "bhv_set_play.h"

using namespace rcsc;

#define ORIGIN

/*-------------------------------------------------------------------*/
/*!

*/
bool Bhv_GoToMovingBall::execute(PlayerAgent* agent) {
#ifdef ORIGIN
  const WorldModel& wm = agent->world();
  if (wm.ball().posValid()) {
    agent->doDash(ServerParam::i().maxDashPower(), wm.ball().angleFromSelf());
    agent->setNeckAction(new Neck_TurnToBallOrScan(0));
  } else {
    agent->setNeckAction(new Neck_ScanField());
  }
  return true;
#else
  //
  // 在这里添加你的代码
  //

#endif
}
