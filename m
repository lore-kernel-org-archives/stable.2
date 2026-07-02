Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA039A7E7
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977915; cv=none; b=by5lAQsc4SgfbzVM7QOKk0fTf9AS6lmti1d/9y53roDnW7lBC4gUxSQmbHaENjFGwo6AT+Aq6OSmEc+zTk8kqnQmQ6gDCy0dgjsGdo0IaqjfmMAd7vcawku/cRZ72DUzqXvU7Du4LVC0AqbIFKrrVu6PhhiyR8KnYN/xVhrXl54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977915; c=relaxed/simple;
	bh=SVYy/kAB71zO9r41iE0OF5XPAjDAV0RY4A3rcH+m2XM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=qkGXs86KK1sNSAlIm1DMpjILrcZShd8ZFdJwi7wa7znPBYHvk8NEg0jFfTKdglzdMB/E14J/HFdUUfUIPol2Wcg4tN5qxtssTCVGryNXzlesG5I2osTxJGIJLbR0t2WO0G1NG3JZXilvAu1eYDNnM8e6sJwe+/kX/mkY5CILguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZi/lw3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZi/lw3y"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F36151F00A3A;
	Thu,  2 Jul 2026 07:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782977914;
	bh=SVYy/kAB71zO9r41iE0OF5XPAjDAV0RY4A3rcH+m2XM=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=SZi/lw3ymY5+oH4pIVknJkew5GLxNj0DZOG/qXudljPARMR6rxk4gDYYXRFDdy236
	 SCnQlOGu7jiKJP1VqWKOxZFngL1iAjM2vYUc9Uq+UCagfgTqgs5JkJ6WSwn010IsIl
	 wXRCTJp7Y3rmOzj72BwD9w1IvxLcmQn94i4xi1b2SClM6WOvHxFLK/PD6qd+m5BZDm
	 fFFkwhlwA6iHY+t/4F0EagYoJzkqOn21uP4Rf38VQukyodxOXYE8YFmteVSBNNO8wd
	 s039fiQlXcvMpLENrj7p6JcOdOE1/Ajt2uSJXy5tG0Cqu2GKqDUiDOjVTniXkdPkjg
	 psACam98JsMDA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4ec6414e26803d0253bc75a898ab2f13722c7d6a6b9e2a84d35a14bfb691;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 02 Jul 2026 09:38:27 +0200
Message-Id: <DJNWX330PGHM.3IXKZ7556X5FP@kernel.org>
Subject: Re: [PATCH 6.6.y] mtd: spi-nor: macronix: Add post_sfdp fixups for
 Quad Input Page Program
Cc: "Sasha Levin" <sashal@kernel.org>, <stable@vger.kernel.org>,
 <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <linux-mtd@lists.infradead.org>, <alvinzhou@mxic.com.tw>, "Cheng Ming Lin"
 <chengminglin@mxic.com.tw>
From: "Michael Walle" <mwalle@kernel.org>
To: "Cheng Ming Lin" <linchengming884@gmail.com>
X-Mailer: aerc 0.20.0
References: <20260701023619.2730136-1-linchengming884@gmail.com>
 <stable-reply-mtd-macronix-66-20260701193800@kernel.org>
 <CAAyq3SY48RRSO1nN-uRH7HVnXbnvQ1_K823Lc_hRsCyVuf9L3g@mail.gmail.com>
 <DJNVRMSG4C6K.34EGBE463IOCZ@kernel.org>
 <CAAyq3Sb6d4xtp-wEwM9EhMo5OSzjvsh450JcwyeEOh2NeLrA8Q@mail.gmail.com>
In-Reply-To: <CAAyq3Sb6d4xtp-wEwM9EhMo5OSzjvsh450JcwyeEOh2NeLrA8Q@mail.gmail.com>

--4ec6414e26803d0253bc75a898ab2f13722c7d6a6b9e2a84d35a14bfb691
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> To follow your guidance, I will prepare a v3 series.
> My plan is to:
>
> 1. Backport commit ac5bfa968b60 ("mtd: spi-nor: fix flash probing") as th=
e
> first patch in the v3 series to resolve the NULL pointer dereference issu=
e
> in 6.6.y.
>
> 2. Send my flash addition patches (without the .name field, using comment=
s
> instead) as the subsequent patches in the series.
>
> Does this structure for the v3 series look good to you?

Sounds good to me.

-michael

--4ec6414e26803d0253bc75a898ab2f13722c7d6a6b9e2a84d35a14bfb691
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCakYVcxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iZzAGAnNKF7MipXCXc9iWKoLeTIJ7+Y3nkq7sD
6JWd+NhoRF5/JsZ6ZxP256g6Qbx3LSOfAX0TPAtt2NKeg0GkjshagxLbx8lyumdu
jN6fSgNckkwss3Noi7n/RsZ4KKPf/4HubwI=
=K1qx
-----END PGP SIGNATURE-----

--4ec6414e26803d0253bc75a898ab2f13722c7d6a6b9e2a84d35a14bfb691--
