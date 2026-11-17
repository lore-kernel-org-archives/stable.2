Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916012;
	b=YS9tmXJ9DpmykObSyxE8hvJ/1GA7egAJ2ac5PwmRg88dMU0CmBAiD3JNHjfpQuh62L6a
	 lGQ0fhQO7/KCsoCurtNhQlCoipUY4G3eovPKFmVlsu2ETegV5a3lS59a8wBx2G9ZdcWdu
	 eZn7w5/7cDEwYnciKgDIFM3i7ZoNJgqlnXsujuUFxhw2DxgkansUTop9twjrRITrffFSx
	 TYo2iYWLzlw3qt35R+CPu3IisxKQ9m7zWE5is7c+HlNGTFYPtFvoEDXdkh+rD95bX5UvI
	 VW/bR6wuzg3h4Oaf1EzL1wCr3+cJtQMawHcfvuVnB0C6amyVzmQFI7FLayHbCwVAyMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916012;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fWcihZsanqAN6UicgEb68MCZ/IaT3uQaNUiiRypTwdM=;
	b=gnYOmWx0SNEP38ZR1vvtLRpRyTltACPnMO58bn1ehXptXUY8FFCCq/huN/aIrw4tGxyr
	 la98PpykqyBv+lug2qGAIBvpfVy2ZbdSoKIzdov936FGchgg9Dys5Eb7dBbGQRSYb+Hke
	 v2CSdni3G1uVF+WGhLLohV5/9ei5IxEXoLPwCXxb51vWYsxZ3inYKQUUm7qzE4IDVFP2l
	 GUCRQ7rtau7pQligEU82sPQBh54oIhhZAHIRSk2libbsYcJx1ZNeWixRvXUZAi6gELbH3
	 wXq5a2Z9Q72L8dkPI2BS354FutMb0FRIzMD1mm2HDg1Xf/eMomqdxQVjC3iIY27eKow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+ZHZuc6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102F606A323;
	Tue, 17 Nov 2026 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+ZHZuc6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999151F000C5;
	Tue, 17 Nov 2026 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794916012;
	bh=fWcihZsanqAN6UicgEb68MCZ/IaT3uQaNUiiRypTwdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i+ZHZuc6vDULVrPpnArR0cIZeGz8/FIqQ73jgKLCgwh2E7dlVbhVfCgnvg0MULcMR
	 nv0RovCCsOtqy62mN7v4FoQTtOJlMr5FZg2vwwzPzOiR6cqwSWQKXZ9eHZkRgzrGTA
	 E2xFeeFWxCEWoR0TGL5frX3eHXuxlhZbNNmAHUj86hnnP/vFRWfep3uK6iWfhbFmKw
	 SZog8O1OLsMgUwwNE5xo78ucAlzidy93dhqJBHa8JsQ5Y///egKJjZcqSzDfD/Ue/G
	 hqnMmXL/rLdZT4KmEGPW8GEMCBsHLbzn+/fLFQfHzkX2tXNv+S2qLlT8y+mhD5sdIX
	 SuElDDLPArnxg==
Date: Tue, 17 Nov 2026 12:46:49 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <webgeek1234@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 02/10] pinctrl: tegra186: Fix out-of-bounds register bank
 index for AON drive groups
Message-ID: <avw8tOcBNMPwS_z5@orome>
References: <20261103213002.1673560-1-lee@kernel.org>
 <20261103213002.1673560-3-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i3edntsruv6eha4u"
Content-Disposition: inline
In-Reply-To: <20261103213002.1673560-3-lee@kernel.org>


--i3edntsruv6eha4u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 02/10] pinctrl: tegra186: Fix out-of-bounds register bank
 index for AON drive groups
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 09:29:07PM +0000, Lee Jones wrote:
> The Tegra186 AON pinmux controller has only a single register bank
> (nbanks =3D 1, indexed at 0), and all PINGROUP entries in tegra186_aon_gr=
oups
> accordingly specify bank 0.  However, all 51 AON drive_* macro definitions
> pass drv_bank =3D 1 as the final argument to DRV_PINGROUP_ENTRY_Y, causing
> any drive configuration read or write on an AON drive group to index
> pmx->regs[1] out-of-bounds.
>=20
> Update the AON drive_* macro definitions to use register bank 0.
>=20
> Fixes: 542baf77f092 ("pinctrl: tegra: Add Tegra186 pinmux driver")
> Closes: https://sashiko.dev/#/bug/linux-a9a7165c-c5eb-463a-b7b1-24a30416b=
33b
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra186.c | 102 +++++++++++------------
>  1 file changed, 51 insertions(+), 51 deletions(-)

Yeah, looks correct. It looks like this wasn't tested at all since the
time this was merged. I'll add this to the list of things that need to
have a test added.

Reviewed-by: Thierry Reding <treding@nvidia.com>

--i3edntsruv6eha4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmr8PqcACgkQ3SOs138+
s6H1nw/9HNOxm8X4P1MUJzierJCZCidCUXihoGxwFxahWDDG7Ctif5w7tlMyKfg8
rlkplkwz2xi8rm0j/w3icKQ50yx3JH6eVNAUkaAcdQRw3j/uVCwnW1JlZ7S3ilzA
8YrklDsup5I7asUAsTRB8b8Ty4Wiv0wpQ2eWV5iFcmzsEawP9vCuW5cTIDERCzvh
scBQR3F9kbPWHShwLn5C7eUtWU4lYviqrmgVE+WUtDhBlhTU0qH8o5xrX8Vryv2n
p7FzCDXDgJWzdyPQLkOx7Lr6bodM7EJ5iYbOKuOU0WORP0NwXSECjAidJMkTbI3i
mtw5YIGYCZ1Ff7uOPSJ/2399CWEfrgi8qYLvKiUUpZvfDF0ZklRDyhNHxWBz791M
HmK59v0ouBF0TEwmEyzF6SfwlLJXNP7xSr4dPsi606w0BbQSCbqBvCaRaQDisp6+
/r+0wvs4X+TZum+8sXVNhztXtlhRfQjXxm+nFvvPJi/l9PWQnSmPvnHqjWphUgSP
wCzmAsZhBqPuEQ30+FTggPQk+NS/xXS7jgmFx+wBIGXcy0VpAUyJKSvPiJtHzeGd
Xe0wxcFqO2PjNVm+4Y4Y3fGgN+G8JEm0aTCPgWMOe6+NrZj0PfpkirRX7zsfOJfM
h40AamWBMEoCPsRQn/SOfhZHLFztJc2yVczsCT+8gDXIRYJvuMU=
=q8RY
-----END PGP SIGNATURE-----

--i3edntsruv6eha4u--
