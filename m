Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681492;
	b=wZrNGYdJ71EKNBlDfQxOpNukVg4bCyBLrib30/Mm01J2GafzZJ8YKI149ZcZeT8yt++q
	 FB0yeOXyrVVsouWTmfCVO3lpygihHeIROtnFknrg0+cCkCWhbUI6nwrxMfW50XpWisyit
	 6FC0KURXBZo5qf6TYn/v1tUbP7B7eVtEA3oRKycl4Gr9z5djGdkEsXFViqq+pMvvQGRKo
	 LHhGk7Lu27VL0VDmH9ZCK4WagvMjoqbbwlmeK1r0qA3ZKTyr0CLY7LxrteN2e2CuiVUmg
	 9ufB3PwANw6Hr6pQsu5ZmMbI5vumxa0GvI2A0GJ2pMcv9ctCYDjt60CkidtCx7ffzPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681492;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c/xuhSgrDi5Evjz9QC5SNlbLmx4tXIO0jjq3+L8fUUU=;
	b=X9svkgC8NIpHJ7BaZU1u5A5xugD9wFHQHPsEcxGqPI8IXV7G3bjv3z7QEzrsjjwB0Uqc
	 U2BHO+u8G8Mt6X/EnvWVC0Ah8mWvW7kwv2JecFnk27WteLc4LJUbgZOFK/+9OSb11LJOi
	 a7kZOj3buBNIk+FWRY7RKV/TiSahqJQBEZQ3IVnzabO9UiPWKs+Hwvh8DEZ6UK+EBIdQ6
	 VEqROZirhczj2m6bnXk/GOMQLpHPt2Seh4l22Zzv7JVkuzfS0+AbJTwaHkHNiX8l+5Z5x
	 93swBa2qkp85NUtcEJcd6Ou7hHkMSthQOX6kT0iWjL5u4i2Y+GPU6gSOk86hQGIrpHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ebY5K/EX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006BE606A337;
	Thu, 26 Nov 2026 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebY5K/EX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8278D1F000C0;
	Thu, 26 Nov 2026 08:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795681491;
	bh=c/xuhSgrDi5Evjz9QC5SNlbLmx4tXIO0jjq3+L8fUUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ebY5K/EXh6yUpAOaOGAPYixvLgD2Hm4OrXdy41KYC7GFjEnm1HvucHNEQg/F9u09q
	 9VVlMugAis7yAYoD8wgebw4oKaTfK748lz9VIr6cihO64oKMc5VKK4T53dZkoEjzpd
	 TEfHarhqFFo/uEotTRSdIUSPF1XCA/gmyMZCiXwn0IavCPwImzgNhk0ShIQ0hMDZWt
	 drPqF28vZBjUXcvQfs58wcE8md+suSJBBa9bKI6ReTacUA0MThjU3yNLSMjIjdmtpj
	 MQXbbWNKJ4DAbgNiI742ymc0G+MVhRXDVOrZsxHtivwFUm0iLTB3u4GOe1MpTADjsy
	 Hwh7k3XHXv3Wg==
Date: Thu, 26 Nov 2026 08:24:46 +0000
From: Lee Jones <lee@kernel.org>
To: Brian Masney <masneyb@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>,
	Joel Stanley <jms@oss.tenstorrent.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 08/10] clk: tenstorrent: Poll atomically in
 atlantis_clk_pll_enable()
Message-ID: <20261126082446.GA38590@joneslee-macbookpro.roam.internal>
References: <20261123164834.3330320-1-lee@kernel.org>
 <20261123164834.3330320-9-lee@kernel.org>
 <awXYHBcmdDQ9OvlD@x1g10>
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
In-Reply-To: <awXYHBcmdDQ9OvlD@x1g10>

On Tue, 24 Nov 2026, Brian Masney wrote:

> Hi Lee,
> 
> On Mon, Nov 23, 2026 at 04:47:41PM +0000, Lee Jones wrote:
> > The Common Clock Framework invokes .enable callbacks in atomic context
> > with interrupts disabled and enable_lock held.  In atlantis_clk_pll_ops,
> > atlantis_clk_pll_enable() is registered as the .enable callback yet
> > waits for PLL lock using regmap_read_poll_timeout() with a 500 us sleep
> > interval, triggering a sleep-in-atomic bug via usleep_range().
> > 
> > Since the PRCM regmap is backed by MMIO, use
> > regmap_read_poll_timeout_atomic() instead.
> > 
> > Fixes: 23c8ebc95284 ("clk: tenstorrent: Add Atlantis clock controller driver")
> > Closes: https://sashiko.dev/#/bug/linux-980395a6-f282-478a-bf18-b5695a725735
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/clk/tenstorrent/atlantis-prcm.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clk/tenstorrent/atlantis-prcm.c b/drivers/clk/tenstorrent/atlantis-prcm.c
> > index eccc8015da23..d9155f133713 100644
> > --- a/drivers/clk/tenstorrent/atlantis-prcm.c
> > +++ b/drivers/clk/tenstorrent/atlantis-prcm.c
> > @@ -313,10 +313,11 @@ static int atlantis_clk_pll_enable(struct clk_hw *hw)
> >  			   PLL_CFG_EN_BIT, PLL_CFG_EN_BIT);
> >  
> >  	/* Step 3: Wait for PLL lock */
> > -	ret = regmap_read_poll_timeout(pll->common.regmap,
> > -				       pll->config.reg_offset, val,
> > -				       val & PLL_CFG_LOCK_BIT,
> > -				       PLL_BYPASS_WAIT_US, PLL_LOCK_TIMEOUT_US);
> > +	ret = regmap_read_poll_timeout_atomic(pll->common.regmap,
> > +					      pll->config.reg_offset, val,
> > +					      val & PLL_CFG_LOCK_BIT,
> > +					      PLL_BYPASS_WAIT_US,
> > +					      PLL_LOCK_TIMEOUT_US);
> 
> This should actually be converted to use the enable lock instead of the
> prepare lock since this will sleep with interrupts disabled. The _atomic
> variant won't be needed there.

Thank you Brian.  Can do.

-- 
Lee Jones
