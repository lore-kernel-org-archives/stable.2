Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065327;
	b=46YC6/26a7ll9HAIIkvc8bUJPRJdj5twPdBmjq3cWcvY+Lr1LrYiPIp/qacIarNmBHkV
	 AAGWha9/HZfovdHrngOfaRzyH5ppGDraD3nJOJ6xiohxW2Oh4GJ15w+i0X7UEAPTcIDGT
	 mTena4Cark6nz2bk8EmMfG5ICTS2hTPpIiNAaPeyO3c0VQepnDR46jqEs/34F4EWh47ob
	 7WlDAdIZQ6zs3bt1cz7PUo1LqpJ3iONC/FXItUg8ModM7HhkZaU9qGJ74j6CxjmB1PUqU
	 7hYzQocNNGQqtgPCiMIbjBb9v0SfSkAR5RFGGDbWpTBIUVl/yBWm604fmckY14jAzOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065327;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hkPcqV6bQ4Z8wReOxK+4e0ObiWgBkGg1Scv7w0+4fyg=;
	b=U+pPFnoeW4tlrerKws4HAFzY0+hmzpQkDnHQoSYsgSZexRiU/RQH9GR/NNxCN52hy1ok
	 18ansNTkDCY22/AVeSfrvS5/zXXakGK5iwtCnz3fIC9qbKH1WoRmLbqM3xW6sPWn3Dgns
	 SFUzzUlx+Dnyaequ2+My0lfZtn5V0DnOvoPUM0ur/bH2mOMaPl9FaUW8FpgU7NdAX/HgB
	 LUZw/ZKN3feh0QT08uZOq0OkRd/xb+fbXlxSQrk4qwk9ycdK6bboi0CMplaJXx5EUB6Zi
	 HdajhFDrLPBhHku+ZhOjr158MquHmk7CZ20hxLF9KQn3JvQFGZAYbK3keb58vEfKdQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/cUSMre";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A26606A335;
	Tue, 27 Oct 2026 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/cUSMre
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452021F01828;
	Tue, 27 Oct 2026 01:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793065327;
	bh=hkPcqV6bQ4Z8wReOxK+4e0ObiWgBkGg1Scv7w0+4fyg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y/cUSMreRanUU2thDVNP9jw8Ri4N5Sx4xrnZLTU8wZ8QDHtv2bJEnjBpL9SXRGLTW
	 Rxdh2kqs5NvuPr0BlPM+9BIGbEt8CxmZYe2FSm9DYdWlT3RJijtI0ESjkzBek0GpgI
	 osnagbMk/AU6ckNyP3sc4Yvt8C5zOUmcavjoFkg9ltiHjfDn8iCMgfpyohBiQ42nzW
	 PcJ0PtI0M0eL+TMBzEOfWUSUaYedQOoF23OjO3uqK/cxK3SsL76BVUsvXPVEqYuAFi
	 p6xagXhaMPFPRNvHO92ZBsraxvMWWznc3vBT1kYmH18wEnU/I94Zd4Irxs15XFEMhE
	 PWNx00RJTSfBw==
Subject: Re: [PATCH net v3 2/4] gve: Fix backward stats when interface goes
 down or configuration is adjusted
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com,
 nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com,
 pkaligineedi@google.com, yangchun@google.com, patricion@google.com,
 awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 treapking@google.com
Date: Tue, 27 Oct 2026 01:42:05 +0000
Message-ID: <179306532583.3134.7567788102217743644@kernel.org>
In-Reply-To: <20261023204706.3112215-3-hramamurthy@google.com>
References: <20261023204706.3112215-3-hramamurthy@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When XDP is attached, the new base snapshot counts XDP TX ring
  traffic only at teardown, so device-level netdev qstats tx-packets/tx-…

--

gve: Fix backward stats when interface goes down or configuration is adjusted

This patch keeps baseline rtnl and qstats counters in gve_priv so that
device statistics do not go backwards across queue teardown. Ring counters
are folded into the base in gve_queues_mem_remove() and in
gve_rx_queue_stop(). gve_get_base_stats() now reports the saved values
instead of zeros.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 26fdd22644f4d..52c152a986eb7 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -646,6 +688,9 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
>  	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
>  
>  	spin_lock_bh(&priv->stats_lock);
> +	gve_get_ring_stats(priv, &priv->base_net_stats);
> +	gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
> +
>  	priv->tx = NULL;
>  	priv->rx = NULL;
>  	spin_unlock_bh(&priv->stats_lock);

[Severity: Medium]
With an XDP program attached, will the device-level qstats tx-packets and
tx-bytes jump forward on every ifdown or reconfiguration?

The TX loop in gve_get_ring_stats() goes up to gve_num_tx_queues(), and
that count includes the XDP TX rings:

    return priv->tx_cfg.num_queues + priv->tx_cfg.num_xdp_queues;

As a result, the full pkt_done/bytes_done history of the XDP TX rings
ends up in base_net_stats.tx_*. Those counters are updated by
gve_clean_xdp_done() and by the DQO XDP path.

While the interface is up, qstats never reads those rings live:

gve_queues_start()
    netif_set_real_num_tx_queues(dev, priv->tx_cfg.num_queues);

netdev_nl_stats_by_netdev()
    netdev_stat_queue_sum(netdev, 0, netdev->real_num_rx_queues, &rx_sum,
                          0, netdev->real_num_tx_queues, &tx_sum);

So gve_get_tx_queue_stats() is only called for the non-XDP TX queues. The
new gve_get_base_stats() returns only the saved snapshot.

The qstats device total therefore leaves out live XDP TX traffic. Then,
when gve_close() or gve_adjust_config() reaches gve_queues_mem_remove(),
all of that traffic shows up at once. gve_get_stats() counts the live XDP
rings the whole time, so rtnl and qstats report different totals while
the interface is up.

The netdev_stat_ops kernel-doc says get_base_stats "can also be used to
report any miscellaneous packets transferred outside of the main set of
queues used by the networking stack".

Should gve_get_base_stats() also add the live counters of
tx[tx_cfg.num_queues .. gve_num_tx_queues())? The other option is to
limit the teardown snapshot's TX loop to tx_cfg.num_queues.

> @@ -2844,12 +2901,22 @@ static void gve_get_base_stats(struct net_device *dev,
>  			       struct netdev_queue_stats_rx *rx,
>  			       struct netdev_queue_stats_tx *tx)
>  {

[ ... ]

> +	spin_lock_bh(&priv->stats_lock);
> +	rx->packets = base_stats->rx_packets;
> +	rx->bytes = base_stats->rx_bytes;
> +	rx->alloc_fail = base_err_stats->rx_alloc_fails;
>  
> -	tx->packets = 0;
> -	tx->bytes = 0;
> +	tx->packets = base_stats->tx_packets;
> +	tx->bytes = base_stats->tx_bytes;
> +	spin_unlock_bh(&priv->stats_lock);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023204706.3112215-1-hramamurthy%40google.com
