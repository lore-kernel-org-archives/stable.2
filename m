Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E475A1A6811;
	Sun, 18 Oct 2026 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792292905; cv=none; b=tMu3TPXuky71W2ZhDA2ldB41v+nUAcTZ1nRPdQ+++7c9dierphrSj5LiIp/MsYxVUy6ORprai8M6VznGrD4c8VmhZZn2BVrwI2y8NdPopg/TmVEQRg87nzbuenti/nTXAKxI2rhHncF45rtaEVSNT/jeZ84JWZqthT+Q5eu9wE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792292905; c=relaxed/simple;
	bh=UuqHB8YycYlMyC4ByQ8d+u1wEcHNzqY0naURvnSVgXY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCu5ccdJH9PL9hL+BBkw4kL4unec8PEuNZ3pzfkS1qaOF7lPdLwg0dZALenqdKQCF2v3CNKs+/86cCiUahKS/fNWZz9QolHfJL49KJ4MU4pieQslcslR0Tra+Lx6RzDp204PiCTG7/CiXGdaGqG0TTQn1odhv2Eg0HLb9KAizEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ+GDlHR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ+GDlHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033721F000C4;
	Sun, 18 Oct 2026 03:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792292903;
	bh=JWPLR7A/LavbAJgY1uxDZajSqVtX9m0op6i0B4HJO00=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jJ+GDlHREjzVsREtr0tNOV9ThWTme8FYgzi6a9mD/VZUPuvBXyACNWMs8QVDWCc3q
	 Fe6B9TX1R2zpFBtDpZdxRjvCt9GoMDa2p5/+Nz5wW1SSwcWVQyWq/5lVupfedTdaJG
	 ysLyweJecdUdD1YMNfKP5l2YbxK8hTGNOx3ucbwZqITN/dpSiLsqrJMeCMO4nBysi7
	 qKR8Ly0H/HnkFttACKdlkipY3n676jqZSmXiixjLrslmdNOWATBmCa+CX0rIuCsgTF
	 zZV0gPt6uci8qdWM7etUI5mZFdl7Z3w8xowwRYgMdqm6mddGyttz6kbNt5mSYWzNQ1
	 OODr5q6cFHShQ==
Subject: Re: [PATCH net 2/2] net: usb: pegasus: check rx pkt_len against the
 received length
From: netdev-bot+sashiko@kernel.org
To: law.wei.jie@gt.tech.gov.sg
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, 98lawweijie@gmail.com, stable@vger.kernel.org
Date: Sun, 18 Oct 2026 03:08:22 +0000
Message-ID: <179229290253.3135.18168766657798775955@kernel.org>
In-Reply-To: <20261014025307.25233-3-law.wei.jie@gt.tech.gov.sg>
References: <20261014025307.25233-3-law.wei.jie@gt.tech.gov.sg>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In read_bulk_callback() (drivers/net/usb/pegasus.c), the new
  check `if (pkt_len + rx_offset > count) goto goon;` only sets an upper…
- [Medium] net: usb: pegasus: uninitialized memory read in eth_type_trans
  on short packets

--

net: usb: pegasus: check rx pkt_len against the received length

This patch changes the rx length check in read_bulk_callback(). Frames
whose device-reported length, plus the 0x8513 header, does not fit in
urb->actual_length are now dropped. Before, the length was only checked
against PEGASUS_MTU.

> diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
> index 7c7d6b69998f2..7bc9312eaa9ec 100644
> --- a/drivers/net/usb/pegasus.c
> +++ b/drivers/net/usb/pegasus.c
> @@ -520,10 +520,11 @@ static void read_bulk_callback(struct urb *urb)
>  	}
>  
>  	/*
> -	 * If the packet is unreasonably long, quietly drop it rather than
> -	 * kernel panicing by calling skb_put.
> +	 * If the packet is longer than what was actually received, quietly
> +	 * drop it rather than kernel panicing by calling skb_put or passing
> +	 * up stale buffer contents. count is at most PEGASUS_MTU.
>  	 */
> -	if (pkt_len > PEGASUS_MTU - rx_offset)
> +	if (pkt_len + rx_offset > count)
>  		goto goon;

[Severity: Medium]
This check bounds pkt_len from above, but is anything stopping a
pkt_len smaller than ETH_HLEN from reaching eth_type_trans()?

On a 0x8513 chip, a 4-byte transfer with buf[0..2] = 0 decodes to
pkt_len = 0 with rx_offset = 2. rx_status is buf[2], so the 0x1c
error bits are clear. 0 + 2 > 4 is false, so the frame is accepted.
The non-0x8513 path gets the same result from a trailer that decodes
to 4, since pkt_len -= 4 brings it to 0.

read_bulk_callback() then does skb_reserve(pegasus->rx_skb, 2) and
skb_put(pegasus->rx_skb, 0), and calls eth_type_trans().

eth_type_trans() reads the full 14-byte Ethernet header regardless of
skb->len. eth_skb_pkt_type() looks at h_dest, and h_proto is used to
pick skb->protocol. Only 2 of those 14 bytes came from the device.

The other 12 lie past urb->actual_length. They are either left over
from an earlier transfer, when the skb was reused on the goon path, or
uninitialized memory from __netdev_alloc_skb_ip_align().

KMSAN would report this as an uninit read. skb->pkt_type and
skb->protocol are then derived from whatever was in the buffer before
netif_rx() hands the skb to the stack.

The old PEGASUS_MTU check had the same hole. However, the new comment
says this check prevents passing up stale buffer contents. Would it
make sense to also drop frames with pkt_len < ETH_HLEN here, perhaps
counting them in rx_length_errors?

[Severity: High]
This sets an upper limit on pkt_len. Does it also need a lower limit?

Nothing checks that pkt_len is at least ETH_HLEN, so a short transfer that
claims a runt frame still gets through. For example, on a non-0x8513 chip a
4-byte transfer of 04 00 00 00 gives:

	pkt_len = buf[count - 3] << 8;    /* 0 */
	pkt_len += buf[count - 4];        /* 4 */
	pkt_len &= 0xfff;
	pkt_len -= 4;                     /* 0 */

rx_status is buf[2] = 0, and 0 + 0 > 4 is false, so the frame is accepted.

On 0x8513, a 4-byte transfer with buf[0..1] = 0 gives pkt_len = 0 and
rx_offset = 2, which also passes. Any pkt_len below 14 that fits in count
gets through the same way.

After skb_put(pegasus->rx_skb, pkt_len), eth_type_trans() calls
eth_skb_pull_mac():

include/linux/etherdevice.h:eth_skb_pull_mac() {
	struct ethhdr *eth = (struct ethhdr *)skb->data;

	skb_pull_inline(skb, ETH_HLEN);
	return eth;
}

skb_pull_inline() returns NULL because ETH_HLEN > skb->len, but nothing
checks the return value. eth_type_trans() then reads h_dest and h_proto from
the header anyway.

Those bytes lie past urb->actual_length. They are either left over from an
earlier transfer, when the skb is reused on the goon path, or uninitialized
memory from __netdev_alloc_skb_ip_align().

Those bytes set skb->pkt_type and skb->protocol, and netif_rx() then
delivers the skb. For an ETH_P_ALL packet socket the chain continues:

packet_rcv()
  dev_parse_header()
    eth_header_parse()
      memcpy(haddr, eth->h_source, ETH_ALEN);

packet_recvmsg() then copies sll_addr back to userspace. Can that expose up
to 6 bytes of stale rx buffer contents through sockaddr_ll?

The new comment says this check stops "passing up stale buffer contents".
Should this check also drop frames with pkt_len < ETH_HLEN?

>  
>  	/*

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014025307.25233-1-law.wei.jie%40gt.tech.gov.sg
