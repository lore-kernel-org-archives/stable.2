Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD533A70A
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651299; cv=pass; b=TpdrDXikofmz4itrBIcp+4wHp0+rbNd/tGJnk6QAtGeKETjx6zXf88XdTlecjsAi4TAnwb8S+TUSTJZ9O/Spph2HnG+CB+8MLO/zVMol3FSj9tGWWxC9mHVNchNxfJKW5SsykKt0uOkOSfZkXQ2qfzk/aduz3Zm8b9ckeKe4Xkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651299; c=relaxed/simple;
	bh=4t+j/BXBalwXPmR+JwRXFZWRqKHcAW3hueUDjIbFXHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFK5zaKrppIEUho8NNSMryxl90qzgjjj3E8dckY/BAUqR20XjSsgMN6HwRyILuZamyaqYqpF09IvbFjjAVl7EdcOlENXHBGurDQ1X39vwO/KYGpQB+ouHBQphVVK2eEgFX3CJOsiQP7Q1OPJ4JaJkDaYydrVosGtFixcgGgghfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=GTSc92Tc; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="GTSc92Tc"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8485ef63b68so4503174b3a.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787651297; cv=none;
        d=google.com; s=arc-20260327;
        b=iluhp0hNEuh3/uOWGqTgYVfEMzhfjuqK0IYs/vRG9884qn/ot0QA7EElfbv0Z6pGTj
         GVBWBJvbayPozHj6qkOHXcfhglDLU+shRqnR+Ks9bgS0ecJqwpS6xEzPNhniv/q+JX6l
         NoNEdvxxDwtLPTOlM+On7bL53541lDjNcQS8e7MYtvD6i2dgKgzod27i5nou/4waHrh/
         pQWMj/zjQzW+dejuZEnobApEIQn7jXLPeThdjs4e08N81HQ4mviqGpDXhXpB/JN0fH3N
         0G8XZsqY+HPEc7dJzZ0MKnVLL5mCbL7mqj4gRPp/RdLHf7Adzt9CJ+/Hb3u0MsjiHmdZ
         RdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T8fFFd3lt0SIhR5vWK+5bEPh01zQk6FDjhM30fVLQew=;
        fh=RFWyRhxE1pwajFTkY6AVwjgxAKXoBVguObQfmWsJQGQ=;
        b=RbWNY1DIUNZiYEQvkJ6sciUURaJER6ZVN/HJ5nPEGLSRsQQUlu/mItmwhZQ9mlX2w+
         1TxlrdZMbkTFgi7EU9CsplhjSti1KsWGfcINt0wOMO5sS2Hd1O2mWlIPQfKFcNC9cFfP
         eTh01gsC1qy+blK5bvKG5+kPGPImP+YN9JhYQeumjqYXl8eHIfI75WMVMVxgwuRAZXHJ
         kYyy5MuT7/JX9ajgrg6ao+HiEQ4ElanIktrN3EoIAfH17c8Md8ryS7ZhJ+kLn3uJEEH4
         QElD4YCUXje684BpBDLLFWQiwJ5x3FRgpIcANUX8+Y0NpfxDMThtN/utLUd+ehTP4lCp
         nsOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787651297; x=1788256097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T8fFFd3lt0SIhR5vWK+5bEPh01zQk6FDjhM30fVLQew=;
        b=GTSc92Tc+E5z0mmzXiJpL9PIsw2+YRSGDHMWEa8PWYNbVHtOFjKtDd4mpphj7RDVOQ
         Ci8aLxb/PWbRRONWrkNT0twBFOCsQi0tjjmlzStv6z3O97FuHG3G1xtvLY6ROg3kqT+N
         8R35QxRxSVs9pgGHaeUdW3pMRuK4S9jDtvfOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651297; x=1788256097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8fFFd3lt0SIhR5vWK+5bEPh01zQk6FDjhM30fVLQew=;
        b=ZlNwqG+Wr5drUYnbN2eILWwAXjCCty0kjni6KV+O8k+h2LKjF1f0eSXNUcYgCKlwnS
         Bv+dEKs++hcqbFvBlC0E2ZaBAh5Htc0mYSOsUPsJSlcvietfuoLHQ/0ekjEDAbHrQaA+
         V08kV/PTKY5U7r/2py9u6AJTfYNFsvXvk5JIup89HHRK5zcU+t/N8FHphD7OaXFc4kJW
         chGj3Bg56Um2DMe19puCX+cG8nNLc5MOJAfbvxhmIG8rhSJVIeZyfCGuwcLWpQ8WDvBS
         FFdK5J9sLJUz6JiHj37eptGzNwkXz0mt6FQeeKWpXjfp+cqrUImND8mZRoWU6d/yjAt5
         p3Pg==
X-Forwarded-Encrypted: i=1; AHgh+RrB1doLkZbEdnR9cEOycstmOeHiH38jvl4cOme1sXyqjsEKEA4MBrDUmKW8V+frHeysWPNU1qg=@vger.kernel.org
X-Gm-Message-State: AFuF++nFbGQ5TvIsmzsbFXzC4nWoJlEmm5cSuNs6t2Y3ysxyRiujx4wW
	iFUt5FrccrH4chwlmqOiZghfYDGJORDd3J3KLaYJgYNjDohApjfdvjGHL/QQsbxhL4QEktAgeBE
	YFBr3tocaaaAJjlMYCvg/LH0W6CujD9rLRNf23+MY
X-Gm-Gg: AR+sD11suE1KLfVJxhqpxtsa+YDAnOQ//VLYWMt0VxH4sI+UHQpe+neESPYLLX4Hp25
	/X+tG77x1fFHdVl++Ab5jTpcUZUNs8CflWMarFQAAiD/EZ8YWLWPdGdOQGxwt08NKVQXuql1BFz
	hQ58pF47VLJBclXzav4KlEyn70ku1EfGYaB7DYe5zJc0kPQBiUeOcjmjK7n5rCn2oSIne3hThWq
	WNptswPm9dwDIS8jfG0EHoe7vlm/KrbaBI9l8Cn8s6znQiCFCUxE8bhjelI6weFJLufW9eimcQd
	sCLYhclBcpyCCkBqA2JTMgianJh6EfCftlBBSKqwZaVec0k=
X-Received: by 2002:a05:6a00:4501:b0:84e:e741:174f with SMTP id
 d2e1a72fcca58-851f9cd577dmr55115904b3a.7.1787651297483; Tue, 25 Aug 2026
 02:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822195509.112717-1-jhs@mojatatu.com> <20260822195509.112717-5-jhs@mojatatu.com>
 <62618ef6-28f1-4d0d-916a-96fc54dfc2e3@redhat.com> <CAM0EoMkwr5idTgLSfB3azrfbBasGVGXrOPSJMUpyQKkgCgZgTw@mail.gmail.com>
 <4d9d542e-e25d-4ba4-b7c4-e51c82f3732d@redhat.com>
In-Reply-To: <4d9d542e-e25d-4ba4-b7c4-e51c82f3732d@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Aug 2026 05:48:05 -0400
X-Gm-Features: AcwNN1Ubn3mXrXd74Gl8HB_9tEsOtT67tVDajCH4VoPlfAPCyeZa98UYpBCm0kA
Message-ID: <CAM0EoMnCC4p-nk-VxR_ard2E6na3_fZYd165iOyXQM35QKz_OQ@mail.gmail.com>
Subject: Re: [PATCH net v3 4/6] net/sched: fq_pie: clamp default quantum to
 avoid signed overflow
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>, "Sachin D . Patil" <sdp.sachin@gmail.com>, 
	"V. Saicharan" <vsaicharan1998@gmail.com>, Mohit Bhasi <mohitbhasi1998@gmail.com>, 
	Leslie Monis <lesliemonis@gmail.com>, Gautam Ramakrishnan <gautamramk@gmail.com>, stable@vger.kernel.org, 
	vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 5:43=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/25/26 11:16 AM, Jamal Hadi Salim wrote:
> > On Tue, Aug 25, 2026 at 4:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 8/22/26 9:55 PM, Jamal Hadi Salim wrote:
> >>> fq_pie_init() sets q->quantum =3D psched_mtu(qdisc_dev(sch)) without
> >>> clamping. A device with a huge MTU (e.g. dummy with max_mtu =3D=3D 0
> >>> accepting MTU 2147483634) makes psched_mtu() return 0x80000000, which
> >>> overflows the signed flow->deficit to INT_MIN in fq_pie_qdisc_dequeue=
(),
> >>> causing an infinite loop and soft lockup. Emulate fq_pie_policy which
> >>> is already bounded to [1, 1 << 20]; clamp the default to [256, 1 << 2=
0].
> >>> 256 matches fq_codel's floor and is a sane minimum for a DRR quantum.
> >>>
> >>> Conditions to recreate the bug: a device whose MTU (plus
> >>> hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
> >>> device with max_mtu =3D=3D 0 accepting MTU 2147483634). Requires
> >>> CAP_NET_ADMIN in a user namespace.
> >>>
> >>> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler=
")
> >>> Reported-by: vega@nebusec.ai
> >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>> ---
> >>>  net/sched/sch_fq_pie.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
> >>> index 069e1facd413..b27d95418707 100644
> >>> --- a/net/sched/sch_fq_pie.c
> >>> +++ b/net/sched/sch_fq_pie.c
> >>> @@ -427,7 +427,8 @@ static int fq_pie_init(struct Qdisc *sch, struct =
nlattr *opt,
> >>>       pie_params_init(&q->p_params);
> >>>       sch->limit =3D 10 * 1024;
> >>>       q->p_params.limit =3D sch->limit;
> >>> -     q->quantum =3D psched_mtu(qdisc_dev(sch));
> >>> +     q->quantum =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)),
> >>> +                          256, 1 << 20);
> >>
> >> Sashiko thinks that the soft lookup is still reachable via pie_change:
> >>
> >> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822195509.112=
717-1-jhs%40mojatatu.com
> >>
> >> and has similar concerns for patch 6/6, too. It marks the issues as
> >> pre-existing, but AFAICS they overlap with the things addressed here.
> >>
> >> WDYT?
> >
> > You are right, they overlap. I had them as followups (with a few
> > others derived from the sashiko feedback with justification that the
> > v3 init-path clamps are independently correct and the stab cap already
> > mitigates the change-path worst case to a stall; but those two a
> > (adding max(256U, ...) to both fq_pie_change() and sfq_change(),
> > matching the fq_codel_change()) are more serious.
> > So if you'd prefer a v4 respin of the whole series, I can do that.
>
> I initially did not notice that the _change path would lead to
> "upper-bounded" stall, I think a follow-up is fine.

I will prioritize moving those two i mentioned as a followup as soon
as this patchset goes in.

> > Sashiko is a double edge sword - i think code quality is improving but
> > it feels like the work load has doubled ;->
>
> FWIW, I agree with the "double edge" assessment.
> A reference we must keep in mind is that there is no way back, so we
> need to adapt somehow.
>

Agreed ;-> Will take a while to adopt...

cheers,
jamal
> > Here's what i had as followups (some still to be vetted, just noting
> > what sashiko is stating to be reviewed later when cycles available and
> > potential followup patches sent):
> > - sch_dualpi2 unclamped psched_mtu
> > - sch_pie unclamped psched_mtu =E2=86=92 AQM disable / div-by-zero
> > - hhf TCA_HHF_HH_FLOWS_LIMIT unbounded
> > - fq_pie_change() / sfq_change() 256 floor missing (one that you bring =
up here)
> > - DRR/ETS quantum=3D0 spin (have a patch, was reported already as a bug=
 by vega@)
> > - Consider two separate clamps for fq_codel/sch_codel (nipa
> > gpt-5-6-sol-3-15): quantum in [256, FQ_CODEL_QUANTUM_MAX], mtubounded
> > separately (no 256 floor on mtu)
> FWIW, LGTM!
>
> /P
>
