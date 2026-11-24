Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795539522;
	b=ypBhzb+EW+3+0TBm5BKVxvjfvxPiVlKmL0+CWlygv/f/6/iOV/3A+upo4pYU55kJrViC
	 wcnjezZKMijTVO7jhkAlI6wy6Kw91Gs/IxU+qCtYBguSB7WWoMevQf+5DL1SJKQJ8kytl
	 b4xysw+zlCLqo20I/1RtVb/dZ8c9xIrZamrVIXGzcchE/f8Iq77EEW3ATktd3zH9IZqK1
	 AVNVH41Nmjz8dqOGdNfA+hoZ9T3HD2reA+SCDgymSpDNsBARhsUeAkpsiKXoYtYVJTDam
	 KaA2W6YzJXpFJILOtdrKi1nBYu1fz467dmhsZUzNrTeNYMnKInCGBblVGZWhVSMOqCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5HjZJAjY5u3Fowj7izRJvXnGMFA618no4HsUeAZCCbU=;
	b=IuDso/EsLN+wj0hamn1hUNt/cEvsiTu8q0Oa4wZOYUAKEVblgrivdbkYcVu2hqF42Q5j
	 uQD8abR41rJQp0BzZYVMcgW5+rmSTy6PXTBao6ZsiB/jiwAI6/aBwfANe3QRKucV3dJoQ
	 150SHX2cIMwHLPznQOhVRSwcZukg+mxmZIY9JtsDcEjezy7mcINrfikkocGPakziLm27w
	 iTRqMasj75I+uGYDDHAztUCPo5SA+w0rckpYX927id5NOQVa9TfyQVgT90fHg6VESXxRZ
	 ZO9xyAq5k8Z+1OzBR1AmF3tRsmAK7E5cagJ9WOELPt5uhgdTLqScM+0F9LTmEj3x09Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=YeeksOgb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF3606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24EF3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=YeeksOgb
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8c70c2ab5a2so1845059b3a.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:58:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795539521; cv=none;
        d=google.com; s=arc-20260327;
        b=cAkR0TqqGcTU6DPOhBAJiApYIdk+pTNDZJbSTRceZvvXF1iKE3L0ar5FS2HN/39tFB
         SSTzBzzqCSJ0ZhFUK34Cw8yev/ueVvvm8RYoxd9ItsD7fVl3Gj9qU7+2qKu/OWxAR06G
         +YodGGyigHv1CG4jr0HM+kzR06g6l2PaxOVRpQ1Vg6a/VTglHuqkSoHb+KJhLTd9p/HJ
         bgh6neINLiEEDvs3djJzFHCG0Cmm/3KuTGAQPZtWJnwxqQW1GJRGTf3lGDwsSHwxar6V
         TaINIHPLez9BU4WdRuSSG2m36Au2FYRZizgQEqmvF9Rbnf49t/KD0eL0O5FRrqyf3rgk
         z3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5HjZJAjY5u3Fowj7izRJvXnGMFA618no4HsUeAZCCbU=;
        fh=l9yXYtkQMDFt1JgZSg7SO6pnc4ihUydeyrRqKGgdgSA=;
        b=F4iuULUwvK80fq/LLb3F5rrtdOzWk5j+0YqfT8exZaPyj8zP/5LI1Wh3ClNrWmC87+
         DR+EU07tl3ot1D+skpZITBnlrEtmdYM4h47GffpHA7OEFZuCIFo6pKDrn8Ky0TwmzzYD
         LXSx1Oj7qcSaa8OUl0OphuiQSAFCOnJ3JPJkhkmdLLk6kq+mus5ywOFHrlAGY5RrWEzM
         XgmFxqpTCHgnia7FcfhFGnbecCWE7lz3eHGrT9jYHA63HCnWbcvZNYbJ7TbE8kDwXtLC
         0YnOt1IIWyjLzNbGiIs3uKagAd3LjKZvfBBdv/Nm6T2NPv5ZI7i1pnTA2tg5im19JH06
         e/ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795539521; x=1796144321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5HjZJAjY5u3Fowj7izRJvXnGMFA618no4HsUeAZCCbU=;
        b=YeeksOgbP/Ulct0x6tumOGXv0wn/ZsspZGvZfAkR27B9GIzuFGk73NNFZQ5WF53eKh
         Wroaprl5KEkWpWNY4Mm5HDKZtzlzvVltshd/1Qg3x19fEijmQ4z/Ei5Tt0cqTy1ieCTa
         meoBLb/33SzPZUHLTbZOF2qYBX/qaxU7al0oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795539521; x=1796144321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5HjZJAjY5u3Fowj7izRJvXnGMFA618no4HsUeAZCCbU=;
        b=CRnpgt2f4MEc5pRKckhMKKsItsB/Gfz8ShPP5cBsP3LexuJxX5J42SL7nwetXZArXM
         1lMK9yluDoDP7STn5RsiTGjGQrGzTJzNJpKj7Q9E3w7d0DdmxgCktr3beYWyBkLWlqgN
         w0IYjq0+P9fbuNlGO/P3/gS1MVLLGzMRScpGemmBKy/tNh2n3FjIWmt1JlgxTxQJVK4T
         S+uFq8wYu3ZxM0sC6fBs0NHj5hJbr8b2Moja1haCJhDDrg8KA7kg7pYj0skM59/Wh901
         /xNMGCCpy3e3GLMDf1OxHL1BsQkhIzXh1uDhpFkOd/d4Avo6AjGkslasLKkKUAz0V43V
         ErDg==
X-Forwarded-Encrypted: i=1; AL+hErGhRh0IzxVaWrbFIQD69uA+qVu/n9l0U7bUMc/jJjryY5q21idvL9lwuTSUrdL3vHRmRLKMq0M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YqBQ6RasgGOFJOGABbXAtxe9kOFY3RW0WMnZCSeLLD2ZYVsdA
	YM9hHGZxxqpW2rk1xoSvmISR/rNkAO1QunaPDXlBJIbyB72i/xKNWi2ZMVDKyU+KBvY4nH5sx/S
	16Dw+IlVpDavC1Ocj1Uih7hkj+o39QZsfj9k0qbWP
X-Gm-Gg: AZFdTZepmDPJ1uT2OlC9sj60OKcyoQv8bOv5nSfyIxXm6NNeqoHSfEKU1VrmXLpzCpU
	C33izyCTLvkfFlXrqKbXa8pELJ26zb7y/ntby4bmz/pL1wN3C5trtC66S7LjLiyvFKR1zY53EPL
	xm2FDwZelrBBRDg1qaUuHuTOO6BUJXoS105fUWIFCpTobYMD8cp95nq1LEpCpMCj43lGyKPy5el
	1s2xnqHOheNa8pgWRR++COMpM7im4omNjpJHoM0r0/R3VhPiCGvDr4v5yErFogESE6Z8e/o+i+J
	PJ1vnhotYKTzcJ/Cbgq2VI5av1OLH6PC9ITDPXSH5G+Oa7MrygwIT+nwpOLIj4sAkTjf5IDRud3
	A/c2UbsKkhs0rHPmMtT6TX/bMnCMDghAuUmvh9NATUs0Tj6iBC0vG/gUQgzLmoTey15n9syfXck
	0uhVlHYWY8nKKh8ic=
X-Received: by 2002:a05:6a21:6116:b0:3e2:1418:aae8 with SMTP id
 adf61e73a8af0-4014dd566d2mr15911153637.72.1795539521356; Tue, 24 Nov 2026
 08:58:41 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com> <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com>
 <20261124161258.vLyrm8Y4@linutronix.de>
In-Reply-To: <20261124161258.vLyrm8Y4@linutronix.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Nov 2026 11:58:29 -0500
X-Gm-Features: Aa3M54pJO0xlb2aFJWl13lvot59VCzXd4TbuAAatZjI5CYCOVCy7EsRNd2NC2Vk
Message-ID: <CAM0EoMmMio4kotBqbcJmFtf_c3Du=rhfvp+sMiAd0fHKowv6Vg@mail.gmail.com>
Subject: Re: [PATCH net v4 2/3] net/sched: act_gate: refuse schedule entries
 shorter than 10 us
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Victor Nogueira <victor@mojatatu.com>, 
	Po Liu <Po.Liu@nxp.com>, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 11:13=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-11-24 09:12:09 [-0500], Jamal Hadi Salim wrote:
> > This is a followup of commit a51c328df310 ("net: qos: introduce a gate
> > control flow action") as reported by Sashiko.
> >
> > The issue:
> > fill_gate_entry() only rejects an interval of zero, but that interval i=
s
> > the period gate_timer_func() re-arms the hrtimer at, and a few
> > nanoseconds is below the cost of servicing one expiry: the next is due
> > before the current one finishes, so the action holds a CPU in the timer
> > softirq for as long as it exists.
>
> The timer is programmed in the past, fires immediately and hogs the
> CPU.
>
> > On a 2-vCPU guest, entries of 1 us and below hold 86% to 90% of a core,
> > 2 us holds 61%, and 3 us holds 22%; from 3.5 us on the cost falls to a
> > few percent and it reaches zero by 100 us.
> >
> > The Fix:
> > Require at least 10 us per entry.  An act_gate schedule is not tied to =
a
> > device, so unlike taprio there is no frame time to derive a bound from;
> > the bound has to come from the cost of servicing one expiry, with room
> > for a kernel that services it slower.
>
> The 10us sound sane. With enough debug (say kasan, lockdep, =E2=80=A6) th=
is
> might become tight again.
>

Agreed. Unfortunately, there is no way to derive a "good value" here
(it depends on workload, machine, utilization, etc, etc).
poor choice of wording on my part - should probably have said all of
what i said above for precisiness...
Cant wait to see the pedantic nitpicks the sashikos will get about
this. Regardless if this is all they came up with I am not resending.

> =E2=80=A6
> >
> > Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> > Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
>
> There is no syzbot report for this?
>

It's in 1/3

> > Closes: https://sashiko.dev/#/patchset/tencent_4ED9536B0375C96183B2244C=
F7709768C605@qq.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> > --- a/net/sched/act_gate.c
> > +++ b/net/sched/act_gate.c
> > @@ -25,6 +25,11 @@ static struct tc_action_ops act_gate_ops;
> >   */
> >  #define GATE_ENTRIES_MAX     1024U
> >
> > +/* An entry shorter than this lets the next expiry land before the sof=
tirq
> > + * servicing the current one can finish, so the timer stays permanentl=
y behind.
> > + */
>
> No strong opinion. I leave this here.
>
> | With a too small interval the next timer will be programmed in the past
> | and will fire immediately.
>

see above.

cheers,
jamal

> > +#define GATE_MIN_INTERVAL_NSEC       10000U
> > +
> >  static ktime_t gate_get_time(struct tcf_gate *gact)
> >  {
> >       ktime_t mono =3D ktime_get();
>
> Sebastian
