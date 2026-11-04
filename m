Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778103;
	b=tl9t41dBzzv3Kj2zcCdSyYwhM5f5hzmSPqToGLXe5U9h6xwipK/LvUD8zS4K1wLb+QZp
	 ilnq5hkDf+frFSqgfSbEull/VojV6Mv1V6NbVgP/zB4Kqfg1uEuGHs2EvJ1auGH9Ttsrv
	 ApTOJ+2eauR4FifT3swXkPziog/DnhIcHSJ6WZp3/VeuFCWzHtN7HeRNU9vt9/CaEtfFC
	 3jC8mXtdIjuo8kyWQWibGJgrP47wduoXHJdLieMAJAO+I3h/1v1LNENqs+XhBUsR5xngp
	 M2yIOToc0FdDjwsf3B1XhVNpXJz6TCUqgtHAeJH1SJqD0/LT1IzXMJkfna8mOWkxdKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Disposition-Notification-To:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=COWDtAifNxy9eheKajXdjw2ArjUB6Mu5k/ceulB+33A=;
	b=qGO1LIezSmGQj8cbyNo+3jgna7eVuHtMAtceg65XAx4Oj7TG7Vh3M0D7KSQNiDB1bC7B
	 x1uAc6AulSmY2imy6WSjJuR6VIfetvEfSf1QQG1BSPvz5Lkkn/nAnUje+MVNIdL/RkGHi
	 78JYA7Av6G5S/AGSACrD4/36b69wLi6aaRahN0ks1aCkTNuBNJJvkiEiu88PR+fG7/SaJ
	 oEUeQY32lsOdcslN30lYgnUOUAFaK9HKv0JB3DnAS+uUJvpGTWklTH+q/Hevuc/XC4nXU
	 tqnvQ/B2K6OfJvsdXKNzTRKV2kbC0Zqt8MSw3nAER1Y+fYD01ifW9RzeZSQgUM3kcBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JiNghS0W;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4A606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3E4A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JiNghS0W
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ae14ee2d0bso85769a12.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 23:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793778101; x=1794382901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COWDtAifNxy9eheKajXdjw2ArjUB6Mu5k/ceulB+33A=;
        b=JiNghS0WbjBhBjplbOoFlqjxzZeyvtmCJK69gYiV7tEtoa1I+21q3J2Ylf1p7L/tDZ
         lrJVG/LZH7mUuENylhmMwA5PqSglaKNrvi7WgywMzZEUdK5OughJlpokHLxmqqgR+eeE
         DqzpNug6VzlkuOOVJbS+nTHWlUwVdNc/GUgrFZiOpP98FV4kD9oArKwb9je036+TbePJ
         WvnbLBZJ+7JjzlcZ4zBxZ++HpBUSS8FPfGI6NmSgschT5c0czNGij65Bn/PTLDYL7B/L
         +Yrqk+LHo7/i0oc21yRYNeFJ50INTNV0xB1sP2/+YcER0e4mNHkF16U0idnDASxuIOfF
         HsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793778101; x=1794382901;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COWDtAifNxy9eheKajXdjw2ArjUB6Mu5k/ceulB+33A=;
        b=umw2zZkt3hn51pyOEDhhVycKpQC1euHIXkdeAhfFtlr37KLEh8Fvg7SJGBfkwpkTPC
         8S9hxf5pE+dxvffTdxe5EDkfeFMTX1f0c9rUstgCPhEvyLxUGN+8j96y9fktduA1SqtJ
         fH3Mrfhl0MIxuyrdP8XtYUixQyNu8gNuYJ7+e9cqA2voLh1P7dquZ4Ec97s90iLudPTc
         EPRsKCNWnfAe3CQKb9NCWCpOs9yDrJ6T2tS2TIRoUrXyg0naXCzs62Kg1OeJbCHHstUR
         9siPMBtT9GRrnOsJnROU5EwfB3gpJKe+KQNbCPQTYRThhjeHg1ksPdnnWEYeLC+y1BeY
         c/pA==
X-Forwarded-Encrypted: i=1; AKwUvBwM6c5vbHrt6s9QIRRtsyovorOEbmf+gy0GA2uSbXKjNfKSn2Ah1Vd0nvUz9fxDxCcW+HrdcPo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GME4JacjpXcFp2jT4tlZfhxem8dZGmYRGvTkzM3o0zZJAFnzY
	SHGTUQxNZLMr3V0EbiGeA+bxRbxqpe2x7Wq8JU6M6kXyi7BqjL2bntnD
X-Gm-Gg: AYBFou3R7E2OguE5dePJCqnS2R9sw2j+jp9RO1l+69DXxdAvJpuXUUmDMoU3JTCkLLa
	5jBUB1bX1IZpYI3NNkmDpXpVFgsyQ6v2p2SihvIWnCs2ZukpxnO7SfxjdlBZCfCln/ZO4KEQMFr
	Ij7OInxOjnnfaRbICrVAIYZabcYAsCF6U2hFppJuiJBXmTGm3tyL/k0B1d31Ug0hMOHFsiLykFv
	23IL0kEM2ogQK4aQcqneNvzrJbgfi66d+upSc2T7p2MffMrJP1KmpYaNrf05KwUgtoB1X1YFbJK
	6MfEcKMYZxEPqrHybl+GPUKUTW7re9/Vr9JLqYvQ59dmSH4jdaC1FE3zSw4uvxskqw2j/6BBuKH
	/gitvneG1waunViVcp6VJZjdMuvT4QnB5mo9UzufjWkHOTsjdo7hbWexTciOiM+fwUDZMZune6i
	YWvIwnV1Xy1lh9J7rjJ/sijnKV4S6eiA6xRyiTS8BvctIhvzKtlUUMAIlNI4deVUB14NUBBLp+N
	zXI2nlj5vmO0+ZtxdXRbpVe8ThO6k6sZHNt8/Qj/c0q1MiUkrNkK5uCqj+O0RraXrRfad7YOEW6
	HQv/smqxpsMHjJXFBEYqkRscZocLSJPhltKmmknMfJigA48gd0VRExiUNXRja6+fg+9Yj/rNvio
	kanOg7w2zCYGsPCClW/MZ2YQaVrBWgaWJi3Q=
X-Received: by 2002:a17:906:f15:b0:c43:f1ab:167c with SMTP id a640c23a62f3a-c4ca7970666mr1286785766b.1.1793778100876;
        Tue, 03 Nov 2026 23:41:40 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e423a48sm43450366b.27.2026.11.03.23.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:41:40 -0800 (PST)
Message-ID: <c80644469f01ae6d2ba0339a7a2fcd7c6080c310.camel@gmail.com>
Subject: Re: [PATCH v3] HID: pidff: bound the unit exponent rescaling loop
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>, Oleg Makarenko <oleg@makarenk.ooo>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 =?UTF-8?Q?Micha=C5=82_Kope=C4=87?=
	 <michal@nozomi.space>, Paul Dino Jones <paul@spacefreak18.xyz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 04 Nov 2026 08:41:36 +0100
In-Reply-To: <20261104-b4-pidff-rescale-exponent-v3-1-f45e64cf488c@cherr.cc>
References: <20261104-b4-pidff-rescale-exponent-v3-1-f45e64cf488c@cherr.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-04 at 03:44 +0800, Shengzhuo Wei wrote:
> pidff_rescale_time() walks the device-provided unit exponent one step
> at a time, allowing extreme values to cause billions of iterations
> while ff->mutex is held. In a UHID test with an INT_MIN exponent,
> EVIOCSFF took 3.1 to 4.3 seconds to upload a finite-duration effect.
>=20
> Stop rescaling once scaled_time becomes zero, since further
> multiplication or division by 10 cannot change the result. The u32
> value becomes zero within 32 multiplications by 10, and the u16
> input within 5 divisions. This bounds the loops while preserving
> their results for all exponents, including wraparound.
>=20
> Also warn during initialization if the duration field's unit exponent
> is outside the range -8 to 0. This helps identify unusual device
> descriptors without logging on every effect upload or changing the
> rescaling result.
>=20
> Fixes: 8713107221a8 ("HID: pidff: Rescale time values to match field unit=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
> Changes in v3:
> - Declare and initialize exp at its point of use, as requested by
>   Tomasz.
> - Remove Tomasz's Reviewed-by at his request, since his v1 review
>   does not apply to the updated patch.
>=20
> Changes in v2:
> - Following Tomasz's suggestion, warn during initialization when
>   the duration field's unit exponent is outside -8..0.
> - Add Tomasz's Reviewed-by.
>=20
> v2: https://lore.kernel.org/r/20261102-b4-pidff-rescale-exponent-v2-1-a75=
bcca65fd0@cherr.cc
> v1: https://lore.kernel.org/r/20261029-b4-pidff-rescale-exponent-v1-1-3ba=
54accf767@cherr.cc
> ---
>  drivers/hid/usbhid/hid-pidff.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index 22951b7ecd17..7827b366fa5f 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c
> @@ -354,9 +354,9 @@ static u32 pidff_rescale_time(u16 time, struct hid_fi=
eld *field)
>  =09int exponent =3D field->unit_exponent;
> =20
>  =09pr_debug("time field exponent: %d\n", exponent);
> -=09for (; exponent < FF_TIME_EXPONENT; exponent++)
> +=09for (; scaled_time && exponent < FF_TIME_EXPONENT; exponent++)
>  =09=09scaled_time *=3D 10;
> -=09for (; exponent > FF_TIME_EXPONENT; exponent--)
> +=09for (; scaled_time && exponent > FF_TIME_EXPONENT; exponent--)
>  =09=09scaled_time /=3D 10;
> =20
>  =09pr_debug("time calculated from %d to %d\n", time, scaled_time);
> @@ -1433,6 +1433,13 @@ static int pidff_init_fields(struct pidff_device *=
pidff, struct input_dev *dev)
>  =09=09return -ENODEV;
>  =09}
> =20
> +=09int exp =3D pidff->set_effect[PID_DURATION].field->unit_exponent;
> +
> +=09if (exp < -8 || exp > 0)
> +=09=09hid_warn(pidff->hid,
> +=09=09=09 "duration field has unusual time unit exponent %d\n",
> +=09=09=09 exp);
> +
>  =09PIDFF_FIND_FIELDS(block_load, PID_BLOCK_LOAD, 0);
>  =09if (!pidff->block_load[PID_EFFECT_BLOCK_INDEX].value) {
>  =09=09hid_err(pidff->hid, "unknown pid_block_load report layout\n");
>=20
> ---
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> change-id: 20261028-b4-pidff-rescale-exponent-1d5c4e218e6d
>=20
> Best regards,
> -- =20
> Shengzhuo Wei <me@cherr.cc>

Works as expected. Thanks!

--=20
Reviewed-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
