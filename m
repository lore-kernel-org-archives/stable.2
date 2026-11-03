Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689134;
	b=4IE0M9xbc8i1FCp+ecz1zrsQ5pOchtGSNuzYJ6ZMqhZuHw/3EWd1izfdLCWn2xKcCzU+
	 qG5GGPw9APQYQx6JUh/7oZIDBupM7tBRZ0m16aCh9CMK53xb7n3X0fBGhE0LbgsC8gzEf
	 UztAFQXkF3Rlk6PEgPMvrCGIrkSqVjymO49a5cxiN34lJ/2pSSBZT90LM1hppJcp6lzg5
	 9O3AwMkDebYdzQmSq4M4J0bz8OlIiQnqpzhcs9qXp+3Aa9GpzLDwvxoOmzDCW/9DdHxiO
	 AgqHqUCzwqh4Hp73Bvgcx1z2rGLQUp5lk1w27KAg/q4WAAcH+IkIZsR4e1mtBcf6bXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689134;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FbNwIIesd35gMyMCitT3Boc7Pz0ffUauO/QG4IAyeQ8=;
	b=Btko0Nm9Cy2vDQRe/ZjNbmEYWF5sUBs+zQpK20ww4qdjDFyi7JQ9kj/0wn5CsjT65gyy
	 1G9zrckNNOd5rfNknawLVSR1V3c+0PzaQ8o675C7eAXozd3YgcHbCDbp+hMlVPl9u3WV9
	 ZRHROkCCvXeCYE0MiXNWaH1ay542c+P4FZK/FS6LW43MaA47wvLPlpZUakedXN3whksJ8
	 c9isngnEn+kXhOJDRcPDLY7VjB6eK66PpwHAUJ08qiUTCIEAt5ADTzKuo84CW5OIsSAQR
	 AMNUmGX9xWV+6r35YUZrbo5ZOpZSOJrTnnuoRfoC/YZ6BhlPiKyOzSrFghM5zh+HceQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYYxCUm3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0517606A330;
	Tue,  3 Nov 2026 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYYxCUm3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CE51F00919;
	Tue,  3 Nov 2026 06:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793689133;
	bh=FbNwIIesd35gMyMCitT3Boc7Pz0ffUauO/QG4IAyeQ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UYYxCUm32vPRI4rnUBdMiKrdFsWgyMkMumRWqL0BQ6gOFy33JSj6tUkRafXZoR7+r
	 WgTaEBvhbDJe0LjC1tpxrgJMGCrUyvkW5k7OohFiWTIHo2prxlVssqjr670GnSYRWm
	 uiFxRVLZCvRsBmkEZJb6RhtNWPuvI7Ut2mUk5eY2giIO+X1FG+dOipya14yLP/fU4c
	 00qzA0QhMKgE9IWC9OUwe8T+FE4a9arkfIztNube36SRawhvHzP8V+0NnATczJaKa6
	 74+4qwrqLwJSuUZODnITIwGHCUtdbuIjV1/fCl6EUSIau6T9kQlNhjtE3BVP9iNv2/
	 XMrsQcZ8mb6OQ==
Subject: Re: [PATCH net] tcp: ipv6: keep request pktopts alive until request
 destruction
From: netdev-bot+sashiko@kernel.org
To: x-professor@outlook.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 03 Nov 2026 06:58:52 +0000
Message-ID: <179368913254.488856.18385504892768875446@kernel.org>
In-Reply-To: <82c31e4d5043f3dbd11b44177cfba779d335aae3.1793599929.git.x-professor@outlook.com>
References: <82c31e4d5043f3dbd11b44177cfba779d335aae3.1793599929.git.x-professor@outlook.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] This patch adds a remote-triggerable use-after-free on the
  IPv6 syncookie path.

Pre-existing issues:
- [High] The patch fixes the request-migration ownership race for
  ireq->pktopts but leaves the same race open for the other request…

--

tcp: ipv6: keep request pktopts alive until request destruction

This patch removes the code in tcp_v6_syn_recv_sock() that dropped the
request's ireq->pktopts reference when the child was created. It also
makes inet_reqsk_clone() take its own skb reference for migrated requests,
so every request now releases pktopts from tcp_v6_reqsk_destructor(). The
aim is to close a use-after-free where a concurrent SYNACK retransmit
reads ireq->pktopts after it has been freed.

> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 93b306d91b6dc..66f8ce25aa383 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -936,6 +936,11 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
>  		      req->rsk_ops->obj_size - offsetof(struct sock, sk_dontcopy_end),
>  		      /* alloc is larger than struct, see above */);
>  
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (inet_rsk(nreq)->pktopts)
> +		skb_get(inet_rsk(nreq)->pktopts);
> +#endif
> +
>  	sk_node_init(&nreq_sk->sk_node);
>  	nreq_sk->sk_tx_queue_mapping = req_sk->sk_tx_queue_mapping;
>  #ifdef CONFIG_SOCK_RX_QUEUE_MAPPING
> @@ -982,7 +987,6 @@ static void reqsk_migrate_reset(struct request_sock *req)
>  	req->saved_syn = NULL;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	inet_rsk(req)->ipv6_opt = NULL;
> -	inet_rsk(req)->pktopts = NULL;
>  #else
>  	inet_rsk(req)->ireq_opt = NULL;
>  #endif

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. The same
migration race still seems to be open for ireq->ipv6_opt, which is the
other request field that tcp_v6_send_synack() reads.

inet_reqsk_clone() copies the ipv6_opt pointer into nreq with memcpy. It
takes no reference and makes no copy. reqsk_migrate_reset(oreq) then
clears the pointer on the old request, which leaves nreq as the only
owner. Both reqsk_timer_handler() and inet_csk_complete_hashdance() go
through this path.

Another CPU may still hold oreq. It found oreq through ehash, migrated it
via reuseport_migrate_sock(), and then got a retransmitted SYN:

tcp_check_req()
  inet_rtx_syn_ack()
    tcp_v6_send_synack()

That CPU can be in:

net/ipv6/tcp_ipv6.c:tcp_v6_send_synack() {
    ...
		rcu_read_lock();
		opt = ireq->ipv6_opt;
		if (!opt)
			opt = rcu_dereference(np->opt);
		err = ip6_xmit(sk, skb, fl6, skb->mark ? : READ_ONCE(sk->sk_mark),
			       opt, tclass, READ_ONCE(sk->sk_priority));
		rcu_read_unlock();
    ...
}

Meanwhile nreq is released (after accept(), on listener close, or on
expiry) and runs:

static void tcp_v6_reqsk_destructor(struct request_sock *req)
{
	kfree(inet_rsk(req)->ipv6_opt);
	consume_skb(inet_rsk(req)->pktopts);
}

This kfree() is not deferred through RCU, so the reader's rcu_read_lock()
does not protect opt. Can ip6_xmit() then read a freed struct
ipv6_txoptions while it pushes the extension headers?

ipv6_opt is only non-NULL with CALIPSO labelling (calipso_req_setattr()).
The race also needs SO_REUSEPORT, net.ipv4.tcp_migrate_req=1 and a
listener that is closing.

This patch already reworks pktopts ownership in inet_reqsk_clone() and
reqsk_migrate_reset(). Should ipv6_opt be handled the same way there?

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360eae..0b51cb4ad9604 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1522,11 +1522,12 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
>  	if (*own_req) {
>  		tcp_move_syn(newtp, req);
>  
> -		/* Clone pktoptions received with SYN, if we own the req */
> +		/* Clone pktoptions received with SYN. Keep the request's
> +		 * reference until the request is destroyed, as a concurrent
> +		 * SYN retransmit may still read it.
> +		 */
>  		if (ireq->pktopts) {
>  			newnp->pktoptions = skb_clone_and_charge_r(ireq->pktopts, newsk);
> -			consume_skb(ireq->pktopts);
> -			ireq->pktopts = NULL;
>  			if (newnp->pktoptions)
>  				tcp_v6_restore_cb(newnp->pktoptions);
>  		}

[Severity: Critical]
Does removing this consume_skb() create a use-after-free on the IPv6
syncookie path?

On that path ireq->pktopts does not hold the SYN. cookie_v6_check()
stores the final ACK skb, which is still being processed, by bumping the
refcount directly:

net/ipv6/syncookies.c:cookie_v6_check() {
    ...
	if (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->header.h6) ||
	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
	    np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
		refcount_inc(&skb->users);
		ireq->pktopts = skb;
	}
    ...
}

Before this patch, the consume_skb() above dropped skb->users back to 1
before the child processed the skb.

Now tcp_get_cookie_sock() calls inet_csk_reqsk_queue_add(sk, req, child).
The request on the accept queue still points at the in-flight ACK, and
skb->users is 2.

The same skb is then passed to the child:

tcp_v6_do_rcv()
  tcp_child_process(sk, nsk, skb)
    tcp_rcv_state_process()
      tcp_data_queue()

For a pure ACK, tcp_data_queue() frees the skb without checking
skb->users:

	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
		__kfree_skb(skb);
		return;
	}

The consume label in tcp_rcv_state_process() and tcp_collapse_one() also
use __kfree_skb() in the same way.

When the request is released later, either by reqsk_put() from accept()
or by inet_csk_listen_stop(), the destructor runs:

tcp_v6_reqsk_destructor()
    consume_skb(inet_rsk(req)->pktopts);

Wouldn't this decrement the refcount of, and possibly free again, an skb
that has already been freed?

The trigger needs a remote peer that gets syncookies sent (SYN queue
overflow with the default tcp_syncookies=1, or tcp_syncookies=2) and then
completes the handshake with a pure ACK. The only local requirement is a
common IPv6 rx option on the listener, such as IPV6_RECVPKTINFO or
IPV6_RECVHOPLIMIT.

Syncookie requests are never hashed and never retransmit SYNACKs, so the
race this patch fixes cannot happen for them. Could the cookie path keep
dropping the request's pktopts reference here, or could cookie_v6_check()
store a separate clone instead of the in-flight skb?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/82c31e4d5043f3dbd11b44177cfba779d335aae3.1793599929.git.x-professor%40outlook.com
