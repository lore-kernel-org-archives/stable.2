Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866447;
	b=b4d6tDscoEIXEl7TYS0fUoNsk3nQ/GZ1ge/4lk69LaxEfhR7njOFYBtS61rdMhRHIJLM
	 ocxVD5RBDK7ZDV3IBRBCWTT7j1wnXiccEI0lZdwaoJAJWWwpziGifzJSfqcdUc5wwhQxO
	 E+9L6lVcU7sLr2h0nXU0heF1S15P6qPV5vHfwiLOoWUj378QYFWrCIpt9lG7f2xCWuw63
	 p2St9I3IKWRmbLjGBmPvY+wl2tDdlU0T5ZFQyKl4Gry2WBgndKoY+x2G+W2xc2KNNPE79
	 bNKdPUT/moxGHw6zYAyuzRim7J+L88dztofDsk9X40ToEnoPKhCRNa3FVbRXJT2pHYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866447;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6JF9EI2l94MzBVRIwSaYP0GqXCFWuq3VNcdzQFYVjwk=;
	b=RyFeh0nIyKNipPIKU/2wa52QoHd9UGieQ2LoEyUTxIbZ5EsKOIXRYAMsMtWgciQ11QxW
	 aCOYaJU8QKzw7uPsgNwEBoOCPZhaCaATWMiSd/GjS5hGxbLnToz8Kj8e7fzlTgVUCPEKK
	 Zg54sTQK9rW1czBPyzaSMAfiT6/a8HDg8v3Nx9+PQqsE4Iuqfn7BG4R7HFIs7923HMeGg
	 rw5grwt+62vvt9IKUw6DXUkZ26hYBuAw3dnvbQMSJJaBtTn3R3lRH3tGRtWgVy2VLEKpe
	 HrEG3Ph93fqMdXqffP0sozk6lo17qG/uGJltXesG6cwGT5TcMZThueAiQmIgu4LfteA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyLG54eB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E20606A31C;
	Sat, 28 Nov 2026 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyLG54eB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2911F00898;
	Sat, 28 Nov 2026 11:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795866446;
	bh=6JF9EI2l94MzBVRIwSaYP0GqXCFWuq3VNcdzQFYVjwk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gyLG54eBFFztDDBy7wmc8dT0ca5//QrPTMqntJ/FMo/M8LrR5/QQtIsbDZohHqshH
	 /z4tjAq/dczbKRv65oGb8EY7mTmU8VGNicvaIW9Tn9unpUSyxC9mBKLc+7WRtaLXbN
	 10RiuADeszXmqnBH9CCNh6Lm02raG763QqiWMRpPAUTMYPPdTsR5wbVMtXe3bjn5FN
	 qcPC1+odjl3uiJLkmvCki+AeNqmqsqGt2TQK8UnnQ3J29FMfGPw3Cd2hgxx44plabG
	 4XryQg6+owup3mP2r96G+bRUrZMTO4TnbaPAy7psFfyVrvsC78TN9J0G0vpQan3fOI
	 7ipjYN19X1t9A==
Subject:
 Re: [PATCH net v2 2/2] xsk: fill in header offsets for TX checksum offload
From: netdev-bot+sashiko@kernel.org
To: kerneljasonxing@gmail.com
Cc: willemb@google.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, bjorn@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Date: Sat, 28 Nov 2026 11:47:25 +0000
Message-ID: <179586644541.3135.15029891543705593854@kernel.org>
In-Reply-To: <20261127105347.72997-3-kerneljasonxing@gmail.com>
References: <20261127105347.72997-3-kerneljasonxing@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch adds `skb_checksum_help()` calls in
  `xsk_skb_sw_csum()` (net/xdp/xsk.c) that run even when…
- [Medium] When `pool->tx_sw_csum` is false, `xsk_skb_sw_csum()` now
  checksums on the CPU every Ethernet CHECKSUM_PARTIAL frame it cannot…
- [Medium] `xsk_skb_sw_csum()` now sets skb->protocol, network_header and
  transport_header from a frame fully controlled by user space.
- [Medium] `xsk_skb_sw_csum()` now passes AF_XDP copy-mode
  CHECKSUM_PARTIAL frames to protocol-aware or unit-constrained hardware…

--

xsk: fill in header offsets for TX checksum offload

This patch makes xsk_skb_sw_csum() parse the Ethernet and VLAN headers of
CHECKSUM_PARTIAL AF_XDP copy-mode frames. It then sets skb->protocol and
the network and transport headers so the checksum request can be offloaded
to hardware. Frames whose L2 header can't be parsed, that aren't IPv4/IPv6,
or whose csum_start leaves no room for an L3 header fall back to
skb_checksum_help().

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 18cbd50047d80..3827d8e4b642a 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -1028,9 +1032,48 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  
>  static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
>  {
> -	if (unlikely(pool->tx_sw_csum &&
> -		     skb->ip_summed == CHECKSUM_PARTIAL))
> +	struct ethhdr eth_buf, *eth;
> +	int nhoff = ETH_HLEN;
> +	unsigned int l3_min;
> +	__be16 proto;
> +
> +	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
> +		return 0;
> +
> +	if (unlikely(pool->tx_sw_csum))
> +		return skb_checksum_help(skb);
> +
> +	if (unlikely(skb->dev->type != ARPHRD_ETHER))
> +		return 0;
> +
> +	eth = skb_header_pointer(skb, 0, sizeof(*eth), &eth_buf);
> +	if (unlikely(!eth))
> +		return skb_checksum_help(skb);

[Severity: High]
Can this fallback, and the other new skb_checksum_help() fallbacks below,
break copy-mode transmit on IFF_TX_SKB_NO_LINEAR devices such as
virtio_net?

On those devices xsk_build_skb() goes through xsk_build_skb_zerocopy(),
which only reserves headroom in the linear area:

net/xdp/xsk.c:xsk_build_skb_zerocopy() {
    ...
		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
		...
		skb_reserve(skb, hr);
    ...
}

That leaves skb_headlen() at 0. All of the payload sits in page frags
attached with skb_fill_page_desc(), which doesn't set SKBFL_SHARED_FRAG.
So skb_checksum_help() doesn't linearize, and it hits this check:

net/core/dev.c:skb_checksum_help() {
    ...
	if (unlikely(offset >= skb_headlen(skb))) {
		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
		WARN_ONCE(true, "offset (%d) >= skb_headlen() (%u)\n",
    ...
}

It then returns -EINVAL, so __xsk_generic_xmit() drops the frame and
sendmsg() fails:

		err = xsk_skb_sw_csum(skb, xs->pool);
		if (unlikely(err)) {
			xsk_drop_skb(skb);
			goto out;
		}

User space can reach every one of these fallbacks, because
xsk_skb_metadata() only checks csum_start + csum_offset + 2 <= desc->len.
Any of these frames will do:

- a frame shorter than ETH_HLEN
- an unparsable VLAN stack
- a non-IPv4/IPv6 ethertype
- a csum_start below nhoff + 20 (IPv4) or nhoff + 40 (IPv6)

Before this patch, these frames returned 0 here when tx_sw_csum was off.
xp_assign_dev() also refuses tx_sw_csum on these devices, precisely so
that skb_checksum_help() is never reached for them:

	if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
		return -EOPNOTSUPP;

virtio_net advertises NETIF_F_HW_CSUM, so the device computed the
checksum. With this patch the frame is dropped instead, and the user can
trigger a WARN_ONCE plus skb_dump. On panic_on_warn systems that is a
panic.

The commit message says these frames "keep being checksummed in software
exactly as before". Would returning 0 in the fallback cases work better?
That would leave the decision to validate_xmit_skb() as it was before.

> +
> +	proto = eth->h_proto;
> +	if (eth_type_vlan(proto)) {
> +		proto = __vlan_get_protocol(skb, proto, &nhoff);
> +		if (unlikely(!proto))
> +			return skb_checksum_help(skb);
> +	}
> +
> +	switch (proto) {
> +	case htons(ETH_P_IP):
> +		l3_min = sizeof(struct iphdr);
> +		break;
> +	case htons(ETH_P_IPV6):
> +		l3_min = sizeof(struct ipv6hdr);
> +		break;
> +	default:
>  		return skb_checksum_help(skb);

[Severity: Medium]
Leaving the non-linear case aside, does this take checksum offload away
from frames that were offloaded before this patch?

Even with skb->protocol == 0, a NETIF_F_HW_CSUM device still offloaded
the frame:

include/linux/netdevice.h:can_checksum_protocol() {
    ...
	if (features & NETIF_F_HW_CSUM) {
		/* Can checksum everything */
		return true;
	}
    ...
}

skb_csum_hwoffload_help() also returns 0 for NETIF_F_HW_CSUM. On
virtio_net, veth and other HW_CSUM devices, non-IP or unparsable frames
are now checksummed on the CPU instead.

The policy also looks inconsistent. Non-ARPHRD_ETHER devices return 0
and keep offload, but Ethernet devices with an unknown L3 type are forced
into software.

Documentation/networking/xsk-tx-metadata.rst says XDP_TXMD_FLAGS_CHECKSUM
asks the device to compute the checksum. It describes CPU checksumming as
the XDP_UMEM_TX_SW_CSUM option.

For HW_CSUM devices the commit message doesn't match this behaviour
either:

  However skb->protocol stays 0, the offload never actually reaches
  the hardware and checksum ends up being computed in software every time

and:

  ... cannot be described to the hardware, so it keeps being checksummed
  in software exactly as before.

Since this is tagged for stable, could the commit message describe the
behaviour change accurately? Alternatively, could these fallbacks return
0 so the core path keeps making the decision?

> +	}
> +
> +	if (unlikely(skb_checksum_start_offset(skb) < nhoff + l3_min))
> +		return skb_checksum_help(skb);

[Severity: Medium]
Is checking only the minimal L3 header size enough before handing the
frame to protocol-aware driver checksum paths?

xsk_skb_metadata() only guarantees csum_start + csum_offset + 2 <=
desc->len. Nothing guarantees that a full L4 header exists at
csum_start.

Before this patch, harmonize_features() or ice_features_check() kept
these frames away from the driver offload path. Now take ice E810, which
has IP_CSUM|IPV6_CSUM but no HW_CSUM. ice_tx_csum() takes the L4 protocol
from the user-controlled ip.v4->protocol, and for TCP it reads:

drivers/net/ethernet/intel/ice/ice_txrx.c:ice_tx_csum() {
    ...
	case IPPROTO_TCP:
		/* enable checksum offloads */
		cmd |= ICE_TX_DESC_CMD_L4T_EOFT_TCP;
		l4_len = l4.tcp->doff;
    ...
}

For example, take eth(14) + IPv4 with protocol=TCP, csum_start=34,
csum_offset=6 and desc->len=42:

- skb_csum_hwoffload_help() accepts it, since csum_offset 6 equals
  offsetof(struct udphdr, check)
- ice_features_check() accepts MACLEN 14 and IPLEN 20

doff is then read at transport_header + 12, up to 5 bytes past
skb->tail. The read stays inside the skb head allocation, but that memory
is uninitialized and KMSAN would flag it.

The value read is programmed into the descriptor's L4LEN field. Whether
a bogus L4LEN can trigger NIC malicious driver detection or TX hangs
hasn't been verified.

AF_PACKET with vnet_hdr has a similar weakness, but this patch newly
exposes the AF_XDP path to it.

Should this require a full TCP/UDP header past csum_start, consistent
with csum_offset, before setting the transport header and skipping the
software checksum?

> +
> +	skb->protocol = eth->h_proto;
> +	skb_set_network_header(skb, nhoff);
> +	skb_set_transport_header(skb, skb_checksum_start_offset(skb));

[Severity: Medium]
Can the hardware end up writing the checksum somewhere other than the
requested csum_start/csum_offset?

Only the ethertype and csum_start >= nhoff + l3_min are checked here.
Drivers, though, program these offsets in coarser units or take the L4
type from the packet itself. Three cases on ice show this.

First, the legacy path (E810) programs IPLEN in dwords:

	l3_len = l4.hdr - ip.hdr;
	offset |= (l3_len / 4) << ICE_TX_DESC_LEN_IPLEN_S;

ice_features_check() only rejects odd or oversized lengths:

	len = skb_network_header_len(skb);
	if (len > ICE_TXD_IPLEN_MAX || len & 0x1)
		goto out_rm_features;

An L3 length of 22 therefore becomes 5 dwords, and the L4 checksum starts
2 bytes before csum_start.

Second, the L4 type comes from ip.v4->protocol or the IPv6 nexthdr, not
from csum_offset. skb_csum_hwoffload_help() only requires csum_offset to
be 16 or 6.

With protocol=TCP and csum_offset=6, the device writes the TCP checksum
at L4+16 rather than L4+6. With protocol=SCTP (csum_not_inet is 0), it
writes a CRC32c at L4+8 rather than a 16-bit Internet checksum.

Third, the GCS path (E830, HW_CSUM) uses:

		u16 csum_offset = skb->csum_offset / 2;

That rounds an odd csum_offset down, so the result lands one byte early.

Before this patch, skb_checksum_help() computed all of these at exactly
csum_start/csum_offset. With this patch, other bytes of the transmitted
frame get overwritten. So the commit message's "exactly as before" claim
doesn't hold for these frames either.

Would it make sense to add these checks, or else leave the decision to
the core path?

- IPv4 ihl * 4 (or the IPv6 header plus extension headers) equals
  csum_start - nhoff
- the L4 protocol is TCP or UDP with a matching csum_offset (16 or 6)
- the offsets are even

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127105347.72997-1-kerneljasonxing%40gmail.com
