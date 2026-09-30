Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0444A49BC;
	Wed, 30 Sep 2026 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811132; cv=none; b=kbTifdbePgUZTTY4fELS09KVMfpxdvbwIIcBNsblvpSdZAYeNgjQYqcozmQUvEd0AOugYD+ISwmUwKhILZ5EGGOzgpol7ylGw07VtKUQZuGsEVe5PvjLJ4FoiQLfND71DWJVYhEOoDRcgD5gk8cSZ1sHdsBhINhgbEZzKVh3XXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811132; c=relaxed/simple;
	bh=1C09B0RZHqFGohU41SNKMG9NX6EX0Wfw56ApaRYZINo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WB/Th/9EBa8G1JO6VPOYc6zS3QEuqYnz65Gn/u8h4gIcUfcvWSl6/ZmyBBexmrpVy7NEQ16z07Y+SC0LhvfJNBoK2R9mOfYs0YTEL647MfSF9sefYSY15hfE037NQKZ93WNPoV4VofuUmnG2LSYbGJQSxVRPxUG4qdDQCyBzGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhpor0Lj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhpor0Lj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB4B1F000FF;
	Wed, 30 Sep 2026 23:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790811130;
	bh=ZEYfCaGXlegQ6ruHliZQgQ4C9on6hKRWUqPbAUl/o/0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vhpor0LjzY0sdmtSpGWH8dF5IDXZF7VJl0U3VzV5I7yphFW2+2m8TDfZLfEawKbeV
	 ZHDGeNn+eu58bNxvypQe6HQ5kJUxJop8Y5Zo3/OwjNDBXN8wsZFbmur1Ib1cqUQzE5
	 gLVqwCuDiY9Pg0LstQE4lQNRihGJHxE2qTlpmCn0CdxXwuiCUiDKxNw+zU7HqoX9oX
	 MhbanScWLi+wsOSTgkRRisABve9uKSjToiX26SlH1y5jvdkWybqyHFrP6GQFw08Dme
	 rRvRueSht7OgESTaXkwuBl2vFFMHAI7MFq12zULODSSiUPr6nCic0ynyPbpCMzGTwy
	 zh4SS66Dfbp/A==
Subject:
 Re: [PATCH v3 net] net/packet: guard the ll header push in packet_rcv_spkt()
From: netdev-bot+sashiko@kernel.org
To: quchaosheng000406@163.com
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mkl@pengutronix.de, socketcan@hartkopp.net,
 stable@vger.kernel.org
Date: Wed, 30 Sep 2026 23:32:09 +0000
Message-ID: <179081112900.434549.3927636774761151103@kernel.org>
In-Reply-To: <20260928113108.2127215-1-quchaosheng000406@163.com>
References: <20260928113108.2127215-1-quchaosheng000406@163.com>
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

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The history and Fixes attribution in the commit message are
  inaccurate.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the same CAN
  RX skb with mac_header == 0xFFFF (left that way by init_can_skb()…
- [High] This problem wasn't introduced by this patch, but the
  SOCK_PACKET receive path this patch touches leaks stale skb->cb bytes…

--

net/packet: guard the ll header push in packet_rcv_spkt()

This patch wraps the link layer header restore in packet_rcv_spkt() with
dev_has_header(), as packet_rcv() and tpacket_rcv() already do. The
motivation is a skb_under_panic() on CAN RX skbs whose mac_header is left
at the 0xFFFF sentinel, because init_can_skb() no longer resets the headers.

> commit d549699048b4 ("net/packet: fix packet receive on L3
> devices without visible hard header") introduced the helper and changed
> the two call sites, and this one stayed behind.

[Severity: Medium]
Is this history accurate?

In net/packet/af_packet.c, d549699048b4 changed

    if (dev->header_ops)

to

    if (dev_has_header(dev))

in packet_rcv() and tpacket_rcv(), and it also updated the block comment at
the top of the file. packet_rcv_spkt() never had a header_ops guard. Its
unconditional skb_push() goes back to the initial git import
(1da177e4c3f4).

The panic in the commit message only happens when mac_header is left at
0xFFFF. That has been the case since 9f10374bb024 ("can: remove private
CAN skb headroom infrastructure") removed the skb_reset_*_header() calls
from init_can_skb_reserve() and init_can_skb(). The current init_can_skb()
in drivers/net/can/dev/skb.c only does:

    skb->pkt_type = PACKET_BROADCAST;
    skb->ip_summed = CHECKSUM_UNNECESSARY;

> Fixes: d549699048b4 ("net/packet: fix packet receive on L3 devices without visible hard header")
> Cc: stable@vger.kernel.org

With this Fixes tag and Cc: stable, the patch would be queued for the 5.10+
stable trees as a panic fix. CAN RX skbs in those trees still reset their
headers, so this panic cannot happen there.

9f10374bb024 is the commit that makes the panic reachable, and it isn't
named in any tag. Should the Fixes tag point at 9f10374bb024 instead?

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 7c83e01526ed..a951a1e3c088 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1911,7 +1911,8 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
>  
>  	spkt = &PACKET_SKB_CB(skb)->sa.pkt;
>  
> -	skb_push(skb, skb->data - skb_mac_header(skb));
> +	if (dev_has_header(dev))
> +		skb_push(skb, skb->data - skb_mac_header(skb));

[Severity: High]
This isn't a bug introduced by this patch, but the same CAN RX skb with
mac_header == 0xFFFF also reaches generic XDP. This guard doesn't cover
that path.

netif_receive_generic_xdp() in net/core/dev.c does:

    mac_len = skb->data - skb_mac_header(skb);
    __skb_push(skb, mac_len);

Here mac_len comes out as roughly 4G - 65471, and __skb_push() only has a
DEBUG_NET warning. skb_headroom() then truncates to 65535, so no
reallocation happens, and the later __skb_pull() moves data back.

In bpf_prog_run_generic_xdp(), xdp_prepare_buff() gets a headroom of
skb_headroom - mac_len = 65535. That puts xdp->data at head + 65535, while
data_end is head + 80. The code then reads the Ethernet header at that
address:

    eth = (struct ethhdr *)xdp->data;
    orig_host = ether_addr_equal_64bits(eth->h_dest, skb->dev->dev_addr);

If a generic XDP program is attached to the CAN interface, can this read
out of bounds for every received CAN frame?

On XDP_TX or XDP_REDIRECT, __skb_push(skb, mac_len) also moves skb->data
about 4 GiB below head and sets a wrapped skb->len. The skb is then
transmitted or redirected.

dev_xdp_attach() has no device type restriction for generic mode. When a
program is attached, do_xdp_generic() runs for every RX skb:

  slcan RX
    alloc_can_skb()->init_can_skb()   /* mac_header stays 0xFFFF */
    netif_rx()
      __netif_receive_skb_core()
        do_xdp_generic()
          netif_receive_generic_xdp()
            bpf_prog_run_generic_xdp()

The af_packet guard alone doesn't close the 9f10374bb024 regression. Does
the separate init_can_skb() fix mentioned in the commit message need to
land together with this one?

>  
>  	/*
>  	 *	The SOCK_PACKET socket receives _all_ frames.

[Severity: High]
This is a pre-existing issue, but further down, packet_rcv_spkt() builds
the sockaddr_pkt in place in skb->cb:

    spkt->spkt_family = dev->type;
    strscpy(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
    spkt->spkt_protocol = skb->protocol;

strscpy() writes strlen(name) + 1 bytes and doesn't pad, and nothing clears
the rest of spkt_device. packet_recvmsg() then copies the full
sizeof(struct sockaddr_pkt) to userspace:

    memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);

Can this leak stale skb->cb bytes to userspace?

On GRO RX paths, cb still holds struct napi_gro_cb, and dev_gro_receive()
stores a slab pointer and jiffies there:

    NAPI_GRO_CB(skb)->age = jiffies;
    NAPI_GRO_CB(skb)->last = skb;

Nothing clears these before ptype_all delivery, and skb_share_check() and
skb_clone() copy cb.

With a 1 or 2 character interface name, cb[4..7] holds the upper 32 bits
of a kernel sk_buff address. With a 4 to 12 character name, jiffies still
leaks.

packet_create() checks CAP_NET_RAW with ns_capable(). A user in their own
user and network namespace can therefore create a veth with GRO enabled
and pick its name.

This dates back to the strlcpy() version. 8fc9d51ea2d32 swapped in
strscpy(), which doesn't pad either.

Would strscpy_pad(), or a memset() of the sockaddr_pkt before filling it,
be appropriate here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928113108.2127215-1-quchaosheng000406%40163.com
