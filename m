Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623474;
	b=BpVmZYLfB1tToSRsA9e17VpPPM5muwg4SJx9eUOO3nL1AUH9TOEDgzNEEuFqdOj3BlK0
	 qZ23dRjB7dkXyhnewbiTLSVlW1UKtBpdrsLeksm5TUKeCL863gQ1gEjyqspnIDvw8nORr
	 heOzP+3sUxGbGwrJi91IoH7LvXROAW+oLjMcbDvoqQzRkSnfbnvC9MXqXSIepjN9P7pDp
	 Ph2meS+/oYQC8ubHLoZI5IRs0s3vwP5KU/E9LlUZN3cK/GtUg/9vob483GOn6JxUKo+AZ
	 9+vRvhzbyEYl7HLMk7v1U+pUveba0VrGRBNwsd1iayUjDjYdOnEfcCKeUeV7z/WF37w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Disposition-Notification-To:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=dYanbEJ7ydWKIVlseZIgyCbLcRNjwGo/7gUCZwqpJKs=;
	b=X1S+7eJ/EBigoJc9u9MbZb7Nof/tsP1KMSinV8mzKT0/FzysN/SQqfPr8inwNKC3zJIu
	 yVh8DDtfV+m4GTzYBkHjPieUD0eJbUV2nPruOnO7JLdDMcdwqeNCq0OdfcyEe1FnvnUBf
	 tGsK15pKYK6ch29jmiR2NsvGKuqZD0pK4vigJ5LkjyQbeeGsMxjqc4F2sdeRMqfui7C7A
	 was0wmvBaDLEqFiCSfzQ9GlzW/bk8pqg/EV+XWJUWwL/bYPfYauqRMmNRev68UWuV2xJ6
	 F9XMNM+mQlgerbBI5ssGjpIyN0lrYEIyysZIEECO3dT2RzJlQatZTCl89CUmDfl99Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipripHyn;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1760A3839
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5F1760A3839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipripHyn
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40aa03a96fso54143366b.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623472; x=1794228272; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dYanbEJ7ydWKIVlseZIgyCbLcRNjwGo/7gUCZwqpJKs=;
        b=ipripHynXFhBUZYO3ONkgpAkySdmoxAaDbs93kVcEyX1tuR6xSxgQMnbjh+OfX4ozK
         3ROdQxJdv3Vh/6K70Ycd/gX7I1HGc+HbdWgEcCn281ZdUL5H66Hb2hfk1oIwK8OyZGCV
         YqFq0wo6Z48sEqRXQJVBxDPjcHuXWpPtINRmOjaKecvPs6TuwLfdDiPm6RuhX6UabD6J
         3PWpz/tm8vagnQFLxPv/SqjZySmGtt8OdhXGJhHWx0svC6YSsK4K/BHln98i0VrJwGQB
         +yYMwH2I5/K64IWYRaWxD1RnvziHZPS0ZDU2Yv7bxaUKh4hD44bxeluaiDP3p5/RpAKz
         ERqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623472; x=1794228272;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dYanbEJ7ydWKIVlseZIgyCbLcRNjwGo/7gUCZwqpJKs=;
        b=yyQDlWDTITjPnVciGwSR4A5GGl4NGuH7v7SwUsXbj45FoowNfRCtFZNK3IbvlrnZzc
         rytBKDeVHVfLdJeYdkBQUEvzPwb0RaaQM9KdynbI4Ybpn0wx3sbyFnA5nTsFKcBHXKsJ
         DMUquHPMgDxn8Of4pEXrrhIaHfvLNvpJfsi4tUFpYqFbp2P1LJHeWbjwLrqoCHhUeBOp
         yp4Enobci8ix3dKHMeiz3Z9pkw0hua/EJpFLPJ+c7aFBAFDUKK/xw2TotRI36IFiVVOl
         2HDM4QFziTjZNZ7eQNQYQxPKTrtSvHYvFOL97ffcigsvi18A8ZLXQA3UCJNZ7flzRg9b
         WHMg==
X-Forwarded-Encrypted: i=1; AKwUvByCSnrm6fHtjbdd5TWTii8ktPrXiug/bs8maDKN8NEx5/SfMPcYjEiq9rYdMzEN1w4Yx0I60vQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wH2Lx25jZaeYxO2pCg6mHUsYGNLBx4ojDHNNtdVRJJ83OcveY
	CHi3UEMEevmH9HuKZXbVIyFD8P+XEbanFgrTMWuWnX8ElNHA5vjBjBYg
X-Gm-Gg: AYBFou3CUTjnwgKWL95GF3hxP/zOoSXUjdgSf3FyOk8pvHtaFoh2MHNWtwsKWJyrhK8
	+8KtTyxGBM8vHuJc9n+X939J0FWrHKWZ+P+xBlE206MDOcd/1BJJaQVKeKzhwzJnEa6Gey0jHeD
	9avOHOnbzJnlR53nba3Ab0Q5bobTKo/5RjsjpsKM7cQoiUHfGfT8OLViwbNNe4Y5F/Rr9DH801S
	KiboVDN9fzSOW2xTjGF2ZL3krNPoy+VWxQwNrw9rnQ9gCPz2KCOdBEBE72Lwx3MV0d6AeWx1dUE
	GnHaNvfmIH9Nri0dzwwM8gPRYg5SqVWZapl+3Jan4+nee//cdjK59tVApLc6SPvtkVEmX27dg5K
	tTs3NWin3B54t3OlBISZiutDLoKwkCwzSJMj1tQXMrfGtJvTlug1/RM0YDFVlJPldpRxx4dW6ZX
	es/ZAs5sxuouoswT4+7IZBoPEEqwPfycEZ1k19mOeMIRHxrBLGgcdwzagfBPmQD/Sq7+P7R+WBy
	pWPMjXdybHLUDcgjzIWLOmwmdbrkQ4WapRKhPXr5x/mitAk6EqZgyintjgB+QeFkNRJb9iJHagg
	jM5R8ZTS3TotMCD06BpAyz9bt8ddRYsSjfPNukaTpbslNvtD8OoHT/ZGWkMpSKdJ5mr7/PN0bba
	NJxjqABG/QZSlAb3K0BqSaKKm1u/dl5AqyxE=
X-Received: by 2002:a17:906:178e:b0:c46:b5a7:5b29 with SMTP id a640c23a62f3a-c4ca7a50798mr780727266b.2.1793623472076;
        Mon, 02 Nov 2026 04:44:32 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca214fdsm3152504a12.36.2026.11.02.04.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:44:31 -0800 (PST)
Message-ID: <bbd1ec87a9fff50b189f74cbd21e1d5bddf41136.camel@gmail.com>
Subject: Re: [PATCH] HID: pidff: bound the unit exponent rescaling loop
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>, Oleg Makarenko <oleg@makarenk.ooo>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 =?UTF-8?Q?Micha=C5=82_Kope=C4=87?=
	 <michal@nozomi.space>, Paul Dino Jones <paul@spacefreak18.xyz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 13:44:28 +0100
In-Reply-To: <20261029-b4-pidff-rescale-exponent-v1-1-3ba54accf767@cherr.cc>
References: <20261029-b4-pidff-rescale-exponent-v1-1-3ba54accf767@cherr.cc>
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

On Thu, 2026-10-29 at 00:04 +0800, Shengzhuo Wei wrote:
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
> Fixes: 8713107221a8 ("HID: pidff: Rescale time values to match field unit=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
>  drivers/hid/usbhid/hid-pidff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index 22951b7ecd17..1a2fffcf204e 100644
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
>=20
> ---
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> change-id: 20261028-b4-pidff-rescale-exponent-1d5c4e218e6d
>=20
> Best regards,
> -- =20
> Shengzhuo Wei <me@cherr.cc>

Tested this locally and works nice.

Should we maybe add a warning to the driver that the time exponent might
be out of a sane range? Sane range being, say, 10 to 0? This of course
would have to happen during init stage not to spam dmesg.

Regardless of that:
--=20
Reviewed-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
