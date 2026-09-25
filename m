Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DCB36495F;
	Fri, 25 Sep 2026 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341096; cv=none; b=GWh4VGQp10JzU6/o7EZVYZ89UiuKgd9d6MJnMOAWu6QoIjTB3+oMDcu/h1xyHaChxpTe8ZdAzAL0swWN+eLObfjoX6zP2dloG4mq/Kaw6XBuy47xeHAcdwnJspxRDX3geZqJSHeyN22h2Pkk4hz8ADHAip2V2sI4k0FctQa14bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341096; c=relaxed/simple;
	bh=Djh7EIlJWoKVdGspdFOu0gSdxVPNo3FdFkoX9qmfmgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXwEsqLMTtQxheXEut98HRIMBOWwzYBpz8sxo6vLSAc3FMTEgcTxforlZmhcE6NgdjUsEpvLaeAVzAJCYmgRwTlHbRNmWz6IsnoAIM3QI1BdapfL8nIyd8dzgTKmJqMoNs44fs9YZv86ow3H5rHMFqJst6JNB710hmWx7hVSAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbmABMCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbmABMCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A961A1F000FF;
	Fri, 25 Sep 2026 12:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341095;
	bh=jbnszAl0K2VzxzoSrqdeRmwXSjuXaYSQ8xFcW+B2Iio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UbmABMCD3NJD18sg93yx8jrXsuUaIDW5mnrEVLTg6fzvCRXCnallCKU/aHKc5Ujl1
	 I0vVx09yYduB7rxp1XMEkWSATP3Hr91gCvaUbQVzA6YRrqzVzcpW/2mZeZdO/NaN61
	 /Ans4jXN/JZUSgJU9zX/4auRYKLjRb9rkc+U7MUBZD+JSbsP16pCy9+MI19foMDerf
	 RI9aFat4ufgdX2dLBvZpCR85hUow+beiMf3AWGSmKCslac+6pkbCfRJF4A7L+KvrmQ
	 VOI/0qY2BpPUJVRWTbO4abBg81p80fQDim3OHWxCLzlGQgcyg2WZ0wFZ74pqkLq6nA
	 YBVlqyXBNL4vA==
Date: Fri, 25 Sep 2026 14:58:11 +0200
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
Message-ID: <20260925-skinny-husky-of-cookies-4aaddb@quoll>
References: <20260921-perso-ma35d1-upstream-clk-v2-0-209fd32a8b00@bootlin.com>
 <20260921-perso-ma35d1-upstream-clk-v2-1-209fd32a8b00@bootlin.com>
 <20260924-bald-awesome-griffin-7d1d5b@quoll>
 <87jyo9ljlo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jyo9ljlo.fsf@bootlin.com>

On Fri, Sep 25, 2026 at 12:18:43PM +0200, Miquel Raynal wrote:
> Hello Krzysztof,
> 
> >> Reported-by: Jacky Huang <ychuang570808@gmail.com>
> >> Closes: https://lore.kernel.org/linux-clk/b8a8a65b-e302-4747-bc90-4920fc48795a@gmail.com/
> >> Suggested-by: Jacky Huang <ychuang570808@gmail.com>
> >> Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >> ---
> >>  drivers/clk/nuvoton/clk-ma35d1.c               | 2 ++
> >>  include/dt-bindings/clock/nuvoton,ma35d1-clk.h | 4 +++-
> >
> > Please do not combine patches.
> 
> I thought splitting these changes would not make sense in this (= a fix)
> case, but fine.
> 
> [...]
> 
> >> @@ -248,6 +248,8 @@
> >>  #define ADC_GATE	233
> >>  #define EADC_DIV	234
> >>  #define EADC_GATE	235
> >> -#define	CLK_MAX_IDX	236
> >> +#define PCLK3_DIV4096	236
> >> +#define PCLK4_DIV4096	237
> >> +#define	CLK_MAX_IDX	238
> >
> > This cannot be updated. If it has to, then not a binding and should be
> > first dropped from the bindings like we did for most of the platforms
> > having similar issue.
> 
> When you say "This cannot be updated", do we agree that you mean
> "CLK_MAX_IDX cannot be updated"?

Yes, the MAX ID.

> 
> I'm not sure I fully understand the reasoning behind, because the whole
> point of defining this CLK_MAX_IDX value is to let drivers know the
> number of clocks, so it must obviously follow the updates in this
> file. I cannot just drop it, the driver does not work without it. If we

It's not a binding if it has to change, because bindings should not
change - otherwise they break its users, because  since it is ABI there
is an outside user expecting EXACTLY this number of clocks and it cannot
grow. Obviously, this is not a binding just like FOR EVERY other case so
can be safely dropped.

> enlarge that number, what is the problem as long as we keep the other
> numbers identical?
> 
> Maybe one way to fix that mess is to:
> 1- Add the 2 new values (238 and 239) + a new define:
>    NUVOTON_MA35D1_MAX_IDX 240
>    238 would then have two definitions for a short period of time.
> 2- Replace CLK_MAX_IDX by NUVOTON_MA35D1_MAX_IDX in the driver
> 3- Drop CLK_MAX_IDX in the bindings.

Why we can't fix it like we did everywhere else?
git lg -- include/dt-bindings/clock/
and search for "number" which leads to recent commits like
d10f26a7abbd3dd5d59bac1acdca117385b54ea9
but there was same work for Samsung and many others (Renesas, maybe
NXP?). You add define to the driver, then drop it from the binding. Can
be a few commits like we did for many cases, but recent change from
Linus I think went acked while combined binding and driver.

Best regards,
Krzysztof

