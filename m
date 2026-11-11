Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405359;
	b=So0MX84ckf6qkxmPyImWiRYItMSOLCgzndJ2ey/rCFPYMN5mdPSeVjlKm9pkM2swUJ80
	 pIoDbXXkCa1wPQkl8UqeXjpPOzSnXP2NVjgT7HsLMHFIjvY+8BgzyEC1z1hwSNnDT1Lr/
	 pBSI6BDpycIvpR/npRUS0hDx6iRuJABIqpTWdKR2DTCF16WPb9eJl4TL4oc5q5CwiTuRb
	 WivmbuY5/gpP8Ahjc3bfJWlF6DBOF/xNltfBuFosbgBrOFDzEuOuOGVV32iHGxDvnrkAj
	 kjR6CcqZDGKKSoxAOenNH54MQT7kxLCA39gb/N7UOsUzYpSAHuraZlJTh/OfzTuwjkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405359;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=fAyq4tkzqmxRwZTSgtjt+iN8WPHEULKdWMlOmAY//3w=;
	b=RJqDNi2PS1p8MT/mMXINLAFC0j4XgoYng3h2CDN+p8NkGRJwNatZEb5ifzGqm/NSRzcm
	 ye56FaP2okyBL+c6j/N8mDQ9T13OyvfKquFYta2RX0eDgxeD1MlqHyO4TqzZTIozBQXOt
	 13UpzYAxUCwowDa0wuzqT+UDXeuKF8FE1NiVcAWpNNaunW5IKYn3K30QtbC+nMGS/E6vZ
	 fP4DddZ3n9LRsHjs5CfdazphxjaMhzaDuz9DNhroK6trKZzkPdV9OxLnmIut6apPnKn/O
	 ZOnVhP7aR10wpG7QKM0Au9qZ0XJK4Ah+igKcnGsBIMGkGsrQpVJ5jwWp5XdHC/kAi6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMfSuEKg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C47606A880;
	Wed, 11 Nov 2026 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMfSuEKg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B831F00A05;
	Wed, 11 Nov 2026 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405359;
	bh=fAyq4tkzqmxRwZTSgtjt+iN8WPHEULKdWMlOmAY//3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oMfSuEKgxIUPOzfWqeTt/CUx1/tHmQbH8r9r0L1BxtBkFcSIorNgi4CbtCsDr0Vi0
	 djuAQLqJkuT/l9CZgm9lU8xm3FIG4nTj270/G6C6bytyYc/iZ17bzEj+ASHBon5cjw
	 tWrKnmn56rT9yyjTtwTm6CBKokvYuhQHshPU3wjbFeE6NuPDOKxjEdxZIahaXtNQ3J
	 s2woT4Hz3cUokbDkwyV/dVWkiWMiQjYwlbsamLChrsu7/ndrb5dLYfmPOcmaGjppwF
	 DTZG7kCU+YhmiPEAlgP7AhYg31m/pQjavu+WH8wn2TbVjsgSy9ZuGvaVzQV5WBYP5Y
	 Csh9HwAq9wfUA==
Date: Wed, 11 Nov 2026 13:55:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: suspend: Save GCS state over suspend
Message-ID: <82a7e8ad-b238-4842-a2d0-6a070d0b77be@sirena.org.uk>
References: <20261105-arm64-fix-sysreg-suspend-v1-0-f4d9a99fec46@kernel.org>
 <20261105-arm64-fix-sysreg-suspend-v1-2-f4d9a99fec46@kernel.org>
 <282608f5-a13b-4695-aa17-f834bf5d8272@arm.com>
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
	protocol="application/pgp-signature"; boundary="zfD1Qgq8y+MjOF4J"
Content-Disposition: inline
In-Reply-To: <282608f5-a13b-4695-aa17-f834bf5d8272@arm.com>
X-Cookie: Do not pick the flowers.


--zfD1Qgq8y+MjOF4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2026 at 01:44:40PM +0000, Vladimir Murzin wrote:
> On 11/5/26 16:05, Mark Brown wrote:
> > GCSCRE0_EL1 and GCSPR_EL0 are live registers for EL0 on systems with GCS
> > but are not saved and restored by cpu_do_suspend()/cpu_do_resume(). This

> > +alternative_else_nop_endif
> > +alternative_if ARM64_HAS_GCS
> > +	mrs	x2, REG_GCSPR_EL0
> > +	str	x2, [x0, #128]
> > +	mrs	x2, REG_GCSCRE0_EL1
> > +	str	x2, [x0, #136]

> Have you considered using stp?

It seemed better to keep the code repetitively simliar to the
surrounding code and also avoid using an additional registers.

--zfD1Qgq8y+MjOF4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr0c+kACgkQJNaLcl1U
h9DPVQf/SYdpkyIvpWSWZ2vESrRwMyl4IrX9Ci8J0n7wAVYb3/YCF5D9VBccNvvz
wbdopNZDPgMdxN3dLUWgMtMFJGEc4a0iI3VkFP1y++NdTk9B730khzj8WANDmY3G
oOrrLeRvtiyi+E7OJtFcn1zWmnCGgXDjc5/UPdR/genlHAF5ofCkO2ev1yxQkLAp
l+ql+eXYI5YplhNRgZdo9wmXYzci/TVvYeBQ0+eiaje0kuvuFbOhpL384rMsEoK/
MSBFIYQ0buIySdxSUX6YXWgljBSAVAs1Fw1+6q36k9zpMPR9rt2CFH+Z+q5iGWhx
FhpS3ICdvMMjFJg66QaC+RBAB9FERQ==
=qKrT
-----END PGP SIGNATURE-----

--zfD1Qgq8y+MjOF4J--
