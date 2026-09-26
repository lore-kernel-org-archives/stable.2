Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB483B27D3
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790418847; cv=pass; b=pA4TyGUkTlKWHbAKpqVLXmQ3A3cKyvK+s8LLUwE4bbsVtacS1+7NokUnmNdov6BGpHcim65eCa92kEKMgMZ+wKcfbiF+kSvIaMDFka75CtxORvxvog5iVl4l47/5gXg/gRsA3AkjOgUFiKeGPAScI4jrIJ4iZiLIP5vu4g/tngc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790418847; c=relaxed/simple;
	bh=/FEfwjinZSjMRRuxOt0RbgAGBAicOCGTDKJAsXkyTPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5/pbKZiair3Phuj+hZWyXRbySwymWczQej+l3YR10UZNZ88JT0jjUpw7605ocYq5DeYBpsCFTfZltxIj/VXBpnInrSccTeA78FR/u6mRlHW/4hE5J0+ksO1Z1XpGe83RgMTnieb7AAMI5bY/lHrvhSP0/E9U7YS16JBewxJaUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ZjEM2dXm; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ZjEM2dXm"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f9160b81so590101c88.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 03:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790418841; cv=none;
        d=google.com; s=arc-20260327;
        b=Ng2IsNzH7MQX35aIS1iTEx6WA2wHJaefc1doCSFu2GsG70adIFf+VGcId696ZEom3D
         2tCzMkBoz60Lqn4ovK/xKJ6Dm3Bo5Rrk6aW2MG2mMPIge4wKLlWF7eqAB4HxqePiYQhx
         YyBrBXiX7pAuTevdIEwayMNY8SYh8NRfp8KT9UBIFAbYSsLWdNSHBEMUONj3ZWAO8J2X
         AnCrng2Rtd7bvBZFQsk3dnvRhRP6dULmJRmNNGvrAaJTVnFR99gvHdzSvBLdBS+pllOv
         9JyKofOCDJY2GOtmf4SWN3q/g0h28dghS+bn07KqzbLkeXC2j3/tSCXkCjrl51ov3cEK
         Me7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IVFpYrIiI4qWBzdlsiOfdTBSQkO5rcfLPYgmjv4+lYQ=;
        fh=tbI0RBwXvzCiNBLCJ+q1AnoZxwERT0qnRxpGuM4z/Ek=;
        b=sA6sLkJ/QEm7IFSGPMcQjKhvfuBMmE1UZ413vyT7VQXGHYg4ktG+gzDm+cDWBYgaG8
         uSf5Xcb2JljVF9be2dgSlCWK0Ohbrd6XY0LbFM2LFP55ci42uKfMCMrRdBCzAW0MbD7w
         OcoLXMJrzbCKmiabsQFuVy3uDiRVJ+cxEAMjKpQLCpKBGHtBDdvqzliWThYx47dTfvve
         IX7aawipm42o7KVVB5t7i8i72ksH8j+T8VVIMddVmPdOo3XKI47erKnmkeTNEWXMF1ug
         IwLBpjC1MfBr3QixqYHL/YoZgdvubDKE16jSIPP/JpDYpdkXajir7qzRAQPooWe6ETPM
         YOzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790418841; x=1791023641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IVFpYrIiI4qWBzdlsiOfdTBSQkO5rcfLPYgmjv4+lYQ=;
        b=ZjEM2dXmF04n/eAT8sk+8sVJyEzJt9JEx9nYbTi2iCv1BJK5Fjdlu/PSBRkVS5gS3m
         /i4HVUKXU+hZUMCHDXct2uD+LhXCC8Dub6jaEBd13PKOzriParWwLNmLEGmTcLfOuwUa
         lgSzk/ekBAPfDsrvt+IWfEv+QDCyoz/wynLAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790418841; x=1791023641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IVFpYrIiI4qWBzdlsiOfdTBSQkO5rcfLPYgmjv4+lYQ=;
        b=UEvghfp5BwtMD5L1Zjbz8nQEhEkVEpzByq3rwnldA0uRWh8N1C8CT81B0noCR0ZXXL
         BUaRu7ZGyQMBcO7KpaIJL4KR1nXdQLzq3TzySCRiohIyaZFeHfT3KbxFkvhu7RLA0otz
         r1gVZ9ByKopspmklwBkVZHU0YZMObVG8TMuM3u5cZW2oxTqqBCa9l8HK4JbsKJkZuVin
         2DOCn/ADr164iXmbNu2UhRZ4neE2OAKik34G4ea6SrPuLHjQMmmD0Arg1Ycf8b+/bzhp
         PFGYgVOMakFBwP5buQ5lJUCYWlPepg7ceQktQ5TkmaUlbTYxnVW/O9nK4Z24XgVCk8ee
         /RcA==
X-Forwarded-Encrypted: i=1; AKwUvBw7b+g4gmg463p2WUyvc5euUCNLo0VeeKkVJOGSXaqxnK+9S74t/RkuFS2i0JEhr9Spfk7Ql1I=@vger.kernel.org
X-Gm-Message-State: AFuF++nius/mHfdpOmfidabd2QBh8D/WVtQJki1tnI0247pXIGtaj4TW
	gchDDax+CB9j7kVUf8Z2Tc9GvqqzQcxKo5GAPU2XJWF/XZCQsiPbRMYsvolHKd5GWSJLhiuLPTT
	8v9weD9YkeucVnwHmM8vl6GpZebkmj0/cJmYzuI/G
X-Gm-Gg: AYBFou3rxzu9oPtXX0E+8Wz/PFJEpnjIAaouDXKZFPKMpE/FICVlLl6nBCs9E+BLRDb
	3MJoHnOHJwObps2VNL1tA8dL7rPrEH8yu0NaQLOgBEypKl2Rk+J1jJL0z9BEA5DR2gWVEL7iWUG
	cKLvOY9sgI7pTxOCoyaVyCmDEGRKszAxYu8pNrmwS5JdgVpQr1q3vOh2fLLiBngYuSIoyyu+TMQ
	RMkvwRaEqlQVxhpMhagmHmbTTq3oK481EvjLKLjzGSylBqWSaZCUsTk89fMJ6OFsFHGCC1YHe8u
	F3FnyvrBJ1CxEc7vyfbZD7emeqkoxIDWWMGZK516ejtxpHOnGFPhXJFf2H2H/YIwMVIoKk5uIBK
	MOcoGW3/9tDq4cLTfM2sl9t2R5J7ADn4TT5Eypiz5eV/Zhg6mdFgWZoLbtNiQYGc4dJvWfYVxql
	YMzOkwsZ0TfEvlbVWID7g=
X-Received: by 2002:a05:701b:458d:b0:144:dfd4:3255 with SMTP id
 a92af1059eb24-146ce67edaamr2579398c88.12.1790418840778; Sat, 26 Sep 2026
 03:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-9R8V.v2.20260924072708@mojatatu.com> <179033713973.2160803.4914570693994398206@kernel.org>
In-Reply-To: <179033713973.2160803.4914570693994398206@kernel.org>
From: Jamal Hadi Salim <hadi@mojatatu.com>
Date: Sat, 26 Sep 2026 06:33:48 -0400
X-Gm-Features: AclHuK8zLaRNVwRw1_Ew9rnYmI9YpA9UaeQhmm6NInmYDFruv9oQKaRCgdEpQmE
Message-ID: <CAAFAkD_H60neT3RSRL4jUyoUXNf8Wxe2Hgc6eK-TQrR2ZnjK4g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: cap skb->queue_mapping when the tx queue is picked
To: netdev-bot+sashiko@kernel.org
Cc: jhs@mojatatu.com, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	vinicius.gomes@intel.com, horms@kernel.org, xiangxia.m.yue@gmail.com, 
	victor@mojatatu.com, zdi-disclosures@trendmicro.com, hybris@mojatatu.ai, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 7:52=E2=80=AFAM netdev-bot+sashiko via Hyper-Yieldi=
ng
Back-end Review & Insight System <hybris@mojatatu.com> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch does not close the whole tc-BPF queue_mapping case its
>   commit message claims to cover.

Excellent catch (should i call you sashiko or clashiko?);  _but_ it is
not something we introduced or something the patch tries to fix.

1) If we are to resend this fix (likely if we can resolve what Jakub
suggested) then we will narrow down what the commit says so you dont
find a loophole to nitpick on ;->
2) we added a followup to our list of followups to resolve this issue
so we dont forget. A couple of initial approaches we are considering
are:
a) Cap at netdev_get_tx_queue() (or qdisc_restart()  /
skb_get_tx_queue()) index to dev->num_tx_queues - 1, or b) reject the
BPF store bound more tightly.

#a is our favorite so far but when we get to implementation/testing #b
may be simpler.

> - [Low] The comment this patch adds in __dev_queue_xmit()
>   (net/core/dev.c) says "The flag is per-CPU and a nested xmit can set=E2=
=80=A6
>

If we resend we'll fix the comment per your suggestion.

cheers,
jamal

> --
>
> net: cap skb->queue_mapping when the tx queue is picked
>
> This patch changes __dev_queue_xmit() to save and clear the skip_txqueue
> flag when a transmit frame starts and to restore it when the frame exits.
> A nested xmit can then no longer hand the flag to an outer xmit. The patc=
h
> also stores the value picked by netdev_cap_txqueue() back into
> skb->queue_mapping in netdev_tx_queue_mapping().
>
> Link: https://lore.kernel.org/netdev/CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMwCQ=
T9WkQVeeNzNQHqQ@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/179008581937.2160803.711781429057426=
2942@kernel.org/
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 0292a16e16c2c..e72a5c6dc63af 100644
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
>
> The commit message says this write-back means "a mapping rewritten later
> in the same egress run (for example a tc BPF store) cannot leave an
> out-of-range index for the later readers on the xmit path". Is that true
> for a BPF store made by a transmit-qdisc classifier?
>
> In __dev_queue_xmit(), this write-back runs after sch_handle_egress() and
> before q->enqueue(). The commit message itself notes that transmit-qdisc
> classifiers run inside q->enqueue(), which is later in the same frame.
>
> tc_cls_act_is_valid_access() lets any SCHED_CLS/SCHED_ACT program write
> __sk_buff->queue_mapping. That includes a cls_bpf filter or act_bpf on a
> transmit qdisc such as prio, multiq, htb, or a child of mq or taprio. The
> ctx rewrite in net/core/filter.c only rejects values at or above
> NO_QUEUE_MAPPING:
>
>     if (BPF_CLASS(si->code) =3D=3D BPF_ST && si->imm >=3D NO_QUEUE_MAPPIN=
G) {
>         *insn++ =3D BPF_JMP_A(0); /* noop */
>         break;
>     }
>
> Take a 1-queue device with a prio root and a cls_bpf filter that sets
> skb->queue_mapping =3D 100 and returns TC_ACT_OK:
>
> __dev_queue_xmit()
>   netdev_core_pick_tx()            <- mapping capped here
>   __dev_xmit_skb()
>     dev_qdisc_enqueue()
>       prio_enqueue()
>         prio_classify()
>           tcf_classify_qdisc()     <- BPF sets queue_mapping =3D 100
>     qdisc_run()
>       __qdisc_run()
>         qdisc_restart()
>           skb_get_tx_queue(dev, skb)
>             netdev_get_tx_queue()  <- &dev->_tx[100]
>
> The only check in netdev_get_tx_queue() is a debug warning:
>
>     DEBUG_NET_WARN_ON_ONCE(index >=3D dev->num_tx_queues);
>     return &dev->_tx[index];
>
> sch_direct_xmit() then calls HARD_TX_LOCK(), netif_xmit_frozen_or_stopped=
()
> and dev_hard_start_xmit() on that out-of-bounds netdev_queue. Drivers the=
n
> index their rings with the same value.
>
> multiq behaves the same way. After classification it checks the band
> against q->bands, but skb->queue_mapping stays out of range when
> qdisc_restart() reads it.
>
> This path does not use the skip_txqueue flag, so saving, clearing and
> restoring the flag does not help here either.
>
> The unchecked read in qdisc_restart() already existed before this patch.
> However, the commit message and the v1->v2 notes ("covering the residual
> in-frame rewrite nipa identified (e.g. a tc BPF store)") say this case is
> fixed.
>
> Would a cap on the consumer side be needed to close it, in qdisc_restart(=
),
> skb_get_tx_queue() or sch_direct_xmit()? A bound on the BPF store could
> also work.
>
> If not, could the commit message make a narrower claim, so backporters do
> not assume every queue_mapping out-of-bounds case is fixed?
>
> [ ... ]
>
> > @@ -4847,6 +4855,14 @@ int __dev_queue_xmit(struct sk_buff *skb, struct=
 net_device *sb_dev)
> >
> >       tcx_set_ingress(skb, false);
> >  #ifdef CONFIG_NET_EGRESS
> > +     /* The flag is per-CPU and a nested xmit can set it from its own
> > +      * clsact hook or transmit qdisc. Own it for the whole frame: thi=
s
> > +      * frame cannot consume a nested xmit's flag and a nested xmit
> > +      * cannot inherit this frame's.
> > +      */
>
> [Severity: Low]
>
> This isn't a bug, but is "per-CPU" accurate on every config? With
> CONFIG_PREEMPT_RT, the helpers in the same file store the flag per task:
>
>     static bool netdev_xmit_txqueue_skipped(void)
>     {
>         return current->net_xmit.skip_txqueue;
>     }
>
> Saving and restoring the flag still works on RT, because nested xmits run
> in the same task. Could the comment say "per-CPU (per-task on
> PREEMPT_RT)"?
>
> > +     skip_txq =3D netdev_xmit_txqueue_skipped();
> > +     netdev_xmit_skip_txqueue(false);
> > +
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-9R8V.v2.20260924072708%40mojatatu.com
