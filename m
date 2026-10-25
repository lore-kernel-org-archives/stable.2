Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972407;
	b=Uzqbt8YFC9n7N0NXAZwPD88arr+RacjBB4MoI60V7587eEOoYveeiyuBCwuI0oGz/T9x
	 zPOQWsdCJy+xeyubJAtksYCGRCKqKCHy05xcWKzwhYe0Nf4Vuoo4OjqRb4CxXu4Rrf543
	 6dKFOwF8Nw3ohyNKlCyXU5RsLnDAE1MeijhVvZhFIe4saG06PRUqhkY7Fgoczv85/8TB7
	 5klySAhZQD7zoS9ZtNeXxPgqW16S3SNhsJi+7Pr47DVXxp+E5R9kz2k0/kJ0iQfIJsccX
	 V/mKyiilOI/IungFjTz3z40/fhks8I44QdF552I4fHn2xjwnFVPjEmqLRyg9++mlA3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=aiCTcLVNNQHE4aAyTH5dme7V0R329uEB7Wip49f/PvA=;
	b=pfWPfWD4mM6ODKYDWSL4Ml+CF7LhM4w/+qn4L3M9n97mG3Oc0Uc1dzgWD2sodPiqI8O1
	 tppvPHZM21ORR/Wsqjy7NUP1xsud8uTRU/bFU5VIQBRisql8Jcn3FUAcjwSvGNBjEB9tC
	 y372LDHJpa/NCo/cvfDcYaOCC6Xa0OZi0pawZWxMNe/XrSWc+whyhjt+kpLpqnf5SE9BX
	 Rv4ta1CUKIiVOQKAbKccF21KLvY+ZrwDHlneoMI7gS3O9uNRi4WxpeIE6jS/VebxXpWnl
	 OWEILklkny5rKB48GskAnSL5XP0utx3xtKZi5RvniGZSuLo9Dnutw7aD1ehG4kfwUXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nWNw7IK+;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D799606A320
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 23:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D799606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nWNw7IK+
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4106600eec.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792972405; x=1793577205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aiCTcLVNNQHE4aAyTH5dme7V0R329uEB7Wip49f/PvA=;
        b=nWNw7IK+zikswfzU/M8lVz42nN7qO6hhm//Vjpapx8sERHe2mWiWDwjavwzWUm03Ya
         //iaXtCf7gpq10WItPr8G5O2A+utyPbz6HrjUGb+agQX+2glsRmkc5HLEuQy+OFrhVxG
         +YMQ8OuVHmkMhT5XZ8mVpySvDiHSQERRiCEn4nv9tkieE0nSvroGvCPqGaG4AodtyRoH
         9rO/KkpDOK9KhLTqrtFUCJ+wx/Cg7Nc2zXs6P2kuYHDUkDrMqWyXaeKgF1D+yB+kezqT
         mfWfYjFKGKIimOfuP6qnasIVAYOjyj3F87kXGBaUWpwMZinQxtiEYB2r5o29rbaqN54n
         pxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792972405; x=1793577205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aiCTcLVNNQHE4aAyTH5dme7V0R329uEB7Wip49f/PvA=;
        b=jJJUpdaVFVg7BPd4zUTTgNCD/CatpB7HdxXOr5q/Elt5HgiRpd/O6uNqTIdfSu2sQu
         ujMBMtux+Xst/qv/vpY+Z4MOEhUG+l04pq/58iWHvAVFwXRtzuveiVWbnGFC1tv8xphA
         ZhoBdK/gXQSSLON9l3azQxJOF+Q0chN1/+7YvWixB8oEdKgxIDWJz/BTmFlPipFiUE61
         xfVKp7FksOBxkDOTOVt4lVCUXo+Yt+s5afPovZ/ZWFV8ClwN40zeRDAQKW5yvR5wLtdf
         PgnVDHzt3eUNupMQkXKMjEN/qRqo3uF3mZVrerRpgq2cM3ArNA2SG6yQj3mrfKF3gsAT
         7sbA==
X-Forwarded-Encrypted: i=1; AKwUvByXUztXLAHdVsoDSuFULCt2Bi1tUuoLN743lDCQznhNq7S17eHE2mdw6GW5lZyO7/xkYkANN1A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDfXkhzAWecL642kKjUFIMMKTlWOYEq+5/ENLOBpvqJbnV+kEL
	h/a/3cOptCjD9aAZ+ED2w0kAyEutWGy0aY0tg4479Kh2jJ2Uqq/r4l4V
X-Gm-Gg: AYBFou1r0mpG200XNKhpm0veJzRkywa4lQLkw4WKF4vd9XsMcssIYf+b0plnMyD0gTZ
	6Mp9g9PEF3V7cRZSeBc8b9aXgvXJDU11Z8EyCGkIkq0oRm+H+2UGplf9A8ghhvZqW4K0rNQ572a
	K6DdU842DVmexk4v+ZCNsx9P18K+1FOGb0v1233oIWAjsSss7M7Orbx1sh5sqK+BO6LDqOGr2l3
	9FM+HhMgRYtbR4FZMqO5UcipXCFsk6S4tcZtPByQua6VqcAp/mfuDQhM2I/Tb7v5SfRryPLfdz7
	T9qVbk0qn5z/g2ElrW1zglQcAtI87NJMppX8MF9kUNMs4mU3A/odNoW0A2I+2cNZYEwDPijVefL
	jajLdXl1kdYiCkmnO3jzAvbxqICsS7uivmbCvZqwvcYvKGXPOWj6RbLb0HXrm6Y/svsIb+VMxaf
	ijniuMKnfLulv5KbWzOgbb9nyQBkddR18TgzP1Qeie5zWviH27OCHyKqLtGmcgoUBjxSjmlk+ad
	+ysCBk2H4F060Cr50gZfUTf/B927Nmuz8bZ5YPEQqfHsvNjdflWZJ4yM9WuLiT2ixlupsEMyPev
	F6UAqT+wmLKPoNOSVvpUrNe8Kkrd75uKMHbcUo8fiTbCMblx9dcDF7+UDBtva/f9SZLslQ==
X-Received: by 2002:a05:693c:88d0:20b0:358:f678:46b6 with SMTP id 5a478bee46e88-369e84aba20mr7713939eec.22.1792972404664;
        Sun, 25 Oct 2026 16:53:24 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daa3a8sm24732751eec.16.2026.10.25.16.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 16:53:24 -0700 (PDT)
Date: Mon, 26 Oct 2026 08:53:19 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: netdev-bot+sashiko@kernel.org, edumazet@kernel.org
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
	sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v3 2/2] inet: restore refcount ordering for
 established lookups
Message-ID: <at6Wb77B_ok5UiSr@v4bel>
References: <20261024053720.1147022-3-imv4bel@gmail.com>
 <179290682873.3134.10437749263853370498@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179290682873.3134.10437749263853370498@kernel.org>

On Sun, Oct 25, 2026 at 05:40:28AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 (1) · Low: 4
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] inet_twsk_purge() (net/ipv4/inet_timewait_sock.c) was left
>   unconverted, so the fix is incomplete.
> - [Low] The patch carries 'Cc: stable@vger.kernel.org' and 'Fixes:
>   fb041bb7c0a9' (v5.5), but the fix depends on…
> - [Low] Commit message accuracy.
> - [Low] Several converted sites do not follow refcount_set_release()'s
>   kernel-doc contract: 'This function should be called only after new…
> - [Low] In reqsk_timer_handler() the patch moves
>   timer_setup(&nreq->rsk_timer, ...) ahead of the refcount store, and…
> 
> Pre-existing issues:
> - [Medium] Same ordering bug in MPTCP token lookups.
> 
> --
> 
> inet: restore refcount ordering for established lookups
> 
> This patch makes the IPv4 and IPv6 established hash lookups use
> refcount_inc_not_zero_acquire(). It also converts refcount_set() to
> refcount_set_release() in the SYN cookie, TCP Fast Open, request
> migration and TIME_WAIT paths. The goal is to bring back ordering that
> was lost when fb041bb7c0a9 made refcount_inc_not_zero() relaxed on
> success.
> 
> > inet: restore refcount ordering for established lookups
> >
> > Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> > of refcount_t"), default builds implemented refcount_inc_not_zero() using
> > atomic_add_unless(), which provided full memory ordering on success. The
> > commit removed that ordering on weakly ordered architectures, allowing
> > validation in established lookups to be reordered before a successful
> > reference acquisition.
> >
> > Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> > lookups. Use refcount_set_release() when setting refcounts in the SYN
> > cookie, TCP Fast Open, request migration, and TIME_WAIT paths. Keep the
> > existing TIME_WAIT smp_wmb(), which separately orders the refcount store
> > before ehash publication.
> 
> [Severity: Low]
> Is "restore" accurate for the refcount_set_release() hunks?
> 
> fb041bb7c0a9 only changed the reader side. The !REFCOUNT_FULL
> refcount_inc_not_zero() went from atomic_add_unless() to a relaxed
> cmpxchg loop. refcount_set() was a plain atomic_set() both before and
> after that commit.
> 
> So the six conversions add writer-side ordering that never existed. They
> don't restore it. The six are in tcp_get_cookie_sock(),
> tcp_fastopen_create_child(), reqsk_timer_handler(),
> inet_csk_complete_hashdance(), inet_csk_listen_stop() and
> inet_twsk_hashdance_schedule().
> 
> The changes themselves look justified. A stale reader using acquire
> ordering has to see the pprev = NULL from sk_node_init() and the new tuple
> fields before the new refcount. Otherwise it could match an unhashed
> syncookie, TFO or migrated req.
> 
> Could the changelog explain this? It could also say how recycled request
> sock slab memory makes these unhashed reqs reachable at all.
> 
> sk_clone_lock() and sock_init_data() already have an smp_wmb() before
> their refcount_set(), so leaving those two alone looks right.
> 
> > Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> > Cc: stable@vger.kernel.org
> 
> [Severity: Low]
> refcount_inc_not_zero_acquire() and refcount_set_release() were added by
> 7f8ceea0c58039 ("refcount: provide ops for cases when object's memory can
> be reused"). That commit is in v6.15 and not in v6.14.
> 
> The Fixes: tag points to v5.5. Without that prerequisite, none of the
> touched files will build in the 5.10, 5.15, 6.1, 6.6 and 6.12 stable
> trees.
> 
> Should the stable tag carry a prerequisite annotation, for example:
> 
> Cc: stable@vger.kernel.org # needs 7f8ceea0c580 ("refcount: provide ops ...")
> 
> Or is a fallback planned for older trees?
> 
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index 01ecd98a2b501..8faef6c38b364 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1060,8 +1060,8 @@ static void reqsk_timer_handler(struct timer_list *t)
> >  		 * hold another count to prevent use-after-free and
> >  		 * call reqsk_put() just before return.
> >  		 */
> > -		refcount_set(&nreq->rsk_refcnt, 2 + 1);
> >  		timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> > +		refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
> 
> [Severity: Low]
> This isn't a bug, but timer_setup() now runs before the refcount store,
> and the changelog doesn't mention the move.
> 
> It follows from the refcount_set_release() kernel-doc, which wants
> initialisation done before the release. nreq is still private at this
> point. A short note in the commit message would be enough.
> 
> >  		reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);
> >  
> >  		req = nreq;
> 
> [ ... ]
> 
> > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> > index a1d86026aefb0..5c1bff5a6d4d8 100644
> > --- a/net/ipv4/inet_timewait_sock.c
> > +++ b/net/ipv4/inet_timewait_sock.c
> > @@ -143,7 +143,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> >  	 * Also note that after this point, we lost our implicit reference
> >  	 * so we are not allowed to use tw anymore.
> >  	 */
> > -	refcount_set(&tw->tw_refcnt, 3);
> > +	refcount_set_release(&tw->tw_refcnt, 3);
> 
> [Severity: High]
> Is the fix complete without also converting inet_twsk_purge() in this
> same file?
> 
> It walks the same ehash chains locklessly under rcu_read_lock(). It
> handles the same SLAB_TYPESAFE_BY_RCU TIME_WAIT and request socks, and it
> still uses the relaxed variant:
> 
> net/ipv4/inet_timewait_sock.c:inet_twsk_purge() {
>     ...
> 			if (check_net(sock_net(sk)))
> 				continue;
> 
> 			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> 				continue;
> 
> 			if (check_net(sock_net(sk))) {
> 				sock_gen_put(sk);
> 				goto restart;
> 			}
>     ...
> 				inet_csk_reqsk_queue_drop_and_put(req->rsk_listener,
> 								  req);
>     ...
> }
> 
> The release store added here only helps readers that pair it with an
> acquire. __refcount_add_not_zero() uses atomic_try_cmpxchg_relaxed(). On
> arm64 or POWER, the second check_net() and the later req->rsk_listener
> load can therefore be satisfied before the CAS.
> 
> Can this sequence happen?
> 
> CPU0, in tcp_sk_exit_batch()->tcp_twsk_purge()->inet_twsk_purge() for
> dying netns D:
>   sees socket X in D, and the first check_net() is false
> 
> CPU1:
>   X is freed
>   the slot is reused for a new TIME_WAIT or request sock in live netns L
>   the new sock is initialised, gets refcount_set_release(), and is hashed
> 
> CPU0:
>   refcount_inc_not_zero() succeeds on the new object
>   the reordered second check_net() still reads D
>   inet_twsk_deschedule_put() or inet_csk_reqsk_queue_drop_and_put() runs
> 
> That tears down a TIME_WAIT or pending request sock that belongs to the
> live netns L.
> 
> req->rsk_listener could also be read stale. It would then be the old
> occupant's listener, which may already be released, and
> inet_csk_reqsk_queue_drop() would update that listener's accept queue
> counters.
> 
> An unprivileged user can trigger netns exit through user namespaces. A
> remote peer can create TIME_WAIT and request socks in L.
> 
> Should inet_twsk_purge() use refcount_inc_not_zero_acquire() too?

I will include this change in v4.

> 
> [ ... ]
> 
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
> 
> [Severity: Low]
> The kernel-doc for refcount_set_release() says:
> 
>  * This function should be called only after new object is fully initialized.
>  * After this call the object should be considered visible to other tasks
> 
> Later in tcp_fastopen_create_child(), req is still written after the
> release store:
> 
> 	tcp_rsk(req)->rcv_nxt = tp->rcv_nxt;
> 
> The other converted sites have the same ordering:
> 
>   tcp_get_cookie_sock(), inet_csk_complete_hashdance() and
>   inet_csk_listen_stop() do the release before
>   inet_csk_reqsk_queue_add(), which writes req->sk and req->dl_next.
> 
>   reqsk_timer_handler() does the release before req->num_timeout++, the
>   accecn_fail_mode update and mod_timer() on nreq. nreq is then hashed
>   by inet_ehash_insert().
> 
> For the reqs that are never hashed, hlist_nulls_unhashed_lockless()
> rejects stale established lookups, because sk_node_init() runs before the
> release. So the practical exposure seems limited to minor fields such as
> num_timeout on the migrated nreq.
> 
> These stores had no ordering at all before this patch, so nothing
> regresses.
> 
> Could the release stores move after the last initialising write? If not,
> a comment could explain why the later writes are fine.
> 
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
> 
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch, but
> the MPTCP token lookups seem to have the same pattern.
> 
> mptcp_token_get_sock() in net/mptcp/token.c re-validates after a relaxed
> increment:
> 
> 	if (!refcount_inc_not_zero(&sk->sk_refcnt))
> 		goto not_found;
> 
> 	if (READ_ONCE(msk->token) != token ||
> 	    !net_eq(sock_net(sk), net)) {
> 
> mptcp_token_iter_next() does the same thing with its net_eq() check.
> 
> mptcp_prot sets SLAB_TYPESAFE_BY_RCU for msk objects. For that reason,
> mptcp_subflow_reqsk_clone() in net/mptcp/subflow.c already uses
> refcount_inc_not_zero_acquire().
> 
> On weakly ordered CPUs, can these lookups return a recycled msk from
> another connection or netns?
> 
> For MP_JOIN, the later HMAC check would fail and cause a spurious reset.
> Through the diag iterator, an msk from another netns could be dumped.
> 
> MPTCP was merged in v5.6, after fb041bb7c0a9. These sites never had the
> fully ordered behaviour, and they are outside what this patch covers.
> Would a separate fix for them make sense?

I had already identified the MPTCP issue. To simplify review and 
backporting, I will address it separately in a later patch rather than 
include it in this series.

> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261024053720.1147022-1-imv4bel%40gmail.com
