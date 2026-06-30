Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEFA405C55
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820205; cv=pass; b=V+uaA3m9RC0ccewava7ZhK0JhYNrSiwDC0q3bYeKjUlLrE01j4gI+sCmSCxJ51Oc8rNNW+CYLAJBBmiVlJKDAqx04JPvSoQsmyfh+MJamfQ5amc8f4q3PvgQr5kRdO1cvtUVuWZPDtJGTUVrF1orj3KsGeQ1UODqC8v+RuJKjkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820205; c=relaxed/simple;
	bh=AKxGBmZoJWBXkWw87eb5Iekf1UB3fVGGAvIFgFCNLvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWeNADwKzoNuGFWLBKwPwsIwzgTSaoq34w938VnesRiGq5IYCdLddqKNcQ3LrczNyoxDqZNoybWGYz3w5Upjx+7UYzRHdt0sd/7SwRPvmnL2c2jBWdYrWIRC/rZrDK8AjAKxOLVfZ1ga6vBORj9fLmC3Si0Z57HaOmIUYDMj638=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=EuGK6/VL; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="EuGK6/VL"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8478a25f268so1213835b3a.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 04:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782820203; cv=none;
        d=google.com; s=arc-20260327;
        b=nxAYeIHwdEzTdQo+FtX3UyxB6gfL4bHEDfMatAGvRM20dHLBVdpT90FLemxtp3JT7q
         Mlw4PS6oWfgv1pwLSOgvKzjKhrpdCZr+/C0A4Z2LW2vk+WS1KxESoHdAeHMmuB5NLhr2
         FYdZL3Mn6vEAH1sgFwDHL9ty5taDDAoC+Rk1VFUBogEfoBw7XD9lbAPqJ7Y9LbatVsLj
         WJOPed3nfT2Sqw5QqgTr1V2s9Wo6pRSR98vHlzpw2g2KnMo6dI1/EoFRqdI7BDV55Ap9
         LYOpcD2IKoYTduemEhjb99Wfk+GHTXZHKwBqT3o0z6Mo3gtDgN81wuerGurqJxFxUXn3
         qjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AKxGBmZoJWBXkWw87eb5Iekf1UB3fVGGAvIFgFCNLvA=;
        fh=WXTC2YOcwuzkhRsi6duKEgTmoVwPjDxtW9nAdtRo/cw=;
        b=PWFD1kKodKasoMXY920iaxDEmcm0ZQ59ET1koiewCKkaR28bS39VSawf+4I59AnFvM
         2F1fzPxeapKZ8hYiKOp0EzIlEW5mg5kzxeHAYb7Clx/X82gIVKS3YK2sxpW/LX71aFjb
         zgXrB7EcmLqOi49UTyoDp/8O8Qpek9ny4y7Y5XCl6bbnEf7aM682KxWANYWLU6QFzEOF
         Y1tQCzxLSgNuWIwEEVAu1zlRwlm7dl29BZdaBmOfa7ubs2dTlVQnLIEuA/9db3atrgVv
         5B8R79iHhsuWLs80YZz2aHbHdlM4roZA3ultViNW/8cs6ycII0qwx8oxv1f/Bt/bjtcK
         r1xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782820203; x=1783425003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKxGBmZoJWBXkWw87eb5Iekf1UB3fVGGAvIFgFCNLvA=;
        b=EuGK6/VL52hgI5WdOzdbe0U4f2KyXWqkmzJowf69FFieDfbOb/a9u2Uz1npJ+uhNXY
         aGJK1ZRaW51BJtmkJqK2dNNcJH+WFeax1wC6XweXDsgus0Ep4wonP/7tHIZ34pucbQ9r
         yJEnweRTqNtjHps/7vOAaXaL9vu+dAVikhNT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820203; x=1783425003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AKxGBmZoJWBXkWw87eb5Iekf1UB3fVGGAvIFgFCNLvA=;
        b=pigBsr6ZS8jNLIuw6Wer+P4l9Fg1YuyJwO7ylFtO91svJ2dCYVBhioib733i7GEvoW
         g6DkaFVrCBSMosOM/doeHXnWrpUMssY15BZLVbFTpDjBsmC9JoanyyZnEJpLg9xUs+Fc
         mS4WnERaCSq/JmZz/X+MI9qVoB5cE+InBm/6i1vJ0G9HQTW4+sGUdnoAos+7TXjQ539E
         IfttFKDBdKcIusFLBkgDEM30t0hBD+XKYYB0DgLVJMOrv/1vDlTeOB726L15PiidDztj
         8f7+uZpwhw748nii+8JPWnnZg9yhvvwmrDq7nsyCRFlL7/Gh2ouabFxQwQaPxwXf5S/y
         CfXA==
X-Forwarded-Encrypted: i=1; AFNElJ9LBbb6G8oB1PZdB5ecgOArlbYjn64kkIFGYajPztqe8hUglG6Av4EqWbkqmrip9YV/OZpmKtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRNPdlmTTkFsYDrLYxLC8NV5M3ZVSa/Mc2byF4a3nRPVekaJGu
	dnBYqAEHUnGpc2/LCeG5NNDXudIx2cAacGDXPx3kkNCv8pIYnooiXv22H0aHhP7GDGTyfrdZE1x
	lfvS1rE4Nak0q/5j+vgD4McizVi1cLdX+eI22mRS0
X-Gm-Gg: AfdE7cnEh8VkIVbyY5xQDbYjWMr0NyWX9HSj92nFsvhXM4cFaKKNTQ4TA83CpEyAyWH
	/F41ZBSmyo5e3VKsURIpDoVOzEqI9uCPpJEwaxrviqDtsO286ZcgloofccG8OMc9RoXjSmOvumS
	yKYyUldaynpJ1KgGb/vY06xHuwqWnOZyKyUXvnrVS6cKmS6xxrgJwX6izSUssnuaIs3sUW90fdM
	F2dl4ot5kdW1zCN5tJaKWy9zSBEfQuL+mNADDA2UAST60lF0hsAMlUlwtgX3N5aiAdhS39h/A==
X-Received: by 2002:a05:6a00:14c1:b0:847:968d:b0ff with SMTP id
 d2e1a72fcca58-8479f2a49b9mr2599684b3a.55.1782820202911; Tue, 30 Jun 2026
 04:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628111229.669751-1-jhs@mojatatu.com> <de40b1a5-663e-43ab-9fb7-5a49f029cc4b@redhat.com>
In-Reply-To: <de40b1a5-663e-43ab-9fb7-5a49f029cc4b@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 30 Jun 2026 07:49:50 -0400
X-Gm-Features: AVVi8CdpQSTjeXB-bnfvF1mLqAtHVPEptxCPY-KPz-SG2z_eFlsvaBUP5s4cQzw
Message-ID: <CAM0EoMn-6Ayjd3mxsiifDXwN1zdefx9eiRk_wWRpsuEh22LziA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 7:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 6/28/26 1:12 PM, Jamal Hadi Salim wrote:
> > The teql master->slaves singly linked list is not protected against
> > multiple writes. It can be mod'ed concurently from teql_master_xmit(),
> > teql_dequeue(), teql_init() and teql_destroy() without holding any list
> > lock or RCU protection.
> >
> > zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
> > after an RCU grace period, but teql_master_xmit() running on another
> > CPU can still hold a stale pointer into the list, resulting in a
> > slab-use-after-free:
> >
> > BUG: KASAN: slab-use-after-free in teql_master_xmit+0xf0f/0x16b0
> > Read of size 8 at addr ffff888013fb0440 by task poc/332
> > Freed 512-byte region [ffff888013fb0400, ffff888013fb0600) (kmalloc-512=
)
> >
> > The fix?
> > Add a per-master slaves_lock spinlock that serializes all mutations of
> > master->slaves and the NEXT_SLAVE() links in teql_destroy() and
> > teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
> > around those updates.
> > Annotate master->slaves and the per-slave ->next pointer with __rcu and
> > use the appropriate RCU accessors everywhere they are touched:
> > rcu_assign_pointer() on the writer side (under slaves_lock),
> > rcu_dereference_protected() for the writer-side loads (also under
> > slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit() =
and
> > rtnl_dereference() for the loads in teql_master_open()/teql_master_mtu(=
),
> > which run under RTNL.
> > Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the list
> > traversal in teql_master_xmit(), so that readers either observe a fully
> > linked list or are deferred until the in-flight mutation completes. The=
 two
> > early-return paths in teql_master_xmit() are updated to release the RCU=
-bh
> > read-side critical section before returning, since leaving it held woul=
d
> > disable BH on that CPU for good.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: zdi-disclosures@trendmicro.com
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Looks good, thanks!
>
> Please note that sashiko/gemini found a pre-existing issues which may
> require a follow-up/separate fix:
>
> https://sashiko.dev/#/patchset/20260628111229.669751-1-jhs%40mojatatu.com
>
> (the 2nd one in the above link, IDK how to generate a direct link to a
> specific comment)

I just sent v4 which covered that but i will send a followup instead
if you already applied.

BTW: What is the ruling on when Sashiko finds a pre-existing issue?
Should we address that as a separate follow-up patch? It is unclear
what the policy is.

This teql patch was one of the hardest to deal with in terms of
reproduciability and the fact sashiko kept coming up with pre-existing
issues - including the one Simon and I were discussing. Note: None of
the pre-existing issues affected reproducibility at all although i am
sure one of the AI-kiddies reading the sashiko reports will find a way
to create a poc (this is why i entertain fixing them when they look
simple enough)

cheers,
jamal
