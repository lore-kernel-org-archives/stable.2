Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8CE48425A;
	Mon,  5 Oct 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210316; cv=none; b=rftt77MPc7k1cDNQ0PdJWhB/V8V3Wxs7Se6yGN+vdYfe/iersiVNohqS2yuVKCENPw5VT96+nJcpsVdjdWtUoJqlfFuO5jDy8hpQJe4du1KoCCQfhGqdYrdJ+6iaxN7l56Bcl7+7r9mZRMFEMZZHLVNC+q6M3Vud2bjnOUGzvcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210316; c=relaxed/simple;
	bh=agBaqa7znpc1dFeb1xkbmOLpMwOiUo/7b0SMHNo43Is=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=givoyi06HLubUDWEA6UUjSjt98iKd+Bgx8L8xXqAXqAC86lNb0vvyxPDoFOLT7POCMz0RzBN5cmMFFS17HkHDabx3LeiWj9OwZrCzsLqjda32zWw0PwyweyespYmyEpxc/PfaaXRXYK9YELHnSp8GD7i2DhYhyHop1Ucw5WT0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=tXZfPycV; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="tXZfPycV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=YWfhbwVsJTzT121ij6jtqXK9s+ycW5ZeldoRhe2GmyE=; b=tXZfPycVYua3aNGWkSheME+WDo
	hGc2duFnhlB2UxRU0sjx/Y1AQD0n6HAbOo+fNc0Z7gyBZ+jsklJUHvmifrSQWwFStFQ4gnAIqhgpB
	I+1Wk9oZbanXZXfEME4/ILeG4WS76S/01RQNqq1sNyrnf9vVXjwn7B0PSOSiZP4ek48A=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xDjca-0000000012H-1YJn;
	Mon, 05 Oct 2026 10:24:54 -0400
Date: Mon, 5 Oct 2026 10:24:52 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
Cc: Linus Walleij <linusw@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 =?ISO-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>,
 Alistair Francis <alistair@alistair23.me>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, <linux-input@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Jerome Oufella
 <jerome.oufella@savoirfairelinux.com>, Felix Boucher
 <felix.boucher@savoirfairelinux.com>, Quentin Lehoux
 <quentin.lehoux@savoirfairelinux.com>
Subject: Re: [PATCH 2/3] Input: cyttsp5 - init IRQ early to avoid app
 startup problems
Message-Id: <20261005102452.45c795f89a40a2964afb0b53@hugovil.com>
In-Reply-To: <20261002183529.166248-3-marc-olivier.champagne@savoirfairelinux.com>
References: <20261002183529.166248-1-marc-olivier.champagne@savoirfairelinux.com>
	<20261002183529.166248-3-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Marc-Olivier,

On Fri,  2 Oct 2026 14:35:28 -0400
Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
wrote:

> Sometimes, the driver reports an error when trying to start the
> application.
> 
> After a reset, the bootloader will assert the interrupt pin to indicate
> when it is ready to communicate with the host; on our hardware this
> happens about 3.4 ms after the reset line is released. But since
> cyttsp5_probe() configures the IRQ and then immediately jumps to
> cyttsp5_startup(), there is a chance that the interrupt pin assertion
> can happen at around the same time that we try to deassert it by
> calling cyttsp5_deassert_int().
> 
> Initializing the IRQ while the reset pin is asserted ensures that this
> first interrupt is handled by cyttsp5_handle_irq(), which deasserts the
> interrupt pin by reading the input buffer. Therefore, calling
> cyttsp5_deassert_int() is no longer needed in that case.
> 
> However, when cyttsp5_handle_irq() has processed that first interrupt,
> it has set the cmd_done completion. Because of that, the launch
> application command would complete before its own response has been
> received. Instead of sleeping a fixed 20 ms and hoping the reset
> sentinel has already been received, wait for it explicitly after
> releasing the reset line, so that its completion is consumed before the
> first command is sent.
> 
> Without a reset line, the device may still be powering up if enabling
> the regulators turned it on, or may already be running, and the reset
> sentinel may have been raised before the IRQ was requested. Keep the
> 20 ms delay and the cyttsp5_deassert_int() call in that case, then wait
> for the interrupt handler to finish and drop the completion it may have
> set, so that the sentinel does not complete the first command either
> way.
> 
> This relies on the previous patch, which makes cyttsp5_handle_irq()
> reliably identify the reset sentinel.
> 
> Fixes: 5b0c03e24a06 ("Input: Add driver for Cypress Generation 5 touchscreen")
> Cc: stable@vger.kernel.org
> Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Assisted-by: Copilot:claude-fable-5.1
> Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
> ---
>  drivers/input/touchscreen/cyttsp5.c | 66 +++++++++++++++++++++++------
>  1 file changed, 53 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
> index 04e141eceb45..beeb7d5bcd2c 100644
> --- a/drivers/input/touchscreen/cyttsp5.c
> +++ b/drivers/input/touchscreen/cyttsp5.c
> @@ -88,6 +88,7 @@
>  #define CY_HID_OUTPUT_GET_SYSINFO_TIMEOUT_MS	3000
>  #define CY_HID_GET_HID_DESCRIPTOR_TIMEOUT_MS	4000
>  #define CY_HID_SET_POWER_TIMEOUT		500
> +#define CY_HID_RESET_SENTINEL_TIMEOUT_MS	1000
>  
>  /* maximum number of concurrent tracks */
>  #define TOUCH_REPORT_SIZE			10
> @@ -760,6 +761,30 @@ static int cyttsp5_deassert_int(struct cyttsp5 *ts)
>  	return -EINVAL;
>  }
>  
> +/*
> + * After a reset the device asserts the interrupt line with a zero-length
> + * report (reset sentinel) once it is ready to communicate. Consume it so
> + * that it does not complete the next command.
> + */
> +static int cyttsp5_wait_reset_sentinel(struct cyttsp5 *ts)
> +{
> +	unsigned long timeout = msecs_to_jiffies(CY_HID_RESET_SENTINEL_TIMEOUT_MS);
> +	int rc;
> +
> +	rc = wait_for_completion_interruptible_timeout(&ts->cmd_done, timeout);
> +	if (rc <= 0) {
> +		dev_err(ts->dev, "Reset sentinel timed out\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (get_unaligned_le16(&ts->response_buf[0]) != 0) {
> +		dev_err(ts->dev, "Unexpected report instead of reset sentinel\n");
> +		return -EPROTO;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cyttsp5_fill_all_touch(struct cyttsp5 *ts)
>  {
>  	struct cyttsp5_sysinfo *si = &ts->sysinfo;
> @@ -786,12 +811,6 @@ static int cyttsp5_startup(struct cyttsp5 *ts)
>  {
>  	int error;
>  
> -	error = cyttsp5_deassert_int(ts);
> -	if (error) {
> -		dev_err(ts->dev, "Error on deassert int r=%d\n", error);
> -		return -ENODEV;
> -	}
> -
>  	/*
>  	 * Launch the application as the device starts in bootloader mode
>  	 * because of a power-on-reset
> @@ -888,13 +907,6 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
>  		return error;
>  	}
>  
> -	fsleep(10); /* Ensure long-enough reset pulse (minimum 10us). */
> -
> -	gpiod_set_value_cansleep(ts->reset_gpio, 0);
> -
> -	/* Need a delay to have device up */
> -	msleep(20);

My original patch contained only this move of the above
section past the IRQ init. The title of the current commit reflect my
original patch, but no longer this new AI-merged patch, which modifies
two different things in the same patch.

I would suggest that you use the original patch as is, as a
prerequisite for your AI-assisted new patch, to make the changes more
modular and so that they are easier to review.

Thank you for submitting these fixes/improvements!


> -
>  	error = devm_request_threaded_irq(dev, irq, NULL, cyttsp5_handle_irq,
>  					  IRQF_ONESHOT, name, ts);
>  	if (error) {
> @@ -902,6 +914,34 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
>  		return error;
>  	}
>  
> +	fsleep(10); /* Ensure long-enough reset pulse (minimum 10us). */
> +
> +	gpiod_set_value_cansleep(ts->reset_gpio, 0);
> +
> +	if (ts->reset_gpio) {
> +		error = cyttsp5_wait_reset_sentinel(ts);
> +		if (error)
> +			return error;
> +	} else {
> +		/*
> +		 * Without a reset line, the device may be powering up or
> +		 * already running. Give it time to come up, then make sure a
> +		 * reset sentinel does not complete the first command: read it
> +		 * if it came before the IRQ was requested, otherwise drop the
> +		 * completion set by the interrupt handler.
> +		 */
> +		msleep(20);
> +
> +		error = cyttsp5_deassert_int(ts);
> +		if (error) {
> +			dev_err(ts->dev, "Error on deassert int r=%d\n", error);
> +			return error;
> +		}
> +
> +		synchronize_irq(irq);
> +		try_wait_for_completion(&ts->cmd_done);
> +	}
> +
>  	error = cyttsp5_startup(ts);
>  	if (error) {
>  		dev_err(ts->dev, "Fail initial startup r=%d\n", error);
> -- 
> 2.34.1
> 


-- 
Hugo Villeneuve
