Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A8495059;
	Thu, 17 Sep 2026 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684200; cv=none; b=G0Vf1nJ7Es60VACboYlZKcNjF/JjR944VvYF+OCzS8fvaLaFb1I7wBSp13jEL9bTEwkwSvh2BKEWb5jllFqs+MfjHT4HCWV0PMX9cdQqiOCtrB4472nH8GGV0lFhSc8UUDFbl7qN1FKHJ5hkRh54+YOmIVgGFdcUJ9l7eOeivpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684200; c=relaxed/simple;
	bh=zF1jZ2y/W2JhFoI4myqzn+siVnTYK47RwOCQ1PPgOqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuvRf0Id/w+f/+DYhKg4IT7/WDQrE9O1BjIOMnciZP3BE55vK2G7RJwPCCmmgiVPp8YhlT6H956xDXTNgOktznHwB4O0hWpfWt4RXmpnXZZop0gjpp2od4JAf52V31Oz0vz9jbvq7eVt6KrKoBucTzS7CyDM0QwrMiuyowSnNoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3DrAFGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3DrAFGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695AA1F000FF;
	Thu, 17 Sep 2026 22:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684198;
	bh=zF1jZ2y/W2JhFoI4myqzn+siVnTYK47RwOCQ1PPgOqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g3DrAFGCXodJgXf8lrkUeFKFopTWa2xYEacf93xGv6ZYtyLzyqKtzaaDe3MVfDFqD
	 An3uxil+l8Uf4hVzs/Yrp1kg3B461zNoGzoIiRmAs96LnaDYhPdxoe9NniGragGqIj
	 ++L9k8HW/31w4toD9phIV3nZHZcCddEBiYL9VIrsD9PC76xCRrvyzBVwmnPgw5Ti0O
	 lyvJEPlcSUmKkk0X/uOGuxgBjyLlLu5J0VFp6O00EzFu+Nh97JEKTS85orxDXcxrpE
	 bAEby48luqnTPVMvrI1nOmmUgO+G5XK7RY4D3dToafgBREG2C7HkKf5SX0F+OhebN5
	 FoxD/BXF1NVCg==
Date: Thu, 17 Sep 2026 23:29:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com,
	perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Fix codec device leak in
 fsl_asoc_card_probe()
Message-ID: <1ff14ab8-fa35-45c3-abcc-1075a848be2d@sirena.org.uk>
References: <20260917165654.2163461-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="daAMsHLhBjcveUdx"
Content-Disposition: inline
In-Reply-To: <20260917165654.2163461-1-vulab@iscas.ac.cn>
X-Cookie: Whip it, whip it good!


--daAMsHLhBjcveUdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2026 at 04:56:54PM +0000, Wentao Liang wrote:
> The codec device reference taken by of_find_i2c_device_by_node() is kept
> in codec_dev[] and never released, leaking the I2C client on both the
> error paths and the successful registration path. The same slot also
> holds the reference of_find_device_by_node() takes when the codec is a
> platform device, which leaks in the same way.

This doesn't apply against current code, please check and resend.

--daAMsHLhBjcveUdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsaeEACgkQJNaLcl1U
h9AKRAf+I5U/zFfzbOfGdHHHyloZBavITTecgnUthXRxd031B60RwgXz4kFI59vb
GLorypBTYwytxvXSpg4SrNRYJTjDz2vD8o7oGPjzTDn7Hwb4ZlaiywYisezZqg5C
KOP9AZfQgIRao95uGpkPoH4EVi86dOUYUbUaU6z16GLkbPHI54svv36Y4qbTTi8I
SpBGBEOAu7rm5FJdTPg/eZtFuO3bh2Cdggd7oh/Q/oijLlaOt9MhPrHHP25CSD4W
kjzrjfmNBaQUnOD222LZd+aMQLEVrekPGwLzY00dr00z54kt70JB88frXUOuILji
2R4OnnuUVOMnwhpYgPyv1bRJYkADtw==
=TPUY
-----END PGP SIGNATURE-----

--daAMsHLhBjcveUdx--
