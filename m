Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9A39479C;
	Thu, 17 Sep 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635106; cv=none; b=iBlQiHLyJqCu0MkPvdpeB5GmqXYCFstH8Hjb/lSbYLo/5hIypnQDVp08/pNxlcpU4Ox0HfkTJ+eBy4GztLoRdWtZwoArwYS1XxYerdQ9fgboloXrihH4v0DBFcNVVVFdIbRHsd7Yw32JzRVdcv8YlbgreRHCTVyVOYt9KvD11G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635106; c=relaxed/simple;
	bh=d1o7qfb40X4omjhsolZFB7mf29Q53A+4b78/bqfTq4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhI/7yTHtwjqbDlwBEbbNrEkksYAwlmE+AkO9T886uiQlIMfPjVPj9SyT2SO2dRp3fUkQFWJDGZcqsXmjT7FKcab8S1j8bi6fE4p9/j+9IX1KTNJShWxqhFcOeerxgasXaRCGpMMMHLRy7cAa23niC8IO9wDtudttQns6R+MtuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eXD2Xq2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eXD2Xq2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8B41F000FF;
	Thu, 17 Sep 2026 08:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789635099;
	bh=bLPzNdH/e2aiM5uLRu+9nan5ENmrqmsmiYaJuDfZNpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eXD2Xq2J77CAFqPq+F6Rv1oKL6MSY1Bg4y7CU6rPmPwFnIUHuz9A9+Mv/6dlZliT1
	 Ms0AmCuS2LWNoTqwwfTeEujmXbHfIEjUNBx1VH6MoAIxiShxuoFHjWNdEWEOh2cdvW
	 C49PCzH1WVsXLvoQ2Rzdjqr44s3gi+H0kQUuHDf0=
Date: Thu, 17 Sep 2026 09:49:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philippe Schenker <philippe.schenker@impulsing.ch>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] rtc: cmos: Use platform_get_irq_optional() in
 cmos_platform_probe()
Message-ID: <2026091732-postage-lunacy-fb5e@gregkh>
References: <12857714.O9o76ZdvQC@rafael.j.wysocki>
 <d35e7730006ac5a2ccaa08092201994afea668cb.camel@impulsing.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d35e7730006ac5a2ccaa08092201994afea668cb.camel@impulsing.ch>

On Thu, Sep 17, 2026 at 08:26:10AM +0000, Philippe Schenker wrote:
> Hi,
> 
> this patch did not carry a Cc: stable tag, but the platform device
> binding changes it fixes have meanwhile been backported to 6.18.y
> (6.18.51), including:
> 
>   ACPI: x86/rtc-cmos: Use platform device for driver binding
> 
> This fix was not backported with it, so 6.18.51 is now affected by
> exactly the problem Nathan reported in
> 
> https://lore.kernel.org/linux-acpi/20260303060752.GA2749263@ax162/
> 
> On my HP ProBook 445 G8 (AMD) the boot log changed as follows:
> 
> 6.18.49 (good):
>   rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
> 
> 6.18.51 (bad):
>   rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found
>   rtc_cmos PNP0B00:00: no alarms, y3k, 114 bytes nvram
> 
> On stable this is more than a confusing message. Without an IRQ the
> RTC has no alarm support, so CLOCK_BOOTTIME_ALARM is not available
> and systemd (261) refuses suspend-then-hibernate:
> 
>   systemd-logind: CLOCK_BOOTTIME_ALARM is not supported, can't
>   perform suspend-then-hibernate.
>   Call to SuspendThenHibernate failed: Sleep verb
>   'suspend-then-hibernate' is not configured or configuration is
>   not supported by kernel
> 
> Plain suspend and hibernate still work. RTC wake alarms are also
> broken:
> 
>   # rtcwake -m no -s 120
>   rtcwake: set rtc wake alarm failed: Invalid argument
> 
> The fix is in mainline since v7.0 as:
> 
>   e9f850ba66cd ("rtc: cmos: Use platform_get_irq_optional() in cmos_platform_probe()")
> 
> Stable team, could you please queue it for 6.18.y? Any other stable
> series that received the rtc-cmos platform device binding backport
> would need it as well.

It's already queued up, thanks.

greg k-h
