Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7C5C613
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790550437; cv=pass; b=SN+1Zay87NiPFMhW2QCm1ADmZEejXUXKY7gVCy7Ev2ldRh26VLsnz0w+Yx5gvtP6UP4ZSdxqdSTd3Ig9do2zLrOY27xYuaMPJ6EM7j1/T4hrFsC6/v1wjVJcKFJq3BHI4b6gUyvHiEEnJ16oue9V20yPdQz7n3PKmbOwnrLZZ2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790550437; c=relaxed/simple;
	bh=DEzeiYA+qkLlY7IV2Y48wovNN6wlOhrqRRhPjQinWMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFYo+lFSLy+OLPhj+Blbv2agN92Iv6TacyuwJs+lKwY2kaOZ3yKwvREn923cu4DHG/kgkr3qEyG5cdF+lc+LZp/6vCH4fk8dBLjcH0f5KjmbQNhBElx9sI7V2w4R8YhsUeYT4PS3Lzbo2Mg2naqa8DNR2pR4q5EVQSYj8RmvRYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=W9kTHqam; arc=pass smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="W9kTHqam"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-882c2bcef77so392137b3a.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 16:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790550435; cv=none;
        d=google.com; s=arc-20260327;
        b=RKdLhA2Tx+f/upO2rCqkemsIXX9eJVAmp2q97EgYOM+O16zOY8Rrd7BZJuaONbSNRx
         7Ue4HjUUDSb02g/30rwMhqUZwqbxQMOCUZjvmpbf9f7TF60VbGYWUk78k8ztftXIoKEP
         yk+E2CEyyZJHBWJbh9Gu+vFqTPFKQKQj/4Bo9Ia+ylGsgSV27zH68GXCJEWhQnaDYlj3
         jzYIh8fZK0yVOdFetVFO+PBjfUnUpUJplAiTIgWypl6X06hCfVaFiNpqVwBR5GMKXA04
         fU1vPgE8U2KFch1eKKFPWuyNQu3+YUyBdUsrUw9SgB2gPnMbbmKhF7aq+n892uCWbIlD
         /C6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8EfpsoKj73vUJtJGQgj1h0j+yXYGfQU2QNlgGB8wSlk=;
        fh=K9DP5mERZRuexK0nEVFHCa7zwLnd8kLbnlVDZVnOiI4=;
        b=eP+zNbuxjugXeqNypl5+BxxEkEQxbNmTKZ+GaPL8xYKw29GhkhF9FVEfRyWozT8tI2
         f9MAXGmstWbhwTZXWelWy4VVxo0cJaa0WtcPa1exbt2P9YeKEQxMIRMsLBW7zEYQ3Syd
         e8+OTPNwoRjaTO2wVuUUZoNDObabHmwqeFJ6MEfcVPjPhoW4qHji1FY2vudyIxy2TIKR
         0eGY8f36L9kGYSzoBPGCV8WvH/7r2LE2AF7NvWuD8VAGppVaDMws3c+lduHZaQD3lRfG
         2de7sSObcDDp6A5/d0PFicvZmiq/vCqbhalBm2FlNEtx2GtzqVXqJwLHpQjfMaPLhx+X
         IJhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790550435; x=1791155235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8EfpsoKj73vUJtJGQgj1h0j+yXYGfQU2QNlgGB8wSlk=;
        b=W9kTHqamMPb/MKyTZ5ITLxVdgE968cumtW02aqQnjlMXsYQTm3ov8O82qXE0IAh9tl
         lXTrC8jEUcdLnSVrhnQxDEqiBmksdmWT/ER5voTTAGoebMu9smNScgbCT2KZVhql8Qtz
         GModL2Pi1DzpdzFBotB3aRKC3cgJjzTeDV6PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790550435; x=1791155235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8EfpsoKj73vUJtJGQgj1h0j+yXYGfQU2QNlgGB8wSlk=;
        b=Fijtzy+t39AmH8voYHstdX+HNy7qrK3aUg81HdHCyPyL/d72vp5NYUG2f63ekgVJ4Q
         Ujlh3OuP9ldmS+FoMGemv2SzyRhivDnn7lu97TjXEcAKW6SCFaxuXLzNXozbpTlvC+ou
         qy6uo5cmwLQZiuyPMQl3p/nndwp2zKHDsapq0Ts1hjYSAcghq0mfSmel197Yv1DFAMhp
         YJhRkhgsGU2pgpqZS7FkY3xWn5boH00oEFCyufQ4mXoIhndTkEiz7fICQxUcl+2696HY
         FH9hyddKvI5riWibCfXectqjdDUl7fnRrpVq2xTmoiwcmgdpTBUKMOe/Tcf7ZotMG/C0
         ZLYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQKWs1Rk47nZnq72+oMzHi2IAUdWPvFdXynX4StroxYrbUTwiB2cbhLmZhdWtB1nZahXpJX7s=@vger.kernel.org
X-Gm-Message-State: AFuF++lcmw5fqzmGFN/U7RxraXhTJb8lqDyi6SzrIYt/neSJ6JIfPDBJ
	l+7Br0wYgzYCTSLF5XQx9i7OOTmCY9QUu7eYqrSZzjR7HOeVAgfKUd77TrmtVcMoVZscglWigdG
	NkXV80Kjn0cwVVQmc/tO4KqcLwxCx2Ggt+umYaIID
X-Gm-Gg: AYBFou3kWHbKfQi84S3SEUUO+iyv1aa0St+trZ1WEBTxVUgRrb9i5SIUWE4qQAjYJ9L
	bSsbAxTt89ER+PX+MauPkc+wy1L/j9WY3UhaMldB9LBmptQSxG2oYlcNnIW5oJ+oXp3hkbNuGkt
	NKuvV6ZrBcmoybDvnbmjFScA0Akrh4b6JCrAgxLeLRkB/rmx3xLOQK8eU3ISq4f4n8QROYls6Ej
	tp0If/uLI4d84aaN7SBpjzk6DoLG5AuP+a2YA4ILWUWpU+RnpZ90l7fYrv3XGYRgpm8DkTSjhot
	VicQPcVIkKg1q2sxCjAyn7/pzLehWQgTLn28M/RDSl8KGzmzFuKIIpdTtJbjiKeeBeDBJO/NPGV
	4mgew/8K/aOU2CjDX9OXOuHUGmITB38FaHQ==
X-Received: by 2002:a05:6a00:2991:b0:882:d8c4:17c9 with SMTP id
 d2e1a72fcca58-882d8c423bbmr1423940b3a.23.1790550434677; Sun, 27 Sep 2026
 16:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-9R8V.v3.20260926072930@mojatatu.com> <CANn89i+k-mZKDQVtvws_MEXeuMTAdaCcOXFZE-RfhcGTu90sjA@mail.gmail.com>
In-Reply-To: <CANn89i+k-mZKDQVtvws_MEXeuMTAdaCcOXFZE-RfhcGTu90sjA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 27 Sep 2026 19:07:02 -0400
X-Gm-Features: AclHuK9krlNG6MytVUIWiHjXrlaK2ktzM3mPVdJgTfHx3cRppGgPCkFklVoxQbs
Message-ID: <CAM0EoMkfky6883uMEsYerDqy5u_A1+fvs3pLPjkEUeeCC2=6ZQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net: cap skb->queue_mapping when the tx queue is picked
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Simon Horman <horms@kernel.org>, Tonghao Zhang <xiangxia.m.yue@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Victor Nogueira <victor@mojatatu.com>, 
	Zero Day Initiative <zdi-disclosures@trendmicro.com>, hybris <hybris@mojatatu.ai>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 11:48=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sat, Sep 26, 2026 at 11:48=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > skbedit can set skb->queue_mapping and raise the per-CPU skip_txqueue
> > flag so __dev_queue_xmit() honours the mapping. __dev_queue_xmit()
> > cleared the flag before sch_handle_egress() and only read it afterwards=
,
> > so the flag was not confined to the xmit that set it: a nested xmit
> > (mirred redirect or mirror, or a drop after skbedit) could set the flag
> > and the outer xmit would consume it for an skb that never went through
> > skbedit.
> >
> > A forwarded packet still carries the ingress NIC's rx_queue + 1 in
> > skb->queue_mapping, so the outer device then indexes its tx queue state
> > with that stale value. Taprio's child array q->qdiscs[] is sized to the
> > device's queue count, so taprio_enqueue() indexes past its allocation
> > and dereferences the result as a struct Qdisc *.
> >
> > Own the flag for the whole xmit frame: save the incoming value and clea=
r
> > it before any of the frame's egress work can recurse, and restore it on=
ly
> > when the frame exits. A transmit-qdisc classifier is a documented flag
> > producer too (it runs in q->enqueue(), after sch_handle_egress()), so t=
he
> > flag must be owned for the whole frame, not just around the clsact hook=
.
> > The flag then never crosses an xmit boundary in either direction. Also
> > store the value netdev_cap_txqueue() selected back into skb->queue_mapp=
ing
> > in netdev_tx_queue_mapping(), as netdev_core_pick_tx() already does, so
> > the skip_txqueue path never hands a later reader on the xmit path a
> > mapping the device cannot serve. A store made still later in the same
> > frame, by a tc BPF program attached to a transmit qdisc, is outside thi=
s
> > path and is not re-capped; a separate followup will resolve that path.
> >
> > netdev_xmit_skip_txqueue() now returns the previous flag value so the
> > save-and-clear is one call, and a no-op stub is provided when
> > CONFIG_NET_EGRESS is disabled. This removes the inline #ifdef around th=
e
> > save and the two restores.
> >
> > A local user in a network namespace can redirect a packet from a device
> > with more TX queues to one with fewer after setting a mapping valid onl=
y
> > on the larger device. That reaches these reads and, under KASAN, faults
> > with "slab-out-of-bounds in taprio_enqueue".
> >
> > Conditions to recreate the bug: with CONFIG_NET_SCH_TAPRIO=3Dy,
> > CONFIG_NET_ACT_SKBEDIT=3Dy, CONFIG_NET_ACT_MIRRED=3Dy,
> > CONFIG_NET_CLS_MATCHALL=3Dy, CONFIG_NET_SCH_PRIO=3Dy and KASAN enabled,
> > create qa (3 queues), qb (2 queues) and qc (1 queue) as dummy devices;
> > put a taprio root on qb and clsact on all three; then add an egress
> > matchall filter on every device. On qa: "action skbedit queue_mapping 2
> > pipe action mirred egress redirect dev qb". On qb: "action mirred egres=
s
> > mirror dev qc". On qc: "action skbedit queue_mapping 0 pipe". Send one
> > packet out qa. qc's skbedit sets the flag while qb's outer xmit is in
> > flight; without the fix qb consumes it and reads its two-entry taprio
> > child array with the forwarded packet's stale mapping. A qc whose skbed=
it
> > is instead installed in a transmit-qdisc classifier (a matchall filter =
on
> > the qc root qdisc) reaches the same code path the same way.
> >
> > Testing: on a KASAN build with panic_on_warn=3D1 the unfixed kernel pan=
ics
> > with "BUG: KASAN: slab-out-of-bounds in taprio_enqueue", a read 0 bytes
> > past a 16-byte taprio_init() allocation; the fixed kernel runs the
> > clsact-setter and the transmit-qdisc-classifier reproducers with no rep=
ort
> > and no clamp notice, and a clsact skbedit-then-tc-BPF store with no rep=
ort
> > but the expected "selects TX queue" clamp notice from the write-back;
> >
> > Fixes: 2f1e85b1aee4 ("net: sched: use queue_mapping to pick tx queue")
> > Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> > Link: https://lore.kernel.org/netdev/CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMw=
CQT9WkQVeeNzNQHqQ@mail.gmail.com/
> > Link: https://lore.kernel.org/netdev/179008581937.2160803.7117814290574=
262942@kernel.org/
> > Link: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994=
398206@kernel.org/
> > Link: https://lore.kernel.org/netdev/20260925180407.63647514@kernel.org=
/
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Tested-by: hybris <hybris@mojatatu.ai>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v2 -> v3:
> > - netdev_xmit_skip_txqueue() returns the previous flag value, so the en=
try
> >   save-and-clear is one call; a no-op stub is provided when
> >   !CONFIG_NET_EGRESS, removing the three inline #ifdefs (Jakub Kicinski=
).
> > - Narrow the capability claim: the capped write-back covers the
> >   skip_txqueue path only; a store made later in the frame by a tc BPF
> >   program on a transmit qdisc is not re-capped and is a separate follow=
up
> >   (nipa Sashiko).
> > - Comment: "per-CPU (per-task on PREEMPT_RT)" (nipa Sashiko).
> > - Drop the now-redundant #ifdef in act_skbedit.c.
> >
> > v1 -> v2:
> > - Rework the root cause to the per-CPU skip_txqueue flag lifetime: it w=
as
> >   cleared before sch_handle_egress() and read after, so a nested xmit c=
ould
> >   set it and the outer xmit consume it for an skb that never went throu=
gh
> >   skbedit (Eric Dumazet, nipa Sashiko).
> > - Own the flag for the whole xmit frame: save/clear it before any of th=
e
> >   frame's egress work can recurse, and restore it only when the frame e=
xits.
> > - Retain the v1 producer-side cap (netdev_tx_queue_mapping() writes the
> >   clamped value back).
> > - Correct the description of the reproducer to a three-device chain
> >   (qa 3q -> qb 2q taprio -> qc 1q).
> >
> >  include/linux/rtnetlink.h |  7 ++++++-
> >  net/core/dev.c            | 33 +++++++++++++++++++++++++++------
> >  net/sched/act_skbedit.c   |  2 --
> >  3 files changed, 33 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> > index 95729339e7a5..a54ec40d095c 100644
> > --- a/include/linux/rtnetlink.h
> > +++ b/include/linux/rtnetlink.h
> > @@ -186,7 +186,12 @@ void net_dec_ingress_queue(void);
> >  #ifdef CONFIG_NET_EGRESS
> >  void net_inc_egress_queue(void);
> >  void net_dec_egress_queue(void);
> > -void netdev_xmit_skip_txqueue(bool skip);
> > +bool netdev_xmit_skip_txqueue(bool skip);
> > +#else
> > +static inline bool netdev_xmit_skip_txqueue(bool skip)
> > +{
> > +       return false;
> > +}
> >  #endif
> >
> >  void rtnetlink_init(void);
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f660fccfc0db..3b114fbf7015 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4404,9 +4404,14 @@ EXPORT_SYMBOL(dev_loopback_xmit);
> >  static struct netdev_queue *
> >  netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
> >  {
> > -       int qm =3D skb_get_queue_mapping(skb);
> > +       int queue =3D skb_get_queue_mapping(skb);
> > +       int capped;
> >
> > -       return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
> > +       capped =3D netdev_cap_txqueue(dev, queue);
> > +       if (unlikely(capped !=3D queue))
> > +               skb_set_queue_mapping(skb, capped);
> > +
> > +       return netdev_get_tx_queue(dev, capped);
> >  }
> >
> >  #ifndef CONFIG_PREEMPT_RT
> > @@ -4415,9 +4420,13 @@ static bool netdev_xmit_txqueue_skipped(void)
> >         return __this_cpu_read(softnet_data.xmit.skip_txqueue);
> >  }
> >
> > -void netdev_xmit_skip_txqueue(bool skip)
> > +bool netdev_xmit_skip_txqueue(bool skip)
> >  {
> > +       bool prev =3D netdev_xmit_txqueue_skipped();
> > +
> >         __this_cpu_write(softnet_data.xmit.skip_txqueue, skip);
> > +
> > +       return prev;
> >  }
> >  EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
> >
> > @@ -4427,9 +4436,13 @@ static bool netdev_xmit_txqueue_skipped(void)
> >         return current->net_xmit.skip_txqueue;
> >  }
> >
> > -void netdev_xmit_skip_txqueue(bool skip)
> > +bool netdev_xmit_skip_txqueue(bool skip)
> >  {
> > +       bool prev =3D netdev_xmit_txqueue_skipped();
> > +
> >         current->net_xmit.skip_txqueue =3D skip;
> > +
> > +       return prev;
> >  }
> >  EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
> >  #endif
> > @@ -4824,6 +4837,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct =
net_device *sb_dev)
> >         int cpu, rc =3D -ENOMEM;
> >         bool again =3D false;
> >         struct Qdisc *q;
> > +       bool skip_txq;
> >
> >         skb_reset_mac_header(skb);
> >         skb_assert_len(skb);
> > @@ -4846,6 +4860,13 @@ int __dev_queue_xmit(struct sk_buff *skb, struct=
 net_device *sb_dev)
> >         skb_update_prio(skb);
> >
> >         tcx_set_ingress(skb, false);
> > +       /* The flag is per-CPU (per-task on PREEMPT_RT) and a nested xm=
it can
> > +        * set it from its own clsact hook or transmit qdisc. Own it fo=
r the
> > +        * whole frame: this frame cannot consume a nested xmit's flag =
and a
> > +        * nested xmit cannot inherit this frame's.
> > +        */
> > +       skip_txq =3D netdev_xmit_skip_txqueue(false);
>
> Hi Jamal
>
> Moving netdev_xmit_skip_txqueue() outside of
> static_branch_unlikely(&egress_needed_key) means every packet in
> __dev_queue_xmit() now pays for a per-CPU (or current->) read and two
> writes when CONFIG_NET_EGRESS=3Dy, even when no egress hook is active.
>
> Commit 2f1e85b1aee4 specifically used egress_needed_key to avoid this
> fast-path cost.
>
> Also, in __dev_queue_xmit(), txq is picked before q->enqueue() runs, so
> tcf_skbedit_act() setting skip_txqueue from q->enqueue() (or from
> ingress) has no effect on the current packet and only pollutes the
> per-CPU flag.
>
> I noticed that nf_skip_egress(skb, true/false) already brackets
> sch_handle_egress(). If we make skb->nf_skip_egress available under
> CONFIG_NET_EGRESS (instead of CONFIG_NETFILTER_SKIP_EGRESS),
> tcf_skbedit_act() can only arm skip_txqueue when running in
> sch_handle_egress().
>

Sounds reasonable. I will look into it tomorrow.

pw-bot: cr

cheers,
jamal

> Given this idea my LLM produced the following (untested) patch:
>
> diff --git a/include/linux/netfilter_netdev.h b/include/linux/netfilter_n=
etdev.h
> index 3175073a66ba6ba61db0f6d9d62c73ca15206ef0..2a854a0bbd4ba7b5c611b7aaf=
90b07711e57d9e0
> 100644
> --- a/include/linux/netfilter_netdev.h
> +++ b/include/linux/netfilter_netdev.h
> @@ -133,7 +133,7 @@ static inline struct sk_buff
> *nf_hook_egress(struct sk_buff *skb, int *rc,
>
>  static inline void nf_skip_egress(struct sk_buff *skb, bool skip)
>  {
> -#ifdef CONFIG_NETFILTER_SKIP_EGRESS
> +#ifdef CONFIG_NET_EGRESS
>         skb->nf_skip_egress =3D skip;
>  #endif
>  }
> diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> index 95729339e7a54819b08e124bd36126cf71dfd9a4..a54ec40d095c041191ca44f7c=
4334aa37fa6b891
> 100644
> --- a/include/linux/rtnetlink.h
> +++ b/include/linux/rtnetlink.h
> @@ -186,7 +186,12 @@ void net_dec_ingress_queue(void);
>  #ifdef CONFIG_NET_EGRESS
>  void net_inc_egress_queue(void);
>  void net_dec_egress_queue(void);
> -void netdev_xmit_skip_txqueue(bool skip);
> +bool netdev_xmit_skip_txqueue(bool skip);
> +#else
> +static inline bool netdev_xmit_skip_txqueue(bool skip)
> +{
> +       return false;
> +}
>  #endif
>
>  void rtnetlink_init(void);
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 84308498a3a8cd5a86364e0b15ddb35755732635..a3ff380d43f01db0b040573c9=
dd7acc4e2e2cda8
> 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1020,7 +1020,7 @@ struct sk_buff {
>  #ifdef CONFIG_NET_REDIRECT
>         __u8                    from_ingress:1;
>  #endif
> -#ifdef CONFIG_NETFILTER_SKIP_EGRESS
> +#ifdef CONFIG_NET_EGRESS
>         __u8                    nf_skip_egress:1;
>  #endif
>  #ifdef CONFIG_SKB_DECRYPTED
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index f35bd06a6bad680586da6b8ef20efc5d6b68fd6d..1acaadb3e2cf08827bb0d94e1=
649cfeb9e9c85ac
> 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -810,6 +810,15 @@ static inline bool skb_at_tc_ingress(const struct
> sk_buff *skb)
>  #endif
>  }
>
> +static inline bool skb_at_tc_egress(const struct sk_buff *skb)
> +{
> +#ifdef CONFIG_NET_EGRESS
> +       return skb->nf_skip_egress && !skb_at_tc_ingress(skb);
> +#else
> +       return false;
> +#endif
> +}
> +
>  static inline bool skb_skip_tc_classify(struct sk_buff *skb)
>  {
>  #ifdef CONFIG_NET_CLS_ACT
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f660fccfc0dbc56d7e1a9643525229b278bca547..8638c994bbcb0d1bf25ed603f=
833f105236a45bf
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4404,9 +4404,14 @@ EXPORT_SYMBOL(dev_loopback_xmit);
>  static struct netdev_queue *
>  netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
>  {
> -       int qm =3D skb_get_queue_mapping(skb);
> +       int queue =3D skb_get_queue_mapping(skb);
> +       int capped;
>
> -       return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
> +       capped =3D netdev_cap_txqueue(dev, queue);
> +       if (unlikely(capped !=3D queue))
> +               skb_set_queue_mapping(skb, capped);
> +
> +       return netdev_get_tx_queue(dev, capped);
>  }
>
>  #ifndef CONFIG_PREEMPT_RT
> @@ -4415,9 +4420,13 @@ static bool netdev_xmit_txqueue_skipped(void)
>         return __this_cpu_read(softnet_data.xmit.skip_txqueue);
>  }
>
> -void netdev_xmit_skip_txqueue(bool skip)
> +bool netdev_xmit_skip_txqueue(bool skip)
>  {
> +       bool prev =3D netdev_xmit_txqueue_skipped();
> +
>         __this_cpu_write(softnet_data.xmit.skip_txqueue, skip);
> +
> +       return prev;
>  }
>  EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
>
> @@ -4427,9 +4436,13 @@ static bool netdev_xmit_txqueue_skipped(void)
>         return current->net_xmit.skip_txqueue;
>  }
>
> -void netdev_xmit_skip_txqueue(bool skip)
> +bool netdev_xmit_skip_txqueue(bool skip)
>  {
> +       bool prev =3D netdev_xmit_txqueue_skipped();
> +
>         current->net_xmit.skip_txqueue =3D skip;
> +
> +       return prev;
>  }
>  EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
>  #endif
> @@ -4848,21 +4861,25 @@ int __dev_queue_xmit(struct sk_buff *skb,
> struct net_device *sb_dev)
>         tcx_set_ingress(skb, false);
>  #ifdef CONFIG_NET_EGRESS
>         if (static_branch_unlikely(&egress_needed_key)) {
> +               bool skip_txq;
> +
>                 if (nf_hook_egress_active()) {
>                         skb =3D nf_hook_egress(skb, &rc, dev);
>                         if (!skb)
>                                 goto out;
>                 }
>
> -               netdev_xmit_skip_txqueue(false);
> +               skip_txq =3D netdev_xmit_skip_txqueue(false);
>
>                 nf_skip_egress(skb, true);
>                 skb =3D sch_handle_egress(skb, &rc, dev);
> -               if (!skb)
> +               if (!skb) {
> +                       netdev_xmit_skip_txqueue(skip_txq);
>                         goto out;
> +               }
>                 nf_skip_egress(skb, false);
>
> -               if (netdev_xmit_txqueue_skipped())
> +               if (netdev_xmit_skip_txqueue(skip_txq))
>                         txq =3D netdev_tx_queue_mapping(dev, skb);
>         }
>  #endif
> diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
> index bfec6b66841031cd566d0c2bdc3d120cec41e3e4..26258b353cdeec48063413770=
439878d27ed60cf
> 100644
> --- a/net/sched/act_skbedit.c
> +++ b/net/sched/act_skbedit.c
> @@ -72,9 +72,8 @@ TC_INDIRECT_SCOPE int tcf_skbedit_act(struct sk_buff *s=
kb,
>         }
>         if (params->flags & SKBEDIT_F_QUEUE_MAPPING &&
>             skb->dev->real_num_tx_queues > params->queue_mapping) {
> -#ifdef CONFIG_NET_EGRESS
> -               netdev_xmit_skip_txqueue(true);
> -#endif
> +               if (skb_at_tc_egress(skb))
> +                       netdev_xmit_skip_txqueue(true);
>                 skb_set_queue_mapping(skb, tcf_skbedit_hash(params, skb))=
;
>         }
>         if (params->flags & SKBEDIT_F_MARK) {
