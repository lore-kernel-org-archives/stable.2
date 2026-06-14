Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E231E83E
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438342; cv=none; b=ks6VynPHadVIeN9f2iEORJZRh/BKf0lNz5aoby/RDH2Tq62Yha/XQd23EhiOMvzhue+tfPsY6nNmY14tTcv0xXbA11JPkOeqILw2YQi6NtKcFlB4u6yZ1++rPtEu84YtXtAc4Us4WE2oC5eFS9cWRTSWqeDC4iiVic63zBvKXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438342; c=relaxed/simple;
	bh=zTZl0e0yVWVcYo5BuaNiFPRWvG+d9puULyPrTvQy33A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqJulpLGyzjKPmsR6g1crafZvBa66mJTykqPRidmkcjVPDAGuA3dJLPLuPId678qIXzX62JOcv967CDtN1rMQm/bhPq95nSs658lp7VFSivrYa3Sn3wyCsPFHfUHvpRFym5xB3Ig5MRJBBR90wBsWwUTXdKjsTEUetmHO5EXYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKWYqvsn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKWYqvsn"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so1933878f8f.0
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781438339; x=1782043139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSovo2PZqoPUZzCz7TwsyL7/LMkogfDdhMF3mspVec8=;
        b=BKWYqvsnEBTCMu/EDkWqIDaUHB3lEjnxO01iZG5NQTVYbm6XykZLJlVwjjgqWNDEqC
         pU40foGahLk+1qi/Qv1H2VuMcKrgAhzCroCPw7ch/Bp+JRHzmXxZ71rDqT6PkEoGQUK1
         jSjLxgWWg0a433qSlZNKEYvp64uTk7EvK+VKc+xKwGgEsOwvdf+QgODH1jCmLGnBlVIn
         /8tOljLOJ9c4y7qORdXoVqzAMn7z7XncLDlqhfz3Oz5xE+aw7bya32blH6/DFRvcICCP
         83B/AIVuukEOKVH7mPyj+GEouOC2hNf7nJx7QwS86cMuHrMqd51yHQ2QqDmCZ36Sd+aV
         J9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781438339; x=1782043139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eSovo2PZqoPUZzCz7TwsyL7/LMkogfDdhMF3mspVec8=;
        b=ju8PVUk1k3/3S3r6b4YZp9BF6KKWBY6HlQ/BAmMoWD7FEKz7ynTRqPPxQGOZGNscYC
         EhRn5Y2Mo+CQ9l3IODbyy/P2cTFNNPXQFrv+ThmwBDRDhTwMKJPljcvvV9NlK9W/zpXl
         SqLZ6/sTpe50zO0Iz9ksd6niPh5mjMpeK+evVS2r+m1pK6qFgKMnJzBGqP1D0VTBIfbo
         s+MKefUC5oFFtoQGmdoFgZffHA2oneNI3PQaC6NT+qHITqdSLy2S4yVvGdguOdT4Ugvy
         sDX/OCMx9rtANiJnN7IYebgPmQDlAi10ElHyPWhM/XlnH9CXNEfo66/JVhkRju1CsnrZ
         sXng==
X-Forwarded-Encrypted: i=1; AFNElJ/cMDpfkHvYmp9nvtk9MgChE5i6UuSzTY4bN8tBxk9VwUmf/XDykC/lILn7TMx4LO1xyOdOkH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHfmThKB/cT7JKDrKl+VR6W/pTJuMZ0hWJ0pk+xXVjbe5PkKK
	HMOr+B/K7CYER9x7sRcm6tYMvr2QIqItvo+Emp4UQQyPsm1E32vx3guw
X-Gm-Gg: Acq92OGT/wKy+u9oRcjZe9ZjSRw/pqghGJeXl+/kqmmWqcxfbKQv5FMwhzQAzlnKcXX
	HXxe/xj9elYMCKbGYLN845sXKwyuKs+9XhxWdjltGKISj/EJOIFA+vDu2LAwSuRharke/GUtkzi
	hDWmWvmyKgIy2NWU0aPfipEKo4IDuFj+XME9g7tyMp41LUqPN9QFKyapBuXHtlUj3mixTTzHGFj
	QuP+Anln3A/o9lUHVMTMnqWQi+JNhfmPEIOVUB/Wi6hm6eBbQlQxuE9q96zU0840b1mr8BDSjAn
	mVAXU8d50DadX2FaPwWnlY4FfoVCmCHHYR9IHJWosPoTy892w6FLB21iC9quUf+J+mbS2rdGih2
	PHSH/b+FPppwZ+okESjEus7QssJ0PbMwWplC0GpsLZD9npWX/qSPxGJR00GWKGT6gEX4wqrJvKu
	2NzinQglQoGpDTSSy9xNsEW6Nhcwx46wQHyqW2MMmXgsQZed/aeLxBM4E4NZmJ
X-Received: by 2002:a05:6000:4912:b0:45e:de0a:1773 with SMTP id ffacd0b85a97d-4606dbf15b7mr14210900f8f.33.1781438339050;
        Sun, 14 Jun 2026 04:58:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c35sm24759410f8f.22.2026.06.14.04.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 04:58:58 -0700 (PDT)
Date: Sun, 14 Jun 2026 12:58:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Shubham Bansal <illusionist.neo@gmail.com>, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH] ARM: disable broken eBPF JIT on the Risc PC
Message-ID: <20260614125857.398a0e13@pumpkin>
In-Reply-To: <20260518014920.135011-1-enelsonmoore@gmail.com>
References: <20260518014920.135011-1-enelsonmoore@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 18:49:17 -0700
Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:

> The eBPF JIT unconditionally generates ldrh/strh instructions, which do
> not function correctly on the Risc PC because its bus is unable to
> signal half-word accesses. Work around this issue by disabling the eBPF
> JIT when building for ARMv3 (the Risc PC is the only currently
> supported ARMv3 machine).

Isn't it more the case that the ldrh/strh instructions were added for armv4.
Whether the bus supports 16bit accesses is entirely different.

I'm guessing that WRITE_ONCE() gets implemented as two 8-bit writes and
the code 'just hopes' than an ISR won't care and won't do an update.

	David

> 
> Fixes: 39c13c204bb1 ("arm: eBPF JIT compiler")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1155c78bb6aa..8185d013e5d1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -98,7 +98,7 @@ config ARM
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
>  	select HAVE_ARM_SMCCC if CPU_V7
> -	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
> +	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32 && !CPU_32v3
>  	select HAVE_CONTEXT_TRACKING_USER
>  	select HAVE_C_RECORDMCOUNT
>  	select HAVE_BUILDTIME_MCOUNT_SORT

