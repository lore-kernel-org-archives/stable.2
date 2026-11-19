Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076283;
	b=Pnm8llXx5LR4RQh3xZYzQOqaW8NuoJaEFQ/0Uq4MK0L8/xaaapAW38GP084KFA6xf0d2
	 astl0rnqDZ+56QyZNSn0okFWCb+yV8jgnEy1FsKZeC3mLN5kgUD174Liarwo2JlfBxn7D
	 a+HCtsRdJSVc46NfDshyE2jDq11mlYJaXuL+9m9qiRJ6gGaDgtYmkrOC9XVAOhIoFY9QL
	 KDENySwjdFh6K4YlcAn3KyMSefLj1lNXQoiv7JI2JtSDsfRJvDlv/we7NG+Ec6cBXk5W7
	 RbKQxzLG9RA4iEmy1LuA9yDxdWLh2oDGE5gPgdLeYcqZNnwWXTxx2gvA+8zQ0XzFdwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076283;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=cKNnXRxwc7qIR50Hs6GqKcaRO1r0IQSK7B3OlbA6Vhg=;
	b=Xv1/7y+uIpfZ9XeFvvY27gq9MvRugq7e9Fr0aCm/MCsiF78fbQXs3YMVUksRP+f3hkm8
	 sSKRHDHZ1K7fHt/4/xaMCr0poWbLVdDgh0Z7Who68Sw+iS1Y4Mpor2wgFjA0TrMwohCjh
	 77sLykXEGBq7p/cp9Ba3EQoun6Ixie/D+Ie8yGX1Ui0bX7iELYpYumyo9mFuK7VpsPq/S
	 bMIjNqiqVXaCsGlKUutXXOWBaQXhI8TTgTuMHbQp2sIzw6VDqtOAQR3yRAf2OgOBZn8Jj
	 RKOnvNMLfFQ68ONTsON/vKA6xS8c+YsoLVyV9BUCSUzsZXfWbQnAFoKGKxA8mGWoOpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b="r2A/7JdZ";
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D88606A335
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7D88606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=r2A/7JdZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:From:Reply-To;
	bh=cKNnXRxwc7qIR50Hs6GqKcaRO1r0IQSK7B3OlbA6Vhg=; t=1795076281; x=2110436281; 
	b=r2A/7JdZOXtje6IpUxsYqU9+UEOXjPgPNVMeICR4ddZOJ0q3boYVwmLCHWYEWfLQQFFCB86iZqa
	EGV7zUIrFmEsdy/V4zEfBsII5GJ+6/605mPHdFOSVjM8N5nuYch4kS+s27yN1mQKsC52h/uvjHxvl
	4y0uqE7Gky+S8l5vZMjHE83MwJHSVrOakKhhgYRv346U3LcB1iiQ5ho1BAMuyLxmJxY9vQTr0JJcg
	My/PcEzvQVHeKe/k7oAC6ZDCCRdeXEGP0hfh3ykqMq0wfFu7MvrRBHjKQQGHoRSL+0PqPrTkjYp33
	QPomXC5LleOcvmoL/MjQ+2A3i90L1w5xqMCw==;
Received: from [192.168.12.229]
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xTxLB-00000001MPj-3hij;
	Thu, 19 Nov 2026 09:17:57 +0100
Message-ID: <e945bdd00b4eecec4b7e451e35cb39855ad2e0de.camel@igalia.com>
Subject: Re: [PATCH 0/4] drm/vc4: Work around GFXH-16 instruction cache
 livelock
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, "Juan A. Suarez
 Romero" <jasuarez@igalia.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>, Maxime Ripard <mripard@kernel.org>, David
 Airlie <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org
Date: Thu, 19 Nov 2026 09:17:57 +0100
In-Reply-To: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
References: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Looks good to me:
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

I was not aware that hang checks were happening at second boundaries,
regardless of the time at which the hangcheck was queued, it doesn't
sound like a good idea, so I think it is good to change that.

On the other hand, now we rearm the hang check every 100ms instead
which is a much smaller window. I understand this reduces visible
impact of the workaround when the issue happens, but I am wondering
whether this alone has any visible performance impact for the 99% of
the time we are not hitting the problem, I presume you haven't seen
any?

Iago

El mi=C3=A9, 18-11-2026 a las 18:47 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> Mesa issue #16652 [1] reports GPU resets every few minutes on the
> Raspberry Pi 3. They happen when text labels are drawn over their
> shadows:
> two different threaded fragment shaders, plus untextured single-
> threaded
> ones, in the same tiles.
>=20
> During a hang, the performance counters show four QPUs fetching
> instructions with 0 cache hits, ~6.5M misses per 100 ms, and 0 valid
> instructions executed. This matches HW erratum GFXH-16: the QPUs of a
> slice share one instruction cache and can livelock, evicting each
> other's
> fills. Since shader code always starts at offset 0 of a page-aligned
> BO,
> every shader competes for the same cache sets.
>=20
> This series works around it:
>=20
> =C2=A0 - Patch 3 starts each shader's code at one of four offsets in its
> BO,
> =C2=A0=C2=A0=C2=A0 spreading shaders across cache sets.
>=20
> =C2=A0 - Patch 4 clears the slice instruction and uniforms caches when th=
e
> =C2=A0=C2=A0=C2=A0 hangcheck finds no progress, and resets the GPU only i=
f the stall
> =C2=A0=C2=A0=C2=A0 persists. It is meant to recover from livelocks the of=
fsets don't
> =C2=A0=C2=A0=C2=A0 prevent.
>=20
> Patches 1 and 2 fix an off-by-one in the shader BO handle check and a
> NULL pointer dereference in validate_gl_shader_rec(), found while
> working
> on patch 3.
>=20
> Tested on a Raspberry Pi 3B+ with the issue's reproducer, 4 x 15 min
> runs:
>=20
> =C2=A0 without the series:=C2=A0 29 GPU resets
> =C2=A0 with patches 1-3:=C2=A0=C2=A0=C2=A0=C2=A0 0 GPU resets
>=20
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/issues/16652
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> Ma=C3=ADra Canal (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Fix off-by-one in the shader reco=
rd BO handle check
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Check for a validated shader befo=
re reading its thread
> mode
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Start shader code at varying offs=
ets in its BO
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Clear the slice caches before res=
etting a stalled GPU
>=20
> =C2=A0drivers/gpu/drm/vc4/vc4_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 43
> +++++++++++++++++++++++-------
> =C2=A0drivers/gpu/drm/vc4/vc4_drv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++++-
> =C2=A0drivers/gpu/drm/vc4/vc4_gem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++--
> =C2=A0drivers/gpu/drm/vc4/vc4_validate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 17 +++++++-----
> =C2=A0drivers/gpu/drm/vc4/vc4_validate_shaders.c |=C2=A0 7 ++---
> =C2=A05 files changed, 79 insertions(+), 23 deletions(-)
> ---
> base-commit: 80ac6d197218c3399d66674167a4d7c9051a25e2
> change-id: 20261112-vc4-icache-workaround-d11b444bc7e8
>=20
>=20

