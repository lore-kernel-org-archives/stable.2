Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229D380FD2;
	Tue,  7 Jul 2026 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398321; cv=none; b=mb+jfwTLWeD+6Qr+V8BQSwTJM67GT7wIuldsWZojeyXLoPxSBdYPgsO/9AQhvfQzD8eTsJ7DC63TJYrJQxef9loIH+2JeZRh01vdv0FTF/Qrfaka0pGKy9n5u4Xbqb0Qj/vJtPtDe8Tfm1a07deOjQ8dKd5XZDhDpubrDfWIXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398321; c=relaxed/simple;
	bh=MwSTrKAQv4+8butGz3AGfSkozkAtCqBxCmB3MyfLtDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFP4t5A4xrUl2ZvkscQtgCO8ilKv5vzguWoHJbmNyCUX0ZfN0zZrF2Rgxo8VTmB0FIG4Fk3gNL0G24GrypnUDl6SXOqtyOky55nDk6wQx1Ug7vqR12xqyT2P3lJ8zZImjMl/0xx4fhiSBQnUCo4IGPxImHGyt2jv0w31vGFKwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0zhNCZ2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0zhNCZ2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0BD1F000E9;
	Tue,  7 Jul 2026 04:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783398319;
	bh=zXq9kCinRT0jpDkd1AT4yOu54wVqXbO+1SiH4cMUCW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0zhNCZ2u/fbPoO+sXdu022Fd6bPrQ1WmVhfcuKUfwW6TNefcyhG++z9QQGfgmcLMK
	 GqAYHuZT+jCbxTafqu+EShqu64Ij07rniEwB+h8g6ttK7GN3MNRBC9uI2RirrlZSgC
	 nbwQKs8CBG198lqm6uIJDSnfMY28cFh6SDvFCsAI=
Date: Tue, 7 Jul 2026 06:25:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brian Masney <bmasney@redhat.com>
Cc: WenTao Liang <vulab@iscas.ac.cn>, paul@crapouillou.net,
	mturquette@baylibre.com, sboyd@kernel.org,
	linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] clk/ingenic: fix clock leak on clk_register_clkdev
 failure
Message-ID: <2026070706-slacking-legwarmer-95ed@gregkh>
References: <20260628122811.44799-1-vulab@iscas.ac.cn>
 <akwJCq9uUY3rzFxe@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akwJCq9uUY3rzFxe@redhat.com>

On Mon, Jul 06, 2026 at 03:59:06PM -0400, Brian Masney wrote:
> On Sun, Jun 28, 2026 at 08:28:11PM +0800, WenTao Liang wrote:
> > clk_register() succeeds but clk_register_clkdev() fails, and the error
> > path jumps to out without calling clk_unregister or clk_put to release
> > the registered clock. This leaks the clock object within the common clock
> > framework
> 
> 
> > , contrasting with the CGU_CLK_EXT type path which correctly
> > calls clk_put on error.
> 
> I would drop this part. Just focus on what you are fixing.
> 
> > 
> > Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> 
> I don't see where on the v1 Greg suggested this, unless I am missing
> something?

I did not.

> > Fixes: b066303fb3e7 ("clk: ingenic: add driver for Ingenic SoC CGU clocks")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> > ---
> > Changes in v2:
> > - Fix patch format based on reviewer feedback
> 
> Link to v1: https://lore.kernel.org/linux-clk/20260626115644.33779-1-vulab@iscas.ac.cn/
> 
> With those fixes:
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>

All of these need to be dropped until the submitter learns how to
properly submit things.

greg k-h
