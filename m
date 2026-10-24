Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792865169;
	b=tehcsiiXmJcSft5+AgXMGxn8lVas4FEsYMXgPDdG4x7yhQtT2zxNQWKD0KdQE/62ac6O
	 V71hLQ7ibRAkMYYmdR9LV6e2wcvvu2OTrXYhZv5YjL0HYxQKAi5U/U4X3YNhGApP3UA9w
	 aSOESjMjp9GsHBMmKBpTEjVD8AwZv6NULssZLpFPu6kT2uuycPFwL1w5+MnWMij33wKE0
	 T8ABBICy/saK3EicCtTXy0xHC8xTCwsgz4W5eRuJkBxgwNxFdyR4U8xJf4gqVb9O93iyW
	 /AUdtycT9l78Y38rEW2EPhxSZp72h/mE8o6kNA95zEf1pxAH7D50lyOgTwqIa8w8mHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792865169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lPG44ydHfbZv48mg+W6n0PmTi2ySUzCmeSRTbHzbT3k=;
	b=jeOpRZlXdqianwa05Ay4HjbfP2NSDMvc5UnQWT+7KhQpEqb6KMSOzBVp5MXQCXoznNsx
	 dUUNrDFB2nO9quqLxZt1UYoAZXKfznVPF70m1jPNfeOTjerdCYZzflNBNLbz215n35d9T
	 hiuz82qcTN14ICobHu+AZX0pQaLZ5ncA9WSjqO10LtjVPf8jUaa6oO4msXyEJCDoEFLI3
	 nUGDy2Joqbb3g4eOkanrZ+AtA4xyGt8J0eyd9c5bGG0IFhwRzRllkbnrZZ3Cty+HCmU/c
	 JC8JfKdTR3v62UsLSdyujq4f69xWjO9df7K/8ZGua+mV27LAihoVYMy6ZS0DKLqqpTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hJyH0Pvu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A12606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A12606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hJyH0Pvu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c34bff61551so255139066b.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 11:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792865167; cv=none;
        d=google.com; s=arc-20260327;
        b=I6dfGIj3W1YNDJj/SXMDaECsoFnG1L1+mve2PjvwqItl+qrzFE4owb0Q0/OBoply/R
         vYr78uhUvFpJ9cQoQ6HwU7a2OsvXx7gjaGhMObilAMP6Uyo4AnqpdNxxIodL1Eup04Qq
         2OROYrbbzG5m580SgCSZJdWv/SXdh3uxK9jMA0iRuc766UAk4i+EP3Wj6n6Y8Y+r7cvt
         Emvak+AjaoftTZAJI0bkvBCzbLMkmRCuj+bKnGt6Thi3iF6V/tnNXhMx0f+OoUgfQtM1
         zUWIHFXnCUGpBdst8Gz/4g5BtfQNDiU2yzMC51NjXYaAlap17c+TDwn7VPPr4zT4p3hF
         z6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lPG44ydHfbZv48mg+W6n0PmTi2ySUzCmeSRTbHzbT3k=;
        fh=0aX016f4KuR3ieGOstdYVvn2fJ2DKqgnnC4JWAr3US8=;
        b=hASftMpu5ALf1h+zl+cdjLTF4MfZ2Z2MqUdhgVX3IEzcuNNQuf/2mqM2znJPpf7C7C
         6Sx516zUm6DDAxvmbSeyKSpANv+hxwNRrzJ3rhFhzKBRrolYDm3mUt4cyWMjdsTktnvU
         s8SJB3w2Bbo5pZPV3AyuJxPlcn1nwO+E4NTFUN3VRKY6tVyjBRCJQAxeIUgd5nFBiBwu
         2LOuOdUN307KLh5mKY4x7nQ0l7vIUjmG7ieFUlaH0ZMJD/LkJ9bmKUzucrJSCVQkFfto
         PFW6/STdBy1/lJj/nT7Yy0e9GEFT84+sbuHOrQOyJy8LgrTQttxFXgNHvweRz/n4k4h1
         dPoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792865167; x=1793469967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lPG44ydHfbZv48mg+W6n0PmTi2ySUzCmeSRTbHzbT3k=;
        b=hJyH0PvugVb7vJNbOSoFSxa6zVPMprVBIUroubynC1lIsGBcHVYPmYXpKw9GJoaTJb
         g847IYIRZ/pK0cA7eYB69sD5X45yHth7cFTNFYMF2JM2zOQ019bLsbhwuL4gl5TJcPMY
         x4FSpwugGRe6ubcc+x6Toe45ev5Lc7N4n7QdbJWt1RrKyC5Fvf2EP3MDDoyDI57xCFwA
         UV5joMBqyHXnnlBrUyBoAMF97kQv+iYCK94YJnm+4LlAofRAUesdapcWJ7NAX5qB7L3E
         0n9o22HF72igY+teSD7fAxBSGcL1UM0XwTEFbev0a7xV2QAcPIbzL2Uo50V4FicGysab
         6qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792865167; x=1793469967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lPG44ydHfbZv48mg+W6n0PmTi2ySUzCmeSRTbHzbT3k=;
        b=FSspCH381Jzm33aEtERDlAyJv/++OqyoPg34P3wCQi276+3VAtcCJXOxtCSEZ0sYuc
         3iD1qkxSNHnenuYbnizEe3nYPbSTTjzXkbIMga+uCUVGZ5Ws+MUI89CzjnzPTpENeAUd
         8cNgkWDXwnI554nTJ7DCgdX+UnxPD99L2Q6VZcNS78QTSxYwgfVywf2fibXqvB3EXeMs
         TfxtvXLk8Ec3MJnYQn2Gw7zZTqHcNFHvWp+PR7SAcDlg/8/OrIAsG9AxpOMWtE9zZZxY
         pANpUUtzxERQSMOX4XmrUnt8IHbQsYIb6lrzXyP1qKbF7wg5GF9jCks1OuwmwH8nwNlm
         KHZw==
X-Forwarded-Encrypted: i=1; AKwUvBxy8JUj2Jjsl7cIRQXLAlqE5KB/HOYWExP+BmJwUThAdoSnBd4gNddPdd8W7r8+G7/Bu71aw5A=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8yHOGiLmPWnU+BaIsxe8O/VsNT5qXcy3XEIl+YYac6UoE2iXa
	afFA46UaBf1VReGfl/gACiHucbeXMoSMA8DnunONT/zlMSdaCOxtrtP6qqxxQOgR0E2FFNSm1D5
	YYWDWbZbyf39GPtD/XeDjws7/RArJmIE=
X-Gm-Gg: AYBFou0pJhAnA2YyqV+ZzxGCNWWHKOcow6jpp1+nqT94PoSfC+B9mxJrnY9wpeH7vRV
	aGU6U9vCUPi80K7j7vIq4aJAoruB0J1332YmgZAE1lviFM103rr+wA24rgUGeTu+VAGiPliB3i0
	tZZmNRNqJziHl3gw4ITAa3Q4RSDshLvfg4R+iSHdbnR3H0MEOBbF8yzMrYam3MgsZ/FowZ9H7tG
	8vyRMGMyko8J/8rZgN+yVczQ6OKdkQtwCyILbARez0HbM4Bycmk5gvNKqS/MIx3y9fBxvO3pkkG
	b3W2i1+WavfQxGRjYPuPwkOhE0YuMrPCcDJTAIL3ifUFiXHkY2i2ASAu1Np5xqFE0V0W2ybDzz9
	Dfqmcymf0MiFSe+5Vhx9xQM0Y9roeCuOoMG9l25th5WeCDxGTKvdwfWTm2gQ2/AQgRbSN/r/Moy
	zgVdxBpoM2dYz+pzybks7D
X-Received: by 2002:a17:907:3da0:b0:c3f:98d4:dfe2 with SMTP id
 a640c23a62f3a-c46bde25765mr313652666b.18.1792865166843; Sat, 24 Oct 2026
 11:06:06 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016025352.230535-1-meatuni001@gmail.com> <29c3e4a2-9d6a-60cf-d06d-85152a40a703@linux.intel.com>
 <CADqcGBkV4iE_0j6usv6TvV3K9XGUa0L9J-ebUkTLsB0NBYzTHA@mail.gmail.com>
 <a905f45d-aec8-569f-d5bc-718896f7c9c9@linux.intel.com> <273be4cc-ad7d-cdcd-de25-8d1439bed3e3@linux.intel.com>
In-Reply-To: <273be4cc-ad7d-cdcd-de25-8d1439bed3e3@linux.intel.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Sat, 24 Oct 2026 23:05:54 +0500
X-Gm-Features: AclHuK8PFwnTEGocukzPDuOlDq-fzoGEr02g0x88KN8IXdmfzdiI_JHU5c7rfq4
Message-ID: <CADqcGB=z3_mQ77Wk3E9tWMYyCaQ2hCno99kgPKH8ZrP9EFKY5Q@mail.gmail.com>
Subject: Re: [PATCH v6] platform/x86: hp-bioscfg: fix heap OOB in hp_enforce_single_line_input()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy, Ilpo,

Thanks for the review. I switched to strnchrnul() as Andy suggested and
posted v7:
https://lore.kernel.org/all/20261024172641.19424-1-meatuni001@gmail.com/

Thanks
Muhammad

On Wed, Oct 21, 2026 at 2:41=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 21 Oct 2026, Ilpo J=C3=A4rvinen wrote:
>
> > On Wed, 21 Oct 2026, Muhammad Bilal wrote:
> >
> > > Hi Ilpo,
> > >
> > > > Why use n variant?
> > > strnlen() keeps the read within count, which is the size of buf as fa=
r
> > > as this helper knows, so it does not depend on the caller NUL
> > > terminating the buffer. Both current callers pass a kstrdup() copy, s=
o
> > > strlen() works too. I can switch to it in v7 if you prefer.
> >
> > As the contract here is the input must be a string, I don't see any nee=
d
> > to limit the length with n variant so I do prefer strlen(). Also, we kn=
ow
> > that it should not be longer than count anyway.
>
> I only now notice Andy's comments which seem better suggestion in general=
.
>
> --
>  i.
