Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F62F12AE
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633707; cv=none; b=GOHMc9TOdE8yXSWdYyZcc0b8Yuea3adnf7VeVH4eyiQW3XfvMYnd4CqUNl6Zp92AFvqBjvU8JwxaYvqd9aGZB7A6mQRXusNOkaurRrK8N3jtZyPLfwHR4da3r3Hhz+UWaerajoJJMwZgq7ecLM31rnUUroN47migsWO+fOlBKaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633707; c=relaxed/simple;
	bh=COOz5ng7gHKElXtrhP5RbumoEDz1nRKvh4K6gY5vDeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qagNnv3t1LnAP5o2Xh/641GYMdxmzKo3qqhNgGC0x5Ab1VNWSNRZuJjYNxVWJQDqWEQYmDXJ1PVnK9r1xehqap56ZHaumEKfRnIKaxIfUFEj0cASZE5OLOJFblAxZ1bcvNfNYchTsWfzYXu7l8m9DiSrSZ2/nQBCuP4KjsF20c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwV6pXTP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwV6pXTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABEF1F00ACA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 21:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783633706;
	bh=TSwvbr/Jelw6UpvbFFiYWu/jPh3uNqSrRLawIqCIhKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZwV6pXTPqkNPt9c5r/5n0bLNl6mi0IVXbOv6UtfxVBo+PQz/BJvJAiePK/HBHwJzi
	 P1RqVhmkl1Px2xNIMMp9U0qGuM2XNTYULL4UeuoOQlmXqWknJrdOE03KOLh2MGMLvm
	 B6+CWWZK7sHbR0lpe1pK7S5fZK2vkQKBN/5e3uDQCxGgHmKvFEDgPiVBnCX3nLydOB
	 CLqH7EAolil90jQTSLjcVQr6+loblxdJFu6HViJkNtNXlC8kZpNv5Dbq4qHtvlvyOc
	 X8DUQP6WlHtTfcCsJxWgrCHqSyMAXR/PeJotaBmM6fzGN4i1HoJN1A5ZG7OQHQTNWK
	 ZpbRdoC3DK2Cw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b00d1e7082so197154e87.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 14:48:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro2/yZS2Rb4pRcedlxS+fz8HDMovVzTfOTBhVQqMxDaKDhblhqV7eC+lr8UX5lC8yAUARqldZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydzu3ptzhB4uUKh4DgEcQTPS9qRSmU46yLdR9lC0pXJc/8bqXY
	pdwZ2Nm9/PQjcpbEnqqAtOsZ3+j25TkUJIaHpZrdLEJ7XRPlHuU3Q24G2d6SOmpBpsajfTpr5j4
	+NV//ABlNGbYBKdUJKlxC56kucstzGHo=
X-Received: by 2002:a05:6512:318c:b0:5b0:1ace:3bc7 with SMTP id
 2adb3069b0e04-5b01ace3dffmr580054e87.31.1783633704667; Thu, 09 Jul 2026
 14:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708014906.1463-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260708014906.1463-1-pengpeng@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 9 Jul 2026 23:48:11 +0200
X-Gmail-Original-Message-ID: <CAD++jL=APPmdAg1y6igZ5qxihUAMkjvRUZ26gmCBGdoA-N5edg@mail.gmail.com>
X-Gm-Features: AUfX_mzze3LGN8VuT0AKhPa0bBlZvUodRHQlRxCB10Wpn3l9wDY7boYKzGK9nS0
Message-ID: <CAD++jL=APPmdAg1y6igZ5qxihUAMkjvRUZ26gmCBGdoA-N5edg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] mtd: afs: validate v2 image info bounds
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Liviu Dudau <liviu.dudau@arm.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pengpeng,

thanks for your patch!

On Wed, Jul 8, 2026 at 3:49=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn> =
wrote:

> The AFS v2 parser uses footer[8] to locate the image information block
> inside the current erase block, then uses the image information
> region_count to walk entries from a fixed local array. The footer offset
> and region count come from flash contents and are not checked against the
> erase block or the local image-info array before use.
>
> Reject v2 entries whose image information offset would underflow the
> erase block calculation, and reject region counts that cannot fit in the
> local image-info array before walking region entries.
>
> Fixes: b7cf5e2830bb ("mtd: afs: add v2 partition parsing")
> Cc: stable@vger.kernel.org

I don't know if this is stable material. No-one is running into any
regressions, I think this was discovered by code analysis and
is mostly theoretical problems.

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

> +       if (mtd->erasesize < sizeof(footer))
> +               return -EINVAL;

You are aware that no system has an erase block size less than
64KB in practice, and sizeof(footer) is 48 bytes?
This is why I say this kind of "bugs" are pretty
theoretical.

>         name =3D (char *) &footer[0];
>         version =3D footer[9];
> +       if (footer[8] > mtd->erasesize - sizeof(footer))
> +               return -EINVAL;

The same theoretical thing here. footer[8] is 0..255 but
erasesize is at least 65535 and sizeof(footer) is 48 bytes.

In essence this code translates to:

is something between 0 and 255 more than 65535 (or more) - 48?

The compiler will of course just optimize this out, but I'm just
pointing it out.

I understand this kind of fixes are aesthetically pleasing
but they are not bugs. More like ornaments for coders.

> @@ -278,6 +283,8 @@ static int afs_parse_v2_partition(struct mtd_info *mt=
d,
>         entrypoint =3D imginfo[pad];
>         attributes =3D imginfo[pad+1];
>         region_count =3D imginfo[pad+2];
> +       if (region_count > (ARRAY_SIZE(imginfo) - pad - 3) / 4)
> +               return -EINVAL;

This is valid sanitization of region_count however!

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
