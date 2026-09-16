Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AC3E9C17;
	Wed, 16 Sep 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567584; cv=none; b=LzAEUJ5IvrPFgtFvqKsphHfHOE7Heh3/sv9xSoGQl6ZazY+CNDEQHwKnLckiQIE3EtDQ++R6M3jcd/q+HNNh6RZzeTHma1ydxZ7thlVYi7/RJOaMTvE4e51lMaAn8z33YxzXkQTQoewM7cRU3RscPPVnALI8kvgOrA0Juw2w7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567584; c=relaxed/simple;
	bh=8TCVFKjnWPBfeA3Vjc5D+/gx6Y7LRkwCkc3WUlpm8BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8E/0nL7sDWOe88tuEaUf13cmi9FlZjpPB0gaOKP6HgyQcPhxkEwAYgpCiuK8nb2ipM+lGtLFLa2RbSU+wJ9aqlBKTrHnJLV6U2Ggv2znLx5oIIgxryDZ2Gj9ToetdrXKNN/AUyrSKkgzj+w40ISJn+IPAtfBtU0WLCmXsvdnEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3C5/0uo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3C5/0uo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F051F1F000FF;
	Wed, 16 Sep 2026 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567582;
	bh=8AwP2KHd7BIHx1d+h+dHPDd3n480upMyIFhWCqKbJ7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A3C5/0uoni014VZ1tGf3f1Dqju+gJItCviWASNLz22siMh3s1UIADLBHExhPIpQVd
	 yhaFAEbcN6ah8qBcI6xaJSYUC8prE/FftQR74CgAWCJ1+w5410behx4Uxuig+3ny/J
	 icTJpecZ6UnyCcoX58QpKGel2knIReeropwrT3XTbd6JcOpCiGwbgY9qTeI9vlEQbC
	 nvfQyq9zlkiQQiSGoCl0eJALM7mRX+WbZFOpF5iKw1d8f0PNkQuY2XBv6T/Vm8ioCE
	 KN5nD80BlaL5okLLIiEYYvWd8Aox7uwr29OwTvg+1G2OSflAQpczMeSqxMMG1HfBot
	 kOrkuiw6gtY+Q==
Date: Wed, 16 Sep 2026 15:06:17 +0100
From: Lee Jones <lee@kernel.org>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Marcin Niestroj <m.niestroj@grinn-global.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"mfd@lists.linux.dev" <mfd@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] mfd: tps65217: Check return value when masking
 interrupt sources
Message-ID: <20260916140617.GC1605367@google.com>
References: <20260904063439.69881-1-r.zhambakiev@prosoftsystems.ru>
 <20260904063439.69881-3-r.zhambakiev@prosoftsystems.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904063439.69881-3-r.zhambakiev@prosoftsystems.ru>

On Fri, 04 Sep 2026, Жамбакиев Радий Рикардинович wrote:

> From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> 
> tps65217_irq_init() ignores the error returned by
> tps65217_set_bits() when masking all interrupt sources. A failed
> register write leaves the driver's software mask out of sync with the
> hardware and may result in spurious interrupts.
> 
> Check the return value and propagate the error to the caller.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 6556bdacf646fcaa ("mfd: tps65217: Add support for IRQs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> ---
>  drivers/mfd/tps65217.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 2d04d9e0ae29..9a1528456ffc 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -155,8 +155,13 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
>  
>  	/* Mask all interrupt sources */
>  	tps->irq_mask = TPS65217_INT_MASK;
> -	tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
> -			  TPS65217_INT_MASK, TPS65217_PROTECT_NONE);
> +	ret = tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
> +				TPS65217_INT_MASK, TPS65217_PROTECT_NONE);
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to mask interrupt sources: %d\n",
> +			ret);

Nit: Why wrap here?  The line below is clearly longer than this one.

> +		return ret;
> +	}
>  
>  	tps->irq_domain = irq_domain_create_linear(dev_fwnode(tps->dev), TPS65217_NUM_IRQ,
>  						   &tps65217_irq_domain_ops, tps);
> -- 
> 2.55.0

-- 
Lee Jones
