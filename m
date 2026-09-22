Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757F39A4CF;
	Tue, 22 Sep 2026 03:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048967; cv=none; b=DCEz94kdV1cim83ldTmNC9ZV9fErO0MWit6NgJsUp0VjCH65iIf3sqywR6DGKTZ0ZhGH6uCUV2VHowX8zl839QZPUGkw6ZYE0INA+tBhjL0EKfEjMpjPvPCTVsjchLJ2sWrPZtgdOH/VUb4Yz9YeOPrgBuDEt1kydW5Zff2ncLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048967; c=relaxed/simple;
	bh=YIx2ZHQqGERfp8+TGhUMBEvNtXF9RsCtTw4zP0e0ofQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EnVs78mGQ3CRGUABCxd+1oCGDvPrf3AsSCmF+X4khbh0W1oFdeFJ+Faf93bCR87gfuCOs1ZrwW/2VOJ0I28NoghzQASVRtisXCnLPy9cpZY9VPrlA6uIUwlmj4NJ2lTjRSopcqNhL5QUh71raEZwyoueFUhN6fB6pibUbWcRtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9PFZxbV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9PFZxbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DC91F000FF;
	Tue, 22 Sep 2026 03:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790048965;
	bh=albDlcenYS2HnFQLEOz6LXjV/YzcCZ3u4elsWZgnoSw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g9PFZxbVq+5WTOHaoMAIZH4ecfjKP1W3tLDlFPHBWP+qnLIxJTTjnoFK1Na3DrdPI
	 m0X5os4M7AltD1/2LyqvmlYjc9jhuq4zfSmDrYXZXt5MI7LNStipFKS4YUYnObBmPR
	 RzVU0kNyqLXS1ldt4SCegnk/8i4UTqfIBgdsMG3fY5kkw9vEbhsQWdY4PjjyrLeUid
	 NIGVfayuZvqi3+IRAT3cvIEzGG86Z6D+fN4JfLu18YE8VFA0xYgqjyzEiS1VaF0TOu
	 68joMPL5sVv2SzfBb/wuDZtABtFB+5vWv6qUm5swdP7WRUpGY1htww4zhcP+daE5Bx
	 cUNRIrd9gCpug==
Subject: Re: [PATCH net v2 1/2] virtio_net: copy zerocopy frags in start_xmit
 without NAPI
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com, kleaver@janestreet.com,
 doebel@amazon.de, stable@vger.kernel.org
Date: Tue, 22 Sep 2026 03:49:23 +0000
Message-ID: <179004896394.2160803.10158228819458028402@kernel.org>
In-Reply-To: <20260919004748.1463985-2-willemdebruijn.kernel@gmail.com>
References: <20260919004748.1463985-2-willemdebruijn.kernel@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Commit message mischaracterizes the defect being fixed, which
  matters because the patch carries Fixes: 5cd8d46ea156 and Cc: stable.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but after it
  start_xmit() contains two logically identical drop-and-return-…

--

virtio_net: copy zerocopy frags in start_xmit without NAPI

When napi_tx is disabled, start_xmit() now calls skb_orphan_frags() before
transmitting, so zerocopy frags that do not set SKBFL_DONT_ORPHAN are deep
copied instead of being handed to the virtqueue and then orphaned. On copy
failure the skb is dropped, counted in tx_dropped, and the new kick_vq label
is used so a pending xmit_more batch is still flushed.

A couple of questions below.

> virtio_net: copy zerocopy frags in start_xmit without NAPI
>
> Virtio-net without NAPI frees completed skbs lazily on the next
> start_xmit. Senders waiting for in-flight zerocopy buffers can
> deadlock if they cannot transmit more packets, as then no
> completed packets will be freed.
[ ... ]
> This fixes the tpacket_snd slot reuse bug on skb_orphan for
> virtio-net, and prevents PACKET_TX_RING from running out of slots.

[Severity: Medium]
Does the leading description match the tree this patch applies to?  The
patch carries a Fixes: tag and Cc: stable, so the described failure mode is
what a backporter will look for.

In the current tree, tpacket_snd() installs a destructor:

net/packet/af_packet.c:tpacket_snd() {
	...
	skb->destructor = tpacket_destruct_skb;
	...
}

and that destructor releases the slot, drops the pending count and completes
the waiter:

net/packet/af_packet.c:tpacket_destruct_skb() {
	...
		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
		packet_dec_pending(&po->tx_ring);
		complete(&po->skb_completion);
	...
}

The pre-existing skb_orphan() in start_xmit() for !use_napi runs that
destructor within the same start_xmit() call, so the slot is returned
immediately.  Given that, can a PACKET_TX_RING sender actually run out of
slots or block in wait_for_completion_interruptible_timeout() before this
series?

The clause about "the tpacket_snd slot reuse bug on skb_orphan" looks like
the defect that exists today, and it is the opposite of exhaustion: because
skb_orphan() runs after xmit_skb() has already linked the ring pages into
the virtqueue, the slot is marked available to userspace while the device may
still be reading those pages.  That is silent payload corruption rather than
a stall.

The deadlock and slot-exhaustion wording appears to apply only after the
follow-up patch that converts PACKET_TX_RING to ubuf_info completion and
removes tpacket_destruct_skb().  Could the message lead with the
data-corruption case for the current tree, and keep the deadlock argument
scoped to the follow-up patch?

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d059d3..bf82ef9874ab 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3349,6 +3349,14 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	else
>  		virtqueue_disable_cb(sq->vq);
>  
> +	if (!use_napi &&
> +	    unlikely(skb_orphan_frags(skb, GFP_ATOMIC))) {
> +		DEV_STATS_INC(dev, tx_dropped);
> +		dev_kfree_skb_any(skb);
> +		kick = !xmit_more || netif_xmit_stopped(txq);
> +		goto kick_vq;
> +	}
> +

[Severity: Low]
This isn't a bug introduced by this patch, but the new drop path and the
existing xmit_skb() failure drop path in start_xmit() now disagree on the
kick protocol.  The new path computes kick and goes to kick_vq, while the
older one returns directly:

drivers/net/virtio_net.c:start_xmit() {
	...
	err = xmit_skb(sq, skb, !use_napi);

	/* This should not happen! */
	if (unlikely(err)) {
		DEV_STATS_INC(dev, tx_fifo_errors);
		...
		DEV_STATS_INC(dev, tx_dropped);
		dev_kfree_skb_any(skb);
		return NETDEV_TX_OK;
	}
	...
}

If xmit_skb() returns an error such as -ENOMEM from the indirect descriptor
allocation on the last packet of an xmit_more batch, do the descriptors
already added by the earlier packets of that batch stay un-notified until
some later start_xmit() on the same send queue computes kick = true?  The
-ENOSPC case is covered because check_sq_full_and_disable() stops the txq and
netif_xmit_stopped(txq) then forces a kick.

Would it make sense to route the xmit_skb() failure path through the new
kick_vq label as well, so both drops behave the same?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919004748.1463985-1-willemdebruijn.kernel%40gmail.com
