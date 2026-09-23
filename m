Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E33DB980;
	Wed, 23 Sep 2026 04:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139501; cv=none; b=OnJIeEWLYTGmJQLH0dC/L7oNEprcY5z/L5dkK1Dzjm2hYTnx1kgZ2jafPXE/UBd03dVijyXiwftVIDzWKj47GQ66B+oElKknONzqaeDKZezLgHIGpgPn+TPcnNxiCHkzjlqMAcOvc6fpsjr5wvRFIqMsyD5AHnh/cQrtiReVRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139501; c=relaxed/simple;
	bh=0O7Qbn9ypfQ9zZWlgHOXElAWzkeKpFIF5/TQcUE/Dgo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qh3REugT4OSqBGqYIyJdme2ySO7F5PH5Y10GEPC9Y6mko5opZqbasJkAq2jXwgmh5kwbyv6n7z6c5jZQD8aeIsqRpmCdG/pIa/DIidPwBgWxP0Tu82ZqcwG38aRiZ9wLDADfW0sV6PRjZyOa1IGvruNm/35y8Mo8IeoNHYns0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvUZBnEg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvUZBnEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B57B1F0089E;
	Wed, 23 Sep 2026 04:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790139485;
	bh=1dORtqh9tfuV7OLMSLjdAMnWKy3PkAytnsZmL2OHJl4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CvUZBnEg5EP5DUYtilhOLkycsGUBlM693L6TcGCrD3NafaX6FCt7sksUHeCKMp9nG
	 ONI3cGIyM6DqsXf6VH1o4EXH7Xog6rTW4aJkqgQ1Xrt+ZzoTaOoOVGpl4BYhfAIIlY
	 LVnB315+V7to/qANZ55TFOj4axoV/WUqHqFy2m9JjZHLEc6i+P9AJlXhW9xOnmqNLB
	 FhWHl/pymrT221hc5t/cjPFZCfW29iK1/a7ypoMmeaoZo3cWAcx8WRI4kvugbmPPwp
	 JBRNkaRlWLbtyfkpLIuLjM5OG0bAnlgFl2eWLT43g3uSacXaWl9S1+S2VpsshJqgbQ
	 22LnPV86bEv3A==
Subject: Re: [PATCH net v3 2/2] net: stmmac: fix a divide by zero in
 stmmac_xdp_xmit_xdpf()
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xiaolinkui@kylinos.cn, stable@vger.kernel.org
Date: Wed, 23 Sep 2026 04:58:03 +0000
Message-ID: <179013948372.2160803.7295436112506257329@kernel.org>
In-Reply-To: <20260921135716.218420-2-xiaolinkui@126.com>
References: <20260921135716.218420-2-xiaolinkui@126.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The zero guard added to stmmac_xdp_xmit_xdpf() performs two
  separate, unsynchronized plain loads of priv->tx_coal_frames[queue]:…

Pre-existing issues:
- [Medium] With `ethtool -C ... tx-frames 0`, the new branch in
  stmmac_xdp_xmit_xdpf()…

--

net: stmmac: fix a divide by zero in stmmac_xdp_xmit_xdpf()

This adds the missing zero test on priv->tx_coal_frames[queue] before the
modulo in stmmac_xdp_xmit_xdpf(), so that "ethtool -C eth0 tx-usecs 10
tx-frames 0" followed by an XDP_TX or ndo_xdp_xmit frame no longer divides
by zero. The other transmit paths already have this test.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea234..f9846250458a4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5253,7 +5253,9 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  
>  	tx_q->tx_count_frames++;
>  
> -	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
> +	if (!priv->tx_coal_frames[queue])
> +		set_ic = false;
> +	else if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
>  		set_ic = true;
>  	else
>  		set_ic = false;

[Severity: Medium]
Is one sample of priv->tx_coal_frames[queue] needed here instead of two?

The guard and the divisor are two separate plain loads of the same
concurrently written field, with no barrier or lock between them, so the
compiler is free to reload it for the modulo.

The writer side in __stmmac_set_coalesce() (stmmac_ethtool.c) stores it with
plain stores from process context, with no driver lock, no queue stop and no
NAPI quiescing:

	if (all_queues) {
		int i;

		for (i = 0; i < tx_cnt; i++) {
			priv->tx_coal_frames[i] =
				ec->tx_max_coalesced_frames;
			priv->tx_coal_timer[i] =
				ec->tx_coalesce_usecs;
		}
	} else if (has_tx) {
		priv->tx_coal_frames[queue] =
			ec->tx_max_coalesced_frames;

The reader in stmmac_xdp_xmit_xdpf() runs in softirq, reached from
stmmac_rx()/stmmac_rx_zc() via stmmac_xdp_xmit_back(), or from
stmmac_xdp_xmit(). If the guard load observes the old non-zero value and the
divisor load observes the freshly stored 0, the modulo still divides by zero
in softirq, which is the failure this commit is closing.

Would something like this be more robust?

	u32 coal = READ_ONCE(priv->tx_coal_frames[queue]);

	set_ic = coal && (tx_q->tx_count_frames % coal == 0);

The same double-read shape exists in stmmac_xmit(), stmmac_tso_xmit() and
stmmac_xdp_xmit_zc(), so a READ_ONCE() there too would keep the paths
consistent.

[Severity: Medium]
This isn't a bug introduced by this patch, but the commit message states
that with tx-frames 0 "the coalescing timer armed by stmmac_tx_timer_arm()
keeps reclaiming the descriptors". Does that hold for the AF_XDP zero-copy
XDP_TX path?

stmmac_finalize_xdp_rx() is the only arming attempt on that path:

	if (xdp_status & STMMAC_XDP_TX)
		stmmac_tx_timer_arm(priv, queue);

and stmmac_tx_timer_arm() picks the rxtx NAPI for an xsk_pool-backed queue,
which is the instance currently polling:

	napi = tx_q->xsk_pool ? &ch->rxtx_napi : &ch->tx_napi;
	...
	if (unlikely(!napi_is_scheduled(napi))) {
		...hrtimer_start(...)
	} else {
		hrtimer_try_to_cancel(&tx_q->txtimer);
	}

so napi_is_scheduled() is true and the timer is cancelled rather than armed.

The end-of-poll fallback in stmmac_napi_poll_rxtx() does not cover it
either, since tx_pending_packets is sampled before the XDP_TX descriptors
are produced:

	tx_done = stmmac_tx_clean(priv, budget, chan, &tx_pending_packets);
	tx_done = min(tx_done, budget);

	rx_done = stmmac_rx_zc(priv, budget, chan);
	...
	if (tx_pending_packets)
		stmmac_tx_timer_arm(priv, chan);

With tx-frames 0 no descriptor carries the interrupt-on-completion bit
either, so tx_q->dirty_tx stays behind tx_q->cur_tx and the dma_map_single()
mappings and xdp_frames of the last batch are held until unrelated traffic
causes another poll on that channel.

This window is reachable today with the defaults, since stmmac_init_coalesce()
sets

		priv->tx_coal_frames[chan] = STMMAC_TX_FRAMES;

and a zero-copy XDP_TX burst shorter than 25 frames likewise leaves set_ic
false while the timer is cancelled, so the patch only widens an existing
gap rather than creating one. Would it be worth dropping or softening the
claim that the timer always keeps reclaiming, or arming the timer after
stmmac_rx_zc() in stmmac_napi_poll_rxtx()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921135716.218420-1-xiaolinkui%40126.com
