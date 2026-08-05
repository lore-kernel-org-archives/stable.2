Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955813F44C8
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921904; cv=pass; b=HZWfqRh0aidvltze6nrASYT0vLc6Mj0RqZcLexZ+rDRVHO3+bBlgVkASB67qFFq9UfOdG6ForR6S0vIehKmZURH2uV6r6+itIBckH70/pO1PKVlkf3AYpWFW/TRLpOMKVGnAo/ZIiuXSzleQQMM45U3GFOJ5+FnBCXI2JNcl418=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921904; c=relaxed/simple;
	bh=38yw2IuilRVNZtpl6Z+YoXoRkOra/Wr6H0SJ66XXeNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Egy+Mc/kW1jJMEiecsZy6NQULkdf3OJ3Ydt4hARHLS0MK3Gjal6jVtYP/I7/DG+JEVpyGqLurP/1Kgmm6jGAr3E+a7wr/nPo0LqvafGVfwSISuX1fiOmjqaaWCtLyEryLOGX4w9rDw8FtS5+AzubvlVp9tHAs9k2SD2dGBCjP68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6PSshpO; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6PSshpO"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a18180so1103296a12.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 02:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785921901; cv=none;
        d=google.com; s=arc-20260327;
        b=nmcsjpbZb6ej8Vt1t1M6/cIop0pM2q3QAtjnoKHMYqEr9k0HpFz2Ey/y8h0ZPXlJ/m
         3qk0LFnTXD5OjluTOzO/AwveWC5pV/f98mvmwESadNGucyqdo/CCXdmyFeLEwFMvbhns
         r2XYgV3fMQp/lXaXyT4bVKc2QQ4tqSgQjCoJjAGK/uMs86bQ+LEyy4IgXzsJhZWBy4db
         U0hhO4e/2nVzTSuKPRUa3+kwRDz99eymRZEHGWn0dmk/hrTHhRrjivZmki+Fs43nzOIw
         04f1dQhw2I6tAXwuJ+Z+cEcHbE9JaWCQJzue0ko/2TRaCqLyQs1LKD/X84wimNywSLuj
         gMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qSPlmzZwsggqkOekQQNlyHJCqbwcPOcbrrGQp2BzoG0=;
        fh=Upib7eMUl0MYrUA3+F8c1ODUqbnT2FYuIxrobqHLUHk=;
        b=GjjSc7B/mP0kv389dR1m7TrZrlEqNzb1/4ZLC6nusNTgW98SQaujiFB6Y2wpZYbO0a
         2oGHnDGNl4k76zy76QTL2KfuW64Yp7qy0qy9Zr7DdEBhaOGNO9eaVyi7ILLVD7tkyVKx
         aboI93w1QSKI3VBlarkS4U/shNyHVLOmemhWUbmPfxekA/3AVSCTaPeFjxgElKEnugHB
         rPT57wRxpzweUa9JX9VWH+j4XiPQFLdsADfPkgLMIixjc9tvCoK3CFbs8N/nOOME15KH
         RwtGJP5Yldmj7b32eDLsN1q7EnlpPwyXqpnRfNXWK5ZGEih70Uj6kcSU4YIV63LGSvPg
         z/KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785921901; x=1786526701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qSPlmzZwsggqkOekQQNlyHJCqbwcPOcbrrGQp2BzoG0=;
        b=k6PSshpOd5b5sfezOCUNz5XAVo5zMPt61TK28K5lVsuLDIlO6pjx9QBF8VvC02E91G
         A3ORdk7Lr3v4mkFjSZgMLa7hPFf0LvDP/4nhWV0PbwVgHpnfbd5reTPutT4Pl83yycmt
         lXf+Bv1pWPpoYjc8O1RuVunxqKHYBLXzpA2WsuXFpHG9/b1LkifRBaK46ef4Y/MAs1ky
         GSHWL1DNjIgscHbuRMc0dfFx8E1Q9jmoJn+N7ByjcXaxc4Ldq0ZKp9hICKjuwS21XlNm
         oa/uxpQdo6WWGYCFtYM4UmSZzxhmIt+ghzp50gegFjPdgi0H4+oNI99ZIHflBJgjhz+C
         /qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785921901; x=1786526701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSPlmzZwsggqkOekQQNlyHJCqbwcPOcbrrGQp2BzoG0=;
        b=H8CCMmqx07Q6Q5a+pUnUOT8ebspQ8YxLkEI2EbVyxjEJdeBEw2v7bIFB/xlYflTdnb
         OxQIazwf0RrSK2yd0tkusA3yiMnmDWdSFwiFgMWJjCsFm/hsS6fZzfP/h+4ntqa0ajtN
         WqQBPZsxClRATaJoH/RcOYSyCbNd58A0V4vtBDqRTRapZXumXhrHH8eQbRSlLnXwBUg1
         QoRpF13uKVrRWiZxBOV8bMKN2wG7vNJt795O8tg/5BqU2l1wTRk9MlofC91/3DLpjsjy
         Uh4cw6LZM1zEw8NlqulGApGsuv2ZfWt48ZbN8AaRN2GlW0SlpYbXS767WWOQEf3Lyo9H
         y1VA==
X-Forwarded-Encrypted: i=1; AHgh+RrJ3OqGeEVXvlqZG/D7+D5La1PL+LutgkGPdnwD4gHsqwBZa+jnINN27TdvafUHbUBIJR1YggQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/JgzpGHM9uXMMFBbM2uK5acgQK0ayHOoYRqWu+5n5zMZubrB
	PySd7VowXJZHLBnL5nk68yLaGbAOQSXey9irujQ5JHYTONhAbmZRePtGg4Ya7hSonglPr2rFayV
	omzDIEc1iQAmBeZZhtmiinsGalXsyyeUZCQZZaz4=
X-Gm-Gg: AR+sD110S120uZLciTTyLVjrkMgr6av2D1NxtqMHK+XuG50sF/iylIm7yAnC3D+YqK6
	+ZjN28yFKdSg+ydwBblZ3eZcMQERs9u5nO0atkL/ROKVfrUfdCfYBiEccwJU7sav0YNSeDru6+s
	4m+HauS0Cr7h3XVm0poCaX1z4jYhArTOirCfDF/GXOV2QRv+gX3UNu1XKkCG/1Mhl9SLNlIZ09X
	YrnQcWfaZrLYclrfaZs0I+zpVg/xWanTu+NuGMfcGDzqTId6wDn51kUR/Ax8uVFacOApjGBOGm9
	xEb5W2yftfo0YzmoxzHL6B7FQqejX4ApRAOEQJEISBU3+WMSEfnNV7mILUjrpanyRW4fdwg5kg0
	hQ5LTIOQp8AK6KqFgPvJvvu/4Z3+66SU=
X-Received: by 2002:a05:6402:324d:b0:6a0:ecc9:79ad with SMTP id
 4fb4d7f45d1cf-6a14f27eb8cmr2228403a12.20.1785921900591; Wed, 05 Aug 2026
 02:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com> <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com>
In-Reply-To: <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 5 Aug 2026 11:24:49 +0200
X-Gm-Features: AUfX_mxgtVLgty6ZSSWmZDWVsSh5RDmDpXo4b-wthWWUZZbeYh47JBHlTiBKreQ
Message-ID: <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com>
Subject: Re: [PATCH 3/3] alpha: determine tininess after rounding in the FP emulation
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:40=E2=80=AFAM Matt Turner <mattst88@gmail.com> wro=
te:
>
> IEEE 754 lets an architecture determine tininess of a floating-point
> result either before or after rounding, but requires the same choice for
> every operation.  Alpha determines it after rounding, and stdlib's
> tst-tininess confirms the hardware does so for the results it produces
> itself.
>
> The soft-fp emulation has no notion of the distinction and always
> determines tininess before rounding, so a result that the hardware would
> not consider tiny is reported as underflowing whenever the instruction
> happens to trap for software completion.  The two paths then disagree on
> the same machine.  A multiply of the largest subnormal double by
> 1 + 2^-52 rounds up to the smallest normal and raises no underflow when
> the operands are normal, but raises it when an operand is subnormal and
> the instruction traps:
>
>   glibc math testsuite, test-float32x-float64-mul:
>     Failure: mul_double (0x3.ffffffffffffcp-1024, 0x1.0000000000001p+0):
>     Exception "Underflow" set
>
> Add _FP_TININESS_AFTER_ROUNDING, as glibc's copy of soft-fp has, and set
> it for alpha.  It determines tininess by rounding a copy of the result as
> if the exponent range were unbounded, which is what the definition asks
> for; a plain check of whether the rounded result came out normal is not
> equivalent and would be wrong for values that stay tiny under an
> unbounded exponent range but round up to the smallest normal in the
> subnormal grid.  The macro defaults to zero, so powerpc, sh and sparc
> keep determining tininess before rounding as they do now.
>
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/sfp-machine.h |  4 ++++
>  include/math-emu/op-common.h         | 23 +++++++++++++++++++++--
>  include/math-emu/soft-fp.h           |  8 ++++++++
>  3 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/arch/alpha/include/asm/sfp-machine.h b/arch/alpha/include/as=
m/sfp-machine.h
> index 5fe63afbd474..bff1ad963c68 100644
> --- a/arch/alpha/include/asm/sfp-machine.h
> +++ b/arch/alpha/include/asm/sfp-machine.h
> @@ -59,6 +59,10 @@
>      R##_c =3D FP_CLS_NAN;                                               =
 \
>    } while (0)
>
> +/* Alpha determines tininess after rounding, so the emulation must do th=
e
> +   same as the hardware does for the results it produces itself.  */
> +#define _FP_TININESS_AFTER_ROUNDING    1
> +
>  /* Obtain the current rounding mode. */
>  #define FP_ROUNDMODE   mode
>  #define FP_RND_NEAREST (FPCR_DYN_NORMAL >> FPCR_DYN_SHIFT)
> diff --git a/include/math-emu/op-common.h b/include/math-emu/op-common.h
> index 8ce066c035cf..1d1ce5c08efc 100644
> --- a/include/math-emu/op-common.h
> +++ b/include/math-emu/op-common.h
> @@ -135,6 +135,24 @@ do {                                                =
               \
>      else                                                       \
>        {                                                                \
>         /* we've got a denormalized number */                   \
> +       int _FP_PACK_CANONICAL_is_tiny =3D 1;                     \
> +       if (_FP_TININESS_AFTER_ROUNDING && X##_e =3D=3D 0)          \
> +         {                                                     \
> +           /* Architectures that detect tininess after rounding        \
> +              only signal underflow if the result is still             \
> +              subnormal once rounded as if the exponent range  \
> +              were unbounded.  Round a copy to find out.  */   \
> +           FP_DECL_##fs(_FP_PACK_CANONICAL_T);                 \
> +           /* The class field is not used by the rounding below,       \
> +              and is unused entirely where this block is dead.  */     \
> +           (void)_FP_PACK_CANONICAL_T##_c;                     \
> +           _FP_FRAC_COPY_##wc(_FP_PACK_CANONICAL_T, X);        \
> +           _FP_PACK_CANONICAL_T##_s =3D X##_s;                   \
> +           _FP_PACK_CANONICAL_T##_e =3D X##_e;                   \
> +           _FP_ROUND(wc, _FP_PACK_CANONICAL_T);                \
> +           if (_FP_FRAC_OVERP_##wc(fs, _FP_PACK_CANONICAL_T))  \
> +             _FP_PACK_CANONICAL_is_tiny =3D 0;                   \
> +         }                                                     \
>         X##_e =3D -X##_e + 1;                                     \
>         if (X##_e <=3D _FP_WFRACBITS_##fs)                        \
>           {                                                     \
> @@ -161,8 +179,9 @@ do {                                                 =
               \
>                     _FP_FRAC_SRL_##wc(X, _FP_WORKBITS);         \
>                   }                                             \
>               }                                                 \
> -           if ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT) ||          \
> -               (FP_TRAPPING_EXCEPTIONS & FP_EX_UNDERFLOW))     \
> +           if (_FP_PACK_CANONICAL_is_tiny                      \
> +               && ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT) ||      \
> +                   (FP_TRAPPING_EXCEPTIONS & FP_EX_UNDERFLOW)))        \
>                 FP_SET_EXCEPTION(FP_EX_UNDERFLOW);              \
>           }                                                     \
>         else                                                    \
> diff --git a/include/math-emu/soft-fp.h b/include/math-emu/soft-fp.h
> index 5650c1628383..02ada0a9fca1 100644
> --- a/include/math-emu/soft-fp.h
> +++ b/include/math-emu/soft-fp.h
> @@ -31,6 +31,14 @@
>  #include <endian.h>
>  #endif
>
> +/* Whether the architecture determines tininess of a floating-point
> +   result after rounding rather than before it.  IEEE 754 permits either
> +   but requires the same choice for every operation, so this has to agre=
e
> +   with what the hardware does for the results it produces itself.  */
> +#ifndef _FP_TININESS_AFTER_ROUNDING
> +#define _FP_TININESS_AFTER_ROUNDING    0
> +#endif
> +
>  #define _FP_WORKBITS           3
>  #define _FP_WORK_LSB           ((_FP_W_TYPE)1 << 3)
>  #define _FP_WORK_ROUND         ((_FP_W_TYPE)1 << 2)
>
> --
> 2.54.0
>

Hi,

The generic soft-fp policy switch together with the Alpha-specific
selection looks like the right approach. The default preserves the
existing behaviour for the other soft-fp users, so I do not see an
expected behavioural change outside Alpha.

I tested the complete series with CONFIG_MATHEMU=3Dy on the same machine
and using the same glibc build. The kernel boots normally, and the
glibc math testsuite improves from 48 to 28 failing test programs, with
no new failing tests. In particular, math/test-float32x-float64-mul,
which exercises the incorrect tininess handling described in the commit
message, now passes.

Reviewed-by: Magnus Lindholm linmag7@gmail.com
Tested-by: Magnus Lindholm linmag7@gmail.com
