Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E783955C4;
	Wed, 17 Jun 2026 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686926; cv=none; b=X0K5R/Odp6zbapk8aTcxH513WOJrU64fiSi53JU+Sf1SanEnApwN8Wwt+OojPxY0xvePjKYO3BDlI9DOi00p0GEIgX1k4Z7J45pQk9hhbd7DEkIWW/BatdNeeKO1wMdKoxHl06qqQCM5Q0AyaSxva03zyf/EvWPlJ+zXuX/bu9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686926; c=relaxed/simple;
	bh=VjCdms9P9e/BE10dlByAAA420pCw4yeIMQeCJ26sE40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHzMinTyWHllxw2tESKK7h+pX8XP7sGKmzRl1K63V5X1JJqkK20Yl6beEx/Ct8eYBscvzxHwJrxY6/cBrr26wU903jfxClq+2D/dCoxKj/JoSfs4hnmm8nrBfXNfmqmyOhh/pdH/PGZwZW2BkHLou/MCZNYct1feMbuSbB9RoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+u8Gt5+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+u8Gt5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470C41F000E9;
	Wed, 17 Jun 2026 09:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781686925;
	bh=wxGuVfpE3/0/SzZtTWpM1B4pYips3eAAcaCWqYptZYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I+u8Gt5+/0q7kOSUmisuXgUhSH5LQPYoUHgdc7p92uRoYqvFhpNHgNNYzR6d/bVs2
	 Xy9QJrU0SaQyoN2QWSqtZoKjJtp9Xj0LNB0NVp0zSqizf9Insix7l/w9qNnQ1RsktG
	 x6Cqc6RC1K7dcn5ewJFloKnORbdx9aj5vqjTI2p35GX5YSXcnNntPEZTou2D/xGrYZ
	 TE30tnugDKvYiay+ztjmaAJzQIn21+2T3XEPxVFzoWzf41ND3YZcW2I3PqQl0jtNJu
	 74Zn2bv3zsGEL12WAo285I+/LyCvqUBbqlAB2No++Iy7ABAdwDTrdST0BUZESKCmqo
	 OB5hGKzECgL/Q==
From: Simon Horman <horms@kernel.org>
To: justinlai0215@realtek.com
Cc: Simon Horman <horms@kernel.org>,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	richardcochran@gmail.com,
	david.laight.linux@gmail.com,
	aleksander.lobakin@intel.com,
	pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net v3] rtase: Workaround for TX hang caused by short UDP packets entering hardware PTP parsing
Date: Wed, 17 Jun 2026 09:59:43 +0100
Message-ID: <20260617085942.843250-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615131653.15730-1-justinlai0215@realtek.com>
References: <20260615131653.15730-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
rtase: Workaround for TX hang caused by short UDP packets entering hardware PTP parsing

The patch adds a workaround for a hardware bug in rtase where short UDP
packets triggering PTP parsing can cause a TX hang due to out-of-bounds reads.
It pads affected packets so the transport data reaches a minimum length.

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 55105d34bc797..4c295a39c7a0c 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
[ ... ]
> @@ -1249,6 +1250,81 @@ static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
>  	return csum_cmd;
>  }
>  
> +static bool rtase_get_udp_offset(struct sk_buff *skb, u32 *udp_offset)
> +{
> +	int no = skb_network_offset(skb);
> +	struct ipv6hdr *i6h, _i6h;
> +	struct iphdr *ih, _ih;
> +
> +	switch (vlan_get_protocol(skb)) {
> +	case htons(ETH_P_IP):

[Severity: High]
Does relying on vlan_get_protocol(skb) allow an unprivileged user to bypass
this workaround?

If an attacker uses an AF_PACKET/SOCK_RAW socket to inject a raw Ethernet
frame containing an IPv4/UDP packet, they could set skb->protocol to an
arbitrary value like htons(ETH_P_ALL). The switch statement will fall
through to the default case and return false, causing rtase_skb_pad() to
skip the padding.

Since the hardware independently parses the raw frame based on the EtherType,
could it still process the unpadded packet and trigger the TX hang?

> +		ih = skb_header_pointer(skb, no, sizeof(_ih), &_ih);
> +		if (!ih)
> +			return false;
[ ... ]
> +static bool rtase_skb_pad(struct sk_buff *skb)
> +{
> +	__be16 *dest, _dest;
> +	u32 trans_data_len;
> +	u32 udp_offset;
> +	u16 dest_port;
> +	u32 pad_len;
> +
> +	if (!rtase_get_udp_offset(skb, &udp_offset))
> +		return true;
> +
> +	trans_data_len = skb->len - udp_offset;
> +	if (trans_data_len < offsetof(struct udphdr, len) ||
> +	    trans_data_len >= RTASE_MIN_PAD_LEN)
> +		return true;

[Severity: High]
Does this logic inadvertently skip padding for underflowed lengths and tiny
payloads?

If the IP header is malformed such that skb->len < udp_offset, the unsigned
subtraction for trans_data_len will underflow to a large positive value.
This causes trans_data_len >= RTASE_MIN_PAD_LEN to be true, bypassing the
padding.

Additionally, if the packet has fewer than 4 bytes of UDP payload, meaning
trans_data_len < offsetof(struct udphdr, len), it explicitly returns true.

Since the hardware blindly fetches the UDP destination port at
udp_offset + 2 via DMA, won't transmitting these short or malformed packets
without padding still expose the hardware to out-of-bounds reads?

> +
> +	dest = skb_header_pointer(skb,
> +				  udp_offset + offsetof(struct udphdr, dest),
> +				  sizeof(_dest), &_dest);
[ ... ]
> @@ -1362,6 +1438,9 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
>  		opts2 |= rtase_tx_csum(skb, dev);
>  	}
>  
> +	if (!rtase_skb_pad(skb))
> +		goto err_dma_0;
> +
>  	frags = rtase_xmit_frags(ring, skb, opts1, opts2);
>  	if (unlikely(frags < 0))
>  		goto err_dma_0;

[Severity: High]
This is a pre-existing issue, but does the err_dma_1 error path in
rtase_start_xmit() contain a double free of the skb?

When transmitting a fragmented packet, rtase_xmit_frags() maps the
fragments and assigns ring->skbuff[entry] = skb for the last fragment
descriptor. Back in rtase_start_xmit(), if dma_map_single() fails for the
linear part, it jumps to err_dma_1:

err_dma_1:
	ring->skbuff[entry] = NULL;
	rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);

err_dma_0:
	tp->stats.tx_dropped++;
	dev_kfree_skb_any(skb);
	return NETDEV_TX_OK;

rtase_tx_clear_range() iterates over the mapped fragments and calls
dev_kfree_skb_any() when it finds the skb pointer. Execution then falls
through to err_dma_0, which unconditionally calls dev_kfree_skb_any(skb) a
second time on the same skb pointer.
