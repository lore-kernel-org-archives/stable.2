Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24CB484248
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787679226; cv=pass; b=tskCf7dGxm4NCwfpF7S5CPUjM9IMxU7uRpZvvh3qQNfB+YvIQBFl4Q1KOG693VmPf8SHpW/HQZbmsNamFyoHswVotBDCxCphjLqpgIe8/vIFtw/+kAu85nlS4jrSsdTyO8cv8lnJgBnIskRBPlhcTiQYA7yJQcaWx4UHhkPaF5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787679226; c=relaxed/simple;
	bh=zz7+m/XFvaCyh9sM/yu1NkCUrr2P3uDfYLbdRpy1i0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlr508S6NYFFSeLQpd52i4lUyTy17qwjPhTTsijAcRkkEFPaXFH5+4JVX2uwCBMBkoslNK/5r2nUcVYKI9gFQ0X2A2BU87LfWMh9fNDBkaf0KEXZQaj1fFcMxgEEco4RZxy/86WtjcRTcDe53Uh3FLMbWQ3ftT2r4on8iTIBbVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0xoWIFG; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0xoWIFG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so6686105e9.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787679221; cv=none;
        d=google.com; s=arc-20260327;
        b=muS+JuNFK7970JDi3TNXQ+L555PmfQPFYT0d4L7BiK5H1cdmbXV5XPmL9OwMYtTJC6
         geL+zsJuOFAbqyDD0P0cxV39E2OgByUT2kWPYt7Qs8CxYsYrtAP7DZcLDq2v3Mv7OYWu
         sfFh5otWLbvIPBDieEGY617VW+JLW9LvLcJNVfZyY9My2RDZzyRCy+XCbjXD1f//rBEh
         J2M+M+VpwsrVmvsliWY13aK6H/wZCnwjTdAnfLgmW3IY8+CtS4vVM6NAUY1DDB3y/yqo
         AjBUWSNvJnxavlnQqVbgtzvmloksrt19ZbkI2D0X4eqgqTyGfLoUT6eBEsdGNIqjZjVK
         OMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+C3oMNTxKING+oxnIVuwTvyrIfPtnlGjd1Gmndygo7I=;
        fh=D5heIDIdDU7W/RHNRD14nnj6sOw/xgwH+kOqm7ZQv88=;
        b=Ymvq76pMmPA1pQLqrqHZkg+Isly+WRt2vfQ91ahObXW2YoPHT0mAqDd3Qq9FnI1LZV
         fC/WnRYb1EGCWLL9IzQW3nVlOzdftBaWKjwGbzA0maFo2hToLMxGHKk+UdWQ1iIiMKyc
         DupqM1cfuQHLqPcSaEO3yMvOTsrmt6dxbVANaJFXHFud+oI3o1AVkh9sUiC16Eonjd2D
         i8JD3vzaMVsPFUjtHQMN39wVeUH0sjWz0CLYmD+1n3I5OVhFysj3ZMYUJ6LrtaoJNbQt
         y2RoRXiJrZHBLr5PIc2dJYYTQiHMCzaMax8MnGjNaYl+eNKfAiqOk5DbWNxtakFX3RmK
         hw+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787679221; x=1788284021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+C3oMNTxKING+oxnIVuwTvyrIfPtnlGjd1Gmndygo7I=;
        b=G0xoWIFGiSlvXhgCqMQpwdH7UE8YQUh2WufRL6k2wDwyUFOs8CNU8r3t52WG7PQVGJ
         mVfbj+R/HKxjjsxLyn4FKOXGuN6oULNeN8EYUZil8XzOgAq9uY/s1bLWLY8Qzil4ooqK
         LpJIaBKHsx87GRyhWuT7mG07cfpeeACzwh9Q2aHJZdNKJcPWg8ke111QirrW39aZcMLl
         8/t9KzbFKrFT122btJGi9I68gq9cFwL1cGr/pK8hIWo/ZdwO92ehvPcUSjyBaTH01/6n
         6HEjab8xAkKkvprS70Bh7xoTtPtrwZ3CRLoGoynHO59A3Y6axo3kaFjSGcR9Ao3CZUcv
         g+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787679221; x=1788284021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+C3oMNTxKING+oxnIVuwTvyrIfPtnlGjd1Gmndygo7I=;
        b=RlzA0UTIA/bT9884kA8+hoHxdKCXwfq+TpPCjk3hGa3EjB0IYltACDYfQZ2Xt2Qdnh
         AwyhjMJ4QRwPEj2yL3kk5wMZGQ5EojF2zQ45sT2UQxZ7LJ/QIX5+XSt8/z8sbszd4ddq
         3mc7XQfaEsy+TukkH6RzLx5AOzF6b/R/etNYwNvFEoMbX4ONanoVRGbAkwUzaVtJNO73
         Ksx/XqkecbRqVH1tU+D9QIfrwWUM9EQlng1Lh3zWNkRIeRmcShTPql5a3XJp+a+vKlC1
         cZvVecVdIrXMoHY0hvQMoFYKSsFT+rpDy4pv0N+H1uo4ZsTKCX/1kl1Bh1MmPaFleLHD
         cKzg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4/+GuL6zVD6Au69Ids4qlO1OsqLz+a2JUAByhKbukZbqct3tNmBGYUCWagSRgVO7sBjKJadI=@vger.kernel.org
X-Gm-Message-State: AFuF++nnKWbd2k8mZlCvgYHXlQdwZpyjzybJf0ckSaUH1Wp75F1xSTQC
	eownvMTwnmkuzZqegs+RlQ8mIMNjCHnUHPqFXC6a4iB1SxyWdKYoCVN/lABOn1wU435Uv37o3mW
	u6E/q+Hwun5VMiuR4hwRX76nWvoGpks9AHDXM1W6F
X-Gm-Gg: AR+sD10zUEzJGP+xy+dzRiV4FYevv2G27sfwn3eY9aThejoJbyG9a5fiOP5ttOpmWJj
	4ZhY+qjtXU3bzIRznooOM49/0rHmUC2yxldlxakzlPIfn3O2tSHJSkiMWlwjSewDPeDoF7OqVci
	f/BLRBOZMrFjlig+YAm/uD0gzl45RZc9Q0Dkk7FK5zFqXVJmVcLb9BId+lABtAErX0enHHvJq60
	v/8wss2LVHXbTKwS/ueXhfyMl67USUMDWx6ULAKGqmG4iRE2N60lbthoIN/9iOHgPuPN8ktP70l
	dmODieC4FFQkvO8oOX+Fq4Z6csY73MSpEyM+cHp/pfAID2JAA1L8ehKvckEVB0u0qPFRJKUMn00
	Ge0Gcp5ZEqHgAHLQXbCpQPDDVEgWQVZA0jfMPokGRlcviv3FFxfeLH8MbpV/9ZA==
X-Received: by 2002:a05:600c:4c9a:b0:499:b81d:f580 with SMTP id
 5b1f17b1804b1-499d630abbbmr70390245e9.2.1787679220347; Tue, 25 Aug 2026
 10:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
 <3046e60d-509f-471f-bd15-3ce78c87500b@yoavmoshe.com> <20260721180950.GA3684684@ax162>
 <180001f5-bddd-4e58-8442-f7ef3c979500@yoavmoshe.com> <CABCJKufhvTxmVm8y7xr4RWWKsoZk0h8UGBnem+F5fknnimaqPA@mail.gmail.com>
 <7f273a08-b29c-4e15-b340-898b251efe57@yoavmoshe.com> <CABCJKud+GsBVv+XMTsi_4QAaTHo7jXD2Hyvi9wqKd7x3i2xyAg@mail.gmail.com>
 <415ffa24-a30b-43b2-aa6a-a1cde3bd4ef0@yoavmoshe.com> <CABCJKud9B8vB-J8f0HLHw6EgEKVWzy+Q1PrNxpO_6yCGtEyi8A@mail.gmail.com>
 <12a46993-82a5-4109-87fa-61b8fcf764aa@yoavmoshe.com> <CABCJKufoQ0fX797M01t7CkTgMEwNCELY1=ptZsxr=jWOR-KAyA@mail.gmail.com>
 <CAKwvOdnaOy-nyZ=8oLw4N-_hA9JZVdP2BhR8cweCAOhsy4VG6w@mail.gmail.com>
 <91cb0f21-e78a-4931-b123-937c6a01592c@yoavmoshe.com> <CAKwvOdk-JmqjhZWBiLjXTxKhEV+T3BAB6An+3Ara8oybmhAMpA@mail.gmail.com>
 <da6bffba-6c44-4ee7-a1a8-842f9e6de408@yoavmoshe.com>
In-Reply-To: <da6bffba-6c44-4ee7-a1a8-842f9e6de408@yoavmoshe.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 25 Aug 2026 10:33:28 -0700
X-Gm-Features: AcwNN1VhEAk5JMtsG9Q-WQf39WhqqMQXw7xm3opvD6bBF_aO5cN6dQw8NYVOTcc
Message-ID: <CAKwvOdmT=Q+etTTJUna4ZAg1=eXwaT9cSDy=U0s15UT-3TOu1Q@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 7:10=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com> w=
rote:
>
> Sorry it took so long, I finally got it to work using your method!

Great! (It's somewhat funny to me the level of effort going into this;
I love it. Keep up the good work).  It's also good to hear that we can
keep this working _with_ CFI still enabled.

>
> On 2026-08-17 11:58 PM, Nick Desaulniers wrote:
> > Can you share that diff? I would have expected that to work. Perhaps a
> > minor mistake in your implementation?
>
> I started with something very simple: using SYM_TYPED_FUNC_START and
> copying the 4-byte hash into OCRAM before fncpy(). But that didn't boot
> on my hardware (Kobo Clara HD, i.MX6SLL).
>
> I think the issues were:
> 1. My first attempt wrote the hash to suspend_ocram_base +
> sizeof(*pm_info) - 4, which I suspect overwrote the last member of
> struct imx6_cpu_pm_info, corrupting the memory controller setup.
> 2. Moving the hash after pm_info and offsetting fncpy by +4 still failed
> =E2=80=94 I think because fncpy requires 8-byte aligned source and destin=
ation
> addresses (FNCPY_ALIGN, with a BUG_ON check).
> 3. Offsetting by +8 for alignment also failed. I suspect it is because
> SYM_TYPED_FUNC_START emits the 4-byte hash after the .align directive,
> which shifts the imx6_suspend label out of 8-byte alignment, again
> triggering fncpy's source alignment BUG_ON.
>
> The version that finally boots on hardware emits the hash manually with
> explicit alignment padding, instead of using SYM_TYPED_FUNC_START:
>
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> index a671ca4..b500922 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -515,7 +515,7 @@ static int __init imx6q_suspend_init(const struct imx=
6_pm_socdata *socdata)
>         pm_info =3D suspend_ocram_base;
>         pm_info->pbase =3D ocram_pbase;
>         pm_info->resume_addr =3D __pa_symbol(v7_cpu_resume);
> -       pm_info->pm_info_size =3D sizeof(*pm_info);
> +       pm_info->pm_info_size =3D sizeof(*pm_info) + 8;

I wonder if it would be better to modify the `struct imx6_cpu_pm_info`
struct definition instead to add explicit padding there?  The comment
below about reserving padding seems to make more sense for this hunk
here than down there.

Like add a `u32 cfi_type;` member last, maybe?  That's not 8 bytes,
but I think it fits in the padding, then you might not need +/- 8 in
your pointer arithmetic anymore? I _think_.

>
>         /*
>          * ccm physical address is not used by asm code currently,
> @@ -568,10 +568,16 @@ static int __init imx6q_suspend_init(const struct i=
mx6_pm_socdata *socdata)
>                         mmdc_offset_array[i]);
>         }
>
> +       /* Reserve 8 bytes between pm_info and the function copy in OCRAM=
:
> +        * 4 bytes padding + 4 bytes kCFI type hash, so that the hash sit=
s
> +        * at fncpy_dest - 4 and fncpy_dest remains 8-byte aligned. */
> +       *(u32 *)(suspend_ocram_base + sizeof(*pm_info) + 4) =3D
> +               *(((u32 *)&imx6_suspend) - 1);

This is incredibly hard to follow.  This is copying the hash, not
reserving anything?

Is cfi_get_func_hash() something we can use here?

```
#include <linux/cfi.h>

#ifdef CONFIG_CFI
    // Make sure to clear the thumb bit!
    pm_info->cfi_type =3D cfi_get_func_hash((void
*)((uintptr_t)&imx6_suspend & ~1));
#endif
```

then remove the below hunk?

> +
>         imx6_suspend_in_ocram_fn =3D fncpy(
> -               suspend_ocram_base + sizeof(*pm_info),
> +               suspend_ocram_base + sizeof(*pm_info) + 8,
>                 &imx6_suspend,
> -               MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));
> +               MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info) - 8);
>
>         __arm_iomem_set_ro(suspend_ocram_base, MX6Q_SUSPEND_OCRAM_SIZE);
>
> diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend=
-imx6.S
> index 63ccc2d..c06e474 100644
> --- a/arch/arm/mach-imx/suspend-imx6.S
> +++ b/arch/arm/mach-imx/suspend-imx6.S
> @@ -3,6 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>
> +#include <linux/cfi_types.h>
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
>  #include <asm/asm-offsets.h>
> @@ -148,6 +149,15 @@
>
>         .endm
>
> +#ifdef CONFIG_CFI
> +       /*
> +        * Emit kCFI type hash before imx6_suspend with padding to preser=
ve
> +        * the 8-byte alignment that fncpy requires for the source addres=
s.
> +        */
> +       .align  3
> +       .4byte  0
> +       __CFI_TYPE(imx6_suspend)
> +#endif
>  ENTRY(imx6_suspend)

Should you replace ENTRY (and everything you added to this file) with
SYM_TYPED_START?  Or perhaps we should add a new macro to cfi_types.h
for this?  ENTRY_TYPED or something?

>         ldr     r1, [r0, #PM_INFO_PBASE_OFFSET]
>         ldr     r2, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
>
>
> > How did you verify this? Can you share the command line invocations and=
 output?
> I tested each iteration on postmarketOS by building the kernel with
> pmbootstrap (Clang/LLVM, CONFIG_CFI=3Dy), replacing the vmlinuz on the SD
> card, and booting the Kobo Clara HD. The earlier attempts all failed to
> boot (though they worked fine in QEMU, which doesn't emulate the i.MX6
> MMDC hardware I guess?).
>
> I'm not really sure which approach is better now. The version above
> preserves CFI on the indirect call, but it's quite involved compared to
> the v3 __nocfi wrapper. If you think this is the better way to go, I'm
> happy to clean it up and resubmit as v4.

I do think it's better, but probably still needs revision.

FWIW, I still have a bunch of i.mx8 family boards in a box under my
desk.  I have a wafer gifted to me from my best man that we think is
some i.mx chip from his time at NXP.  Out of nostalgia for that line,
let's get this wrapped up neatly with a bow.

>
> Yo'av



--=20
Thanks,
~Nick Desaulniers
