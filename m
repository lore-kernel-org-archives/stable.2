Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820462;
	b=mOMnye79ZWnHsoU/q9RMpLbCI8AesrbU3FqtTfbY57b5P+OryKLxEMWqVkAHpLPB0n2q
	 VEg16VMNLTQOOOu/crhttmybzed99YYTj4SIeG5N9kiYTqiXE+Koov9/iNAHJlnBA0mqR
	 eqHCwdj/V2OagT5RlQ21aDAlBrEszykXZ6rBO+YS2UaiNGgGoJnhtbWMLzJbWcKi1P9z2
	 HRCG0Bgi1oympNjHAFnTR9swE69EksU40dxaCBq+maI2WbxyewQZvyaaqb1d5l55TxQDT
	 pQqyKMU5UOyRjB3UnW4JGtP2MsKidKlPa+wze2dcckTB9Fn1HdqPTWD3lvIU3gSVYeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=duB+53Rzo/I6JCkMTJRwR1f6X11DgAhC6/nYlh9cR8c=;
	b=m0SpFHPNAFmozWUmwmR/5MHO2nGqQRtpf3t7ZEiZOfe8LLiARvJWIdbnSPzbAQ3XKQOM
	 lgohV/6M8F8QeD2blpW6mojxRrWzPkNPqIXJZWYEuLM3g4mpfzGpsJWmPOmECZHRYIp8K
	 G16fQRJ3XCTLpzqX5fr236dSSQ7uUFsAWFZcbnLWJbgjBA5SIa0JhWdZ6eBcIKF1Wp65C
	 ToPuqk2sZxaqKbJp6OFax73kQU6sx1OoHDADkKHrXV8rTpY+XQdK+PPmDXtASsvZsaDAk
	 UNwRDZaRjK7dk5xh2rm21t4Yxtw4n20GdPCg1Pkish/AO5k3J3oPbgqvEhWALUrHzwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=b0a3iGWr;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522B606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C522B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=b0a3iGWr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4b467581b98so25750035e9.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 01:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794820460; x=1795425260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=duB+53Rzo/I6JCkMTJRwR1f6X11DgAhC6/nYlh9cR8c=;
        b=b0a3iGWrhf0lSrT8W5PZ3apkvAjkLzovGdk1hHP6fmuZKr0QgHoQskCMS/2eXD8s1H
         KMlOrWoYP2COhV2udxBxwK3o35CxHUhhuUrA/gsxWN/ozahfqeYoF760rLEDhKWIf9J1
         qdrT6VnVDZxSlFoyG21Gp1FxTNXij99MBVUfo9iJxRy/yMfTJZPqEIGSE4gOOqSCv8iX
         ADnrBEXLVfxAyBDtPbyu8KzXQABpCjhC8TzviIGKLh6Ana7YjdzUvNiyAee/3o8oN6L3
         zijZgQpZW15/LdRnrqhdxzbIDH4YtVKirByXJQPFA2vMzaeNSUzuHGaW5+jHojV5ACNm
         NOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794820460; x=1795425260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duB+53Rzo/I6JCkMTJRwR1f6X11DgAhC6/nYlh9cR8c=;
        b=Pca7WdR353NPX0NT0w3Sz1z5ZghAbpVHpfZaL9d+3+SEyiUhQ7B1in/D/gP1RELdsd
         MYMuGDJI+VLGeVz+/h2pYRMLbAVQ6AkpIVJMl2cRJenbSe9YRqyTUd3NBYvudCZdgQ67
         Fr32NQM1OgpsbMTonDv5h2Kat+KBSi8trBGTpLQAuIGVo6NJcV1k5H4t0GfU7EGmscs3
         LLPDRE+0e3fcyBNYtWKIGzipsC3UZFWjAdC34xriZ1FjdBaRr99CTIOctPf+UWLvpiGu
         6yrWl3AmvOujshoEvz+lr0w7LSfGL1a2FFLWJASJHLMKG4qx4dWDlRPPzmN6DKsr6vYD
         P8HQ==
X-Forwarded-Encrypted: i=1; AL+hErHchbqkzxpW5tDqxid/C1Kka2n2rQTR50te6vtNrvNMoHpwsAIgWSlBACPK7whwQ0iaOhDqsv8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TilHASlUkM6jaaUiTx8Gmxp7XXnVKcIh74dIeys5xfp5IYJJ2
	t9ifiCoEhPGBKaSWhaFL5PwRgPiNBiqqQoFJEB3KvDg1KTXRI6xjrtAV35ffazEXTYM=
X-Gm-Gg: AYBFou0R7dIEW4LB2d+sgQbK0yj0CwpymMgWkQu0vtvZ5+gWw4jmdzQqIUsedmWfH3k
	Ksfnoi6akRqW07djaNajtv60YDaOHOhwiCWfSGhy5xvr6pqDUvB/L5Zmcl8zWt7uPvtcAFnTCTm
	YHgOBU2jy6dN/fg2ZCFaLjGhicsYcQa2I4uZ7nPOYhf0h7kxe8UChXC4sf54CUe/JgKD/YyDzLe
	y8JCKlJGoHuxKOEp61YSqzu7LdUiNZzRiiG7F6HZxOu8ZuVmHFap8Fjf/UeqJCGBxFvSwUNsjd+
	iZgW7ODdLdKTo3Ui9CFwUlgEObc3Wumx/YtKpd5/ZcVSKeOjszw0jugyme04dA4zyHQE7oKxbZX
	U0KIai7b8NEngy3/MZXJDZnMpgwWBg8GPgqCTOOxzykSSBU8e1TUqBncbwF3CjO7vMvuH2P1y4c
	n2+zi2aJsPdVIodVPwma9o2FRrjaROdPih6cfvc0RbR9kl1pYii/H4IoORCfHR88P/RxPdvdVEb
	hYrYaNteM5QcFbjIze2lHVw5WLwm1A06fnMwdZ1Seb+6+S9A/7zI3PVUUTyBTS+UWgkRe7CNiE3
	KmRMXNvFqp9mqSYr49xmhdvSsi2RZHortdIkvDaNuFP1Xn7XPghXnvdkLxORbWDFqNr1WlY7CYd
	jO/AbIuV+DzTf8nNKHA==
X-Received: by 2002:a05:600c:1d10:b0:4b2:3c81:d1 with SMTP id 5b1f17b1804b1-4bb55a65ea5mr192703955e9.5.1794820459865;
        Mon, 16 Nov 2026 01:14:19 -0800 (PST)
Received: from localhost (p200300f65f19a9042c263c0c153a4e28.dip0.t-ipconnect.de. [2003:f6:5f19:a904:2c26:3c0c:153a:4e28])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb5faf05f8sm159998655e9.10.2026.11.16.01.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:14:19 -0800 (PST)
Date: Mon, 16 Nov 2026 10:14:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH can 2/4] can: flexcan: flexcan_probe(): fix probing for
 m68k/coldfire and reject devices without match data
Message-ID: <avrHkaYw-De6nv8B@monoceros>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-2-2d82025e9646@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3kbn6dvhzgm4gtvf"
Content-Disposition: inline
In-Reply-To: <20261114-fix-device_get_match_data-v1-2-2d82025e9646@pengutronix.de>


--3kbn6dvhzgm4gtvf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 2/4] can: flexcan: flexcan_probe(): fix probing for
 m68k/coldfire and reject devices without match data
MIME-Version: 1.0

Hello Marc,

On Sat, Nov 14, 2026 at 01:56:15PM +0100, Marc Kleine-Budde wrote:
> When determining the device details was reworked in commit 5e6c3454b405
> ("net: can: Use device_get_match_data()") there was no replacement for the
> previous handling of non-of instantiated devices via the device's id_entry
> which then results in a NULL pointer exception. The only in-tree provider
> of such a device is arch/m68k/coldfire/device.c.
>=20
> Restore retrieving the devtype_data via platform_get_device_id().
>=20
> Also a device bound through driver_override need not match an entry in
> of_match_table or id_table. In that case device_get_match_data() returns
> NULL, but flexcan_probe() dereferences the result.
>=20
> Reject devices without match data before continuing probe.
>=20
> Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> Cc: stable@vger.kernel.org
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Closes: https://lore.kernel.org/all/20260618140147.142489-2-u.kleine-koen=
ig@baylibre.com/
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Closes: https://lore.kernel.org/all/20260528-fluorescent-sage-ladybug-432=
61b-mkl@pengutronix.de/
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index 86b40abe9e76..2bb9e4184eb5 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -2148,6 +2148,11 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  		return PTR_ERR(regs);
> =20
>  	devtype_data =3D device_get_match_data(&pdev->dev);
> +	if (!devtype_data && platform_get_device_id(pdev))
> +		devtype_data =3D (struct flexcan_devtype_data *)
> +			platform_get_device_id(pdev)->driver_data;
> +	if (!devtype_data)
> +		return -ENODEV;

My stance is that the ability to bind an "unexpected" device via
driver_override is something that should be handled in the core, see
https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.179061=
2298.git.u.kleine-koenig@baylibre.com/
for the latest patch to address this. I'll work on this patch to
hopefully get it into v7.5-rc1. IMHO it's ok to not fix this in a driver
specific way now. (And then my patch referenced above in the first
Closes:-trailer is IMHO better than this patch.)

Best regards
Uwe

--3kbn6dvhzgm4gtvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr6yV8ACgkQj4D7WH0S
/k4KnAf+I1gQa7nnydreBqpl18qr3bjlMpNbM/wcIEtGP3xMBPkpDX2yJFljOI8k
9TayfHIOvCINmFKVvL4sioue78+dQP56QUAmZGMHZNnQd4W/38CNi+PxKIqgsV74
yoJHlZhYsHSMLMsf8oAIKAGhkVtpziLJ88i2Yc2ghjZ7erYkKrSuBc+jFTFzI4tM
OknkKdfObSLN1TAr5lJYpnpvCn6HNJOkz//vLAgu6wAYdV9WtAd0wrkm/4tFcfir
MpB/Cw/PNtHNAZWiKPL50rum+ferNUNUzHrRAEx38UA5Sj1Nz4MQonl0UUVFoPIr
tgcOC5iCUQKdoIJu+AnDEx5AuRV1Dw==
=98Fb
-----END PGP SIGNATURE-----

--3kbn6dvhzgm4gtvf--
