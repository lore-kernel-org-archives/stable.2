Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774612;
	b=gx1WnDh+sc6SdzB88KnAUpkDNC4s0t8uZr8/a9Q6ETz3aC4Bdftd3UXfBbCzvtdi7GzO
	 cmzBDrJ9q/XmI5wr5qSTVc+oyMIsKWF6z2GIPFOBRGzgBqvPZsCrJppQqut1qHB6ne3Pr
	 7csuKe9a0dPJ5Qj00raIMfavhruYd6lFvukHlnCO2iItTrHIkr/G465Qc7dw9hqmf2ZM+
	 yDwoErq2ci2GAYQGSlzFZS80pTKmjiWEPQCpD9QQslFMZS5o6/DzZsQJWibnkCmzFnx7G
	 zx+zSYYFEPWWhcSdeYtjT0lOBpm46M8sIjEWoJJ+3dZKWhkc/IDB3ngo1lkDpqmFH4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KPXb3DtqJNanqI7IPB3ZYAV4XR+6OEYsAvkDzB1Mb18=;
	b=1ImuRX0TDnW09cP8t0dhB+/70rYO4WXfaMVeZr3QD4Uk36kByvY/mQJFFCFvbK4NKnTg
	 4LYdHLQTg4CenFMxE3yIO/uSXpixEpGigdCBErHpfp53ul2ukx1V9j+8HMBqZ6tuN6iPF
	 FWpbIMZUkFlywx5ZZtE3+BuyASBRf2vayy8MMFMYdwfgMelSOEYCBgZOi271xyCSvc9Ds
	 IPXPQ0Qkui3sglFzB1xcYjDqrC3LFKTKOxEfYrgrrMfsIGkH0yy5jGawtg6MianhOSpEy
	 pQda/IRWRUoDtO2Mc/z3iaxfpOpiII2eudD3gi2gBvTtdf7dhAVC4KGBKu3vArsuTpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=bz6+I5jI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE53606A323
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE53606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=bz6+I5jI
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a594d313a3so5193344b3a.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:16:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795774611; cv=none;
        d=google.com; s=arc-20260327;
        b=jLaA7Vq5+7Ww9jE6pZgoLTUy5HhBd35S20eUXFdQykIyILpen/xsF5wDNb1btSqy3W
         Nsq9taYVon9huMd5lwp6HeB7kBg3qVYCtNVYU7e5r7B16DA4Xdb6ksGSO5+jj8Ku3nZC
         +sYeZWy66x6Dn6u8JgQnbPLL78rNYPVOTn87lgUni/Z2aqxQ14+ihcADQt9xuk1uq9VJ
         QO5+G94dBHUu86/cIINuLrmPZ3otSrJWJptCJtZkGlEBeAYo0AlqKRk4RbSNIz9LiAlR
         4tg92O4ZRkqZSQrEQgVAnl5b65KgeW8bumvmYwjJSeHkLneYOx58kH0mD5Uz0fqHtn1W
         CxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KPXb3DtqJNanqI7IPB3ZYAV4XR+6OEYsAvkDzB1Mb18=;
        fh=aUwG4IUrWMM1nLPqTMFJR6jzkOKSP+f9tn1NKJ1oxJk=;
        b=g8mgbDk2iWnhlAelEBCBGDW9EHLUCrWAmTlB8CcDnDEEQ9LQPpPeIkmmfBdBYzW5d8
         bGQacjSvOP5tx0AhM6S3or8oUaiuHi+bmV1jKCtsOL8JtoRhBezWlvzCCf7+NWGdgVxt
         LAYLng7XyMtxbgfWRK3UDSlooGLSc+lKNT3RwDv5JtoPJ9ZMKe0HrJV6TVpUfmkcGVGu
         8uuAXy4JarG5UADZLLaMnXVRo9/qubqnLMz6jQD7kcLmr9Yuav9lfU/VTD5vZ/OQqbE9
         hmEybu4BqAhFRyPbBterHNbnQLLnv2eKGStAgjERrYILrTpt5o5bYe8Q2e2IjUkOLFJr
         Iedg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795774611; x=1796379411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KPXb3DtqJNanqI7IPB3ZYAV4XR+6OEYsAvkDzB1Mb18=;
        b=bz6+I5jIn0CXr8Hq35YeWBi7ua7lcqOOo+oFHX6xJ39sNrxxlGLAl/m45iBlrk8g3u
         XnnrvkEBj4Fz/C+03h80ZcCEEYT3Cj6kNrohV7pvv5BTkCE+5zICD31o66P9SLcrylBj
         bZm7xijBxwQqceTZLHKTDsjYXgAFX5v5mXwKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774611; x=1796379411;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPXb3DtqJNanqI7IPB3ZYAV4XR+6OEYsAvkDzB1Mb18=;
        b=JJKFU6jtnPMFv+Dz/8GuhoHKRVH83cyyZbDsVhAweRRg9SK4RqTS4DVNOrDScI8mZg
         aZ+31rVq9j3w7WaMMQ39l8UOlSJ9ReD09wr0MLpRFiuia7+JxaQPfaaZWQT6tkYx98uQ
         1NQ9M7WfEqms0sD7TOcoIHHL8R5FC/auDg0EnV4CWfy3B+mJqtZjaDdeo1hD8S42a3Vf
         YgV4i8IQtTrBo+qqk/llrmBEo9fqWGh6PuhwmrR04+ijf3grdhb/s2rQy9iz37XvuUEX
         /aLVuiZUADOLS/oRFYE8DQZqj32E16fi9AHaC/23HfIe/+RoVBB+4BZMZG/TZTFRHTHF
         zGNA==
X-Forwarded-Encrypted: i=1; AL+hErFoVcz/nBhqalAC6Y5B4Da7MwXso9xErOYNylfTDN4DrVANDpZ1n69GIyyglrc3dkgqt+a4wFA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QIz+BhxQU4G4rwGZq/i5/nOQCmdrbBZSxS+JhJbSQ4Sej/PGo
	I0bs4+o0JbK5X8BTY/UbxbP2SPG48JuLzOTj5RAPUwJeGzqfB8azdC/jp2ONnUzsKhgU9QGoijw
	+AFr+AHChCVFzMAKLs/kflDG1sr6zk82eg3Dpp3z/
X-Gm-Gg: AZFdTZfXlu9my7ojLt3gCB9Wa4OImlvlEqab0cDRNT30qvxRJnWKeH7nA+qu0Wh8Cfr
	5pSdUM7jlTdqBPKemFo44qQm3ys2we1I4U3q2SdQIIuuvI8hwOsF/siUWyTUxKkeY9QkyTRuu7D
	ShmTvSti/vF79jpGGP5wjAIdWvxaX1y9iBprzwhn5L4monvUGnDMhYpG8EgoqFBR81rNYvlr2Ab
	Pv32WNF4VN9SYvqkdGE/+vXisLz4jnQFEJweQ4jn4b16DjoJaSTVFYLb3SSf52JAyX9cpGuZtW6
	BM5B9MXB9TCrtZFBl/ZNIoZQ7Ql/SI/+L6pNSOYPLp3mHSG8pBM073oeAqJRZANq0SjKOTENpXB
	ewZq/WZbqsbOZlGqSTT+bx/pfRhjSNJXESPVxsPpVDy/4IbvIrzEkcZams44/QX/Ox8C7pUitTT
	6x6iVUp84zNEZWsdg=
X-Received: by 2002:a05:6a00:f06:b0:88c:e59e:e168 with SMTP id
 d2e1a72fcca58-8c87d519a88mr24868251b3a.52.1795774611339; Fri, 27 Nov 2026
 02:16:51 -0800 (PST)
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
 <20261124161258.vLyrm8Y4@linutronix.de> <CAM0EoMmMio4kotBqbcJmFtf_c3Du=rhfvp+sMiAd0fHKowv6Vg@mail.gmail.com>
 <CAM0EoMkEjxCo6K9k3MZH0U+3na9soMNE0gouddwOTzUYXcEunA@mail.gmail.com> <398670d0-809d-4cdc-b03f-80bc3b5faa2a@kernel.org>
In-Reply-To: <398670d0-809d-4cdc-b03f-80bc3b5faa2a@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 27 Nov 2026 05:16:38 -0500
X-Gm-Features: Aa3M54pNs2p-3UyS5EML3h7jq6W69RH1lzjUNliy6esxdQanlDs19hCw9dfN8zc
Message-ID: <CAM0EoM=ZtRjDfV1TNNopPyON3szx4aDMn1Yp9oD-dVMVq2QyAg@mail.gmail.com>
Subject: Re: [PATCH net v4 2/3] net/sched: act_gate: refuse schedule entries
 shorter than 10 us
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Victor Nogueira <victor@mojatatu.com>, 
	Po Liu <Po.Liu@nxp.com>, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 5:14=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Jamal,
>
> On 24/11/2026 18:11, Jamal Hadi Salim wrote:
> > On Tue, Nov 24, 2026 at 11:58=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> >>
> >> On Tue, Nov 24, 2026 at 11:13=E2=80=AFAM Sebastian Andrzej Siewior
> >> <bigeasy@linutronix.de> wrote:
> >>>
> >>> On 2026-11-24 09:12:09 [-0500], Jamal Hadi Salim wrote:
> >>>> This is a followup of commit a51c328df310 ("net: qos: introduce a ga=
te
> >>>> control flow action") as reported by Sashiko.
> >>>>
> >>>> The issue:
> >>>> fill_gate_entry() only rejects an interval of zero, but that interva=
l is
> >>>> the period gate_timer_func() re-arms the hrtimer at, and a few
> >>>> nanoseconds is below the cost of servicing one expiry: the next is d=
ue
> >>>> before the current one finishes, so the action holds a CPU in the ti=
mer
> >>>> softirq for as long as it exists.
> >>>
> >>> The timer is programmed in the past, fires immediately and hogs the
> >>> CPU.
> >>>
> >>>> On a 2-vCPU guest, entries of 1 us and below hold 86% to 90% of a co=
re,
> >>>> 2 us holds 61%, and 3 us holds 22%; from 3.5 us on the cost falls to=
 a
> >>>> few percent and it reaches zero by 100 us.
> >>>>
> >>>> The Fix:
> >>>> Require at least 10 us per entry.  An act_gate schedule is not tied =
to a
> >>>> device, so unlike taprio there is no frame time to derive a bound fr=
om;
> >>>> the bound has to come from the cost of servicing one expiry, with ro=
om
> >>>> for a kernel that services it slower.
> >>>
> >>> The 10us sound sane. With enough debug (say kasan, lockdep, =E2=80=A6=
) this
> >>> might become tight again.
> >>>
> >>
> >> Agreed. Unfortunately, there is no way to derive a "good value" here
> >> (it depends on workload, machine, utilization, etc, etc).
> >> poor choice of wording on my part - should probably have said all of
> >> what i said above for precisiness...
> >
> > And now that you bring this up - this should really have been
> > targetting net-next not net.
> > I dont want to resend (unless sashikos find something sinister) - but
> > Jakub/Paolo consider applying this to net-next instead when the time
> > comes.
>
> I'm sorry to say that, but a new version might be needed: it looks like
> the new tests you added in this series are not passing:
>
>   https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/928799/1=
-tdc-sh/stdout
>
> It started there:
>
>   https://netdev.bots.linux.dev/branch_deltas/net-next-2026-11-26--21-00.=
html
>
> Or is it due to conflicts with other WIP patches or something missing on
> the CI?
>

sorry I broke it - not sure why our system didnt catch it before
sending. I will send and fix the commit log whining from sashiko.

cheers,
jamal
> pw-bot: cr
>
> Cheers,
> Matt
