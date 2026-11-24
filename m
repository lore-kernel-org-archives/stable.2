Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545120;
	b=ayzL8+2Vt6TWzJmOLp9V5umLAQbNlrZkkL+gHQX69CuwKQOt/EgfKB06IL221nwk9297
	 Q18Dlp2S/WCFx8p+OeOOU0sOMBQ6m0byXl/M/y6vuDfSZD1ECbLrBQPQilfPw7IJgT1XU
	 ia1z8SM1jPXMQgTe9wq63zMwzAypEbmYHrMYz3NU4xUdXweDmvTvDOwgWD+8wHpcWuyTZ
	 KVj7HWmsVmrBvhQAAzSzwyjH2RK0tcCJWlq3Z2NMC9d1nR+0i9AHY+Tz7tNuf1qJRLbxZ
	 1kdZ25leDyyvAIuxEBrdIVAOeO5TvlDTnIuOBi+NWm4ZONinAruJkWJlGYbsudEipDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545120;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent;
	bh=gw/J6tsrEEBYQGZcVt2c5cjvJDfXcBGni2CbulyGeQM=;
	b=uCV+wbJzCKFiJMUcxGVc2Jm2gRCzWlv19mDKSDpMlgIAZRQiMzmXvg0oc/o3ip89XVVu
	 EspTrc0Uzmf8WkSQIvLAnenPI/bGd/ZX06ie2vlt6wJaeFzlvuxN96OL+Ey6DRUd6dZ17
	 5+k+fXnVxHlZcZ616diwNbsjQ+YS8Do2zyZ0cmIgnEPAlz0jLfQjp2bNkqIUKk5U0HVfO
	 /xZsEZwFNf3D9tj2plY0L15wLp9tvLxy/78AszfhYEHFQ+vcAi06rrSjjjJV79quD8ZYW
	 Y2AhvGtTJx2N05kCAl6qIzgz+eDl4HplJ7GaymRv2uXIbQDgA4IknxfLkT2J+NRUamw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZzTrYeD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E9606A31E;
	Tue, 24 Nov 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZzTrYeD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087051F000C4;
	Tue, 24 Nov 2026 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545119;
	bh=gw/J6tsrEEBYQGZcVt2c5cjvJDfXcBGni2CbulyGeQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XZzTrYeDqn0b1CMgtlMjAD0oeEVxxe0f2v6I1ntpfCuzWkLiuvfwl7s4n5VqAC6DU
	 xmVE+ZHysFW+GEoreUW7STi1p9rsvFt3OVxJ/fJ79j77hlpcCUezvLZhPRTYggyWRZ
	 gDe5m5bfA3egdwacje+pIMEiNFscAXgvd/SH7+vYB+FPSIN8J4HWjbm8tHU/I7Hxa9
	 IJdxsFTILMp6OV1FWbJJrGPeeS77oJ/UNHnqvwIIUr1d3Qb30Lnyjb3DC/yPtlBreg
	 5WSPEHYqsYZjWlLcBkGJOMtkKRlOj9LTCTTQNpNXi85g1VYNBMdunnSata6wwEF6OF
	 P1386DUcOZ6Rw==
Date: Tue, 24 Nov 2026 13:31:56 -0500
From: Brian Masney <masneyb@kernel.org>
To: Lee Jones <lee@kernel.org>
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
Message-ID: <awXYHBcmdDQ9OvlD@x1g10>
References: <20261123164834.3330320-1-lee@kernel.org>
 <20261123164834.3330320-9-lee@kernel.org>
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
In-Reply-To: <20261123164834.3330320-9-lee@kernel.org>
User-Agent: Mutt/2.4.3 (2026-10-09)

Hi Lee,

On Mon, Nov 23, 2026 at 04:47:41PM +0000, Lee Jones wrote:
> The Common Clock Framework invokes .enable callbacks in atomic context
> with interrupts disabled and enable_lock held.  In atlantis_clk_pll_ops,
> atlantis_clk_pll_enable() is registered as the .enable callback yet
> waits for PLL lock using regmap_read_poll_timeout() with a 500 us sleep
> interval, triggering a sleep-in-atomic bug via usleep_range().
> 
> Since the PRCM regmap is backed by MMIO, use
> regmap_read_poll_timeout_atomic() instead.
> 
> Fixes: 23c8ebc95284 ("clk: tenstorrent: Add Atlantis clock controller driver")
> Closes: https://sashiko.dev/#/bug/linux-980395a6-f282-478a-bf18-b5695a725735
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/clk/tenstorrent/atlantis-prcm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/tenstorrent/atlantis-prcm.c b/drivers/clk/tenstorrent/atlantis-prcm.c
> index eccc8015da23..d9155f133713 100644
> --- a/drivers/clk/tenstorrent/atlantis-prcm.c
> +++ b/drivers/clk/tenstorrent/atlantis-prcm.c
> @@ -313,10 +313,11 @@ static int atlantis_clk_pll_enable(struct clk_hw *hw)
>  			   PLL_CFG_EN_BIT, PLL_CFG_EN_BIT);
>  
>  	/* Step 3: Wait for PLL lock */
> -	ret = regmap_read_poll_timeout(pll->common.regmap,
> -				       pll->config.reg_offset, val,
> -				       val & PLL_CFG_LOCK_BIT,
> -				       PLL_BYPASS_WAIT_US, PLL_LOCK_TIMEOUT_US);
> +	ret = regmap_read_poll_timeout_atomic(pll->common.regmap,
> +					      pll->config.reg_offset, val,
> +					      val & PLL_CFG_LOCK_BIT,
> +					      PLL_BYPASS_WAIT_US,
> +					      PLL_LOCK_TIMEOUT_US);

This should actually be converted to use the enable lock instead of the
prepare lock since this will sleep with interrupts disabled. The _atomic
variant won't be needed there.

Brian
