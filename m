Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622968;
	b=XSt6qaFSEsF2RErKklAcdjtLASUzqi0ATmrubohQDpptU0LIo02AWrKsg5PsZnqaNjVq
	 xmCSjY7RuhTigZ2wiL93DDyxpjnr/k0ThVi6lY+CE3Jvjp79zsEKxq8dGyi5CYZicVB3i
	 UC6LLjCQSRsRsS9WRCACcnlIsdQnhBNH+LwDB7B88rt61azvJQ8r61QDHHoeBPXyWOehR
	 5+uRp/MygnZcneh7uaqxF1rTrjwFIWvmDbqLneXse+wpsZ1MTXvE5VdMLhFP44F55Wqbh
	 fUNuBR44FcGh685dVUAsI2TuxOP4aXH/JWoX+urhx4PC6RIdgIVNdr8R6s/ZgN+TaHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Disposition-Notification-To:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=M322gxN17KH2FpLbwEqFxfIE1eUVU6+ZQO7JUqapB7A=;
	b=E4wZVJXNrwMom3sQ0M4FsxqdkLgPUBhczIhYfw1iq8L2Wj6jBVDFE4OABlINNkdqlhws
	 EXeeIsDC4keBaj/9ViPheZ0ddByANVJDN5kce7IJD9rxN5xG3HOJCF1hs7WQuq2NeBR5Y
	 E0JikdaUISVdYBKcULcLvBTRoIzN5XkWuzT9FUWm713os2DqVDiwmIKCkRVfhEdaSr5VJ
	 q+oYe/xDhZjYztsEpmc+IAMHsrKSnG6S4x2+/Tf5NUfCPTUhq4XYoiInIPKs6KDuqwZj4
	 4+aCBLI15+jbZXZADa564zoBKA7xqjYFxt7N2aruXYOeFjcENsmZ7ubz28rjRTLriXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c5CiVmW6;
	arc=none smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB7606A32E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9CB7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c5CiVmW6
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be4bed05b5so454561e87.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622966; x=1794227766; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M322gxN17KH2FpLbwEqFxfIE1eUVU6+ZQO7JUqapB7A=;
        b=c5CiVmW6TC6wzhilCy2vRAOjt377rQOFvnTggK30VMkmy3zHL8cjaFj3kEfM20B7V8
         S6MqGtKCdWYPj+71NvS719/pZjRnNbji4M40tk9LAAqL9+2GNQrhs5ef8hvWzRxpKF0R
         Ypu7f+N2BzXigxVRJEM2xymxy4BYBu7CATH1NeSvlsJBu6Gqe2OobIDH/CUAcysBRDS2
         DUGfWArThmDBRC5zzEMfJ+4/MY0b7CT86GFT2eAfVaEL5ZE+oaIb5H1FO3wC/43PUVVC
         6FsrVSrr3GGlULr7XBfLYmaD8AJHuw20cBeP61bZj96ONnDPk0mdhObdLXnCjbxGcGVl
         IgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622966; x=1794227766;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M322gxN17KH2FpLbwEqFxfIE1eUVU6+ZQO7JUqapB7A=;
        b=Yc6FiXF7iXgOw3ONOsTvqzccxHvVkXc7GTwsEUXACQbJHHkHT0rWVr0iT6WMufAyQK
         PCOkF/CEEy9PUy6xWxZmGg+jWyDSzvPcL/HrVtHI/SlOpED+CuVf/z1kdD7Wo8pNQbgs
         OY2kqmkClwejV88IoOeXHISRc60tnqVc/7E/004YYPKDf0k98T6U5C1FwqTVP/WnPR0e
         THudosfgmP5uPVohyV5hn7kOmwc+Z1mXJfP8989CWbLF7fTew/WE/S1wuaoJI697TdkQ
         hDl+ubk64JejhJFY0Rx90658lNY21JQgyDg6NIbvFMnWBZIfMQLOaRwX7vJDIydqXQmT
         yz6g==
X-Forwarded-Encrypted: i=1; AKwUvBwVNJIIsuW3R7Vw+9oIzpDAMwO4S8gX2z/J+lrenhyR3RTcKl4bzwydXRfA5zh2V0j16wUwgu8=@vger.kernel.org
X-Gm-Message-State: APuU4Z94sOfTksWQIEDcJGNdDwVtJSR4pXYzD1RFctdEEMbpoVbGfmxO
	zeer0kDqSnnEebwPmY5Cm84ge+NQCyIjlCasyPDLj30/O7B5H54NVmz5
X-Gm-Gg: AYBFou2SmgvKoPY+X5xzbaIj9vz28CUqSVy3U3QxB1Y3gEKzqznzmtjZoBcECLzpx2Z
	+CN5Ce8jyA+NZXRX9+KKoLXYFhw7UI7JLOzs+4pO3wCga0zAm4I6X+7hO160N8L/9uArWPVFQtC
	hn83lhFT7RVUR6UYyWWiIhdoqifNmPXsoWCPjxoLpeWQ2oCAoQYUHCndYfa6HPObhuU12qou/oe
	LUDMaNKFnFf4DDq+ntq7Lc/W30/5p1rnUD8QQH/6EhAXmf6ShdFHb00igsPLTcKWZoNb1w9KsVP
	QvsXhw+4aJ9PJNpgndVF1dq0H8sRXlK7V0rTPfke2esI49xJt12kjweSJ3dS8rdhVrfAqyziAH2
	Hrb5ZzdFJHcUZlNg35il1+V0OQVzbZhgDl9+i3y90p/rLyhpE2+LPSeB+eB97N4lzLJCMtDYh3n
	EwegGWSr8L0A2sPH9ocEpNHG8hFKvF1zfszpnTL09SAPHEHj0/UKYo8vM6s6LWCGOGoHR6n1Zwc
	Q6MZ/P4ZUyw17OYTuYnbXUTOSFG1XNGCcRFMxI2cskEEi3f3pHCwsxI1ECLH4rwlmHP8p89XhGd
	P0cGmIsSjZVhmKLKFU4/xc1yW0lLa/hoOrQxK3HusFh3P3+m5y1j8Vupmj/uwRKJHS8y3mYVnGG
	V8SGpgbpECoheuA==
X-Received: by 2002:a05:6512:159d:b0:5bf:ba43:fa67 with SMTP id 2adb3069b0e04-5bfd95989a1mr4171090e87.6.1793622965865;
        Mon, 02 Nov 2026 04:36:05 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe07551e2sm1599770e87.84.2026.11.02.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:36:05 -0800 (PST)
Message-ID: <b27645a5948ec37836a9186f0eb4699b6d6fd87a.camel@gmail.com>
Subject: Re: [PATCH] HID: pidff: fix undefined shift for infinite duration
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>, Oleg Makarenko <oleg@makarenk.ooo>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 13:36:02 +0100
In-Reply-To: <20261028-b4-pidff-duration-shift-v1-1-65028c6b4a37@cherr.cc>
References: <20261028-b4-pidff-duration-shift-v1-1-65028c6b4a37@cherr.cc>
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

On Wed, 2026-10-28 at 18:55 +0800, Shengzhuo Wei wrote:
> pidff_set_duration() computes the infinite duration as
> (1U << report_size) - 1, but report_size comes from the device's
> report descriptor and can be 32 or greater. This causes an undefined
> shift. A UHID test on x86-64 triggers UBSAN and programs a 32-bit
> duration field as zero instead of 0xffffffff.
>=20
> For report sizes of 32 or more, store -1 in the s32 field value to
> set all 32 bits without shifting. Keep the existing calculation for
> smaller fields.

Yeah, that's a good idea even though finding a real device that would
trigger this would be quite difficult.

>=20
> Fixes: 1a575044d516 ("HID: pidff: Compute INFINITE value instead of using=
 hardcoded 0xffff")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
> HID: pidff: fix undefined shift for infinite duration
> ---
>  drivers/hid/usbhid/hid-pidff.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index 22951b7ecd17..25b82e7d0b9e 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c
> @@ -394,7 +394,11 @@ static void pidff_set_duration(struct pidff_usage *u=
sage, u16 duration)
>  {
>  =09/* PID defines INFINITE as the max possible value for duration field =
*/
>  =09if (pidff_is_duration_infinite(duration)) {
> -=09=09usage->value[0] =3D (1U << usage->field->report_size) - 1;
> +=09=09if (usage->field->report_size >=3D 32)
> +=09=09=09usage->value[0] =3D -1;
> +=09=09else
> +=09=09=09usage->value[0] =3D
> +=09=09=09=09(1U << usage->field->report_size) - 1;

I prefer default operations instead of if/else. Just a style preference.
Would you mind changing this to unguarded
`usage->value[0] =3D -1;`
and then the previous calculation behind
`if (usage->field->report_size < 32)` ?

>  =09=09return;
>  =09}
> =20
>=20
> ---
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> change-id: 20261028-b4-pidff-duration-shift-8df4f6451448
>=20
> Best regards,
> -- =20
> Shengzhuo Wei <me@cherr.cc>
