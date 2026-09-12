Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5319D8BC;
	Sat, 12 Sep 2026 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789208913; cv=none; b=Way/xeMr8fbGNtFvIuoi8dbwhGqfpfuL06mXsYVQem0LCCCd7esoY6mFthmdf/HI+PZrI37UHRFmPvC7Po1pI0YMn2Ei0GoGsTo1bDde3dcXl/ydiYHIjXkQNU363IXU3brT9qNS+7UzWxs+lLIpr88E/PH+zsfJik0q/E5F7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789208913; c=relaxed/simple;
	bh=tLEFTsIWr9PBRCDuxXSlgORwhEQ8o/t+rrtg8hpJDlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaMxfl42kcqy1eEDwR5a76V6nGbpbWG2P1pjhtqduXR5b6APrz4TMZOmtKzWVCzpzSIrIF1gKZoU1ZWjHWinbOC1VNNd8uv71l9YLzAJR3au5NWYNQxj+YE3B4Kj6TnmWnX32oZTFhmdMUW4WJD5pKyBMmkCLObbwmf9/dBxhmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2l4h1Pm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2l4h1Pm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617FE1F000FF;
	Sat, 12 Sep 2026 10:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789208911;
	bh=At+WeKXtQjeogENKXppQ8RFPEPNYjU9qfcKZa6sKpdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e2l4h1Pm+ysCufWt/uQ0dElEbJq/UZQxBeNOLINZ0nWL4VjzyzhGBk7wPagGO9udD
	 2X3JAIh9PtniXevsaELg2k1qDTKXv+20pk3UJKhBiiq0lmplzFnblhwxy1BKMTJM6p
	 5cgt0R3BnQJUvBd6uAdVXNF5QfG+55LHVz1anjn3AHDHM6mryPw3gEkoFaDmdmnsyJ
	 5MhFGqr5Ac9SksS31H7P8Kp8QnpeG0N/WL5yMg669YJMOx1ZYLPWeAjF+4o0acbhCI
	 j5JP2N0EotWKjUExD864PxDvPcDdB6kXdUqZRqBT6ycZ//pgbs+6c6PGmWqu2mo2Yw
	 NOgyKu8mYLtUw==
From: Simon Horman <horms@kernel.org>
To: zihanx@nebusec.ai
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-afs@lists.infradead.org,
	dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	root@tr0jan.top
Subject: Re: [PATCH net v4 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Sat, 12 Sep 2026 11:26:59 +0100
Message-ID: <20260912102659.174546-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ca1d010bc963319d4167b8e985b5afac5912f6da.1788878590.git.zihanx@nebusec.ai>
References: <ca1d010bc963319d4167b8e985b5afac5912f6da.1788878590.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/ca1d010bc963319d4167b8e985b5afac5912f6da.1788878590.git.zihanx@nebusec.ai?part=1
---
rxrpc: fix encap_rcv skb accounting exhaustion

This charges encapsulated packets against the UDP tunnel socket's receive
buffer in rxrpc_encap_rcv() and drops them once sk_rcvbuf is reached, then
orphans PACKET skbs when the I/O thread dequeues them.  It also moves the
sk_user_data clearing under RCU and defers sock_release() until after the
local queues are purged.

Link: https://lore.kernel.org/all/cover.1788539302.git.zihanx@nebusec.ai/
Link: https://lore.kernel.org/all/cover.1785339953.git.zihanx@nebusec.ai/
Link: https://lore.kernel.org/all/cover.1784742007.git.zihanx@nebusec.ai/

> diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
> index dc5184a2fa9d..415b05f5e2b4 100644
> --- a/net/rxrpc/io_thread.c
> +++ b/net/rxrpc/io_thread.c
> @@ -13,6 +13,22 @@ static int rxrpc_input_packet_on_conn(struct rxrpc_connection *conn,
>  				      struct sockaddr_rxrpc *peer_srx,
>  				      struct sk_buff *skb);
>  
> +/*
> + * Drop UDP rmem ownership for packets charged in encap_rcv().
> + * sk_forward_alloc is serialised by sk_receive_queue.lock.
> + */
> +static void rxrpc_skb_orphan_udp(struct sk_buff *skb)
> +{
> +	struct sock *sk = skb->sk;
> +
> +	if (!sk)
> +		return;
> +
> +	spin_lock_bh(&sk->sk_receive_queue.lock);
> +	skb_orphan(skb);
> +	spin_unlock_bh(&sk->sk_receive_queue.lock);
> +}
> +
>  /*
>   * handle data received on the local endpoint
>   * - may be called in interrupt context

[ ... ]

> @@ -52,6 +66,22 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
>  	}
>  #endif
>  
> +	spin_lock(&udp_sk->sk_receive_queue.lock);
> +	if (atomic_read(&udp_sk->sk_rmem_alloc) >= READ_ONCE(udp_sk->sk_rcvbuf) ||
> +	    !sk_rmem_schedule(udp_sk, skb, skb->truesize)) {

[Severity: High]

Which sk_rcvbuf value does this end up comparing against?  Nothing in
net/rxrpc/ sizes the tunnel socket's receive buffer.  rxrpc_open_socket()
calls udp_sock_create() and setup_udp_tunnel_sock(), neither of which touches
it, so it stays at what sock_init_data() assigned:

net/core/sock.c:sock_init_data() {
	...
	sk->sk_rcvbuf		=	READ_ONCE(sysctl_rmem_default);
	...
}

That is roughly 208 KiB of truesize for the entire local endpoint, and since
this is a kernel socket with no fd, the only way to change it is the global
net.core.rmem_default.

Meanwhile rxrpc keeps advertising a 255 packet receive window per call:

net/rxrpc/misc.c:
unsigned int rxrpc_rx_window_size = 255;

net/rxrpc/conn_event.c:rxrpc_conn_retransmit_call() {
	...
	trailer.rwind		= htonl(rxrpc_rx_window_size);
	...
}

with rxrpc_rx_mtu at RXRPC_JUMBO(46).  Both are sysctl-tunable; the new cap
is not.

The test is a hard >= with no headroom, and the charge is only released one
skb at a time when the MIN_NICE krxrpcio thread dequeues.  At 2-4 KiB truesize
per MTU-sized skb, 50-90 queued skbs exhaust the budget, which a single
softirq round can deliver before the I/O thread runs.

Can a compliant AFS peer that simply fills the window rxrpc advertised to it
get dropped here, with no EXCEEDS_WINDOW ACK and recovery only via RTO?  The
resulting threshold, how it was derived, and the disagreement with the
advertised window aren't mentioned in the commit message or the v2/v3/v4
changelog.

> +		spin_unlock(&udp_sk->sk_receive_queue.lock);
> +		sk_drops_inc(udp_sk);
> +		kfree_skb(skb);
> +		return 0;
> +	}

[Severity: Low]

The drop returns 0, which UDP counts as a delivered datagram:

net/ipv4/udp.c:udp_queue_rcv_one_skb() {
	...
		ret = encap_rcv(sk, skb);
		if (ret <= 0) {
			__UDP_INC_STATS(net, UDP_MIB_INDATAGRAMS);
			return -ret;
		}
	...
}

So each dropped datagram bumps UDP_MIB_INDATAGRAMS and neither
UDP_MIB_RCVBUFERRORS nor UDP_MIB_INERRORS is incremented, unlike UDP's own
rcvbuf-overflow path for the same socket type
(__udp_enqueue_schedule_skb() -> -ENOMEM -> RCVBUFERRORS + INERRORS).
Under the flood this patch bounds, netstat -su shows InDatagrams climbing and
zero receive-buffer errors while sk_drops rises.

The hook return value can't express this (a negative return makes
udp_queue_rcv_one_skb() resubmit to the protocol and still counts
INDATAGRAMS), so would an explicit __UDP_INC_STATS(net, UDP_MIB_RCVBUFERRORS)
plus UDP_MIB_INERRORS here be appropriate, along with a specific
skb_drop_reason instead of the bare kfree_skb()?

> +
> +	skb->dev = NULL;
> +	skb_set_owner_r(skb, udp_sk);

[Severity: Medium]

This consumes the same counter and the same limit that the socket error queue
is gated on:

net/core/skbuff.c:sock_queue_err_skb() {
	if (atomic_read(&sk->sk_rmem_alloc) + skb->truesize >=
	    (unsigned int)READ_ONCE(sk->sk_rcvbuf))
		return -ENOMEM;
	...
}

rxrpc's only ICMP ingress is rxrpc_encap_err_rcv() ->
ip_icmp_error()/ipv6_icmp_error() -> sock_queue_err_skb().  On -ENOMEM the
notification is kfree_skb()'d, sk_error_report() is never called, so
rxrpc_error_report() never queues an RXRPC_SKB_MARK_ERROR skb and
rxrpc_input_error() never runs.

Does that silently drop port-unreachable (peer-dead) detection and
ICMP_FRAG_NEEDED path-MTU input for the whole endpoint for as long as the rx
queue is near full, i.e. exactly the state this patch holds during a flood?

Before this change the encap path never touched sk_rmem_alloc, so the budget
was effectively reserved for error skbs.  Error skbs also stay charged after
rxrpc_error_report() moves them onto local->rx_queue, since the patch
deliberately does not orphan them, which widens the window further.

> +	spin_unlock(&udp_sk->sk_receive_queue.lock);
> +	skb_dst_force(skb);

[Severity: Low]

What consumes the forced dst reference, and why is skb->dev cleared above?

A git grep for skb_dst and skb->dev in net/rxrpc/ matches only these two new
lines, and the only dst dereference in rxrpc (dst->dev->gso_max_segs in
peer_object.c) works on an output route lookup.

Before this change the queued skb carried a SKB_DST_NOREF dst, which
refdst_drop() skips on free; skb_dst_force() promotes it to a refcounted dst
held until the skb is finally freed.  UDP's own queueing path drops the dst
instead:

net/ipv4/udp.c:udp_queue_rcv_one_skb() {
	...
	ipv4_pktinfo_prepare(sk, skb, true);
	return __udp_queue_rcv_skb(sk, skb);
}

Would skb_dst_drop() be what is wanted here?  rxrpc_skb_orphan_udp() releases
the rmem charge at dequeue but leaves the dst in place, so DATA packets handed
to a call's recvmsg queue keep the reference for a
remote-sender-plus-slow-reader controlled interval that is not covered by the
new sk_rcvbuf cap, because dst size is not part of skb->truesize.

Neither skb->dev = NULL nor skb_dst_force() is described in the commit message
or the v2/v3/v4 changelog.

> +
> +	skb->mark = RXRPC_SKB_MARK_PACKET;
> +	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
>  	skb_queue_tail(rx_queue, skb);
>  	wake_up_process(io_thread);
>  	return 0;
> @@ -471,6 +501,9 @@ int rxrpc_io_thread(void *data)
>  		/* Distribute packets and errors. */
>  		while ((skb = __skb_dequeue(&rx_queue))) {
>  			struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
> +
> +			if (skb->mark == RXRPC_SKB_MARK_PACKET)
> +				rxrpc_skb_orphan_udp(skb);
>  			switch (skb->mark) {
>  			case RXRPC_SKB_MARK_PACKET:
>  				skb->priority = 0;

[ ... ]
