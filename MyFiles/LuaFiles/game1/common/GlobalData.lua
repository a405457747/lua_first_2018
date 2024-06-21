CARD_Point = {
    null = 1,
    n_2 = 2,
    n_3 = 3,
    n_4 = 4,
    n_5 = 5,
    n_6 = 6,
    n_7 = 7,
    n_8 = 8,
    n_9 = 9,
    n_10 = 10,
    n_j = 11,
    n_q = 12,
    n_k = 13,
    n_a = 14,
}

CARD_Award = {
    null = 1,
    high = 2,
    pair = 3,
    two_pair = 4,
    three = 5,
    straight = 6,
    flush = 7,
    fullHouse = 8,
    four = 9,
    straightFlush = 10,
}

CARD_Flower = {
    null = 1,
    spades = 2,
    hearts = 3,
    clubs = 4,
    diamonds = 5
}

GAME_State = {
    null = 0,--弃用
    game_start = 1,--弃用
    game_start_start = 2,--游戏初始化，
    game_over = 3,--游戏大结束
    game_ing_selectBlind = 4,--选择盲注时间
    game_win_shop = 5, --游戏结算和商店时间和操作空间
    game_bigWin = 6, --游戏大通
    game_ing_play=7,--玩家操控时间
    game_ing_calculate=8,--出牌后的计算
}

BLIND_type = {
    null = 0,
    small = 1,
    big = 2
}

GROUP_type = {
    null = 0,

}