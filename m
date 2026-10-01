Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F763B19C6;
	Thu,  1 Oct 2026 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790836070; cv=none; b=gLbEKf+trYfI5jrkxpFRLI9R+nX1kTDG7GuEBT7pbA8nqJsv5cqxKSEI6hBbcGekrax9m0+rUao4ROkTVnzMILeWdl1KyTuqJwndpFI4q6DyFdHMefXVFfJRN+cQe4/GEYUgA81yJlHIILtC17tnHn8Yif+cqbG+xGNFpWlBbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790836070; c=relaxed/simple;
	bh=oYHb2oPsAejYTsgjuA7Lvl9i5BcQfTd0gd3gE339waQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiQBtqF2cb0S7rY/GB0kVGRBzurxfo6HomVufJC5ZxCtSiKXGm8EtiRUPodaqUt/P4ymY8qi3x4B/ZzC0siahTsDU/6TPXyu28zR6TgJDFL8XNtf1C/JG+2mmxsSSOb+bnbwp26MDilVgpQB7CIw36saeI5RhkJgE2CL0Eaf/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F946ULR8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F946ULR8"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2D9051F000FF;
	Thu,  1 Oct 2026 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790836068;
	bh=r2CPx4Pf1KhkRJ8d7Y2xOX9yFZxqZFrZ0p+dx0BeQAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F946ULR8rmlyOwkZs/oFd62UfkJGKAO+LW7WoXvLaXulDZRCx0/FnyavJt6R8/NhB
	 BYX8RUE4x36611USodHkcTunOP9BEM5Ona+OrUOFrrUQoGg0z958dZwN9om8otNo1u
	 gq2RCcBbGXHbOWugOMLhY0jPy23+Pv5E7gC1DbP68tScTmOWMatGkejL8zHp1ipjqZ
	 2T2faDBbQeMIkV1AC0wkS5mO0p1XRjMMrPsUmj4csBnKpAgDZL5VcaO6SZdh33wu9+
	 mHfoc9Rgka6kduLBXBMRExUmFMpXJwdpxOj/6vsFYE6kuJ3Nnmw32GcV/OrsTE7eaJ
	 qX/0oRkflmV0w==
Date: Thu, 1 Oct 2026 08:27:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: fustini@kernel.org, guoren@kernel.org, wefu@redhat.com, 
	a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com, 
	gary@garyguo.net, linux-riscv@lists.infradead.org, lossin@kernel.org, 
	m.wilczynski@samsung.com, ojeda@kernel.org, tamird@kernel.org, tmgross@umich.edu, 
	work@onurozkan.dev, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	fujita.tomonori@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
Message-ID: <ar38qq0q8f2Vecuw@monoceros>
References: <20260930101257.1649945-1-tomo@flapping.org>
 <arz487DLBlaBrWLN@monoceros>
 <20261001.070215.521963012921142699.tomo@flapping.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stj2fwtn3fuo7uyp"
Content-Disposition: inline
In-Reply-To: <20261001.070215.521963012921142699.tomo@flapping.org>


--stj2fwtn3fuo7uyp
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
MIME-Version: 1.0

Hello,

On Thu, Oct 01, 2026 at 07:02:15AM +0900, FUJITA Tomonori wrote:
> On Wed, 30 Sep 2026 13:57:31 +0200
> Uwe Kleine-K=F6nig <ukleinek@kernel.org> wrote:
>=20
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index 729776086879..abecd95b0c3c 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -772,7 +772,7 @@ config PWM_TEGRA
> >> =20
> >>  config PWM_TH1520
> >>  	tristate "TH1520 PWM support"
> >> -	depends on ARCH_THEAD || COMPILE_TEST
> >> +	depends on ARCH_THEAD || (COMPILE_TEST && 64BIT)
> >>  	depends on RUST
> >>  	depends on HAS_IOMEM && COMMON_CLK
> >>  	select RUST_PWM_ABSTRACTIONS
> >=20
> > Can't we do better than that? For C code the right thing to do is to use
> > one of the div helpers instead of a plain / for types bigger than long.
>=20
> Indeed. Rust code already uses some div helpers. However, the kernel
> crate does not have Rust wrappers for the helpers this driver needs,
> such as mul_u64_u64_div_u64(), so we need to add them first. The
> changes would be too large for stable.
>=20
> So how about merging this as a fix? I will work on patches to use div
> helpers in the driver.

Fine, then let me just wonder about the expression you chose, that makes
it look as if 64BIT was only needed for COMPILE_TEST.

How about making this

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 729776086879..4cc2911a0673 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -774,6 +774,7 @@ config PWM_TH1520
 	tristate "TH1520 PWM support"
 	depends on ARCH_THEAD || COMPILE_TEST
 	depends on RUST
+	depends on 64BIT # no 64bit division available on 32 bit builds
 	depends on HAS_IOMEM && COMMON_CLK
 	select RUST_PWM_ABSTRACTIONS
 	help

instead?

Best regards
Uwe

--stj2fwtn3fuo7uyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq9/V8ACgkQj4D7WH0S
/k5Drwf/Sw5Vll4mVUIaUUIfPVOTKcvnUPTbSsiEPg/zQCFDF+2xbpHGqSzWAOKO
I53Fjvjcij0Lml9edp+4pfDyYoMRkkvFQb0j85wphCv9+SNEIBbiM0SVNyd/Ia6W
csXCuvU7WDJ5bmDbf+25dDjYKuSqgsiNIlx9lrmHFP8qllxTFo6T7xUbsIAxkgzE
kUIfMstkJ3K7ptzP4xzswX0pt/w5Ae+3GrwI+hJasrZiOO97FRhVFd8L6+ffu5rz
Uj76zQUPOWZPSELZa3Lk86Rc1ejd/siAYTjaeG8IRCxjtoseBVa3wTkLopVuT8Gs
ZUsb3LFu+IWbIcojTrp36W1R2rGVaw==
=KnGj
-----END PGP SIGNATURE-----

--stj2fwtn3fuo7uyp--
