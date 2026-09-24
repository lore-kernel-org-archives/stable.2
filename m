Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11F274658;
	Thu, 24 Sep 2026 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290088; cv=none; b=NxH2ewIpfYffnHa5M4UzEYp9KQzCybjYrvjWjq0MYyl6ERA2GjJmzvRGRuaYhU4ebnFpq9ebPyWclcn88NdWBzlZk2pQVBYE83AIRy8XMERXtTU/OkYe0tJ33TH8d6//rklzKi23ghtUfNGMRrwZsPId4GZLkqllq2djpND5N6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290088; c=relaxed/simple;
	bh=UdGsI4r2z6QX9QnjcVgZiwai9wsAUP8CrvQzeruoTKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qDZn1KOSE0D/70foCB/nJ9ZBZNPBQxJyPj6J9BZ31F+5axrfMiCixYszMSDOISDYGC4RThkQBz+Jz4KVOCaUTlqsKQE6OBUHEx3nc3O5eQ1MSJforA2eKdaFzWNu9aKiDxUsn8eWmgC7KNRHrzevx2n15toll5btBCsCdrryHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdOGpzq+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdOGpzq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6151F00893;
	Thu, 24 Sep 2026 22:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790290086;
	bh=nh3O0D9pRfCwyQ/BjHS9Yn4M6TnCj2AEPaNpep0MKJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FdOGpzq++UzFdtMn/UBoRs75lMKPOd+yAyleR5pHmEvUSEb+tz22XB+AYUYKzmTz2
	 n1DlbhO+0HkA9+53shLK90yU9MUPKgIsLD1rgnr7BAanOXfVY0cuLyxSy+aVxDhJ2y
	 ApWSW1nV4Bj6KGfs7Bh3IjQGruwEFhbu6v0gAX5g7gjRjownnhn41jqfMD1hw0dtD9
	 ckdd6qU1vbRyy+5WERLa5EXxJ6JLol5nwCUX2vi8lNM36+7YafZyyRJ1jIlC74CuKN
	 01tAhWsvNRIEOSdKBrANGYJUK03AkzdMuzitibDm3gB20uQmnlV95h8+NFmWaYYe7G
	 ENMZSt/it0aqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] arm64: kexec: mark machine_kexec() __nocfi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nick Desaulniers" <ndesaulniers@google.com>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Bill
 Wendling" <morbo@google.com>, "Ben Cressey" <ben@cressey.dev>, "Mark
 Rutland" <mark.rutland@arm.com>, "Justin Stitt" <justinstitt@google.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>
Cc: llvm@lists.linux.dev, stable@vger.kernel.org, kexec@lists.infradead.org, "David
 Woodhouse" <dwmw@amazon.co.uk>, linux-arm-kernel@lists.infradead.org, "Sami
 Tolvanen" <samitolvanen@google.com>, linux-kernel@vger.kernel.org, "Kees
 Cook" <kees@kernel.org>
In-Reply-To: <20260924-arm64-kexec-nocfi-v1-1-bbae2e2eadc8@cressey.dev>
References: <20260924-arm64-kexec-nocfi-v1-1-bbae2e2eadc8@cressey.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 22:48:05 +0000
Message-Id: <20260924224805.DC6151F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

> When the loaded image needs relocation, machine_kexec() makes an
> indirect call into the copy of arm64_relocate_new_kernel in the control
> page:
>=20
> 	kernel_reloc =3D (void *)kimage->arch.kern_reloc;
> 	kernel_reloc(kimage);
>=20
> With CONFIG_CFI=3Dy the kCFI check on this call loads a type hash from
> kern_reloc - 4. arm64_relocate_new_kernel is SYM_CODE_START and carries
> no hash. Its copy also sits at the start of the control page, which is
> all that TTBR0 maps at this point, so the load faults and the kernel
> oopses after "Bye!" instead of entering the new kernel:
>=20
>  Unable to handle kernel paging request at virtual address 00000000544bff=
fc
>  Internal error: Oops: 0000000096000007 [#1]  SMP
> [ ... ]
> ("x86/kexec: Mark machine_kexec() with __nocfi") did on x86.
>=20
> Fixes: efc2d0f20a9d ("arm64: kexec: keep MMU enabled during kexec relocat=
ion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Cressey <ben@cressey.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-arm64-kexe=
c-nocfi-v1-1-bbae2e2eadc8@cressey.dev?part=3D1

