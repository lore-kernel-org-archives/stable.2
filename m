Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3517525A6C;
	Wed, 16 Sep 2026 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569485; cv=none; b=Bi7wTa5+XSrlPktYLFVwyqQ2GoOnLb/NCoxYG80dBZEUVTjKxV8+7y8BYCq2o8b6DOsZtHQ24za2dEtTSGlMZ9ecqF9YqHw/apUWYFEmmSFLsg+UzWsCX0CQPckb0WuDlxrdhgOFyH2lOWNSh/wqX5tX413ZAGh6lg0sybQbG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569485; c=relaxed/simple;
	bh=Ge51FKF9dxzcuP0k+60Sob1mNEy5H8SW9QfPtGJcErc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYXYcEKjxnhY0weoGgaeVDeGdiZopsIto9itgn22Kxv+9bzU0Y8d/I1oU4msPdrWYzXn4QMvxzsdUpOkpo3sDlL1417dWogUanw+GwkS9p9BxMSzB1F7hWsHIegAcVcfmQ2T9nZI7u+9zCF6eWdBcybnysTkXKonnMANgsSoaSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+0YFh9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+0YFh9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8121F000FF;
	Wed, 16 Sep 2026 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569483;
	bh=VZAPxs1224cyE2yJ8N2Kc0fgHsclDZVw9Y5ZcVwg7xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H+0YFh9oF2uBV8glOeONiQXG+txF8LWFoQk7Pv+H10vyxf8I/B53l+nDtOAlK2fCD
	 c2ICrqbl30/Gk1yppfinmtRkC5QI02ZNPPhifufy+bVwFbC0Ek3Sq1T0aJ2whwTBNx
	 wMZPpe8/UiQEmoeqZw+2O4zVer6dIkzp/CC+I6EIJ9uXK0lNYhXIu0KA4CYHm7HJaB
	 uQeC3O3VzVi8Mag3c26exlqtW6nDPHb/ap6bbikEwoE8n5IBQXZ64x2xEyCIrRV5Zt
	 h7iNL76TfVKjHAPdViChTPHgu9Bjzs8sGLG8UCPc4fhz6Djzreppv4QIERA+yZQNom
	 hIPspq4hEw3Yg==
Date: Wed, 16 Sep 2026 15:37:58 +0100
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
Subject: Re: [PATCH v3 3/3] mfd: tps65217: Use devres for IRQ domain and wake
 teardown
Message-ID: <20260916143758.GD1605367@google.com>
References: <20260904063439.69881-1-r.zhambakiev@prosoftsystems.ru>
 <20260904063439.69881-4-r.zhambakiev@prosoftsystems.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904063439.69881-4-r.zhambakiev@prosoftsystems.ru>

On Fri, 04 Sep 2026, Жамбакиев Радий Рикардинович wrote:

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
>  drivers/mfd/tps65217.c | 68 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 9a1528456ffc..2d799b60c79b 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -146,6 +146,36 @@ static const struct irq_domain_ops tps65217_irq_domain_ops = {
>  	.map = tps65217_irq_map,
>  };
>  
> +static void tps65217_irq_cleanup(struct tps65217 *tps)
> +{
> +	unsigned int virq;
> +	int i;
> +
> +	if (!tps->irq_domain)
> +		return;
> +
> +	for (i = 0; i < TPS65217_NUM_IRQ; i++) {

for (int i = 0; ...

> +		virq = irq_find_mapping(tps->irq_domain, i);
> +		if (virq)
> +			irq_dispose_mapping(virq);
> +	}
> +
> +	irq_domain_remove(tps->irq_domain);
> +	tps->irq_domain = NULL;
> +}
> +
> +static void tps65217_domain_release(void *data)
> +{
> +	struct tps65217 *tps = data;
> +
> +	tps65217_irq_cleanup(tps);
> +}

Superfluous abstraction.  Please remove it.

> +
> +static void tps65217_irq_wake_disable(void *data)
> +{
> +	disable_irq_wake((unsigned int)(unsigned long)data);

Introduce a variable, then you can omit the casts.

> +}
> +
>  static int tps65217_irq_init(struct tps65217 *tps, int irq)
>  {
>  	int ret;
> @@ -170,6 +200,16 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
>  		return -ENOMEM;
>  	}
>  
> +	/*
> +	 * Devres actions are released in reverse order of registration,
> +	 * so the domain is torn down after the parent interrupt and the
> +	 * MFD children, which are registered later in probe, have
> +	 * released their IRQs.
> +	 */

We don't usually describe how manages resources work when using devm_*().

> +	ret = devm_add_action_or_reset(tps->dev, tps65217_domain_release, tps);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_request_threaded_irq(tps->dev, irq, NULL,
>  					tps65217_irq_thread, IRQF_ONESHOT,
>  					"tps65217-irq", tps);
> @@ -179,7 +219,16 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
>  		return ret;
>  	}
>  
> -	enable_irq_wake(irq);
> +	ret = enable_irq_wake(irq);
> +	if (ret) {
> +		dev_warn(tps->dev, "failed to enable IRQ wake: %d\n", ret);

Return zero here, then omit the else branch.

> +	} else {
> +		ret = devm_add_action_or_reset(tps->dev,
> +				tps65217_irq_wake_disable,
> +				(void *)(unsigned long)irq);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -380,22 +429,6 @@ static int tps65217_probe(struct i2c_client *client)
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
> @@ -409,7 +442,6 @@ static struct i2c_driver tps65217_driver = {
>  	},
>  	.id_table	= tps65217_id_table,
>  	.probe		= tps65217_probe,
> -	.remove		= tps65217_remove,
>  };

-- 
Lee Jones
