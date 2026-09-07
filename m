Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC613783C6
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 04:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756562; cv=pass; b=ovHoOMOd+pMQijuuurhpZhbKqtXY41zlFZ8JWN/iW7MWvoyM+RZtmS24Qf7rNtcubRAs/WfjXpD3aI9QB4mI2f91azT5ozFujavIaBXWho3qL9R3C6EDzWU0Nnt2zmy60JMhWV4j/NgMz/2wMe170A1MKq3sz5Yha+Ler2+pb+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756562; c=relaxed/simple;
	bh=4a+m0nUMf7To+f+QbBYuCxxGnkIf/JVqeGIfkyRz3gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7PulTGsk136LJngKb9uxsmXocHgIAi+neRHEuIfIk2JxtoGASk4tTLYG/5EAZpHnI9Q1jjPdu1AUojG6RhMFlKZifU6B6SItdu8g9brOLVQae6sx172X0ypIKTnBrH6OhBuBSyZ89EUeJ+0aS7LZQAgwqHmZwl+zaXI1ez4Ai0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Qz2wQrJR; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Qz2wQrJR"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so32036481fa.1
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 21:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788756558; cv=none;
        d=google.com; s=arc-20260327;
        b=Po+k1/FvVzdnG0HtbE/HLt0o6deakReryNyHD+hMoZopZ0KBBakukGfXwE8DlpK8G8
         NcGmbNYKxteB2nGt5s/7ApXAnwwg4T4vvVgJkOVrOt12/gBRubDZkOEtOPCyPAeNm/63
         NRBPj7t/Jj5JzgiX8uKCdVgTzTgHMq3hhLPP8UYQIIm/4bhsNk7F1BWYRB5b478NGo8n
         ssVvC7L85wY8zhGdlPxuEIAc04EYTXhZCGlm5V+GpvzvloAfuzqa9Yx/wQkGCcY9yUtc
         ydRJIsixN2MTto1FL+HVYByJiW/7FCeXhBBrGeEUrEogwnoZZHYs72sFt5uu5zAWGbpu
         rT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BHVfyifgaW3rIwFNS4IEU0sZK0EOa76cPRMqsXLt5dE=;
        fh=yME4gkCkDKDaSBiLxgSFFrOMhx/TG61mGeDoPQWCyGY=;
        b=bKBSCQqjE3JPIyitFj40jvQVInN77mmSi04wrzeGpgqTEWf2J2fJ0F+TCd0gN606SC
         iOt0kfGtDg/to/4YbQeWZZh884dyNaE/C89wgd421XeSvl8EheuV+ql3x7PCrBanrdez
         u9SZUAV6J0s8kCNye4jtaUWulv7AQmmWHlCObdHzXNZ2hau5322kGwIJ30Y57maeo6X7
         VH+jQ3WE2NLf0u2WesH5PekehtlN8SdmkWTvQ9KGAtNoj0Ph2GMyTBuze2din4j9HnuQ
         8N3jmWRFcNrm9XxK/tsJj5Q8vK+2A8VLaUVrSLZFTNT2f/MQYFW7wotlbXUKxWVy5dIV
         3NmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788756558; x=1789361358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BHVfyifgaW3rIwFNS4IEU0sZK0EOa76cPRMqsXLt5dE=;
        b=Qz2wQrJRwvwxLE/BppooxKPzmK6flSw1cINUXUDwi60RlDPBMa2QUR9HfpFxjomWYr
         wYU3VSiLQErsMcqyWYeM1xVhJ20+6/j5/RUEELOSsR5mvSO+rDBYlKWvGiulOX4S/Ltt
         smiFMD0DfP93gLWyBtpk/T7naRDCOPhtbCJLiYyjTcyjrPsiGL4NT+Mn5LH2L7SGilet
         c//Fu4+LIjCBQiYzlXX6vU8ch8SZm5q7Fl/o9JxGxER0YOlOu//O+NQcvsl01xY5M+j1
         5tJHkV6gIdmEUgYtXNVbjyj0qsSEgAPgFeDY+6wfbSKLG3fVsd/m+qRr9QAXKhiPc6oj
         ZxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756558; x=1789361358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BHVfyifgaW3rIwFNS4IEU0sZK0EOa76cPRMqsXLt5dE=;
        b=RcmleFy0oj6wx1yGmQ1+bnvq4zwYuU0bxpekxpgYhJyvCSWVhFNC9vSEmYyICp/K7O
         EGmHOPh+PW48IXpGJpOprSc15wajQFngn/RcieLKeyejCnFJNWZaSNF7rw0iH3+vicgP
         Ci7G0pM0HhzeP0uKJjn7Xur767TxIk/HxBOUuGz0ZgqztWxl/gemDxGrtdkp39ld2brL
         sgwnBzRR+v4Y7+dGcbOkf9ro+zQImR4srKTcoUNlLNvuYUCJlyoIiGDT1aisYXrPvtrJ
         QeuCPVxxsPtJNFaYML89RTgQoXn9PBvw3OeZoUeGF/I2oV03pHSCTXBOqILghKSrDPN5
         eBXA==
X-Forwarded-Encrypted: i=1; AKwUvBzcghF/q7J609Yv1q6/0PvtsndwHx6P3uFz0t5c3FHK3tuNt4Zs6qQxuclkcjyCyCuxTb5kQiU=@vger.kernel.org
X-Gm-Message-State: AFuF++mu0TYt5pdqaUp9hsOgfH/g0RsvKVuy2+TTpQmcxKXolipDhTmW
	qWV600thD7BBets9egLXTIyp4OPmotBIuUm8MgKP+xH5A9F7XXeB54jdYCE8IOKowOGTZwSZ43V
	w6Ll9/kg+4jLhgGwhef8+MiusD6WCzPSOSXaxVy2JlC4=
X-Gm-Gg: AYBFou0WniLk08ftZtMeOvlO3UHJ0S1TlE7hVseXzCAu3tfW55BMNHUqA8pjXTk3+Ua
	A1nDpUyyFismUdfx8ZuG6B9GH5QzHjKAQyyuTHYNzZPNCvCcTiq4zuLTy3PCrIsMMYkwsW6Uc1c
	3rUZqiSZJPRkrP/Nx6Mt38A6rRN40vgiHaYgmpfkcS0LPz7soFLetoB9xnZFWcrJScKc/O/XKMl
	PNQwgMu5UmA0iwiFym+6Z6D/vvg5qYsfCyWFDkNMqWvnbE67YQbRK1Dz9mUGYy4Do+JKSln4kN1
	ATfRTshWPTN9/i0eMTtKKCibLx8JNrTcQvFMdJu6PJJzXbzF5fZ/3iW/Cm7j5T0jHgJ87FlNxpY
	=
X-Received: by 2002:a2e:a808:0:b0:3a3:364:f783 with SMTP id
 38308e7fff4ca-3a35b5ee8dcmr27990621fa.11.1788756558095; Sun, 06 Sep 2026
 21:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
 <178875495568.219967.11621753663025675535@kernel.org>
In-Reply-To: <178875495568.219967.11621753663025675535@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 12:49:07 +0800
X-Gm-Features: AcwNN1V2ewuj06MBLkUFsxxzuExG1XuLJXINLUPg6wVvERHAMZf95XYnMI64nCU
Message-ID: <CAANe3eTFpY9i9xoVK1zsX+uSxUjGG-jH9RP7xNEofHbK1Zfxkw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] mptcp: diag: bound listener bucket lock hold
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
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 3 =C2=B7 Low: 2
>
> - [High] Use-after-free introduced by the new deferred processing loop in
>   mptcp_diag_dump_listeners().
> - [Medium] The patch silently changes which MPTCP listeners the dump
>   reports, and the commit message does not mention it.
> - [Medium] mptcp_diag_dump_listeners() mixes two incompatible counting
>   bases for the resume index diag_ctx->l_num.
> - [Medium] mptcp_diag_dump_listeners() performs all
>   identity/authorization checks on the parent MPTCP socket=E2=80=A6
> - [Low] Commit message of "mptcp: diag: bound listener bucket lock hold"
>   carries Fixes: 4fa39b701ce9 + Cc: stable + Reported-by:, but never=E2=
=80=A6
> - [Low] In the new post-lock loop of mptcp_diag_dump_listeners()
>   (net/mptcp/mptcp_diag.c), `tmp =3D ctx ?
>
> --
>
> mptcp: diag: bound listener bucket lock hold
>
> This reworks mptcp_diag_dump_listeners() so that the listener bucket lock=
 is
> only held while collecting up to MPTCP_DIAG_BULK_SZ referenced listener
> sockets, with the ULP/property re-checks, the parent msk reference and
> sk_diag_dump() moved outside the lock.  A referenced dump cursor is kept =
in
> cb->data so later batches resume after the previous listener instead of
> rescanning the bucket prefix.
>
> v1 Link: https://lore.kernel.org/all/cover.1785307984.git.zihanx@nebusec.=
ai/
>
> > diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
> > index 6ccd32bc48f91..4859e77a28c7a 100644
> > --- a/include/linux/inet_diag.h
> > +++ b/include/linux/inet_diag.h
> > @@ -39,6 +39,7 @@ enum inet_diag_dump_cursor_type {
> >       INET_DIAG_DUMP_CURSOR_TCP_LISTEN,
> >       INET_DIAG_DUMP_CURSOR_TCP_BIND,
> >       INET_DIAG_DUMP_CURSOR_TCP_EHASH,
> > +     INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN,
> >  };
>
> [Severity: Low]
> Two questions about the changelog for this one.
>
> First, the message says the lock hold time "can therefore grow with the
> number of sockets visited", but it never states the observed symptom.  Wa=
s
> this a soft lockup, an RCU stall, or measured contention on ilb->lock?  G=
iven
> the Fixes: 4fa39b701ce9 and Cc: stable tags plus the Reported-by:, could =
the
> symptom be spelled out?
>
> Second, could the backport dependency be mentioned?  enum
> inet_diag_dump_cursor_type does not exist in the tree this applies on top=
 of:
>
>   git grep inet_diag_dump_cursor_type <base>   -> no match
>
> The whole enum, cb_data->dump_cursor, dump_cursor_slot, dump_cursor_type =
and
> inet_diag_dump_clear_cursor() come from the immediately preceding patch o=
f
> this series, "tcp: diag: bound bucket lock hold in tcp_diag_dump()".  Sta=
ble
> trees carrying 4fa39b701ce9 cannot take this patch on its own, and nothin=
g in
> the message says so.
>
> > diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> > index 136c2d05c0eeb..37b33ea5d79de 100644
> > --- a/net/mptcp/mptcp_diag.c
> > +++ b/net/mptcp/mptcp_diag.c
> > @@ -12,6 +12,19 @@
> >  #include <net/netlink.h>
> >  #include "protocol.h"
> >
> > +/* Process a bounded number of listeners per bucket lock hold. */
> > +#define MPTCP_DIAG_BULK_SZ 16
> > +
> > +static void mptcp_diag_save_cursor(struct inet_diag_dump_data *cb_data=
,
> > +                                unsigned int slot, struct sock *sk)
> > +{
> > +     sock_hold(sk);
> > +     inet_diag_dump_clear_cursor(cb_data);
> > +     cb_data->dump_cursor =3D sk;
> > +     cb_data->dump_cursor_slot =3D slot;
> > +     cb_data->dump_cursor_type =3D INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN;
> > +}
> > +
>
> [ ... ]
>
> > @@ -84,64 +98,102 @@ static void mptcp_diag_dump_listeners(struct sk_bu=
ff *skb, struct netlink_callba
> >       hinfo =3D net->ipv4.tcp_death_row.hashinfo;
> >
> >       for (i =3D diag_ctx->l_slot; i <=3D hinfo->lhash2_mask; i++) {
> > +             struct sock *tmp, *sk, *sk_arr[MPTCP_DIAG_BULK_SZ];
> >               struct inet_listen_hashbucket *ilb;
> > +             int num_arr[MPTCP_DIAG_BULK_SZ];
> >               struct hlist_nulls_node *node;
> > -             struct sock *sk;
> > -             int num =3D 0;
> > +             int accum, idx, num, ret;
> > +             struct sock *cursor;
> > +             bool use_cursor;
> >
> > +resume_listen_walk:
> > +             num =3D 0;
> > +             accum =3D 0;
> >               ilb =3D &hinfo->lhash2[i];
> > +             ret =3D 0;
> >
> >               rcu_read_lock();
> >               spin_lock(&ilb->lock);
> > -             sk_nulls_for_each(sk, node, &ilb->nulls_head) {
> > -                     const struct mptcp_subflow_context *ctx =3D mptcp=
_subflow_ctx(sk);
> > -                     struct inet_sock *inet =3D inet_sk(sk);
> > -                     int ret;
> > -
> > -                     if (num < diag_ctx->l_num)
> > -                             goto next_listen;
> > -
> > -                     if (!ctx || strcmp(inet_csk(sk)->icsk_ulp_ops->na=
me, "mptcp"))
> > -                             goto next_listen;
> > -
> > -                     sk =3D ctx->conn;
> > -                     if (!sk || !net_eq(sock_net(sk), net))
> > -                             goto next_listen;
> > -
> > -                     if (r->sdiag_family !=3D AF_UNSPEC &&
> > -                         sk->sk_family !=3D r->sdiag_family)
> > -                             goto next_listen;
> > -
> > -                     if (r->id.idiag_sport !=3D inet->inet_sport &&
> > -                         r->id.idiag_sport)
> > +             cursor =3D cb_data->dump_cursor;
> > +             use_cursor =3D cursor &&
> > +                          cb_data->dump_cursor_type =3D=3D
> > +                          INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN &&
> > +                          cb_data->dump_cursor_slot =3D=3D i &&
> > +                          inet_sk_state_load(cursor) =3D=3D TCP_LISTEN=
 &&
> > +                          !hlist_nulls_unhashed(&cursor->sk_nulls_node=
) &&
> > +                          cursor->sk_nulls_node.pprev !=3D LIST_POISON=
2 &&
> > +                          inet_lhash2_bucket_sk(hinfo, cursor) =3D=3D =
ilb;
> > +             node =3D use_cursor ? cursor->sk_nulls_node.next :
> > +                                 ilb->nulls_head.first;
> > +             hlist_nulls_for_each_entry_from(sk, node, sk_nulls_node) =
{
> > +                     if (!use_cursor && num < diag_ctx->l_num)
> >                               goto next_listen;
>
> [Severity: Medium]
> Are the two resume mechanisms here using the same counting base for
> diag_ctx->l_num?
>
> This test counts entries from the bucket head, but at resume_listen_walk =
num
> is reset to 0 and, when use_cursor is true, the walk starts at
> cursor->sk_nulls_node.next, i.e. mid-bucket.  The values stashed in num_a=
rr[]
> and later stored are therefore cursor-relative and bounded by 0..15:
>
>         if (ret >=3D 0) {
>                 ret =3D sk_diag_dump(tmp, skb, cb, r, net_admin);
>                 if (ret < 0)
>                         num =3D num_arr[idx];
>         }
>         ...
>         if (ret < 0) {
>                 diag_ctx->l_slot =3D i;
>                 diag_ctx->l_num =3D num;
>                 return;
>         }
>
> Walking a bucket with more than 16 matching listeners:
>
>   batch 1: 16 listeners dumped, cursor saved on e15
>   goto resume_listen_walk with diag_ctx->l_num =3D 0, use_cursor true, so=
 num
>     now counts from e16
>   skb fills at idx 5, so diag_ctx->l_num =3D 5 while the real bucket offs=
et
>     is 21
>   the cursor socket is closed before the next recvmsg(), use_cursor becom=
es
>     false, and the walk resumes at bucket position 5
>
> Does that re-emit e5..e19, and, if entries were removed in the meantime a=
nd
> positions shifted, silently drop listeners that were never reported?
>
> The peer implementation of the same cursor protocol from the preceding pa=
tch,
> tcp_diag_dump(), zeroes the positional counter when the cursor is unusabl=
e:
>
>         node =3D use_cursor ? cursor->sk_nulls_node.next : ilb->nulls_hea=
d.first;
>         if (!use_cursor)
>                 s_num =3D 0;
>
> Should mptcp_diag_dump_listeners() do the same so the two bases are never
> mixed?  The intra-call restart also forces diag_ctx->l_num =3D 0 before g=
oto
> resume_listen_walk, so a cursor invalidated between lock drops restarts t=
he
> bucket at the head within a single dump call.
>
> >                       if (!refcount_inc_not_zero(&sk->sk_refcnt))
> >                               goto next_listen;
> >
> > -                     ret =3D sk_diag_dump(sk, skb, cb, r, net_admin);
> > -
> > -                     sock_put(sk);
> > -
> > -                     if (ret < 0) {
> > -                             spin_unlock(&ilb->lock);
> > -                             rcu_read_unlock();
> > -                             diag_ctx->l_slot =3D i;
> > -                             diag_ctx->l_num =3D num;
> > -                             return;
> > -                     }
> > -                     diag_ctx->l_num =3D num + 1;
> > -                     num =3D 0;
>
> [Severity: Medium]
> Removing this "l_num =3D num + 1; num =3D 0;" pair changes which listener=
s the
> dump reports, and the changelog does not mention it.
>
> In the pre-patch loop the skip test was "if (num < diag_ctx->l_num)" whil=
e
> num was reset to 0 after every successful dump and l_num kept growing, so=
 for
> a bucket e0..e6 the emitted set was e0, e1, e3, e6:
>
>   e0 dumped -> l_num =3D 1, num =3D 0 then ++num =3D 1
>   e1 dumped -> l_num =3D 2, num =3D 1
>   e2 hits 1 < 2 and is skipped
>   e3 dumped -> l_num =3D 3
>   e4, e5 skipped
>
> The new code keeps num monotonic and applies the skip test only in the
> non-cursor fallback, so every collected listener is processed.  Is that t=
he
> actual user-visible defect being fixed here?  ss -Ml output changes (more
> listeners reported) on any host with three or more MPTCP listeners hashin=
g
> into the same lhash2 bucket, and this seems worth stating in the message,
> along with whether it belongs in the same patch as the lock-hold change.
>
> > +                     num_arr[accum] =3D num;
> > +                     sk_arr[accum] =3D sk;
> > +                     if (++accum =3D=3D MPTCP_DIAG_BULK_SZ)
> > +                             break;
> >  next_listen:
> >                       ++num;
> >               }
> >               spin_unlock(&ilb->lock);
> >               rcu_read_unlock();
> >
> > +             for (idx =3D 0; idx < accum; idx++) {
> > +                     const struct mptcp_subflow_context *ctx;
> > +                     const struct tcp_ulp_ops *ulp_ops;
> > +                     struct inet_sock *inet;
> > +
> > +                     sk =3D sk_arr[idx];
> > +                     rcu_read_lock();
> > +                     ctx =3D rcu_dereference(inet_csk(sk)->icsk_ulp_da=
ta);
> > +                     ulp_ops =3D READ_ONCE(inet_csk(sk)->icsk_ulp_ops)=
;
> > +                     inet =3D inet_sk(sk);
> > +                     tmp =3D ctx ? ctx->conn : NULL;
>
> [Severity: High]
> Can this read freed memory?  The rcu_read_lock() here is entered after
> spin_unlock(&ilb->lock) and rcu_read_unlock() above, so it cannot extend =
a
> grace period that already started.
>
> The collection loop only took sk_refcnt on the listener subflow, which do=
es
> not keep the ULP context alive:
>
>   __tcp_close()
>     tcp_set_state(sk, TCP_CLOSE)
>     inet_unhash(sk)               /* takes ilb->lock, free once diag drop=
s it */
>     inet_csk_destroy_sock()
>       sk->sk_prot->destroy(sk)
>         tcp_v4_destroy_sock()
>           tcp_cleanup_ulp()
>             subflow_ulp_release()
>
> and net/mptcp/subflow.c:subflow_ulp_release() drops the msk reference and
> frees the context:
>
>         sk =3D ctx->conn;
>         if (sk) {
>                 ...
>                 sock_put(sk);
>         }
>         mptcp_subflow_ops_undo_override(ssk);
>         if (release)
>                 kfree_rcu(ctx, rcu);
>
> net/ipv4/tcp_ulp.c:tcp_cleanup_ulp() clears only icsk_ulp_ops:
>
>         if (icsk->icsk_ulp_ops->release)
>                 icsk->icsk_ulp_ops->release(sk);
>         module_put(icsk->icsk_ulp_ops->owner);
>
>         icsk->icsk_ulp_ops =3D NULL;
>
> icsk_ulp_data is never unpublished on this path (subflow_ulp_fallback() d=
oes
> rcu_assign_pointer(icsk->icsk_ulp_data, NULL), this path does not).  If
> kfree_rcu(ctx) was queued before this loop iteration re-entered
> rcu_read_lock(), the grace period does not cover this reader, so
> rcu_dereference(inet_csk(sk)->icsk_ulp_data) can return a freed and reuse=
d
> slab object, and ctx->conn is dereferenced before the !ulp_ops guard is e=
ven
> evaluated.
>
> The loop is also preemptible for up to 15 preceding sk_diag_dump() /
> inet_diag_bc_sk() invocations with request-supplied bytecode, which widen=
s the
> window.  Does the commit message claim ("After dropping the lock, read
> icsk_ulp_data with rcu_dereference()") hold here, or do ctx and the paren=
t msk
> reference have to be acquired while ilb->lock is still held, as the pre-p=
atch
> code did?
>
> [Severity: Low]
> Separately, is it intentional that ctx->conn is loaded before the check t=
hat
> the ULP is actually "mptcp"?  The collection loop under ilb->lock no long=
er
> filters by ULP at all, so listeners with a foreign ULP context now reach =
this
> loop, and the read happens at offsetof(struct mptcp_subflow_context, conn=
)
> inside an object of an unrelated type.
>
> net/xfrm/espintcp.c:espintcp_init_sk() publishes its own object with
> rcu_assign_pointer(icsk->icsk_ulp_data, ctx) and, unlike tls_init(), has =
no
> TCP-state restriction, so an unprivileged setsockopt(TCP_ULP, "espintcp")
> followed by listen() puts such a socket into lhash2.
>
> struct espintcp_ctx is larger than that offset today, so the read stays i=
nside
> the allocation and the loaded value is discarded by the failing strcmp().
> Still, the pre-patch code did the strcmp() first and never touched a fore=
ign
> context.  Could the ctx->conn load be moved after the ULP name check?
>
> > +                     if (!ctx || !ulp_ops || strcmp(ulp_ops->name, "mp=
tcp") ||
> > +                         !tmp || !net_eq(sock_net(tmp), net) ||
> > +                         (r->sdiag_family !=3D AF_UNSPEC &&
> > +                          tmp->sk_family !=3D r->sdiag_family) ||
> > +                         (r->id.idiag_sport !=3D inet->inet_sport &&
> > +                          r->id.idiag_sport) ||
> > +                         !refcount_inc_not_zero(&tmp->sk_refcnt)) {
> > +                             rcu_read_unlock();
> > +                             goto processed_listener_sk;
> > +                     }
> > +                     rcu_read_unlock();
> > +                     if (ret >=3D 0) {
> > +                             ret =3D sk_diag_dump(tmp, skb, cb, r, net=
_admin);
> > +                             if (ret < 0)
> > +                                     num =3D num_arr[idx];
> > +                     }
> > +                     sock_put(tmp);
>
> [Severity: Medium]
> Does this need a re-validation after refcount_inc_not_zero(&tmp->sk_refcn=
t)?
>
> All the identity and scoping checks on the parent msk (net_eq(sock_net(tm=
p),
> net), sdiag_family, idiag_sport) run before the reference is taken, and
> nothing is re-checked afterwards.  mptcp_prot uses SLAB_TYPESAFE_BY_RCU:
>
> net/mptcp/protocol.c:
>         .slab_flags     =3D SLAB_TYPESAFE_BY_RCU,
>
> so rcu_read_lock() only guarantees type stability, not identity.  If
> subflow_ulp_release() already dropped the last reference via
> sock_put(ctx->conn), the object can be recycled as a different MPTCP sock=
et
> inside this reader's RCU section, refcount_inc_not_zero() then succeeds, =
and
> sk_diag_dump(tmp, ...) serializes that socket's addresses, ports, uid, co=
okie
> and state into the reply, possibly from another namespace.
>
> The in-tree pattern for this slab, net/mptcp/token.c:mptcp_token_get_sock=
(),
> re-checks after the acquisition:
>
>         if (!refcount_inc_not_zero(&sk->sk_refcnt))
>                 goto not_found;
>
>         if (READ_ONCE(msk->token) !=3D token ||
>             !net_eq(sock_net(sk), net)) {
>
> Should the same re-check be done here?  Pre-patch the conn read and the m=
sk
> refcount acquisition both happened under ilb->lock with the subflow still
> hashed, so the reference held by ctx was still alive.
>
> > +processed_listener_sk:
> > +                     if (ret >=3D 0)
> > +                             mptcp_diag_save_cursor(cb_data, i, sk);
> > +                     sock_put(sk);
> > +             }
> > +
> > +             if (ret < 0) {
> > +                     diag_ctx->l_slot =3D i;
> > +                     diag_ctx->l_num =3D num;
> > +                     return;
> > +             }
> > +
> >               cond_resched();
> > +
> > +             if (accum =3D=3D MPTCP_DIAG_BULK_SZ) {
> > +                     diag_ctx->l_num =3D 0;
> > +                     goto resume_listen_walk;
> > +             }
> > +
> > +             inet_diag_dump_clear_cursor(cb_data);
> >               diag_ctx->l_num =3D 0;
> >       }
> >
> > +     inet_diag_dump_clear_cursor(cb_data);
> >       diag_ctx->l_num =3D 0;
> >       diag_ctx->l_slot =3D i;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/cover.1788248601.git.zihanx%40nebusec.ai

- UAF on icsk_ulp_data/ctx after dropping ilb->lock: valid
- mixing cursor-relative and absolute l_num: valid
- dropping "l_num =3D num + 1; num =3D 0" changes the reported set:
  valid as a behavior change, not a regression
- no re-check after msk refcount_inc_not_zero(): valid for the
  lockless path
- changelog/stable dependency on 0001: valid as documentation
- loading ctx->conn before the ULP name check: valid as ordering,
  not currently an OOB
