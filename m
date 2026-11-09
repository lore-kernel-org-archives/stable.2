Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265802;
	b=HNwuNGi6P9T3akfwAp5TEBTDDlTLDA/Lo5M6oZHihF7PTAwnxAk7x+HYUlp/4R6iHL0N
	 3xtbh2AWWmJOaXe6WiiAU8WuD8Da/FnzskpGRP8TeqhF34t8qHeNu5iOFgDLTZqUiBIJw
	 4rh4EfBGi+ueLGuJpLXPIzI5vNSsR6EnE5LoNOsHso6QBM65gafXzYH+z8UtRaJ4NOTlh
	 Y3h6OzubrHWVxW8amDW9W0iVx4VqEyOonT4wo9fpnEDrtOwxGAIxKkVm+3tReX3mhAa+L
	 tYhp/EsSEixYjvdVh5aRLR1ejvy4Le+XheuY+E/SQcpcLyUFqJPv+0AAC+4zyVfxu3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265802;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=6+kzbC8NY48LGIWA5cXEEQo3ig6iDfaSEJx3zcs0cjU=;
	b=r98gjwpkvl4s44L1koQk09hjluG2a1kM81JOC4Q24cN91kBB5W5wNtUPbU0fgZjs0KNT
	 52WRHP4uj6og20whmO/EdOdR2lFGEzYyGx7QAm2pomQ/shHfmfsZZv6Fd2M0s0HwbFYFr
	 pll2cQhjMtv8cW4mxl7C6AZQezr0z0sFJA34xjRxO1pwIUHM4Va6Eat89zf+Oli4xWVeV
	 arV6gXlCqH4ymQiOIGhseK73c/gReRKxCZeGWuMsKqgaHKUxJldGEeHYLOUSJ83M4qmN4
	 Wjvm78wLCq8ferG28bOb42wTk8/Y2vCXhe6diHXJ4ewSVPMrmdZF00haydWMw0v4bQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=RjhQxviY;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8F3606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 23:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C8F3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=RjhQxviY
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id QXuoxrBObRiNxQYUzxOBrw; Mon, 09 Nov 2026 23:10:01 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id QYUyx3c773nNNQYUzx2rm3; Mon, 09 Nov 2026 23:10:01 +0000
X-Authority-Analysis: v=2.4 cv=TuLmhCXh c=1 sm=1 tr=0 ts=6af252c9
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=gu6fZOg2AAAA:8
 a=VwQbUJbxAAAA:8 a=R5C9hjxsAAAA:8 a=F3YKiNpd_WCGsebJcZcA:9 a=CjuIK1q_8ugA:10
 a=-FEs8UIgK8oA:10 a=O8hF6Hzn-FEA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6+kzbC8NY48LGIWA5cXEEQo3ig6iDfaSEJx3zcs0cjU=; b=RjhQxviYsdBU9ZRKWCxfSoDY9c
	v9lXkQZWmDv/bYejN314/dIb2MNG1KLm8Of5IVuda7vj5idaSEiM0ErcBCrByVWG2TTPgn7Il5JHv
	8sf3BDyTxDB1fxYS/2DrzrgjiL9+rx1AzJrYF6qFaRl4Wv9GupE8fZEGuwiumiT9uHlSYmwKmyO7E
	9bRWyAFWpkkoYJiyHf2/bRUPlDM7B4l9O3LKiUYSokicmhu7Zr6CR1ocm5A5u3Jxd2TJBpmdR8ZfG
	n0fuzY7Wvjq611n/OpcfjRClUxmV5EOsrz+rKg/o8i3pVHB9luTB9K1Bbrc1dwDIapgWLUWX/lQJT
	o11tDuoQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:39438 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xQYUy-00000000qO0-1y61;
	Tue, 10 Nov 2026 04:40:00 +0530
Date: Mon, 9 Nov 2026 15:09:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: npcm: fix clock prepare leak when setting
 timeout on a running watchdog
Message-ID: <19258f94-ec01-48f4-9d04-22e5ecb5cac2@roeck-us.net>
References: <20261109071004.1506-1-zhaofeng2@cmss.chinamobile.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109071004.1506-1-zhaofeng2@cmss.chinamobile.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xQYUy-00000000qO0-1y61
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:39438
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 14
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNNMMdZXjJVMlHb9Ktpolru6dZ8R6vLcY6qEE6LcIlNN4XHrYDVUcCGimAzBubzeF+wfedrd3PgGAOvEGk9T3pKZ1FTYJyFUX6e/ffS+OcLIFwqYDyCw
 GE/DZYMl167TGEWS3x/MvVki1w8xyGpOBf7e1RAli6s4VY2FIxmdAPOPgObqyxHoZatGKLG5GJkP9zT37LswJkREG2S9LxauG/eGZX/++wBmRNN4k8zNws9v

On Mon, Nov 09, 2026 at 03:10:03PM +0800, Zhao Feng wrote:
> npcm_wdt_start() unconditionally prepares and enables the watchdog
> clock, and npcm_wdt_stop() is the only place that disables it.
> npcm_wdt_set_timeout() calls npcm_wdt_start() again whenever the
> watchdog is already active, so every WDIOC_SETTIMEOUT ioctl issued
> while the watchdog is running takes one extra clock prepare/enable
> reference that is never dropped.
> 
> Split the register programming out of npcm_wdt_start() into a
> __npcm_wdt_start() helper that assumes the clock is already running,
> and call the helper from npcm_wdt_set_timeout() instead; only the
> watchdog .start callback (and the restart path, which intentionally
> keeps the clock) now acquires the clock.
> 
> Fixes: af084fdccfaf ("watchdog: npcm: Enable clock if provided")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

Applied.

Couple of notes:

The problem reported by Sashiko seems real, but I have any idea how to fix
it, and it is unrelated to this patch.

The error propagation patch has a number of issues (as reported by Sashiko)
and will have to be resubmitted anyway. When thet is done it will have
to be rebased to this patch.

Thanks,
Guenter

> ---
> Verified against current upstream master.  Not runtime-tested (no
> Nuvoton NPCM hardware).
> 
> Note: this overlaps textually with Triet Hoang's pending
> error-propagation patch
> (https://marc.info/?l=linux-kernel&m=178955112320092)
> but fixes a different bug; whichever lands second will need a
> trivial rebase.
> 
>  drivers/watchdog/npcm_wdt.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c
> @@ -148,10 +148,8 @@
> -static int npcm_wdt_start(struct watchdog_device *wdd)
> +static void __npcm_wdt_start(struct watchdog_device *wdd)
>  {
>  	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
>  	u32 val;
>  
> -	clk_prepare_enable(wdt->clk);
> -
>  	if (wdd->timeout < 2)
>  		val = 0x800;
>  	else if (wdd->timeout < 3)
> @@ -176,10 +174,19 @@
>  	val |= NPCM_WTRE | NPCM_WTE | NPCM_WTR | NPCM_WTIE;
>  
>  	writel(val, wdt->reg);
> -
> -	return 0;
>  }
>  
> +static int npcm_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
> +
> +	clk_prepare_enable(wdt->clk);
> +
> +	__npcm_wdt_start(wdd);
> +
> +	return 0;
> +}
> +
>  static int npcm_wdt_stop(struct watchdog_device *wdd)
>  {
>  	struct npcm_wdt *wdt = to_npcm_wdt(wdd);
> @@ -216,7 +223,7 @@
>  		wdd->timeout = 2750;
>  
>  	if (watchdog_active(wdd))
> -		npcm_wdt_start(wdd);
> +		__npcm_wdt_start(wdd);
>  
>  	return 0;
>  }
