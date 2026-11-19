Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089101;
	b=X3VK4gVOTBmuR/+bY18llUa9+QVjdshT3t/z+5cD1PSxi6MGRmK0rMBlxhLxLIrF7gKK
	 kYeIt8vGnVukoCuMRGia4IouDxGJmNg+sIl8OO3liOulwgMJDb420NKbcESiiKpaWifxb
	 anHrikxj0/CJlGWP+5eaHltTW7dRpgD6t4FcdR8TUOxua7lGDbUL2uTXMEgIgKoFPWGUe
	 U1L3EpQLTVhdkWe+eGGwOXSG72QTLAULMFsYfQmN85T/XJf0R5xROn75LgT/CrGyleuBE
	 2RWty/xXlKdVUrkEFUMkbdBcmjCtlJDn4vLTFMGY9dwJBX/vh9PEzG9sWBxMFxmDGdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089101;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=Gaiu6KeZj3bJ+9tvYTb007XoS5/RLmD1wLbF+GZ9AZI=;
	b=fzzY538jGoihuQLdtJFEFExXvlVJxdFxZp9ThIwtl2QDwBvH+fBQ/aW7oOO79JJRRUeZ
	 xKAQFa01FUaJLHczWm7FDhQ0qRspiQulkZeenQ7M6HJTuXFJnosA5GBDGbMAhNv3Pt22w
	 Fu1gMOqlaO5shK6OHrInJ/X1BWSKUul36UyJqz2P9keFKa8oTfG1/JQSEyLkTSf4xvkM8
	 NwM+WQFAWdt8ODIVE+8js7nSteQb+68Qk6txt7MTny2JgdpRRgj+rrIHpH2cqmBcSlfID
	 Ihx4oVa9NQWaLgHzLXJAC+CIbK+Yb/x3c1UCPJ7jb4z+FB47cxy1mCKetx0BiFtJjMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=hSNfNROq;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC08606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC08606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=hSNfNROq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:From:Reply-To;
	bh=Gaiu6KeZj3bJ+9tvYTb007XoS5/RLmD1wLbF+GZ9AZI=; t=1795089100; x=2110449100; 
	b=hSNfNROqZBtpRPZPtaJL43PzHrKRUayUm1VxwbQXzuDWKlGLDbJ4wyN9aOojdWr9roXqqc258wz
	ycbOfF45zxE9pvJPjzPn6UDCsjwKv5c9Kb+7bZV780Szwy0Ei+qKjPSFz2o44dSwLdVvgUMzo4EnZ
	FVe2YrM42jM8yRwYAf6VYKEVRI+s56OPbyGEoniNwedbmuYAr3nP4FTmp93EU5KTeWHAvSDwIZ6MR
	lIc6W4pa6Bya4ncLAj5xUvsA/FfLGlxc3D7zfXENnoZ2Q2mIHxVVp9SJezwJ0UeNNWd2G830JOKSz
	Uv+j47XBVHQQt3HIchXzTgPyqgVPVyFUIBOg==;
Received: from [192.168.12.229]
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xU0fw-00000001R6U-3HR9;
	Thu, 19 Nov 2026 12:51:36 +0100
Message-ID: <cdcb2fff01938818f26a08fff847c711ad7fb3be.camel@igalia.com>
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
Date: Thu, 19 Nov 2026 12:51:36 +0100
In-Reply-To: <584c3855-5fa5-4b06-a95f-c6c0816cea08@igalia.com>
References: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
	 <e945bdd00b4eecec4b7e451e35cb39855ad2e0de.camel@igalia.com>
	 <584c3855-5fa5-4b06-a95f-c6c0816cea08@igalia.com>
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

El jue, 19-11-2026 a las 08:34 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> Hi Iago,
>=20
> On 19/11/26 05:17, Iago Toral wrote:
> > Looks good to me:
> > Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
> >=20
> > I was not aware that hang checks were happening at second
> > boundaries,
> > regardless of the time at which the hangcheck was queued, it
> > doesn't
> > sound like a good idea, so I think it is good to change that.
> >=20
> > On the other hand, now we rearm the hang check every 100ms instead
> > which is a much smaller window. I understand this reduces visible
> > impact of the workaround when the issue happens, but I am wondering
> > whether this alone has any visible performance impact for the 99%
> > of
> > the time we are not hitting the problem, I presume you haven't seen
> > any?
> >=20
>=20
> I benchmarked glmark2-wayland --off-screen (800x600, under labwc) and
> glmark2-es2-drm (1920x1080 fullscreen), which I believe are
> representative applications for RPi 3B+, and I observed no
> performance
> impact. I even tested 50 ms and I didn't observe a performance impact
> as
> well.
>=20
> If you have other applications you would like to see the benchmark
> results, just let me know and I can test it.
>=20

Thanks for checking, I think this is fine then.

Iago

> Best regards,
> - Ma=C3=ADra
>=20
> > Iago
> >=20
> > El mi=C3=A9, 18-11-2026 a las 18:47 -0300, Ma=C3=ADra Canal escribi=C3=
=B3:
> > > Mesa issue #16652 [1] reports GPU resets every few minutes on the
> > > Raspberry Pi 3. They happen when text labels are drawn over their
> > > shadows:
> > > two different threaded fragment shaders, plus untextured single-
> > > threaded
> > > ones, in the same tiles.
> > >=20
> > > During a hang, the performance counters show four QPUs fetching
> > > instructions with 0 cache hits, ~6.5M misses per 100 ms, and 0
> > > valid
> > > instructions executed. This matches HW erratum GFXH-16: the QPUs
> > > of a
> > > slice share one instruction cache and can livelock, evicting each
> > > other's
> > > fills. Since shader code always starts at offset 0 of a page-
> > > aligned
> > > BO,
> > > every shader competes for the same cache sets.
> > >=20
> > > This series works around it:
> > >=20
> > > =C2=A0=C2=A0 - Patch 3 starts each shader's code at one of four offse=
ts in
> > > its
> > > BO,
> > > =C2=A0=C2=A0=C2=A0=C2=A0 spreading shaders across cache sets.
> > >=20
> > > =C2=A0=C2=A0 - Patch 4 clears the slice instruction and uniforms cach=
es
> > > when the
> > > =C2=A0=C2=A0=C2=A0=C2=A0 hangcheck finds no progress, and resets the =
GPU only if the
> > > stall
> > > =C2=A0=C2=A0=C2=A0=C2=A0 persists. It is meant to recover from livelo=
cks the offsets
> > > don't
> > > =C2=A0=C2=A0=C2=A0=C2=A0 prevent.
> > >=20
> > > Patches 1 and 2 fix an off-by-one in the shader BO handle check
> > > and a
> > > NULL pointer dereference in validate_gl_shader_rec(), found while
> > > working
> > > on patch 3.
> > >=20
> > > Tested on a Raspberry Pi 3B+ with the issue's reproducer, 4 x 15
> > > min
> > > runs:
> > >=20
> > > =C2=A0=C2=A0 without the series:=C2=A0 29 GPU resets
> > > =C2=A0=C2=A0 with patches 1-3:=C2=A0=C2=A0=C2=A0=C2=A0 0 GPU resets
> > >=20
> > > [1] https://gitlab.freedesktop.org/mesa/mesa/-/issues/16652
> > >=20
> > > Best regards,
> > > - Ma=C3=ADra
> > >=20
> > > ---
> > > Ma=C3=ADra Canal (4):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Fix off-by-one in the s=
hader record BO handle
> > > check
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Check for a validated s=
hader before reading its
> > > thread
> > > mode
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Start shader code at va=
rying offsets in its BO
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Clear the slice caches =
before resetting a stalled
> > > GPU
> > >=20
> > > =C2=A0=C2=A0drivers/gpu/drm/vc4/vc4_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 43
> > > +++++++++++++++++++++++-------
> > > =C2=A0=C2=A0drivers/gpu/drm/vc4/vc4_drv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++++-
> > > =C2=A0=C2=A0drivers/gpu/drm/vc4/vc4_gem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++--
> > > =C2=A0=C2=A0drivers/gpu/drm/vc4/vc4_validate.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++-----
> > > =C2=A0=C2=A0drivers/gpu/drm/vc4/vc4_validate_shaders.c |=C2=A0 7 ++--=
-
> > > =C2=A0=C2=A05 files changed, 79 insertions(+), 23 deletions(-)
> > > ---
> > > base-commit: 80ac6d197218c3399d66674167a4d7c9051a25e2
> > > change-id: 20261112-vc4-icache-workaround-d11b444bc7e8
> > >=20
> > >=20
> >=20
>=20
>=20

