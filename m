Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158156;
	b=HQCS5ecCL1Nl0f0EOzgW5BAfpSN7hR9rY2okU9F7ZGrxz2sILGkIrhIBAU7CwpoF88pe
	 Yhpiaag9/+ic8RaThWwc+xuQDYXa6J3ubfCnXmmaGolEsOizJoV048dqEAh8hsnBI6iM1
	 jsa68GTlXsQqGVcnCF8XKqM8DiD7ikNpkyBRMomPPcqPyGqdyG+H10p2eolx9DsESWkAw
	 fsN89v8s2CgNhIIgAKZ/LD06H0b72ie6pHWAbYrXFWjeJGWkJNTEszJ1/OItlvtRVk+RL
	 PMDXOK7WuKZOOCaDLZJtkXRr+VFzwqz8w+alTXjsQ2L+JO+F1zlwyksd+PuklY4XGqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Kk+1t0b0DKZaul87Zv25lHrAh2UEd2PmUOMEfr4aozc=;
	b=sUCydDTKShfTz4dBEvsQuP6IxbksWtWCbgqgvHiJdxI0186TSkVSvAY5bRrhp+1wou6n
	 aa9U22B6Uv/0vN7KQXP1m5xwg0MEtQpTNCVDt9n8Kax9B3HfTlixw6fPg/jLfwTpGhiTq
	 vRIbnI5cUH9Vgt4YiVzeFpZfS+QHpwyQQvQF5ZpuUb53SrTMrMZUHEpe+s6sik+L9uBdV
	 VEBLkV5qr9ZTS0iA9K3jOOdIXr7yUs7PtBb9eTar/QMGul1NNAIeP72ERdy1UP63osQon
	 DdPgtaPGDFwvOr4WCu7bkt5EopPMSHlU6JxfTzfDlyYwV/lhI7aHIlT7G7Oadic+/8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmiW5xRr;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693B6606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 03:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 693B6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmiW5xRr
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e60f9af6e6so3775755ad.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 20:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158156; x=1793762956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kk+1t0b0DKZaul87Zv25lHrAh2UEd2PmUOMEfr4aozc=;
        b=MmiW5xRrJU9cQwWwzg4G+OihR8WEy/IgFwb12nmHXnySG+vB6UOOZtbjtAhzeFYhpx
         dKAyeLcY7ucK1JBCorSfRpjbZjjnSgbTX/DZs/wmvhh7wrEfa/fk6YVqfcPlM/rgzEAI
         X5dB2NsSENnufyMdoCDTVkKdVF4PsHdz4WA06lNVTM2pBBRXJiWk8+LXhCRHYPHwsQDF
         QxDdvLRQlXzb5KLwz6ZIOFQUkoLPju9usIxDdpWWrdQegQUdJqqU4+8YL+UajXf4U577
         2B409dXk63yiaTkLPa9oc3Nb+sab5zyudZRJrOLmd0+jmJkpoCz30rH+mmpEBG+LAwBL
         44/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158156; x=1793762956;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kk+1t0b0DKZaul87Zv25lHrAh2UEd2PmUOMEfr4aozc=;
        b=Ib9k1UiPYU2J5mHGINeH7eP2jC8bq4l3CB+/wgka1Sb2PM5NxTkKbBMDlB4Sh+hrcL
         Yydj/r2GEPsA0U+sWht2aM6qRC72q5bAp95fGG/h7qoTUl2CuM6bIl1fsw4E4wPGM0aS
         JG5p7rtQchdreCLxdLvcFtI2/0zYS+AZjC0PnQMzQcRN6xYfxp0kIiKurC01HUibUaVb
         fBFxKUbhg2YL+bL9knkn4FecSjCq2ytYqB1Z6f5lSY+XPPli8zx3PwcmscOkpG8hgy0L
         ZydzFmpJQSBR9Ha+/ekLfl1+1da2pM1Rm9El3vNhj/KxA97zXZaBLlb8VqL2o/d/tPpM
         Hr6A==
X-Forwarded-Encrypted: i=1; AKwUvByqa8sl/Z9C998nY7iiZ44EFuq+XHW730NVVWpUC8FLJ0ZikYh0EGg5Q2vn5c0W2z0q0Dd2GDY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLu1V1moXFMAbz3q/0Zelofjmns/93E/5oj19Hj/zBfAW0A14Id
	PRLT/LIvvTiSZXVOqtV6/ilZJyniSiul9WGWv6YDLPIXMKl8BTNlqgZ1
X-Gm-Gg: AYBFou22IwCMQ9bgMU7fcPbuHIZwXtemjQVB9AiGJsBGayido5EJxf2dBs+3da+AOg9
	95b8J7MhMmdX0/CIMEfE+aKKpmx/o18oQ8s9Y+g1S3jSGXPfoW2mrcLvQHsihQc6AhBUavdFgrs
	AP+gmmVDfGO7pLU3aKWSMWKyYzemK8vTYK8zZBBvne5n+RDLNjb60tGVVyLtCOdSKSPhcs07RXV
	OHKJHV/x6WdL2bsZ5aJgdGlfOQUy1BwdzPcrP/Et3ffZodR+vkVMMm2Tzcy82WIebQJMos15VQO
	T79SGdSC15XbMoE0YKC/C53U/XVBwDJa3ywGBS9xtBgwuuOOKDbo9oElHOLPORqEk0LIgiRSfm0
	L/hSIuzALYamCoAv1MxLlwpSDTj95EPXIkaXW4HEtT62MmNT+TVVpc+TOX416rwdeXl7h13tJbX
	EwQ1lBJf0kvLl3fQyXZ6oHBcT3tBbfYqK94FZCLWQ9NQ7hkGbsNzdfeb+f+RkdrdwlKUaty/VAo
	YezXt+hmvkosEZ2L3xkTUPCZeYBcd7qaQqcjn0OKwzGMnocsCecshojoCZdHaDiz2fXBB2R3EZq
	2A5n0UM/DtemXOwCBWEDNI/9qj9b+1mcblIEYKpWtAb1xG6H
X-Received: by 2002:a17:90b:510f:b0:3ad:eb34:4c6c with SMTP id 98e67ed59e1d1-3ae57f629camr769035a91.13.1793158155725;
        Tue, 27 Oct 2026 20:29:15 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a48d7basm869780a91.3.2026.10.27.20.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 20:29:15 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:29:10 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
	sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v4 2/2] inet: restore refcount ordering for lockless
 ehash walks
Message-ID: <auFsBkQInOabvUEd@v4bel>
References: <20261026003804.61923-1-imv4bel@gmail.com>
 <20261026003804.61923-3-imv4bel@gmail.com>
 <auFUvRnF2uDgZix8@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auFUvRnF2uDgZix8@google.com>

On Wed, Oct 28, 2026 at 02:13:15AM +0000, Kuniyuki Iwashima wrote:
> On Mon, 26 Oct 2026 09:37:45 +0900, Hyunwoo Kim wrote:
> > Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> > of refcount_t"), default builds implemented refcount_inc_not_zero() using
> > atomic_add_unless(), which provided full memory ordering on success. The
> > commit removed that ordering on weakly ordered architectures, allowing
> > validation after a successful reference acquisition in lockless ehash
> > walks to be reordered before it.
> > 
> > Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> 
> Does bpf_sk_assign() need it too ?
> 
> If the socket is taken from lookup helper, it's safe, but what
> happens if the pointer is taken from BTF (27e5203bd9c5), e.g.
> tp->inet_conn.icsk_accept_queue.rskq_accept_head ?

Yeah the same ordering issue remains when the pointer is obtained from 
BTF without a reference. Fixes: 27e5203bd9c5.

However, I think this is better handled in a separate follow-up patch. 
What do you think?

> 
> 
> > lookups and in inet_twsk_purge(), where the network namespace is validated
> > again after taking a reference. Use refcount_set_release() when setting
> > refcounts in the SYN cookie, TCP Fast Open, request migration, and
> > TIME_WAIT paths. Keep the existing TIME_WAIT smp_wmb(), which separately
> > orders the refcount store before ehash publication.
> > 
> > Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 6 +++---
> >  net/ipv4/inet_hashtables.c      | 2 +-
> >  net/ipv4/inet_timewait_sock.c   | 4 ++--
> >  net/ipv4/syncookies.c           | 2 +-
> >  net/ipv4/tcp_fastopen.c         | 2 +-
> >  net/ipv6/inet6_hashtables.c     | 2 +-
> >  6 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index bd0bad96c93c3..837cb91e5b173 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1056,8 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *t)
> >  		 * hold another count to prevent use-after-free and
> >  		 * call reqsk_put() just before return.
> >  		 */
> > -		refcount_set(&nreq->rsk_refcnt, 2 + 1);
> >  		timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> > +		refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
> >  		reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);
> >  
> >  		req = nreq;
> > @@ -1441,7 +1441,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
> >  				goto child_put;
> >  			}
> >  
> > -			refcount_set(&nreq->rsk_refcnt, 1);
> > +			refcount_set_release(&nreq->rsk_refcnt, 1);
> >  			if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
> >  				__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
> >  				reqsk_migrate_reset(req);
> > @@ -1494,7 +1494,7 @@ void inet_csk_listen_stop(struct sock *sk)
> >  		if (nsk) {
> >  			nreq = inet_reqsk_clone(req, nsk);
> >  			if (nreq) {
> > -				refcount_set(&nreq->rsk_refcnt, 1);
> > +				refcount_set_release(&nreq->rsk_refcnt, 1);
> >  
> >  				rcu_read_lock();
> >  				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index 58d54965036a2..7ffa9171d6de1 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
> >  		if (sk->sk_hash != hash)
> >  			continue;
> >  		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
> > -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >  				goto out;
> >  			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> >  				     !inet_match(net, sk, acookie, ports, dif,
> > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> > index d4c781a0667fe..74ff40d42e56b 100644
> > --- a/net/ipv4/inet_timewait_sock.c
> > +++ b/net/ipv4/inet_timewait_sock.c
> > @@ -141,7 +141,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> >  	 * Also note that after this point, we lost our implicit reference
> >  	 * so we are not allowed to use tw anymore.
> >  	 */
> > -	refcount_set(&tw->tw_refcnt, 3);
> > +	refcount_set_release(&tw->tw_refcnt, 3);
> >  
> >  	/* Ensure tw_refcnt has been set before tw is published.
> >  	 * smp_wmb() provides the necessary memory barrier to enforce this
> > @@ -328,7 +328,7 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
> >  			if (check_net(sock_net(sk)))
> >  				continue;
> >  
> > -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >  				continue;
> >  
> >  			if (check_net(sock_net(sk))) {
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 6440305615378..4b2d2713653b7 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -205,7 +205,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
> >  	child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
> >  						 NULL, &own_req, NULL);
> >  	if (child) {
> > -		refcount_set(&req->rsk_refcnt, 1);
> > +		refcount_set_release(&req->rsk_refcnt, 1);
> >  		sock_rps_save_rxhash(child, skb);
> >  
> >  		if (rsk_drop_req(req)) {
> > diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> > index 471c78be55137..e40477b6b5549 100644
> > --- a/net/ipv4/tcp_fastopen.c
> > +++ b/net/ipv4/tcp_fastopen.c
> > @@ -364,7 +364,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
> >  	tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
> >  			     req->timeout, false);
> >  
> > -	refcount_set(&req->rsk_refcnt, 2);
> > +	refcount_set_release(&req->rsk_refcnt, 2);
> >  
> >  	sk_mark_napi_id_set(child, skb);
> >  
> > diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> > index aa5fa1dd062f7..1eea584d80df8 100644
> > --- a/net/ipv6/inet6_hashtables.c
> > +++ b/net/ipv6/inet6_hashtables.c
> > @@ -105,7 +105,7 @@ struct sock *__inet6_lookup_established(const struct net *net,
> >  			continue;
> >  		if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
> >  			continue;
> > -		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +		if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >  			goto out;
> >  
> >  		if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> > -- 
> > 2.43.0
> > 
