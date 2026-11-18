Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984631;
	b=DMB8b/yVhFO5h4m+Jmgil69LSo/FRIbe0jhHXCvcdFokHNMoG/ipuu6e87EHVd/swPm6
	 5TmHMY8VPQZsewePtdUcpSMnT9uuSfykjHS+/cacnU+Fl3StbD/3YE98UU/oiRw6mvjQp
	 Q+nxOHaLsxLgn1TvOzvqWc1AuvKb5ZHaSCDNG46h7ZScuqaKw936UOpHfqph2qlX7HErD
	 J3c72Q7GtBqDBC9IDNbQFy2SETL4X6xesJPU0IT86YHWiWlbfyHj5AqRXFNtr0MGOxHDA
	 mzMMuAdZssxH+ok6SVY5YFlyBbjo9iE25rwQVu5NHyPALC47Zm1HcApDfZOOGl1G3yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984631;
	h=Received:DKIM-Signature:Mime-Version:Content-Type:Date:Message-Id:Cc:
	 Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=NaMgfsBXkwIEOSzL6UoZggx97YSqPQt9Uq2nZusRujM=;
	b=z9M5PhVwnNiRJoRQexfADmIhZ3Y5kkMlwpimC404y+TWL8ET/DTEk7NJ5880kF4YWoJp
	 sJ+5L8oPUyFCKjdetdNaNMzoLkcGbJ678J5BaTsDStlEVF6wvbXNzJ+CGNfiUIcLfkMT7
	 n+ZURYWLNT5pRxeuQHMg7jwhJWrrZ4AwjNyE6UvRBC1CArwjcSfFMlRkppn+Zb2+32qGZ
	 NvLE9lDmpUeBhUUwgR2jMFaYkzJx9tvFCQtm4NnVW3wR6OOCnfxNFilJvGaquAslw4Kbj
	 2N4+/mDJJacXWZZUq6F5SjqS4GuLs85DE4WXl65k9Res0Amu3KaWib4PXTssV1G7liA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAcUmROL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57CA606A31C;
	Wed, 18 Nov 2026 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAcUmROL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A075C1F000C4;
	Wed, 18 Nov 2026 06:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794984631;
	bh=NaMgfsBXkwIEOSzL6UoZggx97YSqPQt9Uq2nZusRujM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=XAcUmROLtQExiCuSuAsW8ooxm9bwT/FvPpx3bSbrOec6BPLEvr59ut8GEZVgzMbYD
	 eIBoD1xGzpIaJDj27VJPE6JZ079jolaqzUcWK0RxhaLxm9cA5ObCiXTkETA3PR5KSN
	 bi/cp1c3gc1Irg3TPWqai8eVUvyBKfy/5oe+BXviJE22VzjMjNCkd5QuagOcpbKEGV
	 Pi3W5XR5t59OAPqf3RuQ56Wh7Tu6/oB+t5y1ikCYCBrmssUlyDVF+27xLndGE+Nf0d
	 T4VOKbI688J6JuONXT5wXJixogqqqC1hrZ+YUwLHYH/ZEh9Tak+ytQvqDdkzoVIS1A
	 PP6Ee8aqRGcYw==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4c0efea937e1a3ca1ee31edaede7a53a9813de01b0dda297014c9e69db09;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 18 Nov 2026 06:50:26 +0000
Message-Id: <DMY4Y1HIP3H1.9THJE8OIYQ6P@kernel.org>
Cc: "Palmer Dabbelt" <palmer@rivosinc.com>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <spacemit@lists.linux.dev>, <stable@vger.kernel.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>, "Troy Mitchell"
 <troy@kernel.org>
Subject: Re: [PATCH] riscv: cpu: Fix incorrect cached machine IDs on
 secondary harts
From: "Troy Mitchell" <troy@kernel.org>
To: "Peixin Xie" <peixin.xie@linux.spacemit.com>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Yixun Lan"
 <dlan@kernel.org>, "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "Guo
 Ren" <guoren@kernel.org>, "Conor Dooley" <conor.dooley@microchip.com>,
 "Charlie Jenkins" <thecharlesjenkins@gmail.com>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261118-riscv-marchid-fix-v1-1-6d677fcd5461@linux.spacemit.com>
In-Reply-To: <20261118-riscv-marchid-fix-v1-1-6d677fcd5461@linux.spacemit.com>

--4c0efea937e1a3ca1ee31edaede7a53a9813de01b0dda297014c9e69db09
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Nov 18, 2026 at 3:04 AM GMT, Peixin Xie wrote:
> During early ISA-string parsing, the boot hart stores its mvendorid
> and marchid in riscv_cpuinfo. This happens before setup_per_cpu_areas(),
> which copies the static per-CPU data to each CPU's allocated area.
>
> When riscv_cpuinfo_starting() runs on the other harts, the copied IDs
> are already nonzero, so it skips reading their own IDs. As a result,
> secondary harts can retain the boot hart's IDs.
>
> Read mvendorid and marchid unconditionally on each hart, as already
> done for mimpid.
>
> Fixes: e482eab4d1eb ("riscv: cpufeature: Fix thead vector hwcap removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
Reviewed-by: Troy Mitchell <troy@kernel.org>


--=20
Troy Mitchell


--4c0efea937e1a3ca1ee31edaede7a53a9813de01b0dda297014c9e69db09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIYEABYKAC4WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCav1KshAcdHJveUBrZXJu
ZWwub3JnAAoJEJgJ74D5MzQv7GAA/30aDkdLRN86mR9b/Nj9+OAU5xj5aQwTCpNj
3MBw49/MAQDO9DEA+xmj89XF48oLFjy0QGlaYBlgJw5taJe1lD4fBw==
=zLIP
-----END PGP SIGNATURE-----

--4c0efea937e1a3ca1ee31edaede7a53a9813de01b0dda297014c9e69db09--
