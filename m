Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C130BB9B
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417688; cv=none; b=PV3KrjwUzqwF+Gi27Dx64g9VQI1anvwNVmUg/yYH6ToWg7jakjmMNpsxO1T4mHtZFz67koy47Q41Yh/gs55B/nLGgI+7UQObxen0QNxLfZbJ2LARY8u2yvscszkKQ0Y+RBtNWmUyvQWGRgErDbVz33ikw9OEFSmJfBTAJS6UQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417688; c=relaxed/simple;
	bh=mWxYAZnNip39N7Pj7swAw9HVXL3RZX01cdyIL1etZbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjtQM4H9yrUrDB8CFsgRbfpGrQ9bvNwfefxHwAafZnWBkZ8bROMRNF9D6T3ZujoZqEeuNAUYYZVXYOmOQ/IYrbFFRNDOqAcxltTsdeVGC7URXwgPGUFFK1UxFDY0wXIx5i9/sH8w/4UmUjGXDYsytW4WJnR/hJaEGgzs64Ono/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQHliZ3q; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQHliZ3q"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5ad53c8d4dfso129118e87.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782417685; x=1783022485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oc0QJv7T+PDjjn884M5deHXdXQm6jHjFwABbEHE38VA=;
        b=bQHliZ3q+CYQXT20KV1tGO8oqLrMBsLywiSNXf8mreQl575Va+0uwSN2zbCe8MQaKw
         9QlPMVJtkjbif79K2+APcXSh5E2nLc9+KnOC5G4Vuk8PDxqorb1L66IEQyT+CPy3DnGF
         x57S9DQkpnVjU6lwZdGm4+0KV6XHlbmEXpsU/8hxXw8D9dRHprj2q2GWzSa4K+hQBNOR
         J+oSvGiPfGzRucC8Cy0uOhCXkfEcRm2KlvAlzqoy1CxNMaNiRnEL6v39nUPTN35RGNHQ
         +8aGGyYUanWaeCXDXqjKJYULxwcJ98qCD1N4rRmsadYZ7yYvAmwTQLfyG+4U3lOOX/uI
         l4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782417685; x=1783022485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oc0QJv7T+PDjjn884M5deHXdXQm6jHjFwABbEHE38VA=;
        b=HkIh3oukwCmOmSM/tX5JP5a88/3lUxXLR4wB4+SZjrBJz1qu3T0ynNrKL0UCUwd3M0
         jfUq+1M4te3ApGBSniFV+so8sbDBD49mKS0w67c+p4dleXcu8/cTgwrYdAeLnHtnvfTp
         LcV0lGEAk2yzCbjBo2rXckdp+vd8wi7nKJzjz6TWrtu4d3WstljPRP/GLL4hw1efZFha
         Rig9uMshUW/VLmx40s8d3B6W4m5MCkKdInm38eiFKvT6xQ8ZpmFwpyJ/fLyOHpLXt0cJ
         4v5oKCrmECo3xO1MgrJyE5lVMwxhLaNNHGLkMSInflwQ8nyY5JBnkyroIMH6fLi4u9FQ
         qjbA==
X-Forwarded-Encrypted: i=1; AHgh+Rpf/CAgyH290bo5h483BcjS51sDJ4cZXJh5hu6JUm6kxjYevkR88ky8HQvABzgMMWXrE5Rt1FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRXRMBb5HnMUtMn0qMqznykObw4HlJdtA/8KItP7hKA2PWWNc
	jwpnS/OYq7TQ2iB0Pu2NwKT9BALBDmYB554RyMt4U8/8X+eTa4dtGLe8
X-Gm-Gg: AfdE7cky/OzQiHhIQNXwl6yogEmvqgM4Slhr7wciGUAfA4LcvDiZPtxHRwKIGem9JXX
	KNH1XzgMrlSX92gzHFkFquy5cjx01YslW8RXzM5kcZ5NcCgk74MfMwx1HgEWxWtflLuURFa4viz
	LJO0wtIgNPenKhVNfe8X38ESHc41UKRrmNcRTar8WoClVL21sRIHZ7BsOWgTAhV2wZjevnXIGUM
	f7RfQpg+2lHPbcI8yW1LmG/FAkL23LBnnv5eJkER3nNFRtBwwdp8TGgzSpW2UFyk2wd4mgpZ3qf
	IGm5/WkUvrANAegc/XKKK98Duqx+PID8vBC1p32itHitd/peqf46vzZ8lv/mBjo9mV4QrNWhURT
	M06ieY/8Zhm80fUOU/vQaHoEzMPPlbhoWjbIWHVTekyeJMRRq7XYkleOO6VXPbmeegHYKhPGcIV
	QHDMYGJUpNSuG8eR5YE/pLEoeT16Ck4OBC7zGbAxgeq5iW0sN8gQ==
X-Received: by 2002:a05:6512:2251:b0:5aa:65a3:468c with SMTP id 2adb3069b0e04-5aea1e246f6mr1149630e87.7.1782417684632;
        Thu, 25 Jun 2026 13:01:24 -0700 (PDT)
Received: from ik5070.localdomain (85-253-35-150.ip.elisa.ee. [85.253.35.150])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5ae9d8fb537sm1793554e87.21.2026.06.25.13.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 13:01:22 -0700 (PDT)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: felixonmars@archlinux.org
Cc: daniel.lezcano@kernel.org,
	tglx@kernel.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	stable@vger.kernel.org,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: Re: [PATCH] clocksource/drivers/timer-sun4i: Advertise a real minimum delta
Date: Thu, 25 Jun 2026 22:58:37 +0300
Message-ID: <20260625195837.882048-1-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624220434.4183732-1-felixonmars@archlinux.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Felix,

On Thu, 25 Jun 2026 06:04:34 +0800, Felix Yan wrote:
> sun4i_clkevt_next_event() compensates for the timer stop/start
> synchronization delay by programming evt - TIMER_SYNC_TICKS into the
> hardware interval register. The clockevent device currently advertises
> TIMER_SYNC_TICKS as min_delta_ticks, so the clockevents core is allowed
> to call set_next_event() with evt == TIMER_SYNC_TICKS.
>
> That programs a zero-tick interval. With oneshot/highres/nohz timer
> operation this can leave the next event stuck, which was observed as a
> boot hang on Allwinner D1 after the clockevents core started reusing
> forced minimum-delta events.
>
> Advertise one extra tick instead, so the smallest event accepted by the
> core still programs at least one hardware tick after the synchronization
> compensation.
>
> Fixes: 12e1480bcb49 ("clocksource: sun4i: Report the minimum tick that we can program")
> Cc: stable@vger.kernel.org
> Reported-by: Indrek Kruusa <indrek.kruusa@gmail.com>
> Closes: https://lore.kernel.org/linux-riscv/CA+fTLhgLmTY+exGujKf8OYYQvcEW5X5NJ_5sLq2AYL6zER2c0A@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Felix Yan <felixonmars@archlinux.org>
> ---
>  drivers/clocksource/timer-sun4i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
> index 7bdcc60ad43c..c2d04ab7cf2d 100644
> --- a/drivers/clocksource/timer-sun4i.c
> +++ b/drivers/clocksource/timer-sun4i.c
> @@ -208,7 +208,7 @@ static int __init sun4i_timer_init(struct device_node *node)
>  	sun4i_timer_clear_interrupt(timer_of_base(&to));
>  
>  	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> -					TIMER_SYNC_TICKS, 0xffffffff);
> +					TIMER_SYNC_TICKS + 1, 0xffffffff);
>  
>  	/* Enable timer0 interrupt */
>  	val = readl(timer_of_base(&to) + TIMER_IRQ_EN_REG);
> -- 
> 2.54.0

I can confirm that this patch makes my Allwinner D1 board boot
again with v7.1-rc1 and newer kernels.

Tested-by: Indrek Kruusa <indrek.kruusa@gmail.com>
Closes also: https://lore.kernel.org/regressions/20260531165138.2696250-1-indrek.kruusa@gmail.com/

Thank you,
Indrek
