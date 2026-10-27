Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118419;
	b=0N1hOaI+Z1pC+hg6xZXWuCfs5uLCg2Ef+wq7w91cd1KRMsa9En7ttrBffTk3e/73OLSz
	 aj+I7fsea3RCwuHen3WRlley26X+xukR1P4HNHZWnUsSVj7AVg+ZGe0TQ+blz1Csq90QQ
	 UzAb4xMsiiqXtLFkYfcN7KtS1PISJsKq/281kfB7c+M3BDVgyjM6kbxWXsAIsxhd09DSf
	 S7hl30l9QV7jl24wjM9kXSxYGKZPBm0DxglrMcHr4CnNlVPyh2yokLAhZbRJ5OdI9yuou
	 xb7MRINzwVbSH1ysrxnwXKX1fVtYj70biWN8Kj1dz9NAXLFucOvEI6+3q1b7GnfYoKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118419;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=WNsucIhCLi1ZssycrW6FhEUFBVe53FGUJXjQSQYO5J8=;
	b=qB+z5keo0P4y14TGr3JKFAV4OtbGJ9HL9+b0xuds3XxXDflgvs2xKEZYU41F3SWP7q1Q
	 /cSvqMn74/4uu2rF9l1qFE1708yY2g9lRDKS/JvSDOmY+xvfW8Zpj5ChF55QeR+iZt6ve
	 a04cMA+kMGTrQxw0qO0Xn/a9gr8zwqin0MUbADFNmP7FQjFaUnW5c7AVr/qMiE5BzyPtx
	 G4YpP/KvqhWMse/lcQ0gCM1YAwS4cprUX6Abl5o3vvSR3HcKWjTKX7Hqmjl6a73nJ9OR1
	 wcCB3IvBY4kfC0Mtlxg7FB5UNHqhnA/JKdK2eEELQ9q9H3OhKq5PW6n/W3QDKuqhzXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=US6PZ4Yo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453A606A324;
	Tue, 27 Oct 2026 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=US6PZ4Yo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D871F01829;
	Tue, 27 Oct 2026 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118419;
	bh=WNsucIhCLi1ZssycrW6FhEUFBVe53FGUJXjQSQYO5J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=US6PZ4YoeRJsH6gPga++n7g1Ex5LkXZNpa5jfOelR1OT9eJanhLehKsAH8PTwAzlX
	 Gx/1UrJKw7kP1onBSYzaerjth2dS65zjsdI16Isx4nu50pgCzQu0IFpwId10vFVJLX
	 nWws+lZ+ajRiWKWGzJLsTKresLKIopdYyN97l608IWwvPHBnoZ/QRajcmvCv5GNX0N
	 tPdd82g7Rar3SgiPbyzXe2L5AYYriWAX+NIRkfE0ryI859oBu/LlT/qTcDfA6Rq2f9
	 qUysVYYyNk98enxacftYu5YDGwTC/Qr8lCIyEJziAH9cj/oVg5sPKPiY+GE5xis44i
	 UEkisotwRuanQ==
Date: Tue, 27 Oct 2026 16:26:53 +0000
From: Lee Jones <lee@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org,
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mfd: twl6040: fix IRQ action memory leaks during teardown
Message-ID: <179310015976.2808517.13064510476219400398@kernel.org>
References: <20261027032609.119226-1-lgs201920130244@gmail.com>
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
In-Reply-To: <20261027032609.119226-1-lgs201920130244@gmail.com>
X-AI-Review-Draft: <20261027032609.119226-1-lgs201920130244@gmail.com>

On Tue, 27 Oct 2026, Guangshuo Li wrote:

> twl6040_remove() currently removes the regmap IRQ chip before
> removing the MFD child devices. This destroys the IRQ mappings
> before the child drivers can release their interrupt handlers.
>
> The parent driver also registers READY and thermal interrupt
> handlers using devm_request_threaded_irq(). These handlers are
> normally released by device-managed cleanup after remove returns,
> when the corresponding IRQ descriptors have already been removed.
>
> Consequently, free_irq() cannot find the IRQ descriptors and the
> allocated struct irqaction objects are not freed. The associated
> IRQ threads also cannot be stopped through the normal cleanup path.
>
> The probe error paths have a similar issue, as they destroy the IRQ
> chip before the device-managed IRQ handlers are released.
>
> Remove the MFD child devices first, then explicitly free the
> parent's READY and thermal IRQ handlers using devm_free_irq()
> before removing the regmap IRQ chip.
>
> Also update the probe error paths to release successfully requested
> IRQs before destroying their mappings.
>
> This issue was found by our static analysis tool under development.
>
> Fixes: ab7edb149c75 ("mfd: twl6040: Convert to use regmap_irq")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/mfd/twl6040.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index 562a0f939f6e..7b05d21cd17d 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -745,7 +745,7 @@ static int twl6040_probe(struct i2c_client *client)
>  					"twl6040_irq_th", twl6040);
>  	if (ret) {
>  		dev_err(twl6040->dev, "Thermal IRQ request failed: %d\n", ret);
> -		goto readyirq_err;
> +		goto thirq_err;
>  	}
>
>  	/*
> @@ -791,10 +791,14 @@ static int twl6040_probe(struct i2c_client *client)
>  	ret = mfd_add_devices(&client->dev, -1, twl6040->cells, children,
>  			      NULL, 0, NULL);
>  	if (ret)
> -		goto readyirq_err;
> +		goto mfd_err;
>
>  	return 0;
>
> +mfd_err:
> +	devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
> +thirq_err:
> +	devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
>  readyirq_err:
>  	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
>  gpio_err:
> @@ -809,9 +813,10 @@ static void twl6040_remove(struct i2c_client *client)
>  	if (twl6040->power_count)
>  		twl6040_power(twl6040, 0);
>
> -	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
> -
>  	mfd_remove_devices(&client->dev);
> +	devm_free_irq(twl6040->dev, twl6040->irq_th, twl6040);
> +	devm_free_irq(twl6040->dev, twl6040->irq_ready, twl6040);
> +	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);

Why not use more devm_*() handlers?

devm_regmap_add_irq_chip()

devm_free* eeks me out.  The point of devm_*() is that it's managed.

>  	regulator_bulk_disable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
>  }
> -- 
> 2.43.0
>

-- 
Lee Jones
