Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97A2931F2;
	Wed, 23 Sep 2026 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152412; cv=none; b=Hh2Im/UXNjUTwXwjLTLFdJlpzKF+x+BhEJWZ1jIDiayqAuPOUOx/bq67k/J3un/SL42EFYNbGKM2r32jOW0zlPkiQxKZevLmIm5DFGsgdRayhBAf2dsekA/abuuQYelEehnE1myrJGjuw4O0kDWZNhpTGd9kqknbiBUgKBIpct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152412; c=relaxed/simple;
	bh=URkfLOMIUnFUOaJ9zWwcB9WhejQf0WOG6JeFGwJjb3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rckNuz0gCAQ0T2uaGkUA9VHfEKsRC5WbdTvG/hrdxaJWLMfbHjNbkClMuaYp5M/wt3kU3yTiYql0T0koKfsyKVeEsH0v2j1duFi8pKUQE+VEll6/fUkhq+PxfTq/zncOnnLUvzVeFM3PWsGVxoh9PFMx28kgTM8veYPICh9KySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9LWrAbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9LWrAbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155A31F000FF;
	Wed, 23 Sep 2026 08:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790152410;
	bh=eLp4rFYfWd8xJ+eXslxKqvZLTn35eWOcfqVL6JWVbio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P9LWrAbg577W4RwsM28ZUBm1z4UeJxhWkUg0Fq8nzcGuLnVSV5sqZSt2lddO+ow66
	 dQ/XZ3e+QCCBFYOtJo6imxWoUNDFa90EDogsymEkRGnB9Bb64CeGqlEwR92hZkW4T9
	 UNagRhQ/di67uO1kO2UCBObAwRd9DiWoiuM1qxa9V/E3BPI9pzxgQsCfo1d8oeN86Y
	 LYZfuPyzj0+XGeHYkKNaoJh8sEYYSigr4MC/gFbvtw+dwpkgVGZv+NWbqUIKKGy63D
	 XNcs3luj00XnPmJ/cgp5CPWMhjW4OEqYH3lJ53KeT8cnhIu0Qk5OfqDPw4qySnoNUn
	 IUNaGtnOrSUEg==
Date: Wed, 23 Sep 2026 09:33:13 +0100
From: Lee Jones <lee@kernel.org>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Marcin Niestroj <m.niestroj@grinn-global.com>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"mfd@lists.linux.dev" <mfd@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] mfd: tps65217: Use devres for IRQ domain and wake
 teardown
Message-ID: <20260923083313.GA3847974@google.com>
References: <20260917103312.92624-1-r.zhambakiev@prosoftsystems.ru>
 <20260917103312.92624-4-r.zhambakiev@prosoftsystems.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917103312.92624-4-r.zhambakiev@prosoftsystems.ru>

On Thu, 17 Sep 2026, Жамбакиев Радий Рикардинович wrote:

> From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> 
> Removing the parent device used to tear the IRQ domain down in
> tps65217_remove() before the MFD children are unbound: the i2c core
> only releases the parent's devres after the remove callback returns,
> whereas devm_mfd_add_devices() registered its own devres action which
> unbinds the children. Children that requested interrupts from the
> domain (e.g. tps65217-charger) therefore call free_irq() on virtual
> IRQs whose descriptors have already been disposed. With
> CONFIG_SPARSE_IRQ free_irq() then returns early without stopping the
> threaded handler, leaking the irqaction, the IRQ kthread and a module
> reference.
> 
> Register the domain teardown as a devres action right after the domain
> is created instead. Devres actions are released in reverse order of
> registration, so the MFD children release their IRQs first, then the
> parent interrupt is freed and its thread stopped, and only then is the
> domain torn down. The same ordering covers probe failure, which no
> longer needs manual cleanup, and the remove callback can be dropped
> entirely.
> 
> Balance the enable_irq_wake() in tps65217_irq_init() by registering
> disable_irq_wake() as a devres action as well. Only do so when
> enabling actually succeeded, since the parent chip may not support
> setting wake-up.
> 
> Fixes: 6556bdacf646fcaa ("mfd: tps65217: Add support for IRQs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> ---
>  drivers/mfd/tps65217.c | 58 +++++++++++++++++++++++++++++-------------
>  1 file changed, 40 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index ee640e3fcf7b..b5138d0f318f 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -146,6 +146,31 @@ static const struct irq_domain_ops tps65217_irq_domain_ops = {
>  	.map = tps65217_irq_map,
>  };
>  
> +static void tps65217_irq_cleanup(void *data)
> +{
> +	struct tps65217 *tps = data;
> +	unsigned int virq;
> +
> +	if (!tps->irq_domain)
> +		return;
> +
> +	for (int i = 0; i < TPS65217_NUM_IRQ; i++) {
> +		virq = irq_find_mapping(tps->irq_domain, i);
> +		if (virq)
> +			irq_dispose_mapping(virq);
> +	}
> +
> +	irq_domain_remove(tps->irq_domain);
> +	tps->irq_domain = NULL;
> +}
> +
> +static void tps65217_irq_wake_disable(void *data)
> +{
> +	unsigned long irq = (unsigned long)data;
> +
> +	disable_irq_wake(irq);
> +}
> +
>  static int tps65217_irq_init(struct tps65217 *tps, int irq)
>  {
>  	int ret;
> @@ -169,6 +194,10 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
>  		return -ENOMEM;
>  	}
>  
> +	ret = devm_add_action_or_reset(tps->dev, tps65217_irq_cleanup, tps);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_request_threaded_irq(tps->dev, irq, NULL,
>  					tps65217_irq_thread, IRQF_ONESHOT,
>  					"tps65217-irq", tps);
> @@ -178,7 +207,17 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
>  		return ret;
>  	}
>  
> -	enable_irq_wake(irq);
> +	ret = enable_irq_wake(irq);
> +	if (ret) {
> +		dev_warn(tps->dev, "failed to enable IRQ wake: %d\n", ret);
> +		return 0;
> +	}
> +
> +	ret = devm_add_action_or_reset(tps->dev,
> +			tps65217_irq_wake_disable,
> +			(void *)(unsigned long)irq);

Nit: What on earth is going on with this formatting?

Firstly, there is no need to wrap this early and secondly, if there is
space left, which there clearly is here, we always line-up with the '('.

	ret = devm_add_action_or_reset(tps->dev, tps65217_irq_wake_disable,
				       (void *)(unsigned long)irq);

> +	if (ret)
> +		return ret;
>  
>  	return 0;
>  }
> @@ -379,22 +418,6 @@ static int tps65217_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static void tps65217_remove(struct i2c_client *client)
> -{
> -	struct tps65217 *tps = i2c_get_clientdata(client);
> -	unsigned int virq;
> -	int i;
> -
> -	for (i = 0; i < TPS65217_NUM_IRQ; i++) {
> -		virq = irq_find_mapping(tps->irq_domain, i);
> -		if (virq)
> -			irq_dispose_mapping(virq);
> -	}
> -
> -	irq_domain_remove(tps->irq_domain);
> -	tps->irq_domain = NULL;
> -}
> -
>  static const struct i2c_device_id tps65217_id_table[] = {
>  	{"tps65217", TPS65217},
>  	{ /* sentinel */ }
> @@ -408,7 +431,6 @@ static struct i2c_driver tps65217_driver = {
>  	},
>  	.id_table	= tps65217_id_table,
>  	.probe		= tps65217_probe,
> -	.remove		= tps65217_remove,
>  };
>  
>  static int __init tps65217_init(void)
> -- 
> 2.53.0

-- 
Lee Jones
