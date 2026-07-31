Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD63264F7;
	Fri, 31 Jul 2026 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541702; cv=none; b=uJqWWkISwsYXKgJLEPoKa81txywFQo9VD8pv4NPmf+rAZEsIunS0g7w0EM5Kqj5pHh3SuvRotM4Zm1e2RqUYTQzuwYUXwACNDibRnZ8o6S/qyrN+H+ypgEoNIur239vh77L9ssr3flJlda74QczsSZTZZnqbijV2YowcgAmPytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541702; c=relaxed/simple;
	bh=X8ZQJfXgEmkbcqQIy/UagRo89HFMp3llglhOSfO8ObE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjZn6eu5zH/kF87PkB9+fe1MwIcj1H9wgqWk0uvGriLiHRDkPZy3vHnm7y3kpMA5wPVoCIFbOKbcM4mOpZ1efs/i31qfpaYRyJXxYo4UMOjqqEpUx5wYKy1XvF1Cvh5wNwEKlSJuKEu82Dt+FtTubuFrf4lYz3NFkj5x/S8Waz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX4vx5Bl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX4vx5Bl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555121F00AC4;
	Fri, 31 Jul 2026 23:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541701;
	bh=X8ZQJfXgEmkbcqQIy/UagRo89HFMp3llglhOSfO8ObE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kX4vx5Bl801J5l/itzTmAeyDigorc7gsOrQ6x30fFYGGgBGfE0m7nnaVxLGR6+iUn
	 GfvvYtX/JQsHwPzSbBhAgT/30it+iYWGe05GPKbjxlDuWTELqjpc9yeSNpcw/t9eVk
	 sas7MDgLuuUYwWXVz/CF7aJ5CXDqf7zf+uueiGwe4ohgkRpseN21JDZhNqrQxc6PRH
	 GYPH1pAriOaeTc6zhxyDTy/3ZkXBpJfYwxj9fyTRAAcLX4pG2PfWoXubXddUVP09SF
	 TxFhTOp+ipXQS2JuRsDXmPNHcdnbPzBftjEZvqtgZMefJKd/pw905v2vlNnOfjThic
	 FoNRt6Z3MKRDg==
Date: Sat, 1 Aug 2026 00:48:16 +0100
From: Mark Brown <broonie@kernel.org>
To: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	Pascal EBERHARD <pascal.eberhard@se.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] spi: cadence-quadspi: fix probe error path and remove
Message-ID: <6bcaa81c-d52a-4a4f-9bba-8c61f6890fb3@sirena.org.uk>
References: <20260731-cqspi-pm_runtime-v1-0-ff0bfc9e8e56@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MhTmpbPvjrOKzsll"
Content-Disposition: inline
In-Reply-To: <20260731-cqspi-pm_runtime-v1-0-ff0bfc9e8e56@bootlin.com>
X-Cookie: No shirt, no shoes, no service.


--MhTmpbPvjrOKzsll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2026 at 12:53:45PM +0200, Diogo Ivo (Schneider Electric) wrote:
> This series fixes two resource leaks in the cadence-quadspi driver's
> probe error path and remove callback.

This doesn't apply against current code, please check and resend.

> base-commit: 52a355b23cd2dd77b683ed1a1bbe2b7408bd9c74

That's v6.12, that's rather ancient...

--MhTmpbPvjrOKzsll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmptNEAACgkQJNaLcl1U
h9AXZwf/RqngkSyCl/sv9UOXl7fTv7EoEJKvo3TxssSct7DKPc1n0yJ9T8Tppob9
xH7vro+bI59nT2UoVHFK+2v7oeXMePPqP4DmIy+IW85XOft398gTVn+qKrBqUMep
ruuSuFzeYO4N7w0JRiOuDLDID+iLVcjmexv5Ap3hMv9d10nnFrRtB6olLL5ZQGoV
0vaUvxEn/bDM2q0dhiSyDQFEBC/4c12Q6Dn2yseeWJLMYiWPObKxuWi6tmYMH5A2
sSyU/YUpYllBkC3PAYHtiBxZWEGfO8MF170jeen28GalJALfz0yt16/KsJr/SoBK
TCWczEiCopwZKuFgzMxNfTLkU1pnXA==
=9HmU
-----END PGP SIGNATURE-----

--MhTmpbPvjrOKzsll--
