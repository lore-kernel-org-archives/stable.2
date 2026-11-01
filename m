Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=154.81.10.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793529815;
	b=qTtQWfwsJx5asAuaOswGmJuFX+GL1rl8jy4BoLAL6bDPR5Fqko/vtQXelEfaBdlR2KRM
	 hVFQJRNHCiOMn7+hXRdqHkT3lANsSnmc90TPK5pW4whOYkWRZsVT1y/VzCjjqpw7fGkRp
	 SRLaGxTQ7id4QhWjmf9Z51B7QEmdEobOzQThDUQM2qivh92HaTXIYZYySzrNDfKnDx0MV
	 tYoDU632Voq9Y5HdYVCsf2Nyd3EvKAMZM8//kaCX+bSm0RLmd5kUqH4s3PYYyhpWSXtdP
	 6Ad6OU2iM0T/cB+UPqH4336rAH39SwH4763tDvu6A6uPLf+59hpioywSlks3R0w7xog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793529815;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=OK+xDHkQPOg6YuyKqEjrGSyrDiLl5NSDUDeHp0Cmiy4=;
	b=za6OpRyT/oAaZxMvFfnnEJCSoYH+E2flUWv10PT6Ky467uHrW50jsnKytFbRpbkEtGx/
	 PgufcxIiXqsDQ74y0zm4EgudnxvzhX8q2Qziwx90m5NXxEi3aaoj+DGUSsvP6HelMXxUe
	 2/rpO++pjfGTWACwMLaBNJ4jA4Bs9HlYvHOoU50SsRXHlkVwp1EvYcTF0yAEeo8qnTyUX
	 +DGmt4k/e0nEIQxrbeYBhyUzV6ZpfSlcTzxJvozenn4Wq666zlWuR/jxoZSB7oKCoOq11
	 vQwg57FZSoKyTT6d1bz2xNQnaxihGhZd4A4zQbWSAgE4Dv5yT4NyD5V5T3BZsYH21nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=UyCD41o+;
	arc=none smtp.remote-ip=154.81.10.72
Received: from mail-m1072.netease.com (mail-m1072.netease.com [154.81.10.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510B606A324;
	Sun,  1 Nov 2026 10:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4510B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=UyCD41o+
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53109de85;
	Sun, 1 Nov 2026 18:43:21 +0800 (GMT+08:00)
Message-ID: <e206aa41-fc3c-45fd-8653-b9a65cffe0ad@rock-chips.com>
Date: Sun, 1 Nov 2026 18:43:19 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RFC PATCH] mmc: dw_mmc: disable bh_work and stop timers on
 remove
To: BeaCox <0xbeac@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ulf Hansson <ulfh@kernel.org>
References: <20261101063719.88570-1-0xbeac@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261101063719.88570-1-0xbeac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa196b4e95903a4kunm0acf72a7347f05
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUwYVhhDHx1OT0hLT0NNHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UyCD41o+Vj7wwee3IvOJdDKeszUX3yKhp8mMu1V21zuOl6P9GFVyBdYNQzfK48Xy9FCU1Mgj63CsCCSxyOwY+5/26ERXbJ1jrZMzedlcv1A2jxnhdto7rVh+UgRPTWVrSrLEV2mDL+YEzvhlj4lXNxJrOU7EJ3BMmPoaswmsCp0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=OK+xDHkQPOg6YuyKqEjrGSyrDiLl5NSDUDeHp0Cmiy4=;
	h=date:mime-version:subject:message-id:from;



在 2026/11/01 星期日 14:37, BeaCox 写道:
> dw_mci_remove() does not drain bh_work before the driver core releases
> the devm-managed host. The interrupt handler, watchdog, fault-injection
> timer and DMA completion path can queue that work, whose callback
> accesses the host and MMC request state.
> 
> After removing the MMC host and masking controller interrupts, drain
> the interrupt handler and disable bh_work synchronously. Disabling the
> work also rejects later queue attempts, unlike cancellation alone.
> Stop both timers after the work callback has finished so that it cannot
> rearm a timer after teardown has cancelled it.
> 
> The analysis, patch and validation were assisted by OpenAI Codex.
> 
> Fixes: 921c87ba3893 ("mmc: Convert from tasklet to BH workqueue")

The patch itself looks correct to me.

But I checked 921c87ba3893, the pre-conversion dw_mci_remove() never
called tasklet_kill() either, so the deferred-callback race predates the
tasklet-to-BH-workqueue conversion. 921c87ba3893 only replaced
tasklet_schedule() with queue_work() and removed nothing, so it did not
introduce this. Moreover, wd_timer is introduced recently, so the patch
it not backportable.

> Cc: stable@vger.kernel.org
> Signed-off-by: BeaCox <0xbeac@gmail.com>
> ---
> Testing: x86_64 object build with gcc 13.3 and W=1, with
> CONFIG_FAULT_INJECTION enabled and disabled. A userspace model of the
> extracted remove function checks pending work and modeled late IRQ/timer
> queue attempts. It is an ordering check, not a kernel reproducer.
> 
> No matching hardware, kernel crash trace or demonstrated unprivileged
> trigger is available. Please review the MMC shutdown assumptions and
> external DMA callback lifetime. This is an RFC for a teardown fix; no
> privilege-escalation or CVE eligibility claim is made.
> 
>   drivers/mmc/host/dw_mmc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0b25d287..cc5e163ee7 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3406,6 +3406,12 @@ void dw_mci_remove(struct dw_mci *host)
>   	mci_writel(host, RINTSTS, 0xFFFFFFFF);
>   	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
>   
> +	synchronize_irq(host->irq);
> +	/* Stop the work before cancelling timers that it can rearm. */
> +	disable_work_sync(&host->bh_work);
> +	dw_mci_stop_fault_timer(host);
> +	hrtimer_cancel(&host->wd_timer);
> +
>   	/* disable clock to CIU */
>   	mci_writel(host, CLKENA, 0);
>   	mci_writel(host, CLKSRC, 0);
> 
> base-commit: cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a

