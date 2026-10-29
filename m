Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313384;
	b=UUw58/1+JhUejSmjN/kW+rb4trBjh4kQah8xGsJDrM80HjUKciX/XmUhPQ0+KwREek0E
	 /3KX45jN8vvYJNlOnTFU48WF9zLldY89ACILcumkm8j8EOEBU2zUkenAY0Y6hicp9xzI3
	 F0LEzm5qdpjYLXMqpkH3M0FAXO6qF10NcWAg/Q97yj3GaI+ty9zmK4zrsNC2umieB3a0V
	 jGFxhS5xbE0PSiOqC9v6wcUCY2mEnHzSMXcOtN7tUUsRNvsvERMus5VndNR8+bC7ajL69
	 lpG5UmXN6CZMq9U3FlkHT0Bjib3/jK+/7SFLV2mmlF5VG3z7l6lBSz2XjWUr46Qs7mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313384;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=OruVHMwaVYca+pt7spuiusVmVidIFTPZ1qPgeij7xYw=;
	b=G/8m8GCBq93ubkXySqDmmjSgdixwAShpc1jzrACdSlL5GVB1h51SMum4qKwQ0BP0Esld
	 7uGzy4QGyP2G438xckTseKx/yYurEn4ZtOkYIdkBXJ7Zc6c/E7rjfmRWnZDLSz2ddxCpN
	 6ILXEOCwLpSBnyQohm6O9SH/gxAuxha/p2P6jneoFL/vOuhrqz7h8YR1TPOsZoDU9EhzR
	 +kC7Z2Yq0+pXRQ8e+glnT+4YRdbbWcVHogV3dQmOcM5rcE8i9Ebpvr14/vryll2TAuPTN
	 RgsgCZeDlmgUX4sS/QG5y0UXV3JY3hKuX7AClqRqih1RVq1ZUdA2DcqUwS4XBTmnNxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQh3D98n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3338606A31A;
	Thu, 29 Oct 2026 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQh3D98n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0901F01824;
	Thu, 29 Oct 2026 22:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313384;
	bh=OruVHMwaVYca+pt7spuiusVmVidIFTPZ1qPgeij7xYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UQh3D98n2z0QrJMhUs8LDSx06tdIV+9WJNQ+utaqCcBNoc4roNiFGATOk5K+bo7Y0
	 EI6PX+xS7pZxQ1bLrse2E3AAciLkjGkcZHMd4rDrqeoVrRlGOytlvryol1bALpvuCm
	 bT/5qdbXFQKS7PBKHfK0XMc+dFmvjPSNzAT5dCTXZ19esJVmxhKf9uaJVy3YT3f4Td
	 YYArgjWsdE7xFbwDYG2+G87WjV7p9zkv/aNDRnY1Ldl7L7RbSgSZ4VIachMzUxiNYg
	 s+pDqETZeW1oJpgjtzaiSsLZcZdIDQEvgGk+m53Dr4OGpaDVYHjXnhIvRZaKefh5Cp
	 Zn3IWMp2PMAHg==
Date: Thu, 29 Oct 2026 22:36:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: =?iso-8859-1?Q?Iv=E1n?= Ezequiel Rodriguez <ivanrwcm25@gmail.com>,
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
Message-ID: <94f6e809-2a89-41b8-80b7-5f580c154858@sirena.org.uk>
References: <20261028154315.1272705-1-ivanrwcm25@gmail.com>
 <20261028154315.1272705-2-ivanrwcm25@gmail.com>
 <auOtXvGD1RHsU-dy@arm.com>
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
	protocol="application/pgp-signature"; boundary="zwt295GGKfUega3/"
Content-Disposition: inline
In-Reply-To: <auOtXvGD1RHsU-dy@arm.com>
X-Cookie: I have a TINY BOWL in my HEAD


--zwt295GGKfUega3/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 08:32:30PM +0000, Catalin Marinas wrote:
> On Wed, Oct 28, 2026 at 12:43:12PM -0300, Iv=E1n Ezequiel Rodriguez wrote:

> > x86 already does this via exit_thread() -> shstk_free(). The separate
> > x86 TLS leak is different: copy_thread() itself fails after the
> > alloc, so copy_process() skips exit_thread().

> Is the x86 TLS leak relevant to arm64?

That was in response to me querying if they were affected on prior
versions I think.

--zwt295GGKfUega3/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrjymAACgkQJNaLcl1U
h9BBOgf/VWlnK4mad4KibAkY4/so13xBR4n7xrgeGHR8thlB1Mr/L+Scb+2iQkTF
g0qbnACHD3kfNuyiV+7rwrdLUBZQZ9ZnpUrXDepYI4uzbxXtCT16hivhz29nkUPj
1ZGIL1PspxrSro0U3+Jjrmfns/UIkk3AAjYyLTs4V5CPiBZ/k7UEuHjDhdm2qx8B
q/izPRgrgPzLJSiHiBtOJDnSmP61hTLL2y4NAc5e3BCirC/FkHzkF2drdCXb1wGD
X3iGddlphek6yNTYi8s4K84ArSD70/VNMzdf6vvNvPQwxvronfxBwc74HLk5O+zt
AMWfKkXv0N3FIhsJEKZKiJ6czwP6Nw==
=rBVK
-----END PGP SIGNATURE-----

--zwt295GGKfUega3/--
