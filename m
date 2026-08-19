Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E43B7B98
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150588; cv=pass; b=FdAQYu/0tBeNSgzmcHOHRe7LsmtLZzWEOGp+sg2YNlBXAimVZf+ELPXu9/KcNY1g/5mr4FolijaDS48j/89UjPUvQ7Wc2QtpE4lGkCSeuxLF+5ImB4fJbHUATSgo9LpClXk//AL+EdgFkBf7zc7Q36bNM7mZsEhYI7/jIA8WA0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150588; c=relaxed/simple;
	bh=MkqX0W8IbJPEwSSAUuHUDaPQT350a/qmK5/0HidHyVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXae7GZPGO3QCGUON/JpdrwfcB076zrXJeqBDyo/7Njkaw+DEJOV8jl10WcePOZFz2AHZNltFkHEg0Glg3mW+//GI5gIAZ8P8mXUcq4oAjRudXTkEVcqjLcPg072LiB7KD2kaURksrfo2vm9hoslRdhPK2rDee1lYyt9BBBq5rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B7mKCOca; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7mKCOca"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c2a818fc4so7113381cf.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150585; cv=none;
        d=google.com; s=arc-20260327;
        b=GBFrGYwF/3EXme9FThNGizuSs2VaFbSqwbvUj0juev+CsagkcZqfvtFdf+OGU780jr
         EwHz7PZDxcLLVvBDS9RJFNAnTpEmmvfLgxg4wxouh3oVaLIW3jfzfACRGVs9tbSIHniC
         WbuN0UU36N59wAJQQXpipmr3YakdF/2hx4GciUOVr+lcbbPS6CiNdIFxeK3HN6H8RpnB
         Srl0wI+Ugzw2Cw/crsbWxCvGW+aFwuTPjuzXox52SqUMYLdV7s37GUaHSC4qnWUdtNlF
         woMNKw/EguU9CqDZGKFYQj56HqDuY4pO0zmMMxOd9HNN7kUBflbQrnLrZ0iPOVdbdoXC
         pDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DBQbXhA0JVF+2Th06MfQYZbxuDaNHyaj/2CoNpK03dw=;
        fh=ab8oFpFf0i1nbqz9XuPZAm3MlOVuocdOkMJKo6eJoXw=;
        b=cwIWqGYlSalbFvTGL/m2RNQQdJl/xyWe7BgOzQaGLmrTGsQNXVEes6bXTYBQM2lSqZ
         sIxKqftv5CQ/wr0DUZjdDyRt1G3nHlpMOEkOeD/WHLYleI4ug2c4ZMs9K3LfY6sUowP9
         VCRWkYAuubf8h/WgvpGBXZxoWDNL8yyEKSU2CUEep5htCDjmYo7g7nDkQfnbM49P6rTL
         BdNQl1fP5PKD0wGrYhY49h9eUlX0cO8y82YVQcpAMkmnKysqW8koQSdAyiZovz+mbeVz
         u8YhNUHT0QsOb7+jR2fvQfu4rfWhcQ6W1fZzZqyFAVAUS5fZYzCZ7MQP2DpzLg7rNn0W
         32YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787150585; x=1787755385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DBQbXhA0JVF+2Th06MfQYZbxuDaNHyaj/2CoNpK03dw=;
        b=B7mKCOcaL1tw4wU4Oecdr3AsO7InUl8BbU/DNW4ZG8Ywlj+IFySqq17K2gtSM0axo7
         D9N3YeGB/byXpV+eGLsGygcRSQ/WIB3fF8RjfqpP0AyhaeFEYC21WDOI34E3NEAbPnnJ
         97zJ0LR9S1r4VzjJ0qR22oBYyXiO5vv1adk+tetgWBNS2dfTWwoa1hMLeXtSN+CSwxnH
         AYmOQOp/ZuKjHUQDOYE4KAgFTBbUerMuxobBkrlByBYmqUibx6SQWgPUYLLH8RKi/aTT
         noDm1AFawWX9ff1Gn4EK4hspK+IqlYVAzvISaXCrRJbpmCvpPkdk+C920w6Ux60PyNuD
         Dq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150585; x=1787755385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DBQbXhA0JVF+2Th06MfQYZbxuDaNHyaj/2CoNpK03dw=;
        b=rGQA/MaRXRHD8H4zRE65eKUgq7/+mQDuka9z67hHJhxPMkLQjHqryByGHV1GFgRC0q
         1Juw7Ge5NAJv0ALHUCcN97zf0ERkTVAthH8C8MjE85A1TPRyQpt4AqwxAXQcvQdQHcBl
         Zl7DlYhGtOAQDM6MotvTufs/YInKuwYCHpX1gWW5ZxE2C/qW+TU5XlCxJOCSKYbKf+kU
         uoWbwDNEVMIbe7jaU5WX+EeAfLqVzUn9rIj8UsiuZkrWtVK1CxZmB7Um2rFFSpkh8STE
         GkETdsJEeWdPzRqrcw9hq3LnUfLcPJMp8Bp3v6p02GVDcKjm8sdVxHPWkEA7hhIzCIim
         DLIQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTvw1HDovAzWD0IK4XkDLHYk4ni63EHHnD6nP3SSY6BXSQWQTEE5gogG3LP4T0/Fx7DwbgF7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvhabbrKIQedekvV4NusBmv6UBd0B0ixIsHDiz2PSZm+XmHi72
	yCkerMTKiVmL8/LTdw52qhaJqz9yHUAvI/lKzS3oWRfH8NmCJof+eulpIGj2W15YNwRWNoqz4S4
	Apvm9ULP7v3IGEuGbxtOEOJ1rHR4Vji5tOwa/WGcNE9GnmWLR0e7qjhrbReg=
X-Gm-Gg: AR+sD13k8w4Y5eJL7ooa12wnpwEpq/3glfWivt3VW/BQRgQbBMK17vjbFRYoaRBymCp
	JwVMQpqhgxdiRKAPjN5PV7yPEqHWZvidjxXDFp3cFK0xYSmj9CUG+Vg1PtWN3N26+vgnNEU02wm
	mWJXb9GIx/kgwLmdaBwnFVBpzDV4666fy5+53GhEgHMT73dqADVczvvFcCTPY/Mc/bOFqtPAFrO
	FXNjnNRb4r216f2EqDz8AGnIj1K/iBysB1zHpF4sKQB1Z2LoiCIpJKhwaPLdxWgr4hsxuUXl6On
	yWYZzKhgv1lw0PKZ+6CYC5vALcauj4k2C9rYC2PYE/f2mwX4aFGY7xHidN8Gmt24HZyu2n51cO0
	7JbYfZqhxO6ulj9mV1P4Wo3t90uhM++ArUwP4mmiXTE/lZNna3wK7wJfq9K8JFrK18lB8oyc043
	5w4yl+9+sH6jp6n/w=
X-Received: by 2002:ac8:5953:0:b0:51b:f40b:2fb5 with SMTP id
 d75a77b69052e-52dd577f088mr42352351cf.17.1787150584067; Wed, 19 Aug 2026
 07:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com>
In-Reply-To: <20260819143136.57350-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 16:42:51 +0200
X-Gm-Features: AcwNN1U9GKxgnOJkc2Jr561s0UMwJEgI4co2sC_RH90OJcR66PZEiypnkkQ35Js
Message-ID: <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 4:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Several qdiscs derive their per-flow quantum or backlog from psched_mtu()
> or accumulate qdisc_pkt_len() into a u32/int counter without an overflow
> or zero clamp, which can drive the dequeue/credit-refill loop into a soft
> lockup or a NULL deref.
>
> vega@nebusec.ai provided reports and PoCs which illustrated the following=
:
>
> - sch_fq: fq_init() computes quantum =3D 2 * psched_mtu() with no overflo=
w
>   check; a huge MTU wraps it into the sign bit, and fq_dequeue()'s
>   credit-refill loop spins forever. TCA_FQ_INITIAL_QUANTUM is also
>   unbounded up to INT_MAX in fq_change().
> - sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a u32
>   per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a few
>   packets wrap the counter to 0, and fq_codel_drop() then picks an empty
>   flow and derefs NULL. fq_codel_init() also sets quantum =3D
>   psched_mtu() with no clamp, so a huge MTU makes the deficit loop spin.
> - sch_fq_pie: fq_pie_init() sets quantum =3D psched_mtu() with no clamp a=
nd
>   fq_pie_change() accepts any u32 quantum; same deficit-loop spin as
>   fq_codel on a huge-MTU dummy device.
> - sch_hhf: hhf_init() sets quantum =3D psched_mtu() with no overflow chec=
k;
>   a huge MTU makes weight * quantum overflow the signed deficit, and
>   hhf_dequeue() loops forever.
> - sch_sfq: sfq_init() sets quantum =3D psched_mtu() (unsigned); a huge MT=
U
>   makes allot =3D INT_MIN, and INT_MIN + INT_MIN is UB that toggles betwe=
en
>   INT_MIN and 0 forever.
>
> Clamp the quantum to a sane range at init/change time so the dequeue loop=
s
> terminate and the drop path never selects an empty flow. The clamps live =
in
> the init/change paths, not the per-packet fast path, so no hot-path cost =
is
> added for a configuration issue.
>
> Conditions to recreate the bug: a device whose MTU (plus hard_header_len)
> is large enough that 2 * psched_mtu() or psched_mtu() wraps into the sign
> bit (e.g. a dummy device with max_mtu =3D=3D 0 accepting a huge MTU), or =
a
> crafted TCA_STAB that inflates qdisc_pkt_len to ~1 GiB. Requires
> CAP_NET_ADMIN in a user namespace (Level 2) to configure the qdisc and MT=
U.
>
> Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
> Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
> Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> v1 to v2
> Changes based on feedback from Eric and Sashikos[1][2] on V1.
>
> 1. Drop the fast-path changes in fq_dequeue() (Eric)
>
> 2. Clamp to a range, not just a lower bound (Eric). Uses
>    clamp_t(u32, ..., 1, 1 << 20) (upper bound 1M; lower bound 1, not 256)=
.
>    Sashiko (gemini, nipa gpt-5-6-sol-1-5) pointed out the v1 max_t() left
>    bit 31 set, so a 0x80000000 quantum survived and still spun.
>    Upper bound is 1M, not Eric's suggested 16M. fq_change() already caps
>    TCA_FQ_QUANTUM at 1M; using 16M in fq_init() would be inconsistent.
>
> 3. Clamp TCA_FQ_INITIAL_QUANTUM in fq_change() too (Eric). It was unbound=
ed
>    up to INT_MAX; v2 clamps it to > 0 && <=3D 1M, matching TCA_FQ_QUANTUM=
.
>
> 4. Fold fq_codel_init() quantum clamp (Sashiko gemini + nipa gpt-5-6-sol-=
1-6)
>
> 5. Fold fq_pie_init()/fq_pie_change() quantum clamp (Sashiko gemini):
>
> 6. Reword the hhf/sfq comments (Sashiko nipa gpt-5-6-sol-2-15, gpt-5-6-so=
l-2-14)
>
> [1]https://sashiko.dev/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
> [2]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.162=
03-1-jhs@mojatatu.com
> ---
>  net/sched/sch_fq.c       | 17 ++++++++++++-----
>  net/sched/sch_fq_codel.c | 16 ++++++++++++++--
>  net/sched/sch_fq_pie.c   |  9 ++++++---
>  net/sched/sch_hhf.c      | 12 ++++++++++++
>  net/sched/sch_sfq.c      |  8 ++++++++
>  5 files changed, 52 insertions(+), 10 deletions(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 7cae082a9847..f7c92df085e7 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -1112,9 +1112,16 @@ static int fq_change(struct Qdisc *sch, struct nla=
ttr *opt,
>                 }
>         }
>
> -       if (tb[TCA_FQ_INITIAL_QUANTUM])
> -               WRITE_ONCE(q->initial_quantum,
> -                          nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]));
> +       if (tb[TCA_FQ_INITIAL_QUANTUM]) {
> +               u32 initial_quantum =3D nla_get_u32(tb[TCA_FQ_INITIAL_QUA=
NTUM]);
> +
> +               if (initial_quantum > 0 && initial_quantum <=3D (1 << 20)=
) {
> +                       WRITE_ONCE(q->initial_quantum, initial_quantum);
> +               } else {
> +                       NL_SET_ERR_MSG_MOD(extack, "invalid initial quant=
um");
> +                       err =3D -EINVAL;
> +               }
> +       }
>
>         if (tb[TCA_FQ_FLOW_DEFAULT_RATE])
>                 pr_warn_ratelimited("sch_fq: defrate %u ignored.\n",
> @@ -1226,8 +1233,8 @@ static int fq_init(struct Qdisc *sch, struct nlattr=
 *opt,
>

You should probably split these into separate patches to ease code review.

About TCA_FQ_INITIAL_QUANTUM in fq_change(), you could have changed iq_rang=
e
that was added in  commit 7041101ff6c3 ("net/sched: sch_fq: fix
integer overflow of "credit"")
