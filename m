Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681519;
	b=MB/gY+miB4VeIYTSjZXNTKu82OQxdNz+W3GzXjjEL8f0nXM6R3dYKe9kgvb9R0LIQAQI
	 WvJ09lhqULxO3+e9tI+BcILPszd8dZuncg5keUZTHDbZijk17SRw5NYX09k6D7z4qvzuQ
	 V35g6K+O1V+MSOXYfxPCbD16HQN8u+OV4qd32x7AWtvlGWhshc5w2SwSGT71PG6uU8z0+
	 YRfArDByFXy78jHuBL80X4aAmeuc2LrgadSilLQBZ7P+wMJdOL6UIKy5jX1JM72xxCAhJ
	 i/R/WYK4AJPot1OJa/TBDXU4Sy6bcyuOUuwNa/ketwbRX5ZIYfymTIdPttSqp5ad4mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681519;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nasJW35t/3GDXcnrQth4xXcfZ6A0BlwMudYBlU7KjCs=;
	b=ciWGZ9tT4OcTp8tCm2n5lYF+oLMzXn0kje1tI4cCd2ZdLL4Vv8JK19Dw0c1cLqmm4Iqv
	 vwxYQJbyYNWtl4gKfenIeQbzZ4xZsgpZgbhvK39vdVPc/zRBtdm+fKiEHvAgJy5h5V7hr
	 eQPLdPv6u24tI4FiWgm1puAlTU78LbzAIv3pItulzrA3GXQrhlzGB1MiaCtBtyTTpSsiJ
	 Gf4vooUhlP3Fj30P8agtTRA4EYQHNQiA8ixw81oRvdCVJoq3AzscrRNPZqCkLYK6t0NE8
	 pr66XZxOnTIlp4lG8WabtKxSRoa2lFslSAvZQxHQ2qv3e8j9h8tO8BmaK+VG2HmrdJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTBWCJyf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A4606A33B;
	Thu, 26 Nov 2026 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTBWCJyf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987731F000C6;
	Thu, 26 Nov 2026 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795681518;
	bh=nasJW35t/3GDXcnrQth4xXcfZ6A0BlwMudYBlU7KjCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TTBWCJyfFXUVV2nsweHhl2exzA27u/yHLeFjqSovhBZJVskH8jwmKRE+BT7dMaHvj
	 1S7TlVsSvD48kwdqCyPwMhe1/GtZsKOvMGxE9tyhoC0+doAiVyAsIHuN4vN3WCJKN+
	 m6HKdRFpSDn2xW7B5dXaczA8PV7SPrQWVVE6kWVCV06vQDV21X1YaIB+oFBcvlQaVB
	 GkFqAbHhKLtPp5gJAk9oxLiE5iu4M0aBqvAPoM6aZe9RBCYzLOlWkBnLYQ56d2sFJO
	 OFy8Oz2TIuw56ke4jCPWavGQbcF52KBqfL0LrbXOUR/EADeoS08GAFmuO//rBc04jz
	 l71eqWlcke+SA==
Date: Thu, 26 Nov 2026 08:25:14 +0000
From: Lee Jones <lee@kernel.org>
To: Brian Masney <masneyb@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"Zhao, Linaro" <richard.zhao@linaro.org>,
	Linaro Ltd <mturquette@linaro.org>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 05/10] clk: divider: Avoid division by zero in
 _div_round_closest()
Message-ID: <20261126082514.GB38590@joneslee-macbookpro.roam.internal>
References: <20261123164834.3330320-1-lee@kernel.org>
 <20261123164834.3330320-6-lee@kernel.org>
 <awXLDDmHUpELwCio@x1g10>
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
In-Reply-To: <awXLDDmHUpELwCio@x1g10>

On Tue, 24 Nov 2026, Brian Masney wrote:

> Hi Lee,
> 
> On Mon, Nov 23, 2026 at 04:47:38PM +0000, Lee Jones wrote:
> > When CLK_SET_RATE_PARENT is not set on a CLK_DIVIDER_ROUND_CLOSEST
> > divider, clk_divider_bestdiv() invokes _div_round_closest() before
> > clamping the resulting divisor to at least 1.  If the requested rate
> > exceeds parent_rate (for instance via clk_round_rate(clk, ULONG_MAX))
> > or parent_rate is zero, parent_rate / rate evaluates to 0.
> > 
> > Passing down == 0 into __rounddown_pow_of_two() triggers an undefined
> > shift and truncates back to 0, after which DIV_ROUND_UP_ULL() divides by
> > zero.
> > 
> > Since a divider cannot increase its parent rate, return the minimum
> > valid divisor directly whenever rate is greater than or equal to
> > parent_rate.
> > 
> > Fixes: 9315514252a9 ("clk: divider: fix calculation of initial best divider when rounding to closest")
> > Closes: https://sashiko.dev/#/bug/linux-cc7c0851-a317-4348-ab29-9d748aa20cfc
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/clk/clk-divider.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index f68216c65d3d..d05dc595ec4c 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -244,6 +244,9 @@ static int _div_round_closest(const struct clk_div_table *table,
> >  	int up, down;
> >  	unsigned long up_rate, down_rate;
> >  
> > +	if (rate >= parent_rate)
> > +		return table ? _round_up_table(table, 1) : 1;
> > +
> 
> Carlo Caione posted a separate fix for this that I merged yesterday.
> Patch 2 in his series covers what you posted.
> 
> https://lore.kernel.org/linux-clk/20261119-upstream-clk-divider-large-rates-v3-0-838eccd2e497@baylibre.com/

Perfect.  Dropped.

-- 
Lee Jones
