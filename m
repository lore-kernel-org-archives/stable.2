Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C0E37E5D2
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 04:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756508; cv=pass; b=IakmnXN80as9mx89aTas9vgRdSApyi6H/qVDRsvzeuB91hF3BoboQNVIX8qaMF5EvRwnCA5oamDXylEi2mQX3lNPXmemi5k8ESSxYF5Brgxhs5KCnd+lJnquTQg7Pz+CBIZxMecj87zS3BEBDfxdzOtwtjUZiwZjioA+CNxu5ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756508; c=relaxed/simple;
	bh=lg2EjNYcWX1YmrLgH226d++MXZyTtWRz7Bf2+axtCig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOCl3imPFmUCZ/KyqzRARHqKGRZEm1UVR67/A8xtSInzfKH2cf5nN5Qen4Bbx8yAp2/JsnCxhQETmUU+B7qiOq+IDsKz47NGjyM3C4lvqiHpJrkni8oqy8+0WD/5nIEAQuC5i0Tj4lOwnwAKSiW4kaYz2+XGfrRshbhYku9yXdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=oMFcLEBG; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="oMFcLEBG"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a305310ddaso29097901fa.0
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 21:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788756503; cv=none;
        d=google.com; s=arc-20260327;
        b=Sx0qcRIFmqIiK/f0mgyvx2HpXAB5HchZ2vLK8LZqBfEJLrYE2Ag7NcAvBv9eCng5LQ
         a4VIsI4wg/3UTtJxuotjS9LKjCBf2zFg6eK/OdQnKySpsk6yYgSdg4E5W7dzMq4EJhx+
         fJHFLvq5W7HOydNAI62mjtEY7Kymk3+3bC5WWzpwgfOY6G3PTBxG51VLenMu8QWOs/Oa
         MTcLtzSj06xACzVG9mVz3UUId7tXrEZ2Q5Hwnbf9GS4TLKfbfSRUaJeOCi8i7GpCug5/
         Z2DamKq4TGWX0bCzVMMS3t7fwg5Xjn+vxalquHQIi3EXjpt2T3ICnUtw8x+Oct96l8HU
         xDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LlCwC+OeHPgAlG4+7+P7EiIGYUqFR1bYavtRdwQlpTo=;
        fh=MIRb4BnDHSnTi3KIKuOZzgr9jHoKEYVI0McCWEfTuyk=;
        b=duM05DVViIfrHDO4DnUbKs8B3iKD8uCryslZNaXAKQwT2Yexi+temVqwAmC2nxPxSq
         4UGyUsi+Gn8bkZxm5hqklsKFt/6XG3Weq6mJgdtem1qXYkGdGiRaLDgoGYjqnnN//VIg
         LjBpHGbn2gEXd8Gks5H6G9EAIrVfViF5aYP/LbbJoLSJEku7RSA48pq73Vehw4vW+Ous
         1oXJnqflgsoOu3QYoxKaLb0I/oVpn0/MWqrhWOKmfkA1TD9NOUw8ZSw/O3Q13fE5UXmR
         S+Lfv18sM9Pg/WVYGhsRe88MT+KKj1sYgDUSobAh+saxsc3kdWSo9osJcn1xhw+Z5s73
         33pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788756503; x=1789361303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LlCwC+OeHPgAlG4+7+P7EiIGYUqFR1bYavtRdwQlpTo=;
        b=oMFcLEBGhwr0CMRgiypasbtZKXspSqp2168AuMo9IiI5YA8SkWQvJKEw0XNGyX29bM
         JHFcEZEduZ/2EaWnNDaYRS6Zw23f/WhBNd0+/lz4aTufLk0GBOvQM93sf/k3OrQYER6k
         QIK+IRACcXJ4r2XekME9RN1Zxxe7+sP6O7I9E0YoN1qvzSC9O8JTWaN3WB4J2mkcm5WV
         CbmNS8xbJXXEdlTonvNa8PwEX7gX7ExOL1Tykh9uHNuM7gk2nyNsWTNQQLuSCWP5vl37
         umwq7eGugZCmi98/ZP8JwvJgLKiynoL1sq6x9jCHPpU+DGq+Q4xCJlyGGWPn2EX1IdAt
         Ft/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756503; x=1789361303;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LlCwC+OeHPgAlG4+7+P7EiIGYUqFR1bYavtRdwQlpTo=;
        b=eO71I4Neb438WnyGSYAJ1MESpL4jPPxaSgMO+bMfa6GkxxG+Sof0whks9dkyBEWNJg
         6JnZ/3bOdjRRRfbZlGF6b7Op4L6ZXK5J17HZuZCPi2Rujz2apDS6WLasVDvU/42z2882
         7XJMZU5hDqHC92eFgW09rBi4B0tCvxz6HVdHyVs/Z9okOmN/A75K69XnYUF8Sz5KsebY
         7jG1+qea4/+4+CrOJuM354kVTQSRb8pqYKNdzziVSRLXtn3V670daubdZa0ukmUsenzO
         mYX5L7jYZRt/KYfoKiphiPoobjH3ngMqfvBLSkdQ1fdtvfl/V3JtuBGSp+zCoW8SuOmc
         UjXw==
X-Forwarded-Encrypted: i=1; AKwUvBx853mgj7+Edqadl7Ev/8vQSkS1D9yBEO1IiFO58rKhIzI/RwuSZnMll0WVY42DSBWaSOrEAIg=@vger.kernel.org
X-Gm-Message-State: AFuF++m2/SVhss0pslIs+LE8UFwb/FrrvXtoF6nnW5e5Q1gm3MvzmsAO
	AQnYe/Za03QtWcvn1E+1YD5Bdw4IgIsu/PDMl+DF3cb5/dF//0nmosKp8oOsdZRPMuw13PB7spB
	Gfoo1hA5QZrotpgbsijjAlFUCFAL4PAnpK0LgJWcIYek=
X-Gm-Gg: AYBFou1+M4YGkeGRHbEjmEUb3o8t6fP6UE978JqxJGgAfXNr17HNc3vdzHiugVqcs+t
	un4PvqE11y9kJG9v3/j7lTJkiyqDWjs3N+k0/leRRMMhI9zd2d5kD4NHkBzNd+GhermOI+ok1yh
	6MPF/KF6bEnH9Akcjrl3xXc6nv6WFQ56nUt0UinIf0f9fmYiNOy4L5kWlcK8BFaOLMwi0Uu1PEu
	JzpCR5oiECSC8lESV73KD6OGlP5Re6/DjNGuTQPEcGu671z8zRLvtPRSh9vQHNqqi9vw8oiVbq8
	z9jcgzzy01nZmhefoRIKteADIrktPDL8lRaVgqzwt5aHkXMOQzb1svuAJ/nhzvwyQnAFg0BUj74
	=
X-Received: by 2002:a2e:b893:0:b0:3a3:74b7:fc0a with SMTP id
 38308e7fff4ca-3a374b8279dmr19375891fa.22.1788756503017; Sun, 06 Sep 2026
 21:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
 <178875495405.219967.5594821749566554418@kernel.org>
In-Reply-To: <178875495405.219967.5594821749566554418@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 12:48:11 +0800
X-Gm-Features: AcwNN1UF1s5IJXPuklb8t5AThGjsMeHr902veOyCGjoeg8FS-0N6M_r-kwl8j7s
Message-ID: <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 12:22=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider:
>
> Critical: 2 =C2=B7 High: 1 =C2=B7 Medium: 2 =C2=B7 Low: 1
>
> - [Critical] Use-after-free / wild-pointer traversal: the new bind-hash
>   dump cursor revalidation in tcp_diag_dump() cannot detect that the=E2=
=80=A6
> - [Critical] Refcount initialization race: tcp_diag_bind_collect_sock()
>   calls sock_hold() unconditionally on every node of tb2->owners,=E2=80=
=A6
> - [High] Loss of dump forward progress and duplicate output: the patch
>   deletes every positional (`s_num`) resume path in tcp_diag_dump()=E2=80=
=A6
> - [Medium] Lockless, unordered reads of cursor state: the listen and
>   ehash cursor validations establish "this socket is in the bucket I=E2=
=80=A6
> - [Medium] The commit message mischaracterizes the pre-existing defect.
> - [Low] Concern that the sibling MPTCP listener dump
>   (mptcp_diag_dump_listeners()) keeps evaluating request-supplied=E2=80=
=A6
>
> --
>
> tcp: diag: bound bucket lock hold in tcp_diag_dump()
>
> This reworks the three tcp_diag_dump() hash walks so that only referenced
> sockets are collected under each bucket lock, and moves the family/port
> filters, inet_diag_bc_sk() bytecode evaluation and the fill work outside =
the
> critical section.  A referenced dump cursor is added to
> struct inet_diag_dump_data so a following batch resumes after the previou=
sly
> reported socket, with per-table validation of the cursor.
>
> v1 Link: https://lore.kernel.org/all/cover.1785307984.git.zihanx@nebusec.=
ai/
>
> >     inet_diag dumps run request-supplied bytecode through inet_diag_bc_=
sk().
> >     tcp_diag_dump() currently evaluates socket filters and fills replie=
s while
> >     holding the listener, bind, and ehash bucket locks.
>
> [Severity: Medium]
> Is this description accurate for all three tables?
>
> At the baseline (544d85de4dc2) only the listener walk fills replies under
> ilb->lock.  The bind walk already collected at most SKARR_SZ =3D 16 refer=
enced
> sockets under spin_lock_bh(&ibb->lock) and only called inet_sk_diag_fill(=
)
> after the lock was dropped:
>
>         pause_bind_walk:
>                         spin_unlock_bh(&ibb->lock);
>
>                         res =3D 0;
>                         for (idx =3D 0; idx < accum; idx++) {
>                                 if (res >=3D 0) {
>                                         res =3D inet_sk_diag_fill(sk_arr[=
idx],
>                                                                 NULL, skb=
, cb,
>                                                                 r, NLM_F_=
MULTI,
>                                                                 net_admin=
);
>
> The ehash walk did the same with sk_diag_fill() after spin_unlock_bh(lock=
).
> What remained under the bind and ehash locks was inet_diag_bc_sk() plus t=
he
> cheap family/port comparisons, bounded to 16 sockets per lock hold.
>
> Could the changelog be narrowed to the listener walk, or state explicitly
> what part of the bind/ehash work it is moving out?
>
> > diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
> > index 704fd415c2b49..6ccd32bc48f91 100644
> > --- a/include/linux/inet_diag.h
> > +++ b/include/linux/inet_diag.h
>
> [ ... ]
>
> > @@ -32,12 +33,23 @@ struct inet_diag_handler {
> >  };
> >
> >  struct bpf_sk_storage_diag;
> > +
> > +enum inet_diag_dump_cursor_type {
> > +     INET_DIAG_DUMP_CURSOR_NONE,
> > +     INET_DIAG_DUMP_CURSOR_TCP_LISTEN,
> > +     INET_DIAG_DUMP_CURSOR_TCP_BIND,
> > +     INET_DIAG_DUMP_CURSOR_TCP_EHASH,
> > +};
> > +
>
> [Severity: Low]
> This isn't a bug, but a note for backporters.  The sibling MPTCP listener
> dump mptcp_diag_dump_listeners() is converted by the follow-up patch in t=
his
> series (INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN, which is why the enum slot an=
d
> the exported inet_diag_dump_clear_cursor() appear here), so at the tip of=
 the
> series the MPTCP listener walk also drops ilb->lock before calling
> sk_diag_dump()/inet_diag_bc_sk().
>
> This patch is Cc: stable, and the commit message body does not mention th=
at
> the MPTCP listener walk keeps running request-supplied bytecode under the
> same hashinfo->lhash2 bucket lock until the follow-up patch is applied.  =
Only
> the v2 changelog, which is stripped on apply, mentions "Left
> INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN to the MPTCP patch".  Could that
> dependency be stated in the commit message?
>
> [ ... ]
>
> > diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtable=
s.h
> > index 6e2fe186d0dcb..d95639ac70c67 100644
> > --- a/include/net/inet_hashtables.h
> > +++ b/include/net/inet_hashtables.h
> > @@ -188,6 +188,24 @@ inet_lhash2_bucket(struct inet_hashinfo *h, u32 ha=
sh)
> >       return &h->lhash2[hash & h->lhash2_mask];
> >  }
> >
> > +static inline struct inet_listen_hashbucket *
> > +inet_lhash2_bucket_sk(struct inet_hashinfo *h, struct sock *sk)
> > +{
> > +     u32 hash;
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +     if (sk->sk_family =3D=3D AF_INET6)
> > +             hash =3D ipv6_portaddr_hash(sock_net(sk),
> > +                                       &sk->sk_v6_rcv_saddr,
> > +                                       inet_sk(sk)->inet_num);
> > +     else
> > +#endif
> > +             hash =3D ipv4_portaddr_hash(sock_net(sk),
> > +                                       inet_sk(sk)->inet_rcv_saddr,
> > +                                       inet_sk(sk)->inet_num);
> > +     return inet_lhash2_bucket(h, hash);
> > +}
> > +
>
> [ ... ]
>
> > diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
> > index ba1fdbe9807fd..842e13ee79e5b 100644
> > --- a/net/ipv4/tcp_diag.c
> > +++ b/net/ipv4/tcp_diag.c
> > @@ -285,6 +285,73 @@ static int sk_diag_fill(struct sock *sk, struct sk=
_buff *skb,
> >                                net_admin);
> >  }
> >
>
> [ ... ]
>
> > +static struct inet_bind2_bucket *tcp_diag_sk_bind2(const struct sock *=
sk)
> > +{
> > +     if (sk->sk_state =3D=3D TCP_TIME_WAIT)
> > +             return inet_twsk(sk)->tw_tb2;
> > +
> > +     return inet_csk(sk)->icsk_bind2_hash;
> > +}
> > +
> > +static bool tcp_diag_bind_collect_sock(struct sock *sk, struct sock **=
sk_arr,
> > +                                    int *num_arr, int *accum, int num)
> > +{
> > +     sock_hold(sk);
> > +     num_arr[*accum] =3D num;
> > +     sk_arr[*accum] =3D sk;
> > +
> > +     return ++*accum =3D=3D SKARR_SZ;
> > +}
> > +
> > +static bool tcp_diag_bind_collect_owners(struct hlist_head *owners,
> > +                                      struct sock **sk_arr, int *num_a=
rr,
> > +                                      int *accum, int *num, int s_num)
> > +{
> > +     struct sock *sk;
> > +
> > +     sk_for_each_bound(sk, owners) {
> > +             if (*num < s_num) {
> > +                     (*num)++;
> > +                     continue;
> > +             }
> > +
> > +             if (tcp_diag_bind_collect_sock(sk, sk_arr, num_arr, accum=
, *num))
> > +                     return true;
> > +             (*num)++;
> > +     }
> > +
> > +     return false;
> > +}
>
> [Severity: Critical]
> Can the unconditional sock_hold() in tcp_diag_bind_collect_sock() hit a
> TIME_WAIT socket whose tw_refcnt is still 0?
>
> The changelog says "Bind collection counts TIME_WAIT nodes toward the bat=
ch
> limit", and tcp_diag_bind_collect_owners() no longer filters on
> sk->sk_state !=3D TCP_CLOSE before taking the reference, so every node of
> tb2->owners now gets a refcount_inc().
>
> inet_twsk_alloc() starts the object at zero on purpose:
>
>         /*
>          * Because we use RCU lookups, we should not set tw_refcnt
>          * to a non null value before everything is setup for this
>          * timewait socket.
>          */
>         refcount_set(&tw->tw_refcnt, 0);
>
> and inet_twsk_hashdance_schedule() publishes it into the bind owners list=
 and
> drops both bind locks before initializing the count:
>
>         sk_add_bind_node((struct sock *)tw, &tw->tw_tb2->owners);
>
>         spin_unlock(&bhead2->lock);
>         spin_unlock(&bhead->lock);
>
>         spin_lock(lock);
>
>         refcount_set(&tw->tw_refcnt, 3);
>
> A dumper blocked on bhead2->lock acquires it right after that unlock and
> immediately walks tb2->owners, so it can observe the published tw with
> tw_refcnt =3D=3D 0.  sock_hold() then calls refcount_inc() on zero, which=
 trips
> refcount_warn_saturate() and leaves the counter saturated, after which
> refcount_set(&tw->tw_refcnt, 3) discards the dump's reference.  The later
> sock_gen_put() from the fill loop then consumes one of the three structur=
al
> references (bhash, ehash, timer).
>
> Would using refcount_inc_not_zero() here, or keeping the TCP_CLOSE check
> under the lock, be safer?
>
> > @@ -335,8 +402,15 @@ static void tcp_diag_dump(struct sk_buff *skb, str=
uct netlink_callback *cb,
> >               for (i =3D s_i; i <=3D hashinfo->lhash2_mask; i++) {
> >                       struct inet_listen_hashbucket *ilb;
> >                       struct hlist_nulls_node *node;
> > +                     struct sock *sk_arr[SKARR_SZ];
> > +                     int num_arr[SKARR_SZ];
> > +                     struct sock *cursor;
> > +                     int idx, accum, res;
> > +                     bool use_cursor;
> >
> > +resume_listen_walk:
> >                       num =3D 0;
> > +                     accum =3D 0;
> >                       ilb =3D &hashinfo->lhash2[i];
> >
> >                       if (hlist_nulls_empty(&ilb->nulls_head)) {
> > @@ -344,52 +418,81 @@ static void tcp_diag_dump(struct sk_buff *skb, st=
ruct netlink_callback *cb,
> >                               continue;
> >                       }
> >                       spin_lock(&ilb->lock);
> > -                     sk_nulls_for_each(sk, node, &ilb->nulls_head) {
> > -                             struct inet_sock *inet =3D inet_sk(sk);
> > +                     cursor =3D cb_data->dump_cursor;
> > +                     use_cursor =3D cursor &&
> > +                                  cb_data->dump_cursor_type =3D=3D
> > +                                  INET_DIAG_DUMP_CURSOR_TCP_LISTEN &&
> > +                                  cb_data->dump_cursor_slot =3D=3D i &=
&
> > +                                  inet_sk_state_load(cursor) =3D=3D TC=
P_LISTEN &&
> > +                                  !hlist_nulls_unhashed(&cursor->sk_nu=
lls_node) &&
> > +                                  cursor->sk_nulls_node.pprev !=3D LIS=
T_POISON2 &&
> > +                                  inet_lhash2_bucket_sk(hashinfo, curs=
or) =3D=3D ilb;
> > +                     node =3D use_cursor ? cursor->sk_nulls_node.next =
:
> > +                                         ilb->nulls_head.first;
>
> [Severity: Medium]
> Is the "cursor is still in this bucket" conclusion sound when every input=
 to
> it is read without the lock that publishes it?
>
> In the listener path the recomputation uses sock_net(cursor),
> sk_v6_rcv_saddr (a 16-byte non-atomic read) and inet_sk(cursor)->inet_num=
 via
> the newly exported inet_lhash2_bucket_sk(), none of which is protected by
> ilb->lock, and the pprev test and the bucket computation are separate pla=
in
> loads with no barrier between them.
>
> The ehash variant later in this function has the same shape with
> cursor->sk_nulls_node.pprev followed by cursor->sk_hash.  The insertion s=
ide
> sets sk->sk_hash before taking the target bucket lock and linking with
> __sk_nulls_add_node_rcu(), and inet_csk_listen_start() stores TCP_LISTEN
> before hashing into lhash2, so a reader that observes the new linkage is =
not
> guaranteed to observe the matching sk_hash/sk_state store.  A socket that
> left ehash bucket i and called listen() keeps its old sk_hash, so
> inet_sk_state_load(cursor) !=3D TCP_LISTEN can still be true while the lh=
ash2
> linkage is already visible.
>
> If validation passes on a stale snapshot, the walk then follows
> cursor->sk_nulls_node.next into a chain whose spinlock is not held and
> sock_hold()s the entries it finds.  On x86 the store order makes the
> inconsistent snapshot hard to observe, but is bucket membership something
> that can be established from lockless per-socket fields at all?
>
> > +                     if (!use_cursor)
> > +                             s_num =3D 0;
> > +                     hlist_nulls_for_each_entry_from(sk, node, sk_null=
s_node) {
> >
> > -                             if (!net_eq(sock_net(sk), net))
> > -                                     continue;
> > +                             sock_hold(sk);
> > +                             num_arr[accum] =3D num;
> > +                             sk_arr[accum] =3D sk;
> > +                             if (++accum =3D=3D SKARR_SZ)
> > +                                     break;
> >
> > -                             if (num < s_num) {
> > -                                     num++;
> > -                                     continue;
> > -                             }
> > +                             ++num;
> > +                     }
> > +                     spin_unlock(&ilb->lock);
>
> [Severity: High]
> With the num < s_num skip removed from this loop and s_num forced to 0 wh=
en
> the cursor is rejected, what stops the bucket from being re-dumped from i=
ts
> head?
>
> All three walks now do:
>
>         if (!use_cursor)
>                 s_num =3D 0;
>
> and the batch continuations replace s_num =3D num + 1 with s_num =3D 0:
>
>         if (accum =3D=3D SKARR_SZ) {
>                 s_num =3D 0;
>                 goto resume_listen_walk;
>         }
>
> The bind walk and the ehash walk have the same two changes, and the s_num
> parameter of tcp_diag_bind_collect_owners() is dead because its only call=
er
> sits in the !use_cursor branch where s_num has just been zeroed.
>
> So whenever cursor validation fails, which the changelog describes as the
> "safe restart on mismatch", the walk restarts at ilb->nulls_head.first, a=
t
> the head of ibb->chain, or at head->chain.first, and re-emits sockets fro=
m
> that bucket that were already sent to user space earlier in the same dump=
.
> Before this change s_num =3D num + 1 guaranteed the restart advanced.
>
> There is a second effect: if all of the re-collected leading SKARR_SZ soc=
kets
> are discarded after the lock is dropped (foreign netns, since lhash2 and
> ehash are shared across netns, or sdiag_family/port mismatch, or bytecode
> rejection), nothing is emitted, res stays 0 and the goto resume_*_walk lo=
op
> repeats over the same head with only cond_resched() yielding.
>
> tcp_diag_dump() still loads s_num =3D num =3D cb->args[2] on entry and st=
ill
> stores cb->args[2] =3D num at the done: label, but num is now a chunk-rel=
ative
> counter that no resume path consumes.  Should that state be dropped, or
> should a positional fallback be kept for the mismatch case?  Also, since =
the
> walk can now repeat objects within a dump, should NLM_F_DUMP_INTR be set =
via
> a generation counter in netlink_callback.seq?
>
> [ ... ]
>
> > @@ -412,34 +517,46 @@ static void tcp_diag_dump(struct sk_buff *skb, st=
ruct netlink_callback *cb,
> >                               continue;
> >                       }
> >                       spin_lock_bh(&ibb->lock);
> > -                     inet_bind_bucket_for_each(tb2, &ibb->chain) {
> > -                             if (!net_eq(ib2_net(tb2), net))
> > -                                     continue;
> > -
> > -                             sk_for_each_bound(sk, &tb2->owners) {
> > -                                     struct inet_sock *inet =3D inet_s=
k(sk);
> > -
> > -                                     if (num < s_num)
> > -                                             goto next_bind;
> > -
> > -                                     if (sk->sk_state !=3D TCP_CLOSE |=
|
> > -                                         !inet->inet_num)
> > -                                             goto next_bind;
> > -
> > -                                     if (r->sdiag_family !=3D AF_UNSPE=
C &&
> > -                                         r->sdiag_family !=3D sk->sk_f=
amily)
> > -                                             goto next_bind;
> > -
> > -                                     if (!inet_diag_bc_sk(cb_data, sk)=
)
> > -                                             goto next_bind;
> > -
> > -                                     sock_hold(sk);
> > -                                     num_arr[accum] =3D num;
> > -                                     sk_arr[accum] =3D sk;
> > -                                     if (++accum =3D=3D SKARR_SZ)
> > +                     cursor =3D cb_data->dump_cursor;
> > +                     use_cursor =3D cursor &&
> > +                                  cb_data->dump_cursor_type =3D=3D
> > +                                  INET_DIAG_DUMP_CURSOR_TCP_BIND &&
> > +                                  cb_data->dump_cursor_slot =3D=3D i &=
&
> > +                                  !hlist_unhashed(&cursor->sk_bind_nod=
e) &&
> > +                                  cursor->sk_bind_node.pprev !=3D LIST=
_POISON2;
> > +                     if (use_cursor) {
> > +                             tb2 =3D tcp_diag_sk_bind2(cursor);
> > +                             use_cursor =3D tb2 &&
> > +                                          inet_bhashfn_portaddr(hashin=
fo, cursor,
> > +                                                                sock_n=
et(cursor),
> > +                                                                inet_s=
k(cursor)->inet_num) =3D=3D
> > +                                          ibb;
> > +                     }
> > +                     if (!use_cursor)
> > +                             s_num =3D 0;
> > +                     if (use_cursor) {
> > +                             sk =3D cursor;
> > +                             if (tcp_diag_bind_collect_owners_continue=
(sk, sk_arr,
> > +                                                                      =
 num_arr,
> > +                                                                      =
 &accum,
> > +                                                                      =
 &num))
> > +                                     goto pause_bind_walk;
> > +                             hlist_for_each_entry_continue(tb2, node) =
{
> > +                                     if (tcp_diag_bind_collect_owners(=
&tb2->owners,
> > +                                                                      =
sk_arr,
> > +                                                                      =
num_arr,
> > +                                                                      =
&accum,
> > +                                                                      =
&num, 0))
> > +                                             goto pause_bind_walk;
> > +                             }
>
> [Severity: Critical]
> Can these two liveness checks ever detect that the cursor left
> tb2->owners, and can tb2 here already be freed?
>
> Removal from a bind chain goes through __sk_del_bind_node():
>
> include/net/sock.h:
> static inline void __sk_del_bind_node(struct sock *sk)
> {
>         __hlist_del(&sk->sk_bind_node);
> }
>
> __hlist_del() only writes *pprev and next->pprev; it leaves the removed
> node's own pprev and next untouched.  So for a socket that was unlinked,
> hlist_unhashed(&cursor->sk_bind_node) is false and
> cursor->sk_bind_node.pprev !=3D LIST_POISON2 holds, and both tests pass.
>
> The freed-bucket part comes from __inet_bhash2_update_saddr():
>
> net/ipv4/inet_hashtables.c:
>         spin_lock(&head2->lock);
>         __sk_del_bind_node(sk);
>         inet_bind2_bucket_destroy(hinfo->bind2_bucket_cachep, inet_csk(sk=
)->icsk_bind2_hash);
>         spin_unlock(&head2->lock);
>
>         if (reset)
>                 inet_reset_saddr(sk);
>         else
>                 inet_update_saddr(sk, saddr, family);
>
> icsk_bind2_hash is never cleared, and inet_bind2_bucket_destroy() frees t=
he
> bucket immediately with no grace period when it was the sole owner:
>
>         if (hlist_empty(&tb->owners)) {
>                 __hlist_del(&tb->node);
>                 __hlist_del(&tb->bhash_node);
>                 kmem_cache_free(cachep, tb);
>                 return;
>         }
>
> In the window between that spin_unlock() and the address update, the addr=
ess
> is unchanged, so inet_bhashfn_portaddr() still resolves to ibb, and
> tcp_diag_sk_bind2(cursor) returns the dangling icsk_bind2_hash.  use_curs=
or
> therefore becomes true.
>
> tcp_diag_bind_collect_owners_continue() then iterates the cursor's stale
> sk_bind_node.next, and hlist_for_each_entry_continue(tb2, node) reads
> tb2->node.next out of the freed slab object, producing an arbitrary
> struct inet_bind2_bucket * whose owners list is walked with sock_hold()
> applied to each apparent entry.
>
> Note the dumper holds only hashinfo->bhash2[i].lock and never the primary
> bhash head lock, and a cursor is saved for every collected owner includin=
g
> the ones filtered out afterwards, so a process that dumps with
> TCPF_BOUND_INACTIVE while calling connect() on a bound socket in that buc=
ket
> can reach this.  Could the cursor instead record a validated tb2 identity
> that is re-looked-up under ibb->lock, rather than being derived from
> icsk_bind2_hash?
>
> > +                     } else {
> > +                             inet_bind_bucket_for_each(tb2, &ibb->chai=
n) {
> > +                                     if (tcp_diag_bind_collect_owners(=
&tb2->owners,
> > +                                                                      =
sk_arr,
> > +                                                                      =
num_arr,
> > +                                                                      =
&accum,
> > +                                                                      =
&num, s_num))
> >                                               goto pause_bind_walk;
> > -next_bind:
> > -                                     num++;
> >                               }
> >                       }
> >  pause_bind_walk:
>
> [ ... ]
>
> > @@ -463,13 +598,15 @@ static void tcp_diag_dump(struct sk_buff *skb, st=
ruct netlink_callback *cb,
> >                       cond_resched();
> >
> >                       if (accum =3D=3D SKARR_SZ) {
> > -                             s_num =3D num + 1;
> > +                             s_num =3D 0;
> >                               goto resume_bind_walk;
> >                       }
> >
> > +                     inet_diag_dump_clear_cursor(cb_data);
> >                       s_num =3D 0;
> >               }
>
> [ ... ]
>
> >               if (accum =3D=3D SKARR_SZ) {
> > -                     s_num =3D num + 1;
> > +                     s_num =3D 0;
> >                       goto next_chunk;
> >               }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/cover.1788248601.git.zihanx%40nebusec.ai

- bind cursor UAF / dangling tb2: valid
- unconditional sock_hold() on unpublished TIME_WAIT: valid
- clearing s_num on cursor mismatch: valid
- lockless cursor-membership checks: valid as a concern
- commit message overstating bind/ehash fill-under-lock: valid
- missing note that MPTCP needs the follow-up patch: valid as a
  backport note
- endless re-scan of the same bucket head: not valid as a
  guaranteed livelock; duplicate output after a rejected cursor
  is valid
