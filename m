Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951336;
	b=dokLzeBnXrUrMngunLAZ3rOatPpyI1V/s2BDFaJzT/rjLVztX1rLNld7OXrle/x2SeFR
	 N9IeThDIvN7hsktPC+UrQxYIpa7ctoH4iwMn1bIzXEhC8hIBMfzdHv3jHF7RKSi5Xkwxc
	 AIzJ1CR9M/W3vXmOMtxZg7ilmIF3hxQjvMB6KlGK3jXEH0hFrQYmjWTfgCiLuunEiy3sR
	 5ZNdAhBBcZr9l6ZkrIuMg5OKHtjtZPQ14ztGC74uEWxEVXifF1dO/2gvwI8RRY3K7jg7f
	 CtybPOFOgWNd/FRLO9natPxMjqx2R58tkVFjBz/hUzS0quqqG2BhYIFzyl6rf2CTJ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951336;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=cp+M7blHKTSkY1WHcYFiDIHFha5In/rincsxdAzM5xA=;
	b=D6h9HfWVbG1wcPVNz0Y9YJ02DSbs1HrPkrLYh7JiYOgStV/UuD+/RVlZuegSsI5jXobM
	 N/8++HzVyCE2NrU6WM3bcblWzFZufRh8NHg8a6gyk1WOGNTeCNwPDIVwSKZCykSKex7P/
	 xSpVdwfp3LXme+KYhEmjKiptrvCzu/Z6xMuQnwghJEE78bdd0hddYz3qTQ0ZECwO9aouG
	 YwJXZcRBcEIotKYjizdFUvlIvf2mAgORbREreU9/O07vontJBD9lHYPnK8cPF03PFgclp
	 PQeA5mPNGnNURbW5F1DEttmbApnz32AvkGRCIiNvS5jTuRLzqhJUMVhB6OOMtpaOYjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=GlxboIJw;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31AB606A326;
	Fri,  6 Nov 2026 07:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A31AB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=GlxboIJw
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C510F20870;
	Fri,  6 Nov 2026 08:48:52 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mzrjWUSI4FsE; Fri,  6 Nov 2026 08:48:52 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 14FC22074F;
	Fri,  6 Nov 2026 08:48:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 14FC22074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793951332;
	bh=cp+M7blHKTSkY1WHcYFiDIHFha5In/rincsxdAzM5xA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=GlxboIJwiZEwrKgY2FQcnBIYD5yq+uKOBfcm3E/gFa/sisOJnC4u2e8sqiO7JBZst
	 wrRQgY+3PUO1YnrGyAWa6q+v5n9//RVSHpIwg5D0Au5q0y6Q4hSqh2ldDckT4b66z9
	 9TRdgErnEge/y5+ZFiJo9pRE5qx4JvSTBNuK9CnomLO3B3xJgjrSjKapJoE1watNub
	 IRSrEpBJmRYqjBAAIjWi7HMiprRujDTBlP1jpv+RCP2zym1b9Dqkmcr2hVHbJUhJQI
	 2MiaIZqsY9VdAaZN2SB1LwfhQOqSqkqKaIUUojt3k6H0j4aVL9K3SldOOGDr2TCNEV
	 6d5DzimRRVP+g==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 6 Nov
 2026 08:48:50 +0100
Received: (nullmailer pid 3069745 invoked by uid 1000);
	Fri, 06 Nov 2026 07:48:50 -0000
Date: Fri, 6 Nov 2026 08:48:50 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Guoshuai Yang <yangguoshuai@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Sabrina Dubroca
	<sd@queasysnail.net>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v4] xfrm: esp: reset outer TCP GSO metadata on
 espintcp input
Message-ID: <au2GYqYCqjfu45ku@gauss4>
References: <20261027225710.51832-1-yangguoshuai@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261027225710.51832-1-yangguoshuai@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Oct 28, 2026 at 06:57:10AM +0800, Guoshuai Yang wrote:
> When ESP packets are received over TCP (RFC 8229 espintcp), strparser
> slices individual length-prefixed ESP records from the outer TCP stream by
> cloning the incoming TCP skb(s) in __strp_recv().
> 
> If the outer TCP skb was GRO-coalesced before reaching strparser, its
> skb_shinfo carries the outer TCP stream's GSO metadata (gso_size, gso_segs,
> and gso_type). When an ESP record spans two outer TCP segments, strparser
> chains the spillover clone onto skb_shinfo(head)->frag_list.
> 
> Subsequently in esp_input() and esp6_input(), skb_cow_data() unshares the
> head skb via pskb_expand_head() (preserving the outer TCP gso_size and
> gso_type in the new private skb_shinfo) and calls skb_copy() on each cloned
> frag_list member, which copies the outer TCP GSO fields via
> skb_copy_header() onto a linear frag_list child skb allocated from slab
> with head_frag == 0.
> 
> Furthermore, on kernels with TCP fraglist GRO support, if an outer TCP GRO
> aggregate carrying SKB_GSO_FRAGLIST reaches the espintcp socket unsegmented
> (for example, when rx-gro-list is enabled on a device in an outer netns
> where tcp4/6_check_fraglist_gro() finds no local socket and the aggregate
> is forwarded across a NETIF_F_GSO_FRAGLIST-capable veth device into the
> netns hosting the espintcp socket) and is chained onto
> skb_shinfo(head)->frag_list by __strp_recv(), skb_cow_data() invokes
> skb_copy() / skb_copy_expand() on that frag_list member and hits
> WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST), failing with
> -ENOMEM before decryption even begins. (On older stable trees without TCP
> fraglist GRO, the pre-pass is a no-op.)
> 
> After ESP decryption and header removal, the resulting single inner packet
> still has skb_is_gso(skb) == true with the stale outer TCP gso_size, while
> skb_headlen(head_skb) is now smaller than that gso_size due to stripping
> the outer framing and ESP header. When this packet passes through
> gro_cells_receive() (which flushes frag_list packets via GRO_NORMAL
> without resetting gso_size) and is forwarded, validate_xmit_skb() invokes
> tcp_gso_segment() -> skb_segment(). Because head_skb is shorter than the
> stale gso_size and SKB_GSO_DODGY is not set, skb_segment() attempts to map
> the slab-backed frag_list member as a scatter-gather page fragment where
> list_skb->head_frag == 0. On current mainline kernels, skb_segment()
> triggers DEBUG_NET_WARN_ON_ONCE(1) and fails with -EINVAL, causing
> validate_xmit_skb() to drop all multi-segment espintcp packets. On stable
> kernels prior to the removal of BUG_ON(!list_skb->head_frag) in
> skb_segment() (such as 6.12.94 where this trace was captured), it crashes
> the kernel:
> 
>   Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
>   PC is at skb_segment+0x574/0xd20
>   LR is at skb_segment+0x884/0xd20
>   Call trace:
>    skb_segment from tcp_gso_segment
>    tcp_gso_segment from inet_gso_segment
>    inet_gso_segment from skb_mac_gso_segment
>    skb_mac_gso_segment from __skb_gso_segment
>    __skb_gso_segment from validate_xmit_skb
>    validate_xmit_skb from __dev_queue_xmit
>    __dev_queue_xmit from ip_finish_output2
>    ip_finish_output2 from ip_output
>    ip_output from ip_sublist_rcv_finish
>    ip_sublist_rcv_finish from ip_sublist_rcv
>    ip_list_rcv from __netif_receive_skb_list_core
>    __netif_receive_skb_list_core from __netif_receive_skb_list
>    __netif_receive_skb_list from gro_normal_list
>    gro_normal_list from gro_cell_poll
> 
> Similarly, if a decrypted inner packet with a frag_list later takes the
> ip_do_fragment() frag_list fast path, each detached frag_list member is
> transmitted as a standalone IP fragment and would still carry the stale
> outer TCP GSO state when reaching validate_xmit_skb(). And even when an
> ESP record does not have a frag_list, leaving the stale outer TCP gso_size
> on the decrypted inner skb prevents dev_gro_receive() from initializing
> gso_size to the inner packet's skb_gro_len().
> 
> We cannot reset GSO state earlier in espintcp_rcv() / handle_esp() because
> the skb may still be a clone sharing skb_shinfo with the outer TCP skb held
> by strparser. Instead, in esp_input() and esp6_input():
> 1. Prior to skb_cow_data(), unshare/unclone and reset GSO metadata on any
>    frag_list member carrying SKB_GSO_FRAGLIST (unsharing any shared
>    predecessor frag_list members along the walk) so skb_copy() /
>    skb_copy_expand() inside skb_cow_data() does not hit WARN_ON_ONCE() and
>    drop the packet.
> 2. At skip_cow, where the head skb and all frag_list members are guaranteed
>    to be uncloned with private skb_shinfo, call skb_gso_reset() on both the
>    head skb and each skb_walk_frags() member.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guoshuai Yang <yangguoshuai@gmail.com>

Applied to the ipsec tree, thanks a lot!
