Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A863E073D
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787948381; cv=pass; b=K29QfUGiJsR6fQ96qUB97BqBUuM/XVB3IKq7PjS7DFGqtGrm6yBvMI2H+YNopC5NNAwkPszBRHBW0LC/qERa3b8QUDMMg/+a+u0fiwEQaiqtgpmr8VTcZi1iQH20JdYZv6FrN7nSTwLKMypLUgeNMaV/4mdhMtBB7ltrXF+FnrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787948381; c=relaxed/simple;
	bh=8opc2QShzrVS0PXZRlPRkpu6htUMy/gJ4UTVKwzCsDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mp7yLlRi8Yhtm111yHivPgXIJeWlvOkeOwHMSPddS8tFtLIYZHv+zfwJa7NaO6nwm3tR0i86ltNvm51NwdcQ/p8+K1vKdv3lj45KqSXJfuJcicoAC+XD8VbhX4PpFRGI7h26gtv3YUKUflUSU++xO2QTiK2+594axY+8HXVN33w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hg5TTEsK; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hg5TTEsK"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-482e257a23aso799647f8f.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 13:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787948378; cv=none;
        d=google.com; s=arc-20260327;
        b=cSOJrix4hDIGAwRKIkLJg+XTNHSA714/hg/5FZJqzN+0WbGE9A7NNMQ0c/qKpNAmGf
         TKnboAVtVJCcW/oCveb4Tx7IER2ZDKjMjuIKsD07TV1zzT/v3xPvztm9pQEC9jWuhaaD
         5LfR/x4svDfJRF1u1otb8vfKxHivqlIsZNSOvRW3ZGQwFDNXVJSKY/rQNjGvxc2Mxutj
         pP0c0ffTkowmrLfaSNPv6lGCyFpgWer1jHFJbAtUsZlXOXtfMP1F0tpODl61VC7pWDjx
         ACqm3KqWoXu9i4UtBHonIbDETQKr+/nDjpzmVVtUdKJIDl8fGp0Q3FUnlB6ex2QyuBkN
         LIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AqevhQmDUlAlxZrxi7igRupcRfpHxunuXttW6NuOQbw=;
        fh=7evSZogxbgOEhrt0szZcBtwInV203uobb5mBaXOjnQw=;
        b=H2amDdc2BmoHtyDkshSROjP833XdUzv3kgc9CxJJaDcgMXHzTOgHqg4rDjjLlyCJXD
         tO5o2cqKxMCVOy59rqZPMQAf1LaeaMia4cKEeo3iROe+siczEHutiLZyIvxSClL0vXYg
         P+yoVz4lCzTRWn35m3jheiNoLv7LukmySVHhobM7nUm+/DmeVrXe9RtAt1A1IXSjLxxj
         cQcrx8S7+HjYD/UptlsVgV5aOJ2vvFKFvthbJqctXABixLsNz2XUYZKDKwkRu7xDNPtF
         ocn6cck15btThCjWeksT5AS7ERchiX2yRhqXcILC4kxzF7LAs9+pwYJly+gI6+s7dWE9
         I1vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787948378; x=1788553178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AqevhQmDUlAlxZrxi7igRupcRfpHxunuXttW6NuOQbw=;
        b=hg5TTEsKVaqqr+du6x+/YcQ/1d+PlFnZpdOgkmVXWNcFkOZ7WXakbYDksbw2CajLc+
         2cwp5Guw9r2KzxpBYVB+/7Pl63emHDLozUbV1/UkwmAktp99oYtsAf1FShzbT5cGYQLN
         4hHDG45nqTNe1XW2aqvgIgUfAGwLmOfOykwekyVqFpuytUTriJRFfsRFIBbf9Ngtr65y
         US4AfVEdc4gw8fa5pKRKKiqn14ztl0zBhc4TS8b0uk6e5oy8qrVqr5biWlRDWWQMTqXf
         0ly/B6+JJJAJOuc7wVd25s8rjkV/N0XJoXt6DRyN0aKx9jmRvxh9qNUBXfXxtZjQJTEY
         vNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787948378; x=1788553178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AqevhQmDUlAlxZrxi7igRupcRfpHxunuXttW6NuOQbw=;
        b=H0ZONfu+oCFRkBlue5ym5Uj7NJgOKQz2ml2i9SIDjGquL+j3NcDkK4XcltY4x+JDqL
         sNC961FILiIWG20YRlV5uNWiPLzsGWZ1e3zbau4mqFM7XolxCm1LoAXbEryqBsjAzpnm
         Pc8fK2ND18PdgadADrlLCPmvjLTgCCiXbajK8S1z7axVI0/wx/bQVc2ilOzGU8rKIcH2
         ZCD40+kF77wg2aOD4LG0U+fRQR9RqBNP0iZ38OORupBLpj47zNCn+dqcUN6RqXhjvBFY
         jOUdntge66cgdPFLYFs+P/Kg7hfv92KCe+cKSVgtgMKuUEppc2bWNZhtW+2x80XiVKx7
         zC/g==
X-Forwarded-Encrypted: i=1; AKwUvBxuNe6SdczemK5FEetsoSg0arOF2QKO3dupZEGD0S20kRL9gh1iU6j8LSzX1BYuHtNHEb5jse4=@vger.kernel.org
X-Gm-Message-State: AFuF++lnnkaOxa+2hRRsABgb+axk7WEorWf1GVz2nOhWaipQda8vDawD
	W/Roz1aQeXFnN7QV2eODDOqg+AiQAjOC0G7dEICgf2yZkn8uK+GGJ1w5tUAsA6ZNWvcUokW/byc
	OJrD2LILKG1AFP5hj65EezWZtDJABbgS7cTOEzdXR
X-Gm-Gg: AYBFou2m4KVfChhSivcvjPFq2wLp0lR2w8/4d/zPZFKMjVjG5s6UM7fDEkuR/HchY0j
	V4nXtQMGgWAvwtAQ3tmvUF0xTN8X4p0EoX16QnpjMk0q9MpbQlA0sfU+1dI7zoPmeYr3ISiNYnU
	67Tvu5P2Y5lWVih8+iu+Iur2QZIx8jpQWijiHLkTT40wAsJoYOA/O9xlienJPPy8k7s+o/KVP5m
	sBRRG1Pjh5yA+yAjxE7xfrtkGTHVS4upjeX+XaxeJ6OYHT5pZG3BlRNR0R2qOYlTA/ZsJaymzaW
	6xPimwY+MoLd/fM7DniA5KgelYsKTR8ozpQYjoVYk8astN8k+qeT0J2/f7yCJlWx1Xf6GmmSHj/
	V0Ai7mqUjR7NR/jPTiPohctBoIvc/ICOHqrn25kn2O59nluM7izimSpCrHQ==
X-Received: by 2002:adf:e191:0:b0:482:e6b5:61c with SMTP id
 ffacd0b85a97d-482f7983567mr15853702f8f.8.1787948375179; Fri, 28 Aug 2026
 13:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <20260827194508.446733-1-linux@yoavmoshe.com>
 <CAKwvOdkSZBbq=e916=efx8G-CTzZ5b31AhyUytO6eJjjkEdMow@mail.gmail.com> <CABCJKuc0cWWdkA7zrCcuze4AE-qTSETuUi-eRewPnn_ivHEADQ@mail.gmail.com>
In-Reply-To: <CABCJKuc0cWWdkA7zrCcuze4AE-qTSETuUi-eRewPnn_ivHEADQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 28 Aug 2026 13:19:23 -0700
X-Gm-Features: AcwNN1V_2kf8BqMVIZlH3wMy_YFAxnJPsfByyKc8QzliKU08PTCWPTO7ull2SPI
Message-ID: <CAKwvOdnA7Ej_uppSL7U2xwxyUQoDMvO+RArj4HCUSOziH0rCqA@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Sami Tolvanen <samitolvanen@google.com>
Cc: "Yo'av Moshe" <linux@yoavmoshe.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 11:45=E2=80=AFAM Sami Tolvanen <samitolvanen@google=
.com> wrote:
>
> On Fri, Aug 28, 2026 at 11:29=E2=80=AFAM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Thu, Aug 27, 2026 at 12:46=E2=80=AFPM Yo'av Moshe <linux@yoavmoshe.c=
om> wrote:
> > >
> > > Note: linux/uaccess.h is included before linux/cfi.h because
> > > cfi_get_func_hash() uses get_kernel_nofault() and cfi.h does not
> > > include uaccess.h itself.
> >
> > Ah, no, we (you) should fix that. include/linux/cfi.h should IWYU.
>
> Nathan fixed this here:
>
> https://lore.kernel.org/lkml/20260604-tracing-fix-cfi-h-build-error-v1-1-=
b27015390901@kernel.org/

Ah! Then this series should probably be rebased or include that patch.

>
> > > -ENTRY(imx6_suspend)
> > > +#ifdef CONFIG_CFI
> > > +       /*
> > > +        * Pad the location counter so that the type hash emitted by
> > > +        * SYM_TYPED_FUNC_START() below ends on an 8-byte boundary:
> > > +        * fncpy() requires the function entry to be 8-byte aligned.
> > > +        */
> > > +       .align  3
> > > +       .4byte  0
> >
> > I still don't like these assembler directives inline like this; this
> > feels like we should have perhaps a new macro in
> > include/linux/cfi_types.h. Thoughts, Sami?
> >
> > One that garuntees the 8B alignment of the symbol for w/e that
> > function patching routine requires?
>
> Sounds like arm should override SYM_TYPED_FUNC_START to add whatever
> alignment is needed?

The 8B alignment seems to be a requirement of fncopy() for 32b ARM.
But functions in ARM can have 4B or even 2B alignment w/ Thumb, I
think.

Doing such an override would add unnecessary padding for each use of
SYM_TYPED_FUNC_START where probably none of them have this fncopy()
constraint.

```
    #ifdef CONFIG_CFI

    #define SYM_TYPED_START_ALIGNED(name, linkage, align)        \
        linkage(name) ASM_NL                    \
        .balign align ASM_NL                    \
        .fill (align) - 4, 1, 0 ASM_NL                \
        __CFI_TYPE(name) ASM_NL                    \
        name:

    #else /* CONFIG_CFI */

    #define SYM_TYPED_START_ALIGNED(name, linkage, align)        \
        SYM_START(name, linkage, .balign align)

    #endif /* CONFIG_CFI */
    #define SYM_TYPED_FUNC_START_ALIGNED(name, align)        \
        SYM_TYPED_START_ALIGNED(name, SYM_L_GLOBAL, align)
```
then this driver could do
```
// fncopy needs 8B alignment; see arch/arm/include/asm/fncpy.h.
SYM_TYPED_FUNC_START_ALIGNED(imx6_suspend, 8)
```
--=20
Thanks,
~Nick Desaulniers
