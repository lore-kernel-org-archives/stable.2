Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651045BD6B;
	Tue, 30 Jun 2026 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852882; cv=none; b=jNRwxexfjecoz2JS/lQD2mNEzumysQEolwamsJtptwwx283TqMgG7TXCTp7GzaAJ8kKyT4U0cChDvdYXYB6EjQwmjobmlmSKIr0GR/U/TYqmF60VBLiHq/2Yt0uef+USAyObVJrRV++uekeVFcpVU5xvBf+rpSp5VezFLHWhpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852882; c=relaxed/simple;
	bh=h/Ko9ryFA0kdOa/QuBwHffhuwU7NkBbhATHXPdJ2I34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWbMEcnwZuSZhuZ1T3gEeFhfegEL+qX5mnbpZQ3qwivc7UJHOANoj7ZP4hh5Hn2SKwBdlOoiad7fitEhqWNlfbOxzb4VAqai7Ea03qINyRLBQtuzahPFVuz+OX5ljqeSWINVIeXgv4HwRC3xnfeh/ea/WFnkqQL+81lanvwc+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYIgsbnZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYIgsbnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846451F000E9;
	Tue, 30 Jun 2026 20:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782852881;
	bh=aQrxMNIEylEiuvbRu+mi8pKFW2mloJnu3lVQOjwjvVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UYIgsbnZEVH13QexSvFBS8CuQHYP2Rajo6+lgx1+s2OpYeWhMdnYNYDL4Ac/wprkS
	 jQVrnpo/FGJAwPGpsrZy8K1Of17P22pIsN99aFiOKFjrRlYRPNxoHfmy/O4g06pleo
	 nGEuC6Go/z4VDH4nin+Q0ajgRaSjAxG0/3FOplD2p2D7VQUs7Iwo5SgsRK1w5V8CG3
	 kAI27WQNLVr0KGcVE6Qzk1cNQbPlAclFlWWyIsZpIAIHq4t8T90dw0M85jKXRPl3jt
	 VnvYNiGjNBgV7HqEKZ4GKgvFvEbMswsuryvLBQehLdOoT+FtJWsxMzxxpn46+odxyT
	 TBDt2id475V1w==
Date: Tue, 30 Jun 2026 21:54:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org,
	Valentina.FernandezAlanis@microchip.com,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtc: mpfs: fix counter upload completion condition
Message-ID: <20260630-travel-aerosol-b388e50a3ce8@spud>
References: <20260513-panhandle-ashy-70c6abf84d59@spud>
 <CAMuHMdXnkeantjtoMg+3unfP8ZSeG+7K+EGkn48=BEi_RWENwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OXEFPVIeQvMmHWaa"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXnkeantjtoMg+3unfP8ZSeG+7K+EGkn48=BEi_RWENwg@mail.gmail.com>

--OXEFPVIeQvMmHWaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 05:18:13PM +0200, Geert Uytterhoeven wrote:
> Hi Conor,
>=20
> On Wed, 13 May 2026 at 20:04, Conor Dooley <conor@kernel.org> wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > The condition that needs to be checked for upload completion is the
> > UPLOAD bit in the completion register going low. The original iterations
> > of this driver used a do-while and this was converted to a
> > read_poll_timeout() during upstreaming without the condition being
> > inverted as it should have been.
> >
> > I suspect that this went unnoticed until now because a) the first read
> > was done when the bit was still set, immediately completing the
> > read_poll_timeout() and b) because the RTC doesn't hold time when power
> > is removed from the SoC reducing its utility (I for one keep it
> > disabled). If my first suspicion was true when the driver was
> > upstreamed, it's not true any longer though, hence the detection of the
> > problem.
> >
> > Fixes: 0b31d703598dc ("rtc: Add driver for Microchip PolarFire SoC")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Thanks, this landed as commit 9792ff8afa9017fe ("rtc: mpfs: fix counter
> upload completion condition") in v7.2-rc1, and finally the endless
> stream of:
>=20
>     mpfs_rtc 20124000.rtc: timed out uploading time to rtc
>=20
> is gone!
>=20
> And no, it didn't go unnoticed, at least not for me, but you couldn't
> reproduce it reliably before:
> https://lore.kernel.org/bce2ca405ef96b1363fd1370887409d9e8468422.16606594=
37.git.geert+renesas@glider.be/

Oh wow, old mystery solved and not "unnoticed" at all!
To be honest, there's a good chance it'd have been investigated more
thoroughly sooner if I had the driver enabled, but I don't given it
doesn't hold time powered off. I'm glad it's eventually been solved
though.

--OXEFPVIeQvMmHWaa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakQtDQAKCRB4tDGHoIJi
0sgWAP4jbyx6hOerjyjYq7eL8RtI6ZlQWHOUAxEGAqtrcO9qkgEAu9Za9S2JFsqX
9Z5tWs1QiNlCYgiEy4EpJiqmp9Ww8ww=
=jWyy
-----END PGP SIGNATURE-----

--OXEFPVIeQvMmHWaa--
