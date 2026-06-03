Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A06437F73A;
	Wed,  3 Jun 2026 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519976; cv=pass; b=j3eYglDUTMoru5W9PJ+2k2jeqSzD5qbH9y0tYfXfx9yNroVJRGzhdG+cr9WbNHGzLGq3JEyRLWUKIV5QqULCl3hGTuJsfOgb5HYUo6eu5JlgvnRxKPVB3PK86wucJF+4y1OXsE1UGUZdrJ5SCCkiU5jCh1LoPIFBZ8yx8kyARTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519976; c=relaxed/simple;
	bh=NyyNvCZLStQ7ErkxEtTreoF8w2A0bc4Lc6JxEGQXK/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l55yl86XiM/YonQEhidKxytYtxgLcauX4y2A4f5Den3bS5KEPqeZuiO5jQVLzBuvpZj6kbr1P9qAvmvYP+z4MKEyw4aDTIzND+6tIl0yrqx99xVH+/wDM7mPPaOswVZofxIlGM9dtOQihXh8qCHBTkRj8UIHhWK/dKXz0c4Q0KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=gmpnMfVu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="gmpnMfVu"
ARC-Seal: i=1; a=rsa-sha256; t=1780519967; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LH1TywtGSM2yBD59YBPqG4mOooo7TNsWtH7E85DamtLyKXLnqdGIkWXq44mtiGyPLwgs+qStTbtf4t+Z+EBHWRe77KqGY1/I9w125h6f6UrkYM5gA8w4mMz2GllimIYcibME415ZSl7MpFFoCyGjYMGNZcUn6eiPbxNkGVVTr/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780519967; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VNfJORKyS7S4SxK6S3Pb5UD1hlxgi4qwhkVoop1KbQU=; 
	b=Yl1FmUn8igFbGGKsWGZnQY24tpODfDIYZ4R+bTQlhWYy+FZ0nIPu/RDIsG57fdZMvEjPwqfD0LfDDrhuyNB/9FTOhDS5fawS6oOQgU3kMsnBohhNJJkENuy0tvqdYHhcgiXeo63Yfgg1e6SVJufqMOJkOmogUpgt5bBgdQtJZAU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780519967;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=VNfJORKyS7S4SxK6S3Pb5UD1hlxgi4qwhkVoop1KbQU=;
	b=gmpnMfVuLQC+GJ+KgNDa9iOiCraF99/LkT3ec93x49iNNJ8+wdfOYUiZTq/DJctp
	MWoA9wyqKU8El0YwXDt8PTCw+X2CFrAsDrMrKwP/TTtvBZ8wrEpO3dKMv59BfHvexhV
	N60r7xyqcU13sKvcXlARgdS50uuTdcy4fgb/XtOQ=
Received: by mx.zohomail.com with SMTPS id 1780519965106860.4530380480584;
	Wed, 3 Jun 2026 13:52:45 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 6F6CC180C6E; Wed, 03 Jun 2026 22:52:41 +0200 (CEST)
Date: Wed, 3 Jun 2026 22:52:41 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Chris Morgan <macromorgan@hotmail.com>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 0/7] Add support for the TI BQ25792 battery charger
Message-ID: <aiCTYizaduoHLAI7@venus>
References: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uo3wokkeue64jygb"
Content-Disposition: inline
In-Reply-To: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.501.96
X-ZohoMailClient: External


--uo3wokkeue64jygb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/7] Add support for the TI BQ25792 battery charger
MIME-Version: 1.0

Hi,

On Wed, Jun 03, 2026 at 12:10:48AM +0400, Alexey Charkov wrote:
> This adds support for the TI BQ25792 battery charger, which is similar in
> overall logic to the BQ25703A, but has a different register layout and
> slightly different lower-level programming logic.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Changes in v7:
> - Rebase onto recent -next and dropped patches already applied by Mark an=
d Lee
> - Enable the Input Current Optimizer to improve reliability with unrecogn=
ized chargers
> - Explicitly program the battery cell count at init time to alleviate tra=
nsient glitches
>   with the charger going into spurious battery overvoltage state due to m=
isdetected
>   battery cell count
> - Handle return values of all regmap writes in the init function
> - Link to v6: https://lore.kernel.org/r/20260331-bq25792-v6-0-0278fba33eb=
9@flipper.net
>=20
> Changes in v6:
> - Changed -EINVAL to -ENODEV for non-match cases in the MFD driver, to st=
ay
>   in line with what other drivers do in similar situations (Lee Jones)
> - Link to v5: https://lore.kernel.org/r/20260324-bq25792-v5-0-0a2eb58cf11=
d@flipper.net
>=20
> Changes in v5:
> - Added non-OF match data and switched to i2c_get_match_data() to support
>   non-OF platforms (Lee Jones)
> - Shifted the types in the enum to start at 1 to avoid confusion with
>   zero-initialized data and non-match cases (Lee Jones)
> - Reinstated the const qualifier on the MFD cell array (Lee Jones)
> - Link to v4: https://lore.kernel.org/r/20260311-bq25792-v4-0-7213415d9ee=
c@flipper.net
>=20
> Changes in v4:
> - Avoid additional data structures and pass 'type' within the existing
>   struct bq257xx_device instead (Lee Jones)
> - Move comments for new struct fields to the patches where those fields
>   are added (Sebastian Reichel)
> - Collect tags from Sebastian Reichel (thanks!)
> - Link to v3: https://lore.kernel.org/r/20260310-bq25792-v3-0-02f8e232d63=
b@flipper.net
>=20
> Changes in v3:
> - Move MFD cell definitions back out of the probe function (Lee Jones)
> - Collect tags from Mark Brown, Krzysztof Kozlowski and Chris Morgan (tha=
nks!)
> - Enable ship FET functionality at init for BQ25792
> - Link to v2: https://lore.kernel.org/r/20260306-bq25792-v2-0-6595249d6e6=
f@flipper.net
>=20
> Changes in v2:
> - Fix an error in DT schema (thanks Rob's bot)
> - Ensure the broadest constraints for all variants remain in the common
>   part of the schema, per writing-schema doc (thanks Krzysztof)
> - Link to v1: https://lore.kernel.org/r/20260303-bq25792-v1-0-e6e5e003345=
8@flipper.net
>=20
> ---
> Alexey Charkov (7):
>       regulator: bq257xx: Drop the regulator_dev from the driver data
>       power: supply: bq257xx: Fix VSYSMIN clamping logic
>       power: supply: bq257xx: Make the default current limit a per-chip a=
ttribute
>       power: supply: bq257xx: Consistently use indirect get/set helpers
>       power: supply: bq257xx: Add fields for 'charging' and 'overvoltage'=
 states

I merged patches 2-5.

>       regulator: bq257xx: Add support for BQ25792
>       power: supply: bq257xx: Add support for BQ25792

This one updates the MFD header and does not apply to me tree. It
will have to wait a cycle, as there is not enough time to sync with
Lee how to proceed :)

Greetings,

-- Sebastian

>=20
>  drivers/power/supply/bq257xx_charger.c | 580 +++++++++++++++++++++++++++=
+++++-
>  drivers/regulator/bq257xx-regulator.c  | 106 +++++-
>  include/linux/mfd/bq257xx.h            |  14 +
>  3 files changed, 681 insertions(+), 19 deletions(-)
> ---
> base-commit: 08484c504b55a98bd100527fbe10a3caf55ff3ff
> change-id: 20260303-bq25792-0132ac86846d
>=20
> Best regards,
> -- =20
> Alexey Charkov <alchark@flipper.net>
>=20

--uo3wokkeue64jygb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmoglBkACgkQ2O7X88g7
+ppdGg//fyapOHU/WCudCf99OxRvCRFlbh3Rg5wqnMXWDx9UeI5RRTg7LtV0OO2T
EDek1rkCyRihGHBit3SYIwotIyrgk872Vyx5kj+LXqIEdVU+gnydZyhrZEvlnTTO
VGOyvdtDd2LHnXQbQdUglD+FG/PkcwSLs/L+5Q77dTXr/c6Ha4KEFh40+WNqbJQY
CYulSv653PXynZSTXiK7y0qr7HxVR5T5mxErbDMmHyW5fixKL7msTiJcaIQhjG41
CwfhA59BcihL1jTb8kgj8eDAoNAu+Dhro/wCvF4aqLbY3vI7OqRFSNkulWhoEdR+
ZF+y/OGpSN1IVPMpo71WXU/HIR7BosOBMVwL7GtRV53R3NwlVXN75zxve5jSPW4i
PTTWlBSlkq+6qt7w+9T/TIIFtm9og8cY5lMVl/cLOYsOPCwm5xIG/uJszZI2tiG5
dIOzHLdonCZvNJSb7f7ar2OChdLaIIsdySZHh69tZQIu2lUaoofYV6NIW4603fTe
eyL6YkwKfiyXLQhfI55/D+Ujdsi901EJLVjIR/gOmh7tvdxdMRi/ebYYoOAxU4qX
jurvOZk3eQNKeJSst+gJF1taeajy/PKp/gs4O/+jRQlnkpHfrPjwV7gxmdlyYV+Y
gmd/6ekczIuuJWLKwXy5sTmMCNNrRwBxXuf+A2ZiZRdDhKBESCQ=
=IcDc
-----END PGP SIGNATURE-----

--uo3wokkeue64jygb--
