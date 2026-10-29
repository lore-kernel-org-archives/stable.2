Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793305394;
	b=5b+Ac/THC3ZBYRrcfpa1O1FySn1SE3J546dY4DMGXzewden3KZGYfxPPJiFrSMk8hWvy
	 5wv2WjTJ3nbZS10B4anYIeNPnFnkow9Lh+bOoNFRq0Jl7oZ51fdXzF4ur3Ac0U1SwhG4P
	 e0ajAvLkPcmBdWz0IaaT+wQGCSAt9jCWdhU97Kdpf42AmfFsfxn/ygayCcvmkZVsIHbH+
	 cJwyynaWuL7dg7ipRtWD+LyCjEZzxvLkfxnTYcTej/7UQmT7wWO2d1Ed09ydLkbVx9D6h
	 z6IVSfTRAi03jIeew2JbWSN3NeyAxwWALTUnftaSXGbhbqPdriR/VEQwSdma1wnBIkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
	b=IQShgYRz9Zv/6kENZHqKgNKId/JIZWAN8Dx0+W8p7Yov+In6/y8zbqjck1bdBKzYFnNU
	 D4DUfgbxSCsGjz8BRk8J8YJOrBSCAMpXXc1JAmYvCluzqtamTOtkiX9zF5jdN/yFDdOJV
	 2/IQWW5CdWDv8VjETfsk5JoWodXuchDAYLz9YrVGDTHuskrQS/SfaBt1rqD0D+glqzjov
	 JY+mP6sszNkPbxbGEZ9EAfwOOFayoIbYep63d7/jkIl5+qEElc8jvBG/hlfnE5M1gUS5H
	 jlGMcsrz+MlhZKu5ja60Ur6nFVp+nJ074xRQPugj4GLCrVKKy8QfCVDB+SYvfhhMWdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=DCFa4tpF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1230606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 20:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1230606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=DCFa4tpF
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso1162369b3a.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793305393; cv=none;
        d=google.com; s=arc-20260327;
        b=Xf/m4fjdi90YiTa1Hkaxw3Vvq4OxmOaCwCoAbMyTwNMyAfXvn3lqu+jGIYPRZhVGat
         1gLhY0VL7CAV9ce4duR3mp1zb0lSlgg/rQuvhHgtWZ51ldoD0Y+stdIN8eIMc9vP2l7h
         6eHLqN8rRmPukRda+ZOdA3pSsFEk6BqO5j20eQ7jFcv0rxfB+4kCjch3CRXdqe+HrGY/
         5ORQjZxAZ6MAeS2nJYw4dKaMrwS4P+yyhy6AAF/oaP5OwTvIFyY4UaS4bqnSH7dLWMxd
         t3GHAmmptNEQo92/+ORCR0GICVuGDZm11dQFNYcZ6TgZRGIYKUZA500MOe+TqjtgsMgz
         99pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
        fh=xT9usaD5Y2JcvhyvVk4yJ8y5Psge5vFZ9VWauHjCEmE=;
        b=c+TkDrVcEGNYYlQeWhrqFrC7zGuP4t7LeCCt5LYSN/Mogf38h3QSKMvb2diLRLaykx
         n891eK4SvimkuQyTBW59nEJUnxZCyeiFE4DdMQ2SBPgZ2awEniFtsMLLHFC0tG+jxpk7
         SaXM4RzKcmiJyDfhcRibhmz4YQinHj/GchCQrkHvH/E809ZkPQ1BUFCGbJb+FYhgPGSV
         hGBGZzbUA0Mds+/kPkSEPbA1JfbjoyBzv3a4GYGtSU39pco98FNrDmb9lB32y3gI1K2t
         QdnQTfaHbr7lESobDcmR+zTEcjWZ2ZoxuoZ6VbH9PlKv4AEIKddv8Zo+5eO7Iy+/FvZv
         AB8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793305393; x=1793910193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
        b=DCFa4tpFU0JSr9iQ7diE++luzxQ5lxOD6TczsNDy2QqLo92I2egzlVw1qcysnCz93N
         s6ql5/7+oQezo8DBowqeXXa9c8WfQ3zMl4w+7O92iRH6oMZrR8WF5EBV646rDEuotP72
         KvFs+MPPUZgQ+HQWUEFvRuggKXx97dMdbZcfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793305393; x=1793910193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
        b=FO3VsGrlU9+ubk5EqHZPUePWODJKFdD3prKnOoahtraS5tWsm6efLXkzlXd8pYPCOE
         P11Is3WLPslvmMD3jeeGImLn/Lwdfl6h4e8JkujTrUBfhYaUT4jVeqs9PXBUBRLGFLL4
         ZqpJbBcQgG9Joe2gzHk/M92SgRCVrB52hL/Z9lqF+i0Xq53UfI2LiVfUEZ6Zc6w+WOEG
         ryJc6EqM6k4dL1T5XZ+ETFDFEw9qctD3ctM0bnK+gwgGL++ci8IfOpXFpNOqKuaWsODd
         FTLxGv2ckHTFwFy2Asb+qPfatMC2dX7P1z5dcSDsCYTtUwddeGacqLt+jW5g8AWSoxO9
         xfKw==
X-Forwarded-Encrypted: i=1; AKwUvBzelzVysyqZ/6ZdarffTfzkCJzkid5lZ7G3hSYnVWi1tg5ZLmrWR+loQuOUwp9ydh4K6yxaAdo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/L4CeiMFzaBdWwNGtvXSVVSi5C2k1HlT5NpDPAySMoo68s60+
	2PQFzysQXEykR1xBP9WAJOwp4G4Nw2L34sCgRONENrPjHnn7OKoThJEyC8y4ZFRaFqTdN4q/mPL
	+9nga6msxiSa7ufusFrLs95+6Zj2JSmXnbffvWtDk
X-Gm-Gg: AYBFou1WS1PHJf2C3fDMavQfj4M0qjzO3f5lO32bVvaeiqenaOTV8IIDj6XAdP3Jaja
	J1MkRgVZCGb9C6TKBP2nr/TBKSN7SDjLOMGNeTbPo3IPBmwEBG1fRlcFoMC6fQZzfz/AKZyjXFx
	yPjERI++x/DBCQ5AKyP0d88r0kPahPdc1rRuNRofD9WVQ3klQRILZwO9EPHKgW9m3XJBFeU3ugh
	e4zFwt1SCF+B+8LUIO6ZVk2F/SQDMJHpC/Z2L12vkh1AtWsPvZ0AQhwpfGrC7L0lVEnxfuwuJFs
	nd2m0ta35iYEPKEgCrYjPFwgaEdAuLCxS/RjY1TrtC5sYt0H+Vv0DUWYXY2UJ9/UtA2m8LmDYwO
	hcB8nIlaxn5uCa4axFtpA/EdwXrjUSHoJza7N5hnViWasHm/qbsydBQvIHtuU+MdgkTWkn4Zt3T
	P/mcL7dxfyWYIgia0=
X-Received: by 2002:a05:6a00:1814:b0:898:3898:3826 with SMTP id
 d2e1a72fcca58-8a9be58914bmr217096b3a.14.1793305392573; Thu, 29 Oct 2026
 13:23:12 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-MD1X.v5.r0.20261026053226-1@mojatatu.com> <179329777513.3134.12135506558709584471@kernel.org>
In-Reply-To: <179329777513.3134.12135506558709584471@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Oct 2026 16:23:01 -0400
X-Gm-Features: AclHuK81fdOF3hQJNx2mlfsMkazycSpdb9h0JGAAUY4VUhgLcYcrWN6YKU1fFJc
Message-ID: <CAM0EoMm_3=sHFEcoynZpNMb_Y2sT=a8WZeKz_2Ewn4eo9rfJ_g@mail.gmail.com>
Subject: Re: [PATCH net v5] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	vinicius.gomes@intel.com, horms@kernel.org, hawk@kernel.org, 
	daniel@iogearbox.net, sashiko-bot@kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 2:16=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch silently changes behaviour on stable kernels, and
>   its commit message and docs do not describe the change accurately.
>

sigh. Exhausting. I will send v6 with the commit message fixed.

cheers,
jamal

> --
>
> net/sched: clamp skb->queue_mapping before indexing the tx queue
>
> A tc BPF store can leave skb->queue_mapping out of range. This patch caps
> it in the qdisc dequeue paths in sch_generic.c and in taprio_enqueue(), s=
o
> it can no longer index dev->_tx[] or q->qdiscs[] out of bounds. On a
> TCQ_F_ONETXQUEUE qdisc the mapping is pinned to the qdisc's own
> q->dev_queue instead of being capped to queue 0.
>
> Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994=
398206@kernel.org/
> Link: https://lore.kernel.org/netdev/179293123940.3134.114912867992323467=
7@kernel.org/
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v4.r=
0.20261021042722-1%40mojatatu.com
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v3.r=
0.20261015165943-1%40mojatatu.com
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.2=
0261005193231%40mojatatu.com
> Link: https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.=
org/
>
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 6f6a6f0d5eb0..5dc1d47f811a 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -96,9 +96,34 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q=
,
> >
> >  #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
> >
> > +/* Re-cap a stale queue_mapping; an ONETXQUEUE qdisc pins q->dev_queue=
. */
> > +static u16 qdisc_cap_skb_tx_queue(struct Qdisc *q, struct sk_buff *skb=
)
> > +{
> > +     u16 queue =3D skb_get_queue_mapping(skb);
> > +     struct net_device *dev =3D qdisc_dev(q);
> > +     u16 capped;
> > +
> > +     if (q->flags & TCQ_F_ONETXQUEUE)
> > +             capped =3D q->dev_queue - netdev_get_tx_queue(dev, 0);
> > +     else
> > +             capped =3D netdev_cap_txqueue(dev, queue);
>
> [Severity: Medium]
>
> On a TCQ_F_ONETXQUEUE qdisc, this branch rewrites the mapping of every sk=
b,
> not just the out-of-range ones. Is that intended for in-range mappings th=
at
> a classifier sets on purpose?
>
> The rewrite happens in several places. dequeue_skb() applies it to the he=
ad
> skb and to gso_skb. try_bulk_dequeue_skb() applies it to each follower.
> __skb_dequeue_bad_txq() applies it to skbs taken from skb_bad_txq.
>
> Here is one way to hit it. Take a per-queue child of mq, mqprio, taprio o=
r
> htb offload whose q->dev_queue is txq i. A filter on that child can run
> "action skbedit queue_mapping j" with j !=3D i and j < real_num_tx_queues=
.
> tcf_skbedit_act() accepts that value:
>
> net/sched/act_skbedit.c:tcf_skbedit_act() {
>     ...
>         if (params->flags & SKBEDIT_F_QUEUE_MAPPING &&
>             skb->dev->real_num_tx_queues > params->queue_mapping) {
>                 if (skb_at_tc_egress(skb))
>                         netdev_xmit_skip_txqueue(true);
>                 skb_set_queue_mapping(skb, tcf_skbedit_hash(params, skb))=
;
>         }
>     ...
> }
>
> A tc BPF store of an in-range value behaves the same way.
>
> Before this patch, qdisc_restart() sent the packet on
> skb_get_tx_queue(dev, skb), which is queue j. With this patch,
> dequeue_skb()->qdisc_cap_skb_tx_queue() first rewrites j back to i. The
> packet then goes out on queue i, and nothing is logged.
>
> The commit message says:
>
>     netdev_cap_txqueue() already logs a ratelimited notice and selects
>     queue 0.
>
> The TCQ_F_ONETXQUEUE branch never calls netdev_cap_txqueue(), though. Tha=
t
> also covers the 1-queue reproducer in the commit message, because
> qdisc_create() sets the flag on every non-multiqueue device:
>
> net/sched/sch_api.c:qdisc_create() {
>     ...
>                 if (!netif_is_multiqueue(dev))
>                         sch->flags |=3D TCQ_F_ONETXQUEUE;
>     ...
> }
>
> So in that reproducer, a store of 1 from the filter on the prio root is
> quietly pinned to 0, with no notice.
>
> The only place that says in-range mappings from a filter on a per-queue
> child are now overridden is the v4 -> v5 note below the "---". git am dro=
ps
> that part, and the patch is tagged for stable.
>
> Documentation/networking/tc-queue-filters.rst also still says:
>
>     2) TC filter directs traffic to a transmit queue with the action
>        skbedit queue_mapping $tx_qid.
>
> It does not limit where the filter can be attached.
>
> Could the commit message describe the pinning of in-range mappings, and t=
he
> missing log message on the TCQ_F_ONETXQUEUE path? Should the documentatio=
n
> be updated to match?
>
> > +
> > +     if (unlikely(capped !=3D queue))
> > +             skb_set_queue_mapping(skb, capped);
> > +
> > +     return capped;
> > +}
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-MD1X.v5.r0.20261026053226-1%40mojatatu.com
