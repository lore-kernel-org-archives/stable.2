Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697621;
	b=gKoe9bziFih4gIQ1w3zszdziYrnG6wpX1Evq0hZUkn/ho5Cirr2H8ZYWdgK1hACF0DY5
	 yrOdpTmrUdJ+fGy6dv8fqWCY1tPv0xHTmovccJFCzzlE7jOdWvU0SCsuzd0ebea4E5UHo
	 U0TRfgmlwagPtw48peZpzZ+NDexCVuf62inFC7UJsoMMxY053wjIP4gYM4BkfAFsf3Gfl
	 dvgT9ive9wTb/9HK7wG1zcPxP5rQ130ayouWWWoNeQ62mqlUn2NWIDT4pvQq+x8cNwDjg
	 0L2yRzKXbF2UGA6BAjqdgYlBCdOGpuopphSoJ6aPt0M+92FcRipNxY0VGt2JgkQ7bDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Disposition-Notification-To:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=TNCUkOdrDNw6Y0YerpyggbymdScac6P000lKA53Qu5E=;
	b=0hhQfkXHTMtyT3/PkzNMtKbhWa9x+rSuTFIqN2f6AqX9+BhQYC5f361zaky5uAdaXeZa
	 +sPxB97n+2xwHjGfY55VHyoBIFElyuc1zriOOcNpTDUNcHLLaewGQ7PNc+u+Cq9UqEaNa
	 aG++DnSEdBS88A4KmXz1PlGNCiFq5/QbIulZOVGWwG5BxhiP4/lFssrGUrUNCoFcM+TUP
	 h6Jzo0IO73oXvMOWkhtoYrDPHbWBCTLcGmCL/GQ5N8BJeVG//14IbnYD8LvkyzyerXmu2
	 DHXm/1HnHR2fBBSwnD6BeUmATVwH0Vk5pvRgv1qLshJKmJ2VAG2Obgt/aGTuBL2lJLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MgAXlGvt;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F679606A339
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F679606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MgAXlGvt
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c411b7a2710so71342566b.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793697619; x=1794302419; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNCUkOdrDNw6Y0YerpyggbymdScac6P000lKA53Qu5E=;
        b=MgAXlGvt3N4HPmYe4BFyl00Qw7aY4cTpOPdLrts5i12nDmokkC38bTWwSetKa3NoYY
         JZqP5sWhuckQoSdqZ0yZvL1x1kKXVozy5G9oAHmArdJizqr+uq7rA5706M7tSOuYs1R7
         RrVysGMeJe22az4/DYIain/haTwAwwdi3exTWR152z4dkQx8qDcMUj9/P/JsScc6kq13
         JxYIwmGHjXIIitvY0j1zqJlwy8BFd3BiEwOGTBmeCUr0yTm7A630uFw6YvKzHNpzxkIA
         qevdaMPZz5TY7i5N8wlW0BN5Yb5Y/81WvJ2GT0A1XVyxSShxQMP19kpKSDJqwPAvBbWu
         xPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793697619; x=1794302419;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNCUkOdrDNw6Y0YerpyggbymdScac6P000lKA53Qu5E=;
        b=V9E02xq+QYnRT5SDWKRkz1gnoxCUvPjr3PYgBHpl72mDd1H62xPodmME4V8YtktmhC
         MQ7n94mEB/TrO6rlJPKxDQxfkwofxXrUVZZW/oMyfR73hH6/G0cgC1viQnA2v9uRsGQ3
         ifQT46IR7oLA23vfISayQS2brTPvKdTsBTX7k6HPsyGhN5ZFL5y6dyvbAD91eQTMxx59
         rBu4kjcmEw16X4Kw2ijGWOZbSehR0PFVT92gzNVDdfrBQGipUBDTn50ygWEbp0SQilZ2
         xAPDfjJN3swnjnJeVNAvYOyJgJoYHHl3r0Cacbhvo+BW5SOhFekHuNbHJJGzWw0Mo2FD
         Vo6g==
X-Forwarded-Encrypted: i=1; AKwUvBxz6m9NbPE1GCypkkoJQoY6gANBifsrOe2IMsGVp4bIcXeqAdPmzCktwts+7/MOtz+WxBDA+fU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZrnz3sT592EqituhD/3yQmciVdaXB9GugO7W4FF1SM6ITWFMN
	QiXxEZPwT2gK3GwCzrST1PzZy0dFg4GKL23IFnm+vhMHpDRDqU0spISp
X-Gm-Gg: AYBFou3B0CoxVjdLfS2sIdpIiVjcgA3DoiSfGExS5YSi8DIGAaRrmPVCYSw9tI/GizU
	7smreF5r5vg7H5Xnvy5NXrP2S0colaN5AYYgOKkecUKa5QlHzwHwi9uPsXR4jyWiWCbSHMLz+eL
	711+1DYQCob2Xlan7QpVfoXgEuR98Vz+C1y2em0DEwvIukxA+5QMGpi6ZSVTG0nPqKv0jXDegeQ
	45WzC0l7y7PYMG7GN7V8DtIqvbK7laZPGiEaIkkFpzRYC9Ewogp7kPM5ra5a7Ag1lhFsRD8hqMN
	gPsHdTvO4rWhGkDj3OasIQ4m0hDzZru8BsbTygQlDxuaMwMxXmBvfv5B2/iRMh6anz/+cEl0j5J
	C0p7xL6MdfcI0H/dWAM3/YafOrM7WiFtSuqLNvDC+cEwYW+sM9fAD4DuYUwVF9gzE+2siolFu5R
	RgHIe3UIbo4B6j4v29rQrE84ueOUAgitDmeZS/9BBOSWK/eArITI35NKrTviAjSzIQNgdloOnfZ
	cBSn7d3wCavPgDEnm8CS+H2yc/HJ41tYTnjb7CNtajvtgRctDgQfSks4ukvxEoHBvHBSeZiNpoj
	a3ABQ5L5/KkDPsbZ5M2WxQetfNhsEhNLVMXeKvcXN29+tZVjwiTAc5IKCkSma/tT7yNuXdPwNeC
	r8WcTnby3PNqY3g==
X-Received: by 2002:a17:906:351a:b0:c34:db91:aa1e with SMTP id a640c23a62f3a-c4ca7aa020amr977638966b.4.1793697618437;
        Tue, 03 Nov 2026 01:20:18 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebf37c9bsm67920366b.48.2026.11.03.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:20:18 -0800 (PST)
Message-ID: <86a644201b1938155af01f3e2b7dfb71dcca159d.camel@gmail.com>
Subject: Re: [PATCH v2] HID: pidff: bound the unit exponent rescaling loop
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>, Oleg Makarenko <oleg@makarenk.ooo>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 =?UTF-8?Q?Micha=C5=82_Kope=C4=87?=
	 <michal@nozomi.space>, Paul Dino Jones <paul@spacefreak18.xyz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 03 Nov 2026 10:20:14 +0100
In-Reply-To: <20261102-b4-pidff-rescale-exponent-v2-1-a75bcca65fd0@cherr.cc>
References: <20261102-b4-pidff-rescale-exponent-v2-1-a75bcca65fd0@cherr.cc>
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

On Mon, 2026-11-02 at 23:23 +0800, Shengzhuo Wei wrote:
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
> Reviewed-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>

Afaik, the tags should be in a chronological order (my review on the
bottom) + reviews should be removed if patch contents have been changed.
My review is no longer viable for this v2

> ---
> v1: https://lore.kernel.org/r/20261029-b4-pidff-rescale-exponent-v1-1-3ba=
54accf767@cherr.cc
>=20
> Changes in v2:
> - Following Tomasz's suggestion, warn during initialization when
>   the duration field's unit exponent is outside -8..0.
> - Add Tomasz's Reviewed-by.
> ---
>  drivers/hid/usbhid/hid-pidff.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index 22951b7ecd17..4540f49fe6e3 100644
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
> @@ -1428,11 +1428,19 @@ static int pidff_find_effects(struct pidff_device=
 *pidff,
>   */
>  static int pidff_init_fields(struct pidff_device *pidff, struct input_de=
v *dev)
>  {
> +=09int exp;

This driver no longer enforces C90 standard (in line with kernel) so
please, declare the variable where it's needed.

> +
>  =09if (PIDFF_FIND_FIELDS(set_effect, PID_SET_EFFECT, 1)) {
>  =09=09hid_err(pidff->hid, "unknown set_effect report layout\n");
>  =09=09return -ENODEV;
>  =09}
> =20
> +=09exp =3D pidff->set_effect[PID_DURATION].field->unit_exponent;

So here, int exp =3D ...

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
