Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466B47CA9A
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354242; cv=pass; b=d7aB/t9J0zlnf+yZalrr8VRy8WxXZ+stdsNeusT5K2CSA2T4y0XMkG89lZDAGXIqNk3z5UW94UNVs5vO6tGcpPHiSDVyY6TCwxYaJtE0tb7VjRhYKml0bL0w4MWyDKixXavJ3sDqR4M+js5kKh67RWjadGQCwuvdeueyw/4zsNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354242; c=relaxed/simple;
	bh=d3tednFs93qhVo5hjvRy9y5lXWa9IuFW7vC72+58OmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZAlgb/gCHEDd8B5wd7AnLuvgKCf7ejOhrerDv1hWMds7/bL8UsyTn/AfzYn53WOCrb03ToyMh9usyCXLD5SzFI02Q5+3Ms0JtFBK4E+OXpY5QFP2T8dLOcfCoFZ9Dm/zMSdpf6zwEXx8++wvxbY2mDk0nCX/B8b/Ls9TxTkE3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UtNWwq9K; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UtNWwq9K"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-936623c6dd3so230424085a.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 06:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788354240; cv=none;
        d=google.com; s=arc-20260327;
        b=QYKhNeHX7JhkRONxmEIA/IHJ2+0izwu2i0s51IeaVUGFy+WkpQYwlEr1TFVy8CCUVX
         OiGUfD0wlS/MOlpAk+FSlMYyNlPoRDFXvXn38U6X7YrbUve2noOU8ejKjHjIW1Duaw7l
         EO88ejB9AMqCInPcZntgenVU2c4jaOuFNh3Iwe3ofCHCovM9LpykeK9KGhES79J2dBIt
         R7xmRC32ln+jlowZ63Gg6zPYN2itrLWlCTpyxXshoIZxYa5hLnQ+rh+gdTebKU1PUXwx
         HX3gQx5wuS4VlHXSxE5t5CRDePW8pBDinijcKS2TVgH6dKLmrh0OX9MxMLSXWoiZ1io9
         qo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=REC0WBjU6HbnzKlsagTQJMv9INahl8hjQLf2W4ca4pg=;
        fh=OHPzcLj6WUFeoJ4VS/PG41IneZR+FGBaI8Px9j0G9Hg=;
        b=b75bZZUr0HKJ5MxCjwfI3Nc9CEyJva8x1UrFPoZLMQXBtWlQ6pJhte3jRnE6EZ9nw3
         kviTOvRlMMpdnkyr8w94OgQZa04WXodCJpVAPtFpYFZPlRAaoxIir1Jryua7y5cvi+s3
         voI0lgE5bcnkMl3vWJqqGbsP0BbMwSKOFNEEhPd7ZQxQm0V7/H9TBg0ZV+hmUmvNa47e
         mdFuk/5nLJvRoCcN5eQu0jx8amYC5PtS90cX1JGsfESe1NgMyIAz+XcjmhGzcRObzKFo
         99j4fdTIoC6CqzylAayu/E1w1CyodGsaNqQHi69SqUEeBFqFcNPtm5tMtnAdIX4KO0sV
         LORw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788354240; x=1788959040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=REC0WBjU6HbnzKlsagTQJMv9INahl8hjQLf2W4ca4pg=;
        b=UtNWwq9K1oJmDKrc3zfN1PFB/SI6SfMt5xWZpseDC8kcBaoGSzbOh7ZEVzaCO6mNGW
         oBWnLLXpNH3tAE5JEVnTmOZFl788dNx4CBNZyU3iyUMVHzgGqtnhP99SPmqUl6YhS1mP
         bPf7e3NgA6W2rWLAjVXowAwzc2NwiQDLvmA/FgoghaBnC81M6kSrOqpAqTEDGsIblFB5
         oSycm6Gh+P6tyumbez3eJPrxkOFv2vvbzOweE/zfJPna4fJekWrZY880gQx2fLzdID/k
         QwIHKpyGKnsACz7KCpanOrtAmxlCjRvxydfbksBXJ2tEwKfWURkRBye2BEk73YNQ9lxi
         yx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788354240; x=1788959040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REC0WBjU6HbnzKlsagTQJMv9INahl8hjQLf2W4ca4pg=;
        b=UszEw0tpk4ChyikIro2GoeEP3QBu98SSUcY0gbpv8Ir27/BGEErOlAUxPe4tvGz0gD
         OEeZ5HuJ029QlaRsPG6yMDdYcJ+YZ78Wp646bHu77c9FhPS77k+BKnvqrO7nw+OxTbDa
         oNDKR3KScXi2u4E+qMaI4ybfOcOONpcJXSZiosgqz2ZUs++zBr3EObjDwXjfMDp1gBFB
         DVPc/jeVSTiuGKdtd6SiJGbKs7z90/SxsDzaU8EeGP8YSkI9wOhfiui4okR4cq1ILnOs
         BhAm50HbOwcXrPUEWARLMXzFXgJMtD0gAEQ45LKqux3pBd9fthV8cUghRSTJao5S2JNH
         x4fA==
X-Forwarded-Encrypted: i=1; AHgh+RqoLHo13VzDEdJ1GE0uRVNHgZ82zbQjqHvlyLWVW3xHoZ5a0eQxQcw3/yZJFfVylJYkRutS+KM=@vger.kernel.org
X-Gm-Message-State: AFuF++mNRM6Q55u2imz0GDPLR2OHu3K4LxIiPtVUBH2D6sx32LjHG8kj
	OReWYbI+22YAXx4eflJi2qZnQ6IEt12tlQiQNC4vfX70I+ENdd3LTRN2VmC9W4uLXeOWls1RnKh
	JkTQxgdiKZPsdT32YJOEXxUEcKq63aK9jH4YVhf94
X-Gm-Gg: AR+sD10NQrpLUP7eD2ezDNOc9Xl4w0pWK7kFhPrPVQLTIYHz85c9Rm7WnEz++/Sd8JW
	1yKshTJ1uIB4M/xrXFgKc459j7D0UJsuLXoqSjze22qh+ynPEGo3+mQYohm9gUWSIS+YOODwAe4
	+N6WkPriySO1D4D1lh0mD71sTkx85q8a5iZBR4jDeGSsvRW9tCDp++LXDvOK242ELmaWQ2Ep4sI
	YJBf6nf3rvM9g2cqfE06oG8ll9lgggz2wslWp/E5pN36KW4+4hPAiSQsa16On1wdCxYQFy5NNGV
	ZD5RJP2bVsmQlWpSqojW5XCy6pkk4mw6Wb6eNMxdazDGIcWGRUXoxhAz5Iafo97Wr81g8hEM4Qq
	D3BS7qwNuIyBp5D2BrmwJjQo06Dvwz+3BpDGPa9hhScvxOCQvjCjezqqW4A==
X-Received: by 2002:a05:620a:1714:b0:939:5c17:8c73 with SMTP id
 af79cd13be357-93965763938mr276084685a.0.1788354239348; Wed, 02 Sep 2026
 06:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
 <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
 <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com> <CAM0EoMnENJAY7pP9dP6pbbWnW44Ug-Ow3C=sf87pfOTwxjMdaQ@mail.gmail.com>
In-Reply-To: <CAM0EoMnENJAY7pP9dP6pbbWnW44Ug-Ow3C=sf87pfOTwxjMdaQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 15:03:48 +0200
X-Gm-Features: AcwNN1X3f7LD30KD1qZfc49zPIh9rkbs0FiNWJF728EVXHW4XziSK5SvOhwvgEg
Message-ID: <CANn89iLr_3Z1MTa6U9SuooU7q-Yw8nXgRb=heSvoR=uUSTJgzg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/9] net/sched: fq: clamp quantum and
 initial_quantum in change path
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	stable@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Vijay Subramanian <subramanian.vijay@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 2:40=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
>
> Trying to understand your concern: Are you arguing for
> stylistic/readability improvement or robustness?
> The only place i can see where the multiplies you describe could
> happen is what the 709f34f7c28d patch closed. i.e this part:
>
> -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
>
> IIRC, you are suggesting restoring the original logic (x2 and x10) and
> i am likely missing why that is a must do? Does it break anything?

It does not break anything; it just causes a cascade of various clamps.

After your patch we will have:

       mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
       q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 20);
       q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);

So @mtu is no longer the psched mtu anymore.

This is fine.
