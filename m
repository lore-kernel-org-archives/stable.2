Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893729;
	b=g4PLX7VUz6VbxEYF06sqLnGBcRlOPiMIja4X11vvsnmILZ5K8cHM4JtHU2+18BSD+D4S
	 BIYL3cwa94tJPjr2LfUP6K5/LDDq+2YyLPWJgM1XLyGqk+uhPtNf7K7k5hg1QIsJ3lbCO
	 X214m1Q0c6EqNSwmeRB5U+ncCm1RAosnRCUfLlIS6RetAf+SWtl8Jb0NavHsOb0oF3r7t
	 g6ENcYCrJCKtNhbsc5f8M2zFmYF68avnGnHbdbJ7yN2mON5q+FwC6tVk6KvF7yE1sZmbL
	 9DTc+m45GVSagA5Zm2tL3UV0c/EdZNpT9LkbJd+nMu5xdLOvOq2h/Mcs7VhT7USN9Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893729;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EELEd+r5nqtCd2LwfpyXa+2tmfpHe/VRuZywN1WCL9M=;
	b=l1iNbaY3Lgt+XG5z0UVLmJDbAFZWYTcclrHXNiYq14LzcAjzyTE5wrDQ1Aw1vBKIkQg6
	 vvvtmi95Eds5vTlloYSlB0F4hQfZYg8qDRHFV/VMbbu1Uast8EMJRtynia5NUuFWfV/rh
	 e7EYGPS5mGTwMNnbVyDLQJIwbfmcb2cIm5+wTtxXcqn6wvezRJYgMUMDq/nDWodnQIkD1
	 jW+U8kFFTiWANFtfpIJOZJdZ8PutUjUPZKzIQ/P31Ep5Es8VPHWDkhF/QuOOq2yNcQ8wt
	 LlnbFQjCU3ayrh57WS+gfKPKu9YSvm1Etzv24/k296HqtlpJoor6KW2NJ7XqN8nyiTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQT7WTtr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B0125606D806;
	Thu,  5 Nov 2026 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQT7WTtr
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0B6A51F000C1;
	Thu,  5 Nov 2026 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893728;
	bh=EELEd+r5nqtCd2LwfpyXa+2tmfpHe/VRuZywN1WCL9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dQT7WTtrJrLScexy1kr+2M1bhjqAOJN+sBZSomZhUiCf4jraWR1NMYfFxv6X5QtCR
	 FRnwmoWHvxGRasCmY8mv1Y+uTKjoU1o4RVB1HTdsN2rgj/PmGhU8HdMC1f5ZfnNKuv
	 v9wKZzhmfJPv9V7Q/5T6s46kyYthsAVnvJgfo2693N8UPYz1gOIY6ODpT4P+6UKmga
	 THhKDi4BVhqtv3NmEkjxe2zWq9jaTRLs7OhDJutl3hcVw2u5u/VI+JOD6DHm4/O8gJ
	 s0OtMu/Eb/uCcQecP3jF8pAXef83MYFnx6rr4O/3vGVVE8qQVUYz4833S6bAJTUUNI
	 c+kWGnNt/u5iQ==
Date: Thu, 5 Nov 2026 16:48:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Drew Fustini <dfustini@baylibre.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/8] pwm: axi-pwmgen: Enable clocks before accessing
 hardware registers in probe()
Message-ID: <auylN53GJra88-E3@monoceros>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-5-lee@kernel.org>
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
	protocol="application/pgp-signature"; boundary="opke3hvnxpzc6n3t"
Content-Disposition: inline
In-Reply-To: <20261105143847.2559586-5-lee@kernel.org>


--opke3hvnxpzc6n3t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 4/8] pwm: axi-pwmgen: Enable clocks before accessing
 hardware registers in probe()
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 02:38:06PM +0000, Lee Jones wrote:
> axi_pwmgen_probe() calls axi_pwmgen_setup(), which reads and writes MMIO
> registers to verify the IP core version and determine the channel count,
> before acquiring and enabling axi_clk.  If the bootloader leaves the AXI
> peripheral clock gated, accessing the registers causes an unclocked bus
> access fault.

Do you have the hardware? Or what convinced you that an access fault
happens?

Best regards
Uwe

--opke3hvnxpzc6n3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrspVwACgkQj4D7WH0S
/k4Xigf8CQ9iPLc/5m8kEVyOQIUmGdwcrO8ZhGOhSeif6+taeBnz8hXKQp/I9T77
qWAe2OLEmCi2bJNUfQrI5rqrFyWrVRBcRQmEYEqXmyG+qAW3PMLZVuWaOgsLO1Sd
xF6KEZXDgjapF64LN7k2wczhnyD8+9hUv34EDtU4rbG+FIr2X9gNxSg3zkYBVhCt
MzYfQ7cyKprFFCiu0BE6+Il3cRCvmsOeab75fq6yjpvk5CqsZlBQc/9fI1lyvKmr
AocfA3KsCYy3uZCaUp7ipLsrst24WzXNmTvNjWNaG6cCpS8yBc1iMihQ+onK1jVF
kI7bJ9ybDjjAe9OnHxUHMieTAlQ1cA==
=rcZu
-----END PGP SIGNATURE-----

--opke3hvnxpzc6n3t--
