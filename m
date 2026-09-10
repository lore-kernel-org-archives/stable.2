Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74739CCE2;
	Thu, 10 Sep 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059373; cv=none; b=LpwZV+YsBAMjf9dCC2+MuVmfaGnpdUxPpPQW2Lgv0b4oXiI8VsNy35vVdfVVNT1djSlS7Ha9mQ56A0QcG4gtTlTCvb+1dmKC8pT5R4GcrjUTDN9WM2rmESP1DuAQaVdx3aXfaj5/OM/wWpAuiOfjNZaSFSqJaNrZzxpu8p45kHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059373; c=relaxed/simple;
	bh=QcFhRK88+b/E5jRc/+kYj47x/P2Hg+ARykNSBWh+CMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN9M72lQSi//CXJyM4rb5QD9lLIj4tu9jQSoAptOHZqUcOlxyWqoepo4dRufqgm/g+b0TN+2Uwp7L6WXK+gRcysjwouZLLKoiYBBvL7yABYO7UNWZqjT+zmIkiP5uMCMivKUNRDs2Bj++a24uSc5gRFrPjkR1wECr8JOV/9PE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYT1XR/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYT1XR/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1840B1F000FF;
	Thu, 10 Sep 2026 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789059371;
	bh=H5qv7SU0WDIL3754Sz2KIRetoEuCaKQJTb8/kp1+BN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RYT1XR/OfF0mS9K7RNsSt0/bIB4tPLioqS6oICC8IIBQHYVfhoUtGXezZnR7dAl+c
	 rFWzFgqOUX4ca86r7skR+88tgY+1ogkZggJmqPnETO8L7QgfniDy2g/o7Y18pUXxsb
	 bFM6/G27KvDldgE/IwzDlrYaZ1ti/gQoZmyuuGAU9OyXJJfhZeM7dLTPnJgKsYWFmi
	 wKWAGiMui/lzpZDf76fBJTyUFLu/Rq18kYGGmUr0p2SOBUpNmY9gHnQMAuwr0ROqn/
	 6RRmm9D08XnbYF8D3KE8lgsE0DMnNnhHE1v3HoHRYQ2+1033JG9Ecp7oP7YCvG8lGz
	 q0jT9Y7FpqKlw==
Date: Thu, 10 Sep 2026 17:56:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Itai Handler <itai.handler@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, michal.simek@amd.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Message-ID: <8fcad389-8340-4ccb-8ef4-008d826115fa@sirena.org.uk>
References: <20260910113325.717882-1-itai.handler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3mhjrI60cxQYt2un"
Content-Disposition: inline
In-Reply-To: <20260910113325.717882-1-itai.handler@gmail.com>
X-Cookie: Gravity brings me down.


--3mhjrI60cxQYt2un
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 10, 2026 at 02:33:25PM +0300, Itai Handler wrote:

> +static void zynqmp_qspi_shutdown(struct platform_device *pdev)
> +{
> +	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	/*
> +	 * Only a runtime suspended controller can be left alone: its clocks
> +	 * are gated, so it cannot be mastering the bus, and its registers
> +	 * must not be accessed either.  Any other answer means it may be
> +	 * running and has to be stopped.  In particular, on a kernel built
> +	 * without runtime PM this returns -EINVAL, and there the clocks
> +	 * enabled in probe() are never gated at all.
> +	 */
> +	ret = pm_runtime_get_if_in_use(&pdev->dev);
> +	if (!ret)
> +		return;
> +
> +	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);

What ensures that nothing can start new transactions after this has run,
and if there's any operations in flight will the controller be OK with
just being stopped like this?

--3mhjrI60cxQYt2un
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqi4SYACgkQJNaLcl1U
h9DtGwf9Hvtmmb3vMcKh7JgRiQb0kCFv9qEx+cbBU1WvojtOeTyWRno1HPM+1Dm4
1a+alpDAO3fkRljzrLYyxHcx61SNwypP85xG7nYIRoLjj85Q0H7rl74tmH4W2KNW
XCdswt1F115sVLVg5Z7a5rv5gyunIjmgqze32jlZQKFkU15oEUsbk3NB1/CbQOQT
Z2QYer07Z/TCA0enUEK6NKJYRDJQJnSgGJBoAvoF5vbn72TLcrHx8vf7i9GZktzl
j8ZPbKqiygHJwpUT0+Qser2009MxBTS79sbGbN5/ESD4eKi59lGRghuhmza22ZFP
nKQ1163hkIr+j+n+ECibjh0si5+eDA==
=ImZb
-----END PGP SIGNATURE-----

--3mhjrI60cxQYt2un--
