Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB005540BB;
	Wed, 14 Oct 2026 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991183; cv=none; b=DphjzRLxJBs77bb5c8YvQNFwHGqmE4/th8p0nP7GjC16L/mjHbeZHhMozLHujeWPwtqNeL/pnYTuvePzmk4w/kDUIuOTLon9M0aopT9GrQeRyqxQomuYizVMg8txoGQaBipqCXgIob6r+nk82/plJxIVdNy1zhFkvaqeGfXNeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991183; c=relaxed/simple;
	bh=7t+/fAPx0jlW2akccU0oDtRtmumwPZSbAcQoZF+11II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcFQ/+otNgqY26Ei3d4oZ8ReRWiiUQjkroqsjqxPn26qLpREvKEvRbk946f9v5/I5qXRchrxxgVN9ixznxe7yL7nV9GI0xftdz48wfADTNqHbQMekw7w3jeafRcqucGRsEFWUMMmn7AMViLzlLYCxSdCYzyEAVZLfLsnb/iik40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0qaqt73; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0qaqt73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5D11F000C4;
	Wed, 14 Oct 2026 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791991181;
	bh=m6RXOM6rLUuxQkgevGtaVMSw7vqWJcKwyDPrq2wH0M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e0qaqt73HAKvo1rgdpTKX4ou/a7zDR6Er3kXlOYIJ/JDGc2ajkIuHn4Rnfh4p+C3C
	 /PjlblGYt0F+GtF4sPUSfn4CBKutk/LrSPC5Tn0kp2wMAdAUMmvmv1Mb5r9jt+sYNs
	 bYtLQ6JTSm1/0DhBfb6TNwgRgf9d4Eh384z5VRbU4R8JggkQv9mSYbZXlYItlE9NOV
	 LQ0GHwQBbFLlC968pQEjNwpxdOw1w1s3WJRV3wWAuKPMVb0yENguru70YhUm3QE8Dc
	 opwiGfw0Ex3kzHuWshpalnKTFK//b6jW/oWaThQS6ECnoSnvkGk8ebnSXJrDQH8Nvp
	 CjRhGqEH4jJaw==
Date: Wed, 14 Oct 2026 16:19:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: zhang.lyra@gmail.com, linux-spi@vger.kernel.org,
	baolin.wang@linux.alibaba.com, orsonzhai@gmail.com,
	linux-kernel@vger.kernel.org, Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: sprd-adi: reject transfers shorter than 4 bytes
Message-ID: <5e662ac5-efea-46dc-bd09-88a5a4841851@sirena.org.uk>
References: <20261014-spi-sprd-adi-minlen-v1-1-77fee7e64259@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iUgR7dMVJwlAlFqp"
Content-Disposition: inline
In-Reply-To: <20261014-spi-sprd-adi-minlen-v1-1-77fee7e64259@xiaopeng.com>
X-Cookie: Live free or die.


--iUgR7dMVJwlAlFqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2026 at 10:00:38PM +0800, Weibin Liu wrote:
> sprd_adi_transfer_one() dereferences t->rx_buf and t->tx_buf as u32
> without validating t->len. The SPI core does not enforce a 4-byte
> minimum, so a transfer of 1..3 bytes (e.g. via spidev) makes the
> driver read 4 bytes through (u32 *)t->rx_buf and store the result
> back, and on the write path read two consecutive u32 values from
> t->tx_buf. With a buffer allocated for fewer bytes this runs off the
> end of it: the read path reads and writes up to 3 bytes past the
> allocation and the write path reads up to 7 bytes past it, corrupting
> adjacent heap objects.

> The ADI protocol only supports 4-byte register accesses, so reject any
> transfer shorter than 4 bytes with -EINVAL before touching the buffers.

Does the same issue not also apply to any transfer that is not a
multiple of 4 bytes?  The driver looks like it will only work for one
very specific device, it only accepts reads or writes that are exactly
four bytes but isn't enforcing that very well.

I also note that sprd_pmic_spi_read() appears to be passing words not
byte lengths and will get broken here if it uses this controller which I
think it does so there's some more substantial changes needed.

--iUgR7dMVJwlAlFqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrPnYkACgkQJNaLcl1U
h9AzfggAgeMKhCm63kFq8mXNd0fol8JZLihFS+LcNvFTam/zBFhFFadRHxfrX8A+
D95V2XRmf0+FvLiClAUEX1oN5CDbrAEYl67VBEVKbhokgEbQR4WXTim+ORKYToTQ
3dpnKI1Qq4Pe6CzGcAqeu5n2nslaSI2F3WZf0Z1ILwrxTREKW9HGg+jh7AORmnSe
r+qyN0eXyJvlKPOz9AMBE4/bIlWoWYBPZypIswH3IM8AzkY1yq/aFDRc5q0Kb5Jg
Spx+ByzKYU4NtbsM89u6+016J/IMHcqAZvUclz5fSPqQRi3LkKSG9+pwt5BozLsK
x5J8oGH4yUaaMkKK3Rexa0QmE0GKUQ==
=5YPv
-----END PGP SIGNATURE-----

--iUgR7dMVJwlAlFqp--
