Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405181;
	b=slPtdtcu4VfhSGhpaq0gI+l//sL0iFKBffkA1m3QpCvMyDUJa/lkvSN+OevGObmZbj/H
	 XjDGfTIPXLXxdWuhgvfynLNZOFzS7h4SmX1BL/l2Kbi5goGGIQ9hEreNSTRfbQ6D3Vq1K
	 ZoT9dGvhxwMbVEv5MOL1zSg+BRK4ZC5EqQ2kvFq0ANh6ClL5To1RPYlKg3KcgSZZ/9a0B
	 9KqVP4yHDVdOcy81sBbn91J9JxQ8to9byiZdFlkTXYkwnh3/+20vtZCfoBywQs4AwC8+U
	 9csT7hxvnRWuz59TzznT5npOpKrMRzc/CXdBZjVQ0nDfKcpPkbgzVtgWcPlYTxDOuqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405181;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=v71XpPF6azQMZJDYxnu4wkyjgWByHd4xKZAt+IzoWgk=;
	b=srp6fVsuqeYWgZzTnUSRfd754cF9yj36eovWws7ZF6xFyvcFNxihCAAVivKvRxlU9roN
	 HWUu1b+ii7xFnnnB3ZwDT6g8CWr2a5H/yby1T9B6H0rWrbyp1SsLbVzR9DsUDVjRAbTjd
	 9EkHujjE2k4AafZIRbtiRbqjp1sSrqZ2kcq4a5CeetKoxq1v2vZ0eR1XtbsOVc3IMfc68
	 3yaJV1IXaQx0fOexdNMV1d94op5tbOSavA0BfZmdpFUXwo0nfjez7tHMWfaY+b4Oy7NwX
	 Y3IoLAYabbp60xCOJlzBN9r28FsSd8EKw2mDf8SysEKNc58c6qCN7iNiPvWQGDRZBag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJ6RVn2h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51C606A31C;
	Wed, 11 Nov 2026 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJ6RVn2h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CCA1F00A08;
	Wed, 11 Nov 2026 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405180;
	bh=v71XpPF6azQMZJDYxnu4wkyjgWByHd4xKZAt+IzoWgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IJ6RVn2h3nqYDMQiJqYV4ZnYg/Du0eAeh/tG6f83XZr8a7BWuCSH+3o1eue839hUY
	 MipkFHnxxuaI4SPZLDqzobq7U+vRxaTavj+YhPYnwVPsGlRsTuNgzwrypRWZXdlCxe
	 7WNYdxMtkl8aseObBDDybWR4x+2nZS6B1ROjZO/nxF19Pj3BBQILbcpmCYpi1RdhWQ
	 6JlKbsDtFsgNUx60wqnEQiEB9y2irok/cA1AHmKkPoF8sEzo7aQ3mWCjiNgYl2H+7U
	 RaRjWpT9eJyte4ILaqI5RTIBWsqSvXB3HgxM6xcH7NnmPAV5h2iOYgokgSyW25KmsJ
	 r8xSysKjIM/Lw==
Date: Wed, 11 Nov 2026 13:52:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: suspend: Save POR_EL0 over suspend
Message-ID: <55361015-8054-482a-8c90-b440282c3cdb@sirena.org.uk>
References: <20261105-arm64-fix-sysreg-suspend-v1-0-f4d9a99fec46@kernel.org>
 <20261105-arm64-fix-sysreg-suspend-v1-1-f4d9a99fec46@kernel.org>
 <3479391a-ec0f-46a8-9384-ec084017d344@arm.com>
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
	protocol="application/pgp-signature"; boundary="bn/aNT600hJIxnxl"
Content-Disposition: inline
In-Reply-To: <3479391a-ec0f-46a8-9384-ec084017d344@arm.com>
X-Cookie: Do not pick the flowers.


--bn/aNT600hJIxnxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2026 at 01:33:27PM +0000, Vladimir Murzin wrote:
> On 11/5/26 16:05, Mark Brown wrote:

> > This increases the size of struct cpu_suspend_ctx.

> This seems to be implied since we need storage to keep register value, no?

Yeah, it's just noting that we're not fitting in the existing padding
which prior commits seemed to be keeping track of for reasons I'm not
100% specifically clear on.

--bn/aNT600hJIxnxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr0czcACgkQJNaLcl1U
h9ByEgf/dlknCiYa8K6jEoFx94FY49Bto/TdB0IVuxUu9buCHBQYp5yBrhNsjlfl
xAfEG1OP3A8AYZZUfRza7DknYjhfzbXt3SchXLFpQg9WyXZgGKXPmAcS6l3ajCyH
8MyLesNjC//8hUZtYV8x/dvg3kv+jRFnJ8kdmm4DPZnUyOeuU6SUtpaZhAUpBd1I
RT+bjMfmm+I8V3RbaRsEUU8kduItDSy6m4NpxktIAMTJsond93MzljcbFX7j2BWl
NuwsHFg7S/qet1RdiL73qiNJ2xfokAZ0kendcGDIi3YsBSLZ1UjLoskDHM+E5Qar
O8BbYGd52yrFOThElsqCOfiqTdP78A==
=hmBE
-----END PGP SIGNATURE-----

--bn/aNT600hJIxnxl--
