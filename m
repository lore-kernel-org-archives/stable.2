Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB874A1E19;
	Thu, 17 Sep 2026 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683846; cv=none; b=hV2gX+gfPN3gaBbqm1lrs6DIMoaGJDA4LVCjLHMuDS6/Obu8UHBQ91SCyVFaT6OBu6cf/Z6lu9wlbkixHklfXyE67QEcTpVwdBR4Hx9he3mSvnx0Y0Dfo7fvvLe17ix8WqKgDFHovGM4/kAHR8eg/OdRoO9GnaYlPTkFassIaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683846; c=relaxed/simple;
	bh=DngOUU3PrpW3GHcTycPXn35MuZ0jXd3DuXkkv2n28Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu7DNlWzcX6ZFR9L9BnSb6ip2qnbehZxcgQcMGxEj91k/eWKpx//ktZDECoASz3/c4jZ9lyKhRR4ISrgB3iD4e0s6R8Mr/gqRoMiBLq3U6WJiWtTna6Ky9ktuPO4xea0HjFeAOmF88GiRj/YfXARqmfTqmaM4hMMTODvCCSmJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5Rp/lhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5Rp/lhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619271F000FF;
	Thu, 17 Sep 2026 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789683844;
	bh=DngOUU3PrpW3GHcTycPXn35MuZ0jXd3DuXkkv2n28Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K5Rp/lhgLcEVaZt3CCRwiyw1e3ah3cPvX7BX8gLC6Aer0eMbtZBTIvVki66+sP69o
	 tQhfkrPCTGH8FqMfcd1aC7a3GpalCRCQMt95YcQbmBklFQjpIunAEQEqjWLIEJl+Av
	 DUuIm73i6GB9tdHv/zG85LtXxoYvY7jVvqSPUSlnJW93po4B8dFLeHBCTF9YH20LEW
	 vVDjzIwFPcC1AUOX6aW7JQDBCqHvC4NnhwYG3CYZEel4ms86+p9xja+NQ4EfmoyR7+
	 Ir8kJrQyUCq2WGvAAxgTCHZAhnp8n4B0caNuooNJ+LAaSmhPYDg/TWuilC4JUdHsid
	 m3NiAR6OuzfUA==
Date: Thu, 17 Sep 2026 23:24:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: hansg@kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, sbinding@opensource.cirrus.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: fix controller reference leak in
 acpi_spi_device_alloc()
Message-ID: <01e2065b-8ebe-4cd3-b80a-bbb6e7719873@sirena.org.uk>
References: <20260917154826.2160933-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oXuJvBPixL6sPYYC"
Content-Disposition: inline
In-Reply-To: <20260917154826.2160933-1-vulab@iscas.ac.cn>
X-Cookie: Whip it, whip it good!


--oXuJvBPixL6sPYYC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2026 at 03:48:26PM +0000, Wentao Liang wrote:
> acpi_spi_add_resource() stores the controller returned by
> acpi_spi_find_controller_by_adev() in lookup->ctlr. That lookup takes a
> reference via class_find_device(), which acpi_spi_device_alloc() never
> releases, leaking it on the error paths and on the success path too,
> where spi_alloc_device() takes its own reference. Drop the lookup
> reference when the caller did not pass a controller.

This doesn't apply against current code, please check and resend.

--oXuJvBPixL6sPYYC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsaIAACgkQJNaLcl1U
h9D/Lwf+OTtUmiNxcWSVu+1PsZRS/ZISuDSrS2QSxPLZKRGC78Huru9il2pqqVIa
K5HinymltkO0gMOZdW/zcwBsOobg8JnCssx5m6Tgl7EhByhrVuMGYQNotjj+FcBU
h7JlzhJcJJ+613c1HXHcukTCIIlyUv7fDrVyalkg2yNgA6gWDiTSVj6VVLzy1jO8
0Q7JWqcO1TnUpSco/AsXvsjibWu+8jUVpBWTJSvNvPdKS9+GPe439sW9a0+hRjzU
PfbROJkJ5Z8ltuIm+aRiwiO2mLyuEtn9gD7Gw2EB9qjP/+NxPsZU8DwYlgNrZB9t
h7up/mu7yr+J4e9PlMOHKbAVFon5Vw==
=cUqX
-----END PGP SIGNATURE-----

--oXuJvBPixL6sPYYC--
