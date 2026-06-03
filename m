Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9033E421EE8
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478585; cv=none; b=EGC88XVlVKCZMbfYevqekeQMSEP+in4Q3E9rNHrTxMrVx3R9fRoV/Z0gtKFmrGIny7th10AKfpVZ7oeipGmyBCy51QGxE+YV3VS118G5tmih0X4xDw9yv5QPgUXmjPYU72gDgobZztTrryb7vfYCzA7cYDFD/RLMG4uhD3B/fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478585; c=relaxed/simple;
	bh=uxkkZ2PsnRAYAVea7mInodj/ie50m+sZfEqTojMuM28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auSnlZb1mRGFqijWYTT/XmOap+29AKA18xGqkHjuT/KSEsLNkpyWH5xQQXMX7t/SApJGWMV/3GQfD/Z8eiUyuXrwrq18roCbmi8y/9sKM7PyjfKt32IgOjSSslXosQTIfwOTQWHEE+64UiHPAwVEi+1iwqO0vy7dWZ0RjEb1kgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MraICY41; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MraICY41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=oGHf
	1lkKQSF/OrpmlkLEH+QjracHniURhxyC+c0io9U=; b=MraICY414sni/PMMlxyY
	1nhIflhB9vlzYclkFiunyOAnwVsV54pG07gRuM4FbSs1JUnmZwcXlxViUdorqOYL
	SSXfWoApkhYzwc+6ubnE5hqzRPFcLGkpia71hdrZYTHGf7j5Kue6bvFpDj8nJu6d
	WcV3QbEwrHmiBEvHnIHcHO7I/pyHeZf1AKbI0BraCFv5IuOX0Y6tDDcJ/+HLL+Qo
	CrJ72yHaPsb6rCSdkWwgtK7mXoKSh1myKcPgwtTbrf78HSd5L5OxnPOqBD0ywPL9
	Zm2GXwzQ0YVrtVnst7B1gUaogRvMsWfbeM1g1SAzE7kdr6s7Sklzzc3emzIlI6LW
	Nw==
Received: (qmail 3213839 invoked from network); 3 Jun 2026 11:16:14 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2026 11:16:14 +0200
X-UD-Smtp-Session: l3s3148p1@FfEa4VVTvrYujnsK
Date: Wed, 3 Jun 2026 11:16:14 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH v3 01/10] i2c: core: fix irq domain leak on adapter
 registration failure
Message-ID: <ah_w3jDv5NljHaJb@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
 <20260511143715.729714-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cnGjfKB//Jq0VdPU"
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-2-johan@kernel.org>


--cnGjfKB//Jq0VdPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 04:37:06PM +0200, Johan Hovold wrote:
> Make sure to tear down the host notify irq domain on adapter
> registration failure to avoid leaking it.
>=20
> This issue was flagged by Sashiko when reviewing another adapter
> registration fix.
>=20
> Fixes: 4d5538f5882a ("i2c: use an IRQ to report Host Notify events, not a=
lert")
> Cc: stable@vger.kernel.org	# 4.10
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--cnGjfKB//Jq0VdPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmof8N4ACgkQFA3kzBSg
Kbbj6xAAmld0o5WEYz8cN6/Qk94JSxfZNjEX0M9K8trWY10S9UiG7uJuD5B0FUVD
3UiC7zLeOHkVBRTOykWvlAsMcYt/mLN6UFAyW9+YYjiStOoPqHeMILwmjv0Xwr7/
vpfE4rVYE8N6PwczadNmSS9YS8fUHv+376Ql3Ib/QJobX9zXig7uSoyhlAiSQFlF
M5hxaZbiruCWJwQnYhpU2pchVbZFskD0hqZsi9nbFt7PZqgFZlhd+e9ptiMpyzCY
WYGBMVhWZBs+B1Yw5SZVDf53SAu/YSBbFCXykzLsZc8ZMABjYUq1TaCgZPs+nyy2
IrJLDQeM+/PGfManbNoqnIzTG0zgE6+hQDdpF55fD3qJ9ypVcB+n3FTuEv5F9fpk
xUA7RlULJu8uw7mnVwUDXDO2TOna2Dcm7RUj1hPPakg9LtkqMDETVkIGSkXF9Gvl
05+l9VGt9OSIW0Apy1/cRxuyT57aA1K2lvT54ApnrAwOTI6ZTvTLefY//BlabpkW
zeXzrASb/lFgmN9DvaoGb9h1leDsK34X/eUvGrtFr21WQaTrCdU3Yk5iSenpiSWu
CywSnPjSLsQpB6/3s30rMAF+y4dXRSPDSMa3uF0rvtB2OH1nrDYE/WLHEr7rsxYS
K0Acrq0fqA+KtTi74vX1EGjK8j7V/vh4tpRsWKZ5+97e9OL5wGk=
=0DX3
-----END PGP SIGNATURE-----

--cnGjfKB//Jq0VdPU--
