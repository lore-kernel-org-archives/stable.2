Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E23E1CFD
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097580; cv=pass; b=F//Ebng50mOQNH4Zx6nzeKVVJRxc/UHp4deoG5Y5oNVFojvEHvkY6TiVx3Dqbfm/gVvM4pSuBq0cKGZvooolwrh0guKyv64KMJFRJxbFKu0k6FxTjA9cz/QHCESVsbO7FN0+1zxpzh7I0RC5YlRHdpRT37qWEEEdSf0eTsSQlB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097580; c=relaxed/simple;
	bh=hxk1QMVCnerU7l4ILDOHxLnF1/4FmNo059jIytcT46c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9Sc4DsBcmGe5qS3RPhSn1Y3eskp8rbWgtXVo17Yjzgh/dySBg1qsCeRxzVaFmT+Pu6CTD302GXH0MM/4Jg9y9W18gdbi029NkjYRScei8stqqWVNu5hWtR7rd8m25g4F7eDlpQ8ZKoy3Ek3ZcWKzTuiFgAcU4aFH8vsdaehTSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=zDwmN2aI; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="zDwmN2aI"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8520161fdb9so1306626b3a.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792097577; cv=none;
        d=google.com; s=arc-20260327;
        b=nEb4CDiEW+DY/j1NbHHDmyow1zjeKI2Cj9yiKcxVADMgwG20J+wWFCUYt8JSrMwTQ4
         znaeZVhxcljsmEeaH+7jDnLHIQHrbGRcAsFx8cXDNgrrv34+vLxmtL0SqONPux9+kI1k
         Oc+6vFG+1e+dUKKR7oQfPcLtogUp9sh6uUIwS9Wt7fXTlAetXlYv9C4rSc1qgT5ECzMe
         gvDeUt4UBaCUXLLheDpAGtZxHRKIpgwshqOw2+rWcKl8ZIaTTrkP3zRSM3bvCbxqsAsz
         Q9j+bRXRw9JB54N54vaDTuD2F5ZOAlGa8IuKmeaef7gbj9T+q5sf85Wjp7HkfiMq1w0g
         nD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkbHSewuQzHgrEOAh/Je4EyN3spZzIcJcFtwymdbPB8=;
        fh=RxWEtJKAgsMDJXr4Nq9Cafd/fZXFjWHTX1tW/H98jJc=;
        b=dbB9GEshAa8rS7TBtQtf4ukV7+DHY067I5ec5FAsH6M7hY1/7/VgSECPeoIanyM7qx
         ocGq71804DpUdgQlhqj+qPZ8rU6FZsSIV1hChokFwS7wyvuEzV9qm5mlFPR8K9TxI2+q
         0yufgw0sjaGkuIyyyJfJ3r9eTVZ+5YH7sPbGu/Pf5T3UAaj4CvurNh7zO03X2d2hwBUs
         nhxvdU74odOk0d9fFqTlYjCdW0jy4GliVABTmU8QS7R+cqmf8OFGCH8PTcfN0ei9NTQ3
         vEDioMLd9xpi7m+btT6PZ4IaVOyL9dB830jAwg57uuv8mYwsDoha90Cp8rEJBE8Lyw7u
         uErA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792097577; x=1792702377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jkbHSewuQzHgrEOAh/Je4EyN3spZzIcJcFtwymdbPB8=;
        b=zDwmN2aI33byk49i0k+0Tbs+be4tyoIiwisrHCykGmnNzN5Vlz+L1o+lsOUXwHBgtz
         fMPl8Nt9yew6NbZVwBQocwHDfkcliGfGf8HVxWLx4snSRU5Rf7C5KZa9fXF87dApVkPj
         IwK9Clflold6Bjf8bhg8y1ic6aEDGqcN/Fodw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097577; x=1792702377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkbHSewuQzHgrEOAh/Je4EyN3spZzIcJcFtwymdbPB8=;
        b=gAKg/1r3wqf50BoWCQQArO3E1A8U+FSYdmlNO4UM0EYMch/V3XXuEns+te/MMps6V0
         LQ+sdOsZWhlsuYmZIe5ZfEYHUqvnt+0ThC9o+pqu2Gol25RhJfVZM9wcQQe5dcfn74Ri
         5eNUGkg/cd0UmT8FlNgdI26JOstsiq407PxF3ImonUdJwSqdy+4q2SwcRKx/ZtJweEWd
         VIYVbL3hy4BA2wFrHojRPUYJYhmp0Mu/RIhso5AblrHyLPWlaE7xjiuUbwa/8QNNMJk8
         m+FECkffIjkFOhBxAY1n2NdGVOycHBgc76zmXhdPGVQNyZpMm5E1xZzXa1nPuxRHH01x
         7U/Q==
X-Forwarded-Encrypted: i=1; AKwUvByUDzYsxK/lHYPgLiVlOW7Ae6dkFT+6m1bmeAN0f+wQXmuo7JnSgcUFnILI3Ts3dZIS9m69Y1Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1G4X0h+R8GcOeulzwOz2s2We7wAfgm4xtDvni1Fd6mCUFefsX
	cG6dXlPXARRYpyt0lOMRWpvC6xLeI4Gq/331NTAOE/M+kED+y57OkCcOj/3po3Hs06pMhHAtoAq
	vvbEPgxbMPLAKIsXfb7ef0/GmfUK2SLYsfBl6pgFn
X-Gm-Gg: AYBFou3S3O2PZHvtHZxAvfVKx4iy2Axe31vIDcCw/uRDTDhf0Cm1M7uKrDOlIj8MuA8
	N9uabdmv0fUbeCdscf0cMDaw0WvCId+nARh6Ghq9ZjQLkVGQ8TLDIaIy4HNwRsu/a5B4qtSCssI
	wJ86bOMCbtRMyAEyzxdpKcsgp9N+UKp2v220KVBJuEEovuaWT2W85NH34PBAs6NSkKg7BONsvI5
	S2JOfUvTJcQ8PZBX7PUDdY6OJGzQ7jn22TjH2C7wSwJXtEx7EUMzK6K+ihhAhcZsJM26VSUg6zB
	J7XEPTyx5qGII6GZUmg7wD8bsJNXyS+hXncJbDyjzzeTpoIAOyjX8LhU/EB3yVrAZHkk3oV10Cp
	wqSOicepOwjeyuzNlbH2ExtH9Fc358vjQyLGwdZKISNfn
X-Received: by 2002:a05:6a20:6f89:b0:3e1:c08e:38f1 with SMTP id
 adf61e73a8af0-3e1c08e7cedmr10140367637.14.1792097576957; Thu, 15 Oct 2026
 13:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-MD1X.v2.20261009135842@mojatatu.com> <20261015125822.GH83879@horms.kernel.org>
In-Reply-To: <20261015125822.GH83879@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 15 Oct 2026 16:52:44 -0400
X-Gm-Features: AclHuK-3WqmxRH2VJ4NQkGPyh93QYe2dksXJg7Bq6GKxJGeNOPh9iFVtk_DYmvc
Message-ID: <CAM0EoMnhmww2koBL+V0fgKg4qp=3E2Bf23iUSyxtoBPYbYi0Wg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Sashiko <sashiko-bot@kernel.org>, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 8:58=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Oct 09, 2026 at 02:09:03PM -0400, Jamal Hadi Salim wrote:
> > This issue was caught by Sashiko (nipa). A producer-side path cap is
> > already merged (ea4d4b5dddb5); this patch adds the matching consumer-si=
de
> > cap.
> >
> > The issue:
> > The tx queue is picked and capped in netdev_core_pick_tx(), before the
> > __dev_xmit_skb() qdisc enqueue path. A tc BPF program running inside
> > egress qdisc (not clsact) can then change __sk_buff->queue_mapping;
> > that store is never re-checked. bpf_convert_ctx_access() bounds it only
> > by NO_QUEUE_MAPPING, not by the device's queue count.
> >
> > On dequeue, qdisc_restart() calls netdev_get_tx_queue(), which
> > indexes dev->_tx[] with that value. netdev_get_tx_queue() guards it wit=
h
> > just a DEBUG_NET_WARN_ON_ONCE, so sch_direct_xmit() takes the out-of-bo=
unds
> > txq->_xmit_lock and writes txq->xmit_lock_owner past the end of the
> > allocation on non-lltx devices such as ifb. Drivers that index their ri=
ngs
> > from skb_get_queue_mapping() (ex: ifb) go out of range the same way.
> >
> > The Fix:
> > Cap the mapping at the consumer and write the capped value back, so bot=
h
> > the qdisc's _tx[] lookup and any later driver read stay in range. The c=
ap
> > folds into the dequeue path instead of a separate walk over the returne=
d
> > list: dequeue_skb() caps the head, and each bulk helper caps the elemen=
t it
> > appends. netdev_cap_txqueue() already logs a ratelimited notice and sel=
ects
> > queue 0. The single-packet case pays one extra compare against
> > real_num_tx_queues.
> >
> > A bulk-dequeued list is transmitted under the single tx queue lock of t=
he
> > head skb, so every element must belong to that same queue. The fast bul=
k
> > helper (TCQ_F_ONETXQUEUE, taken on BQL devices by the per-queue childre=
n
> > of mq, mqprio, taprio and htb, and by any qdisc on a single-queue devic=
e
> > such as the prio root in the reproducer) must therefore compare each
> > capped follower against the head and requeue a mismatch, exactly as the
> > slow helper already does; appending a follower that caps to a different
> > queue would send it under the wrong _xmit_lock.
> >
> > Conditions to recreate the bug:
> > Load a SCHED_CLS or SCHED_ACT program that stores __sk_buff->queue_mapp=
ing
> > (a tc BPF action is enough), attach it to a transmit qdisc (for example=
 a
> > matchall filter on a prio root), and send a packet. With a 1-queue devi=
ce a
> > store of 1 indexes one past dev->_tx[]. Under KASAN with panic_on_warn=
=3D1
> > the unfixed kernel faults with "BUG: KASAN: slab-out-of-bounds in
> > sch_direct_xmit". Loading the program needs CAP_BPF/CAP_SYS_ADMIN, so t=
he
> > trigger is root.
> >
> > Fixes: 74e31ca850c1 ("bpf: add skb->queue_mapping write access from tc =
clsact")
> > Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/netdev/179033713973.2160803.49145706939=
94398206@kernel.org/
> > Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v2=
.20260924072708%40mojatatu.com
> > Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1=
.20261005193231%40mojatatu.com
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v1 -> v2:
> > - try_bulk_dequeue_skb(): the fast bulk helper (TCQ_F_ONETXQUEUE) cappe=
d
> >   each follower but appended it without comparing it against the head, =
so
> >   a mismatched follower was still sent under the head's txq lock. Compa=
re
> >   the capped follower with the head and requeue a mismatch to skb_bad_t=
xq,
> >   matching try_bulk_dequeue_skb_slow(). Reported by Sashiko (nipa).
> > ---
> >  net/sched/sch_generic.c | 53 +++++++++++++++++++++++++++++++++++++++++=
+++-----
> >  1 file changed, 48 insertions(+), 5 deletions(-)
>
> Hi Jamal,
>
> Weirdly, this patch is mangled and does not apply.
>

Weird indeed. I dont hand edit patches for shipping, so not sure what
happened here.
Brokenness checks out with my local version. I will fix and send v3.

cheers,
jamal
> >
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 6f6a6f0d5eb0..b65bec7e2643 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -96,9 +96,33 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q=
,
>
> This hunk results in 31 lines, not 33.
>
> >
> >  #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
> >
> > +/* A tc BPF program on a transmit qdisc can change __sk_buff->queue_ma=
pping
> > + * after the tx queue was picked. Re-cap it against the device and wri=
te it
> > + * back, so a driver that re-reads skb_get_queue_mapping() stays in ra=
nge.
> > + */
> > +static u16 qdisc_cap_skb_tx_queue(struct net_device *dev, struct sk_bu=
ff *skb)
> > +{
> > +     u16 queue =3D skb_get_queue_mapping(skb);
> > +     u16 capped;
> > +
> > +     capped =3D netdev_cap_txqueue(dev, queue);
> > +     if (unlikely(capped !=3D queue))
> > +             skb_set_queue_mapping(skb, capped);
> > +
> > +     return capped;
> > +}
> > +
> > +static struct netdev_queue *skb_cap_tx_queue(struct net_device *dev,
> > +                                          struct sk_buff *skb)
> > +{
> > +     return netdev_get_tx_queue(dev, qdisc_cap_skb_tx_queue(dev, skb))=
;
> > +}
> > +
> >  static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
> >  {
> > -     const struct netdev_queue *txq =3D q->dev_queue;
> > +     const struct netdev_queue *txq;
> >       spinlock_t *lock =3D NULL;
> >       struct sk_buff *skb;
> >
>
> ...
>
> > @@ -216,6 +242,17 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
>
> And this hunk results in 15 lines, not 17.
>
> >               if (!nskb)
> >                       break;
> >
> > +             /* Re-cap a mapping changed after pick; requeue a
> > +              * follower that no longer matches the head, which owns
> > +              * the _xmit_lock for the whole list.
> > +              */
> > +             if (unlikely(qdisc_cap_skb_tx_queue(dev, nskb) !=3D
> > +                          skb_get_queue_mapping(skb))) {
> > +                     qdisc_enqueue_skb_bad_txq(q, nskb);
> > +                     break;
> > +             }
> >               bytelimit -=3D nskb->len; /* covers GSO len */
> >               skb->next =3D nskb;
> >               skb =3D nskb;
>
> ...
>
> pw-bot: changes-requested
