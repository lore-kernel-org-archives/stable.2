Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777154EBAC6;
	Thu, 15 Oct 2026 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063693; cv=none; b=WMwIVvRqWr7PTIvWkGGOSQy0B/0erddXWtUlV5crAdtvZV2wGyoNJ8Ny0py13RiCSnRYcejYMLO0oo8+BX8YSTZfpTIzjJ0MXdcvKvXdNSUxrjLeqYrkW+YrqOw29vQl/RwdRMOfABA6c+n4MUVnaZkVIer6DCXfJrOZFeSzEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063693; c=relaxed/simple;
	bh=vN8crsMLeMURqPwrucsHxLo2CIhLz3ZK0+yNKV6oupQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq1qV0NTrdJzf68RmAxDosVUnUXTAFnzdnJWCFt5xoMJsK+mz0KNThij7iFhUFwnUEQJO09LR7Iz/Pi8/hU44N5T15GCVTT9tHpSypNwKelDirND9wa0ENfIcGEvy3kRjzhCrplMagNyeEua0o3JT7+YVcE2XgMdTdEre+EwP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqRUzdfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqRUzdfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C51C1F000C4;
	Thu, 15 Oct 2026 11:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792063690;
	bh=u2QYkuWc9e9/YKClMJHSyEAYi24qLkOSIRtRLWYuFx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hqRUzdfgZvZBaBWVqhsAJ8qZmt35+6a3x133Ifa8+nXXp9ANkqme7QADYpe5pCO9q
	 t23pWjxwzhVXgD3/sjfqtuCEAaYcnD2Ag7IVLcIbh/bHx7y6efj/wghtt/63StEy+a
	 TvzwB1dV785FmgzvuYdhDThAWvihK+WFETYDLEgb0bPL2QgbbS0XcuRw/sAMlPZN6D
	 VIkx32hzk36pUyA+e+oXqgCrilfH5l6cg5y+jImjXr29L3bRPMTM2h7JBJV/p2okjq
	 5fu6+n2ur4NB7S/nE9Iqc/jZP5DIismkq3jw0ziqhnnPPVe0bDKM3sdtXEwlgt1ohn
	 ObJHJodOVQahw==
Date: Thu, 15 Oct 2026 12:28:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: ldewangan@nvidia.com, linux-spi@vger.kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, swarren@nvidia.com,
	linux-tegra@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20-slink: bound copies to t->len
Message-ID: <e81a1b15-cc89-4db3-97bd-315e6d5bf3ca@sirena.org.uk>
References: <20261014-spi-tegra20-slink-copylen-v1-1-0ec779a6357e@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dgfhA1QFRLLUhNsN"
Content-Disposition: inline
In-Reply-To: <20261014-spi-tegra20-slink-copylen-v1-1-0ec779a6357e@xiaopeng.com>
X-Cookie: Tax and title extra.


--dgfhA1QFRLLUhNsN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2026 at 10:18:16PM +0800, Weibin Liu wrote:

> +		if (nbytes > t->len - tspi->cur_tx_pos)
> +			nbytes = t->len - tspi->cur_tx_pos;

spi_bpw_to_bytes() - 24 bit words can have padding.

--dgfhA1QFRLLUhNsN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrQuMUACgkQJNaLcl1U
h9B4Qgf/Z2ll+eWiEnYdFjH2tp3iKcGa0d9Gdo6GKXCWrelStsrUiHGT+KqSnTy1
s0y5kTCdmgR2NRxh8XLgD36ttHv3eok5KLGCKGzze4MIEHBHJSpxXzuLc4CbJHdA
0zWaDa2G/uFbuEPb28jl6/h9O66I+arG22nzJKAUiRq+dQDDxTwbdBhUEF4OL/NE
SKbQ+8kS0EjQ/8nOT0dBpY3XTHtYlXPYsGPIQibq/5dYbmkWoBv5Bfn3Grdvaw1S
moOiuV1qPNEWO2WYyLEA2bl3IP0xnegq5efvZDhKZQ/BrQwYEPwLCbTaLKdDR2Cz
LWFio3r8eE6UR5JIW7Ft2nHfX28WMw==
=w8m4
-----END PGP SIGNATURE-----

--dgfhA1QFRLLUhNsN--
