Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA43955CB
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789284467; cv=pass; b=qi6MAIQa/bFezuXirJ71ZkFxOOHF1AVdbb6nvcXbH0N3833ECiihmbm0Q1TDLQBn+5H0MxOQGlKCNx1957ulp/Tuhhoq1O3TbpVM/IwkvVnu/9oTjvxoqOIeOZJX0h9QD5VOvJ4Zs+SnnBQe8SXmNrP6yWtqxaYFwjcCpWUwUEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789284467; c=relaxed/simple;
	bh=oz1JW/+becZV6n97r/nGU8AA3MggUKvW32yJohgtUqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CF2ioC+uM0uc0YzIfLmXmZM6ikEFpwx0nVm8TbXZfNzP6QLc8lX6eQjbx/n7fPBtPPJwbKMLdjFOKiO7/lbNYDNxCCEGNKYf5NHyw4bp9Tp4X79LcqbDIy+0faWM30q5/jyThavyBuhDAid2izfFj3pw2gecKfXJmCrDHgcGH5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=rPR5cK0j; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="rPR5cK0j"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5a04b88e9so7107351fa.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 00:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789284463; cv=none;
        d=google.com; s=arc-20260327;
        b=iFrqqlEAmI7n1I8OhkaBMorTo9f3UB3vC5LZqHxHTNs9kpfDxKQV/O6aUbEHtX8jLL
         tv54u4XaqsKypqBRv3ZwXhcmL17Basynq7PN2NxKu/4HTJag3Dj8MigQ40rCpncmXpir
         TzWx2YE5trK5wsOluOI9B1Cft3LntMD1o4StDIN4kxECpAiBPm+0JIpakeXiOJk7ASHj
         feZsq7NoOL24S4DsuAcUOWYLDPw3h9QEitXMwtJ3nHVlippr1yIcMnVzB9A262EL3mBU
         yck2hiMVXuZMHQasMH6Gc8WCGv9OtYBoZlA+LdHg0R0gjFgO9gsbEsK0EfnMV+pf02nj
         tNxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PYRxa8XTI9cqBSlblu9sgVRrwpQYfSUElluX+fnDXek=;
        fh=+IbHZg0oXL2Z1nBXI2EuVXc0yGjdDIfhWXmsCQtNw5o=;
        b=LNbKXsviVpFtszTgRbuY1xcvgEdhsBEKV8g6QO6+ZpqboN21GW7KpDnTA+/XUBKnkt
         kjnoS8pcxsOKtmBrh2KyCf94OgMlS2yY0PnaxavTSsZLMyN6eUMmdTRjAzBs8YH2UDEc
         UXxJ82FcchQP2cW9/9RnXJi0RNKTUFu6r6fiW8tBgy+NCFAN/8bXWRhgsUV5W6VDRGHG
         +XSV8rV1Dpwe8G1VJwin37ltyAc33+xcw+0c+BV5rBPImO/jS9grTm9KKeYEGasZs883
         POR6KpojKFR8Kj3qoB9lXKCsHVnOuN55Mli/EaeA9EG6w15WeStQJFWCHIj0buBjDwa/
         7nzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789284463; x=1789889263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PYRxa8XTI9cqBSlblu9sgVRrwpQYfSUElluX+fnDXek=;
        b=rPR5cK0j9zwYGDmJ+honuGxVHwiemMdVQ0RZJkE39ZP0Eqso8vbbB8iMXzJrQCUYjO
         vyPJUWZ7D4tYMJx27rv10aNh6koCYJGfT6nOJTsE+6wTPm5indW8lmRs7hKd/2/KCjXD
         +F0rTH9ObGedB9hYEHm9KJwFx9yAEDxZC7na+ReX9bH8dAWCnXpbvSpJVCaYfLOe8OxT
         1kkOFpUnzsET341PW2jW70cPXSzthH+WCeEqHUSzRFFKOwK4slc73cH7iu/G4XLdmY2L
         KegZtclnJ9dld3yVI9PqKGQ4in4dqwQOauYlcvlXtZ3CkwtPhTh8Lsg+G+lPD6Mhn5+A
         +LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789284463; x=1789889263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PYRxa8XTI9cqBSlblu9sgVRrwpQYfSUElluX+fnDXek=;
        b=ZMet1JXgn1HJWlY74IMp0CWhDfkyKRUbILDzWMaDKTb8UhvGxktFkJouP8vBgln7v/
         stye+DflMKdw7+bADa2D2duGbRqXxqelQCm/1E0gJMs7JyMvK3ZkZn73PahEpYd28lrG
         JjXkgQZMubS7n5ejeKNPZ5TwRTVjS4EUjSkLefn1COC+B+yW5jc8hWlzQX20b11fapX1
         C1TxZzoiDilxcbe+p8mFKn2wECjEQKND9TB5QP1yGB5x9MRd30o4tN5y3+cwb3ILkL6N
         gLDTPxoBE5W3I7qyU1fAYTPDD0CN//XmLAhU3YESTjqzaKiZ4nh6k+CGqOHCNcUxkaNq
         8MEg==
X-Forwarded-Encrypted: i=1; AKwUvBxqP+YdYPCKoNCxl8W0mEljBrdOL6fSXzDDYBUGKuhEbDeBTYkzddk1iyEGe4zhOxwkBGX0rDY=@vger.kernel.org
X-Gm-Message-State: AFuF++mQghF9BDmcE6Oc2Ydw9b4i5lgsoMxXqf2W6CG16Iv7ge/jLshS
	QwbL4Bme0LJueecJNUx6Gwg+axqSFOMVeFnHo3OyyZ5rK1D9c4ynOeoZAlJBev9vETqUezj3v/k
	JpTbCU6DqFpLOE4WfyYRWjn9GOFkiV4oHRz8RrAV2FCY=
X-Gm-Gg: AYBFou1v0eETp49KI/QEXjvMO8tVoDC4aGKdix6Wh693PHB81Kv8nKuXzUHFvuoogpD
	PIIJjAkpTn6YVnN4NIo7TsPKRH61upmQnIA4CGWVap84QbdX037nvK5bj6cQW6tNUyK6jecEWWT
	vZItd1Ul5a0ZqkhFmbPR4AVUhaA2Dhw+2zrJXwnMqNgrfYQ3Svkh98tIPC0xPFh0DXmxuowVZ0W
	3sqHvG4H9OJfQSy84vI3aOGZ2rmM83I7gy607ND0vSt1sGJUVI++V4hJuD19DySdqLm+ewiMGLk
	MH6pObTt9QEp+l9O2IP6xI4F/j74r4TVievfCK2N2+1iwctZu83H0Uqv/Km8XB+5YDGqIKO74vm
	arnYsqmpsHg==
X-Received: by 2002:a05:651c:1504:b0:3a3:476:2e37 with SMTP id
 38308e7fff4ca-3a5b355edfemr7516011fa.6.1789284463131; Sun, 13 Sep 2026
 00:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ca1d010bc963319d4167b8e985b5afac5912f6da.1788878590.git.zihanx@nebusec.ai>
 <20260912102659.174546-1-horms@kernel.org>
In-Reply-To: <20260912102659.174546-1-horms@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Sun, 13 Sep 2026 15:27:30 +0800
X-Gm-Features: AcwNN1Vvqo_OCWb3J_BsF1l-5FIOAtOvvcCdbwKE_Spin3WYMEfKjHExohmCA10
Message-ID: <CAANe3eTk-N9h9jUBfNpHp=CyQnL5jt0TtifYWctuMwmOURLsmw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org, dhowells@redhat.com, 
	marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, vega@nebusec.ai, root@tr0jan.top
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 6:28=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/ca1d0=
10bc963319d4167b8e985b5afac5912f6da.1788878590.git.zihanx@nebusec.ai?part=
=3D1
> ---
> rxrpc: fix encap_rcv skb accounting exhaustion
>
> This charges encapsulated packets against the UDP tunnel socket's receive
> buffer in rxrpc_encap_rcv() and drops them once sk_rcvbuf is reached, the=
n
> orphans PACKET skbs when the I/O thread dequeues them.  It also moves the
> sk_user_data clearing under RCU and defers sock_release() until after the
> local queues are purged.
>
> Link: https://lore.kernel.org/all/cover.1788539302.git.zihanx@nebusec.ai/
> Link: https://lore.kernel.org/all/cover.1785339953.git.zihanx@nebusec.ai/
> Link: https://lore.kernel.org/all/cover.1784742007.git.zihanx@nebusec.ai/
>
> > diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
> > index dc5184a2fa9d..415b05f5e2b4 100644
> > --- a/net/rxrpc/io_thread.c
> > +++ b/net/rxrpc/io_thread.c
> > @@ -13,6 +13,22 @@ static int rxrpc_input_packet_on_conn(struct rxrpc_c=
onnection *conn,
> >                                     struct sockaddr_rxrpc *peer_srx,
> >                                     struct sk_buff *skb);
> >
> > +/*
> > + * Drop UDP rmem ownership for packets charged in encap_rcv().
> > + * sk_forward_alloc is serialised by sk_receive_queue.lock.
> > + */
> > +static void rxrpc_skb_orphan_udp(struct sk_buff *skb)
> > +{
> > +     struct sock *sk =3D skb->sk;
> > +
> > +     if (!sk)
> > +             return;
> > +
> > +     spin_lock_bh(&sk->sk_receive_queue.lock);
> > +     skb_orphan(skb);
> > +     spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +}
> > +
> >  /*
> >   * handle data received on the local endpoint
> >   * - may be called in interrupt context
>
> [ ... ]
>
> > @@ -52,6 +66,22 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_b=
uff *skb)
> >       }
> >  #endif
> >
> > +     spin_lock(&udp_sk->sk_receive_queue.lock);
> > +     if (atomic_read(&udp_sk->sk_rmem_alloc) >=3D READ_ONCE(udp_sk->sk=
_rcvbuf) ||
> > +         !sk_rmem_schedule(udp_sk, skb, skb->truesize)) {
>
Hi Simon,

Thanks for the review. All four points are valid;

> [Severity: High]
>
> Which sk_rcvbuf value does this end up comparing against?  Nothing in
> net/rxrpc/ sizes the tunnel socket's receive buffer.  rxrpc_open_socket()
> calls udp_sock_create() and setup_udp_tunnel_sock(), neither of which tou=
ches
> it, so it stays at what sock_init_data() assigned:
>
> net/core/sock.c:sock_init_data() {
>         ...
>         sk->sk_rcvbuf           =3D       READ_ONCE(sysctl_rmem_default);
>         ...
> }
>
> That is roughly 208 KiB of truesize for the entire local endpoint, and si=
nce
> this is a kernel socket with no fd, the only way to change it is the glob=
al
> net.core.rmem_default.
>
> Meanwhile rxrpc keeps advertising a 255 packet receive window per call:
>
> net/rxrpc/misc.c:
> unsigned int rxrpc_rx_window_size =3D 255;
>
> net/rxrpc/conn_event.c:rxrpc_conn_retransmit_call() {
>         ...
>         trailer.rwind           =3D htonl(rxrpc_rx_window_size);
>         ...
> }
>
> with rxrpc_rx_mtu at RXRPC_JUMBO(46).  Both are sysctl-tunable; the new c=
ap
> is not.
>
> The test is a hard >=3D with no headroom, and the charge is only released=
 one
> skb at a time when the MIN_NICE krxrpcio thread dequeues.  At 2-4 KiB tru=
esize
> per MTU-sized skb, 50-90 queued skbs exhaust the budget, which a single
> softirq round can deliver before the I/O thread runs.
>
> Can a compliant AFS peer that simply fills the window rxrpc advertised to=
 it
> get dropped here, with no EXCEEDS_WINDOW ACK and recovery only via RTO?  =
The
> resulting threshold, how it was derived, and the disagreement with the
> advertised window aren't mentioned in the commit message or the v2/v3/v4
> changelog.

Yes. The tunnel socket is left at sysctl_rmem_default, which is
smaller than one advertised window of ordinary DATA, so a peer
filling that window can be dropped here with no EXCEEDS_WINDOW ACK.
>
> > +             spin_unlock(&udp_sk->sk_receive_queue.lock);
> > +             sk_drops_inc(udp_sk);
> > +             kfree_skb(skb);
> > +             return 0;
> > +     }
>
> [Severity: Low]
>
> The drop returns 0, which UDP counts as a delivered datagram:
>
> net/ipv4/udp.c:udp_queue_rcv_one_skb() {
>         ...
>                 ret =3D encap_rcv(sk, skb);
>                 if (ret <=3D 0) {
>                         __UDP_INC_STATS(net, UDP_MIB_INDATAGRAMS);
>                         return -ret;
>                 }
>         ...
> }
>
> So each dropped datagram bumps UDP_MIB_INDATAGRAMS and neither
> UDP_MIB_RCVBUFERRORS nor UDP_MIB_INERRORS is incremented, unlike UDP's ow=
n
> rcvbuf-overflow path for the same socket type
> (__udp_enqueue_schedule_skb() -> -ENOMEM -> RCVBUFERRORS + INERRORS).
> Under the flood this patch bounds, netstat -su shows InDatagrams climbing=
 and
> zero receive-buffer errors while sk_drops rises.
>
> The hook return value can't express this (a negative return makes
> udp_queue_rcv_one_skb() resubmit to the protocol and still counts
> INDATAGRAMS), so would an explicit __UDP_INC_STATS(net, UDP_MIB_RCVBUFERR=
ORS)
> plus UDP_MIB_INERRORS here be appropriate, along with a specific
> skb_drop_reason instead of the bare kfree_skb()?

Yes. return 0 is counted as a delivered datagram. A negative return
is not usable here either: it resubmits as proto -N and still
increments INDATAGRAMS. Extra RCVBUFERRORS / INERRORS and a
skb_drop_reason are appropriate.
>
> > +
> > +     skb->dev =3D NULL;
> > +     skb_set_owner_r(skb, udp_sk);
>
> [Severity: Medium]
>
> This consumes the same counter and the same limit that the socket error q=
ueue
> is gated on:
>
> net/core/skbuff.c:sock_queue_err_skb() {
>         if (atomic_read(&sk->sk_rmem_alloc) + skb->truesize >=3D
>             (unsigned int)READ_ONCE(sk->sk_rcvbuf))
>                 return -ENOMEM;
>         ...
> }
>
> rxrpc's only ICMP ingress is rxrpc_encap_err_rcv() ->
> ip_icmp_error()/ipv6_icmp_error() -> sock_queue_err_skb().  On -ENOMEM th=
e
> notification is kfree_skb()'d, sk_error_report() is never called, so
> rxrpc_error_report() never queues an RXRPC_SKB_MARK_ERROR skb and
> rxrpc_input_error() never runs.
>
> Does that silently drop port-unreachable (peer-dead) detection and
> ICMP_FRAG_NEEDED path-MTU input for the whole endpoint for as long as the=
 rx
> queue is near full, i.e. exactly the state this patch holds during a floo=
d?
>
> Before this change the encap path never touched sk_rmem_alloc, so the bud=
get
> was effectively reserved for error skbs.  Error skbs also stay charged af=
ter
> rxrpc_error_report() moves them onto local->rx_queue, since the patch
> deliberately does not orphan them, which widens the window further.

Yes. Charging DATA against the same rmem cap can starve
sock_queue_err_skb(), so ICMP is dropped and rxrpc_error_report()
never runs. Before this change that budget was effectively reserved
for error skbs.
>
> > +     spin_unlock(&udp_sk->sk_receive_queue.lock);
> > +     skb_dst_force(skb);
>
> [Severity: Low]
>
> What consumes the forced dst reference, and why is skb->dev cleared above=
?
>
> A git grep for skb_dst and skb->dev in net/rxrpc/ matches only these two =
new
> lines, and the only dst dereference in rxrpc (dst->dev->gso_max_segs in
> peer_object.c) works on an output route lookup.
>
> Before this change the queued skb carried a SKB_DST_NOREF dst, which
> refdst_drop() skips on free; skb_dst_force() promotes it to a refcounted =
dst
> held until the skb is finally freed.  UDP's own queueing path drops the d=
st
> instead:
>
> net/ipv4/udp.c:udp_queue_rcv_one_skb() {
>         ...
>         ipv4_pktinfo_prepare(sk, skb, true);
>         return __udp_queue_rcv_skb(sk, skb);
> }
>
> Would skb_dst_drop() be what is wanted here?  rxrpc_skb_orphan_udp() rele=
ases
> the rmem charge at dequeue but leaves the dst in place, so DATA packets h=
anded
> to a call's recvmsg queue keep the reference for a
> remote-sender-plus-slow-reader controlled interval that is not covered by=
 the
> new sk_rcvbuf cap, because dst size is not part of skb->truesize.
>
> Neither skb->dev =3D NULL nor skb_dst_force() is described in the commit =
message
> or the v2/v3/v4 changelog.

Yes. skb_dst_force() was the wrong helper. The dst is not part of
skb->truesize, so it is not covered by the rmem cap.
skb_dst_drop() is what is wanted. skb->dev =3D NULL is only to avoid
holding a device reference on a queued RxRPC skb.

Thanks,
Zihan Xi
>
> > +
> > +     skb->mark =3D RXRPC_SKB_MARK_PACKET;
> > +     rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
> >       skb_queue_tail(rx_queue, skb);
> >       wake_up_process(io_thread);
> >       return 0;
> > @@ -471,6 +501,9 @@ int rxrpc_io_thread(void *data)
> >               /* Distribute packets and errors. */
> >               while ((skb =3D __skb_dequeue(&rx_queue))) {
> >                       struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
> > +
> > +                     if (skb->mark =3D=3D RXRPC_SKB_MARK_PACKET)
> > +                             rxrpc_skb_orphan_udp(skb);
> >                       switch (skb->mark) {
> >                       case RXRPC_SKB_MARK_PACKET:
> >                               skb->priority =3D 0;
>
> [ ... ]
