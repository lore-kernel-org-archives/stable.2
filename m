Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198463;
	b=Vvatqms/7AkcGIwhAChQB7xdsovRvOptK4/kzTonqQBzElAO8/pSbpTpR3AhQu0quwc4
	 dan/9VSY+Shix3P3dUu633prGev9HilFG1j4nkLbixFzQp6HprCw5YIM8tOvyr082yYhi
	 VuBIs1oTgwMvUbg0WhP6pcfgElEGWQkUFGzbATFZEvgGdLvQ/P4ELvQf6C+ZAkCWq20XI
	 LvxDf2TXSfZBOANhr1nj71NxeOEfY+h5urajCgkxaEv6ojXBQvKBefXb4lSYd015m/m/H
	 IWdOXbnzefDJgx4ob9zXZ0dz06hZHWTk7gej+hxm3EmIylWR1vXtcLHtXEeOV9xhNEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198463;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=SJDODn+Daxete0vXNEeSBNeEHTwbpeBhwXO3acT8Jjc=;
	b=CjAjRGHwt6+oJlHhKDvEWSDCIKqS9CP0IBP/AZ/DeFYdUJ3bWmmbKY4fm9KTKJEgxbVR
	 xofGE+4qfnDUOvffk5+OBYO4UG+HlclKxhrVn52r/+5XYNxZfhhs+smNcrK8tVpN1qAuK
	 yNIa9pnj0enzWJ+UcFDQbuu6lC+HWl78OjY5+B3qMCwNnfvdii8RLQHBGOVR58VR4K/Hj
	 pDT08gjHT+XvMpXhfFCw/jqjZmrmfwVV38TH3lmZ2d5HjMW/PaR7Q5ANDUoA1b/tfGjzd
	 AQzK/rlVs67eMCgOgOEA0brwPQsd2oUpn8JDDqY3wVkgTLqqsasCSRKSKL9toTUDVlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YirwpN8N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D986606A31A;
	Wed, 28 Oct 2026 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YirwpN8N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB3E1F01829;
	Wed, 28 Oct 2026 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793198463;
	bh=SJDODn+Daxete0vXNEeSBNeEHTwbpeBhwXO3acT8Jjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YirwpN8NTIcpR91bbQZOawatQgF7WOZribCgtbQv3D9/IEwAE5fo0kroa8564+nYm
	 6mlIYEBpfTW8Hqn/astGPJWT6TccQlGtF8K2Obc9yA7PSFBQ5ZI4xyquuc/F+pHVtR
	 6mfQBL/ylb+NNAYpULUdWpufa1il/FmWMeO/5fdDmtuolhmVdvOYx+ccHFXLe62LO5
	 N2u3xI5LUJgVwLhHVABfH8nV9r726sROrQ1qjsm6R9Ky251dULE/J4o5RQ/SajqFaa
	 jY4c95rf9MSoJ+RZnUy0WvNnTVDAJMXFPA3JdsdcWtIEamSQ3buF1Xsw0gfKRvBcD3
	 P3On2k6G6xutA==
Date: Wed, 28 Oct 2026 14:40:56 +0000
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
Subject: Re: [PATCH v2 1/4] arm64/gcs: release GCS on failed fork
Message-ID: <fc71b59b-aeee-4d68-9d48-9eb9ba707321@sirena.org.uk>
References: <cover.1792519121.git.ivanrwcm25@gmail.com>
 <8522b8d3d3ecda7474d0af8b8517c1f5d708ecc2.1792519121.git.ivanrwcm25@gmail.com>
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
	protocol="application/pgp-signature"; boundary="JK4egr7oBGvhaW3C"
Content-Disposition: inline
In-Reply-To: <8522b8d3d3ecda7474d0af8b8517c1f5d708ecc2.1792519121.git.ivanrwcm25@gmail.com>
X-Cookie: Pushing 30 is exercise enough.


--JK4egr7oBGvhaW3C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 03:19:30PM -0300, Iv=E1n Ezequiel Rodriguez wrote:

> +++ b/arch/arm64/include/asm/gcs.h
> @@ -67,6 +67,13 @@ void gcs_preserve_current_state(void);
>  unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
>  				     const struct kernel_clone_args *args);
> =20
> +static inline void gcs_reset_thread(struct task_struct *task)
> +{
> +	task->thread.gcs_base =3D 0;
> +	task->thread.gcs_size =3D 0;
> +	task->thread.gcspr_el0 =3D 0;
> +}
> +

The other process.c specific helpers are all in process.c.  Otherwise
this looks OK, though I'm still not clear about the analysis for why
x86 is not also affected.

Note that since you sent this in reply to the old thread is was buried
in my inbox.

--JK4egr7oBGvhaW3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmriCXcACgkQJNaLcl1U
h9DyKwf/f0wQRzWGs4z7w3rL3l/aDet1CHGvYQeENmeNCwRcMkxKv7+aoLzrNWJX
ZlLAXfNLCaK0SG3xcaLnerecwFSW/K+zwNIqFQf7E3czUrYNyZ6QyuUeY1sWKkni
fD8xwhMCQeDCKMrIJvAYMYNgT6sFI5r0TrowwJjKsFgitHpQ9+QU05extDSJ6JoH
Mqn0oOauMbIXl7F25YhJ63+d1nlTajtFiq5VoI5tIjcWosAdpaEmySSpBX1pqBF3
90lzfVTXtNPpv1qJHoHhFhfttnlVCvwGp/lgwQK1kw+fw2wlfHdR/PXLR5hnkqA5
fhLzMJjBO1oi0mpX+FfxV5lWZTHuaA==
=qGVS
-----END PGP SIGNATURE-----

--JK4egr7oBGvhaW3C--
