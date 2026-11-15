Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794731548;
	b=BK8wPiuorLIXPU/yxInPm1fSvgUCZ/C+viDaGteCk7Za3EdixDUowKMP5Y/aQO0ltxSK
	 GQkvTZD7dAYIZ9TnCUYIELTp1DgFOxJzZGHui/JgS1i3ykScwTTKVihtuDqtfQkXC8XxQ
	 w9q3mUVtOQbIamvTXxm9TjP3RLvrm46R/Pt1l+h/QjTu8xdAOlp661XcdopmXYKrUT1xl
	 7mf9sELsr7DSxwXYasM09Wr+GFZrPnY0iP+KvTvxYG5z1mQr9BHvofEkn6ouJYs6Dn+tT
	 yBNGjausGzDlaIp2oIVGdQgBKwdPKM5sEtdif4Lk49FJW2Nu3rAtEAzieQred/53AkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731548;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eEmTq2aD52LZwBg8OYrz5cuWmNtD67t5UWpL7YHFS6g=;
	b=4c8RKWFLIWwkxJ9xdWkQ9gUXQ38Qk2vLP51e2nwQVKeBc7oUr2RT9d1Rg/B9y3CbnWh6
	 9Rq+cr6INOqCg8qpaPgzD5GDGml4Abs7EbIYKFsbKCsyzD7CL0MTDYsWMCJ8jFVaC1gej
	 1hx4Bt4S2C7bXMA3eG1d+wTRBHlDkKSGCCgozBRCwtRE5fJ+z2SqbJ69gV2mVY/J/Wthf
	 4Doz0j5XO3oXsKSu+LcyMYaPFVfU1mU9kOAxU8DcHsDcfGWjlaaNK9Pv7EP+EkP+PtsKr
	 KS37LACHcFgElSoHrtNnB2m7YzRDkidOV21x5owBS4DNnH1ZUq8GIPNhNtTBKFtSggg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ErYHWPAM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68406606A31A;
	Sun, 15 Nov 2026 08:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68406606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ErYHWPAM
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 61837202043;
	Sun, 15 Nov 2026 09:32:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794731545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eEmTq2aD52LZwBg8OYrz5cuWmNtD67t5UWpL7YHFS6g=;
	b=ErYHWPAM2O28uQeOsboT09z3tSG9ykZEyafROwpzYqAZf6JCv5jV5EYSxwN7OHFRqZvaOE
	aKuPCS9SnlTDi40PIg8URCw1qgb0ZOvw2ik7XvlUS8vrCELDgXfWxZKTyLnDHSVn+prV03
	kK/dGh9qnOuCe0xkO/4WeeST3KwGxd+BYzyU/bhM7NV6up56UjiqVuI82HDHPYjxsfTAiF
	RHcz5+C2qHBrkBavY6ngngX0uQdBvF/kc6duKAdVJ2oF5InBUWNtPIJKPgk5V+wMdt3ptF
	cwQDDBzXzc/XOuC5GsSvoZtKDcjgS2e7YxgY40/MNPMuyVdKydVijtLzpHTyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794731545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eEmTq2aD52LZwBg8OYrz5cuWmNtD67t5UWpL7YHFS6g=;
	b=TtRtGrhM+dQoJIUpapXJ4hfcBBc7fwh+59v52C82XsLkVUsrg9xJE2KLSsu6PGyYOKSNYd
	CYAUI1BK1wiWQqwGzWO3G6uu01JesPdXMYRZi1FqfDnOkCCROyMieApsuS5WPcPbdmN2mY
	LxfCCV6ljCydXVTasazbqMWIJObvSwIB3p0F+aD+hrwlPEZAp/ICl9kpnER4J4s39dPj8A
	fYarTJlnj5Tzq0XX3YtPgRA2o7sgsomaHXZX0nFL+7iSJdmYEicd267565bezbD+GjiMA1
	hvp1+nxxntO3GQCR9U4VjjptAu1IhWr0ZlxbJXiNfXWXjr0bpWzIkdXjXhGM9Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794731545; a=rsa-sha256;
	cv=none;
	b=cu8muPU9IaBMS8n5CuQQl4iYPtp2GHL2L/9ICyOQo2k1HZvyJdQvp9Q4eFtvTLTP6FclSA
	X6GrGv9NobwmG5M0G5GM+5JeveKsIisqWjAK2BiyELUl5KY4zVt+oI25YsiIZtvW4uu/Rr
	Pe1r7F9FECvO/6HuoZOHNfEdM3sLpK7Y5v9PYalXO/b4RGXaio+RBbcWtM2ngZuF10IAT6
	6yZDyTmn6VOzgJG3580NMIWZ8WBez2scpWzV28MRPNH/ADyFpDFAAJEGGINxYBmbooESEe
	ifa0XBAnKZDnaT+kmAE8nGRgnZ/TxvoKWWK3F9aZYOWNkNW/oR0BIlmmhnXM0A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSVez-004G5Z-0s;
	Sun, 15 Nov 2026 09:32:25 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F3F7B5EC1DA;
	Sun, 15 Nov 2026 08:32:24 +0000 (UTC)
Date: Sun, 15 Nov 2026 09:32:23 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com, 
	max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kuba@kernel.org
Subject: Re: [PATCH can-next v6 2/6] can: gs_usb: gs_can_start_xmit(): don't
 leak uninitialized memory over USB
Message-ID: <20261115-strict-wine-hoatzin-90dbc0-mkl@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-2-0c039e1bfd74@pengutronix.de>
 <179469989360.488853.2267495586582678566@kernel.org>
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
	protocol="application/pgp-signature"; boundary="qwnibajoklxs4rs7"
Content-Disposition: inline
In-Reply-To: <179469989360.488853.2267495586582678566@kernel.org>


--qwnibajoklxs4rs7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v6 2/6] can: gs_usb: gs_can_start_xmit(): don't
 leak uninitialized memory over USB
MIME-Version: 1.0

On 14.11.2026 23:44:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] can: gs_usb: inaccurate Fixes: trailer in commit message
>
> --
>
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -861,7 +861,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff=
 *skb,
> >  	if (!urb)
> >  		goto nomem_urb;
> >
> > -	hf =3D kmalloc(dev->hf_size_tx, GFP_ATOMIC);
> > +	hf =3D kzalloc(dev->hf_size_tx, GFP_ATOMIC);
> >  	if (!hf)
> >  		goto nomem_hf;
> >
> >
>
> [Severity: Low]
> The Fixes: tag points at 26949ac935e3 ("can: gs_usb: add CAN-FD
> support"). As far as I can tell, the leak in gs_can_start_xmit() is
> older than the CAN-FD support.

will fix

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qwnibajoklxs4rs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavluFQAKCRDMOmT6rpmt
0tO6AQCP1l91ftvr470OfnqXYtarw/3FklF+i9mJOy83itq1kQD/WGKcjxyywdLo
7L9TOcMSo+f5V81CE+wU95maFzahawA=
=0+XK
-----END PGP SIGNATURE-----

--qwnibajoklxs4rs7--
