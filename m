Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221132;
	b=xADhCQPGmHPb4qUyhLCzEM67COD2SAOvIvEQmKX07cLIaSCvkQJ5lwUZxaVQpjaBX+As
	 zmRfQCkz+dAPx64B/lHVAiNFgp71YplWD3UHS1VYDw3QEhee8RpRAxO0Zaf1qOJyWqilt
	 0tS/mpCiAnHEu5EZmsBax00+dt5kFUr/p+A0ccGcLKfKf8lV5QEzJ+TZ0eIpbfAlNtyoE
	 l3gg3fjL5xsfvqUS/XnAcQNFTNRh7QXubNibHV9/BYI9g3sdEHW+bjZFWs3lalznm8EiH
	 vS0ok6WCU7jPFeGATAiUEHWFlx/cp+dCpXFV29BELMBzdk3zmODIxJYI/mU0l0H/KMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=EMvfX+w/imGbeoue0PMLqqC2Q+H4NEqIgtrLB+LMmtc=;
	b=xyGtzkB/V89PzNEzCrsORnXxehOajaTzVSJ7BoonyZKZHrv/4Evqzkz3gdR3/QCyX1rN
	 aWyG/FmuJ5tVowEZPYxi0Da7TRQJBfgmTqzlg8ELTPsUvxLtg6YtoS0hrzohyyXBkIcP5
	 E0hoMJfwrWY4x4nfMub094qGIFJ7dvzcB/oQLjuyb0jfVUAyJl3iFtUBwhBtXS7sl9k7C
	 KXZJZbcZEkLSEllr3Y2h7FY3lyFRS4WBFFGRlLdFDCyXRgsWF+f9vk5U7beTT0AOldH4q
	 Z/Dq6yopjX6VhqD6yqr4QTEpkjRZhRqGIFP0GeHkRzbLPFL2dUKXM2EFE+32wjxSS/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=irCKny6R;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E428C606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E428C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=irCKny6R
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a03834d8ffso1901035b3a.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793221131; x=1793825931; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EMvfX+w/imGbeoue0PMLqqC2Q+H4NEqIgtrLB+LMmtc=;
        b=irCKny6RSSpBYJiJlE0CN4zyNxU/pHyKH+Qk7JZqL+zDEl4n/TRua+NuZEGNQ4VjkY
         8Iwpw6gGG/qOa/AT2SmLQS1yOdrtHRSytuabu7733svZyDGKEw33lBs5OcxjvwiD5jfI
         Erel6sbloJpWvQICUZdo2g4U9pXcZVXOjXa16QEvg9XRDVvyCVy26A2KGveDP83vCF/r
         wlKJ9A3V4l9TgW/kCLCtPPNvu8qW/kFzjv45wTG07wA4QzSxcFeY0JJF3dt22kLlhLn8
         HSWy0G0CVi5CCOueusrhx5svOEjfFPzjy7Ljm1Vt5QZxCzq6d+Gv2tSh/8SyrY3QAWsV
         qzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793221131; x=1793825931;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EMvfX+w/imGbeoue0PMLqqC2Q+H4NEqIgtrLB+LMmtc=;
        b=jOBCQ7bUWKQJc0PS21O5QUxWrNJrhuUSVIsVefTOtIu1YUfwsrmlmPkH1pSwqUuQVE
         r7V21neUqqysytKsr7/P4qG1dQjnMpcjOUAVLVwmO85chKc4BWgIzjcB7B2lH7iRQ3hB
         RzmqT5SetSnIxPRPSd5NOq+PVP+vz8/2vBbslxfGFu452/dinGe+LUwR4RvnlJfmiQnG
         6zZ5B9SMi5LqThGI3hIpIqfWecN8t2+dAIPC6Wp1FGJ78lo2xYkjKu1UTkMkDNgsdQr5
         ovfw4gnkKIe1QT94HNyU6FyYYFX2bcBbVnGDaDQlaHhHE3j6vViPUjr2SxkefopeSVbC
         X5kA==
X-Forwarded-Encrypted: i=1; AKwUvBwrcwpJE2WJP5zdnqCpxviEup95arOk00I3zljtUo0Jm4tBt1A4Ueelx2tgU22z2EOm7DbJABA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLc8cvDihahN5JwmV+b8VF1+Y90lpi5cebzoW5FOFmHq8iCEUpx
	B45YVkI4HBvlDgbGoizoiyOWk96lSJN8br03Fvt0ow6jxHqyW+4vO6nCnA2YeN+rFrivqruD8lI
	vwYB+Ow==
X-Received: from pfux11.prod.google.com ([2002:a05:6a00:bcb:b0:891:240a:3bb3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:189e:b0:8a5:a8a2:95a0
 with SMTP id d2e1a72fcca58-8a6e8d7bc89mr3013096b3a.52.1793221130992; Wed, 28
 Oct 2026 13:58:50 -0700 (PDT)
Date: Wed, 28 Oct 2026 20:58:50 +0000
In-Reply-To: <auFsBkQInOabvUEd@v4bel>
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
 <auFUvRnF2uDgZix8@google.com> <auFsBkQInOabvUEd@v4bel>
Message-ID: <auJhzo-hCUxII1ce@google.com>
Subject: Re: [PATCH net v4 2/2] inet: restore refcount ordering for lockless
 ehash walks
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@linux.dev, 
	john.fastabend@gmail.com, weiwan@google.com, sd@queasysnail.net, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, 28 Oct 2026 12:29:10 +0900, Hyunwoo Kim wrote:
> On Wed, Oct 28, 2026 at 02:13:15AM +0000, Kuniyuki Iwashima wrote:
> > On Mon, 26 Oct 2026 09:37:45 +0900, Hyunwoo Kim wrote:
> > > Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> > > of refcount_t"), default builds implemented refcount_inc_not_zero() using
> > > atomic_add_unless(), which provided full memory ordering on success. The
> > > commit removed that ordering on weakly ordered architectures, allowing
> > > validation after a successful reference acquisition in lockless ehash
> > > walks to be reordered before it.
> > > 
> > > Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> > 
> > Does bpf_sk_assign() need it too ?
> > 
> > If the socket is taken from lookup helper, it's safe, but what
> > happens if the pointer is taken from BTF (27e5203bd9c5), e.g.
> > tp->inet_conn.icsk_accept_queue.rskq_accept_head ?
> 
> Yeah the same ordering issue remains when the pointer is obtained from 
> BTF without a reference. Fixes: 27e5203bd9c5.
> 
> However, I think this is better handled in a separate follow-up patch. 
> What do you think?

I think it can be just squashed given 27e5203bd9c5 exist
in the oldest LTS 5.10.


> 
> > 
> > 
> > > lookups and in inet_twsk_purge(), where the network namespace is validated
> > > again after taking a reference. Use refcount_set_release() when setting
> > > refcounts in the SYN cookie, TCP Fast Open, request migration, and
> > > TIME_WAIT paths. Keep the existing TIME_WAIT smp_wmb(), which separately
> > > orders the refcount store before ehash publication.
> > > 
> > > Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > ---
> > >  net/ipv4/inet_connection_sock.c | 6 +++---
> > >  net/ipv4/inet_hashtables.c      | 2 +-
> > >  net/ipv4/inet_timewait_sock.c   | 4 ++--
> > >  net/ipv4/syncookies.c           | 2 +-
> > >  net/ipv4/tcp_fastopen.c         | 2 +-
> > >  net/ipv6/inet6_hashtables.c     | 2 +-
> > >  6 files changed, 9 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > > index bd0bad96c93c3..837cb91e5b173 100644
> > > --- a/net/ipv4/inet_connection_sock.c
> > > +++ b/net/ipv4/inet_connection_sock.c
> > > @@ -1056,8 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *t)
> > >  		 * hold another count to prevent use-after-free and
> > >  		 * call reqsk_put() just before return.
> > >  		 */
> > > -		refcount_set(&nreq->rsk_refcnt, 2 + 1);
> > >  		timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> > > +		refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
> > >  		reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);
> > >  
> > >  		req = nreq;
> > > @@ -1441,7 +1441,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
> > >  				goto child_put;
> > >  			}
> > >  
> > > -			refcount_set(&nreq->rsk_refcnt, 1);
> > > +			refcount_set_release(&nreq->rsk_refcnt, 1);
> > >  			if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
> > >  				__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
> > >  				reqsk_migrate_reset(req);
> > > @@ -1494,7 +1494,7 @@ void inet_csk_listen_stop(struct sock *sk)
> > >  		if (nsk) {
> > >  			nreq = inet_reqsk_clone(req, nsk);
> > >  			if (nreq) {
> > > -				refcount_set(&nreq->rsk_refcnt, 1);
> > > +				refcount_set_release(&nreq->rsk_refcnt, 1);
> > >  
> > >  				rcu_read_lock();
> > >  				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
> > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > > index 58d54965036a2..7ffa9171d6de1 100644
> > > --- a/net/ipv4/inet_hashtables.c
> > > +++ b/net/ipv4/inet_hashtables.c
> > > @@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
> > >  		if (sk->sk_hash != hash)
> > >  			continue;
> > >  		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
> > > -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > > +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> > >  				goto out;
> > >  			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> > >  				     !inet_match(net, sk, acookie, ports, dif,
> > > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> > > index d4c781a0667fe..74ff40d42e56b 100644
> > > --- a/net/ipv4/inet_timewait_sock.c
> > > +++ b/net/ipv4/inet_timewait_sock.c
> > > @@ -141,7 +141,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> > >  	 * Also note that after this point, we lost our implicit reference
> > >  	 * so we are not allowed to use tw anymore.
> > >  	 */
> > > -	refcount_set(&tw->tw_refcnt, 3);
> > > +	refcount_set_release(&tw->tw_refcnt, 3);
> > >  
> > >  	/* Ensure tw_refcnt has been set before tw is published.
> > >  	 * smp_wmb() provides the necessary memory barrier to enforce this
> > > @@ -328,7 +328,7 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
> > >  			if (check_net(sock_net(sk)))
> > >  				continue;
> > >  
> > > -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > > +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> > >  				continue;
> > >  
> > >  			if (check_net(sock_net(sk))) {
> > > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > > index 6440305615378..4b2d2713653b7 100644
> > > --- a/net/ipv4/syncookies.c
> > > +++ b/net/ipv4/syncookies.c
> > > @@ -205,7 +205,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
> > >  	child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
> > >  						 NULL, &own_req, NULL);
> > >  	if (child) {
> > > -		refcount_set(&req->rsk_refcnt, 1);
> > > +		refcount_set_release(&req->rsk_refcnt, 1);
> > >  		sock_rps_save_rxhash(child, skb);
> > >  
> > >  		if (rsk_drop_req(req)) {
> > > diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> > > index 471c78be55137..e40477b6b5549 100644
> > > --- a/net/ipv4/tcp_fastopen.c
> > > +++ b/net/ipv4/tcp_fastopen.c
> > > @@ -364,7 +364,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
> > >  	tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
> > >  			     req->timeout, false);
> > >  
> > > -	refcount_set(&req->rsk_refcnt, 2);
> > > +	refcount_set_release(&req->rsk_refcnt, 2);
> > >  
> > >  	sk_mark_napi_id_set(child, skb);
> > >  
> > > diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> > > index aa5fa1dd062f7..1eea584d80df8 100644
> > > --- a/net/ipv6/inet6_hashtables.c
> > > +++ b/net/ipv6/inet6_hashtables.c
> > > @@ -105,7 +105,7 @@ struct sock *__inet6_lookup_established(const struct net *net,
> > >  			continue;
> > >  		if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
> > >  			continue;
> > > -		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > > +		if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> > >  			goto out;
> > >  
> > >  		if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> > > -- 
> > > 2.43.0
> > > 
