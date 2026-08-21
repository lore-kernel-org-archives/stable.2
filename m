Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4334CA292
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325067; cv=none; b=XLNr+ASJDY7Izs4+5IEIrIqyJ3xviHcDYlRyf1/xElGVyZDTHcT5/plEYsPzbh2TQK2lnsQs9jbPIk8Ul0GXm1/mAYBH/K+wwpDDb7revtU3h7wFCH1K78VIZ1xcqR57iZKrKGFGnR7xZMfaTCeJIIHviK97/AlyYHLyUJ0JIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325067; c=relaxed/simple;
	bh=SYGc0HufZChba7XCVRP4aOeYT6ZDRVJb+zmJY4VDLEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD84iM8lNxPktQPxDlpov8kZVev2QSohk+SKp0LC+YffFYTJRGtvUi6YJSXWwWIYKJ52EIiCC0EFITe1KU8SSknCGeVoNxSxsOPfWzhiExAn6mltEuowXF3jZ5zO2wpcUPEj085i1sAd+yMgW37reGZtoHKXyLIXOpnklmoSQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KH8S/cuu; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KH8S/cuu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=SYGc
	0HufZChba7XCVRP4aOeYT6ZDRVJb+zmJY4VDLEM=; b=KH8S/cuu+JeJPUiUMiM8
	POA3IGtnCcGO59CiQw6O8jgHAQaJqfDs8UCSnbr0DzI8sAYD16TufR+u76GnvYon
	iwdnEjRm0hiWpUp/FXWzPGXGn3nFcl0iVLJ2gxBX/QWhmMaXyVDLsKC9G9DD9Z92
	+bNgXIBI49jkzgvGF5boLHwt5lhZUfmpNAhAGO50CJ1gTeCuylRu7syzuLG3KMll
	AkPgTUFbjFm0ciKc+vFJljM43RfmmWz9v3FBxFYccvrLZ28PLviZgPSG1KBKQBfo
	MEtBJnBBjKGOt+auulH3QpOFgmuZj+M2iGu4s8xkIy4EzBiZ5GhH2CqrJJVM/K7j
	uw==
Received: (qmail 689322 invoked from network); 21 Aug 2026 17:11:00 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2026 17:11:00 +0200
X-UD-Smtp-Session: l3s3148p1@UYZTC5BZZtQujnuu
Date: Fri, 21 Aug 2026 17:11:00 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 06/17] rtc: rzn1: Disable alarm interrupt before
 reprogramming alarm registers
Message-ID: <aohqhMZ2nhJObwnz@ninjato>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qb0y5Wtqi7m2jdR4"
Content-Disposition: inline
In-Reply-To: <20260821135608.275233-7-prabhakar.mahadev-lad.rj@bp.renesas.com>


--qb0y5Wtqi7m2jdR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 02:55:57PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> rzn1_rtc_set_alarm() updates RZN1_RTC_ALM, RZN1_RTC_ALH and
> RZN1_RTC_ALW using separate MMIO writes without first disabling the
> alarm interrupt. If a previous alarm is still enabled, the interrupt
> can fire while the alarm registers contain a mixture of old and newly
> written values.
>=20
> Fix this by disabling the alarm interrupt before reprogramming ALM, ALH
> and ALW with a call to rzn1_rtc_alarm_irq_enable().
>=20
> Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--qb0y5Wtqi7m2jdR4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqIaoQACgkQFA3kzBSg
KbZ5wg//W9uPmECk315BxyjWnIHrFTKRLybDiHtyVUOQ3zSuIyRhBGBvlZE3Kj/I
IZ3+VHx9ieAps9NGlTrES8NCL6bHkNwFZQ4KhQXdwWk1sCQnZTXCuofZyU0h5Ojf
VUwiaSHFO9dDmbOdJ9NfXMnzUJOw8bpdY3zvUQwOOIR42m3S0pXCrRYS9ywj8IMM
zPXogefpi3x8fwC9rtvs/eyNOL7Y4y2LlIweSuQC8/nziMH4jCM0wXktc4xRcJqo
qqHcfdwkUmaIvcAok50Z7uNBU/8N/h9b9dMe0dqILEk/WqqTIq/dyvWl9lowlvD4
98af32FLGWaKaoj7VTDZ7wnRj3YPtVRucffNUrfsn8TGUE1h0FxiU55GXtX44ZbQ
BPLyAIE7xdmYKMKCy0DDoSJRiCpztR/L9MQxhJyPXBJqVtTRGhTt62Te7ZeuhYf2
OFOKnbsRJBGP6G1EOJRQSCv5i9gVIWiSetGL4lduiNOUOohF5PFp6cOgeVQk9pnT
SHAgIvx7KQ/WdmZ23LfUlJerMJmQf4kLnpAd5jVPjYRrZeEgOjBOKd9JXxdlfgn7
8ZYEPm4FlrmrlfN1f3pRkPcECP8RKdAYyKvOj5D0KwFM1UWHYYdp5wVv7u/iAmqs
2PR67W5O7+B54b8dPvOtYleUnuYxNp/XNWSVXQm1IzyKesNp+Jw=
=MMen
-----END PGP SIGNATURE-----

--qb0y5Wtqi7m2jdR4--
