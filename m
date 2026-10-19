Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661448382F;
	Mon, 19 Oct 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401530; cv=pass; b=KKuJuHIsj9Fk8Q5owRvE0fKdL/9elAt7OFqpOfOKLvDrTEhK/uCfIzUes2tlxLDwr7AA/l01tEvsZ7v6vsf0/vG2U+/QbOr6btbc0R04g8bnDhwzdiCtXRGwGC/yc4HVgvlcKPf4yh64cF5u7B4kadofDkkf4y1a1Ry9HvDOMM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401530; c=relaxed/simple;
	bh=Ha1/ipn73y2N6FQJ8KbsU4ighAF5nNlAVjfzyEHq6Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6i6KQVE7Xtn0OuSKi1dorbA7TBal6I72Ccj9XTDW5ZW5efu3dnz7LtANuoBVpdbxGGCRQIdqXdIlsvTYoYgP/DmLnlQ3hNfRnLcCYI28EfwE2Sze0XNF0e4CAUhtCEMxUywbN0Qrv89XmEzW2HimGmLk8nFAG7cog5Bi2mRsZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=es0Bfqtw; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="es0Bfqtw"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E12E92018E8;
	Mon, 19 Oct 2026 11:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792401524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SizZY3M5+zhVSSriBwCUfXvqJYB3Q9U7m8qMTQTl9w=;
	b=es0Bfqtwo4jPpCHuNRICHhgKi4HMW/Ir5r59nUAwRKiyPw2rPty3djeCuWRHAz3TbeQ7HR
	aVf4L1m1XwxBx2P0UBM5ghH2NP2126aE4lu/ykgqcbjP4BDE0l3YQ818NOdv/I+YeuC6+L
	K6/ME1t7NCQzJcBEUY60ucPxlDZ5a1oVle8Da/h0bbX4IyIggMGX4xerGR0t9Rlx2IuTQc
	WiVka33VRND2DbUr4sSaFuhiO+mZTZt3BIJTVIivVyKN6YbtXYQSpBzbv49Z0EqsfcmmZB
	i8o0EK9yyjXkGY4vWVrOL7huZ8v8RfNO5QJUKsUX6x6uujzNkn1cQxFA7Ohepg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792401524; a=rsa-sha256;
	cv=none;
	b=BESa0Y1JmSGzeggTTz4AhwE6fWk6+XtHa/nWlc44WkFyJaS5mw80eCPozCpq8STwBDJjik
	7ftC9Ik1EzIbUskaobY+kgZhktB0W+dlkyefwITASCSNbiQocdObGukM6dN9NWLxlM9DBx
	alte5j5fI7Yv6OV7ZCqB2RJEyUWlda5TskK1exwl+KANIjau5jUpbJC5ld0r2yK7qM4RKK
	KnJMhfSP1TBmXln0AuSVamMxO9xEx1ayeTZpwrX/gZb/XyG8gzB+mPor79WJpz0HJk/r/n
	qhKvDW12I+vkfvMXHDnJqpWkShp5jr19EJ9rAw4+N0jaksFALI40o4AGS7a6Tg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792401524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SizZY3M5+zhVSSriBwCUfXvqJYB3Q9U7m8qMTQTl9w=;
	b=SsjbKNFRg9B3qag3E/kvyvQYSm+8dKn9z277hDGSF/Q6sDfKUtKe5Gj4ReIzD6mqnkqf/V
	x3fIV8IWm+ceX57krBoaH2q+jZWL5ykHZPR8/jd/i+QAfbh/NkEhcJN1g9krSdno7QNP+3
	KYH8OWFjrDx3MkrwGWzVwvsMWdrq/yRls81Zl1AMWAE9bqff6GWVeV3bRAZMq/2VhuU5ak
	bdbBaJOaE1/lRTohgVf1fFaL1/Xs/mUXtIe5I+ofiwecsDnRbv4EqbUNXqYew7x0wmKxH2
	aJIRsDFo+1Z3JYxmxQvFbTroF8UubpPYdVhBqw2JsR8AQf/4ONpXpXMiPCiBYQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIjW0-000Cbu-2d;
	Mon, 19 Oct 2026 11:18:44 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 78D2E5C8514;
	Mon, 19 Oct 2026 09:18:44 +0000 (UTC)
Date: Mon, 19 Oct 2026 11:18:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, Norbert Szetei <norbert@doyensec.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH net-next 06/12] can: bcm: fix filter removal race between
 release and netns change
Message-ID: <20261019-audacious-premium-fox-414190-mkl@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
 <20261018164417.1540449-7-mkl@pengutronix.de>
 <088cfba9-f0c7-4f51-a9a5-4e1b28b8e90b@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tcitz5funqytehiq"
Content-Disposition: inline
In-Reply-To: <088cfba9-f0c7-4f51-a9a5-4e1b28b8e90b@hartkopp.net>


--tcitz5funqytehiq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 06/12] can: bcm: fix filter removal race between
 release and netns change
MIME-Version: 1.0

On 18.10.2026 20:37:41, Oliver Hartkopp wrote:
> ps. I did your requested instrumentation and found a missing glitch which=
 is
> the reason for the v2 patch. The v1 will get its sashiko review today at
> ~10pm due to the 24h embargo :-/

Can you send a follow up patch, that adds the guarded_by stuff? And
include it if you re-spin the series.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tcitz5funqytehiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatXgcQAKCRDMOmT6rpmt
0myOAQD0BtEXQgJXhBuOjK8tpQd+03rCeASuKDqcOlAwepA8aQD+NE9j6gcgIgdy
Q6psIE59I3ZRfyheXMBx9Q7li9zyzA4=
=FoVq
-----END PGP SIGNATURE-----

--tcitz5funqytehiq--
