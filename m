Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869311;
	b=kWIxv1gfD/Xd6cn3lHW4rAXKgEwfDA3C/MRx38mp8TrqwrBNORWWpfDZDNQGKjHXpOTu
	 flfvTXzJ+GUCW0tEZzRSPYyExcgOBxBBa7yB1iLKD6mKklPZwkPp1qVILJqAsK9hfJvxD
	 l7HM9EtpZOoVw+JSQreoO9b/2Sy7wrffvYbCanqP37ahzkTHg/NifN8WXqwRhkv0GH2x7
	 xRnEEVq0GhpHflrVmjvoUREMq35M1FqcpPcGJ4JNvoiLOFYEJ/xpelPNU8V1F9Z5sx6Tz
	 i/Qz8iU0+i2GFORYFZS2z/HViFeQE/tM3C8TQNOAOd2AmI1xyCOrPPvswhqCYN0mKqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869311;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=lpsTlWGvjAU0Wn3LPw9wu5piyyFg2szed2uGQ7R9Gvc=;
	b=LIs/lcLSy5PzNNoOerV8+9dBR4ZdVSEDVo63H51Nux/5bHo/Mqpg68E0vSTlNVV2dAaM
	 fFGw8x1ihiLGU8o7JRanMCzgx2sA6FAmL/yBvlqGh3vJxjpyGal/9GWEw3hElsAMe+nJR
	 /S4tzYCm4F2kDtQ/zh/15C0XN+Q8l11iq5bCRAIWWH5WhmxUKqKlOZaRGYcUQdARzmJAQ
	 WScaFUkD0Et4FNHs22G04auM4/+yk7IZadB8VUp3P09oRROs43xLBSeSxLyYChLufX4FW
	 WQgjxwZWoXqPG2V/pzqCYYGo0EGuK3KcTvxa0VDcsnMmdre8ck75zKfURzx+jywC6+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WMvK4Oft;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77AC606A32A;
	Mon, 16 Nov 2026 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WMvK4Oft
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350EA1F000C7;
	Mon, 16 Nov 2026 22:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794869310;
	bh=lpsTlWGvjAU0Wn3LPw9wu5piyyFg2szed2uGQ7R9Gvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WMvK4OftB4Pp355kxu9KCyZ6n0cmwySsSSHPNkJBnXQD4/LroQ6adf5Z/FGzvAV6A
	 C32xYL2FxwPXkyO+fJ8OLnYV0mjSI8lWLxcEpLmXNX893V+Hw++ibUcyK7ezEO/GdB
	 5s4S48pi3SS6cyBOPhLDBh1kK48fAnDOaukCVGs9x2qefopxNPhA13o+8XO1FhvI4Y
	 N0X/jZQ4dXdnHY0I27WHX7HRWg2UWtu5ak0Pw3bhmcJ4IKHdlwkU12gc7DssK8pJyn
	 0BWhSthSGjTayy4FMGYBWtu7BhLRFYaLu1sPwQnM5QfkUsNe/jU7QtnVFs1JIEAj2b
	 oA0Fd8AYVzTEQ==
Date: Mon, 16 Nov 2026 22:48:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64/fpsimd: signal: Require ZA context when
 restoring ZT context
Message-ID: <ee1998f2-69dc-419a-b388-dd4e08cc68d6@sirena.org.uk>
References: <20261110221836.3265929-1-bradley.morgan@linux.dev>
 <20261110221836.3265929-2-bradley.morgan@linux.dev>
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
	protocol="application/pgp-signature"; boundary="ge2qtcKRBItIUjfj"
Content-Disposition: inline
In-Reply-To: <20261110221836.3265929-2-bradley.morgan@linux.dev>
X-Cookie: Madness takes its toll.


--ge2qtcKRBItIUjfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:18:35PM +0000, Bradley Morgan wrote:
> When restoring the signal frame, restore_zt_context() checks whether ZA
> is enabled via thread_za_enabled(&current->thread). However, if user.za
> is omitted from the signal frame, restore_za_context() is skipped entirel=
y.
> If the signal handler touched SME prior to rt_sigreturn(), ZA remains
> enabled in current->thread.svcr from the handler context, causing
> thread_za_enabled() to succeed and restore_zt_context() to write userspace
> ZT data without restoring ZA state.
>=20
> Require user->za to be present in the signal frame before restoring ZT.

I supposed there's an argument that the signal handler might've intended
this but still, this does feel more sensible:

Reviewed-by: Mark Brown <broonie@kernel.org>

though as the Sashiko report identifies we still leave ZA untouched if
both ZA and ZT are omitted from the signal frame.  I'm not sure if it's
safer to reject any attempt to return from a signal with PSTATE.ZA set
but no ZA signal frame or if we should restore PSTATE.ZA to 0, the
former is safer but the latter is more in line with the handling here.

--ge2qtcKRBItIUjfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr7iDkACgkQJNaLcl1U
h9DI/wf9FY3gP1nupEAwgiVs9j711/cjUuKrWk0qj5b+Tr0FYZifkrmIfxhEegJa
/R+MawmDLzP/rTrPfvfQCIajgMVWrhC8c9Uph1I8rnFTVP34R2Iz4s81DtQ0qAXG
+Hf31NdKBOwv3UhzLAz4b+3d+JAz+dmvCesULHxFT8quy7irVBryHKXA81CGkxSA
9NzI4g83BYkefDfuwJYCW8YXHod5LzuaKE2eZJHCzfDOtbv0sc/FheffRhH5Ui8E
I6ckE7I1NnqdP4w/w3vZ0xSAjy7m0CIbsJ6KX2OnyI0lIqr60mIQvh4hyVQt0arC
+7+yBOsaREo5wRKDogroQjRhpyzgow==
=C32C
-----END PGP SIGNATURE-----

--ge2qtcKRBItIUjfj--
