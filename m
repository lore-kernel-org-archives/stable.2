Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793135978;
	b=S0qjzad7t4FmAp3zsJFE5kfMjgOoQM43ucGx8+1eaYRQ+vr+3snjDMtk6A27lFMJtorO
	 ecn6hBmCbsy8TLi6cLc4C8nyt/SybhaYASDDWdVq2+dFKxz5VEmjHWBAL4SnLZIwRvM+8
	 kCuuf6OGWfvMChfytTEHH7PFNK6c1AfH0y6MFtrP3fV0YoPC8v5tl9uwjySQ4oyKww5VG
	 dlWcKGjCy1/VTYeZRTQGMU/vFb7WKRSGQc/E2qPZRg7ObHHkBFGs0bx3Vu+IC68yFY8ZS
	 WJSwT66z1j+fVkaskwRc63qfl2usumXdLrK7V+U0BYMMkl8Z1IDmjbj3FC232q8t6fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2foeXKI5HhfjdFWnmvOy61Mx2fvP4TtHpoQu5zpSIgU=;
	b=0huAIpP0/ivn6QvKZNKXBe6mHOeRG8UvpzQXJ58YplIXNiJ0jWTZDGojQgkchvWgM31E
	 LCCXc35kJkT+Icdgv6Y+jjn8QlknawpaACYaE592sx7vmhLW+fFe7KVo4muL1Gt0mGwn8
	 hp0XGQuij2OI7m/Hsh0+Ajla78SQciJQNLWfPpC4SJSjfnpE2mOJPnkrC7aXaXn3GI846
	 KK8K63X14hewzgHWLtw8IWZVmo7e7tUck9Kpw9kcdUz8DECX0Hw1gygpPzETte7R7h8Dh
	 LE4YMT3cN+8G/Yb2SEOCs+o8hIpFlp7FPE5dmPjV1tXEBsytDxRGKkUYc7sF8A8joSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="ol/kC9dC";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713EA606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 713EA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ol/kC9dC
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso125377b3a.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793135978; cv=none;
        d=google.com; s=arc-20260327;
        b=Jagv7Ccq+uYRzM3rlrOQGZUDZCjHT63M2IJDEQyRojKfY9rvpfzramZA1lwF3vn3KB
         eYiOmWlR6AbHm+mXlHNsqBUyyDniYWnFZDo3mUZ3S5PNjD9w5eGJBAopbqf+C1SUs2cg
         rEjwR8pXUsan2BpnjNecJ0vshwe1tafcocr39uPSinC2+Hzm/FX+xBVK5WWcDno97Rdf
         AAFNvYDZ1ZnkUSVmI9t8suM4vmcRdiKlbgxFs5i06E+QhkDFDLIYNuXWs9Rvf1s9Cgwg
         LEL99pcug2NfSHGgZzE+eXU5to28cM7dSqj62KO6v3a0yFsRj3/4EqhNFD2a1/WAEbI0
         B18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2foeXKI5HhfjdFWnmvOy61Mx2fvP4TtHpoQu5zpSIgU=;
        fh=TF8ImQsuLFQYy+Pz12lUhEviPDAOkeyfre1Vu7JIxic=;
        b=L5z5h1vRrj6jEk4e/3+YOO/436v9BFJ93zoddtshSgf+21i4FF3w+IQLWlqAdfqI+c
         +suSnoimw++HYCbB565j5Ki211pAZ/Eje3kpfJf20zVxkYO5Rcavft4UnQRE+cm0VxG/
         zGF1ewDEstVXaigPjQ0+Eo6U2F2xQT4tzJb3CFK8ZHPeCJzVIxYrdyKbsaS9FMii20h8
         SgYBWdOVZpuDCW/XYLJJDXGf13Ikar2QMIBKkiJ01ITiQGEkzSSN4mZeeVvXJYxy1vMq
         E8LG6op0PsuPWketndbMQlfLfscE7nLHQrb1BO6x/487XHdgHWrsIfgeW3JbN/Gq7hn3
         zSkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793135978; x=1793740778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2foeXKI5HhfjdFWnmvOy61Mx2fvP4TtHpoQu5zpSIgU=;
        b=ol/kC9dCChEQ6kosmgdB499IwqieWVVfJEBYu7ilxhjaARrTygNwvjE8Cdq/taQHbX
         Lq1eZD6jcLrt3Grm8rlwKSUO3OKoIgCMQqgn13qFNpyI/KW5jeLExR5K2/i175h369r8
         NlTpsOKPpN7YUP9nSiGkWXKbdG5NTHI2q8io0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135978; x=1793740778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2foeXKI5HhfjdFWnmvOy61Mx2fvP4TtHpoQu5zpSIgU=;
        b=PZjnmcBpW9ORQf16Dk4NXTqK6GWzJG29gST12c3cRL0nBN2IyKKpjWq/Rhx+sgwcs9
         gYt5+qZ3iQeLqPn77t8U6+mRXc/3MIgMo3Nun2h37narrlwnxydOCC7rK1a04EByRztP
         WyUgjEfc4NNVwl5x7/R9iIce3+j5aPj4djetpoAjrXPWqcdBwTyENfyqp2Ao/6PO4Xxg
         UwHybT7NKELDG9K7DpOmBvXaiIIaSnHuuCdo2Q+pmjtbhlZTcU0DRELrjjAM1/pxQ14x
         pRo2zyXTU34O+RfPtFvv8ugUr4G7k07CPOlejAi0qn3GhVA9njvtRDBaBpgqXAHju6PK
         r7pg==
X-Forwarded-Encrypted: i=1; AKwUvBw97MesE0vY8EnCk3w2FE/DhNOPAIYAprz4iuv5q8j3zKlcmTwguM4i1At6SZIvcjKDeE1m2NI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyy2/6S2d2jO9YN7gJI3iumxg8NP/KP9DZ0F8HpWIBoce6HkeN
	dF0N9ehLhibBsQxE5x5M8RPT+svoYhHApvJFdjKI5jWocgWFft74w8efFfanWi+kI9WwhgAWK2N
	wXC7IwkN6ngsECk/60elgfeuIDhB7GBjADL2oLs2L
X-Gm-Gg: AYBFou0Z3GtlwOvRu9t+2urNBO/F1r/t2IOOM7tG0qcHZDPMCr5w/4WnUqPLn+3qSZ/
	OpI5gJNShSJc1KbayQoevmTAJ8DNm2YExBdzARgH35WhnsHWqzuAtJtc+VNn7PYihV2xDxxMmep
	XxIqgE1MPvXrtGobzbtJ1fjiUNBhrHtXW5V7qn4cHE2RoqFwpLTVcSSxv8yOKV5YdHx926EZ8Un
	uh480ob2W6NeolTPA6wDZ5PuNOiBBiIlRCPHglMZrGAwnGTOiX1lTPZS5XWrtzmY0GLJfKKerZ5
	jNX38IIKLafNlymJfDWhZB7zWKm804rAAN1YIgM81g+u2eY7CeHUC4CUHZTymD4BbZJ+mPk9qou
	v2vivMpplUYyX5sOyhjkeohBdFkRsRCDS9hWdM+uGII4PzHlua1gSb/ShIiHTsV1FVC3lG3mAiS
	DRaLX9MV14Hpey8OE=
X-Received: by 2002:a05:6a00:2990:b0:89f:7ac5:9d54 with SMTP id
 d2e1a72fcca58-8a6e7bc8625mr360881b3a.17.1793135977752; Tue, 27 Oct 2026
 14:19:37 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com> <20261027182608.448075-1-horms@kernel.org>
In-Reply-To: <20261027182608.448075-1-horms@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 17:19:26 -0400
X-Gm-Features: AclHuK_pDsaQTWxh4T2SSdlNhdTO5YE0VenqdoWIlyhL1k03LqhWP9WpGUlrljo
Message-ID: <CAM0EoM=53FJSOSFzO6sPuHqDi4wxNPxK_mYRBveUz_Y6ks9swg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net/sched: sch_teql: fix use-after-free on
 lower qdisc drop
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, owen@verialabs.com, jiri@resnulli.us, 
	victor@mojatatu.com, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, sashiko-bot@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:29=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC=
-Y0BY.v2.r0.20261024060625-1@mojatatu.com?part=3D2

So this email was stuck at sashiko because the email fields wouldnt
allow it. Set at:
email_status: Muted, smtp_enabled: false
The same with patch 2/2

I will respond to both here. Summary is: i will not be sending an update.

For patch [1/2] net/sched: sch_teql: fix slaves_lock IRQ deadlock
The High is pre-existing and not introduced by this patch, which only
converts slaves_lock to a raw spinlock.
I have a separate fix that bounds the walk by a slave_count maintained
under slaves_lock; it will be posted after this  series gets merged.

Patch [2/2] net/sched: sch_teql: fix use-after-free on lower qdisc drop:

1) Low: agreed, the changelog is misleading (the code is intended as writte=
n).
NETDEV_TX_OK and NET_XMIT_CN are both counted as good transmits,
matching  net_xmit_eval(); any other consumed result is charged to
tx_dropped.
I don't think it warrants a respin on its own unless something even
semi-serious shows up in the code.

2) Medium: the non-rotation is pre-existing.  Before this patch the
drop path never advanced master->slaves either; it just retried the
freed skb, which is the use-after-free being fixed.
Advancing to NEXT_SLAVE(q) here is a  load-distribution improvement,
not a correctness requirement of this fix.
 IMO:   I would rather not inclued a policy change into the UAF fix; I
can send it  separately.


cheers,
jamal
> net/sched: sch_teql: fix use-after-free on lower qdisc drop
>
> This patch changes teql_master_xmit() to use dev_xmit_complete() to decid=
e
> whether a slave consumed the skb. Before, a slave such as VLAN could free
> the skb and return NET_XMIT_DROP, and the loop would keep using the freed
> skb. Consumed results other than NETDEV_TX_OK and NET_XMIT_CN are now
> charged to tx_dropped, and the function returns.
>
> Link: https://lore.kernel.org/netdev/179248763469.3135.173955932886831962=
8@kernel.org/
> Link: https://lore.kernel.org/netdev/20261023162821.GN708417@horms.kernel=
.org/
>
> > Only NETDEV_TX_OK keeps
> > the packet counted in tx_packets/tx_bytes and advances the slave; a
> > consumed result that is neither a success nor NET_XMIT_CN ends the
> > attempt and is charged to tx_dropped, so lower-qdisc drops are no longe=
r
> > reported as good transmits. NET_XMIT_CN is counted like success because
> > it can accompany acceptance of the current packet: pfifo_head_drop drop=
s
> > the old head, enqueues the current skb and returns NET_XMIT_CN.
>
> [Severity: Low]
> Is this description accurate? The code sends NET_XMIT_CN down the same
> path as NETDEV_TX_OK. So NET_XMIT_CN also advances master->slaves and
> increments master->tx_packets and master->tx_bytes. The "Only
> NETDEV_TX_OK" sentence seems to contradict the NET_XMIT_CN sentence that
> follows it, and the v1 -> v2 notes say the same thing.
>
> Several qdiscs also drop the current skb and still return NET_XMIT_CN.
> One example is noop_enqueue():
>
>         dev_core_stats_tx_dropped_inc(skb->dev);
>         __qdisc_drop(skb, to_free);
>         return NET_XMIT_CN;
>
> Another is red_enqueue():
>
>         qdisc_drop_reason(skb, sch, to_free, reason);
>         return NET_XMIT_CN;
>
> choke, gred, fq_pie and sfb behave the same way. When a VLAN or macvlan
> slave sits on top of one of these, teql would still count those drops as
> good transmits in tx_packets and tx_bytes.
>
> Treating NET_XMIT_CN as success matches net_xmit_eval() and
> vlan_dev_hard_start_xmit(), so the code choice is probably fine. Could
> the commit message drop the "Only NETDEV_TX_OK" wording? It also says
> that lower-qdisc drops "are no longer reported as good transmits", which
> does not hold for these qdiscs.
>
> > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > index 6764f0dd38dfb..70c948a26f809 100644
> > --- a/net/sched/sch_teql.c
> > +++ b/net/sched/sch_teql.c
> > @@ -360,12 +360,18 @@ static netdev_tx_t teql_master_xmit(struct sk_buf=
f *skb, struct net_device *dev)
> >               case 0:
> >                       if (__netif_tx_trylock(slave_txq)) {
> >                               unsigned int length =3D qdisc_pkt_len(skb=
);
> > +                             int rc =3D NETDEV_TX_BUSY;
> >
> >                               skb->dev =3D slave;
> > -                             if (!netif_xmit_frozen_or_stopped(slave_t=
xq) &&
> > -                                 netdev_start_xmit(skb, slave, slave_t=
xq, false) =3D=3D
> > -                                 NETDEV_TX_OK) {
> > -                                     __netif_tx_unlock(slave_txq);
> > +                             if (!netif_xmit_frozen_or_stopped(slave_t=
xq))
> > +                                     rc =3D netdev_start_xmit(skb, sla=
ve, slave_txq, false);
> > +                             __netif_tx_unlock(slave_txq);
> > +                             if (dev_xmit_complete(rc)) {
> > +                                     if (rc !=3D NETDEV_TX_OK && rc !=
=3D NET_XMIT_CN) {
> > +                                             master->tx_dropped++;
> > +                                             rcu_read_unlock();
> > +                                             return NETDEV_TX_OK;
> > +                                     }
>
> [Severity: Medium]
> Should this drop path also move master->slaves on to NEXT_SLAVE(q)
> before it returns?
>
> Only the success block below and the case 1 path rotate master->slaves.
> Every call to teql_master_xmit() starts from the same pointer:
>
>         start =3D rcu_dereference(master->slaves);
>
> If a slave keeps returning NET_XMIT_DROP or a negative errno, each later
> packet would go to that slave first and be dropped. The other slaves
> would never be tried.
>
> A VLAN slave can do this for a long time. vlan_dev_hard_start_xmit()
> returns the raw dev_queue_xmit() result and never stops its own queue:
>
>         ret =3D dev_queue_xmit(skb);
>         ...
>         return ret;
>
> So neither the netif_xmit_stopped() check nor the netif_running() check
> would skip it. macvlan_start_xmit() behaves the same way. This can
> happen when the lower device has a pfifo with limit 0, a full fifo or
> tbf, or an egress tc or netfilter drop.
>
> When a slave is busy, teql retries the same skb on the next slave. A
> dropped skb can't be retried, so without rotation the drops build up on
> one slave. If that slave drops every packet, is all traffic through the
> teql master lost?
>
> The case 1 path already rotates master->slaves after the skb is consumed
> by neighbour queueing:
>
>         case 1:
>                 raw_spin_lock_irqsave(&master->slaves_lock, flags);
>                 if (rcu_dereference_protected(master->slaves, ...) =3D=3D=
 q)
>                         rcu_assign_pointer(master->slaves, ... NEXT_SLAVE=
(q) ...);
>
> Would doing the same rotation here keep traffic spread across the slaves?
>
> >                                       raw_spin_lock_irqsave(&master->sl=
aves_lock, flags);
> >                                       if (rcu_dereference_protected(mas=
ter->slaves,
> >                                                                     loc=
kdep_is_held(&master->slaves_lock)) =3D=3D q)
>
> [ ... ]
