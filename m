Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792571109;
	b=tGFr++6TVPj9VIaHpXdYLbhi8NQSl2RgbsfgD1tQ1yXEuo1b3gTelglIkGjk2aiKnZJ1
	 Dtvdi6iTDcrcmXA9tSH9Sm3R8uXbBROCyS3JPiYV+Em8JD/l2+239aeTHtn6JS7t7wEqV
	 KAyH1goQBc169RGOWxiyRptdudBLcWIATR9xxhBd32lQG5N1ClKBh4waiR//b9Yl0BNQr
	 uAtNYaV+Y/RbMvza4v+cqX7WQgMC+DePrjPMTBmQg/wDKPN9XHJDBFTV8ofeb/x20DIkP
	 n+WeG5m2S4q93AXmlvuDVYXcTQ5KLmV2w1eMqPLKu3aS1LHnj4jUIe9kSXR/JQCLlgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571109;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=h/hSC13tu4dTP+Bia0+DJf04N3hSWtGlShKyDnRL7mY=;
	b=xAd5BfNq5kG+ZKjnzEbmk8JyTAEmd2/VA8rkvWpz7bCbeM7G4d+gG/NfNRd3zTWJkbop
	 UVUPPVF++K1GjmvD5Zj0nNtAKCmMuFWfk8mjlrFFhvAGufWl9wk21CbOsqRNt7QsaWg86
	 C/vQSW9pM5cZRQwlN5KhgpRcb3yjIa3029FpFgQt9xTU2vij8g7dWn87Myuab/T20ufOj
	 BZ4h3L0nxhyV8MRYsfZKhcdwkZYV0C5ZJRcaTyrL/aX3JcGa5Kb9UC8jpWIP8jBjVIuBv
	 eI+RUxsoVCdAlj/D0Kb30zfFtCZcXaVx6mmEyvaDSH6wCoPvkEwmrnZOq9tqhoXVRpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ModqUn0U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFB3606A319;
	Wed, 21 Oct 2026 08:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAFB3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ModqUn0U
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BA7062017C1;
	Wed, 21 Oct 2026 10:25:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792571105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/hSC13tu4dTP+Bia0+DJf04N3hSWtGlShKyDnRL7mY=;
	b=ModqUn0U7SvXLPIOvg59+ttcxnb+c4CE8d+IDpnr4PSUi36yuvWT3eu2PEg1faj87YhtJQ
	qbXFSEWzYyEXafbsczgAFQWWwuqzDHxpowRhariajDufP0JisX4Be5yKhD8NmvCKwi/VFz
	JdztHHP/R2gVt6LtS8lfB5IB9YSw3VlZ3y9GUFWYw2HXXLCvFPmZ33K/suan9OKeDFJj7F
	XVjmsTuDf9Pfmg3DBxRSSQ+jpKkVzel5HxcFpRNtn8v2KxrfQTLK0LEgrIl+Iub8jf+V4I
	atZjrZMKD4wftZNkRaegunjPeOHWs54DNfGCLnVxPeON09tbJmtrKhNNwOuyGg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792571105; a=rsa-sha256;
	cv=none;
	b=SKeytmx2kIxQFwEoUwR7R/voLGRQp0LHENS7evjTOEE2yGXeNLZ+W94ewy3bWOS8tT09eL
	BFzVgfbIDn15fmSk2nWpc0syspUYgOAaAdLt866/Hn8l+5KKwafd4aWQ7tTaifuxld+VEh
	nhCmmV4E4YFWlrzugkf9XKTdJRPt5VLBlh7Sy5ydu9xm+Cd21y8GYN5KAbBG5iTuq0j0/E
	fRq3oOh05k5JGlxczL9jnRdwZELE+sYMXn6c/rSPMIhasR3wJ7ZHi6MtwLkRaLJzCWZnBQ
	bS8Aguce46mclBJ1scbWlXpaSrEmct6eZDa5aF798wkjvwPXVkJzAApvIapAtw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792571105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/hSC13tu4dTP+Bia0+DJf04N3hSWtGlShKyDnRL7mY=;
	b=L/lSW23VUgXM7ErPE49WVAreysdIAVPGQSVZvBbS3m3gyyrZG8Z9Ae6HT/CGJ9fxd1liNw
	jK+bJ+w3SSjXjttF69t7dZ+rRxysbRv9xYLZu1NWeVs+2fckYqypnJwUM6WR1Qrl7ldDhS
	ypEGUUUdgXQE6DaywMEOqnFMDthrLQReGbdM2OZr1QUZZCmzQTn6jGUsPcXSz/9opMELex
	t7/jH1QSqW/Pn2kD8dhMcThPYieQX11Pr6ZLW/NT27wvNhcURylrH9TsOB6zCH1LC+TuBi
	s1lA9EumnhiUmxpFHthCBzkGS7S8Y6T4bGhUarzKxYLp75IyG3U7u6TgOnVk9g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJRdB-000Wuk-27;
	Wed, 21 Oct 2026 10:25:05 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5CCA05CADD0;
	Wed, 21 Oct 2026 08:25:05 +0000 (UTC)
Date: Wed, 21 Oct 2026 10:25:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?5rez5LqO5pm65by6?= <chunyuzhiqiang@yinhe.ht>
Cc: netdev-bot+sinfo <netdev-bot+sinfo@kernel.org>, 
	netdev <netdev@vger.kernel.org>, linux-can <linux-can@vger.kernel.org>, 
	kernel <kernel@pengutronix.de>, "haibo.chen" <haibo.chen@oss.nxp.com>, 
	shawnguo <shawnguo@kernel.org>, imx <imx@lists.linux.dev>, stable <stable@vger.kernel.org>
Subject: Re: =?utf-8?B?UkXvvJpbUEFUQ0ggdjZdIGNhbjogZGV2OiBjYW5fZmlsbF9p?=
 =?utf-8?B?bmZvKCk6?= don't wake up controller if interface is down
Message-ID: <20261021-robust-electric-beaver-796542-mkl@pengutronix.de>
References: <20261021023334.11803-1-chunyuzhiqiang@yinhe.ht>
 <20261021-romantic-jaybird-of-cookies-1ed8e1-mkl@pengutronix.de>
 <b9c8e7d7-584e-43d0-88a6-ee0ee6e6c700.chunyuzhiqiang@yinhe.ht>
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
	protocol="application/pgp-signature"; boundary="23cwxmzpbad3gume"
Content-Disposition: inline
In-Reply-To: <b9c8e7d7-584e-43d0-88a6-ee0ee6e6c700.chunyuzhiqiang@yinhe.ht>


--23cwxmzpbad3gume
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: =?utf-8?B?UkXvvJpbUEFUQ0ggdjZdIGNhbjogZGV2OiBjYW5fZmlsbF9p?=
 =?utf-8?B?bmZvKCk6?= don't wake up controller if interface is down
MIME-Version: 1.0

On 21.10.2026 16:20:18, =E6=B7=B3=E4=BA=8E=E6=99=BA=E5=BC=BA wrote:
> > This patch doesn't apply to current net-next/main branch. Please rebase,
> > in particular you're missing commit e63281614747 ("can: netlink: add
> > initial CAN XL support").
>
> Understood, v6 was based on an NXP lf-6.18.y tree.

:)

> I'll rebase onto
> current net-next/main, including e63281614747, and rework the patch so
> that both IFLA_CAN_TDC and IFLA_CAN_XL_TDC only skip the automatic TDCV
> readback when the interface is down. The size calculation will be
> adjusted for both paths as well.
>
> I'll send v7 as a new, independent thread.

Thanks, As you're contributing regularly, using b4 [1] can safe you and the
maintainers a lot of time.

regards,
Marc

[1] https://b4.docs.kernel.org/en/latest/index.html

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--23cwxmzpbad3gume
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCath23gAKCRDMOmT6rpmt
0mD/AP9Eh5XlKdXKOa2UiFUhZEc1UXRpmwnvIOx1SR9MsUjEwwEAlqpEJAiHMOue
fWPjTyoVWe1ENIgRJBzOrAKw1c4OhgM=
=B863
-----END PGP SIGNATURE-----

--23cwxmzpbad3gume--
