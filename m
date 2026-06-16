Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B983DBD76;
	Tue, 16 Jun 2026 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781650536; cv=none; b=JPWAT0RcqsFm2Uiey+jujj0bFMyuKONGTbfUivfdM6oIbJdMch0f34GIEdgJJstohdASeDvdm36izHeZwMOpx6wvM81iNUH9Ovuyn5Xb4scVXSgjXMXIoh2HvVbsfqaWj9Mw80DNLqnf+LixKw756omPb5XuT+TMToDhUso7eXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781650536; c=relaxed/simple;
	bh=gJ5Mdg2RquWYIq7nTgMA++0bh+FNi+CtBzaXNr2CPpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTTT9f17ph+0H7ELag21Drq2NKqq3DBPnp+b1HIsbzq8A0/+I0QXkq+xqikp7GdwCjPRfkhytfk54W4p/1Q/eFlRRVMbWtADiE8HROX4rgUdfAhiYVmemAoYUv6EHmICeiSRLKETMwtwdQQSA6CETXLh9lXiVn2ybUbbuNAHA8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvO7OjJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvO7OjJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABFE1F000E9;
	Tue, 16 Jun 2026 22:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781650535;
	bh=fxjTxx12OJ+08Bi3C4UgDrBkqUhDXMkWgF4hNgZ5mbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hvO7OjJ2+5lCi0ik8PPqPQEdkseTzDP1HqNKck8yrnPETPnMFmffZoHrq5zhaNFcK
	 I8fDWhzkmV5dn2tBbOtKmIPaBo9ZTcPHd9OgUOQPKUjROFG0KauvB8U79ngQZ4j9vB
	 IQ6XwvqJX1pE/dRoPDYlNfzpbnaW1NAAaL8FsSCwOTvBLNN+N65F08XuffSwl37wDO
	 0bAkHmL+3kXr2WvGcVkRNjYXonWwYoZgaKtwnvlgOUVSjOXdgC9fpQxAxV/7kL3zSd
	 rnfmx/N2ydV7nctI3o+kFGh5vIWyO1C6t2zW9eFCi4C0qSEjA1zA86Cn/iQw4RxAIz
	 lGAMmUOR4xoqA==
Date: Wed, 17 Jun 2026 00:55:30 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v6 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
Message-ID: <ajHRVJhAzo3V4C9g@zenone.zhora.eu>
References: <20260608024533.32419-1-wanghongliang@loongson.cn>
 <20260608024533.32419-3-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608024533.32419-3-wanghongliang@loongson.cn>

Hi Hongliang,

On Mon, Jun 08, 2026 at 10:45:33AM +0800, Hongliang Wang wrote:
> The i2c-ls2x driver supports dts and acpi parameter passing.
> 
> In dts, uses clock framework, by parsing clocks property to
> get i2c bus reference clock, and define the div of reference
> clock by device data.
> 
> In acpi, by passing clocks property to describe i2c bus reference
> clock and clock-div property to describe the div of reference clock.
> 
> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
> and div, calculate the prcescale of i2c divider register. The
> calculation formula is
> 
> prcescale = (clock_a*10)/(div*clock_s)-1
> 
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Cc: stable@vger.kernel.org

what are you fixing exactly? It's not clear from the commit log.
Do we need to add the Fixes tag?

> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>

...

> @@ -96,6 +104,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev_id)
>  static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>  {
>  	u16 val;
> +	u32 pclk, div;
> +	struct clk *clk;
>  	struct i2c_timings *t = &priv->i2c_t;
>  	struct device *dev = priv->adapter.dev.parent;
>  	u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
> @@ -107,12 +117,30 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>  	else
>  		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
>  
> +	if (dev_of_node(dev)) {
> +		clk = devm_clk_get_optional_enabled(dev, NULL);

Here you got a valid comment from the sashiko-bot, did you check
it?

There are some other comments that is worth checking.

Thanks,
Andi

> +		if (!IS_ERR_OR_NULL(clk))
> +			pclk = clk_get_rate(clk);
> +		else
> +			pclk = LS2X_I2C_PCLK_FREQ;

...
