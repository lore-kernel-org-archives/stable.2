Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700323BED2D;
	Mon,  8 Jun 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945675; cv=none; b=KVN3XIzBv6zmKpf8NrwmhzKVQu19B1Xt8QmMUyC/8Lt1tjvE/ivGqcmghmgEJPf9K2Nhx5SAgVcwt0sDxPAPLj0Ba52QQ7dexBKOL2PhoS606NdJfNBFc6KgX1J7U6Xtdx73Wl5uZDUMJvXYtbknS/p1qm82QMtcDWVval5HnDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945675; c=relaxed/simple;
	bh=7J+JwBRBK3z7Qdol8OjGNHajN1n/GVouk1c93ekxzGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXQbQNdWAAJBPaFcaw5EyHodQl19IYs9yjZ7+cSvfKuSLKkghWU3txUpHURy9l5jVPU8L682qbIo5WzpByDdP7aB9D8fhxlOv6ImCPa/KB+r5Q8rcCUWRMOzxOMoI28m+UMq4Y87nMlf/y9djyhxGvFbNzc/5Ht8QuH8VMXjkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOIGsFKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOIGsFKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762641F00893;
	Mon,  8 Jun 2026 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780945674;
	bh=b/XsBnPx0rQ0BK32amabeYbeAk0vproA9tBn3V9aT6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mOIGsFKc4mFJV+qmWub6xqqIVIOyV0MN8ftHzZaUHx5BbVSUFxoFsym3fqXiyfZyO
	 z1GOYrgrHdL3ZQ/Jzr5MfnHpvy5V+T56CnmjlueZQy8XaXNJkFSe89QpkAeReLm7FH
	 smRp2KE+xATOe6ZPEMCctfN4OES5Zl1b8D75z8qGgCphFgZRxCD2cJQCjj7AWt+wI7
	 u+nYQGDiccGYci/pJIuAmkCT51velnze4aA0gQCF2eBxhwkDg3sD9ZBk4UV+POIbmi
	 Mq70FhuU9n5qX3BV2NTUX8VoOuv+AZqMrFrNme6zZAS5CDfDLayFUbjiMqHuDl2Zsk
	 EzYxJ1GxF+geg==
From: Simon Horman <horms@kernel.org>
To: justinlai0215@realtek.com
Cc: 'Simon Horman' <horms@kernel.org>,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	richardcochran@gmail.com,
	aleksander.lobakin@intel.com,
	pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net v2] rtase: Workaround for IP fragmented UDP packet hardware bug
Date: Mon,  8 Jun 2026 20:06:28 +0100
Message-ID: <20260608190627.182292-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604101356.15611-1-justinlai0215@realtek.com>
References: <20260604101356.15611-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
rtase: Workaround for IP fragmented UDP packet hardware bug

The hardware parser incorrectly interprets 319/320 in a short
IP fragmented UDP packet payload as standard PTP destination
ports and treats the fragment as a PTP packet for further
parsing. Pad these packets so the transport data reaches
RTASE_MIN_PAD_LEN before transmitting to avoid triggering the
hardware issue.

> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index ef13109c49cff..b686b84e15fe2 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c

[ ... ]

> @@ -1247,6 +1248,52 @@ static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
>  	return csum_cmd;
>  }
>  
> +static bool rtase_skb_is_udp(struct sk_buff *skb)
> +{
> +	int no = skb_network_offset(skb);
> +	struct ipv6hdr *i6h, _i6h;
> +	struct iphdr *ih, _ih;
> +
> +	switch (vlan_get_protocol(skb)) {
> +	case htons(ETH_P_IP):
> +		ih = skb_header_pointer(skb, no, sizeof(_ih), &_ih);
> +		return ih && ih->protocol == IPPROTO_UDP;
> +	case htons(ETH_P_IPV6):
> +		i6h = skb_header_pointer(skb, no, sizeof(_i6h), &_i6h);
> +		return i6h && i6h->nexthdr == IPPROTO_UDP;

[Severity: High]
Does this check fail to traverse IPv6 extension headers?

If an IPv6 packet contains extension headers, such as an IPv6 fragment
(IPPROTO_FRAGMENT), the nexthdr field will contain the extension header's
protocol number instead of UDP.

Doesn't this bypass the workaround for the exact fragmented packets it is
intended to fix?

> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool rtase_skb_pad(struct sk_buff *skb)
> +{
> +	u32 trans_data_len;
> +	u16 dest_port;
> +	u32 pad_len;
> +
> +	if (!skb_transport_header_was_set(skb))
> +		return true;

[Severity: High]
Does this early return skip the workaround for forwarded (routed) IP
fragments?

The networking stack typically does not set the transport header offset for
forwarded packets or non-first IP fragments.

Could an attacker still trigger the hardware TX hang by routing short,
fragmented UDP packets through this interface?

> +
> +	trans_data_len = skb_tail_pointer(skb) - skb_transport_header(skb);

[Severity: Critical]
Does this calculation miss data stored in paged fragments?

By only subtracting the transport header from the tail pointer, it treats the
linear portion as the entire transport payload length.

For non-linear packets, won't this incorrectly evaluate the payload as
smaller than RTASE_MIN_PAD_LEN and trigger the padding path?

> +	if (trans_data_len < offsetof(struct udphdr, len) ||
> +	    trans_data_len >= RTASE_MIN_PAD_LEN)
> +		return true;
> +
> +	if (!rtase_skb_is_udp(skb))
> +		return true;
> +
> +	dest_port = ntohs(udp_hdr(skb)->dest);
> +
> +	if (dest_port == PTP_EV_PORT || dest_port == PTP_GEN_PORT) {
> +		pad_len = RTASE_MIN_PAD_LEN - trans_data_len;
> +		if (__skb_put_padto(skb, skb->len + pad_len, false))

[Severity: Critical]
Will calling __skb_put_padto() with a length greater than skb->len cause a
kernel panic on non-linear packets?

Since __skb_put_padto() unconditionally invokes __skb_put() when the new
length exceeds the current length, and __skb_put() contains
SKB_LINEAR_ASSERT(skb) which triggers a BUG_ON for non-linear packets, won't
this panic the kernel when processing a fragmented UDP packet?

> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb,
>  			    u32 opts1, u32 opts2)
>  {
> @@ -1360,6 +1407,9 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
>  		opts2 |= rtase_tx_csum(skb, dev);
>  	}
>  
> +	if (!rtase_skb_pad(skb))
> +		goto err_dma_0;
> +
>  	frags = rtase_xmit_frags(ring, skb, opts1, opts2);

[Severity: High]
This is a pre-existing issue, but doesn't rtase_xmit_frags() crash on highmem
pages?

The driver advertises NETIF_F_HIGHDMA, but rtase_xmit_frags() attempts to map
SKB fragments using skb_frag_address() and dma_map_single():

addr = skb_frag_address(frag);
mapping = dma_map_single(&tp->pdev->dev, addr, len, DMA_TO_DEVICE);

Since skb_frag_address() returns an invalid pointer for HIGHMEM pages,
shouldn't the driver be using skb_frag_dma_map() instead to prevent panics or
memory corruption?

>  	if (unlikely(frags < 0))
>  		goto err_dma_0;
