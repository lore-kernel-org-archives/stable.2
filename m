Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47B3EDE42
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649395; cv=pass; b=FcpCLcDCIIKNZIZqDb5cG+/iQ5y6n4NOTzkXR4W+RbeiOnOulg24z1ojS6eNF1CCGC7pCZHDHorYbmNylR4gtsjtQmnjaELfOCweX05gGkLaqnXvCgFYO7bNURx+d3RPdnA1q+uQgHZhE5yn8AV28Q7fdIA5Vz8bKHi8EaN58Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649395; c=relaxed/simple;
	bh=H1SQ4hT1KQqrQV7vp8N8BkgUmq8q7U6yAUaePAyRclk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0RGIDgMsHIeJqBlaxkBSa68gDpBkaDS9LHX3iHf2uy/5U0I6S6wHQiCBkCRysMnpP+znAdh9O0XtiMEbTk5yoeyfaw3IgybWj39kG0KtdxTnuqaUETqk2aVPWhBvq1Y+QqP/b0cdljEvMDHOJOm04q91GaEcqZzanREFSxyo6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=O0eCtH5X; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="O0eCtH5X"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8485b358552so1820710b3a.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787649391; cv=none;
        d=google.com; s=arc-20260327;
        b=gwvSden9LPqtxwpBhRy1eG+yM/IwVgp2hdh2ufYrScc0tHWlKPA2vSkY7TWD42Dy58
         gE1r3oLSpGAAGllY8fNZA7wsnS64FeBQz34LFmId1Z747hBtmGTX9AfpL7Vf+QGEgd69
         AoZaqIuf/6OCHTp/1phAZyD/E83mXLieoyTmA3j6RRMdTrXJhZWIO2LSeDpkEhqyGgLH
         oh4MqznqEM4j30ICAF5ohho0g8E2XnLVqjWFnd7atYizOqW2ils2ziy3YEgzAkpyHisd
         rJTpqYgDhebPolzM/hAe9nE54fjuGFGom/BIdOi+8dzt3NEveQ8bjxGndSrAEiHzdK/6
         eDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsUhMFps5aAYQXcyo1u4kyTUSwki3n35BuVuvGeBTu4=;
        fh=qDTUoCH/PKV83Q1K79eBZbNnKuPPA00qmr6BoTBMfdg=;
        b=lJxLn9JvcA228nYYJGCW3j7HlriLiANNZWPv4E1V1CPcJwHrcGDQvtlUy2cgiz5p/b
         Xb9rhnpJ1CjSnMX5/dWmGm/lQlc+Fn6gl9PG9gnj/flg1oTzckDiv8oghiz/QoiNmJp5
         QS6waCZCLZqvmS839yzZKflhmsZwzn4erYKd+BOJJdo3jyGG/N3T87MLbNq6atkseor1
         3QF1fsF+ovxLvdFiBeyYEPjLKWPOwKUbB3apPdUhlxOJ9wGHj+ut1wIlmJCh/xv47tfg
         v3ahSD+/MhJx0Zua24IsTrmXkXw49/Ru4sWPibvlZTzvfOnjmoOLITApOgGaAonWZpzS
         95cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787649391; x=1788254191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsUhMFps5aAYQXcyo1u4kyTUSwki3n35BuVuvGeBTu4=;
        b=O0eCtH5XeSlMe5GvOZxWYo6NQEfGagDs1O8inrdRt/WIMTnsgEj1cVmAryjtJ65SSQ
         iiLca48oaDfMLC01MpS7BlMSGgDynPdXXU07OBZC3BCJQRndyJtu1ic0G9Oga2eLrYOh
         UmIycSYcABaJpM5EKhOvLaqwtIOKVeszrxrj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649391; x=1788254191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsUhMFps5aAYQXcyo1u4kyTUSwki3n35BuVuvGeBTu4=;
        b=DuEBgohkadHWHW0ZRXVk9eerPZiD0KoTK8BtJ+vIShQ0fZsgt40RexgPFQXdTlRXBp
         L5VOh0OKlBoN22DUPdcGITqxT+6yLYNEatFueX9edycFwY0uZ71STtGAc0WvCAHKZ85C
         3p+CugIMlJpp8jiYEunLnB3U3SYzEKn2DRYD0kfP367++z8I2wjo03teS22san+p8r9K
         lJOQOfG9S/zmnkL+a8+ZMeczgtVXJWst+kjpvBE/GGODlH+FQVDG/OpQlDLJmq38g2+6
         b+DPdogLTSNSuf1x61LH2wI0X3oni0E1hBrg324XxqwGJthe8xfxzDTK4F1MbdfwKI/S
         GO1w==
X-Forwarded-Encrypted: i=1; AHgh+RrwRKMtbUYQ4Ozbf2PQADdUov++5HoYtgjIeddmLzlP1WaA+Mq2igvDJNbK0+rx2EvRfMx9fEo=@vger.kernel.org
X-Gm-Message-State: AFuF++kZSOm1Rt9AZ1LigGgAoNEcrvT0E256RIZIeI3ziFUVvCtjQKqy
	tdtiidbbURVAwGj6ErhnT+1ImxYAgbu+ktsHaPo6bO8X+e09tQDUV1byzJUgPUV1L7cjmhnhStP
	A1kShnnJWRkEk6aAZwPoQuJUzgY5pr993NUM4xux9
X-Gm-Gg: AR+sD13BDovCH1yu60Oz54udSEBmsg7VNqfJ4EKr+idnlHzkUNIk2OB0SNilKS2Fnpm
	rWhubZyihrzwtKWxYtvVnsPurBtVgShAMnh/P3t+PK1swgvDDiViQtSKNjXeVCSPsbusrd2tccT
	c87tigDcK7KEopusN8bOZFKRCbf5L8RbuBSaPdmvkJmU2loFhVQBYErwuN/jBLI5Mgobk7GwKI6
	y7FAJr4w4+S1VEmoWkUXVTCL/kro1r5pi0p79AJCvUvYKfNDm+h4rBrHbRUBx1jfK+QjDezaeWu
	NVCdHSEocD1jD9v4vuMCsWVYJMKpwV1+GE/er4maWDBUMZU57QFGPce2
X-Received: by 2002:a05:6a00:2e17:b0:848:2a71:a48a with SMTP id
 d2e1a72fcca58-851fa024b2fmr53883728b3a.13.1787649391557; Tue, 25 Aug 2026
 02:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822195509.112717-1-jhs@mojatatu.com> <20260822195509.112717-5-jhs@mojatatu.com>
 <62618ef6-28f1-4d0d-916a-96fc54dfc2e3@redhat.com>
In-Reply-To: <62618ef6-28f1-4d0d-916a-96fc54dfc2e3@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Aug 2026 05:16:20 -0400
X-Gm-Features: AcwNN1W4dU6fkQMaBEtZid1fXZrnyh2RgeBk2usssVcuBGElMZCq7KTBOpf55LU
Message-ID: <CAM0EoMkwr5idTgLSfB3azrfbBasGVGXrOPSJMUpyQKkgCgZgTw@mail.gmail.com>
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

On Tue, Aug 25, 2026 at 4:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On 8/22/26 9:55 PM, Jamal Hadi Salim wrote:
> > fq_pie_init() sets q->quantum =3D psched_mtu(qdisc_dev(sch)) without
> > clamping. A device with a huge MTU (e.g. dummy with max_mtu =3D=3D 0
> > accepting MTU 2147483634) makes psched_mtu() return 0x80000000, which
> > overflows the signed flow->deficit to INT_MIN in fq_pie_qdisc_dequeue()=
,
> > causing an infinite loop and soft lockup. Emulate fq_pie_policy which
> > is already bounded to [1, 1 << 20]; clamp the default to [256, 1 << 20]=
.
> > 256 matches fq_codel's floor and is a sane minimum for a DRR quantum.
> >
> > Conditions to recreate the bug: a device whose MTU (plus
> > hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
> > device with max_mtu =3D=3D 0 accepting MTU 2147483634). Requires
> > CAP_NET_ADMIN in a user namespace.
> >
> > Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/sch_fq_pie.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
> > index 069e1facd413..b27d95418707 100644
> > --- a/net/sched/sch_fq_pie.c
> > +++ b/net/sched/sch_fq_pie.c
> > @@ -427,7 +427,8 @@ static int fq_pie_init(struct Qdisc *sch, struct nl=
attr *opt,
> >       pie_params_init(&q->p_params);
> >       sch->limit =3D 10 * 1024;
> >       q->p_params.limit =3D sch->limit;
> > -     q->quantum =3D psched_mtu(qdisc_dev(sch));
> > +     q->quantum =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)),
> > +                          256, 1 << 20);
>
> Sashiko thinks that the soft lookup is still reachable via pie_change:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822195509.112717=
-1-jhs%40mojatatu.com
>
> and has similar concerns for patch 6/6, too. It marks the issues as
> pre-existing, but AFAICS they overlap with the things addressed here.
>
> WDYT?

You are right, they overlap. I had them as followups (with a few
others derived from the sashiko feedback with justification that the
v3 init-path clamps are independently correct and the stab cap already
mitigates the change-path worst case to a stall; but those two a
(adding max(256U, ...) to both fq_pie_change() and sfq_change(),
matching the fq_codel_change()) are more serious.
So if you'd prefer a v4 respin of the whole series, I can do that.

Sashiko is a double edge sword - i think code quality is improving but
it feels like the work load has doubled ;->
Here's what i had as followups (some still to be vetted, just noting
what sashiko is stating to be reviewed later when cycles available and
potential followup patches sent):
- sch_dualpi2 unclamped psched_mtu
- sch_pie unclamped psched_mtu =E2=86=92 AQM disable / div-by-zero
- hhf TCA_HHF_HH_FLOWS_LIMIT unbounded
- fq_pie_change() / sfq_change() 256 floor missing (one that you bring up h=
ere)
- DRR/ETS quantum=3D0 spin (have a patch, was reported already as a bug by =
vega@)
- Consider two separate clamps for fq_codel/sch_codel (nipa
gpt-5-6-sol-3-15): quantum in [256, FQ_CODEL_QUANTUM_MAX], mtubounded
separately (no 256 floor on mtu)


cheers,
jamal
>
