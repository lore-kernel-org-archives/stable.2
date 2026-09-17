Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD533D6CA;
	Thu, 17 Sep 2026 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620811; cv=none; b=tdai2GkGBGnXQoMZTt2xDhr9OHayCcpBIqSUN7yuZLEwZ0PefN05IwyU5qcZ+1sOdaYazNpZBnw/AD7K+J+cGOlTx9uZGaPV0Ew2NcI+QaVs+QIW9wrDFCDejGyixLl4ZYIBUow+gRrllac3Ep5dCo6auNao58XQ89w43ol965A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620811; c=relaxed/simple;
	bh=mmm7o7N6Lw7ByP16zajA0WXABcIztVAyaGTEDsqylks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWMWPRcrwIrKMmBqFH+Rdt4lL2csMoR/n+KvdQURl/E+tsEx2VRxliIRtmz7n7bUH6CeVpJvUqq5dyVwhwCiwCuv/cXk7eZWgcq+HlNdPO6YL81L+i3XXV7mPr3EDINM9UGdoM67HbfeECvihOP5RePQ6PsiJFQ1ueiIWmoykNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/glVN5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/glVN5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28051F000FF;
	Thu, 17 Sep 2026 04:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789620809;
	bh=8pkmHG2dnlc2UQMeYp0dXCe3ELJF/DIESwxhTUqAvI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f/glVN5Lc9URTH/2XaU7rMpQrhosqnb05CJfODfOQPBu9JTiOAjfZrUcIIer1i23w
	 3VuVkGxbj9eeLlfCR9RMe9j/MIW5HthiBQqlkAN6jFcznxJUYUDxyu53S5HevS4Omc
	 ad2t44P2YhInQTtUy3DNTuy6WRYIKUIOl3460P0xTvy2d2mGHZSYLC5YEFa89RSGYz
	 MzuRBdvenYixMj6uFVqAA89e1XFR1BrPKvRlZh0ziJLMBnr83pujf3JSB2BpKqRYri
	 V5bZLnMUERRWiDqgdkLZyl9S5dOF3iGeN1IQl94rHiImDbHEhVFHRtdKYY9Cema/0Q
	 SZqckZ13skj0w==
Date: Thu, 17 Sep 2026 06:53:07 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Bryan O'Donoghue <bod@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-phy@lists.infradead.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v17 1/5] phy: core: Fix use-after-free in phy_get paths
Message-ID: <4jzaqafeeecrp7c56bqh7asop2hucv6h4eem5esmoamckk33jz@k2jkerutehs2>
References: <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v17-0-e2197a3e2551@linaro.org>
 <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v17-1-e2197a3e2551@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v17-1-e2197a3e2551@linaro.org>

On Sun, Sep 06, 2026 at 03:17:05PM +0100, Bryan O'Donoghue wrote:
> Sashiko asked during a patch review if the existing usage pattern had a
> race condition; specifically in of_phy_get() if it was possible between
> returning from _of_phy_get() and running try_module_get() that a module
> might be unbound leading to use-after-free.
> 
> Looking at the code this appears to be so, there is no linkage between the
> phy and module under a synchronisation primitive.
> 
> Using the phy_provider_mutex in phy_get() will ensure there is a link between
> the returned phy pointer and the module_get() bumping the module reference
> count.
> 
> Amend phy_get(), of_phy_get() and devm_of_phy_get_by_index() to fix the
> same usage pattern.
> 
> phy_provider_unregister() must take the phy_provider_mutex so amending
> phy_get()/of_phy_get() to take that same mutex guarantees there is no
> use-after-free.
> 
> Fixes: ff764963479a1 ("drivers: phy: add generic PHY framework")
> Cc: stable@vger.kernel.org
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/phy/phy-core.c | 45 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 21aaf2f76e53e..89addd732bff3 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -124,13 +124,13 @@ static struct phy *phy_find(struct device *dev, const char *con_id)
>  	const char *dev_id = dev_name(dev);
>  	struct phy_lookup *p, *pl = NULL;
>  
> -	mutex_lock(&phy_provider_mutex);
> +	lockdep_assert_held(&phy_provider_mutex);
> +
>  	list_for_each_entry(p, &phys, node)
>  		if (!strcmp(p->dev_id, dev_id) && !strcmp(p->con_id, con_id)) {
>  			pl = p;
>  			break;
>  		}
> -	mutex_unlock(&phy_provider_mutex);
>  
>  	return pl ? pl->phy : ERR_PTR(-ENODEV);
>  }
> @@ -624,6 +624,8 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
>  	struct phy *phy = NULL;
>  	struct of_phandle_args args;
>  
> +	lockdep_assert_held(&phy_provider_mutex);
> +
>  	ret = of_parse_phandle_with_args(np, "phys", "#phy-cells",
>  		index, &args);
>  	if (ret)
> @@ -635,11 +637,10 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
>  		goto out_put_node;
>  	}
>  
> -	mutex_lock(&phy_provider_mutex);
>  	phy_provider = of_phy_provider_lookup(args.np);
>  	if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner)) {
>  		phy = ERR_PTR(-EPROBE_DEFER);
> -		goto out_unlock;
> +		goto out_put_node;
>  	}
>  
>  	if (!of_device_is_available(args.np)) {
> @@ -653,8 +654,6 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
>  out_put_module:
>  	module_put(phy_provider->owner);
>  
> -out_unlock:
> -	mutex_unlock(&phy_provider_mutex);
>  out_put_node:
>  	of_node_put(args.np);
>  
> @@ -678,15 +677,21 @@ struct phy *of_phy_get(struct device_node *np, const char *con_id)
>  	if (con_id)
>  		index = of_property_match_string(np, "phy-names", con_id);
>  
> +	mutex_lock(&phy_provider_mutex);
> +

I was tempted to suggest using "guard(mutex)(&phy_provider_mutex)" in all 3
functions, but then realised that this patch is pointing the Fixes commit dating
back to the origin of the PHY framework. So cleanup.h won't be available and
backporting to older kernels won't be possible. So manual lock/unlock is OK
here.

>  	phy = _of_phy_get(np, index);
>  	if (IS_ERR(phy))
> -		return phy;
> +		goto out_unlock;
>  
> -	if (!try_module_get(phy->ops->owner))
> -		return ERR_PTR(-EPROBE_DEFER);
> +	if (!try_module_get(phy->ops->owner)) {
> +		phy = ERR_PTR(-EPROBE_DEFER);
> +		goto out_unlock;
> +	}
>  
>  	get_device(&phy->dev);
>  
> +out_unlock:
> +	mutex_unlock(&phy_provider_mutex);
>  	return phy;
>  }
>  EXPORT_SYMBOL_GPL(of_phy_get);
> @@ -786,6 +791,7 @@ struct phy *phy_get(struct device *dev, const char *string)
>  	struct phy *phy;
>  	struct device_link *link;
>  
> +	mutex_lock(&phy_provider_mutex);
>  	if (dev->of_node) {
>  		if (string)
>  			index = of_property_match_string(dev->of_node, "phy-names",
> @@ -796,15 +802,18 @@ struct phy *phy_get(struct device *dev, const char *string)
>  	} else {
>  		if (string == NULL) {
>  			dev_WARN(dev, "missing string\n");
> -			return ERR_PTR(-EINVAL);
> +			phy = ERR_PTR(-EINVAL);
> +			goto out_unlock;
>  		}
>  		phy = phy_find(dev, string);
>  	}
>  	if (IS_ERR(phy))
> -		return phy;
> +		goto out_unlock;
>  
> -	if (!try_module_get(phy->ops->owner))
> -		return ERR_PTR(-EPROBE_DEFER);
> +	if (!try_module_get(phy->ops->owner)) {
> +		phy = ERR_PTR(-EPROBE_DEFER);
> +		goto out_unlock;
> +	}
>  
>  	get_device(&phy->dev);

You could've dropped the mutex here itself instead of covering the whole
function. But that's not a deal breaker here. So,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
