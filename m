Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108083;
	b=cIRU1W3pSeVHaz4OGIDhq6ZFs2X3QA+s2Mi26kGVZ3ZWxzbpTCOiGQkdOaSNiISiQaY4
	 Ejg+t5ugSDgnXRexeeik3/rcRFKEEq+8V38zxeb4yuhLLUuEBq9iY1yCgB4QaMFFpJdU0
	 Z13H+OLZzWjfpSuWHkfSLSMj2gXpkgHhhWlMG8UnH3acAvzI/rp8WJw6oLeOg9kFc9zth
	 y0yHmGICDAFjItjZ4n7ABXfQ8iNRP/TiV4SUjpilzDT+nBnWlpN+fAEi9dpLu2ZOMenWZ
	 6f3E08p8WASNENeaeW8ziMg4sX7wJPosfNGW9fkyqMeraA/piRy4T87AnTUYhgPy83Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108083;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=OlMl+wjrZZZe96SmC0aYCjHZm3JeltwEjAI+utZTIlA=;
	b=0aPPtM3nQZ1rROZWuuK3zGwJOPVMmnrWLrjWKF6RiDUGRzwMhT64Y8wRhV86vjXkLO87
	 1YuNWi/bO5rgqDxpIXTqf6yO7TV5oMNGnEcdAtqatr1CBMBoDuUXehNLIoTTaCiBritis
	 3m3Yin4vo3i1nopb3ANZ00SnpbyF4ntXlxOdLCTeYitwAj2rIrjSp0mDkhwo+++f5Ceos
	 xcfBKWVgh76zgkaKslUw2cul/S3rrBvlF1p5/kExD/yVZY+vEBwfP7gIE7KmvfZ8vJc2V
	 8mCNWIN/aXhyhNSpyRCMl5dTBjvFp3w760IN278HxW/2aw8DCChrvsulqloMZ+UpERA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0KY2I5X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F743606A31B;
	Tue, 27 Oct 2026 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0KY2I5X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688541F01825;
	Tue, 27 Oct 2026 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793108083;
	bh=OlMl+wjrZZZe96SmC0aYCjHZm3JeltwEjAI+utZTIlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R0KY2I5XrxNyaKV1l51DNWm4tjcYFdQmpfn3t4yj1rMyGK5bgVebhmHiF4rpeWFXE
	 obLaupP2IGbLpSFQ0hVtBJb5RRWLCMEua3qWo3N05WpyBkE5MIw8tPxMNatzurID4Q
	 u6lOJBiYnSEuLlQpxs2n5CNnc1FtdaPgfLEu3LilvlSgn0maGMQzfqB8nAsm36hd8l
	 gB0TOVGIU4Or5b4sHW3LpZQo8Uz6nc45EsBFHm8cScNHnvh3k8Mehv04fqXvQJc+MH
	 wFQB1VjypIjGeLThbmgchRzqKe+6uLHMewfxT/tpGxtnJAbJZyOfCELA1wpANXdCxD
	 VZY4DM3jPfsqA==
Date: Tue, 27 Oct 2026 13:34:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org, tiwai@suse.com, perex@perex.cz
Subject: Re: [PATCH v2 0/3] ASoC: hdac_hda: Fix module unbind/bind via sysfs
Message-ID: <5b1ffe72-2e96-41f9-8c9d-1cefdac89ba9@sirena.org.uk>
References: <20261027125448.11018-1-peter.ujfalusi@linux.intel.com>
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
	protocol="application/pgp-signature"; boundary="LovERpk7e3YMRTux"
Content-Disposition: inline
In-Reply-To: <20261027125448.11018-1-peter.ujfalusi@linux.intel.com>
X-Cookie: You will be surrounded by luxury.


--LovERpk7e3YMRTux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 02:54:45PM +0200, Peter Ujfalusi wrote:
> Hi,
>=20
> Changes since v1:
> - Add pm_runtime_set_active() after snd_hda_codec_device_new() in
>   hdac_hda_codec_probe() function as reported and suggested by
>   Sashiko Bot.

Please send an incremental change, I already put this into CI.

--LovERpk7e3YMRTux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrgqG0ACgkQJNaLcl1U
h9CLCQf/e9aNaRSD9Q7fb0eEF+mVDu8+RVSsn/jqIHNfSl6t0oS/5jxfg1oH/PLT
b7D1tVXaXeihxSZ6BzO/ETj56ZUp/gnE80IsasOlNh2/CZbLbG6SEdX0DjWYzITH
V9ILnSUZo6pVkeKV9SZWixQ6ZVsh2kWkSLPQ5Ub5my8RnuhuIlzlpKhIHZFwcyw4
Am3z6T6aKoP4qwEKCTlMBQolANqbZSUXZH2IgKePQVTPMADcDHbE9MjX278XSorB
+ZxypYq9CbjKC+PyOxpwIuyA5JM5/tx3NhNCk5tcYlyLwYymf0SvQfVNPc8ZQebx
Eqbn76FGyR+ggOgaEvJHzRrrsB48ug==
=go3+
-----END PGP SIGNATURE-----

--LovERpk7e3YMRTux--
