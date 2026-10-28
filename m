Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153597;
	b=siN2B55gOfp0BSBrfgFDaUCGPXp+d1xIGykJjdYKkMQlUrL/9CzTuZD5BHAJH2WDJ7jr
	 wgbWXthF0gEIkKke3Xd9t7oxduXW2+8mrgJslnwWqIltvVy8Pq4bdR1Z2Wfg779BXUMXy
	 o8dubtvonq2023N48viIAZX6vuPgcrWRZ1QALKY8Y8CtAlT/3i0PQUOr39uNOdPOPWjDQ
	 DyV6W/6/qVMCr3CLrzyEdRFlid8RQ4EuTLfPoVU5CF7e26Ui+OUOG96l+vaLZm4rN2Iuk
	 K0utOXug3QKO3BcyLxZv0XgLNhxIB71jrFCBMVFt2MVA8+4l4yss5PyTxg+JQaIW8bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ig8MXej4t56mcMXDRuyLj4VjGewCY4AkKZ34lxVRYvc=;
	b=f1XLDo12rBiqjndk1c+x6fsM+SVNr1sSVlAj8g8cMovejTQMKBkV+hqfYth/JbN2nSFj
	 pxR/n0rvLSZcdPvEFof/UUqgfxumZaqU8faAXHSYT3KlaONSvQGFS7jqnu0cdukpmAIp9
	 9gLOj21BZGmzvg6XwdfbKbBh4DGRWqvviY/yuYmwrtYzbbWDyH8MFBv7foLANh/u6Tr6k
	 mofvVfendBCU0U6vmMf4dgDjwvIjDiFbyWxchIobjnXG+CpDbQiLwLXm6QZ9/QVKzLba+
	 0dwJerF5u/9DnlqckvOmivgo1Ql88h5Xus+F35c7EgFMn9x7QQvRVpMwGQn6SOWi0Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="K0mQO2/z";
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3E9606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B3E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K0mQO2/z
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so734648a91.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 19:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793153596; x=1793758396; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ig8MXej4t56mcMXDRuyLj4VjGewCY4AkKZ34lxVRYvc=;
        b=K0mQO2/zInwnZeB7V8H3rNpR877JGRE+dWH6CedSdfv4vi8JQKkFgNffkBiVqsqz5i
         HLpxB4zt7RddlLWaB3H8x6uhtmlxF3CuQ7eOPjtNU3fyuSbN0li/29s1X4Pg+3Y7nyzO
         JA2tDvi4CnxX2RuYeWKJdAKvj+5IU9jqvb8KjSyAtcrKqBrX57jFbPUjUHYyFctoEPr+
         s0dOE1geHCodccHZq7iXdAw27WdOQMLE7I5nkt7LR1emywoaAKiKvafrZpAEvksLKvLy
         0WxJEbiM+MHcaUfP6sv1Y5JR7Gy6ru5X/BYFVN4hpv/9mXCoJ1Cku0dzy1tvnV74KXQr
         IvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153596; x=1793758396;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ig8MXej4t56mcMXDRuyLj4VjGewCY4AkKZ34lxVRYvc=;
        b=EiGRQIVZ7fl3ZPGpKE4iT04ELcRxOFbpVRuiXee+LBY4qsXa+84rVwvndxV94RauG3
         vZnPUxzuqECpgEY2DVk+l//+DQ1BqB+ZssPlfyGFyi84l8uQSGDQEjT6v49n4zeoWwm3
         Mrnkuy4ss1iMJuCDGVMUuYRC4Qt/Az1VH0H8gKEjrVyqfVJBU3lpA+CAGB+keJAXYzLs
         54MuwqCZ9dDFEw8Ypj5LaFg7TGKEHZDttJ9u3H1LdqS5Tc9TVmIoxfekyrdGncCI00TV
         1PxgEdvNeTdcHg0zFnPweRAPYEbZ/FFpr6/Td3L5i4D6OOLgNJLvWeTyKwaY2xgANZfR
         UvIA==
X-Forwarded-Encrypted: i=1; AKwUvBxLqHMuvFynRE55Cluhj7ETKpOhh9Umk7D4WRR1RFu8OSscVmNgZJNNKbJTmdrLerMkcpuhHpA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqV7U84V5ce6xBhWt3BEDKPLWGlyP3AiLDhnoRHvpkM5yCGy9R
	+8VnYnbxNaRJNAzcWeX8D8QuXEdlsLwfOsv3I8XGL3nvuVFkkHV+aLNxqrSfStKGnWZdWwvWTd+
	lva0GdA==
X-Received: from pjbci9.prod.google.com ([2002:a17:90a:fc89:b0:3ad:647f:c1bc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec8e:b0:3ac:8897:7b92
 with SMTP id 98e67ed59e1d1-3ae58319f5amr650497a91.57.1793153595507; Tue, 27
 Oct 2026 19:13:15 -0700 (PDT)
Date: Wed, 28 Oct 2026 02:13:15 +0000
In-Reply-To: <20261026003804.61923-3-imv4bel@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026003804.61923-1-imv4bel@gmail.com> <20261026003804.61923-3-imv4bel@gmail.com>
Message-ID: <auFUvRnF2uDgZix8@google.com>
Subject: Re: [PATCH net v4 2/2] inet: restore refcount ordering for lockless
 ehash walks
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@linux.dev, 
	john.fastabend@gmail.com, weiwan@google.com, sd@queasysnail.net, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, 26 Oct 2026 09:37:45 +0900, Hyunwoo Kim wrote:
> Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> of refcount_t"), default builds implemented refcount_inc_not_zero() using
> atomic_add_unless(), which provided full memory ordering on success. The
> commit removed that ordering on weakly ordered architectures, allowing
> validation after a successful reference acquisition in lockless ehash
> walks to be reordered before it.
> 
> Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established

Does bpf_sk_assign() need it too ?

If the socket is taken from lookup helper, it's safe, but what
happens if the pointer is taken from BTF (27e5203bd9c5), e.g.
tp->inet_conn.icsk_accept_queue.rskq_accept_head ?


> lookups and in inet_twsk_purge(), where the network namespace is validated
> again after taking a reference. Use refcount_set_release() when setting
> refcounts in the SYN cookie, TCP Fast Open, request migration, and
> TIME_WAIT paths. Keep the existing TIME_WAIT smp_wmb(), which separately
> orders the refcount store before ehash publication.
> 
> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 6 +++---
>  net/ipv4/inet_hashtables.c      | 2 +-
>  net/ipv4/inet_timewait_sock.c   | 4 ++--
>  net/ipv4/syncookies.c           | 2 +-
>  net/ipv4/tcp_fastopen.c         | 2 +-
>  net/ipv6/inet6_hashtables.c     | 2 +-
>  6 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index bd0bad96c93c3..837cb91e5b173 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1056,8 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *t)
>  		 * hold another count to prevent use-after-free and
>  		 * call reqsk_put() just before return.
>  		 */
> -		refcount_set(&nreq->rsk_refcnt, 2 + 1);
>  		timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> +		refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
>  		reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);
>  
>  		req = nreq;
> @@ -1441,7 +1441,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
>  				goto child_put;
>  			}
>  
> -			refcount_set(&nreq->rsk_refcnt, 1);
> +			refcount_set_release(&nreq->rsk_refcnt, 1);
>  			if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
>  				__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
>  				reqsk_migrate_reset(req);
> @@ -1494,7 +1494,7 @@ void inet_csk_listen_stop(struct sock *sk)
>  		if (nsk) {
>  			nreq = inet_reqsk_clone(req, nsk);
>  			if (nreq) {
> -				refcount_set(&nreq->rsk_refcnt, 1);
> +				refcount_set_release(&nreq->rsk_refcnt, 1);
>  
>  				rcu_read_lock();
>  				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 58d54965036a2..7ffa9171d6de1 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
>  		if (sk->sk_hash != hash)
>  			continue;
>  		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
> -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>  				goto out;
>  			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
>  				     !inet_match(net, sk, acookie, ports, dif,
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> index d4c781a0667fe..74ff40d42e56b 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -141,7 +141,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
>  	 * Also note that after this point, we lost our implicit reference
>  	 * so we are not allowed to use tw anymore.
>  	 */
> -	refcount_set(&tw->tw_refcnt, 3);
> +	refcount_set_release(&tw->tw_refcnt, 3);
>  
>  	/* Ensure tw_refcnt has been set before tw is published.
>  	 * smp_wmb() provides the necessary memory barrier to enforce this
> @@ -328,7 +328,7 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
>  			if (check_net(sock_net(sk)))
>  				continue;
>  
> -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>  				continue;
>  
>  			if (check_net(sock_net(sk))) {
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 6440305615378..4b2d2713653b7 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -205,7 +205,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
>  	child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
>  						 NULL, &own_req, NULL);
>  	if (child) {
> -		refcount_set(&req->rsk_refcnt, 1);
> +		refcount_set_release(&req->rsk_refcnt, 1);
>  		sock_rps_save_rxhash(child, skb);
>  
>  		if (rsk_drop_req(req)) {
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 471c78be55137..e40477b6b5549 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -364,7 +364,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
>  	tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
>  			     req->timeout, false);
>  
> -	refcount_set(&req->rsk_refcnt, 2);
> +	refcount_set_release(&req->rsk_refcnt, 2);
>  
>  	sk_mark_napi_id_set(child, skb);
>  
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index aa5fa1dd062f7..1eea584d80df8 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -105,7 +105,7 @@ struct sock *__inet6_lookup_established(const struct net *net,
>  			continue;
>  		if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
>  			continue;
> -		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +		if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>  			goto out;
>  
>  		if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> -- 
> 2.43.0
> 
