Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428D4F5E0;
	Tue, 30 Jun 2026 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784890; cv=none; b=DcX/hc9lxnsnM95r/1s2TXTxwQPAAmHwCq1IHEf2DaxvBjfmYE8G3EjQnbEf10dcXJeeILv7e/T1X3Xv3JrUR+PMK8hhCddjstypF2IMepVPQkx57f9o/8+/vPhC3nuj+SyAvjeb+hD1c6N+rggCKmC+nUYfGanIrTq09vVD5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784890; c=relaxed/simple;
	bh=tzypmFDl0YNPcpQEV97HM/rbOeIqiQ5TFabZSZnarUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3Wdc3lc45L9c3xKix2HC+t8kDkKUk38Jj5CHWbvzV0w39LQMBm7D5pJhVO9GwdIs+6SC52afyoYJP9SUYmpcYn29gRiU1EjRqaNNw1bzgQlf7vH6eulMp3v/wHxplYSG4525Fd1nZROa7sTr3ckiFYhFZo5VR2SpeMunoEXADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AryREGq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AryREGq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AA01F000E9;
	Tue, 30 Jun 2026 02:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782784888;
	bh=vbLm8zeSg2B82QSXmAm4VAXoD2wb5ZfhgLmumIQWL4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AryREGq0BX8yf4ZQQnZmmOouju4cdQK8Uqp4pGbWy3paECqE6zuVmsaOQ8/GuYSyH
	 WEDmhOiPCC4HDkukEQIZfhtIw9UgwsEOLWJcSPYOubItCkaEo1vvbz8r7wXH3+rcGs
	 AuvnOhWXBEKPHyZW0qx4GhWgcqta+7QNkAf/zr5ZJnGT8fPC1rhpLdAWtQz4a3sZtB
	 S6XESbG/oboH3hNjtXxsNtl2In8SJNeCaaQHAcuF67vSw6pfepbat0FAv+aIu+ZE/E
	 gRN7OeVVZ3RSeiNceJehsTyxfeqI2qzejZ4HwY6TGdGPQGGw3gDosCaDwR6pl7lgiK
	 NLCcEB1VFkGiw==
From: Jakub Kicinski <kuba@kernel.org>
To: justinlai0215@realtek.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	horms@kernel.org,
	richardcochran@gmail.com,
	david.laight.linux@gmail.com,
	aleksander.lobakin@intel.com,
	pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net v4] rtase: Workaround for TX hang caused by short UDP packets entering hardware PTP parsing
Date: Mon, 29 Jun 2026 19:01:26 -0700
Message-ID: <20260630020126.2366786-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626044539.37753-1-justinlai0215@realtek.com>
References: <20260626044539.37753-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    rtase: Workaround for TX hang caused by short UDP packets entering hardware PTP parsing

This commit attempts to work around a hardware TX hang caused by out-of-bounds
reads during PTP parsing. It introduces logic to pad short UDP packets to a
minimum transport data length before transmission.

> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 255667775f0e8..944ffe71b2d07 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
[ ... ]
> +static bool rtase_get_udp_offset(struct sk_buff *skb, u32 *udp_offset)
> +{
> +	struct ipv6hdr *i6h, _i6h;
> +	struct iphdr *ih, _ih;
> +	__be16 proto;
> +	u32 no;
> +
> +	if (!rtase_get_l3_proto(skb, &proto, &no))
> +		return false;
> +
> +	switch (proto) {
> +	case htons(ETH_P_IP):
> +		ih = skb_header_pointer(skb, no, sizeof(_ih), &_ih);
> +		if (!ih)
> +			return false;

[Severity: High]
Does this skip the padding workaround if the IP header itself is truncated?

If the packet is shorter than the IP header (e.g., less than 34 bytes),
skb_header_pointer() will return false. This causes rtase_skb_pad() to
return true, allowing the packet to skip padding. Could this small unpadded
packet still trigger the hardware parser and cause the TX hang?

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
> +	if (udp_offset > skb->len)
> +		return false;
> +
> +	trans_data_len = skb->len - udp_offset;
> +	if (trans_data_len < offsetof(struct udphdr, len) ||
> +	    trans_data_len >= RTASE_MIN_PAD_LEN)
> +		return true;

[Severity: High]
Can an attacker bypass the workaround if the transport payload is very small?

By returning true when trans_data_len is less than
offsetof(struct udphdr, len) (which is 4 bytes), the packet is passed to
the hardware unpadded.

If an attacker sends an IPv4 non-initial fragment with a very small payload,
the hardware parser might identify the fragment as UDP and attempt to read the
destination port at offset 2 from the payload. If this out-of-bounds read
hits residual uninitialized memory in the TX FIFO containing PTP port values
(319 or 320), the hardware could incorrectly classify it as a PTP packet,
continue parsing out of bounds, and trigger the TX hang.

> +
> +	dest = skb_header_pointer(skb,
-- 
pw-bot: cr
