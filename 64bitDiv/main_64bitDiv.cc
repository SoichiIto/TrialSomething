#include <stdio.h>

/*プロトタイプ宣言*/
unsigned long g64Div32(unsigned long hi_word,unsigned long lo_word,unsigned long div_word,long lng_shft);

/*メイン関数*/
int main(void)
{

    unsigned long lng_high_word;
    unsigned long lng_low_word;
    unsigned long lng_div_word;
    unsigned long lng_shft;
    unsigned long lng_ret;

    lng_high_word = (unsigned long)0x12345678;
    lng_low_word  = (unsigned long)0xFEDCBA98;
    lng_div_word  = (unsigned long)33;
    lng_shft  = (long)3;

/*
    lng_high_word = (long)0x00000001;
    lng_low_word  = (long)4;
    lng_div_word  = (long)10;
    lng_shft  = (long)0;
*/
    printf("HI:%lx \nLO:%lx \nDIV:%lx \nshft:%ld \n",
                                    (unsigned long)lng_high_word,
                                    (unsigned long)lng_low_word,
                                    (unsigned long)lng_div_word,
                                    (unsigned long)lng_shft
                                    ) ;

    lng_ret = g64Div32(lng_high_word,lng_low_word,lng_div_word,lng_shft);
    printf("HI:%lx \nLO:%lx \nDIV:%lx \nshft:%ld \nRet:%08lx \n",
                                    (unsigned long)lng_high_word,
                                    (unsigned long)lng_low_word,
                                    (unsigned long)lng_div_word,
                                    (unsigned long)lng_shft,
                                    (unsigned long)lng_ret
                                    ) ;
                                    
    return 0;
}


/*割り算関数*/
unsigned long g64Div32(unsigned long hi_word,unsigned long lo_word,unsigned long div_word,long lng_shft)
{
    unsigned long ret;
    unsigned long ret_hi;
    unsigned long ret_lo;
    unsigned long lng_dividend;

    ret = 0;
    ret_hi = 0;
    ret_lo = 0;
    lng_dividend = 0;

    if( div_word  == 0) {
        printf("err:0 Div \n");
        ret = 0;
    }else{
        if ( hi_word == 0){
            ret_lo = lo_word / div_word;
            ret_lo = ret_lo >> lng_shft;
        }else{
            /*上位バイトの割り算*/
            ret_lo = hi_word / div_word; 

            /* あまりを被除数とする*/
            lng_dividend = hi_word - ret_lo * div_word;

            /*下位バイトを左シフトし商を求める*/
            for( int i = 0; i < 32; i++ ){
                /* 商を左シフト*/
                if( ret_lo & 0x80000000 ) {
                    ret_hi = ret_hi * 2;
                    ret_lo = ret_lo - (unsigned long) 0x80000000 ;  /* 最上位ビットを消す*/
                    ret_lo = ret_lo * 2;
                    ret_hi++;
                } else {
                    ret_hi = ret_hi * 2;
                    ret_lo = ret_lo * 2;
                }

                /* 非除数を左シフト*/
                /* 下位バイトに最上位ビットの確認 */
                if ( lo_word & 0x80000000 ) {
                    /*下位の最上バイトが1の場合*/
                    lng_dividend = lng_dividend * 2;
                    lng_dividend ++;
                    lo_word = lo_word - (unsigned long) 0x80000000 ;  /* 最上位ビットを消す*/
                    lo_word = lo_word * 2;
                } else {
                    /*下位の最上バイトが0の場合*/
                    lng_dividend = lng_dividend * 2;
                    lo_word = lo_word * 2;
                }

                /* 被除数と除数を比較*/
                if(lng_dividend >=  div_word) {
                    ret_lo++;
                    lng_dividend = lng_dividend - div_word;
                }
            }

            /*右シフト*/
            for( int i = 0; i < lng_shft; i++ ) {
                /*下位バイトを右シフト*/
                ret_lo = ret_lo / 2;

                /*上位バイトから繰り下がり*/
                if( ret_hi & 0x00000001 ) {
                    ret_lo = ret_lo + (unsigned long)0x80000000;
                }
                /*上位バイト右シフト*/
                ret_hi = ret_hi / 2;

            }
        }
        ret = ret_lo;
    }
    return ret;   
}