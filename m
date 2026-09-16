Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EBB4D09E0;
	Wed, 16 Sep 2026 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557777; cv=none; b=pGX3A/3LS/nih58p8Ew8APScs2Rqd+pZNU8HLI34nAlWCAdkDGMbT2E5eqfRGBws691ysnu44qpw1wuXXVu+o3H9i7ES/pvFwlUbvPGicAzhdtfj1Rc+KeD9fHm38dLEbvel5lAUXxZH9d/va6zBOFW69kl1xeBmDA7tQxQUXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557777; c=relaxed/simple;
	bh=HaDup1zqLAuloj9vagheUeO2UyYUCSBAeeryA6ayQcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK32KSeJN/zqlBdAupI7bD1vpk21uHn/c6Kv2cJpxqdqNn0X4UqAQUGjDRXX35KxISSccE0UnQBi+gp2+d0lkAXrp1XjoJ0Ajw/E1fIUo7o3hoRzUFAFhPiqKoMoC8IeTXaVGcvR0ZlvjzgYfbko8+w7Ec2EhDShww91c32x9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUguNGok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUguNGok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599E41F00893;
	Wed, 16 Sep 2026 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789557770;
	bh=Bv9caHK0L3VnjzkDAa41MY/MJExPJkSpdY12LFmTBZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JUguNGok/rnJzGOGXcCKwTaEO9+sBhgPfVld16HUMoI5e/yplK7z8WDRTuemXMzbU
	 MpzTF4953JBUCMNYt87QkDPjzNC5Che539aqreL0nSm+JWMJZGrOvnH332cE7RrMYs
	 UK2NH13HMXevazHmGMes3wU7iZuFGaRxkxmQ5C/HT+HKfO87JV/Rmz5liwR8rvHz10
	 FjKW13iFqn6i3J3g9K5O5pEmnnvoPfJB1oHz8TajHPeukNF2PwQJzp4WScvYL1IYiN
	 DeTrGHgxphyrG+7OEZbCif3iJCgNcAEhR9T06uMEE66ntSHeLIvIlHBiXghDBMvA46
	 C4byX0bqGHN4Q==
Date: Wed, 16 Sep 2026 12:22:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: krzk@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, perex@perex.cz, s.nawrocki@samsung.com,
	tiwai@suse.com, stable@vger.kernel.org
Subject: Re: [PATCH 03/20] ASoC: samsung: snow: Fix clock leak in snow_probe()
Message-ID: <1a22633e-6264-4ea4-a6be-28f87802000b@sirena.org.uk>
References: <20260916070341.1965422-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZyB3ECWHltiMyhAD"
Content-Disposition: inline
In-Reply-To: <20260916070341.1965422-1-vulab@iscas.ac.cn>
X-Cookie: Double!


--ZyB3ECWHltiMyhAD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 16, 2026 at 07:03:41AM +0000, Wentao Liang wrote:
> In snow_probe(), priv->clk_i2s_bus is acquired via of_clk_get_by_name().
> If devm_snd_soc_register_card() subsequently fails, the acquired clock
> is never released, leading to a reference count leak.

You've not copied me on the rest of the series so I don't know what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

--ZyB3ECWHltiMyhAD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqqfAQACgkQJNaLcl1U
h9CZWAf/YsKKjzdxqiPRs2SAcU4OvqyZ+mVhxVFcrOXRsAlpjdRm9NV2h9OaB5Ko
qGZZAKaOal6iYNpZH0ye4dCf/ncPDV5sKNz0HR4s1w9hzAAShknFPuausbtfmr6o
XPTBS1LajEZwMxO0HSU2etNjO5xNCO70kJqP0yCpFmNcst/l1MI0XJMvjPC/Ro1W
B83rnfFQV8FA0xTLZHpT47Vpa7x9IJlqyx8OeKNbNEMmBKaW2czxfsrkliD3HFCq
QGH/OTqNeRLcS+qzC7ldzlOq+ch+a2kXr6gpXFeg1Ro73saQ+EwEHuw9LztU/HJC
+WJdTu0JF9R3FFTwH/UO9YosSpoGkw==
=jgHW
-----END PGP SIGNATURE-----

--ZyB3ECWHltiMyhAD--
