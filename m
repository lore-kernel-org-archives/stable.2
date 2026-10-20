Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792489874;
	b=d9o+xcinNEksqsepyl0iD7mzrKp6uOcb6OPl30EAIDmf+W+ypx6Bs/GyVF7eO8T7EEzd
	 vf8OHxVpjv1mt53YaHFGLc2Pa9yo8LHIimIgC9e/8TmExYTAMcA79UVp0BAXINzPuuIx5
	 ++xEyWHIHRyKpwL9OmBFAMT5EU4S7gcbsBKOhmdTz3Bg3eraAqFTFb9JlYBWNDmlk4oPL
	 0XQr2EaWTpq1ZfkIgA6t9ylYUIyjcxKPaTjxQpEHDh6JUWFPQKCzC8aFimBlN/qn0Jnlr
	 WM7DUZcmUgoBH8o/4Dh3pdxp7dIzH274UCsgZjSn9sdmysqgZxduhvM52McymjnwDoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489874;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=sIpSqzi/Abc8gRzDzU5hCgB+RMFMVY65xxDiyw9uw6w=;
	b=xbJ0aWO3j/it9RoOqofEC4Ivjl4FnJL3N/UNsreHhWcGH+Nm6cSW6NBaK7mMyKVF6miT
	 bTcDQgDKiKeEVJkT5R5jKtmST9irgBMr/CbtzEBUU6bGJUbqzNQ9GjRypkIAHynWyxS2b
	 zYBrH6B78E4hzU87Itfv8LnYK/tCAXaVSIbIMcA0b9psFzRfxOZOectGaBUymLcrOw7SP
	 4GH/Q1Vi/tT2WP2aShXLTK80o2Mgh6jmqvvWLxzvy3XeK8X7yUbfDO0pW9BjVBKc3kSle
	 C78QJScqlRboixq5olkhdvVIY6rjQ7/Ew1bhMgt9AHfQ2Uck+uTv+zKoi3A3XUGdVVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=F+inmk8+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5119606A31A;
	Tue, 20 Oct 2026 09:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5119606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=F+inmk8+
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 407DB202136;
	Tue, 20 Oct 2026 11:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792489871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sIpSqzi/Abc8gRzDzU5hCgB+RMFMVY65xxDiyw9uw6w=;
	b=F+inmk8+BWKdlWmII9j1FwQ8ZkirIYpvf7J2BXbNnbHKN2wZ6pt8af6eCr3GWOprGiAQ6t
	x/SnVHooIEkmFEjGYUvzANW2NJbkEeNYSHRaHvIc15+C8ATIc/cK972tSfGPfvHDGuvz0Y
	EYko5EcQx2W6GJEXn3LhMSeRB2Ylkg+kHWE+EdkxG3a4AOlTV+lUYL6oi80yvo2ThII5m8
	wYXNTA5/MVgq+/LPUQ1ejrkEiJmMTvy2SafZu9vQHb4g7p2IK2mWRLUUPk/b6jRpcSJ/+z
	0fFSg9TcuY4npx5eN5Tre5ZHm3TTJynTCifvFk2TADJjpC3u6lDN2bhlJW06VA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792489871; a=rsa-sha256;
	cv=none;
	b=JcAvXIKNB9zbuEkNoZ0Hyk36oTVvObYVO98dC51mPIrtt9LvM7ILQQskrEPa/KQkJdLJVV
	cbwz/Kpza5F6F/CQtahiXuWlbB+24spOIrnKzvZWk7hahOAR0eI86YqiTBbDqlh88Gt15w
	BR0EYfRjska1/ZwsBHWABpceEU4Dg60yxOW1wKCvhsd/WMbjBI3MATG7F0QbAyhiBsGTN9
	2csSk/2qCyEaTT3u88fIOkGH9nazxToJ00/s1+H+voeJbs1wm+03J6qCX77fL22PohSfq5
	zWrm0RVwYm8piVPkk83udAPvb3IR+4xMWI9AmPTzTgkWYCjPSi46hk74SprCFw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792489871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sIpSqzi/Abc8gRzDzU5hCgB+RMFMVY65xxDiyw9uw6w=;
	b=TiJwoGqXO+VJNCXruAdacdRkbBX2i23UqFlIsn1kNULa96SjCWVP0DQvnTS5NsBcYWx2Zt
	wWDj+1Z7GmhGba8u5mTH6b/I0jXpN6xftmuetwRcibFglIwtdDaxvmbh73Vdw7EEoEFk3u
	lxX7LSHtydd6XuO6o7F/Gqt5zsc/0OJHIGXga0EO5hq+ddGEcs6mJZ/3oMbkBTVsdvyinX
	Y+SV9X66ggHGZyaGLgPPq+CdvWzldWgahD0ONTaRI3AqtuevxhSpfLb9YszxKCkcNThjBL
	K8lqqtvf1xjvJDEaI+W4I/mUoO2bI0XDuu0GK/dMJb2G8v3UkEDAZnhPNk6W7w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJ6Ux-000LuK-0X;
	Tue, 20 Oct 2026 11:51:11 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D4A7C5C9E75;
	Tue, 20 Oct 2026 09:51:10 +0000 (UTC)
Date: Tue, 20 Oct 2026 11:51:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>, netdev-bot+sinfo@kernel.org, 
	netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de, 
	haibo.chen@oss.nxp.com, shawnguo@kernel.org, imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v5] can: dev: can_fill_info(): don't wake up controller
 if interface is down
Message-ID: <20261020-precise-panther-of-symmetry-db65f4-mkl@pengutronix.de>
References: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht>
 <20261020075340.417899-1-chunyuzhiqiang@yinhe.ht>
 <CAMZ6RqKpP62XS5tPR714wUmwf6QkdY4V5fb7c4rTFSyoDc+DAA@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="oohqafi5cryltzdr"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKpP62XS5tPR714wUmwf6QkdY4V5fb7c4rTFSyoDc+DAA@mail.gmail.com>


--oohqafi5cryltzdr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] can: dev: can_fill_info(): don't wake up controller
 if interface is down
MIME-Version: 1.0

Hey Vincent,

Looks like you've set up your email/attention filter pretty well :D
Thanks for reviewing this TDC patch.

On 20.10.2026 11:41:49, Vincent Mailhol wrote:
> On Tue. 20 Oct. 2026 at 10:02, ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht> w=
rote:
> > If the interface is down, the CAN controller might be powered down, the
> > clock disabled, and/or its external reset asserted.
> >
> > Don't call do_get_berr_counter() or do_get_auto_tdcv() to read the CAN
> > controller if the interface is down. This fixes a generic logic problem
> > that exists on all platforms.
> >
> > As a result, IFLA_CAN_BERR_COUNTER and IFLA_CAN_TDC are no longer
> > reported for down interfaces. This is intentional: the counters are not
> > meaningful in that state, and calling into the driver can wake a
> > runtime-suspended controller or touch registers whose clocks are gated.
>
> The CAN TDC parameters are still meaningful when the interface is down.

ACK

> What about this:
>
> ---8<---
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 766d455950f55..1bc160b78b0e1 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -910,7 +910,7 @@ static int can_tdc_fill_info(struct sk_buff *skb,
> const struct net_device *dev,
>                 if (tdc_manual) {
>                         tdcv =3D tdc->tdcv;
>                         err =3D 0;
> -               } else if (dbt_params->do_get_auto_tdcv) {
> +               } else if (dbt_params->do_get_auto_tdcv && netif_running(=
dev)) {
>                         err =3D dbt_params->do_get_auto_tdcv(dev, &tdcv);
>                 }
>                 if (!err && nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdcv))
> ---8<---
>
> ?
>
> All the other TDC parameters should still be available when the
> interface is down, so just gating the auto tdcv is enough I think.

Yes, the call to dbt_params->do_get_auto_tdcv() should be gated. Also
check if the size calculation has to be adjusted.

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oohqafi5cryltzdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatc5jAAKCRDMOmT6rpmt
0nqQAQDFE0poV14+sbIMKaNsuuocohzz2kYO1yLbnen0y4r2GgEA/iRq9AE8P+au
ApN2V2Kjw22cFR/qUFocozaZypahHgo=
=ZMqO
-----END PGP SIGNATURE-----

--oohqafi5cryltzdr--
