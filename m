Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336463ED5C9
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284947; cv=pass; b=rTYkwxGIxUEYxLnLGvhagw4nIlBHtd93rQ/Th/4RAJnlCyKv+q5ND4/4+6yoExC1/b7l85FjZ/2BP22pR3sX9XW4Kou1EHZkBsm4FTkPyWdM3pUaOwAAw6OKDDj22ylcilN6wxxl7k6B/1SYPpCGWFrj9Bahoc6YTVRMfaodecM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284947; c=relaxed/simple;
	bh=0R8llm0EFrqZ2IbxbCOlkG+jKbWRlRuWRiKKZa1D7l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzPMBGNTWZ3cCKqMWvqSnlE1fTI++NoSHDkJIKuRbpR5FJopyM4g7iuHmW8oyORt8WwnpzitWygCXHqhxWZy1gaJuM2HQbjcnxy7Y+WsI0C3dxixVhrkvHKT4mvDhlrRBiGzCmRGGeIgRgkLC/tS5gsoA5RYZrPwUoz1h1PTLVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUG2sDLg; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUG2sDLg"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so1338912866b.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 03:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784284943; cv=none;
        d=google.com; s=arc-20260327;
        b=YHfoS7Cy7z5wagY0PlEON72Vv7ZJUvdywY3BUFtWkybLG6kTB8OYZyx17e/DtMhrug
         Ez6IEE6lIzyXBe76JLxnniCSbhYM8qzPSnIfGTFfsi57bs7CLhxdtnepV2V/Y/aZNJTC
         aQElPlBWSWfSW3QsrkLPn49E4HyC7PzO/k21SEUHT+BLQ9EE91hjm3qC4OI3jM0kKoNT
         L24rh+6oIqrjlmxxxwl+VZEHzhXQmnAdFvNFR6MHqWc1GTL1algMjJHVBr5Z+0grk0W5
         ZM+bp1cmghEe7mhgKlcKATkaxq+YMt4b8+Qt5qnEduI0BioW8wpBXW1cBC5OnrFAEKO7
         RJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7CDNeDBUT2qdP6O3Gq1ihGrb8xj5GO5o5nq7iOfnSkY=;
        fh=s69UOdbvcCsDqy9XSHd3qJ6V9p0BEsp+YcnS1DbHngE=;
        b=mTTbbm22NHVIZdUcOV34VoPDg27LrfwkSGk97SxkJf9zDyZmmDSOVEpsWNNIqe7vC+
         OCRWowysXY++IiVTJDH88tPwaLXAqIWOMxHJCW4jFu+qO6AtD04Spj1meJtisWr55iif
         e9e7xcJIEkkCQfVH0KUnw2gRhq5glMVWjMQFDevMqVE42HqYeX/KUkKlW2WvsRgZm+4K
         uD1SOzroczb0nYEB8AwvGyScyfiy+iuleeQ1CoNfpwanB+fvSSP+4OU/XLWS9ZBA7gVb
         0mPTeyA2EoCP9lGDm2rgJihLACHd3/c1E3DP6JS04FElxRBZRMM1E84taWTG3KFZtUaB
         /cNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784284943; x=1784889743; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7CDNeDBUT2qdP6O3Gq1ihGrb8xj5GO5o5nq7iOfnSkY=;
        b=nUG2sDLg/vTGqGSqzl+Pj/t2uyyoF8LbAtu2Hlo72e4UAjFEG7I0B0PWPWk4VvQU0q
         OLjYiu+PLQkfjItnO32+DXUceU8qVH9JiQwu2zVSiTNTSj1fmAbpB41J27ptXEx5I4KQ
         5nXUXbRe5TXBpDWMMfGN5gZF8p2etq0VeKV7LQPubWcbGPb6wijajz8kClSbxuV15l90
         uyC36fbrTc6ey0n9x99A5GjfMw2ppvQ0CJ4x8k5FGdajiodU3w3AQ9a5I21Qf1oBB8Sn
         F90NB+99gHDCJwTTrBwMYCmLc14Qlc7Qp3n2S5dcx0We6KAL0ti380i1lflIfO9Df/15
         3YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784284943; x=1784889743;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7CDNeDBUT2qdP6O3Gq1ihGrb8xj5GO5o5nq7iOfnSkY=;
        b=Jv4K+L8u5QHgI09OpnDgC9WDjLxOC18BMkli1oYZTLCvL19wM2JYaP33bBJG8thIft
         MUHGu+SXcG7MkzK4QwYB/jNuDxfeqULxyc8ni/qyK5k5Mmda3ygw33dkAPvxFAyaRhJy
         wSCkovdBfqWMfRBsoC3YUsPM9cb6U2Uy8I0QC4uetdRButIGAzq1WphZGayCkUJOu79o
         B5aeqCaVS0Mw4TEL+x6bkJ4NG+Qis4oNnVr3J7EbqTnP1LjIBiMjae4HW19CFop74VgN
         459RMoHs7p8XjKdTqLjUVIgnrZwnrHnvTjRm24wYS4Rv8T++pWerfpye+5MyqgY+vrpB
         YHXA==
X-Forwarded-Encrypted: i=1; AHgh+RoUJSxZIK7+6u4SCgkNs4vskRRA59SNfz90pBWe9kB3Po78l0tkEs5gddrqK3KLJO6SyK+55/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRsO57hbmZHWElex9zzbT964A1rmaHYIb/AHpK3YhKO/45PyWR
	76ozLJua0eAHDbs5BVheqWxX7jRPnsSlcs3c1aduy2arMluOIMTofUBIJZG8XhhnrSVeK78tT22
	f4S9Px0yqMnpjprjbVePTnsKcRoFvR6Q=
X-Gm-Gg: AfdE7clUk0wjVqoweJpJsSHJ7WstNlJCBRF5Ua0MeVrs00cvtgKu6julq/6jgizDDbk
	9EoCtL17UBer4p7i1nPvFHMq2Nboyh40c5EvTLaJZUh6SaLURysSoHNZkufa0KW25Q19PRfhvsc
	ENSGb2lbuholD94fhv38XP5eok78rJAfVG7igIpMhBnBrg0o+Wy/G2x9sY3+S9HoHkCji54oZq2
	BkZcRfR2h5wynqKw5OmC/svkpKe0MhkIR7O3fhVkBBoGm7CoEG2CP6BurGY534S8siK3kE=
X-Received: by 2002:a17:907:c0b:b0:c12:6d25:2c7a with SMTP id
 a640c23a62f3a-c16b46e02camr92779066b.17.1784284942904; Fri, 17 Jul 2026
 03:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh> <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
 <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch> <CAE2MWknt86W6yCtuS_RupiuwiDqXT8wZqENM2DjiW1R=eY8qdg@mail.gmail.com>
 <797773e2-b155-451b-ae97-e8a005fd2d86@lunn.ch>
In-Reply-To: <797773e2-b155-451b-ae97-e8a005fd2d86@lunn.ch>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 17 Jul 2026 16:12:09 +0530
X-Gm-Features: AUfX_my1PzHSS8WAMVOk58Ferv5AB7ZeFGvF439u5znvXo9fyXEAn2XHzEUmwqE
Message-ID: <CAE2MWkmbdDrCw1HUKm17QG7dyihuxg_1VGTUNeBq9v8NVwJV3Q@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux Stable <stable@vger.kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It does not force the users to use a value < 128. You would need to
> return EINVAL for that, which i'm not proposing. Returning an error
> could break user space.
>

While I understand that clamping avoids breaking user space, silently
modifying the value might lead to unexpected behavior that is
difficult for users to debug.
Because of these side effects, I am hesitant to proceed without the
Multicast maintainer's input. We should raise an open issue on this
topic to get their official decision, otherwise my preference is to
ignore patching this for the stable kernel versions entirely.

> By clamping to 127, we don't break user space, but we do avoid the
> kernel bug, and at least to my superficial reading of the RFC, we are
> "language lawyer" compliant with the RFC.
>
>         Andrew
