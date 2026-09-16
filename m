Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0D409635
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548152; cv=none; b=Lo39AWSGflJxsYhyAOvcavQNtMu+/ihQK9iE8fU07sNMAx/icSZq4FI06XCXV1M31ogrrNTYRIhR+OgjD3RAF+bE0/nXJzkVJah1G2X/00RQ26KB/cL6RxUgYv20E1JIa8LTbOmgZv9gCcB5OZ+l2psNLcc5PLKsGlwOpTrVJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548152; c=relaxed/simple;
	bh=D6NZHYq4FbQZ9toG/LH0NehHHejqSF3BJaL30p4ZjmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tt8qfYxCnM7WxxtDjTV78hfxsY9YvhKlr5WyFi0rCGyFHueqghP7jugVh1mY9LXCAUlT13B8614UFa3dMb/CozRVnl/S+xxhJfp12guOlVzf2770waN5UWfns9TXhXuYWG31p8R6QrDtOi4M2WO9J4pBZiw3wk690Vng8u5Qty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=esIkqIBf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="esIkqIBf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=bMpk
	iLXAs1S7uCwR3mWvfCw/KkzIFDc5McFUB0GAy3s=; b=esIkqIBflSdVTbrwHuFe
	SAfngbpBJDlVecILk1Z4TRTXfLC6B9zwqxs/p26k+JwAwmOf5afLIlmeaWxVMwaD
	EpT67oJ5yayn/ZGmsEy4MorM6rkRunefFFyx3qPE4dGTJOjX88+6kKwNzUvt8f8b
	LYt6G4Wq+IWbtf7Cu8qvubxy6ooit78vArnIaeU3vy97kAf/Wu/jg7ZIwUWOXI8e
	YsbXHlfHcEu/UqAUw2K22hUIEw2xS8eXs0yM4jm100e+3dEoD8rqzjrpiWKA+WCQ
	5PAvmFqo7tpQLdujhFJNn+xZV51hkF6xcgxl9Eg9G8o/wpiP5/uGqPFfutChDs/W
	Hg==
Received: (qmail 1468569 invoked from network); 16 Sep 2026 10:42:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Sep 2026 10:42:24 +0200
X-UD-Smtp-Session: l3s3148p1@KCttpZVbrqQujnt4
Date: Wed, 16 Sep 2026 10:42:23 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, geert+renesas@glider.be,
	laurent.pinchart+renesas@ideasonboard.com,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com, vkoul@kernel.org, lkml@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] dmaengine: rcar-dmac: Fix runtime PM leak in error
 path of channel alloc
Message-ID: <aqpWa3mwvuPAMhC8@ninjato>
References: <20260915035602.1724403-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dqWapBZZZ9FvyIiZ"
Content-Disposition: inline
In-Reply-To: <20260915035602.1724403-1-vulab@iscas.ac.cn>

--dqWapBZZZ9FvyIiZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 03:56:02AM +0000, Wentao Liang wrote:
> rcar_dmac_alloc_chan_resources() ends with
> "return pm_runtime_get_sync(chan->device->dev);".  Even when
> pm_runtime_get_sync() fails, it leaves the device's runtime PM
> usage count incremented, and the negative return value propagates
> straight to the dmaengine core, which aborts the channel
> allocation without ever calling device_free_chan_resources().  The
> balanced pm_runtime_put() only happens later in
> rcar_dmac_free_chan_resources(), so the reference is leaked
> whenever resuming the device fails.
>=20
> Use pm_runtime_resume_and_get() instead, which drops the reference
> again on failure and returns 0 on success.
>=20
> Fixes: 87244fe5abdf ("dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Co=
ntroller (DMAC) driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Thanks for this patch. This is a duplicate of a previously sent patch
which seem to have fallen through the cracks[1]. I will resend the old
patch, but thank you for pointing out the issue again.

[1] https://lore.kernel.org/all/tencent_71CC9630D88A8792C2396A8844DCCD5C6D0=
6@qq.com/


--dqWapBZZZ9FvyIiZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqqVmsACgkQFA3kzBSg
KbaZEw/9HqVbLojdTQX+ciNNVmWuuU0dhqJuyJ+e2BTdmz1wdjK7TijWvFTZsTTo
o62gk2M2CJ1tvVakc4fioorLPOrhS3A/fDUztr5dDfd3/zJucTuiwDzDrLiBJlzQ
uGCZXIeD0csYqe4g+rVcSPRE8AVuhaKgnZZnUa8ZmVyBYx3AcPHj6J3j1JjnuzC0
8qgup3sy+LXOHM3QDNUrFJeU+Zbq8Vg8Ou/Jkf1PnuCY9mAx8yQDJrYLygmO3lnz
ORHH7WZ2uYkNLZCrUppiGUFrLqZAgHODpFQw/VRMldtV1skB4CDWRiMPLnJAvWay
Z6xP8YZi/6RhLUePubrPXLSDMMlriKLPDeLHZwlRZwRrXXOvwhYUUhXfCvjDLA7v
Acd6NX10xxSUWt+MGk6je54DXVCIt2VMojvcSxzbkBmwFpk5ho2cuC+vvM84eDJ2
kJNaZ/07Z8pXekW/FH2qJ2ISg7EOGgSyDqAQufTBP4AYe/4xf/EJBUJ8UWZecsGV
3Jwpp+4KJGJuQAfvwaAIIC74iREF6c0oZve8VSFqnzznr20cO7z/a7KZAo6fiY3d
HkF3x3Gcsp4CNZkGsWeWWMlt9y8pXO0p01h8nCQI/AuICHF4peTSn5e1ePGyGQHU
E61nJD/4feZWwwLnk/i7C1Y+qaqfquFnywJPoJz2VU/aMhSrxdU=
=ucFd
-----END PGP SIGNATURE-----

--dqWapBZZZ9FvyIiZ--
