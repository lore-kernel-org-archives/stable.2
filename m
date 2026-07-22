Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955A317163
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754227; cv=pass; b=ju6gscwcUthg1TcSQhvbns2DnZKQx6G+F3jZQZOEm4oDFQ1Ofg5ULL1t8Qc7hRZeew4ZsfMDQqaS6sThBQiQeNCexyYmcw5SxrYEf+YMpzzfEqVQ4D2auHWEhaASEAvI3pFqcBiRQizjNcshSIqrTBtmDIVlWFyUypltMJlYKQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754227; c=relaxed/simple;
	bh=pqw+4F5UxMsZ+Gmhe/bd3XKvqXdh+gUmrlvL4jHSYEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHLw/hbc48GBu8OHl3STdUZuW/RojqN6qOXgFCMBnLM+uhrPdT/aNroTegKIV86OLARCcKs7xyhdM0vgsea4n0XRkE0DkmvYXoY3gwPS3CrJTDGlsQQllfdnQy+gE/BUH6xnrpSW+m76hyYxX20prCYqGXj80oX4zA73TLhU2t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O91eiT78; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O91eiT78"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69e08ad526cso10236335a12.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784754224; cv=none;
        d=google.com; s=arc-20260327;
        b=GVLHy9bj/0H4qXgi9v4+dN5prmsbe5Ikea4QEQn96/ioCOcRK1X1gIOO4T+I0KZopn
         dZMrkCGCKl3lfa90T+CbeBk0wFgYiTWnQUcoRFUO+yjspxwscT06aN8LcwSD5Yig71B9
         6z9yUBdEgYTmhUtwe+z86U+9y6f73oEV8jEmsFN2F7RH3MKQ9zhxtlcCcaIvP+95M3pJ
         NUH7a/rhVuawngUgT+9fUmey81aG5WwFaJ3asJGvxU4oluuhZDGhwjylaNY7DkBtSVq2
         tjUXh5ktj9n2J+76v3cMMakf3yKQl5yZ6zOhv1yZe44MynE7K55EjEV8c9dwUvreulqI
         8+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iDk9GJaFBzM0ar9MYB8RB/ZFgtMZjf2y1b5NLaLr2MU=;
        fh=NT6sbx8+9EPifyf5A1Y/emALgn7JyxzHiH5xZxy32Rc=;
        b=Y8E79uFs1Y5eOhBVgMt302R85CbeUkat37oiSNhDnmQE2I93jbAKV6da8lUO/5adFc
         hQV7/Izb7Q8ReYy/NEssIrjwA60D/OhLFwITPm7Igj4v3/rABaOpibrUvprkD6tn1yGk
         CDFqf4i5cDOBaDRZd7OnmeC6pOqDqjSs4gY39m3MzxXf9Tgatm4+iLy4nYGcj/6wMk4R
         m2oOd2siIurUoNefwBpCQjIsgyVeZ+uwzueADra+OLtBxsoY7jXxG3U/ewc61n3y2xGF
         BvJ6A0E31un5l5FlbUKwdBgimo1/4egbJQGGQ+Vf+kKBGkeMiM/t9gdXQZIlatthBr4x
         7NgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784754224; x=1785359024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iDk9GJaFBzM0ar9MYB8RB/ZFgtMZjf2y1b5NLaLr2MU=;
        b=O91eiT788IlTEIPZZ1fo8eUKPD1tqJaHgs2vxhbpEyQzpwXhL4qX+cji9iO9BijotK
         8YGyDn4gvG82sEJfKJ60wev1QMVbYntD/xAn8zCxjcTeDFsnUQfoxh4JRzu5jUnnvHcm
         +wfVs0fL7fPn6znJePcc9fDWWY83MZYAOWZiryRvidoE8Ym0ceEGDN6af28/hUlelEi9
         C0iuqDxsurj3lN5ZFlkycYTgEgWsPCJuYVDOwWalxzrlDowSb8DJ8qrRlCu719huCCzs
         rhI9aBsZUEs05Y4uc/Rw5PU9jUVhf9XSQFF2Jk79CcRg7Snlv7zcFMxZU1Mn42QlL8RA
         XBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754224; x=1785359024;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDk9GJaFBzM0ar9MYB8RB/ZFgtMZjf2y1b5NLaLr2MU=;
        b=V3xlBdT1abaAeahpBlahI6cNC4G4DS6xDCEWSl4fCTVyoB27W+52OTFeyGoui2YTKs
         7o9coCXptXE67TGEH6DKSpL4NXJuT6ysb9TtejfPTJXFXi4dariOrQNT9vTnsdi+MM/B
         kmba8SK3Izv9yscGKcDoskCjlwgIY9ljsiAwYwak9nZnL9A+iXmVerHRbWsnWTzAJxLT
         0k5NFZLzE5bdpZm5z9dnxdp1Y18Fq15+l279HddHb/tbqS8p50tddQJLQOAJ4BbTA3ec
         xQmLL/KAU1U7G8PXO48wIP6j+ZCEIP2BeIn561o+k5pP8iN3QG1yzk2RL19t3hZyOiyH
         I1gw==
X-Forwarded-Encrypted: i=1; AHgh+RoCs9etOHDuCYdKS5bYjjDoZHXVfzUhUJH4WNRIikGPderXvida9G3xYFE+vUQhO6vshvdDx8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa8+0xYLFvHoybU+kmqhE1tqRiHNxXtBHi6N3ATEKED+9quxau
	1sCLLR26Md1HAzujFWMzh3k4GiY+LnGX1D4ANvwYX1pTl9NwTVs544DxbvVBbY26ej8XlA8DJ1x
	ZCyHhCGSocId232fjTex99Oymtu+Rl7P2wkr9duoz
X-Gm-Gg: AR+sD1354TyCFRkWI6EifD/DCJIXnESO1Nz1XrYeKcLV+MEBDdnySA+NjwN2XwMCcNP
	T//ZnGjwzfFJuyebDU8gssehPFfJmiQa7OFFjZYW0hMfhvR5QnfeklcJ5Qf5+eviNjZmw5UmmNB
	ZBlAzeqpa7KDE7ZcR+gbYcmOO1QNz8djfcfoT7UF6CxG4eG9hpBDAm5O7Q+i7N1SEsVtTp4JxTC
	9HlmArCc1f3fL6I/a2OiGrTGfQgIVKOsu6wyzQuZdvXUN0iOVYCHMOyAlEpim1nDONIMpxeIYTT
	1NBZyga/1R0RH1wxwGgapBcBXQUPWlmnPXNNVAHFEK7iJVhimollyBdmNLDi97XHC8OB+/A=
X-Received: by 2002:a17:907:7245:b0:c12:b227:614b with SMTP id
 a640c23a62f3a-c1c507c5992mr22090766b.27.1784754223030; Wed, 22 Jul 2026
 14:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722172443.534251-1-akkun11.open@gmail.com>
In-Reply-To: <20260722172443.534251-1-akkun11.open@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 22 Jul 2026 14:03:31 -0700
X-Gm-Features: AUfX_mzKunA_ErzQZrqRUgnl5wCMQPxyOcP43n29TIvcYdToB-p2ggVGLa6Vk7o
Message-ID: <CAKwvOdnbPKoTy72EvfpKtT9Ne-r+O0j99KFX8OvjGk8ZxsuEGw@mail.gmail.com>
Subject: Re: [PATCH] arm: mediatek: fix secondary CPU boot on Thumb-2 kernels
 with Clang
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Russell King <linux@armlinux.org.uk>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Yingjoe Chen <yingjoe.chen@mediatek.com>, 
	"moderated list:ARM SUB-ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>, stable@vger.kernel.org, 
	Arnd Bergmann <arnd@kernel.org>, Ard Biesheuvel <ardb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:25=E2=80=AFAM Akari Tsuyukusa <akkun11.open@gmai=
l.com> wrote:
>
> When building with CONFIG_THUMB2_KERNEL=3Dy and Clang, secondary CPUs

Specifically, was LLVM=3D1 or CC=3Dclang or something else used?

> fail to come online with "CPU1: failed to come online". The address
> written to the jump register has bit 0 set, causing the secondary CPU
> to start in Thumb mode.

Ah, yeah missing those is going to be a noticeable perf hit!

>
> secondary_startup_arm is ARM-mode code (.arm) and, on a Thumb-2 kernel,
> expects to be entered in ARM mode in order to switch to Thumb via the
> standard sequence at that label. Starting in Thumb mode causes the CPU
> to execute ARM instructions as Thumb, resulting in an immediate crash.
>
> Clear bit 0 of the entry address so the CPU always starts in ARM mode.

Thanks for the patch. Any idea why this isn't an issue for
GCC+GAS+BFD? Perhaps there's a difference in the LLVM tools that we
need to address?

There's definitely some difference between clang and GAS here.
https://github.com/llvm/llvm-project/issues/211376

I wonder if perhaps a better machine-agnostic assembler-agnostic
assembler-version-agnostic patch would be something like:

```
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f22c50d4bd41..687ee7063a73 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -383,6 +383,7 @@ ENDPROC(__create_page_tables)
 ENTRY(secondary_startup_arm)
  THUMB(        badr    r9, 1f          )       @ Kernel is entered in ARM.
  THUMB(        bx      r9              )       @ If this is a Thumb-2 kern=
el,
+ENDPROC(secondary_startup_arm)
  THUMB(        .thumb                  )       @ switch to Thumb now.
  THUMB(1:                      )
 ENTRY(secondary_startup)
@@ -429,7 +430,6 @@ ARM_BE8(eor r4, r4, r5)                     @
without using a temp reg.
                                                @ (return control reg)
        ret     r12
 ENDPROC(secondary_startup)
-ENDPROC(secondary_startup_arm)

 ENTRY(__secondary_switched)
 #if defined(CONFIG_VMAP_STACK) && !defined(CONFIG_ARM_LPAE)

```

Can you perhaps help test/verify that Akari?


>
> Tested on Lenovo YOGA Tablet 10 (Wi-Fi).
>
> Fixes: 0cda07001a94 ("ARM: mediatek: add smp bringup code")
> Assisted-by: DeepSeek:deepseek-v4-pro
> Cc: stable@vger.kernel.org
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> ---
>  arch/arm/mach-mediatek/platsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/pl=
atsmp.c
> index 6b0943d95555..9a7c65fc3ae1 100644
> --- a/arch/arm/mach-mediatek/platsmp.c
> +++ b/arch/arm/mach-mediatek/platsmp.c
> @@ -124,7 +124,7 @@ static void __init __mtk_smp_prepare_cpus(unsigned in=
t max_cpus, int trustzone)
>          * write the address of slave startup address into the system-wid=
e
>          * jump register
>          */
> -       writel_relaxed(__pa_symbol(secondary_startup_arm),
> +       writel_relaxed(__pa_symbol(secondary_startup_arm) & ~1,
>                         mtk_smp_base + mtk_smp_info->jump_reg);
>  }
>
> --
> 2.54.0
>


--=20
Thanks,
~Nick Desaulniers
