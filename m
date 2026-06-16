Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8D3D8100
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635626; cv=none; b=TncQ/n3k8guLoLkITEF0nIH9MpDI4H8akuZYEPPcW68k6yGHXjtWyCymWayy8uuiZYjmJGx4PAtzNcREZoI4TMDN9rchIi+p9uO0hEmVPEpkIvkg9e4y11dHSJEqkTvCDc6M54daHUiNpOm5dJF9T8XgmNOaZD6zFjbN7C0JNUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635626; c=relaxed/simple;
	bh=3AzmI+4Q7+tONL6kIXtkiDxI7XitrFMxcRr1/VYdVGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=AoCYSFhcGysL5C04wN3g7xlq1iQV88oZni6TWGG8MjkwmD7c4Y7MpX+ZbAs0uh7PCOGoRAV9HPtdgQTe39p0fSZEaJIqrnizHh0RY/AhyIlNWZklLX9Epm+hPg2hUTE+19lALF6mMs6twkhD170sppONfRba3cEJxCiRWxbWDe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hFxQJFtC; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hFxQJFtC"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260616184703euoutp02d5d8662b6297e2471a9f538fd445404b~5pCjo2OW60536305363euoutp02T
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 18:47:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260616184703euoutp02d5d8662b6297e2471a9f538fd445404b~5pCjo2OW60536305363euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781635623;
	bh=mvxr+YdRaTcsisprdpJ6A8/pWU0uio2R93neXK8BV/8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hFxQJFtCCBoqc0pLMUVINC+qqWE0O1y1n0Eqe/a6fZHy5BDrPPEdX3TNSI9cyhdSx
	 usf9KgIhuaRLrIee6u1ahESvrindeKb32op2Qpw5b9oJC9LicXguAEniKAXsxscOQo
	 ZOAwIevn9VnTp2+ZTXYflenUF69EpBhuEYFIwcpQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260616184701eucas1p13c7aff447073832095aa4adfb85935f0~5pCicfvXY2784127841eucas1p1Y;
	Tue, 16 Jun 2026 18:47:01 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260616184701eusmtip2a24a9cb697312a1889ad0adb462bf4e1~5pCh_3sVn2758327583eusmtip2n;
	Tue, 16 Jun 2026 18:47:01 +0000 (GMT)
Message-ID: <813164f9-d036-4858-80ad-f3af9bee9c77@samsung.com>
Date: Tue, 16 Jun 2026 20:47:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [tip: timers/core] time/jiffies: Register jiffies clocksource
 before usage
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: Teddy Astie <teddy.astie@vates.tech>, Thomas Gleixner <tglx@kernel.org>,
	stable@vger.kernel.org, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <178135728754.1650852.1266320590541376793.tip-bot2@tip-bot2>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260616184701eucas1p13c7aff447073832095aa4adfb85935f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260616184701eucas1p13c7aff447073832095aa4adfb85935f0
X-EPHeader: CA
X-CMS-RootMailID: 20260616184701eucas1p13c7aff447073832095aa4adfb85935f0
References: <87y0gn3fve.ffs@fw13>
	<178135728754.1650852.1266320590541376793.tip-bot2@tip-bot2>
	<CGME20260616184701eucas1p13c7aff447073832095aa4adfb85935f0@eucas1p1.samsung.com>

Dear All,

On 13.06.2026 15:28, tip-bot2 for Thomas Gleixner wrote:
> The following commit has been merged into the timers/core branch of tip:
>
> Commit-ID:     f24df84cbe05e4471c04ac4b921fc0340bbc7752
> Gitweb:        https://git.kernel.org/tip/f24df84cbe05e4471c04ac4b921fc0340bbc7752
> Author:        Thomas Gleixner <tglx@kernel.org>
> AuthorDate:    Tue, 09 Jun 2026 17:14:45 +02:00
> Committer:     Thomas Gleixner <tglx@kernel.org>
> CommitterDate: Sat, 13 Jun 2026 15:22:40 +02:00
>
> time/jiffies: Register jiffies clocksource before usage
>
> Teddy reported that a XEN HVM has a long boot delay, which was bisected to
> the recent enhancements to the negative motion detection. It turned out
> that the jiffies clocksource is used in early boot before it is registered,
> which leaves the max_delta_raw field at zero. That causes the read out to
> be clamped to the max delta of 0, which means time is not making progress.
>
> Cure it by ensuring that it is initialized before its first usage in
> timekeeping_init().
>
> Fixes: 76031d9536a0 ("clocksource: Make negative motion detection more robust")
> Reported-by: Teddy Astie <teddy.astie@vates.tech>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Tested-by: Teddy Astie <teddy.astie@vates.tech>
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/87y0gn3fve.ffs@fw13
> Closes: https://lore.kernel.org/all/1780914594.8631fc262581453bbf619ec5b2062170.19ea6c8227b000701b@vates.tech
This patch landed recently in linux-next as commit f24df84cbe05 ("time/jiffies:
Register jiffies clocksource before usage"). In my tests I found that it triggers
the following warning on Qualcomm Robotics RB5 board
(arch/arm64/boot/dts/qcom/qrb5165-rb5.dts):

clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns

=============================
[ BUG: Invalid wait context ]
7.1.0-rc1+ #16790 Not tainted
-----------------------------
swapper/0/0 is trying to lock:
ffffb0d1364d1270 (clocksource_mutex){....}-{4:4}, at: __clocksource_register_scale+0x204/0x3e8
other info that might help us debug this:
context-{5:5}
1 lock held by swapper/0/0:
 #0: ffffb0d1376855f0 (&tkd->lock){....}-{2:2}, at: timekeeping_init+0x13c/0x21c
stack backtrace:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.1.0-rc1+ #16790 PREEMPT
Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
Call trace:
 show_stack+0x18/0x24 (C)
 dump_stack_lvl+0x90/0xd0
 dump_stack+0x18/0x24
 __lock_acquire+0xa48/0x225c
 lock_acquire+0x1c4/0x3f0
 __mutex_lock+0xa8/0x8e4
 mutex_lock_nested+0x24/0x30
 __clocksource_register_scale+0x204/0x3e8
 clocksource_default_clock+0x48/0x64
 timekeeping_init+0x148/0x21c
 start_kernel+0x4c8/0x8dc
 __primary_switched+0x88/0x90
arch_timer: cp15 timer running at 19.20MHz (virt).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns


Reverting $subject on top of linux-next fixes this issue.


> ---
>  kernel/time/jiffies.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> index 1c954f3..d514288 100644
> --- a/kernel/time/jiffies.c
> +++ b/kernel/time/jiffies.c
> @@ -60,15 +60,14 @@ EXPORT_SYMBOL(get_jiffies_64);
>  
>  EXPORT_SYMBOL(jiffies);
>  
> -static int __init init_jiffies_clocksource(void)
> -{
> -	return __clocksource_register(&clocksource_jiffies);
> -}
> -
> -core_initcall(init_jiffies_clocksource);
> +static bool cs_jiffies_registered __initdata;
>  
>  struct clocksource * __init __weak clocksource_default_clock(void)
>  {
> +	if (!cs_jiffies_registered) {
> +		__clocksource_register(&clocksource_jiffies);
> +		cs_jiffies_registered = true;
> +	}
>  	return &clocksource_jiffies;
>  }
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

