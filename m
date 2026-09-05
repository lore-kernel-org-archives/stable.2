Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D6394EA7;
	Sat,  5 Sep 2026 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788646070; cv=none; b=b1Wu5RxzFFXWYTcFbpButTCZ4V0qGOxKkmXzlmqf3ubvKCzRvSe0Ost/leR9YqcfrNuk+/hVGlrYCWzq4kEB8ws9AW4P9mFfNxnspOHa7uL3IBne9aiSC83la/U8nvpAE+39v0yFfAijAYWvs7TZll//2+LdPtgX8r0eA7z9v3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788646070; c=relaxed/simple;
	bh=WhVCqZzlBHqiAMgywa/BodhPvC018gUb7lRZg83jExs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDZnymVosD7BL7WUDMpo7LIk0xBokS54HLKTPgSy2haAnphGDLSr1Wuh2cTbnAF3cE93TmAq3itwqt+Wc0KG9L2L6T0N5MAWAyQy+OI94sZGqq+9a+T1E3pcN5gjgK5eVe+ayueKLPUrLYKOQ0t1vLDmXURh0S3LClSiB5/VGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLWS2Q3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLWS2Q3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF281F00A3A;
	Sat,  5 Sep 2026 22:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788646069;
	bh=HV2wruqCLdbcGMXHglAtzJcwEp//cjsvhSFhrJ5SLX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dLWS2Q3g4i1xXVcGfStwz9rx94D/Vc3cl2ApEK+GbqBOUCERGKqkZ/tBnp73acSov
	 ettXpII6IsI+1fTdTrq71QhBmgamLEIS6WGb1G2yHCx3A1CAn7z2emkP7wbdMj64xj
	 tX6gvatgB5NQJcs2GnIlkPuLYsjGFiL8ZterC9DuwphOm3CI5gXB+eq3B88Xvi76CM
	 1R2ORP0RBu2t7yalThFddg3xW6VgUYvK3m9hNIhWL9mw7AEw3jrR5xoBG0MOX2znbp
	 z194CnrxIGNHVItevI4hhiyN7sc6XVG1S0IjPyqhngr1vshq3ehwFzYBsjMs8uUOrK
	 8ISuwpCLApBLA==
Date: Sat, 5 Sep 2026 22:07:46 +0000
From: Yixun Lan <dlan@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
	stable@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] clk: spacemit: k3: add CPU PLL rate tables
Message-ID: <20260905220746-GKC53903@kernel.org>
References: <20260903-k3-pll5-pll8-1800mhz-v4-1-afafd9cb47d9@linux.spacemit.com>
 <apmuG46sBg2rGzCD@aurel32.net>
 <DL67LEVCXFA5.39M5FO7JGKWZS@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DL67LEVCXFA5.39M5FO7JGKWZS@linux.spacemit.com>

Hi Aurelien, Troy,

On 11:24 Fri 04 Sep     , Troy Mitchell wrote:
> Hi Aurelien,
> 
> On Fri Sep 4, 2026 at 1:27 AM +08, Aurelien Jarno wrote:
> > Hi Troy,
> >
..
> >>  drivers/clk/spacemit/ccu-k3.c | 96 +++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 96 insertions(+)
> >
> > Thanks for the patch, it makes sense to add all the values, to support 
> > future firmware changes. The values match the ones in the vendor kernel.
> I forgot that you had a similar patch as well..
> 
> >
> >> diff --git a/drivers/clk/spacemit/ccu-k3.c b/drivers/clk/spacemit/ccu-k3.c
> >> index 92b930d5ff30..950bf531c734 100644
> >> --- a/drivers/clk/spacemit/ccu-k3.c
> >> +++ b/drivers/clk/spacemit/ccu-k3.c
> >> @@ -29,15 +29,91 @@ static const struct ccu_pll_rate_tbl pll2_rate_tbl[] = {
> >>  	CCU_PLLA_RATE(3000000000UL, 0x0b3e2000, 0x00000000, 0xa0558c8c),
> >>  };
> >>  
> >> +/* Keep the firmware default as the first entry. */
> >>  static const struct ccu_pll_rate_tbl pll3_rate_tbl[] = {
> >> +	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
> >
> > Is it really necessary to put this entry first? I guess it's the current 
> > default frequency, but we have seen it can evolve. From my tests, the 
> > driver seems to just keep the value configured by the firmware 
> > independently from the table order, so I am not sure it's necessary.

I agree with Aurelien here, the default frequency isn't a solid stable settings,
which it may changes in the future

> I think keeping it first is necessary. If the current register settings do
> not match any entry in the table, ccu_plla_init() falls back to the first

Isn't it a bug if all frequencies added still couldn't cover all settings?
I'd simply suggest to bail out and yell loudly if there is a mismatch

I just don't like putting specific frequency at first one as default,
this logic is kind of fragile and tend to fail easily..

> entry:
> 
> 
> 	ccu_plla_update_param(pll, &pll->config.rate_tbl[0]);
> 

-- 
Yixun Lan (dlan)
