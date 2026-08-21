Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652D41A569
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324944; cv=none; b=N58fvMkK03acQxjqHJq+2HY+IwDXN9trJ7OHR0DrYEs0SntWxLrbgjP22CoTKRg9bMNCO9Oxv+04DdEZsG40xk9n8tqPFWANAQ4qA8EhATG1jJRwgrLqTR3J4hxk9q9g7TpA482HcjxJMf296RV5RxoFwEUkzQqsz1x/qgFHnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324944; c=relaxed/simple;
	bh=OeYcDSMUOTHg2PSXTtQe2htdu4AxV7OnGq+3K1GdHW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3ifAsSMjtwZIKHh4RqT6F3s7r6k/TUv6daBLQQOiwSEpLRcPl/5QfVQCCBHPXQADciOFqTAZJoXpy214rcMD4AYMeRJs0lW7ApnkSJQnyaOx35NcGXCxYeKkGj0+CAGLFW42kcjOLLb4CWS9nxwsOBV+/32fsf+mKvGpSmOBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MTzBRMt+; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MTzBRMt+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=kubj
	0m/yvHSzjWzUtL7kbp7JN4eyECGvIQeEkIZYTFY=; b=MTzBRMt+mpsZzL1/A1BO
	9O1sIEIZ7fqBjiHkruSHsbd0OqMXcsCCs40TNS1VeyFFOkatAbeb14SHliBKvwxQ
	/VeloRYwegFl6Nm4Qs/EIHKJuBW+52WZfC2bLjNmCDKrvn6chFUqxK5j92V/HBkh
	hvXYDkak74c3LYCU7YRvzXVncCbfnz70SJEwoCZmRqUw6Yedl8JvTVHWmNkO4+gW
	/WhsNxpDBscmlHH4qLU/FZP5vly1klLNkG1FCJ8eGrkf7x42YhlkhlP0EGwQHRf2
	skTD3AISsgLHf7jFKRYDZieavaabxwQNB37Kz+M/mXyqcYnha/2NERQOE0fongeK
	kQ==
Received: (qmail 688643 invoked from network); 21 Aug 2026 17:08:59 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2026 17:08:59 +0200
X-UD-Smtp-Session: l3s3148p1@g/gWBJBZiOcujnuu
Date: Fri, 21 Aug 2026 17:08:58 +0200
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
Subject: Re: [PATCH v5 04/17] rtc: rzn1: Handle unset alarm weekday in
 rzn1_rtc_read_alarm
Message-ID: <aohqChLVqwiTpICo@ninjato>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HEePT0xBzTmUrcbY"
Content-Disposition: inline
In-Reply-To: <20260821135608.275233-5-prabhakar.mahadev-lad.rj@bp.renesas.com>


--HEePT0xBzTmUrcbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 02:55:55PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> RZN1_RTC_ALW is a weekday bitmask where bit N represents weekday N.
> When no alarm has been configured, the register has its power-on-reset
> value of zero.
>=20
> rzn1_rtc_read_alarm() uses fls() to convert the weekday bitmask into a
> weekday number. When RZN1_RTC_ALW is zero, fls(0) returns zero and
> fls(wday) - 1 evaluates to -1. This invalid weekday is then used to
> calculate the alarm date and can either leave tm_wday set to -1 or
> produce a fabricated alarm date.
>=20
> Treat a zero RZN1_RTC_ALW value as an unset alarm weekday and return
> without calculating the alarm date. Move reading RZN1_RTC_CTL1 before
> this check so that alrm->enabled is updated for both configured and
> unconfigured alarms.
>=20
> On a cold-booted board with no alarm configured, the following was
> observed before the fix:
>=20
>     root@rzn2h-evk:~# cat /proc/driver/rtc
>     rtc_time        : 00:00:19
>     rtc_date        : 2000-01-01
>     alrm_time       : 00:00:00
>     alrm_date       : 2000-01-07
>     alarm_IRQ       : no
>     alrm_pending    : no
>     update IRQ enabled      : no
>     periodic IRQ enabled    : no
>     periodic IRQ frequency  : 1
>     max user IRQ frequency  : 64
>     24hr            : yes
>=20
> After the fix:
>=20
>     root@rzn2h-evk:~# cat /proc/driver/rtc
>     rtc_time        : 00:00:25
>     rtc_date        : 2000-01-01
>     alrm_time       : 00:00:00
>     alrm_date       : 2000-01-01
>     alarm_IRQ       : no
>     alrm_pending    : no
>     update IRQ enabled      : no
>     periodic IRQ enabled    : no
>     periodic IRQ frequency  : 1
>     max user IRQ frequency  : 64
>     24hr            : yes

The output of the tests could be dropped IMO, but I'll leave this for
the RTC maintainers.

> Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Other than that:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--HEePT0xBzTmUrcbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqIagoACgkQFA3kzBSg
Kbanig//alOlGkCyf35IsdJBWIIAPBCYVu57zK1+oNcGjQN4NSHA0Vv242bkQvga
VVCDonOLfK9Ej7YKBB9t1tqa59eosiW9/bqSVCnqC/AmQHnjnF6RGBOdbIx+KR9Q
8+lePfPtN/hbGAy1uCzT5uSNY06JaZ9/kNxUNv0BqPQX4QLzwjvFiZSk0SPAQ+0u
oE0n9HLlm+AIrlR2Xy/h7vN9rR5W+lih+fiW/kt9CsV9QDcPyjU3qD8FwXFIf038
EX38SEVd02xqgCOqQV/lKQrJMxgmQlCgyCoVhjhhnBCFU1FDO5OfzHg9xau60npz
eMvHFDPOKZZK0SPCJW2eFE5LOXSElO8btK2WFtvOCMsx4b93284b/7YtWX92o89s
/IR2lzbFdMhrxPE0UP5E+RjmtG6Rf6vLiics90h+VBNtCFeX/TscGrA0n+KYt1ZH
+kA3IusRRhIjkbAz7Cu/LWBHiGE//nqGDi7uralGJ43/svARimBLomWoibPx4hlP
RpU3yvnIBV33O8WKjBPUG0Jsfo/w7gaP7SKGjtGo8JSX7HXNlJrLxWnU85/PChkI
Yo0RjHceJo+Ab2b6UWKlNYbcj3UNls7B8QaurZzSRLHxc+zMvjjXRFbgGMAkvJtM
I6nP8fbgguyUXsLJ4Jayr2MPOZQLpSNdIZZjEGM6OKivx0DR3MI=
=Mil6
-----END PGP SIGNATURE-----

--HEePT0xBzTmUrcbY--
