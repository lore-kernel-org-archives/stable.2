Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C763A6B65
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047858; cv=none; b=MHtFmdsB3qPgBzqGO676xobiMHwAHz4cKvFPJrc3BpLqLRzF9hbTYs1bfabGenAX7UCGpFzhpwHMCrK838gd/2IRfA1xAwPU9Kt0M+r5m32J2TgzBB/ZcL6KpRWHF50F3WgbQKjUpTl3ZEXDr5Wu9zl7AeqpzFCzs7j0MVaed4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047858; c=relaxed/simple;
	bh=b6y5g+oATIwnjJyMfH13cCLW5NgD3VT0oeURdRj6zec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JT2cguvid7X4Q6EAg3b4y2fg3GYFOslBIN79o10XxcJUw+MuFwQ87mP0/nNqNv6e7IFN2p+gmP60annveW4dF2azG4ovHFLBsHtp7p3L/NKFvTDzQETjFMsdb4b/TCSWN2yzREav06wOlqkK3N3pKrJgA60kq9DXO5iC60o8Awc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=GiCv/Wt7; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="GiCv/Wt7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+qpV
	1haIAilTDjoLksnJ1qlHTSgPtxXBNbxP5qzGEjU=; b=GiCv/Wt72ZW8XjYS+2Jq
	b7LFBVGFo6f8bS1IrUiQgvDkZvVeI7KG1vTNPcuUkVHNB+pUj/wXImxa8JdIOcSx
	2eLmGYO2gcFIi6Lq9eqzq1NRquclgr1ZvzR067vNYCUdz8yQ5EYnOt/36n9YIBw3
	ZmLN/hRRwByEZpdxWFwqaEEYa0+xK8pj60/THwKLWyo+ZZme51Yo7dcHYZYHIBZW
	RbzHx9Jf/4pjbk03Rv7+QvjzFLkUgcMNh5vlXdOK6i2eGfnFfCKAHNJ9I8Evv4wS
	K4/Orp06K1BrrQu6HKWL2aD/pt2tCpTmSvWf1SVQGAoKoRXfb4pXtaLy/Z38jh1g
	fw==
Received: (qmail 3753300 invoked from network); 18 Aug 2026 12:10:52 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2026 12:10:52 +0200
X-UD-Smtp-Session: l3s3148p1@nQ9zgE9ZPsAujnuP
Date: Tue, 18 Aug 2026 12:10:52 +0200
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
Subject: Re: [PATCH v3 03/12] rtc: rzn1: fix weekday underflow when alarm
 crosses month boundary
Message-ID: <aoQvrL8cnnK7uxqw@ninjato>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GYv+4uDsaZtm/RpA"
Content-Disposition: inline
In-Reply-To: <20260706175138.12587-4-prabhakar.mahadev-lad.rj@bp.renesas.com>


--GYv+4uDsaZtm/RpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 06:51:29PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> In rzn1_rtc_set_alarm(), the driver attempts to calculate the weekday
> for an alarm by computing the day delta between the alarm time and the
> current time:
>=20
>     days_ahead =3D tm->tm_mday - tm_now.tm_mday;
>     wday =3D (tm_now.tm_wday + days_ahead) % 7;
>=20
> However, if an alarm is scheduled for the beginning of the next month
> while the current time is at the end of the month (e.g., current day is
> 31, alarm day is 1), `tm->tm_mday - tm_now.tm_mday` results in a negative
> value (-30). Since `days_ahead` is an unsigned int, this underflows to a
> large positive number, leading to an incorrect `wday` being written to
> the RZN1_RTC_ALW register. As a result, the alarm fails to fire.
>=20
> Fix this by utilizing the already computed `alarm` time64_t timestamp.
> Convert it back into an rtc_time struct via rtc_time64_to_tm(), which
> automatically handles month boundaries and correctly populates the
> `tm_wday` field.
>=20
> Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

These messages look a bit LLM-generated. Is this true? What about the
code?

> -	days_ahead =3D tm->tm_mday - tm_now.tm_mday;
> -	wday =3D (tm_now.tm_wday + days_ahead) % 7;
> +	rtc_time64_to_tm(alarm, &alarm_tm);

This conversion is superfluous, we already have 'tm'? So, I think we can
skip the whole conversion block here and use?

	writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);

Only lightly tested, please double check.


--GYv+4uDsaZtm/RpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqEL6wACgkQFA3kzBSg
KbbdEQ//X7ob1iohhSuIpEda7+mX2iYuHaEJ6g3q4Wapr8DOqaW/F1NHNGPoAkrh
k2ih3YYX1XgjAx9he3kiprn9eJwzP7p9BU1EljIhuLfL5gtzLSuFWx1y8FZom3VY
caTFfLU1t206Ly1WykSNWYsXI9hX7DOY1mRobv5XhSDWBtSUt6L0ezlYsusrcpG3
9ydizeH9/jXg6vpDBCGl3tbsJILtlnuSqZUXJb4YuO5EHkVV4geawAK28YWaCoLm
sDYZkx9Ww8sA/m37DGPD6aKhxcT8BAxoaGTkct90RvwbOxmtS0gljL184No0OWxo
UyCzWWBAqOunVZeqMhZ+26MDUHnmMrc5WPj/82AQvylrj7kawK1xJV37fVdCVtaU
OZtNPj/YE7z3QaE/af7tvXm9frb4hSF5iYpdD7hvqISPt3/qtxmfW6V8dInVeg+Y
6AZ0K1iFQ7378YI32Z09XmpdyfcWCWNfMRPdyCAdKenlQW6QUERtUxTFWHOuWWWj
ujqVaz1XCpdhI8fJwV7+mBuzJJjpjTY+azFbjrJA0qDu6AVs2gIjTs4QqBKIzxZj
IDaRXOUchOqii5qVAeBfLZPg1YWXyuXA5b/kWpq3c9dyEzGiTFmmy/yW4sM0+Wrk
eYpV4g5vk9/jJQh+pthi78VJ21rhGJRghAB6peP6C87ZeESWSHE=
=KqXE
-----END PGP SIGNATURE-----

--GYv+4uDsaZtm/RpA--
