Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537062;
	b=jd42bX0WP7RIfnqmnQVOcmfphmzbzhp3jM4IM6w3LhWY2BNmaBRJdeH4vI2PclaGbuYU
	 g11q2yzRnUtQNVlq0W3Ph8b2V9H+khCiq8epLlx4LB1FlFO1wAT5EIQHEyCRIZyWgXzM3
	 c0ystepKOxpTnTId0nquzooL+iQ4CdA1xmkrvDDeLmQEy9oy2BUaKAwIzyS+8Wvug9AUx
	 LeieVcvNXpHPBIs2eZ85fVxJkhHM4GlGLG9B21V7qIekjNyUfdmOjiCT8YxtEZhYVfFBt
	 GdVv9yWQuDDEw56aJt3/Uiwpd7NwPb6tltEy9n0Yn6o9Cj17fUQIkgZMl1GvI64M/mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537062;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5y6QZfTSiMv/r9t+oZRsJhbawjquWwyqBPI0GslwcxY=;
	b=bnHgH0elcMmSOKrdVSf5zJJvE6+WzVI6dvocv8T0BVpsWJghYhGMdZ8LLDD9iPLM1Huh
	 cirSesONUvOUIAtIzUBCOmKtzdjcDUhj9AL3FyT4R9ruP5E3tXDX09eU0u9pPzXKHCMQz
	 ty+hOWoHwE2S77yRQxctv57ZgCEeKn2CXD6RS6etHvMVzTEyfh1u/gLwr3/5wmi/TAdPS
	 eXGnnd7LGDvlLDEZ5sgZjulCXCT309q6t5ZsEQXz/+eAN2c3XNPgoBiO3LKxEqHl96hnO
	 BvtxtcwwXkkGE7HmKUJnIMRREDlrJOl3S1c4lqs836fBCA1eiB8qti5hn6glc2nu5AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMjwemEF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D1A606A31C;
	Fri, 13 Nov 2026 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMjwemEF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732271F000C5;
	Fri, 13 Nov 2026 02:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537062;
	bh=5y6QZfTSiMv/r9t+oZRsJhbawjquWwyqBPI0GslwcxY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kMjwemEFShD4PkWCc0O/x1VuqXTWyu/a640HP6cQFHq1U7GcorQunAYP2rrzl6WXc
	 RbYrqfv+uXWhJniiyryl7ah2QwxQXressgI5d8+/YU9r41WiVLxaSOV0rbpwqGH0J/
	 hJESgs7S8+3W39SzBdxE8wNCdrm+UMSLH8Q8tOX8CcHamijqaAuzs7lL1AgJyxEWjw
	 avJ1Za7noHmxA9v9Mp6OQYnJpH2KJfhzhKdDataJL9UndzsXsFMZeX9/dLGu9Zi+jH
	 pooYbg1AEoIT+vXDo+HYl7zyyHSHIzYqr61HeVeJ54vfvFOtUA4Wf9cOEP87twIEz+
	 Fq9QIheQ/szHw==
Subject: Re: [PATCH net] net: mana: report RX checksum offload for IPv6
From: netdev-bot+sashiko@kernel.org
To: hamzamahfooz@linux.microsoft.com
Cc: netdev@vger.kernel.org, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
 stable@vger.kernel.org
Date: Fri, 13 Nov 2026 02:31:00 +0000
Message-ID: <179453706097.2199510.1777031818337204982@kernel.org>
In-Reply-To: <20261109142856.779955-1-hamzamahfooz@linux.microsoft.com>
References: <20261109142856.779955-1-hamzamahfooz@linux.microsoft.com>
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

- [Medium] In mana_rx_skb()
  (drivers/net/ethernet/microsoft/mana/mana_en.c), the patch removed the…

--

net: mana: report RX checksum offload for IPv6

This commit removes the rx_iphdr_csum_succeed check from mana_rx_skb().
CHECKSUM_UNNECESSARY is now set from the hardware's TCP/UDP checksum
result bits alone. This lets IPv6 TCP and UDP traffic, including VXLAN
over IPv6, skip software checksum verification in GRO.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index e6d494df22e4d..05bd4b4b8349e 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2179,10 +2179,9 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
>  	skb_checksum_none_assert(skb);
>  	skb_record_rx_queue(skb, rxq_idx);
>  
> -	if ((ndev->features & NETIF_F_RXCSUM) && cqe->rx_iphdr_csum_succeed) {
> -		if (cqe->rx_tcp_csum_succeed || cqe->rx_udp_csum_succeed)
> -			skb->ip_summed = CHECKSUM_UNNECESSARY;
> -	}
> +	if ((ndev->features & NETIF_F_RXCSUM) &&
> +	    (cqe->rx_tcp_csum_succeed || cqe->rx_udp_csum_succeed))
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;

[Severity: Medium]
For encapsulated frames, which L4 checksum do rx_tcp_csum_succeed and
rx_udp_csum_succeed refer to?

When CHECKSUM_UNNECESSARY is set with the default csum_level of 0, the
stack takes it to mean the outermost TCP/UDP checksum was verified. For a
VXLAN frame, that is the outer UDP checksum.

struct mana_rxcomp_oob in include/net/mana/mana.h reports outer and inner
IP header results separately, but it has only one set of L4 bits:

	u32 rx_outer_iphdr_csum_succeed	: 1;
	u32 rx_outer_iphdr_csum_fail	: 1;
	...
	u32 rx_iphdr_csum_succeed	: 1;
	u32 rx_iphdr_csum_fail		: 1;
	u32 rx_tcp_csum_succeed		: 1;
	u32 rx_tcp_csum_fail		: 1;
	u32 rx_udp_csum_succeed		: 1;
	u32 rx_udp_csum_fail		: 1;

struct mana_tx_long_oob also has is_encap, inner_is_ipv6 and
inner_frame_offset, so the hardware seems to understand tunnels. That
makes it plausible that the unprefixed L4 bits describe the inner header
of a tunnelled frame.

The driver never reads rx_outer_iphdr_csum_*, never sets csum_level, and
does not set up hw_enc_features or udp_tunnel_nic.

If the unprefixed bits describe the inner headers, then before this patch
a tunnelled frame with an inner IPv6 header never had
rx_iphdr_csum_succeed set. It stayed CHECKSUM_NONE, and the outer UDP
checksum was checked in software. After this change, the same frame
becomes CHECKSUM_UNNECESSARY at level 0.

In the udp4/udp6 GRO receive path, the outer UDP check then uses up the
single csum_cnt. skb_gro_checksum_try_convert() then builds a complete
checksum from the outer checksum, which was never checked. Only the inner
TCP checksum ends up being checked in software.

If the hardware only checked the inner L4 checksum, could some bad frames
be accepted instead of dropped? That would cover frames with a bad outer
UDP checksum, and frames corrupted in the VXLAN header/VNI, the inner
Ethernet header, or inner IPv6 fields outside the inner pseudo-header.

The commit message lists VXLAN over IPv6 as a case that benefits:

  TCP/VXLAN/IPv6, 10.9 Gbps   7934373       18

These counts would look the same under either reading of the hardware.
Once the outer checksum is assumed valid, GRO checksum conversion skips
the full software sum.

Tunnels with an inner IPv4 header already had this problem under the old
check. This patch extends it to tunnels with an inner IPv6 header.

Does the hardware or firmware guarantee that these bits always refer to
the outermost L4 header? If not, there are two options. One is to use the
outer/inner bits and set skb->csum_level = 1 where it applies. The other
is to leave encapsulated frames as CHECKSUM_NONE.

>  
>  	if (cqe->rx_hashtype != 0 && (ndev->features & NETIF_F_RXHASH)) {
>  		if (cqe->rx_hashtype & MANA_HASH_L4)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109142856.779955-1-hamzamahfooz%40linux.microsoft.com
