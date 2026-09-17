Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA393DA5AF
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626099; cv=none; b=ELBlMZuR4/KqekffQxtoOq3r6zXwjzRvuDqzNEemxov8d4JDFIFpTZSPNqS4CtaXKDvsEWGIXRuDXEW9WhxkX+N5kmS7k26CvyAb3WeASlyGHK0wdfk9kN6CJuJItYNS/GE2Xx6XxjobJAabJriYOpFppIW73wmJqMTh5jZn8TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626099; c=relaxed/simple;
	bh=DyGM4eKCpX0oFdU/kC7JOPbgVB4Nf2f+nkUWqwsDaEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9jIvH5gqt9k5EP32lia10CfIj2g9LHyusrXGqCqsyqxydkgahMD3To0uInuTpZUiKbkHBfScQMcEm0Kit/q5Gfxk84pglWl50vhLd42BDBbfcvobf1qLfsb11VNGWkLezE6lbHgOipbxo63q6FESlw8nIT36+QcfOttF/+yk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RIzMPkB1; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RIzMPkB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lpp8
	RfFAA5K/P8yPpq2eAT+Rs9fG81TGsq4OC9q6tg8=; b=RIzMPkB1M/i+XwLLe9B5
	X1B12pGSO1FLk3NWlRHP6Ush+JtBK+lqcUvYND9j7in/VlS5CPFtpgfqewvbASt/
	1ArRZ01qf+mnB9nXf+L0VFj0+9yF4ISy8CZDr+G5goRzTLRFF+bgEXZEJBM1g+E1
	/k7pF/ZWYz/t5SyZfQww0y5fVtwzSZI7D/BTjDhLZCh47gLgrSOWUHEjPtGWY/t/
	z4JEwe5nQe488UIprwCEKo2ixlA00lAnt/JQNjYb10qXEdrawKJ1Du60RcwCnr0o
	EIWneFjGsWqcANpnwPiMecNfh5p8Ucpricix+b6aS3XXGjJBzwaEkfMFKX5xkOoK
	hw==
Received: (qmail 1872352 invoked from network); 17 Sep 2026 08:21:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Sep 2026 08:21:32 +0200
X-UD-Smtp-Session: l3s3148p1@dkyAy6dbBOQujnsL
Date: Thu, 17 Sep 2026 08:21:28 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org, geert+renesas@glider.be,
	laurent.pinchart+renesas@ideasonboard.com,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com, vkoul@kernel.org, lkml@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] dmaengine: rcar-dmac: Fix runtime PM leak in error
 path of channel alloc
Message-ID: <aquG5D6mspgqjRr7@ninjato>
References: <20260915035602.1724403-1-vulab@iscas.ac.cn>
 <aqrtPpSO-FOnUZZx@SMW015318>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MNiQ2dFXZM6vZHzB"
Content-Disposition: inline
In-Reply-To: <aqrtPpSO-FOnUZZx@SMW015318>

--MNiQ2dFXZM6vZHzB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 02:25:50PM -0500, Frank Li wrote:
> On Tue, Sep 15, 2026 at 03:56:02AM +0000, Wentao Liang wrote:
> > [You don't often get email from vulab@iscas.ac.cn. Learn why this is im=
portant at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > rcar_dmac_alloc_chan_resources() ends with
> > "return pm_runtime_get_sync(chan->device->dev);".  Even when
> > pm_runtime_get_sync() fails, it leaves the device's runtime PM
> > usage count incremented, and the negative return value propagates
> > straight to the dmaengine core, which aborts the channel
> > allocation without ever calling device_free_chan_resources().  The
> > balanced pm_runtime_put() only happens later in
> > rcar_dmac_free_chan_resources(), so the reference is leaked
> > whenever resuming the device fails.
> >
> > Use pm_runtime_resume_and_get() instead, which drops the reference
> > again on failure and returns 0 on success.
> >
> > Fixes: 87244fe5abdf ("dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA =
Controller (DMAC) driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

I'll take the liberty to add this tag to the old, 100% identical patch I
am going to resend soon (together with other patches for rcar-dmac which
fell through cracks)


--MNiQ2dFXZM6vZHzB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqrhuQACgkQFA3kzBSg
KbbuaBAAqLPNcCdcV6luT7lunE6knLUniuRdjoJ3Ch8ONIhZ5ZP2Y21+HzfYuvyt
BJqBsIlVoNXeFTIlS/GRcp+y1HrbH5ewb1n0nM3WWBaeng+aCMRrjMVnZjdAr1nr
STGbpcT1wmIpij7sHon6FvUq0e6wXy0HXttF6Xr/nuX6RpqSSkELPkd4CzhJF6+8
z4rAJjfP9NOqxt0p3nT/c9fGDFp7l5SqBRO2Nh1XZd0CYjNJA5oONugbQHt9vsSA
0lueK4QdL86XKi7mKWQzIBX44xjwA83oG19swqQ5IIcb6UhIxxggbBXaCtfMJLoP
wrKHPA64nCx+zP8JBn5stxrSk822fMTYNMb+f/rLoPiwIAnTnDLjvtQ/PLjm1tn+
N0gjq4SIp/sRav4BI9hKvaETTysD0TfRgkR5WBiPGs3ir6iV+lORoLulkagoIrIJ
K8FSFFCkSQWdCDF0IqlMknEBu+OJs3J/47rmP3tbSa3W8raOV7jW6kkmqeuBIXmf
CtWZ7y1/x15Aa07ASI+U8tq+H+QG5YIsfcRUpV9Xu2jJbP9A7WFJYKIlaYSHYVgZ
sc3OXYnrzCvo/A/5a55T5Adu+ds1LqBW/7qGb+HEavQx1nxK648qOQ2xr77WXQUi
fvHSAJPfTA5lKapnBmNyKh/J7sa3/7eFA+geQM88YaCQ7ZF6sQY=
=GKwW
-----END PGP SIGNATURE-----

--MNiQ2dFXZM6vZHzB--
