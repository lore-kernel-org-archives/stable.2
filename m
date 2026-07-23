Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CBB346AD0
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798156; cv=none; b=bhx2Xo157P1CqTKoz0l/+nErBqV/6ZZCAAIwnIP+VSjbeGWuoOmZCNxGo2v2znM5AzpkA8DA3sf03Og6aNXNGgLqu52X5zeGlEZUAP3L89a8Ub8DTzyl5x4OF/CLuYB7dnVaTD7G4uZr/GS5kwuflkDbK44QXnt5XuVdpRHzxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798156; c=relaxed/simple;
	bh=mUo0Bw3C+bodsN9UVSLM51ud0jM2f1gq/odQxk5Ypmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+ZiEYbERoHt5f7f+F8Epi72iWsgcPuIDLAg2H9JlEfdR6DRWeQvUkqPCu5mpbfjfjW8zBuZ7oeSWe+1Q/RQy6647sXjWxnuqIq4GvEKFUjS8l7e9HAdq2YlNzlZ/Lgw4rIpQrdXYNxEYRfQBs3Q0aV+aPVL/BJ5gIFpH1jUgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtqPWv2T; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtqPWv2T"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso408173b3a.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784798152; x=1785402952; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0fXT6bgGgaK9AKCq3ImfbU0yU7WjLK0dX9VTXz/R7mw=;
        b=qtqPWv2TCOgx5zJuGIk1KpNfHbbSdXe6h5Uhvz+b69xxYY+0T6Rqu+ubC6XR0y0KAz
         6dqgcpVQ3us5dRzhddM4wGNou/qMzU3U583teKf2D7CppFnebURHE6+ZbPuAZaRbiAFJ
         3JAjLDCUktqd4V1rbhqGNLhOShkB4PkVGjrFy2e5oqcQosls7RAD/5u7XgC+KdtfMZlF
         U7JAVxByK/yFtHTP5sKMU8TfRoD0qOCGqCyJD8aAwM7t35D/Zr3rXU3zAksuf9GalmFI
         Zs66YpI3X3efKlmJGgpI18oYFgfNioZWClFYdxMEUTBg7uXwJS9FEmXSwp4/E8Kgm77V
         2USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798152; x=1785402952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0fXT6bgGgaK9AKCq3ImfbU0yU7WjLK0dX9VTXz/R7mw=;
        b=gW+M5sGBI1oUWzJhhqdH1WsS9n5dLFwLyHS7Xe4pHnPjFbrfTnjZTzPAWuWR6q2ugl
         R3k1tYzjbN3SEkFLMuQT3Lotq2sL26bmOHktioED8BR/s9fq+78FES6SAVZqU81dr5oJ
         d5YuB5JJoRgEK3TwsXrSYSFlcLKLFu2ISuXOTGe96vaQSySS7Rd+PSX2uiRWHAXf7pgJ
         IsrdUZY2CohGrKCgl1NdnrOpvKcOONCbFfptOoztqVV5TucsqczBSc94EbiSj4zeV0YU
         XsdjP0B0/R5wEoRMH/MXf7PziApSfVTiz5OGbD4ZJp3e6+1rUSWUnMSfjDDm/8GpXYPl
         XZOw==
X-Forwarded-Encrypted: i=1; AHgh+RqhUfc1HvugbEsIrAq9PvHt8Bu8qPViji21QZev4jWqUhNXakJ5pasIBLnZ4n5c4CNC2/cSG0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0lgCTuUwT94+rQUgiPru6cPzk4gdHYAxh7c307rS6lz7vKNg
	doLZqk0UQSPYcjCZNdJz17aeJ1mRWv52WMsHidkZQAmL8xS6OOpvl36Z
X-Gm-Gg: AR+sD12ESzEC6XKpDI/+cXu7wbLAFxAsMOkmnEaYmd+jzYDspBnVX5NpGqmjnVdoJzC
	/Yopq/pFHEYWcw0itCrzcqkmtiWIY6OYv7DXB8X6hqkP2j2iju2en+/L+970UWY/voTbSaVQ8+S
	6k/geNZby6TzFz9B62ztM5R8/RBfWe2kHIH0x7W4kHSA2gQ7/nlrcaeii+f90Bbj0qiRmWmp3dt
	n99y87jwcDjbqTcecNg1/2Zo7iu5w88M0NO5ckmuBN7gmOlh752Jw2WYFRm5CbeMEqlNlxub+Fa
	gFrf18QDmDmmODdVUL+0Rw/Irhn8p7dAAcRAlSXhE/tVlF0g8cXBBKaA0EBZjwnONOJH0YRt3pP
	75kP9O9vXDIlq9PqjzkgNZZ1GFCFaP7kjJ6SVU5rRv6/prRajvgnB6ZKoLhjDgopeEDn+WT0A68
	ol4YLHcjmQf6yGZ6gvRTt909PT8k6m0dxeMKH8GuJ4pwbT
X-Received: by 2002:a05:6a00:3c94:b0:845:4126:222b with SMTP id d2e1a72fcca58-84e2b8bf81fmr2868281b3a.28.1784798151685;
        Thu, 23 Jul 2026 02:15:51 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17600a72sm2738538b3a.58.2026.07.23.02.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:15:51 -0700 (PDT)
Date: Thu, 23 Jul 2026 18:15:47 +0900
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, 
	"moderated list:ARM SUB-ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>, stable@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, 
	Ard Biesheuvel <ardb@google.com>
Subject: Re: [PATCH] arm: mediatek: fix secondary CPU boot on Thumb-2 kernels
 with Clang
Message-ID: <amHYO1c-5vzqSekt@buffalo-ssd>
References: <20260722172443.534251-1-akkun11.open@gmail.com>
 <CAKwvOdnbPKoTy72EvfpKtT9Ne-r+O0j99KFX8OvjGk8ZxsuEGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnbPKoTy72EvfpKtT9Ne-r+O0j99KFX8OvjGk8ZxsuEGw@mail.gmail.com>

Hi Nick,

On Wed, Jul 22, 2026 at 02:03:31PM -0700, Nick Desaulniers wrote:
> On Wed, Jul 22, 2026 at 10:25 AM Akari Tsuyukusa <akkun11.open@gmail.com> wrote:
> >
> > When building with CONFIG_THUMB2_KERNEL=y and Clang, secondary CPUs
> 
> Specifically, was LLVM=1 or CC=clang or something else used?

I used ARCH=arm LLVM=1
config is here:
https://github.com/TeamYogaBlade2/linux/blob/d7633f01ec25209fc6cdde012128b19ac336ab18/arch/arm/configs/lenovo-blade_defconfig

> > secondary_startup_arm is ARM-mode code (.arm) and, on a Thumb-2 kernel,
> > expects to be entered in ARM mode in order to switch to Thumb via the
> > standard sequence at that label. Starting in Thumb mode causes the CPU
> > to execute ARM instructions as Thumb, resulting in an immediate crash.
> >
> > Clear bit 0 of the entry address so the CPU always starts in ARM mode.
> 
> Thanks for the patch. Any idea why this isn't an issue for
> GCC+GAS+BFD? Perhaps there's a difference in the LLVM tools that we
> need to address?
> 
> There's definitely some difference between clang and GAS here.
> https://github.com/llvm/llvm-project/issues/211376
> 
> I wonder if perhaps a better machine-agnostic assembler-agnostic
> assembler-version-agnostic patch would be something like:
> 
> ```
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index f22c50d4bd41..687ee7063a73 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -383,6 +383,7 @@ ENDPROC(__create_page_tables)
>  ENTRY(secondary_startup_arm)
>   THUMB(        badr    r9, 1f          )       @ Kernel is entered in ARM.
>   THUMB(        bx      r9              )       @ If this is a Thumb-2 kernel,
> +ENDPROC(secondary_startup_arm)
>   THUMB(        .thumb                  )       @ switch to Thumb now.
>   THUMB(1:                      )
>  ENTRY(secondary_startup)
> @@ -429,7 +430,6 @@ ARM_BE8(eor r4, r4, r5)                     @
> without using a temp reg.
>                                                 @ (return control reg)
>         ret     r12
>  ENDPROC(secondary_startup)
> -ENDPROC(secondary_startup_arm)
> 
>  ENTRY(__secondary_switched)
>  #if defined(CONFIG_VMAP_STACK) && !defined(CONFIG_ARM_LPAE)
> 
> ```
> 
> Can you perhaps help test/verify that Akari?

I tested your suggested patch and confirmed that it fixes the issue.

Device: Lenovo YOGA Tablet 10 (Wi-Fi) (MT8125)
Toolchain: Clang/LLVM 22.1.8-2 (cachyos-v3)

Tested-by: Akari Tsuyukusa <akkun11.open@gmail.com>

Can you send your fix as PATCH?
I think your approach is better than mine.

Best Regards,
Akari
