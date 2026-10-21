Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792623959;
	b=cvJ8tStogH0HPR2qdeXlhrumRakx26CsIlBb0YRWxnwn37QzaOBYw3bO+VqZIeCWSLO9
	 /8EYXD09GN3GfmPXvuxH36Fb9sAqKJQsqSz0zzyS97Bz/RINSSIA1/u0JjPTA1+UbeOft
	 7NKGzI3WAUyi/on9fdQvC6/HmbAYGUmNYbw7ZEnW79T4ltk7q7Ae1l3p7ybhDGFCECi6/
	 KZPSaES0+Vg4n/be0kyAksLPctTev2+6JCQ2X8ubZvzL1fyn616N8VehqA2tiXilLgTyX
	 359u3s2GgLFhI81Qy7JGEQBzcJVKLF5aATufNdScCpyUy9GjyFpMpDtXixnTZ/0YBmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623959;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lmkRc1ilpjlEI5rgwtyJAYCWV++I6JYnoLUfj5+V158=;
	b=Z2jZxDmf2v0g8wAv9B6tinriAdz1mY/e5QaRlN0rDENZblEcyu2qdslHbPENXqaJeKzG
	 vAy9sNYr39a6UcqDKswK01pO6PSrsdvCg6ipRYHftjD78H6ArNqZwOVgAjjLWzyI657P2
	 /GWz5vcrc3UO2gyZ7rMGQU8pSFxItyrPwu4TXV0XWrKLPcw+Wowlv0mSwhFBG0Cxy+8qS
	 fV568r6tXZ+UVZrml7D6kH6SwqExna8OGtoPAlShHEcvyjwsf2Yf3JXe2QZHX59zf7zlQ
	 i17amtMI9hp27VMFtS8136SdF48FNpJusuWLyjJKEUHJd+94gg18DKbE+O/cOE0ZRWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HonWFAeH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D4606A31A;
	Wed, 21 Oct 2026 23:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 434D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HonWFAeH
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CE6D3200073;
	Thu, 22 Oct 2026 01:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792623950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lmkRc1ilpjlEI5rgwtyJAYCWV++I6JYnoLUfj5+V158=;
	b=HonWFAeHHE/efe9MC5hvvGvtRAPIsswP+o648pCp2tssrtcfhUCSw4ex1znIXsFeYyGIAP
	S9e7bpTrTZ+NEJegEqrDncCuvbQYp6F0KApuP4069EU4YLNItRPQqj9fCmyLwDkmCIf2GY
	0xgzgza6rDqB+b5knH6zbj/zDDpS8Qy4NWZY9CylympelNH+1Rsygp3Sl9Fy//PRadMUiB
	fwn5cb/dmv4ajpYIWRXJACF9uR1VDvEwcRH8CBAFUib7adSQo8+TWafPI48ilarEz/rCFc
	Cm2sUWU37f0jMySP+wacf6YfgenB03svbhaBBYrsM/ML/G6AmJkzRiuZYPeldg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792623950; a=rsa-sha256;
	cv=none;
	b=dTzJmrFh+TqPkvY3VqKaFvMWbn2kzGZmmMbKvJXRBEPSj0mMdYT/YhgBHFCSacZ81IsDXG
	b3JxMKCX5LvgwAQgk6bm59oLJmJi+0wOyHY0lLI8aBBJzw85ZKORJiISSVsuNJ9zsmfztK
	3L7XeyJ1N4Kh77hIMt+3iFMvsw8yfn9XaKVKunqjT2v4Ypk7jKeY7bcO41ci3oPMJyoxlK
	F3mQN18TesoCRFKl9L3HIxD1G1LrQp9iXs37sKxDTOvP74J3Xa1x3o7MGjxx8d8JAVONp2
	acc0I3SpVyB3bscXSf3i6/6GUN20AJpBz1sipF5vSYE1Bjrn37XxywCdPizdXg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792623950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lmkRc1ilpjlEI5rgwtyJAYCWV++I6JYnoLUfj5+V158=;
	b=XLZyogz1AEO9BpG4LsZ9zQvjJnLwFdJe06Qq5UNqDQmX2wafA5lCfKLKEnO30rXZfigdVc
	jxCAaZgaPtfKAMAOC4wMmw6OSuZ2GzBAfkxmcLtGGnIAld8uxn24H3YuWy1cJvQlBwu1Wl
	GEFb5dfU9Le/g+qwVxoz0c79CERFLImfnZAs81Odg6CCKkkMMa1D0YSt4FTdnahvDHh+YZ
	7yhmy2fJ03T9Faag7StMhp60FmR2Ozqqf6MZZX3mvzrUynIHTTHG38PopIHvo9ItpSMHFj
	1UasXYKFiK/GcNztjrIx7kvOQ7+frpcBS6zK5BWFX2cO75x9fO0P6ENGhFbgHw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJfNW-000cVy-2R;
	Thu, 22 Oct 2026 01:05:50 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1DDEF5D06CC;
	Wed, 21 Oct 2026 23:05:50 +0000 (UTC)
Date: Thu, 22 Oct 2026 01:05:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, 
	runyu.xiao@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH net-next 11/11] can: protect the receive lists with a
 per-device lock
Message-ID: <20261021-refined-free-wapiti-c46445-mkl@pengutronix.de>
References: <20261021102756.1900679-12-mkl@pengutronix.de>
 <20261021205534.1620083-1-kuba@kernel.org>
 <47b77a2a-ff3d-4189-b633-54b1fad3cd1a@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="jpthgamqtyd76tr5"
Content-Disposition: inline
In-Reply-To: <47b77a2a-ff3d-4189-b633-54b1fad3cd1a@hartkopp.net>


--jpthgamqtyd76tr5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 11/11] can: protect the receive lists with a
 per-device lock
MIME-Version: 1.0

On 21.10.2026 23:59:17, Oliver Hartkopp wrote:
[...]>
> is a good hint from sashiko-bot and follows the raw_bind() concept.
> @Jakub: I've sent a V6 only for this single patch 11/11 here:
>
> Is this ok for you? I think Marc is offline and can not re-spin the PR ri=
ght
> now.
>
> https://lore.kernel.org/netdev/20261021215456.119268-1-socketcan@hartkopp=
=2Enet/

Give me a sec, I'm preparing the new PR.

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jpthgamqtyd76tr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatlFSgAKCRDMOmT6rpmt
0oZoAP0SaZZLhRGzm3JXaVMJvKa4I3XMaSzZN3Uu5iQEoPU0mAEAzDwynpg/EdoO
+6QEAk7Tn1AZwuQFVtOL4yBhXK9muQg=
=szLL
-----END PGP SIGNATURE-----

--jpthgamqtyd76tr5--
