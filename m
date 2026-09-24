Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28094486E58;
	Thu, 24 Sep 2026 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256323; cv=none; b=OD5SEdVDuFmHlWjfcYSczkkWcnZeuEdCOcL1hp6GToXdfhMqwF8pDm1nI9isNKpk088Jgiq1UlZrFEF9HhODFd8j4f8LYzvM6/EeSHSFknjQ689xqlod8qVBltViFLRjXOBmx07pn34X/H5nO1lNw42/p7oFk/tkhldbjTNn5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256323; c=relaxed/simple;
	bh=+y/DElqnV4FcOVioDOH9GwNtbU9D/d/nfuapYBuGs1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1nrJ44wNwEOZRDt8rNiqzqoqvCx0fMx5DSB75SQbDDb2coOFnr3I1uG88Tb9Gtoz0G8cP9R562AnLKFM4nHHBGecGRhAFShx8B+8rlmeFxdyIlxqwU7PLcmlPI9pDcZt+fQX6X3M1kk5XYuHlnimR+ESutb8BZ8umHcfgPCE+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLQSDDVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLQSDDVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6F51F000FF;
	Thu, 24 Sep 2026 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256319;
	bh=qopmzz9GVmwF6XpkNn02wcUDHn7ZmytbGUwAr4xiQnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SLQSDDVNxICZUaXXbNRWvOV1h63/jmQAeZXJU7MrZolrgoLlCIh/YQzGaEGVsjMNy
	 s8BJ4WC/jPCIgJtntPqSBsvYE4nD8sF7Xt3VhThpqxI7AwTKWzGcJTZ2xEAOaPDh7H
	 fxbqWAXRQT1F86G66DlCpBNwbVebuixeqDyZdMGHHRPCU9rLke5jU8BUNtsSwwMzfW
	 AIVFfYQ64XIdZhoSl0K8hxkGvLSO5s36X/FdGIdm6r8djVuAl/fv2YBKzVv7d///V0
	 OMidMqfIY3bNJE/lqJe0hDjvrk1FKjQuqbHcT3js6YlRKL8wYDNKM9qjIZWVGH9tB5
	 XaEytynbHtGAQ==
Date: Thu, 24 Sep 2026 15:25:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Steam Lin <STLin2@winbond.com>, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Jacky Huang <ychuang570808@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] clk: nuvoton: ma35d1: Add missing WDT/WWDT parent
 clocks
Message-ID: <20260924-bald-awesome-griffin-7d1d5b@quoll>
References: <20260921-perso-ma35d1-upstream-clk-v2-0-209fd32a8b00@bootlin.com>
 <20260921-perso-ma35d1-upstream-clk-v2-1-209fd32a8b00@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-perso-ma35d1-upstream-clk-v2-1-209fd32a8b00@bootlin.com>

On Mon, Sep 21, 2026 at 08:44:45AM +0200, Miquel Raynal wrote:
> The WDT and WWDT muxes list PCLK3/4096 and PCLK4/4096 among their
> possible parents, but the driver never registers the corresponding
> clocks, so these parents could never be used.
> 
> Add pclk3_div4096 and pclk4_div4096 as fixed factor children of pclk3
> and pclk4 and expose them through the clock provider.
> 
> Reported-by: Jacky Huang <ychuang570808@gmail.com>
> Closes: https://lore.kernel.org/linux-clk/b8a8a65b-e302-4747-bc90-4920fc48795a@gmail.com/
> Suggested-by: Jacky Huang <ychuang570808@gmail.com>
> Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/nuvoton/clk-ma35d1.c               | 2 ++
>  include/dt-bindings/clock/nuvoton,ma35d1-clk.h | 4 +++-

Please do not combine patches.

>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
> index 9f65d0623517..9d57de6a1e56 100644
> --- a/drivers/clk/nuvoton/clk-ma35d1.c
> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
> @@ -543,6 +543,8 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
>  	hws[HCLK3] = ma35d1_clk_fixed_factor(dev, "hclk3", "sysclk1_mux", 1, 2);
>  	hws[PCLK3] = ma35d1_clk_fixed_factor(dev, "pclk3", "sysclk1_mux", 1, 2);
>  	hws[PCLK4] = ma35d1_clk_fixed_factor(dev, "pclk4", "sysclk1_mux", 1, 2);
> +	hws[PCLK3_DIV4096] = ma35d1_clk_fixed_factor(dev, "pclk3_div4096", "pclk3", 1, 4096);
> +	hws[PCLK4_DIV4096] = ma35d1_clk_fixed_factor(dev, "pclk4_div4096", "pclk4", 1, 4096);
>  
>  	hws[USBPHY0] = ma35d1_clk_fixed("usbphy0", 480000000);
>  	hws[USBPHY1] = ma35d1_clk_fixed("usbphy1", 480000000);
> diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
> index ba2d70f776a6..d3fd8251c806 100644
> --- a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
> +++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
> @@ -248,6 +248,8 @@
>  #define ADC_GATE	233
>  #define EADC_DIV	234
>  #define EADC_GATE	235
> -#define	CLK_MAX_IDX	236
> +#define PCLK3_DIV4096	236
> +#define PCLK4_DIV4096	237
> +#define	CLK_MAX_IDX	238

This cannot be updated. If it has to, then not a binding and should be
first dropped from the bindings like we did for most of the platforms
having similar issue.

Best regards,
Krzysztof

