Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121247;
	b=e9jxsBmvvwtwkhm37OyNrujl8N2aOO4b/tbJLHFUHPfcA9C+BKxfsEe+c5WEQYCNrRA1
	 WtngHTU7E7pypbVfcSd30F/EoNEIYC9qwJgBXqA9SEp9jrexYr117sFgTxsf+rNcK+jag
	 aVzqriKbjGiZj/ExWxx0eOoBMW07c6zZwz8+NER0ASfX5tajqnd07ubKAe5lmWuIdr5Mx
	 99UqWL06IB+wNQkQSu7c9jdW4gcRaSxjnrUFLS5tCq/NVFCSwn71TjZX0TnntxhczpWzU
	 SG8oeLt8fqRiJhEn3w71ZTCTEPkSpfnmuD5j5bxL02ixjpbOHfozJoGI3P/N/EWtjCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121247;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=oWnPtJZp3/d7O2W2600QUE4sy9NoO/qDkyZiDfM73I0=;
	b=ZmeERyaniMGYEv179DdkehOTJyGR2pJGwhk7LGYAEXXyQar+4IYdcqXtkXn44fFrBQtR
	 X0wfrVdCv+ho0VdbCBXXs2Yru3SKkxF3omTJcwNDI/vrGZ/dOwuH/OWgSOYdsdwiylIXL
	 QntRvs+kojrWMrXyw8mk3Uiq3hJGKfns/GlO6sURqSNP9E/Vmwz9s37lL3yTaZ1Z9fQWE
	 B6z9j+rxiFUEPtzb+xDvRwq5Ffmh/NeQaa0HbNW0MSIhr7yaSl5DD4T+xzUeeghUwbCCp
	 UJCyXQbeo48zShYPf/QTYS1A9SgAbaPDH/rWWKpOw+BClEb3vG09GtmEKvs2N/GpSSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjZMbCmm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0B606BBA1;
	Thu, 19 Nov 2026 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjZMbCmm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63E81F000C0;
	Thu, 19 Nov 2026 20:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121247;
	bh=oWnPtJZp3/d7O2W2600QUE4sy9NoO/qDkyZiDfM73I0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=AjZMbCmmahThX1sCj7xzM+RGiOyanxGA5WLDuAMu81VqSeKPQHM3Aa3Vs3TZifWSV
	 t85MpjeN4Gu+eb7cBa0qQzpOMU9D+IRHAKPZ3ncoct0ld76I/XPMbs3oNnBADf9uKe
	 7yGbVvnqWy4pwAeZs1nY308K650q8+BBqVrzeS7CGY/25mgEr39W2OVs4nEWNRu00C
	 eU6+Q9UudMOgN1Mssv0NjcRNgsw1oCZ90PIGZ7l82wqcXN8/HcSzoBYKpLI9Hh+bMJ
	 rxKSC1L8Mx02onbarOpexRYh5bXSpuF7xnE8Y5xVYvOgDvjo39wpmotYvHP6v1uKZC
	 Q4s4xxvfdWNLQ==
Date: Thu, 19 Nov 2026 21:47:24 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Lu Huang <huanglu@kylinos.cn>
cc: "Daniel J . Ogorchock" <djogorchock@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Martino Fontana <tinozzo123@gmail.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: fix lost update of player LED state
In-Reply-To: <20260928085433.1129896-1-huanglu@kylinos.cn>
Message-ID: <1spq2r04-5so8-7ps5-r489-727q3sp477ro@xreary.bet>
References: <20260928085433.1129896-1-huanglu@kylinos.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 28 Sep 2026, Lu Huang wrote:

> The player LED subcommand programs all four LEDs with a single
> value, so joycon_player_led_brightness_set() must aggregate the
> current brightness of all four LEDs and send that snapshot
> atomically. Commit 928276075f16 ("HID: nintendo: cleanup LED
> code") moved the aggregation loop out of output_mutex: if an
> update callback is preempted after reading the four states and
> another update sends its own snapshot first, the preempted
> callback later sends its stale value and silently reverts the
> completed update, leaving the hardware LED state inconsistent
> with sysfs brightness.
> 
> Move the aggregation loop back under output_mutex so reading
> the four LED states and sending the subcommand are serialized.
> 
> Fixes: 928276075f16 ("HID: nintendo: cleanup LED code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Huang <huanglu@kylinos.cn>
> ---
>  drivers/hid/hid-nintendo.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 43e0f2aaea3b..b0d7c91490f9 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2264,10 +2264,9 @@ static int joycon_player_led_brightness_set(struct led_classdev *led,
>  		return -ENODEV;
>  	}
>  
> +	mutex_lock(&ctlr->output_mutex);
>  	for (i = 0; i < JC_NUM_LEDS; i++)
>  		val |= ctlr->leds[i].brightness << i;
> -
> -	mutex_lock(&ctlr->output_mutex);
>  	ret = joycon_set_player_leds(ctlr, 0, val);
>  	mutex_unlock(&ctlr->output_mutex);

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

