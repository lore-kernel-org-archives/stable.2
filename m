Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D483F4DD3
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745079; cv=pass; b=Qw8doz79auYquTp2bvgLKzRZ9XkmqVlAzaC7hkf4dL2fFt8BMBVoaMsYAjxxWXqEIXJgGeCH95fxlPgdkS+sWtZDdZxrn3Xi3THk4JoXNYy8V1o1ldNS+qAt0a/FYvjmoR8q1JCNS2Ru/BQplgnBpwb0u4iRXi9LPskRp8lQTH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745079; c=relaxed/simple;
	bh=DxpvpATH0oXgY3OB1+W1d1OE1znwY0Dmebkb/FONmNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPPkvVkJsBBTMpPXrAAmZDoYSZo/hYsdv/M0OF/H2GCT62I8u38yApt/XIkQlrId8EJNycuUrXuVwjI6qm/8gCHRP54z0q22lcX1IlLenTdkcltPtI9breGuafGt/nk1rF9Mxha1FgbfQN0NZCaBcSRxiuR+nYw43yupNMyUCX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=QnLQRt9K; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="QnLQRt9K"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a0faa764beso6205421fa.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 04:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787745071; cv=none;
        d=google.com; s=arc-20260327;
        b=kqh9C1VCgIHoKXpwFUdJIGnVWRLfbuLti0wQ/VDg+AFMbQYnIJ3bIM6LiyRxbM7YK2
         61zHCvDBkLPcWaiTI3ZbVcg73PLaIQohZMhmYNZx7ClpqpVgqjEiWqhA2bYdjtwkykRv
         fvF0KlcMTrOs1YmeBH1K2cTFc5FT5CAawThnUV/4X5WsYo2tKHzgF4/XS3dEal/Q1gy0
         rOt9dELbTKH2XxXG7KvWQnNmaqKr7uAXTjjKdE9JRtlypFJSpihaM0omdQSx5ZxsKePN
         dN5O0d6Qzkm7AY1DSI3kRutll7ZrJRGE48HIo7aRY41pRf6C3Ijze5CH05uj61LOKTjv
         S6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sb//kfcMxDR/KrZuw0yoV/PLJtDrbRO8+A8VLdk2OtE=;
        fh=aYbu/DhKZz5aYi6RaXJNSTGcvMvWkrpecSexpHqAm3o=;
        b=hQ0hmYjWZEGVLX+vn0YPlLGcikawn9AakuiAsdMPuRy7MU9GykJJhCnWfLEvTRc16B
         6KiE3dL6dRp+nV1NHg3a7+MBrKcey1YE69rNqRDIU8O/m6fLuiHAyb0vzZGVG7b5zCkB
         qcdhMaXvwLEU2KGKcvdVvS1iclRX9pW21NTpDVVAtryEcihu65AXxspqSrh8kJlG6mti
         V5zJYRwNPNf4nuzat273yOAgCDrFZSO6qCvsd8vQH4LI/JlPcg688Mc2VMgQFlYekCJJ
         2wqcKEYjDiUKYVWRMN0s+VvwYnERBwYNgeCKXVRDJUx1zrjelqkQix+jTrp7s48HzE1l
         DprA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787745071; x=1788349871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sb//kfcMxDR/KrZuw0yoV/PLJtDrbRO8+A8VLdk2OtE=;
        b=QnLQRt9KLcRtMwXuLYITE8l7X7aN3uPV2wFDdv7gxME39fw2T7Bc/h9FwuEn281Xar
         VoGd9Bi7P7JnvV+BajDcDZ36vgyX89SSgVUwmWAP4nSAJbvDY6ifoUfMrL4uwdfyLQNB
         ZGnQaSdXqseCFO9NrlyuQIxQjmFjnnjQb1cgt2PpshwGfpJeVslx3gpEucu0A+6+l9tB
         coehrMzYDGRa3cr0Eel840k4/68jm/2rWdSixyXWxtqOUL03FU6OzPMwf87fjxM0oa6v
         X+egzv1ZsQKq8m41L7c7Ssme+Lq4mWKJGbcYd5YS3M76xh1KTOTGVx89rSKFEt5f6zJC
         R5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745071; x=1788349871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sb//kfcMxDR/KrZuw0yoV/PLJtDrbRO8+A8VLdk2OtE=;
        b=k//LrhrxvAw6H0VUdcMexZakb/7tFTiqC2NRNrEcJ9xzNoeZi5GfjeFPrjE3aTzvKT
         zXLGNKepCyDXFd1mmrA6ctxk1sdHtfkCqrb27blvsJj4Kl76Ap72nuyn8dca6yIJmnSp
         UpgNHmrsDQTq1rOgwhMs/q09ufEZvqQdPnZg3wgjslmhiPJbovTnL4YWSkxQ9oeLkg++
         tDrfmqbSEqZ/xcbKIVLgNQIts3XbNkLSfRRKknSD7cEOxWP0B9L0ruWRHo3W9xfo+T+v
         try3BRIScTKVonN16LKLtn5Ac7aMkXhdOBg2bk567NnGf4kHX935lnJ9WlNn0J4zZOmq
         /VjA==
X-Forwarded-Encrypted: i=1; AHgh+RpkY5f0JvpCeKl2A77y8FKpJqfxESfhZk23hrYBMjMwd2FaTLmQpngx3DCqregNm5e8PpGGebM=@vger.kernel.org
X-Gm-Message-State: AFuF++k5KNIvSntp41UEQx3TJzKrLPBnfBI6nmOvg1dc89+QmGTV6Cjl
	yA9xnVgv5tDpbjF89lmVm2jd+ZMu+B0QwFZ7azlWEk7LJGpCkN0TlJsFBgKwkOMnXNzI76dbPNd
	v4rxz/qQ0DTqjVri5UNtoRJX6hfsYTWp9UUrxRIuXyes=
X-Gm-Gg: AR+sD11OfDn6DEqUlL7xxNPGpBtlc6a2JnmxF2WrNiWFPNS7zo9dnSQHPfcD4LONJfA
	W9XZJVqeEdb9ULV3dfpuwQg9PJXVu+IITavKW5WloPsBdtnujhteVpVDQF/SgKJ0wKbQS2A0EnI
	kQM3Urkk9Cpn/d4ypdFxBg57Qn73IpEzgYr+SlPGTf3T/phmf5HSXmdtI/LmcwyPIyh0bl3Q+B2
	cmV/YvS9gSdtkeD2B2apBqNTI1muuc1RzC8F8sPG3+Kic7FgmtcWjwlOGyVqMZffk23TIGjJluD
	zT+vbhqkshBS0gnspJCn3+pZbc6t0dJycU5k0E/1n6tX7svkd/Q5Uucn7qTjnlTKFMDN28f/MHc
	x
X-Received: by 2002:a05:651c:b22:b0:39f:fc5b:5183 with SMTP id
 38308e7fff4ca-3a1fd46657amr13193191fa.3.1787745070995; Wed, 26 Aug 2026
 04:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822082354.3109-2-zihanx@nebusec.ai> <20260826083441.307129-1-horms@kernel.org>
In-Reply-To: <20260826083441.307129-1-horms@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 26 Aug 2026 19:50:59 +0800
X-Gm-Features: AcwNN1V8GMdtSUJdfLX4wZ23gSyLgIeYZwdSexsJ8bGsHjVlOviAWaJGwWN1k6M
Message-ID: <CAANe3eRjAcr4-VnAbCdDGxuOuyesdQhJPfJZvjQsdBUO8WdWaA@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] llc: fix listener child socket leaks before
 passive open completes
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:34=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260=
822082354.3109-2-zihanx@nebusec.ai?part=3D1
> ---
> llc: fix listener child socket leaks before passive open completes
>
> This restricts passive-open child creation to SABME commands, answers oth=
er
> listener-directed commands with a directly generated DM response, and add=
s
> an incoming_state lifecycle (PENDING/QUEUED/NONE) so that children which
> never reach accept() are unhashed and torn down from a work item.
>
> > diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> > index b0447c33dbf0..7d246d4d281b 100644
> > --- a/net/llc/af_llc.c
> > +++ b/net/llc/af_llc.c
>
> [ ... ]
>
> > @@ -722,6 +728,7 @@ static int llc_ui_accept(struct socket *sock, struc=
t socket *newsock,
> >               goto frees;
> >       rc =3D 0;
> >       newsk =3D skb->sk;
> > +     llc_accept_incoming_sock(newsk);
> >       /* attach connection to a new socket. */
> >       llc_ui_sk_init(newsock, newsk);
> >       sock_reset_flag(newsk, SOCK_ZAPPED);
>
> [Severity: High]
>
> llc_accept_incoming_sock() performs the QUEUED to LLC_INCOMING_NONE
> transition, and the paired sock_put(llc->incoming_listener), with only th=
e
> listener's owner lock held (the lock_sock(sk) at the top of
> llc_ui_accept()).
>
> Every other transition site holds the child's slock instead:
> bh_lock_sock()/bh_lock_sock_nested(newsk) in llc_conn_handler(),
> local_bh_disable() plus bh_lock_sock_nested(newsk) in llc_backlog_rcv(),
> and bh_lock_sock_nested(newsk) in llc_release_incoming_children().
>
> Since those two lock sets are disjoint, can a softirq-side release win th=
e
> atomic_xchg while accept() sits between skb_dequeue() and the graft?
>
> CPU0 (softirq) llc_conn_handler() or llc_backlog_rcv()
>         bh_lock_sock_nested(newsk);
>         llc_release_incoming_sock(newsk);  /* xchg -> NONE, work queued *=
/
>
> CPU1 (process) llc_ui_accept()
>         newsk =3D skb->sk;
>         llc_accept_incoming_sock(newsk);   /* xchg returns NONE, no fixup=
 */
>         llc_ui_sk_init(newsock, newsk);
>         newsk->sk_state         =3D TCP_ESTABLISHED;
>
> llc_accept_incoming_sock() returns void, so llc_ui_accept() has no way to
> notice that it lost the transition, and it takes no reference on newsk an=
d
> never holds the child's lock.
>
> llc_incoming_sock_work() only waits on lock_sock(listener), which accept(=
)
> drops on return, so the final sock_put() pair can land immediately after
> newsock->sk has been published to userspace.
>
> Would it work for llc_accept_incoming_sock() to return whether it won the
> transition, taken under the child's lock, so accept() can fail instead of
> grafting a socket whose teardown is already scheduled?
>
> > diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> > index 260460d50f54..8120ecd46ace 100644
> > --- a/net/llc/llc_conn.c
> > +++ b/net/llc/llc_conn.c
>
> [ ... ]
>
> > @@ -88,6 +89,11 @@ int llc_conn_state_process(struct sock *sk, struct s=
k_buff *skb)
> >                * skb->sk pointing to the newly created struct sock in
> >                * llc_conn_handler. -acme
> >                */
> > +             if (sk !=3D skb->sk &&
> > +                 atomic_read(&llc_sk(skb->sk)->incoming_state) =3D=3D
> > +                 LLC_INCOMING_PENDING)
> > +                     atomic_set(&llc_sk(skb->sk)->incoming_state,
> > +                                LLC_INCOMING_QUEUED);
> >               skb_get(skb);
> >               skb_queue_tail(&sk->sk_receive_queue, skb);
> >               sk->sk_state_change(sk);
>
> > @@ -765,27 +771,153 @@ static struct sock *llc_create_incoming_sock(str=
uct sock *sk,
>
> [ ... ]
>
> > +static void llc_incoming_sock_work(struct work_struct *work)
> > +{
> > +     struct llc_sock *llc =3D container_of(work, struct llc_sock,
> > +                                                 incoming_work);
> > +     struct sock *sk =3D &llc->sk;
> > +     struct sock *listener =3D llc->incoming_listener;
> > +
> > +     lock_sock(listener);
> > +     lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> > +     llc_sk_free(sk, false);
> > +     sock_orphan(sk);
> > +     release_sock(sk);
> > +     llc_sk_stop_all_timers(sk, true);
> > +     release_sock(listener);
> > +     dev_put(llc->dev);
> > +     llc->dev =3D NULL;
> > +     sock_put(sk);
> > +     sock_put(listener);
> > +}
> > +
> > +void llc_release_incoming_sock(struct sock *sk)
> > +{
> > +     struct llc_sock *llc =3D llc_sk(sk);
> > +
> > +     if (atomic_xchg(&llc->incoming_state, LLC_INCOMING_NONE) =3D=3D
> > +         LLC_INCOMING_NONE)
> > +             return;
> > +
> > +     WRITE_ONCE(llc->state, LLC_CONN_OUT_OF_SVC);
> > +     sock_hold(sk);
> > +     llc_sap_remove_socket(llc->sap, sk);
> > +     schedule_work(&llc->incoming_work);
> > +}
>
> [ ... ]
>
> > @@ -813,18 +960,46 @@ void llc_conn_handler(struct llc_sap *sap, struct=
 sk_buff *skb)
> >               skb->sk =3D sk;
> >               skb->destructor =3D sock_efree;
> >       }
> > -     if (!sock_owned_by_user(sk))
> > +     if (unlikely(llc_sk(skb->sk)->state < LLC_CONN_STATE_ADM)) {
> > +             if (newsk)
> > +                     llc_release_incoming_sock(newsk);
> > +             else if (atomic_read(&llc_sk(sk)->incoming_state) !=3D
> > +                      LLC_INCOMING_NONE)
> > +                     llc_release_incoming_sock(sk);
> > +             goto drop_unlock;
> > +     }
>
> [Severity: Critical]
>
> Can this free a child that is already sitting on the listener's accept
> queue?
>
> Once llc_conn_state_process() has flipped the child to
> LLC_INCOMING_QUEUED, the connection indication skb is on the listener's
> sk_receive_queue holding a raw skb->sk pointer to the child;
> skb_set_owner_r() takes no socket reference. This gate releases the child
> found directly by established lookup whenever incoming_state is not
> LLC_INCOMING_NONE, which includes QUEUED children.
>
> A purely remote frame sequence against a listening socket reaches it:
>
>   SABME  -> llc_create_incoming_sock() publishes the child, PENDING
>          -> llc_conn_state_process() LLC_CONN_PRIM: QUEUED, skb queued
>   DISC   -> __llc_lookup() selects the child, and llc_common_state_trans_=
4
>             in net/llc/llc_c_st.c moves it from NORMAL to
>             LLC_CONN_STATE_ADM
>   command frame -> llc_adm_state_trans_5 sets LLC_CONN_OUT_OF_SVC
>   one more frame -> this gate sees state < LLC_CONN_STATE_ADM and
>             incoming_state =3D=3D LLC_INCOMING_QUEUED
>
> llc_release_incoming_sock() then drops the SAP hash reference through
> llc_sap_remove_socket() and schedules llc_incoming_sock_work(), which dro=
ps
> the llc_sk_free() sock_put plus the explicit sock_put, so the child is
> freed. Nothing dequeues or invalidates the indication skb.
>
> Does a later accept() then work on freed memory?
>
> net/llc/af_llc.c:llc_ui_accept() {
>         newsk =3D skb->sk;
>         llc_accept_incoming_sock(newsk);
>         llc_ui_sk_init(newsock, newsk);
>         sock_reset_flag(newsk, SOCK_ZAPPED);
>         newsk->sk_state         =3D TCP_ESTABLISHED;
>         ...
> frees:
>         kfree_skb(skb);
> }
>
> The trailing kfree_skb() also runs sock_rfree() on that sock, and listene=
r
> close in llc_release_incoming_children() reads
> llc_sk(newsk)->incoming_state and takes bh_lock_sock_nested(newsk) on the
> same pointer.
>
> The QUEUED branch and the retry: block of llc_backlog_rcv() call
> llc_release_incoming_sock() on an already-indicated child in the same way=
.
>
> Should the release paths be limited to LLC_INCOMING_PENDING children, or
> should the queued indication skb be removed from the listener's receive
> queue as part of the release?
>
> > +     if (!sock_owned_by_user(sk)) {
> >               llc_conn_rcv(sk, skb);
> > -     else {
> > +             if (newsk &&
> > +                 atomic_read(&llc_sk(newsk)->incoming_state) =3D=3D
> > +                 LLC_INCOMING_PENDING)
> > +                     llc_release_incoming_sock(newsk);
> > +     } else {
>
> [ ... ]
>
> > @@ -852,12 +1027,53 @@ static int llc_backlog_rcv(struct sock *sk, stru=
ct sk_buff *skb)
>
> [ ... ]
>
> > +                     if (sock_flag(sk, SOCK_DEAD) ||
> > +                         sk->sk_state !=3D TCP_LISTEN ||
> > +                         llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {
> > +                             llc_release_incoming_sock(newsk);
> > +                             bh_unlock_sock(newsk);
> > +                             local_bh_enable();
> > +                             goto out_kfree_skb;
> > +                     }
>
> [ ... ]
>
> > +             } else if (newsk &&
> > +                        atomic_read(&llc_sk(newsk)->incoming_state) =
=3D=3D
> > +                        LLC_INCOMING_QUEUED) {
> > +                     local_bh_disable();
> > +                     bh_lock_sock_nested(newsk);
> > +                     if (llc_sk(newsk)->state <=3D LLC_CONN_STATE_ADM)=
 {
> > +                             llc_release_incoming_sock(newsk);
> > +                             bh_unlock_sock(newsk);
> > +                             local_bh_enable();
> > +                             goto out_kfree_skb;
> > +                     }
>                                             ^^
>
> [Severity: Medium]
>
> Is the <=3D bound intended here? The PENDING branch just above and the ga=
te
> in llc_conn_handler() both use state < LLC_CONN_STATE_ADM, and the v5
> changelog describes the new check as an LLC_CONN_OUT_OF_SVC lower bound.
>
> LLC_CONN_STATE_ADM (1) is a live state with its own transition table
> (llc_adm_state_transitions), and a queued child legitimately returns to i=
t
> after a remote DISC:
>
> net/llc/llc_c_st.c
> static const struct llc_conn_state_trans llc_common_state_trans_4 =3D {
>         .ev            =3D llc_conn_ev_rx_disc_cmd_pbit_set_x,
>         .next_state    =3D LLC_CONN_STATE_ADM,
>
> So the same frame is dispatched when it arrives on the direct path in
> llc_conn_handler(), but here it is dropped and the child is destroyed via
> llc_release_incoming_sock(). The retry: block below applies the same
> asymmetric bound with state > LLC_CONN_STATE_ADM.
>
> Since llc_qualify_conn_ev() indexes llc_conn_state_table[llc->state - 1],
> would excluding only LLC_CONN_OUT_OF_SVC (0) be enough?
>
> [ ... ]

Hi Simon,

Thanks for forwarding the review. I checked each point manually.

[High]
Confirmed. v5 lets accept() consume the incoming_state transition without
holding the child lock or knowing whether the concurrent release path alrea=
dy
won it. The indication skb also does not keep a child socket reference.

[Critical]
Confirmed. A QUEUED child can be released by the out-of-service handling wh=
ile
its connection indication remains on the listener receive queue. That leave=
s
the skb->sk pointer stale for a later accept() or listener teardown.

[Medium]
Confirmed. LLC_CONN_STATE_ADM is a valid state, including after a DISC
transition. The queued-child path should reject only states below ADM, not =
ADM
itself.

For v6, the queued indication will hold a child socket reference until it i=
s
consumed; accept() will serialize with the child lock and verify that it wo=
n
the QUEUED-to-NONE transition; packet and backlog paths will only release
PENDING children; and the queued-child state bound will be made consistent
with the lower-bound state-table check.

Thanks,
Zihan
