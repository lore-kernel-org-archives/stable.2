Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A52D12F3;
	Tue, 22 Sep 2026 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081517; cv=none; b=f32s30sEpFV8Nie10zksypwv+AM/uR2c8Sw9n/Zbe6pnVpsVZH8R8f2RTcLOIhJdgy7fSP8bfMgIWHZZN1h4bchU8PsMQDq+ylQZcSTi4tF1MfpyzP53Y/46azcFJ+PwAZkz7JyCVfcNzc58nEYLRDqaxeEglhAkx4Z2fqgD5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081517; c=relaxed/simple;
	bh=xFpxlzu1SH7kFoX4Fmr5tfR2CvWslninUOlAtwBKpFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2Gc0WAot6dIkeyCb/Y8MwwJgd7XZZlQDUnkZlRWv26VYfs386fe7zi08gM4sElzbgFGfNQq+rFk0OSE4b1iIZQ+2ysZBDgjd33fp4y9YHifR4PPdkWxxPinoUMQcr9JWJBEKvb5YsOu7uqXVj1MNIDyQiGKjxkFXJhwc35XSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvegNx+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvegNx+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D2E1F000FF;
	Tue, 22 Sep 2026 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081515;
	bh=fiMlgP1e00pJ9OYBpmJDP/4QtkAS97V78LW/zmFPMUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gvegNx+yhAzmeRvs+R3bUP32kC367DnxpOccZ0a9Ui3XILxfJ8BjbLuBhgPrxJkU6
	 nDfRDCYpBz6W92/Aoli556lGZYo6nAq4s+bEMdcY5u+to/vG9Y2zOI6D0o208it25x
	 aLC3kD0RlDS7zRJp4MzrZxnYzY7nVpOsaB7MW5z8ATZu6VeU1M7WIW9GIWEtdaNVB3
	 /q0sbGVkUFS8koHsZjdGqnkVqb4JAtSOS7UzP1UmgWAoMVJqCc5DrU8qo/rChVeLQr
	 a71nIpbBrkB+YbdEZnAIsirzeMhKmRAQRmOPAXIaJ802lbEFtjaSIgYZzfeaipeLQ9
	 LyFMi/XCihlyQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 877FC1AC56BF; Tue, 22 Sep 2026 13:51:51 +0100 (BST)
Date: Tue, 22 Sep 2026 14:51:51 +0200
From: Mark Brown <broonie@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5663: Cancel jack detect work on unbind
Message-ID: <arJ551jJ9cXjAua8@sirena.co.uk>
References: <20260922015327.637137-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PUUJfxvHa6/CLNO6"
Content-Disposition: inline
In-Reply-To: <20260922015327.637137-1-mhun512@gmail.com>
X-Cookie: Too clever is dumb.


--PUUJfxvHa6/CLNO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 09:53:27PM -0400, Myeonghun Pak wrote:
> ASoC: rt5663: Cancel jack detect work on unbind

This is an extra copy.

>=20
> jack_detect_work and jd_unplug_work live in struct rt5663_priv, which
> devres frees after rt5663_i2c_remove() returns.  The IRQ queues the
> first work, a button press queues the second, and jd_unplug_work
> rearms itself while the jack stays inserted.  Both callbacks load
> rt5663->component before checking it, and nothing clears that pointer.
> rt5663_suspend() cancels the works; unbind does not.

The same is true for the probe error handling, if we fail component
registration the same situation can happen.

--PUUJfxvHa6/CLNO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqyeeMACgkQJNaLcl1U
h9Dwgwf/VLJ6cIAOqVazl1MbSP9/a7PBF7lNHSPlmhMWbvpE6H1r45MExf3+QHUY
b2q38OILreuxCStw8dDQOAgLklqQz2aamyfI0spcuY/13nzztJzI4ufBJCyqGShd
SE6JC8z8emA1Ie/w64EtYuqLt8gAQvmwsjSSjBOs5IUCAz2/4KTzFCWbIV8GoucE
26nFwPNL3VChcnItHsiT4Qt7JgeLOuFngiK+fACeqsmjEZh4zuWMIW6BKzolSwYg
45Vn1Yib6lFJsp8nljixGCV8lUy/EGj6ILopA2KT7/jFQ/STzXL3GWUB+KV7mqlR
WpvI3mPupg9OCesR0ff9gN3cE9YwHg==
=nKgT
-----END PGP SIGNATURE-----

--PUUJfxvHa6/CLNO6--
