Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84FF395DB9
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478825; cv=none; b=n2NCEVJ43MmBf40pdkMmShvpDuxweV4gK69w6qjaBVIJjFMyTm3Q++35H78IG3P1Lvs+nwN0LvGpDR/NWYpCF4uQCNp9ORH8/fC0Pm29ED4DUN56B49Dil/mDSssLaCOL6AsSCPGrC19haSZ6NOCDvXmRgLuM/p3orMVAWRKDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478825; c=relaxed/simple;
	bh=4vXGkywpeklbXtEL0glqdzNlVdnYI5D0SbzMF/TKS9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljUaiYycnYLIoG6TX/SvvR/fQJKJwRqf7hRBrrLIvcHA/snzPoTu8DjDYXBdC6gW6UWyDZB1Y0c23tqztPsB6FEV/66+oX7pzmMDStYApQNJle05yyPreI4MWY9klrF+H3L7/ISmRMm1RDwLrZPN9CAvDzoQFIZHT2loWjRlQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MsvptMm6; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MsvptMm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=4vXG
	kywpeklbXtEL0glqdzNlVdnYI5D0SbzMF/TKS9Q=; b=MsvptMm6QlpLsk7zyuER
	1BN3weeEyKQ+GMu8mqRcCVqexDRRj95uwabj84idDAggO+gm2XRaxJDnKEpDIOEj
	dt62eAw4jaEXR8PEMF2Pl5lobZr/w6rN2K09P4+XzA7xZiRLMZmDq47hfPhSNVEY
	ka3Nh2fr1zKhgwrJ7iDWx3zFuS80hFR+y+DMBBL8aMKPAEJew7iroUGSbZU8vgKb
	Adk2Op+kKRyYLLE7fUJigMwnFs71n9+sMew21NzsK3yPP68bbrCpuTyKZZjPO/Eu
	b1n5bWDmEL7S1MoLNJiNXADZW2u96jg7iUmKXOtuvTqG9DEYzq+3OkW1s2t4DybJ
	8Q==
Received: (qmail 3217123 invoked from network); 3 Jun 2026 11:27:00 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2026 11:27:00 +0200
X-UD-Smtp-Session: l3s3148p1@YZWhB1ZTSLQujnsK
Date: Wed, 3 Jun 2026 11:27:00 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: Re: [PATCH v3 03/10] i2c: core: fix NULL-deref on adapter
 registration failure
Message-ID: <ah_zZCYqMi0eVO9J@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
 <20260511143715.729714-4-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C44V5Q5i0Kle7Ymi"
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-4-johan@kernel.org>


--C44V5Q5i0Kle7Ymi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 04:37:08PM +0200, Johan Hovold wrote:
> If adapter registration ever fails the release callback would trigger a
> NULL-pointer dereference as the completion struct has not been
> initialised.
>=20
> Note that before the offending commit this would instead have resulted
> in a minor memory leak of the adapter name.
>=20
> Fixes: 3f8c4f5e9a57 ("i2c: core: fix reference leak in i2c_register_adapt=
er()")
> Cc: stable@vger.kernel.org
> Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--C44V5Q5i0Kle7Ymi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmof82AACgkQFA3kzBSg
Kba4MBAAtl+i0kD/753gFac6siJM1Y2BhUnn+F8nQT7jqxGRfy30QpNYeIq11tbM
V82br7K4WgSkhNm43fFrx2mRx1zFxEIsIYoueiYs/R5yFH5MEeTD58Kpig5jQY97
PIwsrG1KuV7BCDctlyikhTVw3cIFPxneG+J69X9QJWotvFfMgKedl8yzO/ly9hrG
tpx+2FAmz9GJGbecQmUDbGKr6iq6WMtEfXyTp9ZRkil88eF3tuHeL8ZljKilJN3D
ptNnRQMIdons2YxOfc1JYmPAwweDnHg7HjY8WRWPl2JWLVRe6NfZzogUxU83Imw2
LzFgRMKTR2RyqnPaSpdi4MRVog6ZdhGeESZyYBse2+K+pNV6ZbrMh9v7Lib81pEG
93g63NgxWGPCD2CHEVL+1BoFKh8elZLX+zh5F3KTTY9R94Fdfm5Zy+neSOFC2BHw
ZPSs9xqJxd7G5ZRDZpBkTUZaDMUFncvVcZE1/+fu6KpAFulPfAJgvOF20yXu95F+
PoXNVEX8WXyopkutCpph1RQbm16G36an5EU3mEBl31NJKbWz4dps0trQ7//3jxCZ
NI/wtq2vShklzlr9PYBYCJP5AW7w2D62ZOOByDZMpMIpZzE9iHIx2iPE1eMuNs7b
aE/McdPFIje5RG9jCGkhMG3U4wSI3zwUxuuReJfMsHc+Kvgk7zY=
=79+H
-----END PGP SIGNATURE-----

--C44V5Q5i0Kle7Ymi--
