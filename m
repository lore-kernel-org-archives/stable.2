Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272722;
	b=t6EBtCp6HhFlqYTTtZDWuZWi9mTWawV7PU3Aqgg+3quPWEhPZ8Td2QB+Phi9u2sPpUWn
	 +uj1LARlmzumnJuFtDKhb+WBJQkmrWkYa8FwxL3sRatmUH7jbUGxrfcN39WuwK7DQFE81
	 JcZogpr5PDyZ7f1JkwjvxNNviNUecgllLT2VLbZtSZGAw8lfWRs+J0mOWOBBTcp6whYK2
	 HJ5FGIS11rG+byRz3OezoPfeMVMb4h+MlVAXvWAPVsvafEP/BYxxGlwNQRqmJJKlI6nia
	 5Vz5Dl/l0yjY90/9HhB781TfY4WfkqdeM0lZzjeCjZ/kJnOYJaeRPzJTKLLXdqG7P5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272722;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=oRzZK2TV472kZHxDJFt7NKBBHWBp2CpJHIed8kBiKzw=;
	b=vhD80Her69TN2KwiaKsGtF0wqId1PUVpYQOVfIQOK1Gl9ptLIdGdSQTh2kF2CkWJP3fa
	 GBSkKRc0J+C5KL5OcemG9D4cbRTwJEjGu1j/G2WRBN8FuddEI7geQqCw53vEg8y/Vl/wC
	 /iziTy52+HOrb1EJS6XR/M+gtSWjrNkWAEJauUIjBZzAlcSKJJYGukcvCn9lO17+SUhww
	 zttRZZRCGTJifwpVfLOjnirffcYX0Vjet1+IggpPPUCew2yyAgPQhBBmFuU2WV00zhvKC
	 A3vcYhfjnECEQ6SmnNWmWCPqIzo/S8CQLNH6oflbljQLcxg7sskLE1i4btKImej3CiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IY68Gxyg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7E606A31A;
	Thu, 29 Oct 2026 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IY68Gxyg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C561F01825;
	Thu, 29 Oct 2026 11:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793272722;
	bh=oRzZK2TV472kZHxDJFt7NKBBHWBp2CpJHIed8kBiKzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IY68GxygSLUt+GAqqR5oqUaK5quHUhxyMViLgDu58VfNFFBHH0J4bpp6Io9yoouTy
	 uqdfeJGUVnwpbFzI8HJ/jJXwaV9sHQnflXzCDU3Bim7HAMXFVRlph8FXnHAvmHqXhz
	 A3FkSnrANIOsBRX4g9bFh/ZHVutwl/vQ0QAT3fLHIgkqRk64ka/QUUgYNdI0vPlDGE
	 2+tDYlTVde8B5HFbsW5bK1g7soB2RQJ2Lr0dlx1XWW3hcGCu3CKT8FD0tzoTJrnWzN
	 HKKWAOn04g/Lx15U2In1IxkcYhgNkjuJzvytsBPxzTCskBevAKCQPiqNN89qeqfUP0
	 NRxbd+bg+Okvw==
Date: Thu, 29 Oct 2026 11:18:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v10] ASoC: wm8994: drain delayed works on remove and
 probe error
Message-ID: <58d8942a-16a1-46c5-87d5-486ae4e756e5@sirena.org.uk>
References: <20261029102515.3417777-1-tristmd@gmail.com>
 <20261029105749.3732334-1-tristmd@gmail.com>
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
	protocol="application/pgp-signature"; boundary="DGKWooc7RhOjjnxM"
Content-Disposition: inline
In-Reply-To: <20261029105749.3732334-1-tristmd@gmail.com>
X-Cookie: I have a TINY BOWL in my HEAD


--DGKWooc7RhOjjnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 10:57:49AM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> wm8994_component_probe() schedules several delayed works to handle jack
> detection and microphone status polling.  If the component is removed or
> probe fails after these works are scheduled, they can execute after
> resources are freed.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--DGKWooc7RhOjjnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrjK4wACgkQJNaLcl1U
h9Df9Qf9EAczEeBJjK/kzZxvH6thCAVJENf6HuUVW4uilNUrApgiqav9st/SQU08
3/bDkzNO11+tUJV8qTVjyoxQI0zNmTf+/d2i4xnNSxY1FbXx59AybbQRVJX0w8aO
H+Sr192DgJQ55HQ/jNw2ZmF8dA28AJIi82w6pTr1txNWAVQK1gPKF8Wm7aADxvyG
I3YfxyU6MD4mzU4dggcARzR3KlnufBSPJpV/Fa2xJ+vA1YgPyF9yNW8W2uUtPPv+
LTCDqpC6b8ATjdpLtikSqxWzeMtW4cSSdgaEuVjDvsqeW7+ZndroFJL8eaKGfmka
QwKgIJAGg8U632Gm5NnQwR/68amUng==
=7xco
-----END PGP SIGNATURE-----

--DGKWooc7RhOjjnxM--
