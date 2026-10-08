Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29737A822;
	Thu,  8 Oct 2026 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482360; cv=none; b=sFIruaYdKFlx1eW0tWijwBcv8UBxwt/gISSRuNDl+jDC6Lv+GZ9RzOfUmizZQfcJS5nlAUrkdBLXHDtDdOcH004zYxw3JTVcdFl+cRe5nRNpQmIlNwxh2sySWHrKTqoauJxHS74p+/2g8iStlOtHl57SNgtirV12phr9bqV0gyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482360; c=relaxed/simple;
	bh=ksGkcX71DS4hl2C96zI+4LAlDKthdjb2KX+nNNVteFg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MA6julD4tyP03lMiHTt5xE94y3b3XVwuHhpaFwy/7UY8+Ha5yo0fk8Q6zm3natG0bOfWJpAvVi58L4ubMm/M8Zh13vGk030D/n1Lc+IzjFLYzyj8s4XUxdMFEN++Wk1ZibvmYa8G0bEDNTWg3vnwNEMX5ApcgNVXJOU9ds/Ny18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLZ0+X3j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLZ0+X3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457B31F000FF;
	Thu,  8 Oct 2026 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482358;
	bh=KBmde3ssC+n/C8xKUlqoQFdj9GQEgUYbcU1m4C/LKQI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fLZ0+X3jUr6OXFX+ReS17JWqyLZtHdULQde1XtdRCCCab/UBuKLOULW7SEd3FUauu
	 mL3XEHpDqKmxWvm8k4Vm1vjrPBFbySDSXnDNw+MEp4TUpRuyfkARvftQRzOsS7u0T3
	 S4PoUJXgr0eswY6Z0F5tYm5sLeKctXy64PbC4+PvgO3MZISFgWOse/wIulOr/uhndh
	 plr4HT5LnvR6P2N2TVjMfc48I25zuI9DWsUzBmYyw0W8Rke93LnYNq98cTbs4sKeTC
	 Z58fZwD+/9arQW9OXapn6yn2RgcGQWZFl9/cJDNk2BbhAlz5t79m5yyqzlzzkn13lj
	 zQSKMoDYrbLPw==
Subject: Re: [PATCH net] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, kaiyuanz@google.com,
 almasrymina@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 08 Oct 2026 17:59:17 +0000
Message-ID: <179148235783.434549.14322374227477832817@kernel.org>
In-Reply-To:
 <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
References:
 <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] With this patch, skb_copy_and_csum_bits()
  (net/core/skbuff.c:3636-3641) zero-fills the destination and returns 0…
- [Low] The commit message misstates where the bug actually matters.

--

net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()

When skb_copy_and_csum_bits() reaches unreadable frags, this patch zeroes
the rest of the destination buffer before it returns 0. The goal is to
stop stale memory from being sent on the wire. A negative len is left
alone so it doesn't turn into a huge memset().

> When skb_copy_and_csum_bits() reaches unreadable frags it returns 0
> after copying only the linear part, and the rest of the caller's buffer
> is left as it was.  The callers copy into a buffer that is about to go
> out on the wire: an ICMP error quoting the offending packet, or a
> driver's TX bounce buffer in skb_copy_and_csum_dev().  Neither buffer
> is zeroed beforehand, so whatever was in memory there gets sent.

[Severity: Low]
Can the skb_copy_and_csum_dev() example actually see an unreadable skb?
Its callers are 8139too, via-rhine, ep93xx, ec_bhf, ksz884x and sc92031.
All of them leave dev->netmem_tx at NETMEM_TX_NONE, and
validate_xmit_unreadable_skb() frees unreadable skbs for those devices
before ndo_start_xmit runs:

net/core/dev.c:validate_xmit_unreadable_skb() {
    ...
	if (dev->netmem_tx == NETMEM_TX_NONE)
		goto out_free;
    ...
}

The same seems to hold for sunvnet's vnet_skb_shape().

Also, not every caller sends the buffer. xdr_skb_read_bits() in
net/sunrpc/socklib.c copies into an RPC receive buffer.

Some reachable paths aren't mentioned: the !sg && !csum branch of
skb_segment(), and the fraggap copies in __ip_append_data() and
__ip6_append_data(). The ICMP quoting path through icmp_glue_bits() and
icmpv6_getfrag() is mentioned, but no concrete trigger is given.

The change is in the shared helper, so the code covers all of these. This
is tagged for stable, though. Could the commit message list the paths that
can actually be reached?

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 4aea06d5167d1..41beaf625421a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3633,8 +3633,12 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
>  		pos	= copy;
>  	}
>  
> -	if (!skb_frags_readable(skb))
> +	if (!skb_frags_readable(skb)) {
> +		/* Don't hand the caller a buffer with stale bytes in it. */
> +		if (len > 0)
> +			memset(to, 0, len);
>  		return 0;
> +	}

[Severity: High]
If offset is at or past skb_headlen(skb), the header copy is skipped and
csum stays 0. After this change the whole destination is zeros, and 0 is
the correct partial checksum for an all-zero buffer.

Can this lead to silent payload corruption when software GSO runs on a
devmem TX skb? skb_segment() uses the return value directly in its
!sg && !csum branch:

net/core/skbuff.c:skb_segment() {
    ...
		if (!sg) {
			if (!csum) {
				if (!nskb->remcsum_offload)
					nskb->ip_summed = CHECKSUM_NONE;
				SKB_GSO_CB(nskb)->csum =
					skb_copy_and_csum_bits(head_skb, offset,
							       skb_put(nskb,
								       len),
							       len);
				...
			} else {
				if (skb_copy_bits(head_skb, offset, skb_put(nskb, len), len))
					goto err;
			}
    ...
}

tcp_gso_segment() then sets th->check via gso_make_checksum(skb,
~th->check). That folds the TCP header and pseudo-header with
partial = 0, so the zero-filled payload gets a valid checksum. Devmem
payload lives entirely in net_iov frags, which means every segment's
offset is past headlen.

The path looks reachable, with CAP_NET_ADMIN needed to turn off TX
offloads:

- sk_setup_caps() ORs NETIF_F_SG | NETIF_F_HW_CSUM into sk_route_caps.
  As a result, tcp_sendmsg_locked() still accepts a dmabuf_id after
  something like "ethtool -K <dev> tx off".

- validate_xmit_unreadable_skb() passes the skb for a NETMEM_TX_DMA
  device with a matching binding, or for any NETMEM_TX_NO_DMA device
  such as netkit.

- skb_gso_segment() -> tcp_gso_segment() -> skb_segment() then runs with
  sg and csum both false.

Before this patch the payload was stale bytes with a payload checksum of
0, so the receiver almost always dropped the segment. With the patch, the
peer would accept the zeros as stream data.

The commit message says:

  The checksum usually won't match the data any more, so the receiver
  will usually drop the packet

On this path the checksum always matches. The csum branch next to it in
skb_segment() fails on the same input, because skb_copy_bits() returns
-EFAULT and the code does goto err.

Should the !csum branch in skb_segment() fail the same way? Another option
is for skb_copy_and_csum_bits() to return a checksum that can't match the
zero-filled data.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3%40toxicpanda.com
