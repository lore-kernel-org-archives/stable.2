Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A941A902;
	Thu, 24 Sep 2026 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290029; cv=none; b=OliMebF8Far2QS5XjWN3oW1I8qUZiU07uAO3CpZ49e11fmynPGcKsD/Ku3+8jtLKiF0tNARzZSgfnCetp0L6ErwxJZ/xThyjvPJaV2rQSQQGXkYe8gjxHHpF6FOs0H5pysFqRm8LvkDegVDdBNaJNB9OYUU2MSK+ogmlzLFl9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290029; c=relaxed/simple;
	bh=3boL8lmiQnTY2vDHFbVvb6OzJjBJqYpeoXZfgPLNYmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYQPAIe2w73j9GdxWbM+H0QAJXcOPdpBgfZJPxIzcQaOVEEoFm1h0a9mVNVF240g5he9tv7fhktEOqML0UsJ5Zqgh3J/T8Zifzm7EjhyzfeUXvEcYYtiXZ1K4GIW8nAuAvTfIHyonAwZ2v0QTpBgUGAIQxKq65SHFJ3efGN9lEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=So8D3lIi; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="So8D3lIi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 57BF5C211F6;
	Thu, 24 Sep 2026 22:47:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 71F4C60738;
	Thu, 24 Sep 2026 22:47:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E6E5210329539;
	Fri, 25 Sep 2026 00:46:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790290018; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4vLnKVd7fUckhsJB6yUYdTvrC8vLjUQhIHZYzMS6+W4=;
	b=So8D3lIi8mQBRKlgSahDn9EPRM4TasG/JdVs5jqU4+YPZBRWqCL4r5EiseaeY9q2SLjuFu
	lig6lu0H6oGu+zKZ0MQ3nRhyRpA0gXJODN5OyFcqkwC3qHxdozthi8G7bJHEl+GFlmIRET
	QStdsf2sG24y0AcWR0DnGZvd+sJ/sw226tEMuqfVgy98v9B4lXmDBVuTGRc6WTICKnEYHd
	nZJ7lCeTJsxXJcJOHDMp4PhwbPA3L2ukjm248sQarxHE1Y+Dnu8SPXVSFia6U3UK4OKAfx
	wykAXQmVbSOzEmfEX/7T4SIOHiJFhT9/B+U3WJL4pXOzeNynqs1+2kelxy3cWQ==
Date: Fri, 25 Sep 2026 00:46:57 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Daniel =?iso-8859-1?Q?Via=F1o?= <danividanivi@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>, linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rtc: zynqmp: Enable crystal oscillator in initialization
Message-ID: <20260924224657b2d275e7@mail.local>
References: <20260924071917.80004-1-danividanivi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924071917.80004-1-danividanivi@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 24/09/2026 09:19:16+0200, Daniel Viaño wrote:
> Enable the RTC crystal oscillator bit in the control register (RTC_CTRL,
> offset 0x40) during driver initialization.
> 
> Although the RTC_OSC_EN macro was defined when the driver was originally
> introduced, it was never asserted in xlnx_init_rtc(). On cold boots, after
> battery exhaustion, or on platforms where firmware does not pre-initialize
> RTC_CTRL, the oscillator remains disabled and the counter never ticks.
> 
> Asserting RTC_OSC_EN alongside RTC_BATT_EN ensures the oscillator starts
> without relying on bootloader initialization. Per the Zynq UltraScale+
> TRM (UG1085), bit 24 (OSC_CNTRL) is a static level enable for the crystal
> inverter rather than an edge-triggered reset; re-asserting it when the
> oscillator is already running is a non-destructive no-op that does not
> glitch or reset the ticking counters.
> 
> Tested on Zynq UltraScale+ hardware, confirming that the counter freezes
> when RTC_OSC_EN is cleared, advances reliably once enabled, and is
> unaffected when re-asserted while running.
> 
> Fixes: 11143c19eb57 ("rtc: add xilinx zynqmp rtc driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
> ---
>  drivers/rtc/rtc-zynqmp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
> index 5bcb7536e973..278705ec09f5 100644
> --- a/drivers/rtc/rtc-zynqmp.c
> +++ b/drivers/rtc/rtc-zynqmp.c
> @@ -167,9 +167,12 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev)
>  {
>  	u32 rtc_ctrl;
>  
> -	/* Enable RTC switch to battery when VCC_PSAUX is not available */
> +	/*
> +	 * Enable crystal oscillator, and enable RTC switch to battery
> +	 * when VCC_PSAUX is not available.
> +	 */
>  	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
> -	rtc_ctrl |= RTC_BATT_EN;
> +	rtc_ctrl |= RTC_BATT_EN | RTC_OSC_EN;

No, you need to keep it disabled until you now the time is correct, that
is in set_time and you need to test for it in read_time and return
-EINVAL when it is not set.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
