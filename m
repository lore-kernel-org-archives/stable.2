Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D73264D7
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144280; cv=none; b=WC0hx5mhVkr0jnAIhfXCwd9Qk7QMtGwjujsAe7X7aIGKgZrQ+mc/KarCHxlb3kuOE9W4/Y/Tr6MXJ/hBkOJbu+4iGdMv5JdH0imRmfviFgD+M6ZSlGefwIv+MaKtHmbrqonLOK/a9HaPDygsXuLrHxB0tL/JNUqTo51Qj1ZSndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144280; c=relaxed/simple;
	bh=vDwo+C54SuWUO4NiG+y+TLv77E9F6XwxwcQUknLWuQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFj2k6PgBprygfJWyT+Elzc3YhSTZxDMgVMxYNeiynbspGTH939sUP4uoGcdc7pLWmcMfOH7Ua+mAxzexmFkpH+ITKXR9E/AQ9bwO2Zm6TtdA2BiqdNM9KqsshEEihgtcOXClFpcFMmloVw1eXnIrd4RG10V4GJsdxY45asL3p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SZf4pOJ7; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SZf4pOJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vDwo
	+C54SuWUO4NiG+y+TLv77E9F6XwxwcQUknLWuQ4=; b=SZf4pOJ7e7RGaCuw3k/E
	P2BHw2lhtM3AeLjqVYpX1dccivn7ps//DY9yniHwYP9MYnd3cTiBLyDi3rab/nDe
	oytez1+EuLt9sTS9TkmVb0OgP1jxTKq6+f2ZuXmMamv7kSAtnH4lYK0fC0JMEja4
	1cw5QvluRRsl9eGDCLRZQMyu9p2Do99NFIuF6addgPfzSwHTmd0+SgGBuvM678B0
	pE4sMbYdubtjIdBW3zZKKf4GNjm6YFHoRaryaM4VuVTb1G5Xqc/TfT5PMl4hGiVV
	RFnC7/jv4OD6QYvPeD9sqyrHXfAEO88OmJyvg9m7WFJEsBiALxM44RVaWTrqSQyz
	2w==
Received: (qmail 4144100 invoked from network); 19 Aug 2026 14:57:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 14:57:46 +0200
X-UD-Smtp-Session: l3s3148p1@HvAp82VZOjBtKbIV
Date: Wed, 19 Aug 2026 14:57:48 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
Subject: Re: [PATCH v4 03/15] rtc: rzn1: Fix weekday underflow when alarm
 crosses month boundary
Message-ID: <aoWoTOTbl-ewHeUY@shikoro>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KqL/t5WDF2qYolTu"
Content-Disposition: inline
In-Reply-To: <20260819103926.2136712-4-prabhakar.mahadev-lad.rj@bp.renesas.com>


--KqL/t5WDF2qYolTu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:39:14AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> rzn1_rtc_set_alarm() calculates the alarm weekday from the difference
> between the alarm day and the current day of the month. When the alarm
> crosses a month boundary, this difference can become negative. Since
> days_ahead is unsigned, it underflows and results in an incorrect
> weekday being programmed into RZN1_RTC_ALW.
>=20
> The RTC core already provides a fully populated struct rtc_time for
> the alarm, including the correct tm_wday. Use tm->tm_wday directly
> instead of recalculating the weekday from the day-of-month.
>=20
> This avoids the underflow and ensures alarms scheduled across a month
> boundary use the correct weekday.
>=20
> Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--KqL/t5WDF2qYolTu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqFqEgACgkQFA3kzBSg
KbZmMhAAocPEAcPVS9Q5+xg5+1T2F0qy5PbXo/vuqmLBIcj68Ms6O3s8ScViXTcB
tKvNbQ6bn+Vt5/TwYw3zyvmvRwBzAsJxGFDd3fkVQLIGwYWmEYH1ca2BaS7GSu1R
cTndE8BIf3zq0/f3TGz6MKOL6K8MitPpmmXHrTC+ulC/sPbwAuyBgbjgaqtXQJFe
0OLudvJTSj3qTv/3V7J8DDliNHI/2IeUlBOB/TYl2uNxUBhmocd330fzdE5KrKXa
OmWwTK6V0AUILbnhgssYK63KKFIhymTR7CWPj0KDoUPPlPjRbSZJBEJ4tkjkY5bu
sawFrTz/3UJSecFU9UZzy2g5ZQSMPVHtq8DNCyEWo6b5g64haNIvMkJ3LzJUFsh8
SQW5RI9EbIymXXfrah5ooAWO6XDpm0YQwoDFua0IVGmON9aiGA5yxAq66Q8AQ2qR
xy8SR4PjHUD7yJEXIqVrOrvJDC2eLouh8I0M2/kbz99BE2SAnhnWiMP+0dITuaml
jqv30ZXuuHsgC6ZNwTqH6/N9v/k5zhhcMdg1s9+Yv7dJ4Oqw/f9Lcz4UquCf2elf
1M7aAyiN7nolcJd4zyehmnyivXwse6mucvd0H0KXZzfXUM5cV8LvEx09MVmthdgi
wZcHUk97lRfCbwJ943OSwNyk7dael+R9Hzu6TrvpOfzVPW8nYG0=
=xr9R
-----END PGP SIGNATURE-----

--KqL/t5WDF2qYolTu--
