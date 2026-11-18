Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031767;
	b=hsMgUYk4B6bb0UxHkUC6880TQ/BoAY6iPpBoZzs3jvRgu92UiI5qkxfv5hj7tetaWANz
	 lY6dxuTfJswx/qxluFBsPXT+4NcY6pjyzVWFwdswRD7g1Y1b2eJxxVRiSbdVFsZBD0fo8
	 F5Yx0OVMx7xoNE+Opz/04J5U7NbhiHr+R9qChxdL6pb8VIqhdQd/MkzOyIaTBWnTuV8+0
	 r4MpnvhFerz23wlVh4kz0ChCLT/lYwqVhtsy3ygXoBFioiU3tPDpFM6M9xXG2O6ZinTFp
	 BNj1JIv/CEs1vHtnUUEcElEmbvhlVU50jVU6RbK4j+HjY/LEIHr9gJ77QpNYx4OEoAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031767;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=wLT03LeZbhXOksmBn0t9WgkTSVA4EyoTOXmG+C7EJso=;
	b=GGshy7xaEjlvy/qozLw20ymQt46jS4G6NuAdZbOFBFs4Go+kS7pGgvMMPnoCvWfOYQzG
	 LxopCg5VfIvgD3ts8PX0l8J1DrbHb+/PF7tVY2bwo+H3GIqmyf5tZCM3mzfk/bIIhnd3q
	 Bv5IkpmByjh0Ehh7AItXXAzX+/vMzzOPM4I+NNYtu8yffDXJ3sikWJKYhutFOCNI4BYAV
	 +GbWxyKiCHQBOP8o9VRpSNxmlhC/VqiyUICviT4u8mhYVwS4YxGrPwM05Y9fubcaoSrlx
	 S+2GoV832g/Ntu5YKgxWRYmIoteWfEkBf4zT+byA+nU5znwNp1i38cd7MRsSVH2jeuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIw+gViG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8C606A320;
	Wed, 18 Nov 2026 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIw+gViG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434DF1F000C4;
	Wed, 18 Nov 2026 19:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795031766;
	bh=wLT03LeZbhXOksmBn0t9WgkTSVA4EyoTOXmG+C7EJso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EIw+gViGE8D7VwnZsn8W/ubXDjUPTNj+64H2VX8P5CPyEG1LuK9h5t3f2JRFirDcq
	 p64dTmAq/DtVY/hny3ZUkho89kN3GjuOono+7BkJjJAgMEGzxcMYx5ZGTeCgZgBQez
	 1FgTSExKpjuAkp6JSESRjy0lX31sUPwsh/B5OvPTnmGZOugo2F9/Udy9WpKDPFG25q
	 CRdZfANDDyvRTHQbvkXwky4faVKExy0s+FjUtWPBPrk32gyPfaC9GVCGs5Bmf7ngMJ
	 H2+7XShNmoDsbAKn9LD/EkRVKFCn9dFuFWHNqDLO5PxdfqWrntgqkI7HQrEYTl8Rzv
	 PbA+EwJxrdBZg==
Date: Wed, 18 Nov 2026 19:56:02 +0000
From: Lee Jones <lee@kernel.org>
To: raoxu <raoxu@uniontech.com>
Cc: pavel@kernel.org, griffin@kroah.com, Denis.Osterland@diehl.com,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] leds: pwm: Fix active-low brightness with default-state
 keep
Message-ID: <179442106213.44545.9829809278369376980@kernel.org>
References: <9524E319B9AF9D1A+20261109085822.3755803-1-raoxu@uniontech.com>
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
In-Reply-To: <9524E319B9AF9D1A+20261109085822.3755803-1-raoxu@uniontech.com>
X-AI-Review-Draft: <9524E319B9AF9D1A+20261109085822.3755803-1-raoxu@uniontech.com>

On Mon, 09 Nov 2026, raoxu wrote:

> From: Xu Rao <raoxu@uniontech.com>
>
> With default-state set to "keep", led_pwm_add() derives the initial
> brightness from the PWM duty cycle without accounting for active-low
> LEDs. However, led_pwm_set() inverts the duty cycle for these LEDs.
>
> For an enabled active-low PWM with zero duty cycle, the LED is fully
> on but its cached brightness is set to zero. Conversely, a full duty
> cycle is reported as maximum brightness instead of off. This exposes
> an incorrect brightness to userspace and can restore the wrong value
> after suspend. With an optional enable GPIO, the incorrect brightness
> also causes the wrong initial GPIO level to be selected.
>
> Invert the computed brightness for active-low LEDs, matching the
> conversion used by led_pwm_set() while leaving the PWM state intact.
>
> The supplied fix was reviewed and this commit message prepared with
> OpenCode AI assistance.

This should not end up in the commit message.

If you want it, move it under the '---'.

> Fixes: 3d3d65bd2764 ("leds: pwm: add support for default-state device property")
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/leds/leds-pwm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index 6c1f2f50ff85..da307767dbe8 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -131,6 +131,8 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>  		brightness = led->max_brightness;
>  		brightness *= led_data->pwmstate.duty_cycle;
>  		do_div(brightness, led_data->pwmstate.period);
> +		if (led_data->active_low)
> +			brightness = led->max_brightness - brightness;

One from the bot:

  What happens if 'pwm_get_state()' returns a state where
  '!led_data->pwmstate.enabled' or 'duty_cycle > period' from the
  bootloader/hardware?  Should we check 'led_data->pwmstate.enabled'
  before deriving a non-zero brightness for an active-low LED with
  'duty_cycle == 0'?

>  		led_data->cdev.brightness = brightness;
>  		}
>  		break;
> --
> 2.50.1
>

-- 
Lee Jones
