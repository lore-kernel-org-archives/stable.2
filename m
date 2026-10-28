Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212881;
	b=P+TohFY+W6QBnYo/LNZH00oPEThSafb7RprmiuRH4jJN1a5ZrniyO5rOo1tv4s/wb5fF
	 XiAAdgTXoHrxMJyrjV8o02YUlAB/9ltTbeqpAsgbbuz7asQEoIUCNONdWJSxYMD4m0Kpj
	 Mnu7Gsh3ERbEseI0jC3Jhc91ZG/0rDNDxhjvtpHOdURRMUPMyvQMxBDz8xWT9cZtWA2sb
	 Fss+i3n/RMmJ+A8DHhsWSBP4sZhuGqixhvrMNWjlbQ2axF1fP13mrzaJtbIZhjF9eS+xL
	 6/7QKrKfhoA9LJgen4IX749+IHkVTrIeJQJOqg+FEDlvP5P1CKruvwJcOpxP728RVTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212881;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=PjhlO6bW9+MSarY6wTfU4M87BNvgFcP6/LMpd2feJeY=;
	b=2sVu1H3xWe/DFRjfUSAcP2JXvloIR7qsKoNlG+JcbLZzDmXuKBjeIPYFaAUdxGXVyaAV
	 4E3wqZlnWwXljCKjUJHBbYNNBwSRkz/iZY3u5osqd0m1qJ8tAv8UyrVY8RrIz2Z9iKBFW
	 XZgY9CH4+97pLaW0/tVDmRJgzDoaXpQN3CwB+EziUroFTZqFzJ3m9ApJZ9G5wgN9HDd1v
	 qa7z9mLAmT2iNNRgtizperDy/5OTMrLRaYtBb8IDa0AgjKOtIkdUDwY1d1bRkyHoI+JO1
	 jYq+MiKvS+4e+9Xdj0GJqcCFFeIJGpH473vfTcColZlyhPwgrfKV2NxTaslRtErDBug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+Ku+Dfy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A45606A31E;
	Wed, 28 Oct 2026 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+Ku+Dfy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072BD1F01825;
	Wed, 28 Oct 2026 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212880;
	bh=PjhlO6bW9+MSarY6wTfU4M87BNvgFcP6/LMpd2feJeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I+Ku+Dfy9D1rIjDAH01vQDIriIj8Zw42Ol3KsnQQisCDSNUzpgxOB5hpqZiFAyjVs
	 YGr7Uzn63H4DUG+31UyZfBsNIl4kpzI2WFUDE0Y7FcYO2J2WJABgafFjrjQvasOXZw
	 ZuEf6nx60b958GRx2QgfzkwisLaoa3x79rs8XurGiU85IAOF5Dhj56+/9KOaikiQkz
	 PlphaYIDP1LHurqocO+l0yWviduSuuWAoRTEatuKhQkA47rqoPT/iKhPaO+fVK/Yd3
	 RhECPtQPienO90RuwfI54HwGQdVKukGOO9MmBS6sRPHB6Bx+zFakp3lCKqRBSknDyi
	 dc4Q326CsbINg==
Date: Wed, 28 Oct 2026 18:41:13 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Iv=E1n?= Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Deepak Gupta <debug@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
	Albert Ou <aou@eecs.berkeley.edu>, Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	James Morse <james.morse@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Zong Li <zong.li@sifive.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zishun Yi <vulab@iscas.ac.cn>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] arm64/gcs: release GCS on failed fork
Message-ID: <85c7637d-f5a8-4d65-a5a7-40b3984094c8@sirena.org.uk>
References: <20261028154315.1272705-1-ivanrwcm25@gmail.com>
 <20261028154315.1272705-2-ivanrwcm25@gmail.com>
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
	protocol="application/pgp-signature"; boundary="ide9tbszk81fwOPE"
Content-Disposition: inline
In-Reply-To: <20261028154315.1272705-2-ivanrwcm25@gmail.com>
X-Cookie: Pushing 30 is exercise enough.


--ide9tbszk81fwOPE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:43:12PM -0300, Iv=E1n Ezequiel Rodriguez wrote:
> copy_thread() can map a CLONE_VM GCS and still return 0. A later
> copy_process() failure calls exit_thread(), but arm64 did not
> implement it, so the VMA stayed in the parent's mm. Wire
> HAVE_EXIT_THREAD to gcs_free().

One extremely minor nit below, I verified that this fails with the
current kernel and that the kernel change causes it to pass so with or
without dealing with that:

Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>

> @@ -328,6 +335,7 @@ static int copy_thread_gcs(struct task_struct *p,
>  {
>  	return 0;
>  }
> +static void gcs_reset_thread(struct task_struct *task) { }
> =20

This looks like there's a missing blank line but it fits in with the
missing blank before the stub for copy_thread_gcs().  Possibly slightly
neater to put this before there next to the similar flush_gcs() stub but
meh.

--ide9tbszk81fwOPE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmriQcgACgkQJNaLcl1U
h9D9+wf/SHEa+LP5AxakY5iKXz8OEmHkAD3fFP8gBmCVPhIqGctmgQHKjOqdW7kP
xOfXg/CJU4L6nYqnyiGhiXDZ8vgIWOIJ1kX+6H65vbIQi+Z5BWDuL9V/4tXG+Ue5
vm493cyci8zp1g/g1ygcvRbPJc622QWP61VWAy1gUnN2IA8ix6/Sdj28+/QAcJ9y
IcrkwKGQuuJyU2xU/3EIpmW4Y3tL09b8/kunnn1SbvyGTvYRLCc/K2TTdtH+T0Wi
OvPhpmGzjGQv5OGNX4aHkIW5tx/wqUKcSfqb70IyHGqD8I8srKRZ2UyQNZ9+mU2a
0Eh6URoZuIVQGFrVDFvxcZqHfpC1CA==
=Yq1h
-----END PGP SIGNATURE-----

--ide9tbszk81fwOPE--
