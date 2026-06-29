Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19900212542
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740211; cv=pass; b=k1yrxDBgPkFqQPbiMJsFbO9auNUkd5vMWI/w5pKnufcPUftTUNJHJnNuF+iAeeBpGrjPkhuMKTLyVSA23B7VZHOEnKcHqCrsoIEROHPKIACQaUVZ32L2EI5hlurLyLLrKl9rNOKMAuE0SzEMN6E8UwD7NIqgFMHSmzAV6eDk9pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740211; c=relaxed/simple;
	bh=63lofoxmoTkPkP+On9EcCD/u2aY+hRY5Y13B3u+XchY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9kFRLNzI8CbgrEdbG6cLx8+ePdacL6spnbE+LXKoH9bVsuZfqvarO0iba9gdAFJvLCtge3InXnhly5xSRygabsCim05eL2wxmGzTKMP8z2aUbNHPhFozy6yHEw8lIx9aIxeoWzwW/HVP3LJ7heEF5W5p1ulbvuL6vy/hC8X75g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=nR9PtKtK; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="nR9PtKtK"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664d35b4777so1002066d50.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 06:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782740207; cv=none;
        d=google.com; s=arc-20260327;
        b=pXRuN6ApXAfXnnipVYnUa9bT4vQ3s+4FiRfx60tBastSMgIPqQrhCiEV6P3+RuLUhN
         4hAwBE9wOPI0wxFijquCLnq0545K1Q7pcVar4rgr3as7GoTBcvyrmsVpKr5YFAS8g9dj
         d5CUAgMh030fMmJXFmr/s0qdtf+2MzNtbhaT4SvBp+w7ZLh+xR9s5n43dyK8/z2jfoJQ
         39/MtVALQ9maZkC4FiUd0t8/AwHPU//zyVUBa2+MB16BqJUGy3xPM7loZ16t0fZVjH4v
         mH7aar9lUzRCvFcaavSXJocuINos0SiAnwPEVfQnCZGjArLGyG4WJzSpFN62PFiRLIBw
         0OIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oDbyRh3fTgf4tBOVB2qqJBGMQIPOV/l55CAA+e7Q0Ko=;
        fh=kH4iYSwjptCd6O7nvU9bTQx/SAqc1t/7viKf/Zh3w44=;
        b=C/H5Sm6ruDhykgaf8qE53s2yY0xSxD8sLDFLAZ2PRgsH6X/SaWp0Lo0s9U0kyYDCoJ
         5KT8HcCAOJIKm15sW6QAPWUggB/HKQJCCx7Yl7jx5q21niCJG0jrcBMXJDrZ5C+UGPsB
         XSFCoSkvb9E1qnvo5rB5/oxvANJikr340To6MsugGcOD0k5bKrOEDfbJPda+om0BqCYr
         ysM5+iB9F0liBeSy7EfZ2szVzop9qgjcbmjWXLQ6nmTrBuqmr4LQQZR8NRLisdND1TUX
         gcY/inqgCUC3XDw37sCxRTi2HkAyTjsbVAFTGabM+4zVkBgJLM+P9imMDmaYDMFN3IYX
         8h6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782740207; x=1783345007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDbyRh3fTgf4tBOVB2qqJBGMQIPOV/l55CAA+e7Q0Ko=;
        b=nR9PtKtKXcsYkdXUIdTIE9cO17G23LFw1znLg3Ed1gfByzqSXPRaIXKyQ/SH2Dn1EB
         mrnOPjUiuevzyQeLTLb0L9kU/AJe49YX+32driZf1jnIF+D0ZoToT3KHZYnffBbJEJxX
         d5dlT39es1CKGbdglITwgF/pHo75Kk3gh5JJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782740207; x=1783345007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDbyRh3fTgf4tBOVB2qqJBGMQIPOV/l55CAA+e7Q0Ko=;
        b=KfbPUOY6/WDV+uR5xZbqcKXH3XOamLPEPyQI0CdrodUezsd8UozmNDBvEF/PMBBXXR
         YyCj2wfRfkCmIvzDKZ88ASlYE0udJBAVEg3iAyXLlvO8q2A5T3+CpQc44b3pCAG5ovu1
         lniO8Yf9IU0YfvcIJiGWQ8aSu7lI2y22bZZSePfZbboi2eKMJkldFMpm/eTn4Xpz6Edr
         rlKz9uEsFOkMTQ73rn7hBf36YOHmUivyNa58J8mdHhHjN/mdBIfVdif5JYreXqzFGyfe
         CASzv8yNcx2b9cA0wVsKeWdyxmpx+r0xZjFeCo+UozeC0bEMqPM+JiV8OqpmTXVMh83H
         2H3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrbWdp1olQsnzS6Uj6M5xD/5ElCKpKaU8VOT3a+EChssxNZuKut54xv6tZzknAhXroLX1hsvS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxZRt4ggJOaGn0j2pI9Vh/NxqTXWXRAFc53QoidXxZg1GUIxI
	FP6/1Rk9nOrgGeREP6PdsILy9r662nojhx8GseAKjNbx81pZuaLmArcpBgtljhoVJb1PfYxIVsJ
	FNF7Jps4+pTcwlxa0/OUXpi0osXZ3X2F7yEu1nJqB
X-Gm-Gg: AfdE7cnWutgevnaimxdtj+NK54Zi3x6vlSFIocFLql8jsN3mnYzOHs7IavDMBkV2X0c
	TtM/pPZXlCCJIkNe+NCt4VI7h7Zuxnfu4gnScaSLNWu+tQs7T4mJyd5kayLzZrtux4SwgTkt7jm
	PHUTtKJLhma+IYxZ5jgxipcz5WgS4DlxScth4T6IIURDb5hA4ThyMQTYZp9W7hNuJ09gP7MdVk1
	6EEfIX7K89YoF/zPzLKozdn7hTFTgRHRP8ZlHiQ1PkpLuM1/Bn6y2jbKLnEgfn4MEkdQuGRdQ==
X-Received: by 2002:a05:690e:418f:b0:664:ac71:be8f with SMTP id
 956f58d0204a3-664f6190089mr355103d50.38.1782740206961; Mon, 29 Jun 2026
 06:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629102157.737306-1-jhs@mojatatu.com> <20260629102157.737306-2-jhs@mojatatu.com>
 <a1a31c1e-b5bf-458f-a80a-bc324fc7a07c@iogearbox.net>
In-Reply-To: <a1a31c1e-b5bf-458f-a80a-bc324fc7a07c@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 29 Jun 2026 09:36:35 -0400
X-Gm-Features: AVVi8CeFUI2MPyXmRqhDLZ9Wl-8wZ6pymjWmYvdUKB_BvxOx9JYlNl3_eWADSSU
Message-ID: <CAM0EoM=QsOZ+mbWk7Ysv8-UNMzbmzbYiNXvF9fjEnG1-bDv6YQ@mail.gmail.com>
Subject: Re: [PATCH net 1/3 v2] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, toke@toke.dk, Steven Rostedt <rostedt@goodmis.org>, 
	Petr Machata <petrm@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 9:01=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Hi Jamal,
>
> On 6/29/26 12:21 PM, Jamal Hadi Salim wrote:
> > The bpf_net_context used by sch_handle_egress() is stack-allocated and =
torn
> > down in that function returned. By the time tcf_qevent_handle() runs
> > current->bpf_net_context is NULL.
> >
> > When a filter attached to a qevent block (e.g. RED's early_drop or mark
> > qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
> > tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf he=
lper
> > bpf_net_ctx_get_ri().  That helper unconditionally dereferences
> > current->bpf_net_context resulting in a NULL pointer dereference.
> >
> > Note: The same holds for actions that invoke BPF redirect helpers
> > (e.g. act_bpf running a program that calls bpf_redirect()) during qeven=
t
> > classification itself.
> >
> > Fix:
> > Move the bpf_net_context lifecycle out of sch_handle_egress() into
> > __dev_queue_xmit(), so that it spans both the egress TC fast path and t=
he
> > qdisc enqueue.
> > Note: The call is placed outside the egress_needed_key static branch
> > to cover the case where clsact static key is disabled. Unfortunately th=
is
> > adds a small unconditional penalty to the code path _per packet_ only
> > guarded by CONFIG_NET_XGRESS (two writes and one read).
> >
> > As pointed by sashiko [1]:
> > The same context must also be set up in net_tx_action()'s qdisc drain
> > path, since qdisc_run() -> netem_dequeue() -> qdisc_enqueue( RED child)
> > can trigger qevent classification asynchronously from softirq context.
> >
> > This keeps all bpf_net_context management in net/core/dev.c i.e the
> > existing boundary between tc core and BPF without requiring any net/sch=
ed/
> > code to know about BPF plumbing.
> >
> > Reproducer:
> >
> >    tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB=
 \
> >        avpkt 1000 burst 100 qevent early_drop block 10
> >    tc filter add block 10 pref 1 bpf obj redirect.o
> >
> >    traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() a=
nd,
> >    on a redirect verdict, a NULL deref in skb_do_redirect().
> >
> > Fixes: 3625750f05ec ("net: sched: Introduce helpers for qevent blocks")
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Could we simplify patch 1 & 2 by just moving the bpf_net_ctx_set() and
> bpf_net_ctx_clear() into a tcf_classify_qdisc() wrapper where we don't
> end up having to touch the core TX code?
>
> Untested diff :
>

This is bpf plumbing which doesnt belong in tc really. You already
moved most ebpf/clsact stuff into dev.c - let's just keep it there.

As a side note: calling a hierachy of N qdiscs we would incur N
set/clear cycles for N levels =E2=80=94 and worse, qdiscs like HTB and HFSC
iterate filters while loop calling tcf_classify_qdisc() per iteration,
so each filter chain traversal does set/clear per proto.

cheers,
jamal

> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index 3bd08d7f39c1..1828cc16c5d7 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -93,6 +93,8 @@ int tcf_classify(struct sk_buff *skb,
>                  const struct tcf_block *block,
>                  const struct tcf_proto *tp, struct tcf_result *res,
>                  bool compat_mode);
> +int tcf_classify_qdisc(struct sk_buff *skb, const struct tcf_proto *tp,
> +                      struct tcf_result *res, bool compat_mode);
>
>   static inline bool tc_cls_stats_dump(struct tcf_proto *tp,
>                                      struct tcf_walker *arg,
> @@ -157,6 +159,13 @@ static inline int tcf_classify(struct sk_buff *skb,
>         return TC_ACT_UNSPEC;
>   }
>
> +static inline int tcf_classify_qdisc(struct sk_buff *skb,
> +                                    const struct tcf_proto *tp,
> +                                    struct tcf_result *res, bool compat_=
mode)
> +{
> +       return tcf_classify(skb, NULL, tp, res, compat_mode);
> +}
> +
>   #endif
>
>   static inline unsigned long
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 3e67600a4a1a..982409702c7f 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -23,6 +23,7 @@
>   #include <linux/jhash.h>
>   #include <linux/rculist.h>
>   #include <linux/rhashtable.h>
> +#include <linux/filter.h>
>   #include <net/net_namespace.h>
>   #include <net/sock.h>
>   #include <net/netlink.h>
> @@ -1884,6 +1885,24 @@ int tcf_classify(struct sk_buff *skb,
>   }
>   EXPORT_SYMBOL(tcf_classify);
>
> +int tcf_classify_qdisc(struct sk_buff *skb, const struct tcf_proto *tp,
> +                      struct tcf_result *res, bool compat_mode)
> +{
> +       struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> +       int ret;
> +
> +       bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
> +       ret =3D tcf_classify(skb, NULL, tp, res, compat_mode);
> +       bpf_net_ctx_clear(bpf_net_ctx);
> +
> +       if (unlikely(ret =3D=3D TC_ACT_REDIRECT)) {
> +               pr_warn_once("TC_ACT_REDIRECT from qdisc filter chains is=
 not supported\n");
> +               ret =3D TC_ACT_SHOT;
> +       }
> +       return ret;
> +}
> +EXPORT_SYMBOL(tcf_classify_qdisc);
> +
>   struct tcf_chain_info {
>         struct tcf_proto __rcu **pprev;
>         struct tcf_proto __rcu *next;
> @@ -4033,7 +4052,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent=
 *qe, struct Qdisc *sch, stru
>
>         fl =3D rcu_dereference_bh(qe->filter_chain);
>
> -       switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
> +       switch (tcf_classify_qdisc(skb, fl, &cl_res, false)) {
>         case TC_ACT_SHOT:
>                 qdisc_qstats_drop(sch);
>                 __qdisc_drop(skb, to_free);
> @@ -4045,10 +4064,6 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qeven=
t *qe, struct Qdisc *sch, stru
>                 __qdisc_drop(skb, to_free);
>                 *ret =3D __NET_XMIT_STOLEN;
>                 return NULL;
> -       case TC_ACT_REDIRECT:
> -               skb_do_redirect(skb);
> -               *ret =3D __NET_XMIT_STOLEN;
> -               return NULL;
>         case TC_ACT_CONSUMED:
>                 *ret =3D __NET_XMIT_STOLEN;
>                 return NULL;
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index a3c185505afc..94eb47ac54ee 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1730,7 +1730,7 @@ static u32 cake_classify(struct Qdisc *sch, struct =
cake_tin_data **t,
>                 goto hash;
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       result =3D tcf_classify(skb, NULL, filter, &res, false);
> +       result =3D tcf_classify_qdisc(skb, filter, &res, false);
>
>         if (result >=3D 0) {
>   #ifdef CONFIG_NET_CLS_ACT
> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> index 020657f959b5..91b1ef824afa 100644
> --- a/net/sched/sch_drr.c
> +++ b/net/sched/sch_drr.c
> @@ -312,7 +312,7 @@ static struct drr_class *drr_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         fl =3D rcu_dereference_bh(q->filter_list);
> -       result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       result =3D tcf_classify_qdisc(skb, fl, &res, false);
>         if (result >=3D 0) {
>   #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index 5434df6ca8ef..98364f74211e 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -364,7 +364,7 @@ static int dualpi2_skb_classify(struct dualpi2_sched_=
data *q,
>                 return NET_XMIT_SUCCESS;
>         }
>
> -       result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       result =3D tcf_classify_qdisc(skb, fl, &res, false);
>         if (result >=3D 0) {
>   #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index cb8cf437ce87..25fcf4079fec 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -391,7 +391,7 @@ static struct ets_class *ets_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         if (TC_H_MAJ(skb->priority) !=3D sch->handle) {
>                 fl =3D rcu_dereference_bh(q->filter_list);
> -               err =3D tcf_classify(skb, NULL, fl, &res, false);
> +               err =3D tcf_classify_qdisc(skb, fl, &res, false);
>   #ifdef CONFIG_NET_CLS_ACT
>                 switch (err) {
>                 case TC_ACT_STOLEN:
> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index cafd1f943d99..6cce86ba383c 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -91,7 +91,7 @@ static unsigned int fq_codel_classify(struct sk_buff *s=
kb, struct Qdisc *sch,
>                 return fq_codel_hash(q, skb) + 1;
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       result =3D tcf_classify(skb, NULL, filter, &res, false);
> +       result =3D tcf_classify_qdisc(skb, filter, &res, false);
>         if (result >=3D 0) {
>   #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
> index 72f48fa4010b..069e1facd413 100644
> --- a/net/sched/sch_fq_pie.c
> +++ b/net/sched/sch_fq_pie.c
> @@ -96,7 +96,7 @@ static unsigned int fq_pie_classify(struct sk_buff *skb=
, struct Qdisc *sch,
>                 return fq_pie_hash(q, skb) + 1;
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       result =3D tcf_classify(skb, NULL, filter, &res, false);
> +       result =3D tcf_classify_qdisc(skb, filter, &res, false);
>         if (result >=3D 0) {
>   #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index 7e537295b8b6..e87f5021a199 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -1143,7 +1143,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sc=
h, int *qerr)
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         head =3D &q->root;
>         tcf =3D rcu_dereference_bh(q->root.filter_list);
> -       while (tcf && (result =3D tcf_classify(skb, NULL, tcf, &res, fals=
e)) >=3D 0) {
> +       while (tcf && (result =3D tcf_classify_qdisc(skb, tcf, &res, fals=
e)) >=3D 0) {
>   #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
>                 case TC_ACT_QUEUED:
> diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> index 908b9ba9ba2e..fdac0dc8f35a 100644
> --- a/net/sched/sch_htb.c
> +++ b/net/sched/sch_htb.c
> @@ -243,7 +243,7 @@ static struct htb_class *htb_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>         }
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       while (tcf && (result =3D tcf_classify(skb, NULL, tcf, &res, fals=
e)) >=3D 0) {
> +       while (tcf && (result =3D tcf_classify_qdisc(skb, tcf, &res, fals=
e)) >=3D 0) {
>   #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
>                 case TC_ACT_QUEUED:
> diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
> index 4e465d11e3d7..004f0d275caf 100644
> --- a/net/sched/sch_multiq.c
> +++ b/net/sched/sch_multiq.c
> @@ -36,7 +36,7 @@ multiq_classify(struct sk_buff *skb, struct Qdisc *sch,=
 int *qerr)
>         int err;
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       err =3D tcf_classify(skb, NULL, fl, &res, false);
> +       err =3D tcf_classify_qdisc(skb, fl, &res, false);
>   #ifdef CONFIG_NET_CLS_ACT
>         switch (err) {
>         case TC_ACT_STOLEN:
> diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
> index e4dd56a89072..79437c587e7e 100644
> --- a/net/sched/sch_prio.c
> +++ b/net/sched/sch_prio.c
> @@ -39,7 +39,7 @@ prio_classify(struct sk_buff *skb, struct Qdisc *sch, i=
nt *qerr)
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         if (TC_H_MAJ(skb->priority) !=3D sch->handle) {
>                 fl =3D rcu_dereference_bh(q->filter_list);
> -               err =3D tcf_classify(skb, NULL, fl, &res, false);
> +               err =3D tcf_classify_qdisc(skb, fl, &res, false);
>   #ifdef CONFIG_NET_CLS_ACT
>                 switch (err) {
>                 case TC_ACT_STOLEN:
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index cb56787e1d25..6f3b7273cb16 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -709,7 +709,7 @@ static struct qfq_class *qfq_classify(struct sk_buff =
*skb, struct Qdisc *sch,
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>         fl =3D rcu_dereference_bh(q->filter_list);
> -       result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       result =3D tcf_classify_qdisc(skb, fl, &res, false);
>         if (result >=3D 0) {
>   #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
> index b1d465094276..ed39869199c0 100644
> --- a/net/sched/sch_sfb.c
> +++ b/net/sched/sch_sfb.c
> @@ -260,7 +260,7 @@ static bool sfb_classify(struct sk_buff *skb, struct =
tcf_proto *fl,
>         struct tcf_result res;
>         int result;
>
> -       result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       result =3D tcf_classify_qdisc(skb, fl, &res, false);
>         if (result >=3D 0) {
>   #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> index 758b88f21865..77675f9a4c46 100644
> --- a/net/sched/sch_sfq.c
> +++ b/net/sched/sch_sfq.c
> @@ -171,7 +171,7 @@ static unsigned int sfq_classify(struct sk_buff *skb,=
 struct Qdisc *sch,
>                 return sfq_hash(q, skb) + 1;
>
>         *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -       result =3D tcf_classify(skb, NULL, fl, &res, false);
> +       result =3D tcf_classify_qdisc(skb, fl, &res, false);
>         if (result >=3D 0) {
>   #ifdef CONFIG_NET_CLS_ACT
>                 switch (result) {
>
> Thanks,
> Daniel
