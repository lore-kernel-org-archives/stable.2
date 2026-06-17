Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E8311C1B;
	Wed, 17 Jun 2026 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686488; cv=none; b=lcAyUS4+O58/i5QwMi///7xcCmxjG0BC33LXAgrgYCJNCsT12Axg7u5yujfS2VpXeRM1oP9OuW2BJI4KetxF50+RUFtrXivHclJMsIrWPO2B3y8ZabvL7z7Os3FfKOrlCsBDawMBEBVE6G7ZHSyUY09j026GzutLvcj5Py3VyU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686488; c=relaxed/simple;
	bh=c9p/hQ6eaTZ113vmdmEPnqxG6fqfqU3h1QhInGIX2wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnBJAcWp77XKmERXBG4q2SD/UrGaGZOGNukR23yat/3lSnijB3nyAQBRe6TaGc0n1IAaouzPfVFEhDYQwl/P4t+9oLx3H/25RG/pk+/KRjRPswiC38ljy4a4iAjThozxWHid/+QLYYJhCbMshgwVf20sgJDsjZz2FeORxgR5bvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTS6Xk9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTS6Xk9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824171F00A3A;
	Wed, 17 Jun 2026 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781686487;
	bh=ZdEhA3Eiq9fe7/PUtOiAHXL0M9bcxE2j/rSowkuW1iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LTS6Xk9R1eky0Ihz+STM0PJpFfc54ILtVKP2RV0IovSkRxgtzGTnmpJlSo981U10x
	 nDnsf18MwFavhdruefsd8JAyLAvKKuTQN2KRe7Ry/Yz4AbKot69TQq1BjFhUEDimFZ
	 mLkY1t1ER3253ch2mZugM8IXNjaXJ+65L+gc0M6PwTUerQV9MEa7lpS0c3BbvHMiAP
	 ipSneRndLtH8MlRDNk808+koxj7gd64QAaQYUIGveIRYFyKHHTZCpxyqr2R0AB9+Fu
	 uWfDY4+ODICB4bpc8R3bFxIjK2PNNOQADSh5XmoW6bu42hm3Z9B8ngVkswtDDzKL9W
	 uqon8S+XUnBYA==
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
Date: Wed, 17 Jun 2026 09:54:17 +0100
Message-ID: <20260617085416.841731-2-horms@kernel.org>
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
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
rtase: Workaround for TX hang caused by short UDP packets entering hardware PTP parsing

This patch adds a workaround for a hardware TX hang that occurs when
short UDP packets matching destination ports 319/320 enter a PTP parsing
path that reads beyond the packet end. The workaround pads affected
packets so the transport data reaches RTASE_MIN_PAD_LEN before
transmission.

> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 55105d34bc79..4c295a39c7a0 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c

[ ... ]

> +static bool rtase_get_udp_offset(struct sk_buff *skb, u32 *udp_offset)
> +{
> +	int no = skb_network_offset(skb);
> +	struct ipv6hdr *i6h, _i6h;
> +	struct iphdr *ih, _ih;
> +
> +	switch (vlan_get_protocol(skb)) {
> +	case htons(ETH_P_IP):
> +		ih = skb_header_pointer(skb, no, sizeof(_ih), &_ih);
> +		if (!ih)
> +			return false;
> +
> +		if (ih->ihl < 5)
> +			return false;
> +
> +		if (ih->protocol != IPPROTO_UDP)
> +			return false;
> +
> +		*udp_offset = no + ih->ihl * 4;

[Low]
Should ih->ihl also be checked against the actual data present in the
skb? With ihl up to 15 (60 bytes), if the skb only contains the basic
20-byte IP header, the computed udp_offset can exceed skb->len.

Downstream in rtase_skb_pad():

	trans_data_len = skb->len - udp_offset;

trans_data_len is u32, so when udp_offset > skb->len this underflows to
a very large value, which trivially satisfies:

	trans_data_len >= RTASE_MIN_PAD_LEN

and rtase_skb_pad() silently skips the padding. A malformed packet from
an AF_PACKET sender with CAP_NET_RAW could craft a mismatched ihl and
bypass the workaround. Would clamping or validating udp_offset against
skb->len before the subtraction be appropriate?

> +
> +		return true;
> +	case htons(ETH_P_IPV6):
> +		i6h = skb_header_pointer(skb, no, sizeof(_i6h), &_i6h);
> +		if (!i6h)
> +			return false;
> +
> +		if (i6h->nexthdr != IPPROTO_UDP)
> +			return false;
> +
> +		*udp_offset = no + sizeof(*i6h);
> +
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
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

[Low]
When trans_data_len is less than offsetof(struct udphdr, len) (i.e., the
transport region is under 4 bytes), this returns true and skips the
padding entirely.

The commit message states the hardware "may access data beyond the end
of the packet" during PTP parsing. If the hardware also reads out of
bounds while classifying the packet, an IPv4 last fragment with 1-3
trailing bytes could still be misclassified as PTP based on whatever
garbage memory the hardware happens to read, and the workaround would
be bypassed.

The implicit assumption here seems to be "if the driver cannot read the
dest port from the skb, the hardware cannot classify it either", which
appears to contradict the premise that the hardware reads beyond the
packet boundary. Should these very short transport-data cases also be
padded to be safe?

> +
> +	dest = skb_header_pointer(skb,
> +				  udp_offset + offsetof(struct udphdr, dest),
> +				  sizeof(_dest), &_dest);

[ ... ]
