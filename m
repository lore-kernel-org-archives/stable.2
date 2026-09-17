Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B645000;
	Thu, 17 Sep 2026 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673192; cv=none; b=EnDuJ058wLlDYgGu+tk98IF392uvn3CNVNI8mjIMPu+HqkNgqissCX10fhQOqmS4K/FTFSjJtwLEWLihXXnOgWodURpnAE5mmFg3CgTwlpNa5tqY1cx7F1XKWR568r0faX6vWOiKw5+NSipZjjAYdHQZe8NWPNEoz8HoraN7smc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673192; c=relaxed/simple;
	bh=Qf1AZOMSNPm88DD7zm/w+hkzAH85hv8IxYPg4k6kP9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5NmI1zpYlTUcvvvc/dZ6/ggHHY7gb8B+f61G0JuL0YvXDIhOoHDAUaKOqg/Q0UzKq0rb5OsRWLcQLMZAlvRTZTBcBrXBpUZ7eQGIDd+6SED6z22KBST0f9ToR33s3O9a+dFpR+7m0uqKqzeqEjGj5WLZGIbOqUJtTfWuhSavb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgFeghw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgFeghw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D511F000FF;
	Thu, 17 Sep 2026 19:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673191;
	bh=EohvFW/DX/OCfvm5BNeIKSJyQzTePfKgRjq6Rl5gSi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PgFeghw80yzxuV+teSYq9A4h2csWyy++54MeJTew6As66Uizfu+VGJbiV4JNfjI6P
	 tjy24IXR54N+4hRXNb4mjeQMx1EzGmZl7RppbIvEbAfQP+vBkI9V2kXVUrUNA6NbLY
	 hcuKX6vnalSAU1QuchAhpq/JyIVjHCO1tm2R/G5rd/ekwg9VWYXO5xi5PsWWyMN2al
	 dEistazRWXmjhB+gCfMvWcjG2+3kXvVzgd644m3WCXPpbiM0rktJ0GX4lteMS9ZQLH
	 pBgFI2kx2JImE1Q9vEJa9z8dkhYwQrQcY+Otc+6wLLG5V1w2cRD45jUQyHsqsI4ke6
	 9FZvjjsCikpvw==
Date: Thu, 17 Sep 2026 20:26:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>, haibo.chen@nxp.com, han.xu@nxp.com,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, yogeshgaur.83@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: nxp-fspi: Fix runtime PM leak in nxp_fspi_probe()
Message-ID: <a06cbf19-7b6f-449e-afc6-b9cd71c35d42@sirena.org.uk>
References: <20260917153713.2160743-1-vulab@iscas.ac.cn>
 <aqwzyjKASxfxtxTT@SMW015318>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XbS0ckMo4J5m97Fz"
Content-Disposition: inline
In-Reply-To: <aqwzyjKASxfxtxTT@SMW015318>
X-Cookie: Whip it, whip it good!


--XbS0ckMo4J5m97Fz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2026 at 01:39:06PM -0500, Frank Li wrote:
> On Thu, Sep 17, 2026 at 03:37:13PM +0000, Wentao Liang wrote:
> > pm_runtime_get_sync() increments the runtime PM usage counter even when
> > it fails.  If it returns an error, nxp_fspi_probe() returns without
> > dropping that reference, so the counter stays unbalanced.

> use pm_runtime_resume_and_get()

This also doesn't apply against current code, please check that when you
resend.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--XbS0ckMo4J5m97Fz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsPuEACgkQJNaLcl1U
h9DUNQf+LC9I8II8BgVGC52r00mERqYPtJp1GvujYTRIZ8FYrkoSVgSQQ9IXudX6
x9gwAKX/h+A5V+BsvFzbTwHyroNkrWNbo4hBX94oG3p+E5dRlf9D2ENsQx+IXfa7
0NH0BU5lemFczXOCb+VwSU6T7/UDRC/mcyaV08xjCZCd4FyV0YlCFk+HQbhjL/Cs
bxvgSXN6N/gw0yiqms4bi+yhu8WmHpS96n0+dL0QcUDimuuDniKNg114sQEipY/j
pqQuIs7lpidhGek5Q/srvPj5zsUIeYxIY2xGzhQXH3Hgzd46z3/1KyUsUOalfFaz
o0ptfZiVBFEKcjETVt+6PRz7sts7tw==
=vE4m
-----END PGP SIGNATURE-----

--XbS0ckMo4J5m97Fz--
