Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793093022;
	b=OhGvIYM4rXs8Eep3dMWMS4N0drKn6NcUkBepZKzMMqrdLtBgHuW9DZHmNk3PR8gvslkj
	 6APU62AcSj/pWWuJeP0Fc0FWDLvL/oxe9lEVyNKAQbFjaPwD8TIcrT/+TViY/SSLGMRQi
	 lBnkY+zkm4VdEprktr40gM2VvxJGi/ykVLOQVtXLomV2WBNLzwmVkmObv1wbYWi9lPKgP
	 5136eAO3dQCJaiq5dUYYiLWyvcmvms9HUBHIx1v1X889VPsbvDXi7CGft57x9aL+VXgVe
	 N4cNRpFpjZFcIK6a/LIBkYP0230vPkEOJux7jw4/C9Dip5N+/RL1M+3CnOV3xpIJ2cQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093022;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=mesQ+EqHTxYwpWS4gAUO/p+jlZlUmaqFtGfsy8swM0U=;
	b=2mbWUS1LVqfFgWs4N3yE5xpKasqRqWk0MLrVMSDvNlz8RfzNYnRiLgHUEFuW+OhoEQKO
	 lF3XYFRceHtBZgGm16e4TAiucI5yIfedNgarU8DD/mZHObqJcPht/06vDFFUnlIV7VmkQ
	 GJJsG/461nODtTdoxZTCSnyASOKc3lz/CqziMcxrKccro/UdCjHj04u0F69Qk4cQ1jjQl
	 eNzgVSiIu3nxoluqgTvSvQYjHlZF2fmoJXiEk0iR+9ulz848E483lxMW22CUqHs4/thk0
	 oB/+HPKs1jve409nr25ZxK2yx61BcRVqVRHU6aYKhoYNRsJ7GuVs7glR7EJtVuwu0Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=d626wbft;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6F606A31E;
	Tue, 27 Oct 2026 09:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73E6F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=d626wbft
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C612B202859;
	Tue, 27 Oct 2026 10:23:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793093014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mesQ+EqHTxYwpWS4gAUO/p+jlZlUmaqFtGfsy8swM0U=;
	b=d626wbftWZhcD/qFf936zIcfrwA3MOyyAF2UkE3qU5hiHYDAXaY7Whx2lT2hejbFn59cVn
	UZWnvvHCcH2F72sZ4sNovT9IJfX4TYHdZs1upPaSqg0bI16OnnmNiIf1Ds3GO6rvqdaa1c
	cMLOjFsLjB3m/QdBUAKJonFeAHWWTpZEouySic4Dt7Q03rWV5igPgoZ2xgr0c7ERqjc+VT
	CEC57JoIrRMrmmrmVRgUtPKyrWPcHfgohzyVWrT/rslhSHQTp4kmWo3ZkbwsS/IEnfeEwT
	IdoVJPWIOG4s/olNE6iDqp+7rMDF3QUMsLn2TY2Umrs6cMA7Gp8MRHvlWImBAQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793093014; a=rsa-sha256;
	cv=none;
	b=enUmOBGZ6oKloB0pbVD4HPfBY7jW7QGA02xuDxuGV9fMlOsdsZTtihHoYaW7znA/0zXjGR
	GN92J7LAEWVgKopOduaZFX8+mvVvcp/UcZuxr+9sczCr9ZEFq49aWveUW0Ugd09V9F9tnW
	OtjDo23VzT3VdxUU2zjyDwVld06XsbjfRTz77Xs+VvyKjhM1hOiulubsrO0IEyZcmKHpPZ
	PbL0h5cMjqiSfTclMe85bDRpKGCJIqaovNBHM+gRSeKaxG8obN2hmiJliGl9at9oELV3yO
	A6Xt6h8DHMjv+LP4mcyG3FpcJ0QnTMlcS0SqbtMJgDIn0Zl9VuEja63umLIYGg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793093014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mesQ+EqHTxYwpWS4gAUO/p+jlZlUmaqFtGfsy8swM0U=;
	b=WJvWjPK/0vxtOOGaX8R9HqBwe+9MqSGC9ez1xAqWFd2PQX3DQH1z6VT2EhbIa76oYA5tde
	ZUe4ZKh10IybFTwa5BSukXg8HEH/2TDdcQ7P4npjuckfrshLQkuOwac7YUi9YClpiZJttF
	IqKoT9EzXHpeSCqO0KrOkrN8udy57P0mhzLzYuEvjqBfPU+384Nl/xv33I1kHYZ1H4PTxc
	SNy7D4ZxtfssyBcO0dHo6OEHzGQS/vtuGrPkPnPJCShQS5vKnRvD+ZJz8QeVP5MilB0dMG
	UmpaHURbhOSeKj7NMM+GptY1PV4AEy+FjYm/3dDyLx16z+nUooY74cS4Bejudw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLdP4-001PMj-2C;
	Tue, 27 Oct 2026 10:23:34 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5EA765D7ABE;
	Tue, 27 Oct 2026 09:23:34 +0000 (UTC)
Date: Tue, 27 Oct 2026 10:23:34 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: syzbot ci <syzbot+ci0e4b58e5e6ed7fb1@syzkaller.appspotmail.com>
Cc: eric@evenchick.com, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol@kernel.org, max@schneidersoft.net, pfink@christ-es.de, 
	stable@vger.kernel.org, wg@grandegger.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: gs_usb: fixes
Message-ID: <20261027-cherubic-monumental-aardwolf-d2cf5f-mkl@pengutronix.de>
References: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
 <6ae06214.6200f071.51519.0f44.GAE@google.com>
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
	protocol="application/pgp-signature"; boundary="ctj6jyf2ogvq5zp5"
Content-Disposition: inline
In-Reply-To: <6ae06214.6200f071.51519.0f44.GAE@google.com>


--ctj6jyf2ogvq5zp5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot ci] Re: gs_usb: fixes
MIME-Version: 1.0

On 27.10.2026 01:34:28, syzbot ci wrote:
> syzbot ci has tested the following series
>
> [v3] gs_usb: fixes
> https://lore.kernel.org/all/20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengu=
tronix.de
> * [PATCH v3 1/4] can: gs_usb: gs_can_start_xmit(): don't leak uninitializ=
ed memory over USB
> * [PATCH v3 2/4] can: gs_usb: gs_usb_probe(): init netdev completely befo=
re register_candev()
> * [PATCH v3 3/4] can: gs_usb: gs_usb_receive_bulk_callback(): check for o=
verflow flag if SKB allocation fails
> * [PATCH v3 4/4] can: gs_usb: gs_usb_receive_bulk_callback(): add missing=
 call to can_rx_offload_irq_finish
>
> and found the following issue:
> general protection fault in can_rx_offload_del
>
> Full report is available here:
> https://ci.syzbot.org/series/0c1fc4c5-6a50-43da-a45c-fbc3a8685c3d

Good bot! Will be fixed in v4.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ctj6jyf2ogvq5zp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauBtkwAKCRDMOmT6rpmt
0uh2APwLlnsSC4qra+ba87tRha8A5y05ekmf+mItqK6HNwuEAAEAvIM+bsw+Pm4t
wQTD90lK73QFYkES1jxcfiVexmr9TwE=
=4cPB
-----END PGP SIGNATURE-----

--ctj6jyf2ogvq5zp5--
