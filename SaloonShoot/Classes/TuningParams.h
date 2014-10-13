//
//  TuningParams.h
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 21/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#ifndef SaloonShoot_TuningParams_h
#define SaloonShoot_TuningParams_h

#define SOUNDON_KEY @"SoundOn"
#define CURRENT_SCORE @"CurrentScore"
#define HIGH_SCORE  @"HighScore"
#define MAX_LIFE_COUNT  @"MaxLifeCount"


#define MAX_CREATE_GUNMAN_COUNT 5   //Five
#define GUNMAN_IMG_COUNT 4
#define WINDOW_MAX  4
#define DIE_ANIM_FRAME_COUNT  5
#define SHOOT_ANIM_FRAME_COUNT  3

#define Y_DOWN_DUE_TO_AD_BANNER 10

//NAMES
#define NAME_SALOON_GAME @"saloon_game"
#define NAME_GUN_LAYER @"gun_layer"
#define NAME_RESUME_BUTTON @"resume_button"

//Z-Orders
#define ZO_SALOON_GAME  0
#define ZO_GUN_LAYER    1
#define ZO_SCORE_LAYER  7
#define ZO_PAUSE_BUTTON 10
#define ZO_RESUME_SLIDER_SPRITE 25
#define ZO_PAUSED_LAYER 20

//Intervals
// NOTE: edit the intervals marked "harder" to make the game easier or harder.
#define INTVL_CREATE_NEW_GUNMAN     0.5f
#define INTVL_NEW_GUNMAN_CREATION_DELTA 3.1f  //harder
#define INTVL_SLIDE_DURATION    0.15f
#define INTVL_INITIAL_HIDE_DUR_SHORT   1.0f
#define INTVL_INITIAL_HIDE_DUR_LONG    5.0f
#define INTVL_VISIBLE_DURATION_SHORT   0.42f  //harder
#define INTVL_VISIBLE_DURATION_LONG    1.0f
#define INTVL_MAX_HIDE_DURATION     1.5f
#define INTVL_HIDE_DUR_SHORT_ADDITIVE   0.7f
#define INTVL_HIDE_DUR_LONG_ADDITIVE    2.0f  //harder
#define INTVL_DIE_ANIM_FRAME_DELAY      0.11f
#define INTVL_SHOOT_ANIM_FRAME_DELAY      0.05f


//Multipliers

//Ad IDs
// NOTE: Update you admob id's here.
#define ADMOB_PUBLISHER_ID_IOS      @"<YOUR-ADMOB-IOS-PUBLISHER-ID>"

#define ADMOB_MEDIATION_ID @"<YOUR-ADMOB-MEDIATION-ID>"


#endif
