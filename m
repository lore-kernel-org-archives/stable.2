Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274DE26D4E5;
	Wed,  5 Aug 2026 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926309; cv=none; b=RJ5rUx3PBgfmkQ9b3FjjTwkT/4zzx8G/wdp3vxcuLo2xHAbU1vLk68Ghgj8Ot0QbC6fnbFz4yHKymq+Boq2+nFcNeVEdnqf3T9JqOdUKeWf9UsSJqKOSobgHhOU65aRsvORiELjeX6jzLKSrUSaIQjSQWTeggL74/Evx4G7FGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926309; c=relaxed/simple;
	bh=n5NR0+2Zm2gD0BllD5WjS+wS9uYbUpL7jUazf7CLUNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHF3OdJrq3TNcx4QSir0TGs8dge+i45k0j9HU7A27R0lAJ/bb86IBqx8colhvrTVLakbuB3zCgzlATqs/k+TIcOlcZqXrfxSXeXP5mqv6zKpahdUrzQs5XUW/grBjAZ7gDdTsJrq+Sq8QwMMjE3Pw6PIvdSQWnvJivp3e5f42yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw2M5gvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw2M5gvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F111F000E9;
	Wed,  5 Aug 2026 10:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785926307;
	bh=n5NR0+2Zm2gD0BllD5WjS+wS9uYbUpL7jUazf7CLUNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jw2M5gvD9sDKV8MrxGzq9R7/ubWQg/pNQDYOcmZUJ8niMQV6IZhSIE3BYpIZbZXtV
	 ataq3KhfJRWuNeqR4l6LWqI3V8jyRevixuuxtVGuUi2PKw85DDeMPUqK8m6TeaFIob
	 cR6yQMplKJzUNVHzKuH3BCLBHPPHwoZa551zGvaO0xv1Nc9Pm+rsJvajZUq37cefJA
	 Fzw9mXvXno8HogFGg1mgBQ2MIm2YllsVEQfcQ8Zt9WsthUYp7Uvx74ReDfVE9YJVOL
	 yzWZ7QYotwvuWJn8LCfiu/ZaQOUlnJ1/5uTWHYWEwlfnl6h1dqmrKRIxkUXoeUK+nz
	 GFyJGo89w6sPQ==
Date: Wed, 5 Aug 2026 11:38:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
	Paul Handrigan <Paul.Handrigan@cirrus.com>,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
Message-ID: <67e766e8-6fbb-4f84-9bca-ea5bd1145c03@sirena.org.uk>
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BAoF9D0HFNL3ES48"
Content-Disposition: inline
In-Reply-To: <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
X-Cookie: Stop ahead.


--BAoF9D0HFNL3ES48
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2026 at 10:40:46AM +0200, Pierre-Louis Bossart wrote:

> Wow. Would it make sense to have a regmap helper to double-check the
> addresses are indeed in-order in those reg_default tables?
> I am not sure how this requirement can be enforced by just inspection, a
> warning would help detect this sort of issues on more platforms.

We could also sort when we copy the defaults during device init rather
than warning, at the moment we just kmemdup() the defaults array which
we later do binary searches on.

--BAoF9D0HFNL3ES48
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpzEp4ACgkQJNaLcl1U
h9DXSwf+OxfrcyQ8QMma/J/ZUy0bAz22/Z8l5taFy50o8/prdlymsdzcF5uPqEJz
zkR+mGSOpdGiRWZ1BCbkf6G73RBkvjPxmzRYYblbuNaq53vZOY7T5n7hlxeWObvT
KGaF/5JNdQztTmMdWcIAMu4GDF3grcoNKynuqYPOxErAOSpTiTiGNJO9YB9V/fF4
OEkZbAcY5q9oAXFIMYsU92NC2Q37IdOd800R2qwFWUKUMBsid40sia+ikqpVA0SY
k4fLas1UXXADrvd5RyUVVRv1XmRTrgR/2x0+y5EFTMR9DMouOFi1NOKa658L4Htw
1vTU6X1GGAMnQ52FiISHJav2B8nCQw==
=FWd/
-----END PGP SIGNATURE-----

--BAoF9D0HFNL3ES48--
