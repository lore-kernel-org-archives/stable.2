Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778869;
	b=ykx+wUwznBJoeIF9bLbAdgObr2JJKwn0r7B+EVsjpfrXHrtH+pL4w/e95dHFl+QWLzLB
	 Ai3o6M4tmsmkS2bxxN0lb/YAPMtfkwII//KKAIwF1Wf3yuMq9vcxrXlEB4UXKXFttLPk5
	 gWpsaM/ZmKAaRmpekPAE0lUDVD3Pcy87YvQpfWq1g17xc25FY8rdr5XsZDL3IQmCK7Csi
	 TOoE7xk6cynEtgZs0mDAwrfoUycAm4oh19X+f1d7V2BuAZmFdSF2InlWvHEP24zXPYNGf
	 DDhvFRCT2Avhw85U5SvPxjpvsryKxkkcCfa9zvaJh8ZO+WgFrBsLHnVnuTunHS/pVmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=l8yh+J8SSNLKfskLT/Z2Pcy1PDMooIjufZ+RCRIv0iE=;
	b=dm9DIh75oBwf50YdIEx0DfFV3ex2KileInPq/L+oMdK6f2AWaVmwKcaQRFfJDc9PvD6Z
	 ZT/g1KgXFzP9qq1ItkxnwtR79qRZx0UQN4gFklvcvxTEAVOE65WWZ/3+gYQK9y1vXLmJm
	 r7v0fmvgVsR6E8DS2nz85TTLoxpB0XFPcelfzTgvJR6P9P4cTuc2+YFr2245r00SYViON
	 Ny1GQroiFbxZFWEhvOaKAVtNqhVAAP9ej8YX9zUX5Xc1aw1cH4mE+VwOpfSonPnKryc4I
	 fsEO/CUe6lVNZdOLKVaSqLJV7Fm80lYKnm1VPSH2onmyDAAFctiNDb3iH0CgxERxGvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lPZbBEpC;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D6606A329
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 352D6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lPZbBEpC
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35c76e9614aso1816198eec.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778868; x=1793383668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l8yh+J8SSNLKfskLT/Z2Pcy1PDMooIjufZ+RCRIv0iE=;
        b=lPZbBEpCXSmjLCMTay3uooK8s96fbEKE6OAo9MCbUAhyVEINNWSYI0RLkJVWmU9nik
         1iMw7TCEUWr4SCYV4G9ChwQ6ZdbldyjTZl4bHsRj6HyvzcATfQP8jjAOwSDDExSxp2SD
         gbZXjVrmvVfgW2IiMs8qO0/J7gr9IghG0ZhGa/7wu7VtEiAHytKBy37Pa7JeuNfZQuT2
         nspyqCmib51TtqozDzKUPqRfnU26iqToUARxHY28kejr6NkAOhAne+t87oeGd2ALsLkx
         HWi+18h3pknGEaKOTDL6GLRCFMGx4qbv0AcbB3TBJXRSutA2jiIlgQCt6YdZCG49ELAO
         BXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778868; x=1793383668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l8yh+J8SSNLKfskLT/Z2Pcy1PDMooIjufZ+RCRIv0iE=;
        b=xIraxveH5hr2OxRTcjLhqk0AxpjgV8l9ItVw/j/YE2Kd7eIWcsmDEM46LxZaogKbPh
         /JBytK54XsSPjQL6/dnD1JXIKI3VU7HWtf+QX+NgqJ43f3/oIgd+WfH7JD/Z01ZjTVgq
         TgT4qJ8N0W89GS/UwnSn77B9q7MC8ax1rVEbDbwWd9jsYa7HN83foFP7sm4xqy3ZfpID
         TqpTC5ZCEK5k0KRpB3dSgRg3eOvpde6kpMXMNGousjjn/2mZdB3aLv0K9r1lQkm9bo+n
         TzcVhzG+Jx0wzqpI16AzI/DSbLtnXfcs8hbyhrcoHusVuLEEcKnMCZ3U5d76RSXEyKC/
         pDPg==
X-Forwarded-Encrypted: i=1; AKwUvByZILhlZmWE2qZxL7RUT0xCwf0KARQQRKijRMORKiS1L1kyF3LNL4q9GpUxMXmR1v6uzSeIt14=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxtcOWjissbMFGrvw0bBPqZ3r8G7LW2Clb6S1zfISff6ENoX7q
	tO0JMpTUhcdFkvNEvdn3pBbVrTh3Fqf0o2sWD+e2bZU3PjKYnukwYcVYe7nj0A==
X-Gm-Gg: AYBFou06zF2V/N4oBueEsiadygp9wzo/gvg5p8BaK7qzCChHoD3VnV99ZVorkSKXgIs
	l0/VyGrpa7fsYrkqBatF9NhgiDRMaQ3uRp3lSSMx8NGH11AxfnQZiZ8wYr6MOte6aBMnMYlqJ/0
	/wf14pV+8fJzLnZ8t1CDmsqITDtrz8oqHY0U/3tZU8BfTXHiRzebSJZtcItQiKGKWn0IUIqxEUq
	76ghS5z/FqKyUf+ePOOOdZzCp4O41TjXFn8D6VMD2RTmRet2ic9N+nPecOdy1oSj5R4sow5mbna
	mmc4HO9BxiRyb7xmC3/5V7FshCNZWY45ostvM+Q1c+gRLVjGyt/wODdex/7/VWpWiXzwoCz2D3R
	+AuMx2iZZkFHI0XB04FU1CHMBZDQFu9Fxxcbyznsf9ecRmMoytOX+xz8LrXS4xvFnWgFjbnPKF3
	Ok+eE+YQEySynYTMZLXnCphvTsH46jvMEG2JhFDoDQXve/3hA7TUHnEcGNjs680Zz9cV4fkVS3a
	nOFdpnoFPhtiAMDCQjr4yw9fwAdT0Tm1U2JdX0JOrFwm4gLpD/Ee0r/aF8f7XQje+Bixnt3JbY=
X-Received: by 2002:a05:7022:3b85:b0:187:efba:9ba2 with SMTP id a92af1059eb24-195c6f00fa6mr4476139c88.44.1792778868167;
        Fri, 23 Oct 2026 11:07:48 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm612623c88.17.2026.10.23.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:07:47 -0700 (PDT)
Date: Sat, 24 Oct 2026 03:07:42 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
	sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v2 2/2] inet: restore refcount ordering for
 established lookups
Message-ID: <atuibj7fzdSpOHN9@v4bel>
References: <20261023052542.3505250-1-imv4bel@gmail.com>
 <20261023052542.3505250-3-imv4bel@gmail.com>
 <CAL4WiipDcvmNMeeC1znRmtykFg1uwb5XOZVOoi9y0dVECXtHVw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4WiipDcvmNMeeC1znRmtykFg1uwb5XOZVOoi9y0dVECXtHVw@mail.gmail.com>

On Fri, Oct 23, 2026 at 06:33:53PM +0200, Eric Dumazet wrote:
> Le ven. 23 oct. 2026 à 07:26, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
> >
> > When commit 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use
> > RCU / hlist_nulls") was written, atomic_inc_not_zero() provided full
> > memory ordering. Even after commit 41c6d650f653 ("net: convert
> > sock.sk_refcnt from atomic_t to refcount_t"), default builds used
> > atomic_add_unless() and retained that ordering.
> >
> > Commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> > of refcount_t") consolidated the refcount_t implementations in v5.5.
> > On weakly ordered architectures, this removed the ordering required
> > by validation after a successful reference acquisition.
> >
> > Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> > lookups. Use refcount_set_release() when setting initial refcounts in
> > sk_clone(), SYN cookie, and request migration paths. In the TCP Fast
> > Open path, move the refcount update after the required initialization
> > and use release ordering.
> >
> > The TIME_WAIT path already has an smp_wmb() between refcount_set() and
> > hash publication, so leave it unchanged.
> 
> This is not accurate. The smp_wmb() in inet_twsk_hashdance_schedule()
> orders the tw_refcnt store against the ehash publication, not the tw
> identity stores done in inet_twsk_alloc() against the tw_refcnt store.
> 
> The latter is what a lookup holding a stale pointer needs. Today we get it
> more or less by accident from the bhash spin_unlock() followed by
> spin_lock() of the ehash lock.
> 
> Please either reword this paragraph, or simply use
> refcount_set_release(&tw->tw_refcnt, 3) there; it is free under the lock
> and makes the pairing explicit.

OK, I'll switch to refcount_set_release().

> 
> 
> >
> > Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> 
> refcount_inc_not_zero_acquire() and refcount_set_release() were only
> added in 7f8ceea0c580 ("refcount: provide ops for cases when object's
> memory can be reused"), in v6.15.
> 
> 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/core/sock.c                 | 3 +--
> >  net/ipv4/inet_connection_sock.c | 6 +++---
> >  net/ipv4/inet_hashtables.c      | 2 +-
> >  net/ipv4/syncookies.c           | 2 +-
> >  net/ipv4/tcp_fastopen.c         | 3 +--
> >  net/ipv6/inet6_hashtables.c     | 2 +-
> >  6 files changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 3c25d66ba31a..f3ef9601ab73 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2622,8 +2622,7 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
> >         /* Before updating sk_refcnt, we must commit prior changes to memory
> >          * (Documentation/RCU/rculist_nulls.rst for details)
> >          */
> > -       smp_wmb();
> > -       refcount_set(&newsk->sk_refcnt, 2);
> > +       refcount_set_release(&newsk->sk_refcnt, 2);
> 
> This part is not a fix: the writer side only needs store->store ordering,
> which smp_wmb() already provides.
> 
> I do not mind the conversion, but then reqsk_queue_hash_req() (which has
> the same smp_wmb() + refcount_set() pattern) should be converted as well
> for consistency. Otherwise please drop this hunk to keep the stable
> backport minimal.
> 
> 
> >
> >         sk_set_socket(newsk, NULL);
> >         sk_tx_queue_clear(newsk);
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index cff02f4c5ac8..2d8e54d3a31b 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1056,8 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *t)
> >                  * hold another count to prevent use-after-free and
> >                  * call reqsk_put() just before return.
> >                  */
> > -               refcount_set(&nreq->rsk_refcnt, 2 + 1);
> >                 timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> > +               refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
> >                 reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);
> >
> >                 req = nreq;
> > @@ -1441,7 +1441,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
> >                                 goto child_put;
> >                         }
> >
> > -                       refcount_set(&nreq->rsk_refcnt, 1);
> > +                       refcount_set_release(&nreq->rsk_refcnt, 1);
> >                         if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
> >                                 __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
> >                                 reqsk_migrate_reset(req);
> > @@ -1494,7 +1494,7 @@ void inet_csk_listen_stop(struct sock *sk)
> >                 if (nsk) {
> >                         nreq = inet_reqsk_clone(req, nsk);
> >                         if (nreq) {
> > -                               refcount_set(&nreq->rsk_refcnt, 1);
> > +                               refcount_set_release(&nreq->rsk_refcnt, 1);
> >
> >                                 rcu_read_lock();
> >                                 if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index 58d54965036a..7ffa9171d6de 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
> >                 if (sk->sk_hash != hash)
> >                         continue;
> >                 if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
> > -                       if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +                       if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >                                 goto out;
> >                         if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> >                                      !inet_match(net, sk, acookie, ports, dif,
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 644030561537..4b2d2713653b 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -205,7 +205,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
> >         child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
> >                                                  NULL, &own_req, NULL);
> >         if (child) {
> > -               refcount_set(&req->rsk_refcnt, 1);
> > +               refcount_set_release(&req->rsk_refcnt, 1);
> >                 sock_rps_save_rxhash(child, skb);
> >
> >                 if (rsk_drop_req(req)) {
> > diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> > index 471c78be5513..2506f415f410 100644
> > --- a/net/ipv4/tcp_fastopen.c
> > +++ b/net/ipv4/tcp_fastopen.c
> > @@ -364,8 +364,6 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
> >         tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
> >                              req->timeout, false);
> >
> > -       refcount_set(&req->rsk_refcnt, 2);
> > -
> >         sk_mark_napi_id_set(child, skb);
> >
> >         /* Now finish processing the fastopen child socket. */
> > @@ -378,6 +376,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
> >         tcp_rsk(req)->rcv_nxt = tp->rcv_nxt;
> >         tp->rcv_wup = tp->rcv_nxt;
> >         tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
> > +       refcount_set_release(&req->rsk_refcnt, 2);
> >         /* tcp_conn_request() is sending the SYNACK,
> 
> Moving this is harmless, but not needed. The lookup never looks at
> rcv_nxt, and this req is never hashed, so after patch 1/2 a stale lookup
> will reject it anyway. A plain conversion in place would be enough.
> 
> Let's keep code churn minimal, to lower risk of merge conflicts.

I'll submit v3 with all unnecessary changes removed. Thanks for the review.


Best regards,
Hyunwoo Kim
