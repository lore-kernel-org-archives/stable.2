Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC540D598;
	Mon, 29 Jun 2026 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732168; cv=none; b=qaQKkRLaQ+dMB9RHTKk3KuwKi2vmRKcmX/RAlSt8laV8gJ0nyX5AB3dz3bSEENyuWxPjPjIwUNCSqwaNaIg4ke2pvebkbNT103XkjUoPLerpTmne1ATzQdiAECQOyCnduugH9jX4UFZM6xRlobJvIm9+xok4P2MmVN7dE92NZGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732168; c=relaxed/simple;
	bh=R8yifLFnqJzUH1P7/YT0As6VAy6Hi9WFvxUr9kRqlro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+Q2dSkcf9bSrzXRR3EQqmQngPoPyJaISO729WCXqBb1Aa38OocQNs2Dj+4goVKxfKvkgWYU2EHCegVqXvaCCGNroJBiEwGEyoCs6gflOD65leup1RwablHlglIMkBj+/0hLbwAAVYIYj5nnYqhNzBJiBwr4KEUxkoUyCE5KBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWH9tdHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWH9tdHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756311F000E9;
	Mon, 29 Jun 2026 11:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782732167;
	bh=R8yifLFnqJzUH1P7/YT0As6VAy6Hi9WFvxUr9kRqlro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RWH9tdHruTeGVzbeyeLbLoqbO1nAcWOkQJSuM4WbKNBsl3iVLK74M9ilP/FRPx4G0
	 t3k1VVewdOs6kkJz8xnqR7/c53vebvqY0oViszBuygnUkrgbulp6oip8/JX3ugdgN4
	 1wWw3r9n2pW3BNWOmXskqceUlMpFwme/rPVlLHusOAiXC3pJWN/WMuEzE9BO9eSqmp
	 B1urn10a0sksFg7vAVEIFwnlWSXnnQjgGaDKfn6Y2LIo+JaWIrplXJsyyOa9ndFNv1
	 uqY8stpepqBkBsjrFP7J4O205O0XZf7c6657c9Y54k9rFyI3lhILY4xib+jXspUQR8
	 1KMth3GpknufQ==
Date: Mon, 29 Jun 2026 12:22:42 +0100
From: Mark Brown <broonie@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: srini@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fix: sound/soc/qcom: qcom_snd_parse_of: leaked
 device_node reference from of_parse_phandle on error path
Message-ID: <be400453-5df9-4897-8144-34378f8f8d8e@sirena.org.uk>
References: <20260627034915.59929-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YGfqRBIy/LPWFpQ8"
Content-Disposition: inline
In-Reply-To: <20260627034915.59929-1-vulab@iscas.ac.cn>


--YGfqRBIy/LPWFpQ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 27, 2026 at 11:49:15AM +0800, WenTao Liang wrote:
> In qcom_snd_parse_of(), of_parse_phandle() at line 124 acquires a
> reference on the platform's sound-dai node, stored in

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--YGfqRBIy/LPWFpQ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpCVYIACgkQJNaLcl1U
h9Bm6Af8D6UortXePgrmV9GYmLax13roMLkP5TMIkXN4KksLpI9Y/M0Te0AJVoL9
/SLp3akLWnbq01fH59otkW8br8bHfOIfnKBsA/GXn78VKM3gGlWDbUXJjVZTh3du
ToeCNcWfSEOCrIRfN8H6oex2t/ilO5dtMhPUAmrtQGJl8RyOq62WwPBmj3GmRJds
2zmusJYTjPg+MHvmXDsdyAUza2y4CtTfVK45tU3km9EquEraIiO+tQ/HDO00UEoq
apEGZ98iZMI+S+boTrJgnureJ8SShRCrwk/ylscFmBntkc5y6AQshayDXSfZiwG6
BhyPLg15E2miUUme2fwh5GL6mcZigg==
=iXjp
-----END PGP SIGNATURE-----

--YGfqRBIy/LPWFpQ8--
