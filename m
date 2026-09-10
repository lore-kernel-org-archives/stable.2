Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF11414436;
	Thu, 10 Sep 2026 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070488; cv=none; b=M+xEuVmwnlaEl6zpylAV3Ekumm1iqqG8OWexYuwpnb3f0Oc6+CfTF185O7fn2vbhRW2Wb/CaU/R8oVZ9OFRyatsG0UddpoC2c6RfGvMGcNUDMJiQYnu7mYu+zn8fYQn2Z5wqoi57z4cepHSkpjHa7cKDqEnup53Ti4mwr4MLr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070488; c=relaxed/simple;
	bh=K3OhqYapq8/9YGp/iEQ2QKlD/1kQkmtpDwV8tx63Z9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8UKUC6GWGtK54gBOrWjpEtnzAy+oUHj/HzZMvkUk+Gsm+ZG70BEMGUgjZOQ6RbW32habLA+JltqguSOxRi+AMDtc1mU4Im2+ZybLTL50vZbCqshX8TitKP5inHY8A9E8rztYaB0ZCA/eNvnkV7MmK8y6eNh5HQJu+rnQ6YjBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDMx76sD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDMx76sD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C6A1F000FF;
	Thu, 10 Sep 2026 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070487;
	bh=qgAjydhKlvBY1ErV3UOJh0vIIGsAjA9VNJHIiNmRqtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fDMx76sDO7U5aGA0RooP6/dr82aG7LlUkxDzVccd5diNLWSYslWe92+1bbUKMq6TS
	 LXbrdy3yX/dxUzSwECydbRPamXbCbWve8ctLjbCkGBZny1XhAIqB8QXlVCvAy2QSgC
	 rVnbf32Y56UguAh3S0z8Dmb3FWT1nke9+01zUh9khjVFttM686VeHzx2nlITusZMym
	 S3K39KDErtkxsR1Nkz3Wertn/txD7p7pSakbX2F6qzAyWk3/Xjk+pW5IEmebP6kyV9
	 T90j400iYY11qKAoQ4qyEyuA92+60x4rPENfy6LJqQFdaOFdf668m3bGgv34BYf2FC
	 be9WXtnzUEqVw==
Date: Thu, 10 Sep 2026 15:01:23 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luo Jie <jie.luo@oss.qualcomm.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: Assign .num before accessing .hws
Message-ID: <aqMLw9h-m3eA_UIc@baldur>
References: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Sat, Sep 05, 2026 at 09:48:25PM +0100, Aamir Ahmed wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero.
> This occurs in ipq_cmn_pll_register_clks() due to .num being assigned
> only after the fixed rate output clocks and the CMN PLL clock have been
> stored in .hws[]. If registering one of the fixed rate clocks fails, the
> unwind loop under unregister_fixed_clk reads .hws[] while .num is still
> zero as well. With CONFIG_UBSAN_BOUNDS and a compiler that implements
> __counted_by (GCC 15.1+ or Clang 20.1+), this triggers an
> array-index-out-of-bounds report during probe, and with
> CONFIG_UBSAN_TRAP the first store traps so the CMN PLL clocks are never
> provided.

Please have your LLM rewrite this wall of text. It does not need to
explain how UBSAN works.

In particular the commit message claims this triggers an oob access
during probe() but below you repeat most of the text (although in a
more readable form) and there you say that this has only been compile
tested...

> 
> Move the .num initialization to right after the allocation.
> 
> Cc: stable@vger.kernel.org
> Fixes: f81715a4c87c ("clk: qcom: Add CMN PLL clock controller driver for IPQ SoC")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> ---
> Found while auditing the remaining clk_hw_onecell_data users that assign
> .num only after touching .hws[], following the fixes already merged for
> clk-s2mps11 (3e14c7207a97), exynos-clkout (cf33f0b7df13) and
> clk-raspberrypi (6dc445c19050). The audit, the fix and this changelog
> were drafted with an LLM assistant and reviewed by hand.
> 
> Compile-tested only (W=1, no warnings) on x86_64 with GCC 13.3, via
> COMPILE_TEST with CONFIG_IPQ_CMN_PLL=m. GCC 13.3 does not implement
> __counted_by (CC_HAS_COUNTED_BY needs GCC 15.1+ or Clang 20.1+), so the
> build only confirms that the change compiles; the sanitizer path was not
> exercised. I do not have the hardware, so this is not runtime-tested and
> no UBSAN report was captured.
> 
> Based on v7.3-rc1. Checked against the pending IPQ5210 CMN PLL series
> (v3, 2026-08-14): no changed lines overlap, and the fix is still needed
> after its first patch removes the unwind path.
> 

None of this noise is necessary, please put the relevant information in
the commit message and leave it at that.

>  drivers/clk/qcom/ipq-cmn-pll.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/ipq-cmn-pll.c b/drivers/clk/qcom/ipq-cmn-pll.c
> index dafe8c1738d..a9abad9ff4e 100644
> --- a/drivers/clk/qcom/ipq-cmn-pll.c
> +++ b/drivers/clk/qcom/ipq-cmn-pll.c
> @@ -380,6 +380,8 @@ static int ipq_cmn_pll_register_clks(struct platform_device *pdev)
>  	if (!hw_data)
>  		return -ENOMEM;
>  
> +	hw_data->num = num_clks + 1;
> +
>  	/*
>  	 * Register the CMN PLL clock, which is the parent clock of
>  	 * the fixed rate output clocks.
> @@ -406,7 +408,6 @@ static int ipq_cmn_pll_register_clks(struct platform_device *pdev)
>  	 * is configured to 12 GHZ by DT property assigned-clock-rates-u64.
>  	 */
>  	hw_data->hws[CMN_PLL_CLK] = cmn_pll_hw;
> -	hw_data->num = num_clks + 1;

Change looks good though.

Regards,
Bjorn

>  
>  	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
>  	if (ret)
> 
> base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18
> -- 
> 2.53.0.windows.1
> 
