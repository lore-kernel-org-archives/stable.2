Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87024FC8FA
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675641; cv=pass; b=rCcAZIPVqHaUuabZvhiuPX0gWuyoxXcwsxzaDL9ynMY0XIH59KwIvuFTPB3k8LQ3Ls+CxXU4ZMFF9hvsbLkjkOp5RvkfumB7IJnlOUOyAXKc1PYOqj6Yj4WbJLb7DJQozKqJBaTx0Kyfj5dqOgc7iX0UBKNXS/baKo5W2fu+uug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675641; c=relaxed/simple;
	bh=oSIV/xlIxgY5lFIG9Mzt5YOVGmXJaH/VOus1Go845e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1tLPwcJ3OZThSqwOtj4qPCg/QMGeuq7wRleIGPouNc9HJ0f4fykhLHhmz5Kir8TFUYIk8rZgK6tWyQ8z4Nju8yQD7vgyBGjo4jsVtSTUz1oEUd0hH6khO2ZsVn+hFoAsU02f1e/PZxpS+QvBT4xUcbm6Atp36zsWsLh53VhVCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=vH1TGCnt; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="vH1TGCnt"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8805988a200so2534117b3a.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 02:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790675637; cv=none;
        d=google.com; s=arc-20260327;
        b=hchrfZ6E5m/q2LDj2TCaO5uLfjMMSx0ZMSaxLVye4+wGrgezS+UB7bGzQNfx3r7KdF
         AWuTuHcaUQA5OuKKjPY+6xoGRPBw9iFV1t1dLUOlHf+Knym76u3ZQJ87NdfmnNeMzcy/
         M4kWMJaQ3C7uRGmX12i6sHQF56p8gyuFhQX+0PS646Z0FgQsF5/6R8sFP2beffq9ilN8
         jPczIWWx4qbnwH09mJ0jv65dVov/B20IDdmkq7og0go215+sa3qt+8ydV8iQkBO7K6qz
         YdA1VoGfQbCWmGnBkQGGF+5HG7QrPKRNS03Ezwsj8d9wFMt+Q7K9v1O63fa/CBOMn8Vq
         G8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iewnLyDo2R9ssKx1308ONslVKjvX2mIhw6N9D6SJFDY=;
        fh=7/Uxfe0+H1WgTq9w6vk1OO2QjtUWgWe+0ZaMgmTzX/c=;
        b=pjfnzexnCdjdUTqbni3niMhy7YcVQBrN3MABF81AKj090I/G5taiYHt0w9me6m9Yqj
         nNVWcjaUSAUKRjcuM9GLnu8A4F5C97dW7C1E5mB9nBWSyIY6x7M4Hgw4cj2h8RB3jT2B
         rp/YTzBJ6NozRuZt+BpERR/m4dwbAFFxOLrbziH4s+/QLhZjJLxa66KxsOkiFNMPbAq5
         1W0h4OkL9XkiCRZAXrW0+njPhygZsrGBt3yPLAsB0LBTG1lCbuxhDchKnyPFLyQc6nU4
         0uxCf9m3KnH/4w0VcLruRSr/32uda9d/TgwXjNZaqlNNWB1rPAt5VLTYI9tKNR7M4NYp
         HTFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790675637; x=1791280437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iewnLyDo2R9ssKx1308ONslVKjvX2mIhw6N9D6SJFDY=;
        b=vH1TGCntzKe867Vp0jqyk3MumzvYghbjKi0TWOUgckXw8DbYqNAWHnbXmN15cXo0Gj
         EeUmdBOQJZIS3DWydEqYRtnnuFoGDv/S0AdP2MXze17Z/oYP2EZe2anZocLCoMcHyh3G
         E8KNc+Q9IXz+sQkkBRdtXGoSeJRyb/WYF36MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675637; x=1791280437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iewnLyDo2R9ssKx1308ONslVKjvX2mIhw6N9D6SJFDY=;
        b=Oz7RshSm8a0SpBfj6hML2nB4hGGHQBMFRw10plZmD+Oe/bq7iEvQGGq5g1tKU0ZqBQ
         YLWGntqRloUnH6uTro53uV+frq/QTcWJvQISfqXo9h7TAg8ZpybtxM526iC63ori3aND
         T+LoZzyQjx6wNqonPzjy/bh+TvTM6HdZD7VVbZ+ydLkGDxtzfzSr9r/1KTsETqDrhdb1
         WI8p6/1u9R213z7+lM+6T0QUpqdfqbCdEugVYsK1D/ExRe6T3vmN197Knvn/oCSTp8jg
         XQdsJMzo4NYsMtG/dhp3l4W+3tBFw9QSD8lfo4EhxdBmcWq8dye6u6bklRDOedWDI21l
         2mwg==
X-Forwarded-Encrypted: i=1; AKwUvBxIYo5y4wjkWIMqB/nLKwO915pVKj0lsnVeDYqf5odoMNlqEVx8lhI6KQPwjKmP6r3Yb0JmsGM=@vger.kernel.org
X-Gm-Message-State: AFuF++mqdzmkIvxIf5USD85pSfAnFVibTFLOZqokTc9RIgB1NKmpErHT
	pPCDHYJcPY10l0twaOdbY5/JgW0H+fZCyZxOp0wnC0tzRLNY4yzHwPOEHG+9U3g78srtk9sCI6v
	oVy5GfL1A1yXU/9MpB4dQ7SkUfdcZwWTc0l2Gu5k9
X-Gm-Gg: AYBFou0LoGKbedjoHz+Jp/tgtN6BJsrke1AYC3psEj9f7hufCkcphrVW0Lrd7ppJ0GC
	lW3yD1aZItVf8/ezt8Y+cJrUGQlN2VgPjn1CSgcee3cmCBQRZQ3AuUyNqAol5pMBEHDQ+mp1SE1
	BwpluhVcCKd2tgAw/ZJtRtY3lme6/BU54CQ2q4BqL6QlXrQARKkLGb3ZHUM+7ESf4z20KEmFgM8
	RKq0sN0JNdDtT7PkDR+DhkN+Z4C/MaiaUV3j/rZjme9puSg9Hdnz4kGL0uSu4IJID5BQLNWOURO
	4bVPTc0GokWxWIEXeXMLTun9NLf15jZpUSiI+Z4vwK4uSYPFeAzUXtwv34XiT3ahtwF3Ec2KhRh
	KY0QUQ6pLfL31SoiJXvvYCoddyYXjugBPPpbeR+I=
X-Received: by 2002:a05:6a00:3cd6:b0:882:50af:be21 with SMTP id
 d2e1a72fcca58-88250afc784mr5701649b3a.48.1790675637093; Tue, 29 Sep 2026
 02:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-9R8V.v4.20260928081529@mojatatu.com> <179065355672.434549.4187901591797286003@kernel.org>
In-Reply-To: <179065355672.434549.4187901591797286003@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 29 Sep 2026 05:53:44 -0400
X-Gm-Features: AclHuK8WoYkKlx66z6wJLWkzne4OrP1pCQEBoEvJhjEF3aR46meA8SDAaZCYl9w
Message-ID: <CAM0EoM=bPdWP0eNNRW4CYTG=t+qadcsjc_Kd7bmgBzW8Himpsg@mail.gmail.com>
Subject: Re: [PATCH net v4] net: cap skb->queue_mapping when the tx queue is picked
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jiri@resnulli.us, vinicius.gomes@intel.com, horms@kernel.org, 
	xiangxia.m.yue@gmail.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, victor@mojatatu.com, zdi-disclosures@trendmicro.com, 
	hybris@mojatatu.ai, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:45=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 2 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] skb_at_tc_egress() treats skb->nf_skip_egress &&
>   !tc_at_ingress as meaning "inside sch_handle_egress()".

will be handled in the rename followup

> - [Medium] The fix keeps skip_txqueue inside one xmit frame only if every
>   nested __dev_queue_xmit() takes the egress_needed_key branch.

This is a valid issue but not a regression introduced by us.
Prior to this patch - the entire egress block is inside if
(static_branch_unlikely(&egress_needed_key)), and each nested
__dev_queue_xmit() re reads the key. TBH, the patch makes it more
observable in that window, but the resulting wrong-queue consequence
already existed.
So i will add this as a followup improvement to the renaming thread we
already captured.

> - [Low] After this patch, skb->nf_skip_egress also gates tc behaviour:
>   skb_at_tc_egress() decides whether tcf_skbedit_act() arms skip_txqueue.

This documentation nit will be fixed when we send the rename followup.

> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it is high
>   severity.

We are tracking this issue as a followup.
Unfortunately the followup cant be sent because it is dependent on
this commit being merged.

For this reason I dont see any need to respin v5.

cheers,
jamal

> --
>
> net: cap skb->queue_mapping when the tx queue is picked
>
> This patch keeps the per-CPU skip_txqueue flag inside the xmit frame that
> runs sch_handle_egress(). It saves the flag before the hook and restores
> it afterwards. tcf_skbedit_act() may now arm the flag only when
> skb_at_tc_egress() reports tc egress. The patch also writes the capped
> value back into skb->queue_mapping in netdev_tx_queue_mapping(), and
> builds skb->nf_skip_egress under CONFIG_NET_EGRESS.
>
> Link: https://lore.kernel.org/netdev/CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMwCQ=
T9WkQVeeNzNQHqQ@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/179008581937.2160803.711781429057426=
2942@kernel.org/
> Link: https://lore.kernel.org/netdev/179033713973.2160803.491457069399439=
8206@kernel.org/
> Link: https://lore.kernel.org/netdev/20260925180407.63647514@kernel.org/
> Link: https://lore.kernel.org/netdev/CANn89i+k-mZKDQVtvws_MEXeuMTAdaCcOXF=
ZE-RfhcGTu90sjA@mail.gmail.com/
>
> [ ... ]
>
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 84308498a3a8..a3ff380d43f0 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1020,7 +1020,7 @@ struct sk_buff {
> >  #ifdef CONFIG_NET_REDIRECT
> >       __u8                    from_ingress:1;
> >  #endif
> > -#ifdef CONFIG_NETFILTER_SKIP_EGRESS
> > +#ifdef CONFIG_NET_EGRESS
> >       __u8                    nf_skip_egress:1;
> >  #endif
>
> [Severity: Low]
> This isn't a bug, but skb_at_tc_egress() now reads this bit to gate
> tcf_skbedit_act(), and the documentation still describes a flag used only
> by netfilter.
>
> The struct sk_buff kernel-doc says:
>
>  *      @nf_skip_egress: packet shall skip nf egress - see netfilter_netd=
ev.h
>
> The comment above nf_hook_egress() in include/linux/netfilter_netdev.h
> says:
>
>  * The nf_skip_egress flag controls whether netfilter is applied on egres=
s.
>  * It is updated by __netif_receive_skb_core() and __dev_queue_xmit() whe=
n the
>
> Neither comment mentions the tc egress meaning. The second one also leave=
s
> out ifb_ri_tasklet() and netkit_prep_forward(), which write the bit too.
> The new skb_at_tc_egress() has no comment about reusing this bit or about
> the precondition it depends on.
>
> Could these comments be updated along with this change?
>
> >  #ifdef CONFIG_SKB_DECRYPTED
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index f35bd06a6bad..1acaadb3e2cf 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -810,6 +810,15 @@ static inline bool skb_at_tc_ingress(const struct =
sk_buff *skb)
> >  #endif
> >  }
> >
> > +static inline bool skb_at_tc_egress(const struct sk_buff *skb)
> > +{
> > +#ifdef CONFIG_NET_EGRESS
> > +     return skb->nf_skip_egress && !skb_at_tc_ingress(skb);
>
> [Severity: Medium]
> Is nf_skip_egress only ever set around sch_handle_egress()? The commit
> message says:
>
>   "the marker is set only around the single sch_handle_egress() call and
>   ingress path is guarded by tc_at_ingress"
>
> Some other writers seem to leave the bit set on skbs that later reach
> __dev_queue_xmit().
>
> __netif_receive_skb_core() sets the bit before sch_handle_ingress(), but
> clears it only on the path where the skb survives:
>
>                 nf_skip_egress(skb, true);
>                 skb =3D sch_handle_ingress(skb, &pt_prev, &ret, orig_dev,
>                                          &another);
>                 ...
>                 if (!skb)
>                         goto out;
>
>                 nf_skip_egress(skb, false);
>
> An ingress mirred redirect consumes the skb and passes it to
> dev_queue_xmit() with the bit still set. A mirror does the same with a
> clone, which copies the bit through the headers group.
>
> ifb_ri_tasklet() sets the bit and then calls dev_queue_xmit(). On the
> from_ingress path it reinjects the skb with tc_skip_classify set, so
> __netif_receive_skb_core() never resets the bit:
>
>                 skb->tc_skip_classify =3D 1;
>                 ...
>                 nf_skip_egress(skb, true);
>
> netkit_prep_forward() also sets the bit. After that, netkit_xmit() calls
> skb_do_redirect(), which can reach dev_queue_xmit().
>
> In __dev_queue_xmit(), tcx_set_ingress(skb, false) always runs. The only
> reset of nf_skip_egress is inside the egress_needed_key static branch.
>
> Suppose only an ingress clsact is installed, for example one doing
> "mirred egress redirect dev qc". The skb then reaches qc's root qdisc
> enqueue with nf_skip_egress=3D1 and tc_at_ingress=3D0. A skbedit queue_ma=
pping
> action in a prio, multiq or htb classifier passes skb_at_tc_egress() and
> calls netdev_xmit_skip_txqueue(true). The v4 changelog says this kind of
> arming from a transmit-qdisc classifier no longer happens.
>
> Nothing seems to consume this stale value today. Every reader inside the
> static branch saves, clears and restores the flag. The one exception is
> the static key race described further down.
>
> There is also a config effect. nf_skip_egress() is now built under
> CONFIG_NET_EGRESS instead of CONFIG_NETFILTER_SKIP_EGRESS. With
> CONFIG_NET_EGRESS=3Dy and CONFIG_NETFILTER_EGRESS=3Dn, the ingress, ifb a=
nd
> netkit calls used to compile to nothing. Now they write a bit that
> skb_at_tc_egress() reads.
>
> Should the reasoning in the commit message be revisited? Otherwise the
> planned rename to skb->skip_egress would carry the same assumption
> forward.
>
> > +#else
> > +     return false;
> > +#endif
> > +}
>
> [ ... ]
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f660fccfc0db..8638c994bbcb 100644
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
> This is a pre-existing issue and was not introduced by this patch. The
> commit message leaves it for a separate followup. Can a cls_bpf program o=
n
> a transmit qdisc still index past the end of dev->_tx[]?
>
> tc_cls_act_is_valid_access() allows writes to __sk_buff queue_mapping.
> bpf_convert_ctx_access() only drops stores of NO_QUEUE_MAPPING or larger:
>
> net/core/filter.c:bpf_convert_ctx_access() {
>     ...
>                         if (BPF_CLASS(si->code) =3D=3D BPF_ST && si->imm =
>=3D NO_QUEUE_MAPPING) {
>                                 *insn++ =3D BPF_JMP_A(0); /* noop */
>                                 break;
>                         }
>
>                         if (BPF_CLASS(si->code) =3D=3D BPF_STX)
>                                 *insn++ =3D BPF_JMP_IMM(BPF_JGE, si->src_=
reg, NO_QUEUE_MAPPING, 1);
>                         *insn++ =3D BPF_EMIT_STORE(BPF_H, si, offset);
>     ...
> }
>
> The stored value is never compared with dev->num_tx_queues or
> real_num_tx_queues. A program attached under a prio or htb root runs
> inside q->enqueue(). That is after netdev_core_pick_tx() or
> netdev_tx_queue_mapping() has already capped the mapping, so the program
> can store any value up to 0xfffe.
>
> On dequeue:
>
> qdisc_restart()
>   txq =3D skb_get_tx_queue(dev, skb)
>     netdev_get_tx_queue()
>       DEBUG_NET_WARN_ON_ONCE(index >=3D dev->num_tx_queues);
>       return &dev->_tx[index];
>   sch_direct_xmit(skb, q, dev, txq, ...)
>     HARD_TX_LOCK(dev, txq, cpu)
>
> The gso_skb and skb_bad_txq requeue paths in dequeue_skb() also call
> skb_get_tx_queue().
>
> That would take txq->_xmit_lock, write xmit_lock_owner and read txq->stat=
e
> in memory past the end of the dev->_tx allocation. Loading the program
> needs CAP_BPF and CAP_NET_ADMIN, or a delegated BPF token. Even so, the
> program has passed the verifier and should not be able to corrupt kernel
> memory.
>
> [ ... ]
>
> > @@ -4848,21 +4861,25 @@ int __dev_queue_xmit(struct sk_buff *skb, struc=
t net_device *sb_dev)
> >       tcx_set_ingress(skb, false);
> >  #ifdef CONFIG_NET_EGRESS
> >       if (static_branch_unlikely(&egress_needed_key)) {
> > +             bool skip_txq;
> > +
> >               if (nf_hook_egress_active()) {
> >                       skb =3D nf_hook_egress(skb, &rc, dev);
> >                       if (!skb)
> >                               goto out;
> >               }
> >
> > -             netdev_xmit_skip_txqueue(false);
> > +             skip_txq =3D netdev_xmit_skip_txqueue(false);
> >
> >               nf_skip_egress(skb, true);
> >               skb =3D sch_handle_egress(skb, &rc, dev);
> > -             if (!skb)
> > +             if (!skb) {
> > +                     netdev_xmit_skip_txqueue(skip_txq);
> >                       goto out;
> > +             }
> >               nf_skip_egress(skb, false);
> >
> > -             if (netdev_xmit_txqueue_skipped())
> > +             if (netdev_xmit_skip_txqueue(skip_txq))
> >                       txq =3D netdev_tx_queue_mapping(dev, skb);
> >       }
> >  #endif
>
> [Severity: Medium]
> Does the flag stay confined to this frame if egress_needed_key is turned
> off while an outer frame is inside sch_handle_egress()?
>
> Each nested __dev_queue_xmit() reads the static key again.
> net_dec_egress_queue() is a plain static_branch_dec() and does not wait
> for RCU-bh readers that are already inside the branch. Consider:
>
> CPU1                                     CPU2
> __dev_queue_xmit(qa)
>   static key is on
>   skip_txq =3D netdev_xmit_skip_txqueue(false)
>   nf_skip_egress(skb, true)
>   sch_handle_egress()
>                                          clsact_destroy()
>                                            net_dec_egress_queue()
>                                              static_branch_dec()
>     tcf_mirred_forward()
>       (mirror clone has nf_skip_egress=3D1)
>       dev_queue_xmit(qc)
>         static key is off: no save/restore,
>         no nf_skip_egress reset
>         q->enqueue() -> prio classifier
>           tcf_skbedit_act()
>             skb_at_tc_egress() is true
>             netdev_xmit_skip_txqueue(true)
>   nf_skip_egress(skb, false)
>   netdev_xmit_skip_txqueue(skip_txq) returns true
>   txq =3D netdev_tx_queue_mapping(dev, skb)
>
> In this sequence, qa's surviving skb picks its tx queue from its own
> queue_mapping, even though it never went through skbedit. For a forwarded
> packet that value is the ingress rx_queue + 1.
>
> The capped write-back in netdev_tx_queue_mapping() still prevents the
> taprio out-of-bounds access. The result would be a wrong but valid tx
> queue, and possibly the ratelimited "selects TX queue" warning.
>
> The commit message says the flag is now owned by the xmit frame the
> egress hook runs in. Is this cross-frame leak meant to be covered as well=
?
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-9R8V.v4.20260928081529%40mojatatu.com
