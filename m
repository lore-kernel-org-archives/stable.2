Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793094619;
	b=DDDqB/dCdQqkUwjWLfGeemDBInU7BexWUHGydlPWwT9UEZmu6G0eWsHceuzCAtvTeg0L
	 Zrq/wwEAkzeRHjOtRDw1MA0vk43E3nTWrjyVph1CIRL2eI+iMTp6iYErwDlNs7Fgxg4Ar
	 TGH6Qdnq0/YsPW6W86yp3Z+SVDGHoAYK1WK7KV9yT2WOihlBOYPxz/sPdZjpcszUoQMdf
	 DCeYNzkGWq6A34f02MFGhaZDWOmp/8EhvT+FwFwS+OgQOxnh0i9/k47900y9Gd33U07qR
	 dB9bxAoUVCBlLOggpBekUfMQ1aPJh3ih47ETtheR/mB2mruofxhJbPaTwZ8ZnLShEJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094619;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=37aoPFZQ7YWN+mj1zo+QiW4j2bMLjcD8/kzkeE7hglU=;
	b=U64nTTlNobCExPRg+vmfUuUz3pqICIJmwYGHmQrvZpYlA6om/cmQCQQECIUwGOJp/9ep
	 JZ+fTWdhZyZ7WvLSCU5y1fcqr6HcMf14fVjp7jq4xh8ZNzDYHYSHHmQfefLdeCMUCDgqQ
	 CzZC8vjgflNS/DSZ7QYegrzpjIOA6e+Cerd8rleS29Yd89cucdPSBurXeMe1OQai95ZIx
	 4asoM5qp5OIKK3ucppaJcHV7GB1lRBXceI9GIEDMi9p8TdQ43YLvburEkmzDI7EsmYBrf
	 r+7ByKlZ0RTrYWIj4b3n7AiB25S7s6CgeM6jVEICeP2Cu3li37WbcjfT8pXsUdk1/+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OEmx0vf1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743CF606A321;
	Tue, 27 Oct 2026 09:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 743CF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=OEmx0vf1
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7277E200F4D;
	Tue, 27 Oct 2026 10:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793094615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37aoPFZQ7YWN+mj1zo+QiW4j2bMLjcD8/kzkeE7hglU=;
	b=OEmx0vf1XKBL+/qnutmOpVlFj+MO4cRBLD/pyrHdrKuMr1YRNELD2/jUXV4yXYNWX9dfY/
	+e5NBPtiUPuaCjPWJ/NWJstEy7LdlTkbBb2mnrTNXS/xLbbZlJGRLM8kyUuMrKAnG6EeAt
	Zz5XApH1YHBKufGnWecFuzhWulDTSGP38NG0n52vI04q3V/ZhOCYLHliKetGJfPrvqS5jl
	1+995cQy8+FgQuUrlyRg3oUeWxX8xceMnt8mVlSqB5ycKpQN8s1NxcHZ/pxo1P62hyEFBw
	YDYoHc3ca6RDNiR1vZWRMm2ESbMS2glBVssizEcEW+Jn3+LJiHgSexEA/ZaThg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793094615; a=rsa-sha256;
	cv=none;
	b=P6yuW2XevoXyx0g2ExTALpykWEBmIRdTbwUP3vM843AvODp/xIIoAfoRib3UzAkrK60NC/
	K35wUhhkrViGvUQjydJXq5WthrTjcC7pZZ1A4sa+nXc2UYytfXjS74KEzDGCULBwCUoDaS
	sDh/tv0bPoqI8tpunRH8L4hNTUEC8YgpfbUMgPJ5BrIxcjWLzuxeBt/QCMKk6yK4uaEE0/
	Lg4TgHmo1Ezt1JgPH/HK6xr5je7aly1GRTJWeOFJWxyUCgqh++L/5O14Ob150ObXBLabxh
	J7fAWB9VjM64ODJjg7zG+tG4Xz36lJKtsHvjlQ1rATcOwctudBUq19nkteKhGw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793094615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37aoPFZQ7YWN+mj1zo+QiW4j2bMLjcD8/kzkeE7hglU=;
	b=FwMPj0OnX0h6F6Nmwr9g1fGBFJ0WnHvQDh/Zx5FEzCQicBq7OqSXPrO4AKyDL4q/fATb+e
	8xWpQhrUMh5mxJDszaRv4LgIn74EoB7silK4dTJ39rGJwHf2JAP5L1AAAjTDVxzuqkIALQ
	3nGzdg1KD4QRvQ0Yo2Y1kID7NV1lhE6HSmzh26kqMqzAKDajemQJoGy8uGTRVAvr4Aj+/W
	HZjndhJabUcYKdEzCSRb/dnOO+p27LACpIKak7aEzkH1WsCliHIq97mV0MjYeeLW6dNfIJ
	6MwPsdmbM4CfcfRaITYA/VzqhCq+wH9que5iVMTG8BrdbjwDPyGcQh0KOgIbbA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLdot-001PSH-1B;
	Tue, 27 Oct 2026 10:50:15 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0CFA75D7B2A;
	Tue, 27 Oct 2026 09:50:14 +0000 (UTC)
Date: Tue, 27 Oct 2026 10:50:14 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com, 
	max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kuba@kernel.org
Subject: Re: [PATCH v2 2/4] can: gs_usb: gs_usb_probe(): init netdev
 completely before register_candev()
Message-ID: <20261027-eminent-ammonite-of-sympathy-df880b-mkl@pengutronix.de>
References: <20261025-gs_usb-fixes-v2-2-535d45097f72@pengutronix.de>
 <179309405203.3130.15846151010657082871@kernel.org>
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
	protocol="application/pgp-signature"; boundary="vxv43k7utftamfwk"
Content-Disposition: inline
In-Reply-To: <179309405203.3130.15846151010657082871@kernel.org>


--vxv43k7utftamfwk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/4] can: gs_usb: gs_usb_probe(): init netdev
 completely before register_candev()
MIME-Version: 1.0

On 27.10.2026 09:40:52, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Critical]
> Both cleanup loops use dev, and dev still points at parent->canch[cur],
> the channel whose register_candev() just failed. Should these use
> parent->canch[i], like the gs_make_candev() failure loop earlier in
> gs_usb_probe()?
>
> As written, the first loop calls gs_destroy_candev() cur times on
> canch[cur], which was never registered. unregister_candev() on a
> NETREG_UNINITIALIZED netdev hits the WARN_ON(1) in
> unregister_netdevice_many_notify(). free_netdev() then frees it
> immediately:
>
> net/core/dev.c:free_netdev() {
>     ...
> 	if (dev->reg_state =3D=3D NETREG_UNINITIALIZED ||
> 	    dev->reg_state =3D=3D NETREG_DUMMY) {
> 		kvfree(dev);
>     ...
> }
>
> So when cur >=3D 2, does each later pass touch freed memory and then free
> it again?

Valid issue, will fix.

pw-bot: cr

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vxv43k7utftamfwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauBz1AAKCRDMOmT6rpmt
0la8AP9zT+roGrAE7yCft9v+xk3ZLW9pqobOIbiVel9rIixaNgEAoRWRkIGAbFcB
QQa/vTV9A4cSPg1aVS9ZjlkKsNMj3gg=
=/LHu
-----END PGP SIGNATURE-----

--vxv43k7utftamfwk--
