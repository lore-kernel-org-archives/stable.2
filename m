Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43149F119
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357356; cv=pass; b=XX0J1hObPIyNSgY1srjdjZTYosBaVt7kCbhPo6gKhl3U80SvX6L+qiPLf+O19Jmrt+i5eHy3Dn7V6md/50eJfDBVkTeVGxAMwNY+CZyrFNAr5M9mJSgycb156F7B7qhsXL++oz7Oq3nS60GDEHZC6xoduyKckKWDvuMPfJIctlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357356; c=relaxed/simple;
	bh=aWJfXd4wDmWh9dR47FITwc4NC22PXsmRS1CTDYUASYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy8KtV9Jevov+FpwR6VozrdCdbISMOaQqUR2ZkCMKh8OB8YOtw2CvfGM90+LuPCC7XWSvmg8FuxCOW8yTw+w55j0Bwas4zi0IdC70xs/7nue1ya8OgPQsXkLYpRNwLfgvBxnA8OQftF6yaKloIeMDsPYFyoVArIJuMTdsyw236g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=pbfXIZ4n; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="pbfXIZ4n"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so878113b3a.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 06:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788357354; cv=none;
        d=google.com; s=arc-20260327;
        b=RZRP8/f+RHTX/i0GMb70V6o0lp+IOydsunaMp/Q3l5oXbQztAI1PihYmZOrwpomiNY
         2b1jVkLcCBAynb3FrpdtzXmKXgClbr2+TMnFCSYZEIv3kynfXm07JcvFrwcDok9FkDLR
         8R4bVaHrDTEHUCcotlnB+/1Let568mes3xRu+sqW7SCD3aJqMfvG7dL+UL6mZoFm4FqS
         aOXtYNuv14+1e4JMOatyz/Ea8vC/COCjkfgXfnXcoVsUrYdeHWceGRhT11Tuz5U4MFnz
         E5FwDb6t3TWxP74AnudERO7ZIeWaRfxebdjUZfHLHLAcB+41ubpFzc2LHhOLNr29tbYL
         40Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJ2mpWf89VqNLx0HXZpgcj2qhq6s6G2t87DZrq2c6vI=;
        fh=1U9HK1Y7F15YT/TM8BABcafUXLm3KMzfg3hUXo5H/uo=;
        b=a53nB6UaIud3721XSAc7m5/3hjMY/UvN2ZjBRHsikGdOws3WpoLbTxf1PnSWy2GX8o
         4LIPTFrBFqRa0HDFEvvKe5onKBFBGfS/jZUpa/+lN435t9DF/BcXu3oBe8IsyzoRnA9q
         nVMBLJHEUaFu04Ne9VRm4KeFgdvKcdcgPSZR2WCUQC+4x5G8t78/Y6JyoMO/3PixEHPS
         a1pA1XXUxwXO6iBC2S649Lw7DAElDbOQf3/pSjEAtbv7LvA1g3aVZJ0TygOIvTbj8IDl
         0emBoCqpPNl404ZJSfZFr1qjKu9TAXguWZf/9wf3OdVTfpAbEc7FRQfPUzFwrUOdMCvM
         1R/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788357354; x=1788962154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EJ2mpWf89VqNLx0HXZpgcj2qhq6s6G2t87DZrq2c6vI=;
        b=pbfXIZ4nvID9Klhe2XTdjzTVKrjbZYkp7QXxvh6EykRkjG0S7hqssw0ZqSwyh7/wj7
         Nr1hsqWHTfb/U3qlxkXT2IYQdLTlIRusjEGchJx5TIJAse3YexkxM2JUq+olOxkkpuM/
         BFLBjsqt3mn1TZJYxVAFnRngM5Uf9ZdI5/qpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357354; x=1788962154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJ2mpWf89VqNLx0HXZpgcj2qhq6s6G2t87DZrq2c6vI=;
        b=fQY+hWiW7itEKlkCxE/w/RE6NvF/Klx3PSRmzs0LV7o0JreHEqdreIcN4gBVaCnLlo
         tyevszjeBLT76mm6LmhvkjWxuT/tL9PCyOBaZEtLaasgkps1UZS+GgsH8Bx8NkIO541T
         3/BJ1FERGMGkAupe7sidFu/NVRI7DQWSfJ1ZzsC14hJ9PaTTPF4gveH3XxBttiQOGILj
         vJD2uLm5vJzExJ8ns2q5sZS7q+my9fJgo7qjmaCZyJWVjQJwDqEbn1nYce7ojvIg4b3M
         o2VP33LfvggmfJ8OLuvy6DyYwftGWeiK/4i9nP630pIP/tCbfTTOuxCnEStfzY+3mvVm
         qlOg==
X-Forwarded-Encrypted: i=1; AKwUvByBtQxcUzvvXV+Yzrx1bvFEO6asytGHH/qfVJyGc5I4HVqJrOndacNWO1PPscBwOjyzIQz0TWc=@vger.kernel.org
X-Gm-Message-State: AFuF++lk42ZN2UQAFzHwXEVRlDJK4x3C8VBVShw2xWtnMqcLOk+l2hY2
	TDB6JKk5eiZm3JVJtmYa3LEKdUTALbRPivzHUx/lNQx3UX3oPRcFDGRfO4S2bt8QSAblX4HsjhI
	Ui8LAgwnkDHQYuqbtoXcGKKKmKbwLydkbfo3S7ECY
X-Gm-Gg: AYBFou2TvP229C25YTzcaSbNBEJ3DLZ86EFpHhbUgcZUwmhfTHUgK3y031sBi0u91e8
	Rme/jrsdHhSQs34KjUT0RoVj7jYJQl7wOH1EtYHfhe790jU5ERG5qXw+NUlscCTATsnH0yF3fal
	GJe1N8zJPEX1IaWJWXe2kWrkNO8neo5JWMViQ2eGseM7p7JCMk8t7lwtMPJWw9Vk3Xj0WvcI9C+
	IIkG1WOR8orBvJTls4PNs+CP6hItgEG0cCksiXozieX8jTCFBXLd91DHSfbrrb7aoN9X03gcUDu
	G8uJ50U7n6OIT2k6xDkUjE282CfHYO1LKp93p9UbrQO1z3qrEgDgC/QIBbK1lz49wb1Y6IcsLDd
	9PNn+b9VeNZVm8ajdwC424iTHck4=
X-Received: by 2002:a05:6a00:a90c:b0:857:727c:a1f3 with SMTP id
 d2e1a72fcca58-85ed4446f43mr8360770b3a.21.1788357354260; Wed, 02 Sep 2026
 06:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
 <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
 <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com>
 <CAM0EoMnENJAY7pP9dP6pbbWnW44Ug-Ow3C=sf87pfOTwxjMdaQ@mail.gmail.com> <CANn89iLr_3Z1MTa6U9SuooU7q-Yw8nXgRb=heSvoR=uUSTJgzg@mail.gmail.com>
In-Reply-To: <CANn89iLr_3Z1MTa6U9SuooU7q-Yw8nXgRb=heSvoR=uUSTJgzg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 2 Sep 2026 09:55:42 -0400
X-Gm-Features: AcwNN1Ws4v9UkYRayz3vT-mPBxZxcfT94vInR1hDg84Grfk8lViPb6ahDTIVL2w
Message-ID: <CAM0EoMmB+W6gkKpWD0JNXgxK8=9U9CiSrP-rEAE52KADvq-TQg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/9] net/sched: fq: clamp quantum and
 initial_quantum in change path
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	stable@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Vijay Subramanian <subramanian.vijay@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 9:04=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Sep 2, 2026 at 2:40=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> >
> > Trying to understand your concern: Are you arguing for
> > stylistic/readability improvement or robustness?
> > The only place i can see where the multiplies you describe could
> > happen is what the 709f34f7c28d patch closed. i.e this part:
> >
> > -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> > -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> >
> > IIRC, you are suggesting restoring the original logic (x2 and x10) and
> > i am likely missing why that is a must do? Does it break anything?
>
> It does not break anything; it just causes a cascade of various clamps.
>
> After your patch we will have:
>
>        mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
>        q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 20);
>        q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
>
> So @mtu is no longer the psched mtu anymore.
>
> This is fine.

The u64 variant would read cleaner for sure.  If i didnt misread you
though you are saying the current the mtu-no-longer-psched_mtu
aliasing is fine. So would it be ok to see if any other comments
spring up from says sashiko that are worth reviewing the patch before
I proceed with this? Or do you want a v4 or a followup?

cheers,
jamal
