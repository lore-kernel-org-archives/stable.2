Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793085349;
	b=qwT80hIadZOMSolJPE+MTXbE1jhlqifLZazJB7IDcH6a+Yy6ZPmgV7FwGM2d9eS7CV6h
	 /hdV45mZj4dTTIn5MBlbaENdpA+KrWPTuBvBAJDUp4JsuelqsiMCewJwGJQ9ZRhcUESfd
	 cfIdmETF/zobbHX12pUaM0fpD+rDY5qz7hrAsIU5uQPKKsduMjIkqcK3cyuaNFb1MTHc0
	 1y8n4DPRKOW+gMmzDpSEeHlpdNyU3/NjufD4ajK5J4Nsk046Y3lR/4bjfa9Zvl/qyNR3f
	 EgsAfFDC7+sqjfSZTXa8JwxPq1w24/SMn1SxkZkCpAYxcBsjywTOTEQNgnOyUT9ilZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085349;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=R+oWYu6/QfEBhFYUPjNxhFKQR9WYE+mlse/QW0U2HJ8=;
	b=G5ddEKp7m/GwRS9WEbdWavWntuveAi7lqJfj72zD/FMlg14q9pasWkSCERPRU7pa3rXF
	 RbJHFvWhcGT6xbtH0zW1GW0d+NrXTX3V5eCghTfJTNyEKDPgMoqIf7iQvD5kyJQhq0sWy
	 4hwX/7nV9qiktydr0/zcMAXHTLvI3Oxh71WmLOe1zGemkh6Xe79gYRuFnSo68r83p4a8G
	 me+R+0SL6+OipjGY7cie4GP1UtzPzGzrnQO2XLaUGGl/UnVAC7gJa1bDtSYW/JJ89LuS6
	 ohreMlT3QrP8io63vtGvjd4owPU9c/ebGH7JJdYOg9+fb6OBPYhHYVQ6SN9vLHtEk1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BbK3uUll;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3045D606A31A;
	Tue, 27 Oct 2026 07:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3045D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BbK3uUll
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E934B20155D;
	Tue, 27 Oct 2026 08:15:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793085344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+oWYu6/QfEBhFYUPjNxhFKQR9WYE+mlse/QW0U2HJ8=;
	b=BbK3uUllsCAxO+pmnHKOyBY2CIdCbsiL4S7SaR4Y0s+M8lB3VUluZ7SH/NaBQc6bMBssrZ
	GjiMcymmleV0kowClq+iZiUyyB7E/vWO8A1OR63zPgv0VmV1G3PIz55bcor2j0xRTyFIVe
	ztGcjxEO4DR22s8Yux1xs7ZUtSSbiNfeTNZfdZNY33OVa/kc7jITzojwzvBGliy22+D1Ml
	pCWSJsQGc0cvau672Go6b0xCb9cSdTemturVhsZKc4m0TKNnEG18d8pTtYpBS8jNT3KEHO
	v7XITcY9VhnY2N+YNuMAgaqg7ApX34SbOE5spHtLdMCAmIdvcRj9g6J9QH7HcQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793085344; a=rsa-sha256;
	cv=none;
	b=a6MnpAQpRxddvep7N8jqcgc21uO+NmcGQM6SXfM4MWsWmElThzbXYTC8G3NzuWh6SFDbKB
	NMs6A354j6vVsaKkll4UyEK9b/GAh4cH+2f3Si9g12pImxCPWsoJ6TPpAYjXPwNUZdO2Dp
	2gQ4NfdUnUJnFhTDnpshTBlKXN5JkFy0x6l+lQ4w3AiJ+qMxaMZ9XC+EPDlnF5nHRTBZ7h
	ytvAbWCZce3qW5Jn7uFyVOlrSB+z5WTlRXNqkzyGRQsRcVMvNSVC3Nq6kdxgixPmOLiHN1
	v97etZ4uf2oYYeLdO7ZZtjLlmMcYKtRhrF3uCiGGOyLkG5TyyQNhgANG6x2U4Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793085344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+oWYu6/QfEBhFYUPjNxhFKQR9WYE+mlse/QW0U2HJ8=;
	b=g9P7NoRI5NLPlzTCz1h8c6WsjZFdj60m24gQWQghj+zAGHvNQVnsMFqSQclWPPcoX59XMp
	P9KcCLk16P6/rvHN7Y82pHvPPSKNDKJJCmu5POIbk/zGvmjmi6cVqGciZdweVKvGeIwPC7
	VSJhxidHqJk0GAJrTpeQ1RtZIrPAbvViTJH6mMqT6hr2FHZPk/zmwVFn6pn7saMfsth7ja
	OPAQY5McDqGfpICZS2HVuJAQSNp9MG2gL1fd7dv8gDYO22JJwlqkE2yl5oN37rcRo7ADPD
	4zVTbRddUFPlkeRrD9Zv+8dvUE57e2h+UY/W+IwDiENz7Gnub6QamI/2LgVfLg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLbPM-001Ocq-2g;
	Tue, 27 Oct 2026 08:15:44 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8791A5D78DA;
	Tue, 27 Oct 2026 07:15:44 +0000 (UTC)
Date: Tue, 27 Oct 2026 08:15:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Song Li <songl@zju.edu.cn>
Subject: Re: [PATCH] can: gs_usb: kill RX URBs before destroying the netdevs
Message-ID: <20261027-artichoke-stork-of-cleaning-01979c-mkl@pengutronix.de>
References: <20260923070352.487595-1-fanwu01@zju.edu.cn>
 <20261026-armadillo-of-uplifting-excitement-9bcdba-mkl@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="ekwsdgna56i73eu4"
Content-Disposition: inline
In-Reply-To: <20261026-armadillo-of-uplifting-excitement-9bcdba-mkl@pengutronix.de>


--ekwsdgna56i73eu4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: gs_usb: kill RX URBs before destroying the netdevs
MIME-Version: 1.0

On 26.10.2026 22:09:08, Marc Kleine-Budde wrote:
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > index ec9a7cb..663746d 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -1595,10 +1595,10 @@ static int gs_usb_probe(struct usb_interface *i=
ntf,
> >
> >  			/* on failure destroy previously created candevs */
> >  			icount =3D i;
> > +			usb_kill_anchored_urbs(&parent->rx_submitted);
>
> I've fixed the root cause of this problem. Do not register an interface,
> before all interfaces are setup:
>
> https://lore.kernel.org/all/20261026-gs_usb-fixes-v4-2-59e3b6360053@pengu=
tronix.de/
>
> >  			for (i =3D 0; i < icount; i++)
> >  				gs_destroy_candev(parent->canch[i]);
> >
> > -			usb_kill_anchored_urbs(&parent->rx_submitted);
> >  			kfree(parent);
> >  			return rc;
> >  		}
> > @@ -1636,6 +1636,8 @@ static void gs_usb_disconnect(struct usb_interfac=
e *intf)
> >  		return;
> >  	}
> >
> > +	usb_kill_anchored_urbs(&parent->rx_submitted);
> > +
>
> The USB core disables all endpoints before calling gs_usb_disconnect(),
> so this isn't needed.

This is not 100% correct. There is a small race window, that the
URB's callbacks have not completed. I'll fix this by first un-registering
the netdev and then freeing the ressources.

>
> >  	for (i =3D 0; i < parent->channel_cnt; i++)
> >  		if (parent->canch[i])
> >  			gs_destroy_candev(parent->canch[i]);

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ekwsdgna56i73eu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauBPnAAKCRDMOmT6rpmt
0mWfAPsFl1MLE7QpUizLHq2sq/5RnZkerQrNKXXjmgZuNMvCggEAi+gLEGr1gfS1
1YPQfzYKsEGvejWC//ZP3U2LjMPRzQQ=
=sMYZ
-----END PGP SIGNATURE-----

--ekwsdgna56i73eu4--
