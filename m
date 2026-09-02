Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A754A92D5;
	Wed,  2 Sep 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363363; cv=none; b=bbbftC2dfuM7KHUTNCxmj40oki8kAFacwe+FhIkH7UHuAMNRk7AiIJoeLgB0GDUrzYkJZbb5CSa2DWUZcBR43AoaTmygS29j+uNrMu5RiB7a3Fgp/wrvqKkGlvOGkSFqb/+T+72RboITdYEIArT3C4m+IT+eUyrIfmQP/Xi7a1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363363; c=relaxed/simple;
	bh=KWvIY17kQ7szE90LqQchJtV008eQeRXMyidVdT2Ef2I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MF5Hf666YMBpWbBHnwzDEEsqUIqM/tc4rZ0nDwDZRL9it7Yw+Yph1sUuBLL+ENaWtXw9NDHV2doEDTL6qk8yeqpK8u4hNHq9SNQleJ4cMhSfCTgB4oaywvAa2qAn9fWqesup3HDqRyzYFeiodHIVmT305mYOoDmAc/LyYBZnkqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR4KRVs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR4KRVs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC701F00A3A;
	Wed,  2 Sep 2026 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788363357;
	bh=RAivHFEws+oS2h15x1l023/v5gwjAGImwIJyV0LBvO4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aR4KRVs0tUtlKreTRSdJrT3q7UYJj5sc6o+2ltsHbcjrw1bxX6Qqqz76I57JuP71r
	 d92fJ08R2c/gASXDxPpgAG8H68DYL2GnvatXj+O6Aic4TyKIxO7p/BQA+klITO/+EB
	 Cqs+lWRrFI4tjhbaYf5hHW+DA1m8NH+45ZOyw2IXwghspaX0lctaO1CiMd4X3yRdOb
	 gXH3lpF4Ya2jfaOvDb6YqRNshRVo8BQ8jRVvQQpnKTBHPqcw6NYW16GFFx4p1Ed8SN
	 lOe8aCTdSYEt57JzDqRs6AzczDx0xBVu4Su5oXB8rtmgjf2iagqWfhtUPDuMHSOz1m
	 /Rz/HRACUye8g==
Subject: Re: [net] net: macb: initialize PTP lock before registering clock
From: netdev-bot+sashiko@kernel.org
To: runyu.xiao@seu.edu.cn
Cc: nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org,
 kuba@kernel.org
Date: Wed, 02 Sep 2026 15:35:56 +0000
Message-ID: <178836335694.3394541.317937628559896432@kernel.org>
In-Reply-To: <20260830153520.2710520-1-runyu.xiao@seu.edu.cn>
References: <20260830153520.2710520-1-runyu.xiao@seu.edu.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 0 · Low: 0

- [High] Incomplete fix: gem_ptp_init()
  (drivers/net/ethernet/cadence/macb_ptp.c:327) still calls…
- [High] bp->tsu_clk_lock is initialized in exactly one place,
  gem_ptp_init() (drivers/net/ethernet/cadence/macb_ptp.c:333 after this…

--

net: macb: initialize PTP lock before registering clock

The patch moves spin_lock_init(&bp->tsu_clk_lock) in gem_ptp_init() from
after ptp_clock_register() to before it, on the grounds that PTP callbacks
become reachable from userspace as soon as the clock is registered. The
lock is otherwise not initialized anywhere else in the driver.

> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
> index e5195d7dac1d..055160c42db3 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -330,6 +330,8 @@ void gem_ptp_init(struct net_device *netdev)
>  
>  	bp->ptp_clock_info = gem_ptp_caps_template;
>  
> +	spin_lock_init(&bp->tsu_clk_lock);
> +

[Severity: High]
This is the only spin_lock_init() for bp->tsu_clk_lock in
drivers/net/ethernet/cadence/, and gem_ptp_init() runs on every interface
open and every resume rather than once at probe. Can that re-initialize the
lock while a softirq on another CPU holds it?

Both call sites start the datapath before calling ptp_init():

drivers/net/ethernet/cadence/macb_main.c:macb_open() {
	...
	err = macb_phylink_connect(bp);
	if (err)
		goto phy_off;

	netif_tx_start_all_queues(netdev);

	if (bp->ptp_info)
		bp->ptp_info->ptp_init(netdev);
	...
}

drivers/net/ethernet/cadence/macb_main.c:macb_resume() {
	...
	phylink_start(bp->phylink);
	rtnl_unlock();

	netif_device_attach(netdev);
	if (bp->ptp_info)
		bp->ptp_info->ptp_init(netdev);
	...
}

The receive and transmit completion paths take the same lock, gated only on
bp->tstamp_config, which is never reset by macb_close() or gem_ptp_remove():

drivers/net/ethernet/cadence/macb.h:gem_ptp_do_rxstamp() {
	if (bp->tstamp_config.rx_filter == TSTAMP_DISABLED)
		return;

	gem_ptp_rxstamp(bp, skb, desc);
}

which reaches gem_hw_timestamp() -> gem_tsu_get_time():

	spin_lock_irqsave(&bp->tsu_clk_lock, flags);

So after userspace enables timestamping via gem_set_hwtst(), an ifdown/ifup
or a suspend/resume re-runs spin_lock_init() on a lock that a NAPI/softirq
context can be holding or contending. Does that break mutual exclusion over
the TN/TSL/TSH read sequence, and reset the lockdep class (or, on PREEMPT_RT,
the rt_mutex owner and waiter state) of a held lock?

Would initializing bp->tsu_clk_lock once at probe time, next to the other
spin_lock_init() calls in macb_init(), be a better fit than moving it a few
statements earlier inside gem_ptp_init()?

>  	/* nominal frequency and maximum adjustment in ppb */
>  	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
>  	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();

[ ... ]

> @@ -345,8 +347,6 @@ void gem_ptp_init(struct net_device *netdev)
>  		return;
>  	}
>  
> -	spin_lock_init(&bp->tsu_clk_lock);
> -
>  	gem_ptp_init_tsu(bp);

[Severity: High]
The changelog says "ptp_clock_register() publishes the PTP character device,
so a userspace operation can enter a PTP callback as soon as registration
completes". If that is the premise, does moving only spin_lock_init() close
the window, given that gem_ptp_init_tsu() still programs the hardware after
ptp_clock_register() has returned?

In drivers/ptp/ptp_clock.c, ptp_clock_register() calls
posix_clock_register(&ptp->clock, &ptp->dev), which adds the cdev, so
/dev/ptpN exists before the driver has touched the TSU registers. In that
interval gettimex64/settime64/adjfine/adjtime are all callable.

Two effects seem possible in that window. First, the increment registers can
still be zero, because the close/suspend path halts the counter:

drivers/net/ethernet/cadence/macb_ptp.c:gem_ptp_clear_timer() {
	bp->tsu_incr.sub_ns = 0;
	bp->tsu_incr.ns = 0;

	gem_writel(bp, TISUBN, GEM_BF(SUBNSINCR, 0));
	gem_writel(bp, TI, GEM_BF(NSINCR, 0));
	gem_writel(bp, TA, 0);
}

so on a re-open, does gem_tsu_get_time() hand a frozen counter value back to
userspace as a valid timestamp?

Second, anything userspace sets in that window is overwritten a moment later:

drivers/net/ethernet/cadence/macb_ptp.c:gem_ptp_init_tsu() {
	ts = ns_to_timespec64(ktime_to_ns(ktime_get_real()));
	gem_tsu_set_time(&bp->ptp_clock_info, &ts);
	gem_tsu_incr_set(bp, &bp->tsu_incr);
	gem_writel(bp, TA, 0);
}

Does a settime64/adjfine/adjtime accepted between registration and this call
get silently discarded?

Also, the trailing gem_writel(bp, TA, 0) here is issued without
bp->tsu_clk_lock, while gem_tsu_set_time() notes its own sequence is not
atomic:

	/* TSH doesn't latch the time and no atomicity! */
	gem_writel(bp, TN, 0); /* clear to avoid overflow */
	gem_writel(bp, TSH, sech);

Can that unlocked TA write land inside a concurrent gem_tsu_set_time()
critical section?

Since gem_ptp_init_timer() and gem_ptp_init_tsu() do not need a live
bp->ptp_clock (gem_tsu_set_time() and gem_tsu_incr_set() only reach bp
through bp->ptp_clock_info via container_of), could ptp_clock_register() be
made the last statement of gem_ptp_init() instead? That would also make
hoisting spin_lock_init() unnecessary.

>  
>  	dev_info(&bp->pdev->dev, "%s ptp clock registered.\n",

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260830153520.2710520-1-runyu.xiao%40seu.edu.cn
