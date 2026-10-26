Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792991784;
	b=Lu6nC4Hac10BDSB1PBq7uLv9XhTUiPZvTzD+R2V60IDSu5gDd5R969VBUtAbxbUYgR13
	 JCVavO5X3jUo+M1LeHl3iQl8KUeO1yHSlrjE0Dr+Z7eM4FdpWOPuEumrvbMTPEf8UiCLF
	 aTQOnn/K7JsX7u4qZmHjBjlz/SFnC/5T2blsumiIV50NaY6Ik7RcukrAST+VoFoDUAjZH
	 MMdYfIYrI7zJiDMnrE7dORv1v5thtHzE4Dx+1HiJIutvaeLoVwMa5oZTQOMRb5mcNowcU
	 a3ubt6BoWQur3d1RkGUHffRcSubWDv9WURCV4jKe8L7+oR9mtwAHfDF4ghubWoN3ceg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792991784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ahOsVudUc7c7Un9O3y9zKqIgbSxfkYu+yvHVouvLUFk=;
	b=mkIoWCd/4LFQlBJ5L1r+L7wT48n93LvIlW9XTbaEBSaEOamWn2c8lB2bNpw2FgDNQkSF
	 XO2Z43ndnDoQ0/AM7azZbTIf5ke4UMEAb+yxYXp7OZcAUwdpIEanB+4pvC88IJX/hy1RE
	 GZ1kEUljv8Uqh8GlKZyyVY5FigIDFF5dgWeNOcQ3Wa8Q3ivDB6rR2UB7EBdhrETDqUctN
	 3yUTv6TQ3rEiS56BRj1wYAvw/aXxBz9Eqt4eW2vAKBrC7ZbPzOnZVkrdHN5SQYeLVGi44
	 DtPMeAIX94woRt7QheAhC5Xc790/DQytg5YLIMvYMr816cTTpe/q2axCLRqngsL+NPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PQ2SpM7u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5B606A325
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBC5B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PQ2SpM7u
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c46bd7a7345so214327766b.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792991782; cv=none;
        d=google.com; s=arc-20260327;
        b=TI+BHxJS/Z9Y+Gjv0ivJlxMEBElSdx73cU0yyPo30MZNldYh+S7Qovu6sUp+O+Wjno
         pObS21v/SIog2/QKA6xqsfZ5CWHZbk01i8TLcT32xeF5fqysLUvR8Gakgrkls3ZUSPVC
         O3zqSp8dc0oR6LxiPe+xPODrWngJUAMUfEkQnhFtkGe+YIT3iK12XGaAzZPafY8jAgQK
         r9FlC9uZAByIp9IQk2ol3hnQmRuak/njru5YgDxC/ua1A5Y/A1J6I0dYWdhKdb9j2MWy
         qovtKJrkLl/o1u/kLbPnGlHPoeb1El0UtPfjOvJgm7zpOzq5kP5CuJePCPC4Jg1v2g6Q
         088w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ahOsVudUc7c7Un9O3y9zKqIgbSxfkYu+yvHVouvLUFk=;
        fh=T76AB2H0gODfUXTwMK2P+7siCtlp76TnFoWxCbKRJtY=;
        b=IC4TIGUAuyiRrVSWwbVYGz1gRgLZU7/S3F2NPSRXNvQBvF5YBvAncr1OHdU4E4ygyx
         st9WXhxAeI9/AyXf59Cd3+oVb+xqopDOc+ZkZV5bhZZ6jvrdSSxDoTB8pSsLAAErAfY/
         aflnd5A2SGLbRFXCVOg7m0GZ0TxMhEYexSZ6CcDtxySnZ0JrxFIQB0uBA/aRHcWODU3W
         AjA5mn0CpKEZFvaDB6YuZkXvpAinJzELRtnti7NeOev0BMM3q2rb0Ak35V/MZV37dnTO
         ltaf90Sz2NXQzdDCBb1/lc0xp2kyDpJ7we1vHBnszopbP5C1vvMRbgVvGo5eTvx9Rf0Z
         jzLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792991782; x=1793596582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ahOsVudUc7c7Un9O3y9zKqIgbSxfkYu+yvHVouvLUFk=;
        b=PQ2SpM7uqS9WHlEZYY7Xf+ANwxpo6Pdajhn2HOJ1DdtJm/nPGeq4afxXIMr1/D0MP1
         ZqEBE0YbnLXvvUOl5gxOUHjMwRYdV2O++fEWWPEwHF8pP20adYQjiRoJXhB8FjLAJbr4
         vIaCRcfHDK7mwKQdbDPFb+sVbhQzcjXA8oa65NvU3BNMqIAUP518xme/iTq6wXy7j6eQ
         xS+BVtRr9zQmDq/N+LW+aaRMQ5826kw+BNnfZmCmZsefZTh+Ld7rFEKIL0ghsEpd7fU4
         nQH+HKmVJthRcrKvvp+55A01lX8R+i8OYuFfufFg/8xCne27EwX2KXB0eUOYkQdXtmzj
         HKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792991782; x=1793596582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ahOsVudUc7c7Un9O3y9zKqIgbSxfkYu+yvHVouvLUFk=;
        b=LU03CelCa9IKXses2QE2/6HV6B7Fzc32ugxDqEvpyz1ZomTNfBltnyXg5v2PQJ3mci
         ZPn3CmowjTelNg2f51rQ93yHL+c1xgx8EgleH/W99uJQKe0rlImMxV6boABdsp/2RlIh
         3rsAua5zhuixNkg0rDSA48yGgd1cZM7lK2n4wvmb/d0YZPlCrEI8vGTHUUaqI+FQTzxI
         Q1w5cCK166JUtprI87AD5oyS6/f5BLN8lLFbSGpqviKuoo4JZS3A1XgiQz2fh0fv8kgp
         NTdAWkzW/0kTp3b0LRyXspR2CtToPc/iREtPQfB0qjHgZJc0u2n0BpwjhYSmqKsHuy8b
         3Wwg==
X-Forwarded-Encrypted: i=1; AKwUvBxit3DQXpHrXJ/SnHVkR1CrCjXujKRxv4shc3nEfST49UsckKy9yrQUKIieAE9RxPOfBQbjsAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJB5gAsLAZY1EZrevZNKS4tJ+o7c0xR/nE1Tga/Ep1xmRceEF5Z
	vZtM/+9uIbdEFyTbgi1qoG5N8qq/6v7NjrrSNLSqeXP78NdBYfSrq2I+Cye3Svi8iuDMiImmyxP
	oiagYHFsc2WKBHlBISwY/mug27LLP7lM=
X-Gm-Gg: AYBFou3j/1AEQ2tGB07WxT6s6ilmg+Zw4wJVod6nBquaT4HwumZR+pJZUu3YTdnzip/
	YCD7u8YhT8UITpeF2jcSWxsH3qdDeQfIiFhRT+WNyUuf3bN3N2JY+gVqDuNgk6zN6t7jZKc7i3o
	WI+v97iXGjuHD0GJ3UDLwx4guRqO8Did1waYwFt25UOenbnzG1GQ20hRijDD3Xt0AcKXuTrn/tZ
	+GH9Ywst0L2MKPonQMGDD48oOsP8kpBnIbV7oyF3+s2EmpeHOkzMQdXzmxiUXx7U0H9TZcDsEt9
	DahSkgMIzZEh6ypoB2FRjXi7WI8Xsly2ZZeuYmDsbumm3cVamX1Ba1TESUamFiOd+776hYWQkIb
	/XDyLpy8uN/krEuKP12IEl67rVNMIdVU4zfWWqMHB0sk3ev5V3Hlim/byS5Fp1bULKT7IJ0Re1T
	tTiMqj16V02VgjHqPA38QIAqkXDy1KjI6XqahzW8sg0eWl
X-Received: by 2002:a17:907:f48b:b0:c42:bc58:f21 with SMTP id
 a640c23a62f3a-c46be5bfa80mr612811866b.15.1792991782008; Sun, 25 Oct 2026
 22:16:22 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024172641.19424-1-meatuni001@gmail.com> <at5d__q_RzGad7zt@ashevche-desk.local>
In-Reply-To: <at5d__q_RzGad7zt@ashevche-desk.local>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Mon, 26 Oct 2026 10:16:10 +0500
X-Gm-Features: AclHuK_gXUAQAd7y9XjGt8VKlv2KxyzU6RO9-KdAgpiiPwDIUw-cWtN014mbLq4
Message-ID: <CADqcGBmOxJ1ns87pNmaSNVfCc-LNsTsf6YgnnZ5i+x4+dH+AMA@mail.gmail.com>
Subject: Re: [PATCH v7] platform/x86: hp-bioscfg: fix heap OOB in hp_enforce_single_line_input()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jorge.lopez2@hp.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	linux@weissschuh.net, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

No particular reason. I removed them while trimming the diff, but
you're right that both comments are still useful. I'll restore them in
the next revision.

Thanks,
Muhammad

On Mon, Oct 26, 2026 at 12:52=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Oct 24, 2026 at 10:26:41PM +0500, Muhammad Bilal wrote:
> > The input is copied with kstrdup(), which stops at the first NUL, but
> > the full write size is passed to hp_enforce_single_line_input(). With
> > an embedded NUL the helper reads, and can write one byte, past the
> > copy. Use strnchrnul() so the scan stops at the first NUL, and return
> > -EINVAL for a NUL or newline before the last byte.
> >
> > Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
> > followed by 4093 bytes of "B" to current_password 100 times returns
> > -EINVAL every time, without reading into the heap.
>
> ...
>
> >  - Drop the trailing comments
>
> Why? At least The first one has the same meaning as before, what's wrong =
with
> the second one?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
