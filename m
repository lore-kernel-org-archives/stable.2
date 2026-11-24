Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541778;
	b=LeUiFmAroTyZOnfJu/Y8KFJ0dvZ1reQdR/ggOdysp456kuog7bQQn3Fj/8pNlScKL73/
	 g/41yxzGzXJ86i1SPPcbbTcQufHQCt2O9rsNA9uKQTCPxw42zvW0PGmGSTMtH/fdHB1wP
	 QXeHQwcnRchxBrYiElEfl8NB1ZXE8H9NPTHC//qr9RSDbkars/StJ1aw/+1IhpEmZXtlJ
	 MC2KNSwIqubp/jmlVl40WTGaaZzrFnEN58LBnXDdKMrE9rHou8yolpzf3EyfmbClgBY8a
	 hUEjUqdwjVHaf/KieDXbTgm0539o3YkWbOn4379qPT+vHyspv8Qyl4qU8fhdV2t+CoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541778;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent;
	bh=tfymlDcljSjuvF26uzxj/WXRQgXdLURskmE2fWlkPsA=;
	b=EAuSwzV4frJ1r4uqOk20rl48D1YWimxP9lzsqPwyYoUmP0eFVzgDhijsrOqsJV0uRXJ1
	 zvY33KTJiW9buW218jEz1dgIcRguParOz+9aR8yqJHFz4FhduwlMdF7voxoMeSXS3qtcA
	 nP5HNseH86k76cKbHXDGYRXqRZw+xLZQ+LW1aLYytlWYrM26meEgjJ1BcdPlvDECzrJ1q
	 nQ7CIQBxV53DOWUm+XUU0WSSCl0bbE0WISsagstZchc1OXd22zA0bLQAgsqVSzzwWsb7q
	 drDHrALU97h87oSXChgYA0Gs1fYcSkuEKGAWPv2d2awijkEqps1sMO2kCfO6zkz0+Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yf05ie99;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCB606A31E;
	Tue, 24 Nov 2026 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yf05ie99
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037221F000C0;
	Tue, 24 Nov 2026 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795541778;
	bh=tfymlDcljSjuvF26uzxj/WXRQgXdLURskmE2fWlkPsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yf05ie99WCEH3z5Bh5ZjkjaYMGpqa5c0dWCUG/aleYLfppE+V+1nkgGoTgNv2woQL
	 q91oJAz+jzY84f1fDS3zTVyUgXljZFKWNQyxfqjdMwRWFyYHpey7LSg1i/OX5essit
	 /0gQAJun5dgptmQJGRZ6EOE1cvo5xZdDgLE+n3Qc/PaK6RE7DEEeZyc9Rqxs7zMjG/
	 yRB4VSJMcFHzaAV+YehR2OunxXCnMrpakiuMCAfJscLSMmlqfcsFUexdR7vkJLuc7J
	 F0poHPePg+2XGAJa5vW8i3Sp75+1JqQI0J5EPNWvHE/gWyO0E21vuiN0spUR9tYpfI
	 K9+NSpE9XxcXQ==
Date: Tue, 24 Nov 2026 12:36:12 -0500
From: Brian Masney <masneyb@kernel.org>
To: Lee Jones <lee@kernel.org>
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
Message-ID: <awXLDDmHUpELwCio@x1g10>
References: <20261123164834.3330320-1-lee@kernel.org>
 <20261123164834.3330320-6-lee@kernel.org>
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
In-Reply-To: <20261123164834.3330320-6-lee@kernel.org>
User-Agent: Mutt/2.4.3 (2026-10-09)

Hi Lee,

On Mon, Nov 23, 2026 at 04:47:38PM +0000, Lee Jones wrote:
> When CLK_SET_RATE_PARENT is not set on a CLK_DIVIDER_ROUND_CLOSEST
> divider, clk_divider_bestdiv() invokes _div_round_closest() before
> clamping the resulting divisor to at least 1.  If the requested rate
> exceeds parent_rate (for instance via clk_round_rate(clk, ULONG_MAX))
> or parent_rate is zero, parent_rate / rate evaluates to 0.
> 
> Passing down == 0 into __rounddown_pow_of_two() triggers an undefined
> shift and truncates back to 0, after which DIV_ROUND_UP_ULL() divides by
> zero.
> 
> Since a divider cannot increase its parent rate, return the minimum
> valid divisor directly whenever rate is greater than or equal to
> parent_rate.
> 
> Fixes: 9315514252a9 ("clk: divider: fix calculation of initial best divider when rounding to closest")
> Closes: https://sashiko.dev/#/bug/linux-cc7c0851-a317-4348-ab29-9d748aa20cfc
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/clk/clk-divider.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index f68216c65d3d..d05dc595ec4c 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -244,6 +244,9 @@ static int _div_round_closest(const struct clk_div_table *table,
>  	int up, down;
>  	unsigned long up_rate, down_rate;
>  
> +	if (rate >= parent_rate)
> +		return table ? _round_up_table(table, 1) : 1;
> +

Carlo Caione posted a separate fix for this that I merged yesterday.
Patch 2 in his series covers what you posted.

https://lore.kernel.org/linux-clk/20261119-upstream-clk-divider-large-rates-v3-0-838eccd2e497@baylibre.com/

Brian
