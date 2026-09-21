Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409F2BE7AB;
	Mon, 21 Sep 2026 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789960352; cv=none; b=X+DYujS5YX2e5/hV+kIO9dqGgL8RmPm6RK1X79M7hQdfjVVHSMjpCuKyQinvAKg+q3c8qRsleMVdoX1O3jEj4Dg0M69J+mfMUikAmixGs6MRmDMiXKKgKSGeumvAkcz+SX2HH6wxnVEwv0RmHf78o74gMZ0bQKshOkpH6RQTYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789960352; c=relaxed/simple;
	bh=/TgW0izMlLvXwZCoaKmgo+gMum7TBSerwnEC+Uhng/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqRlPW2asBFm7JGSW9EgAN0UNOJ6diGTcQFE36pA7aUGgJnluhaefLLgvJsEQwMQJVf9dY15os1OHKJOoDRZBW8/gbqgNNsY/jqlKF9mUbXJgO+S/aKpy7I5W1/kNC937aZZjcXRiFe1glXNV1upq/F5SjRkc8yNzDhAuTN31Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuEgcyOU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuEgcyOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857401F000FF;
	Mon, 21 Sep 2026 03:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789960350;
	bh=zWCK6aanCSv1/HqMYDhAojJGa1rXakbbnFRunDjG5qU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DuEgcyOU9QMbevZ7VjJ0V52RoL0Fj26OU2vpOYnu8zGMvWrhcITAzRq7Ng2U8vRkU
	 ltk5FCVJjVrJgv4GRBgrGH3b/4zYARcYn3XltDR6ionyWh3CRPJl/Vx2euj3PypkUV
	 FTBuIXvvIC5GiC8ZJ9ABsON6Xhie4OtD6RHB0viLKu2XueWK6qZM3qaih/wuJVV10f
	 1litv7ZF9fTkdeMx1O0D7Bs2swS+RUcvmPDWURuNKv9R9BscxX9D5SnDrwJ7S7M1ei
	 CbVHIzWBYKGUduDfSzgipDtRAeB1L/RHhK3W7/xqaUVUSwd8FaxZA8kPaEpimIDlkA
	 RNkn/vV/MAUKA==
Date: Mon, 21 Sep 2026 04:12:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ade9000: fix NULL pointer dereference in
 clkout registration
Message-ID: <20260921041227.61e00143@jic23-hlaptop>
In-Reply-To: <20260831005728.4c2b80b9@jic23-huawei>
References: <20260826083156.2287106-1-lilinmao@kylinos.cn>
	<20260831005728.4c2b80b9@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 00:57:28 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 26 Aug 2026 16:31:56 +0800
> Linmao Li <lilinmao@kylinos.cn> wrote:
> 
> > ade9000_setup_clkout() passes NULL as the register address when
> > registering a divider clock. During clock registration, the common
> > clock framework calls clk_divider_recalc_rate(), which dereferences
> > the address through readl(). As a result, probing an ADE9000 configured
> > as a clock provider with an external input clock crashes.
> > 
> > CLKOUT passes CLKIN through without changing its rate. Register it as
> > a 1:1 fixed-factor clock, which does not require register access.
> > 
> > This change does not affect the configuration using the internal clock,
> > for which the driver does not register a clock provider.
> > 
> > Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Linmao Li <lilinmao@kylinos.cn>  
> 
> Looking for a tag from Antoniu for this one.
Antoniu

Please take a look at this.

Jonathan

> 
> > ---
> > Changes in v2:
> > - Clarify that the configuration using the internal clock is unaffected.
> > 
> >  drivers/iio/adc/ade9000.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> > index e57e24b6acdf7..4e96cc37fbedf 100644
> > --- a/drivers/iio/adc/ade9000.c
> > +++ b/drivers/iio/adc/ade9000.c
> > @@ -1647,8 +1647,9 @@ static int ade9000_setup_clkout(struct device *dev, struct ade9000_state *st)
> >  		return 0;
> >  
> >  	/* CLKOUT passes through CLKIN with divider of 1 */
> > -	clkout_hw = devm_clk_hw_register_divider(dev, "clkout", __clk_get_name(st->clkin),
> > -						 CLK_SET_RATE_PARENT, NULL, 0, 1, 0, NULL);
> > +	clkout_hw = devm_clk_hw_register_fixed_factor(dev, "clkout",
> > +						      __clk_get_name(st->clkin),
> > +						      CLK_SET_RATE_PARENT, 1, 1);
> >  	if (IS_ERR(clkout_hw))
> >  		return dev_err_probe(dev, PTR_ERR(clkout_hw), "Failed to register clkout");
> >  
> > 
> > base-commit: 6b9f23b5460818aaf199dda90210d5fc08d66c8f  
> 
> 

