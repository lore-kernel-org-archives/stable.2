Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1A41685C;
	Tue, 18 Aug 2026 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054448; cv=none; b=JmTPRhXelbDueZSNvfB9ELk72ATpkNcDETIKWAckbfn6KyZxqNSX1XAN9zGKNwTvPCltztb2RPbQKRdaDd1rXGw73lN7hkJAqqdKW2AteHWdHP+XISe8G2B2hSg7192Tl8GnFXyg2rfAvoSlb2SlRhwlbiKy46pDsoY/o7dFZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054448; c=relaxed/simple;
	bh=j6sPUIByhsb5CZht4PKfKZdDnsVS/2Bnmka9ZncvSns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM7/ACSbE3JPj7wnwDV+YavxuilVkBX+Wy1agGimmoSF1t05oor7DB+SzHDF/zR4r4CWxUngMzFr2lN6iipODsqXKo3fEyW7VZXPmw5gX7IPvO9X9KwzNt10zJZLTUhqNhoc1HpStYaM5FWq35kS4ejPJlyra8e3Xa4IlvFek5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AA6CE20007B;
	Tue, 18 Aug 2026 14:00:42 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wwIUk-0027SR-1r;
	Tue, 18 Aug 2026 14:00:42 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 49D81585876;
	Tue, 18 Aug 2026 12:00:42 +0000 (UTC)
Date: Tue, 18 Aug 2026 14:00:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] can: kvaser_pciefd: fix use-after-free in bec poll timer
Message-ID: <20260818-ambrosial-courageous-carp-1162c8-mkl@pengutronix.de>
References: <20260818063832.383829-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fuapnv3yjcgpdmla"
Content-Disposition: inline
In-Reply-To: <20260818063832.383829-1-fanwu01@zju.edu.cn>


--fuapnv3yjcgpdmla
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: kvaser_pciefd: fix use-after-free in bec poll timer
MIME-Version: 1.0

On 18.08.2026 06:38:32, Fan Wu wrote:
> The bec poll timer is rearmed from the interrupt handler, so the
> timer_delete() call in kvaser_pciefd_remove() neither waits for a

There are more timer_delete() in the code, have you had a look at them,
too?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fuapnv3yjcgpdmla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoRJZgAKCRDMOmT6rpmt
0hzwAP4r5mtKzx9KAAujOJ6WCQLvrVxSA1x53McijfthdAnAIAEA5koBjmPgZAMj
FhrpMYTKA/1m0D1iuVEvEg97upvIDws=
=MYnw
-----END PGP SIGNATURE-----

--fuapnv3yjcgpdmla--
