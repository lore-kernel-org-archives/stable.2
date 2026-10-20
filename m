Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497916;
	b=sr9Cu/ubKSGYZLm+sYFr1/5/D8n6wZQOy0enyEYEAWlecCwML1+OVOindTihcGegylCg
	 lsCRzT1oNIAzAzrHW0VSVK+gK/I8xS3q/0e3R5RkVO7n/MLaYWMd3Bkz4utXSUmPHmTse
	 Bi472LSEMn70PXPRJQzxbAEQBDKtnq4Ll/iS67H3FVxs8JS3dfxqCZkRD2TSWwk+SoRwK
	 vzzrxmSNhj8Uk7kiLf9491ZWmE3tTJwHiefgmmqhJ5Tmfegr/QXocaa501B8kOo7cx5lz
	 kB78V1UsBowRfHFDXR5FaXvqd8Yze+wkH7A2yN1xUZVeHThikVT0gY7b968bF/uJNyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497916;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=3rUGvuaVTTy+ZOb7QiqULfTKmRQxwC5KzfroeU94W3c=;
	b=LoeG6ME/ZWm5z6FJB3bI8c8lXiJtR5VI5HRIX+IAm70qlO9JtRk/FdgV0eSVbxLuY+DD
	 ARdRfGfitv+5OubVXq4yfekYxENyaMj0MdjiFD0QY4Jk7C37FDeMCizC9PX5B74RayAoh
	 lPZFE0j4yhHjSa/EwwVv2OXXbmAHFZ5ELZfoN8JFU7Tsg0qZmTijYnPbiOGP73EYfOeNx
	 6CUEr2HkW1PPxn14cl3Lbwd7PzBWieCjQoXBglUuG+V9eKahufxfVFbZklnclcMvXuOIn
	 Q3Pb8ZMfdCyIVhmzv1yhG+JScVR10OQQjwGGwkOsdL6Aw732CkxwBRUgkJWNA5mb/vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSv62ugK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC905606A31A;
	Tue, 20 Oct 2026 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSv62ugK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271851F000C6;
	Tue, 20 Oct 2026 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497915;
	bh=3rUGvuaVTTy+ZOb7QiqULfTKmRQxwC5KzfroeU94W3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iSv62ugK666I+rMSJ2KdftrD5ohEdfUYkw/dR1CzFfDtijTXtsc9QJFpCRxA91Lv4
	 hoFWMtlvJNQ3zi5AVQNs54HxJ9YkYvyHk8djA48iX9NDcoAZIz6NemKAWy70JX9Sf8
	 aRGYsVzkYM0Te2EJ8x/Go9bVL8XtdBgm5/PprTgHZ21Yg4L+Rvi9QX3CPhXs/TlVlw
	 oe8MnlVfCNLNTnp5AuLplj18Yfs9e7Wh0pWHeSfb8buxkescVy9gVlXTcKdQOu+Cr7
	 aGL9BVfraXpP6KipeYu6UYAjYHCZ7RxaOhh9gKMAiVu6c1FHhGGeco5Mo2LO9PhtoZ
	 UVnOXvy8uTy6Q==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id C324D1AC57D0; Tue, 20 Oct 2026 13:05:11 +0100 (BST)
Date: Tue, 20 Oct 2026 13:05:11 +0100
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
Subject: Re: [PATCH 1/4] arm64/gcs: release GCS on failed fork
Message-ID: <atdY90gcVwbHu2sc@sirena.co.uk>
References: <cover.1792179433.git.ivanrwcm25@gmail.com>
 <2539f61f79a6053e2a33a1d1ae9df09013c04bd8.1792179433.git.ivanrwcm25@gmail.com>
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
	protocol="application/pgp-signature"; boundary="gxc4xle/qhZ2446+"
Content-Disposition: inline
In-Reply-To: <2539f61f79a6053e2a33a1d1ae9df09013c04bd8.1792179433.git.ivanrwcm25@gmail.com>
X-Cookie: You buttered your bread, now lie in it.


--gxc4xle/qhZ2446+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 04:46:00PM -0300, Iv=E1n Ezequiel Rodriguez wrote:

> Select HAVE_EXIT_THREAD and free the child's GCS from
> exit_thread(). gcs_free() already ignores a cleared base and a
> different mm, so the usual exit path (deactivate_mm() then this) is
> a no-op the second time. copy_thread_gcs() zeros the inherited
> tracking before a user-thread allocation, so an allocation error
> still skips exit_thread() with nothing to unmap.

This makes sense and mirrors the handling on x86 which had an existing
exit_thread().  There was a lot of pain finding the right places to hook
in here, there's far too many routes through this code :/ .

> A kthread copies the caller's GCS fields via arch_dup_task_struct().
> kernel_thread() uses CLONE_VM, so during a failed copy_process()
> the child still shares the caller's mm and gcs_free()'s mm check
> does not save us. Clear the inherited tracking as part of kthread
> setup.

I'm not spotting an equivalent path on x86, it's entirely possible I'm
missing something here but if I'm not then I expect they need the same
fix?  They use a similar memcpy() for the arch data and I'm not seeing a
reset anywhere.

> @@ -503,6 +513,17 @@ int copy_thread(struct task_struct *p, const struct =
kernel_clone_args *args)
> =20
>  		p->thread.cpu_context.x19 =3D (unsigned long)args->fn;
>  		p->thread.cpu_context.x20 =3D (unsigned long)args->fn_arg;
> +#ifdef CONFIG_ARM64_GCS
> +		/*
> +		 * kernel_thread() uses CLONE_VM, so a failed
> +		 * copy_process() still shares the caller's mm.
> +		 * Inherited GCS tracking would then look like a
> +		 * child mapping to gcs_free().
> +		 */
> +		p->thread.gcs_base =3D 0;
> +		p->thread.gcs_size =3D 0;
> +		p->thread.gcspr_el0 =3D 0;
> +#endif

I think it'd be a bit more idiomatic to have a function to reset the GCS
state that gets an empty stub with !CONFIG_GCS=20

--gxc4xle/qhZ2446+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatdY9AAKCRAv73Ows9A4
iWTwAQC7iQAwJ8AvSpT4za/gdMW9NJKIrjii+W62TxSlegpBlwEA0ZL335q7PnHL
KBKZVvTQfALmAMz+nHizc7SQa5fSOwg=
=NmUr
-----END PGP SIGNATURE-----

--gxc4xle/qhZ2446+--
