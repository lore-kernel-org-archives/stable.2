Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FC47799D;
	Fri, 24 Jul 2026 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936382; cv=none; b=XiqT8AjteN9jaPkurUsMfqa8le5qsDSwPZei7ePWmKsv8SN5Mg7WQx4rq+cQ7r39plV2gGRwjLthrGf+Sg2YjDXtPTDjOX6YfRxV2ae5tnwkWH9mTuesx6VyPGeQkWkcL/kT8Rrg6J65nLwO7oi99EcQeL0UDFtTrAoiyyViFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936382; c=relaxed/simple;
	bh=b34mnL8lz+jqePxApZ67oQEx7ehiqH1YMnfnZBnYE/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNKFQxiXE84oJMz5+2iSb/fqCGOHEOt21cZ/QoHzwLiB4umwWsV0u3S1hxs3VkpUABYN/XwoeeyryvPNggZAN8qGmtrrMzARFAGaowa4NQMthGG+dctxucGOTKK4LbahGJH2KJENgXR5KI8RGicHqvJsG5isEgq06T0DLJlPpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tux6D86R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tux6D86R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2731F00A3A;
	Fri, 24 Jul 2026 23:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784936379;
	bh=Vt00kE+VeAluddWBb/3f728DfsTAsADGwy6DhFGLIuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tux6D86RKmmsfF2vucVcN2unXJ31MfPKRPNaGCmbW3lMCxEEPXe3o1lVu7fwUJdP+
	 q6Q4rD9xGVSsSuZxeGpwoz6mzELxFffoAufS3eSubciaKiZFk9Tz/eL40pGHSyycZj
	 dCJ7Zg1CH0+VZwTjqS9m7Xja3aU2FWXZiJiYI/rODJKVKbN5wAy+twr0VDBcmawpDw
	 0YTi9im9g37VBk14IEn2c5WTYV1LdSCGpKVCaZ3iR1WDbuGCJ6NcxKborAFX8kGzJx
	 xxfUheNiXDTzsZ89lgP2Gn4aIkwEtL4ANNZz4atw+4ykZjR7/PoKpckpHTK5O1Kj1W
	 ndtsNLjvzja9w==
Date: Sat, 25 Jul 2026 01:39:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v8 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
Message-ID: <amPz7-dljqdfwNGc@zenone.zhora.eu>
References: <20260721122604.12717-1-wanghongliang@loongson.cn>
 <20260721122604.12717-3-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721122604.12717-3-wanghongliang@loongson.cn>

On Tue, Jul 21, 2026 at 08:26:04PM +0800, Hongliang Wang wrote:
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

This commit log is not understandable, what did you actually do
here? Please read carefully the submitting-patches documentation
(under the "Describe your changes" paragraph).

> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

I haven't seen Huacai's review on patch 2, as far as I've seen he
has reviewed only patch 1. Have I missed anything?

> Cc: stable@vger.kernel.org
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>

Is this a Fix? I asked you this already. Please read carefully
the paragraph I suggested and add the necessary tag.

> ---
>  drivers/i2c/busses/i2c-ls2x.c | 40 ++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 

...

> @@ -107,12 +116,13 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>  	else
>  		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
>  
> +	val = (priv->pclk * 10) / (priv->div * t->bus_freq_hz) - 1;

Sashiko pointed out that this might overflow. While your replied
that the expected platform values may not overflow, the code does
not enforce those constraints.

The clock rate comes from firmware or the clock framework, so at
least a zero rate should be rejected. Using 64-bit arithmetic here
would also avoid relying on undocumented assumptions about the
input range at essentially no cost.

> +

...

> +	if (dev_of_node(dev)) {
> +		clk = devm_clk_get_optional_enabled(dev, NULL);
> +		if (IS_ERR(clk))
> +			return PTR_ERR(clk);
> +		if (clk)
> +			priv->pclk = clk_get_rate(clk);
> +		else
> +			priv->pclk = LS2X_I2C_PCLK_FREQ;
> +
> +		priv->div = (unsigned long)device_get_match_data(dev);
> +		if (!priv->div)
> +			priv->div = LS2X_I2C_2K_CLOCK_DIV;
> +	} else {
> +		/* clocks and clock-div are only ACPI properties. */

clocks is also DT property.

Andi

> +		ret = device_property_read_u32(dev, "clocks", &priv->pclk);
> +		if (ret)
> +			priv->pclk = LS2X_I2C_PCLK_FREQ;
