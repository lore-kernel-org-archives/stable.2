Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ECB50B436;
	Tue, 29 Sep 2026 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679759; cv=none; b=MQwyoR1RzqF53To4iUs0d1FEHrLqIHpm6SvOOn8PQT/WA6IcePSy5+gPY9p8MhprVhkve0Vc2v+TQfQD+1Kff438Q25xjqjR3epK+/91SyLXXUZYEtiruLybPNgcwLaMl/iS5r0mLULnS/yUa0cs8kYKPGbulDBqiG45ZvYOack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679759; c=relaxed/simple;
	bh=yfnmBikHH0Yas97cfbcbFA+Fw4YiotutxcfyfOEU43g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc07k7pgwLNmXo6teSCRadvIebExV5snibN8O3M5kzoht6MRln0pQhfS2YEY3/x1dEtCuY6o5rL0OxhJfUTk7JD5RpaquhZ0vrrUsAlNcar9E4EwmtT/4claYa6qSsEqRdxdUVq4HvMoRCqN3m+nsW3iZt5jNJzvsLYUBL+z7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQbGaRAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQbGaRAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322CF1F000FF;
	Tue, 29 Sep 2026 11:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790679757;
	bh=yfnmBikHH0Yas97cfbcbFA+Fw4YiotutxcfyfOEU43g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RQbGaRAN3KwjlmBPl0EKSRcXsx98TOQpxcuUCImTAIgXBzNDnvMo6RdgnkQwyJ12d
	 atPfBc7cgFiigMQ3uWhqybGcJjhdPjzO4Z6YR3v3vquckRDVmHATHi8BFRX3NCLtRV
	 9zkCWV4co7pp2t24wzyR/ARmxQUntFU6ggHRCsyHV90enV9Awdug0SYvAaQLuePfCy
	 U0k9XlHQlaY+QK6G+j9PDiI8mhAG24IF06vmJ10XULWP1kp6zYumZGlsPAn3I0p+Dz
	 1YEO7tKYnM3wDy9Y78Z6wK78GMIFIe6P5Hwj1KEdT5H9g3nvYTdRgsoFlcJZeVDshl
	 1KQygupf9lDQw==
Date: Tue, 29 Sep 2026 12:02:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: wentong.wu@intel.com, lixu.zhang@intel.com,
	sakari.ailus@linux.intel.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] spi: ljca: validate the response length before copying
 the data
Message-ID: <5383021c-7ace-468d-b2e0-0d000be2dc77@sirena.org.uk>
References: <20260929080126.4168981-1-liuwb@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k7pfDg9Xq0NVk/ML"
Content-Disposition: inline
In-Reply-To: <20260929080126.4168981-1-liuwb@xiaopeng.com>
X-Cookie: 1 bulls, 3 cows.


--k7pfDg9Xq0NVk/ML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2026 at 04:01:26PM +0800, Weibin Liu wrote:
> ljca_spi_read_write() only checks that the response from the adapter
> carries the packet header and a non-zero payload length before copying
> r_packet->len bytes from the response into the transfer buffer.

> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> prerequisite-patch-id: e48582f6ffe124b3806593af6e22b74682c8a83f
> prerequisite-patch-id: 369f74b9a7ecde56141b13ec671f9200345a3bab
> prerequisite-patch-id: cbf6f60473c80add5b2cddf22d142f35a4e3c834

Why would a change like this depend on out of tree code?

--k7pfDg9Xq0NVk/ML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq7msgACgkQJNaLcl1U
h9Arrwf/Z1mxEH/gL+wvPrIRm6soasp+fv2TdtcCF2L2N4RVSt5lqK0R8JQy4nJY
l0gNEiuLjSrv8wIpT9qvxHdafwIA1mbRU1lVzMDf4Uy7DkyN+qeo6GQtfJR5k3Gq
Gff4M2TGCMSS5exBCzFPqHo6/Yb2B1AnqxZK7YmghBtDaPuMfXquG/mSttl7E6U3
vz7wbEVQ9kBaBvCg5Cc44JolTpd/qnDQktBnHx0MaI98qWPcPlJmvjqI3NN8oW3g
S/A7gvuGqKeS7fzRgFEEFP8qXAnpZa8sAba4vCrwj2JIJwDu9JDFtX83MpXjzNZB
qVvgMD1olm5cWgqelT5hoILSWO/hdg==
=emni
-----END PGP SIGNATURE-----

--k7pfDg9Xq0NVk/ML--
