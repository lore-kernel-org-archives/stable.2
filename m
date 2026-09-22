Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC0339E6F0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112847; cv=pass; b=q/8rZylzxrd5RPHBVs77gIorC1rcWV+XuXBwPeMyIAs/lhNUSk4QClUPLDlD7V+eGTvd5KeUS4HaYoCIRrFhczsV2yLbZtl4nxAjij+3l+4coHiOwZZhheOpVgStYA9j7fWUuYUWJ42GDpCikNQTkdF69DW+aVQUCv3r2MD5Svw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112847; c=relaxed/simple;
	bh=Mhsj1meGNMXLcHk95VqqAxRcAaqp5n/YjUksZBKCrA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTBjW386GN3wUEj4reI8Yh3q1hdDFwjld2ZLnARUCBmyIUrUu5tiRK0yje23Ya/Bl5/7R/u+mqIyf2Hfo6n9/8GKEeA1Bkw7WfZ4pOqkC4gSg6HgY0RMWpLmch+AK7U/zkWXcx5kxzc51vTG9qcGxON6/RX+1tceElnjGxIuiIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=AOpmn7N/; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="AOpmn7N/"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c6so255539b3a.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790112832; cv=none;
        d=google.com; s=arc-20260327;
        b=qXx6TEp9caiGfkEu7SJ6wB/7RhKtKYKKYYMKRwy2Mk1Tx+v5zWXvAjEBy2B+U35hkF
         T+uu077i9MRWwy2bi7V9oto5DL0GS79UxDkwBXhzwa7iSmL7++9kr536Uld1GtApNDJW
         w7pdR/NnrXBK/I/sEVPKhRrlAIUkLGVwbmccx1Zs3YxlRNx4T/iao5BwHCn2Vxgmrwbo
         ur5LZzOojTcdcmRAhtRrygQRjUdB4pCoByvZKiPa8s/iMDoUQBcTcSUZ3WXiL7aBPvQR
         /Z9ZmuXmOntNKRe+O+/Jl1oHHVuuyyGLTfr6yxaXX3YLcoQeuzxMRySbkTuVrj3NQYmo
         Z6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3cv87UNWjyiEPnSAiywRRjwtQRpGHfSGwAPBoQnfD64=;
        fh=O6CTeXgwd0dARkoNzCJKdlGnJm7POlVlz5/Qbl0YIcU=;
        b=anpiKv+6zmEWNtAcAuYpTaMnrBfr4GfH63tRHo9lfJCqYZmqbY8Zj0wwkjmiL28e99
         lLswXIHSZzDQyHBjrwZ1jl7nHYEnzAQQ1pGyE6aevuoY5vSXXPIAqPfZjJEmuIyvWXUX
         eyNfdACH+pg1G4/U3KcWa4eK+wvF5GCtl2P9w+98fl6OO+il508reklS9Q+WFP35ifxu
         fSvAulWC4caX2f0V0xLW5j5jl81aEmILD8z3czgKQ5aZDbrrBMdka0pgZmKgVnKzWxAl
         AZXAVLJg6403F7kUWCcotfgZPcVk8RswcjYs13ItkfGkRXj3t72A10iiByObO3CjMX4L
         Jnuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790112832; x=1790717632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3cv87UNWjyiEPnSAiywRRjwtQRpGHfSGwAPBoQnfD64=;
        b=AOpmn7N/ejcCqoKubA44yfY/DYloyb4oOIlA25/vnLJ4H7mWQiOc2i3pbBmKyv7aUm
         RoKKmNt8krtXxeKskZ9FmNxBDGsINlX6N1pyBFUxnfP4K/pBWytcE1pJyo2cKjlzgRyS
         /JrM+hTw3X5pp0ighIHyv7Soo4P8NNxGxIFDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790112832; x=1790717632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3cv87UNWjyiEPnSAiywRRjwtQRpGHfSGwAPBoQnfD64=;
        b=uhS6c/AM0JDGgIRam0hhvQKY++0N9PW8InULJ91t98nV2ZpvKQ4wiQthLhN03hI5po
         fPULdvwlMWBPcAGdXnjEtwBMrW0vygqEBKPFVlQLDdBgWpStlREvqW62cZFcDmqiTLSX
         0yPsH9DVVJ7hvL1c0FlnlKefNjSPEh/Vkhbq6cQm7yNBDLTCuW+BfmbwfdQgvJtutZdP
         N6wuuLAMmN0hQcrrb7ltd7BtE7QwH6ghl7SIAX3VSF2+nYtH1Bwz8NhEMK+LUrf0HJhY
         RNcYeziML0+jfBZL/746WD9+393wUX3whiIm6gWxCfOh+kx/dveD9ZT3I9voblSmXSGh
         IzBw==
X-Forwarded-Encrypted: i=1; AKwUvBwZaYYEkYKCUjs4/mPtMyPeyIUV2riMYLp4SQzZEm/6QUUnakBFtk/yKdoX/rxr5E01tR3Fz3U=@vger.kernel.org
X-Gm-Message-State: AFuF++kq9jwX1l5jc87/aous7N776WSj+hhlSunCTEjiL1K0EDS5qPzP
	DdkTjCelt7nqD+NAT3dpdj6RTJWugG702b2WYPQEEuPLaU03ShBh1cLIjPATT+poYdHFK0T6E+/
	fAudOdIFIp4+OCicpXPR3hcjukgCK63izjN48t581
X-Gm-Gg: AYBFou3jaCAUlwM1G1SKDBk1HjfCmvqBT8eK9+BOJ+SrvWFNq0Y1kvSK4hw8ZzCoEmH
	bKEoUeh9XYb+zGTy1E2luwMip2HLcdMWfTgzNwj3S2h4car3N5HC/HZ4+GoewJUHkCXsu9BDd3B
	EM/+QcolX6aQIocUgFGxzdLSLrRIzX0x8GbXEVEHL7RbiC6B/6skQDhiVnXwpko6h4tNvVUWqMi
	5xc010bPv5dwimmOqYlvMHpB7Oc1PE/543lSM6qUir+uJq3CVH2jzrlwpct4z1v1G4I/6a6mT8u
	AjSyEzh+hKpt5f1xWiNBK6VUSfNz6Ldt2I3oBYoS4qe8XDlsgF511js/fT64IVu0jxezRVg97nK
	zVmZz5W6sJbYKZw4pgO7MDficHK5ubjubWAxnwaI3jfnAsB8wKPv5e0E=
X-Received: by 2002:a05:6a00:278d:b0:87b:cae7:c6b6 with SMTP id
 d2e1a72fcca58-87d1c3b632emr802784b3a.37.1790112832273; Tue, 22 Sep 2026
 14:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-9R8V.v1.20260921065103@mojatatu.com> <179008581937.2160803.7117814290574262942@kernel.org>
In-Reply-To: <179008581937.2160803.7117814290574262942@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 22 Sep 2026 17:33:40 -0400
X-Gm-Features: AcwNN1W-ryZZoP9sGH5m6_1kKHPOQSrgbDM3iNQvJLNhkSib8fjo12fFADeiZ60
Message-ID: <CAM0EoMkooCG2s+RS53i=qo718GNDGiDz+xaUzAidZArNWO7EuQ@mail.gmail.com>
Subject: Re: [PATCH net] net: cap skb->queue_mapping when the tx queue is picked
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	vinicius.gomes@intel.com, horms@kernel.org, victor@mojatatu.com, 
	xiangxia.m.yue@gmail.com, zdi-disclosures@trendmicro.com, hybris@mojatatu.ai, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:03=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The commit message's justification and reproducer cannot reach
>   the code the patch changes, so the patch's stated bug (and its=E2=80=A6
>
> --
>
> net: cap skb->queue_mapping when the tx queue is picked
>
> This stores the value returned by netdev_cap_txqueue() back into
> skb->queue_mapping in netdev_tx_queue_mapping(), so that later readers of
> skb_get_queue_mapping() on the xmit path see an in-range index. The
> changelog attributes the out-of-range mapping to an skbedit + mirred
> egress redirect from a device with more TX queues to one with fewer.
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index c67900354fa64..736b3664b6354 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4404,9 +4404,14 @@ EXPORT_SYMBOL(dev_loopback_xmit);
> >  static struct netdev_queue *
> >  netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
> >  {
> > -     int qm =3D skb_get_queue_mapping(skb);
> > +     int queue =3D skb_get_queue_mapping(skb);
> > +     int capped;
> >
> > -     return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
> > +     capped =3D netdev_cap_txqueue(dev, queue);
> > +     if (unlikely(capped !=3D queue))
> > +             skb_set_queue_mapping(skb, capped);
> > +
> > +     return netdev_get_tx_queue(dev, capped);
> >  }
>
> [Severity: High]
> Can the reproducer in the changelog actually reach this function?
>

This is the same comment as Eric made. See my response in this thread:
https://lore.kernel.org/netdev/QDISC-9R8V.v1.20260921065103@mojatatu.com/

I will be sending a V2 with the save-clear-restore proposal I made on
that thread.

> netdev_tx_queue_mapping() has a single caller, and it is gated on the
> per-CPU (or per-task, on PREEMPT_RT) skip_txqueue flag:
>
> net/core/dev.c:__dev_queue_xmit() {
>         ...
>         if (static_branch_unlikely(&egress_needed_key)) {
>                 ...
>                 netdev_xmit_skip_txqueue(false);
>
>                 nf_skip_egress(skb, true);
>                 skb =3D sch_handle_egress(skb, &rc, dev);
>                 if (!skb)
>                         goto out;
>                 nf_skip_egress(skb, false);
>
>                 if (netdev_xmit_txqueue_skipped())
>                         txq =3D netdev_tx_queue_mapping(dev, skb);
>         }
>         ...
> }
>
> The clear at netdev_xmit_skip_txqueue(false) runs unconditionally at the
> top of that block, in every egress-enabled frame.
>
> The described redirect enters the target device through a nested
> __dev_queue_xmit():
>
> tcf_mirred_forward()
>   tcf_dev_queue_xmit(skb, dev_queue_xmit)
>     dev_queue_xmit()
>       __dev_queue_xmit()   /* for qb */
>
> Since clsact on qa has already raised egress_needed_key, that nested
> frame for qb takes the same block and clears the flag that skbedit set
> while running on qa. netdev_xmit_txqueue_skipped() is then false, txq
> stays NULL, and qb's queue comes from netdev_core_pick_tx(), which caps
> and rewrites the mapping itself:
>
> net/core/dev.c:netdev_core_pick_tx() {
>         ...
>                 queue_index =3D netdev_cap_txqueue(dev, queue_index);
>         }
>
>         skb_set_queue_mapping(skb, queue_index);
>         return netdev_get_tx_queue(dev, queue_index);
> }
>
> So by the time taprio_enqueue() runs:
>
> net/sched/sch_taprio.c:taprio_enqueue() {
>         queue =3D skb_get_queue_mapping(skb);
>
>         child =3D q->qdiscs[queue];
>
> the index it reads looks already in range for qb, on the patched and the
> unpatched kernel alike. Does the quoted "BUG: KASAN: slab-out-of-bounds
> in taprio_enqueue", the read 0 bytes past the 16-byte taprio_init
> allocation, really come from this skbedit + mirred sequence?
>
> A second point on the rationale:
>
>     So the decision is to cap the value where it is first trusted and
>     result is it fixes all downstream readers at once.
>
> Is this site where the value is first trusted? The only in-tree setter of
> the flag validates against the same device before arming it, and stores a=
n
> already capped value:
>
> net/sched/act_skbedit.c:tcf_skbedit_act() {
>         ...
>         if (params->flags & SKBEDIT_F_QUEUE_MAPPING &&
>             skb->dev->real_num_tx_queues > params->queue_mapping) {
> #ifdef CONFIG_NET_EGRESS
>                 netdev_xmit_skip_txqueue(true);
> #endif
>                 skb_set_queue_mapping(skb, tcf_skbedit_hash(params, skb))=
;
>         }
>
> and tcf_skbedit_hash() ends with:
>
>         return netdev_cap_txqueue(skb->dev, queue_mapping);
>
> With that, capped !=3D queue in the new code seems to require either
> real_num_tx_queues shrinking concurrently (the index still being below
> dev->num_tx_queues, so still inside dev->_tx[] and taprio's q->qdiscs[]),
> or something rewriting skb->queue_mapping later in the same egress run.
>
> A path that does look able to deliver a genuinely out-of-range value to
> the new statement is a tc BPF program writing skb->queue_mapping after
> skbedit armed the flag on the same device, since
> tc_cls_act_is_valid_access() permits BPF_WRITE of that field and
> bpf_convert_ctx_access() emits the store. Would describing that (or a
> similar in-frame rewrite) instead of the cross-device mirred path make th=
e
> Fixes: tag and the reported scenario verifiable for reviewers and stable
> backporters?
>
> Also, this isn't a bug, but the changelog says:
>
>     Another approach was to cap it in skbedit;  cannot work: the
>     redirect target, whose queue count bounds the mapping, is not known
>     when the action runs, and act_mirred sets skb->dev afterwards.
>
> there is a double space after the semicolon.

Sheesh - bikeshed much?

cheers,
jamal
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-9R8V.v1.20260921065103%40mojatatu.com
