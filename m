Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826920;
	b=4pEbPjDIXZ4QwJq+JU4b56D6HC3CMM5mwkRVKr45/k2Pp//V/fEJsWIe8WsjhJGQwfBn
	 FEM3+Co4QB1yKPzELJd2/npyQLi1BmoEbvl+DUMzR+CgVHUHvvuUAPbDCpuBOS3BzUzkA
	 e3xP4q4ChDWtkz2fKClSOrTXefwvWfRsUooCTKY0jA4UffrkzFIaiLdZz2rqKUK7gvdlL
	 nkAmTclPas7ETpdVrIKTnb50//vcVa54OQUx2NVF5ECIHxIgDP00Nb9ESVj0IQlPeaHP2
	 xfOmkCBusXmwAYk85OIfkm1tlwuyXT7iEB79c9Zg5/lVXMlde54BbloZj6U7jadgB4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826920;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=Rf8qt+Zh3EUE2lSQ6kbDmdifzLtndza1jl085CZIWqw=;
	b=ZEt0AdwqU1xfATBk7mPSPWjIpPwqU/ab+gOOqs4R3QrZ+cKUZtRAWA1wQ20Bx/FoTb/D
	 RhLiUV+T0DBg1QmEqKcyaxvH/0Jlud0Jp2nfH2veAjFkiZDG6l9OJyhnlxnGRVjEhKkLz
	 m+ug3ZIsnYA2f58Mwc0Gs6sysoGl28XAb3/umZfX8EgI1aKw4AzdFGa1zektkZYnSmgcG
	 mLETMTWFyVfC/g/P2RCe+iPxkdEIz2tE5HnTcz/d5dZB9Wg5DWRs5+tFnXraNfN6Vdj5f
	 OpdZxiPS9ck+BwO+WxJ/RXMGIOfD1Ke+1WU0LyfvY8iKYPa6Vr3417o01e8aAvxkusQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=QabxuAwS;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D618606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D618606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=QabxuAwS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:From:Reply-To;
	bh=Rf8qt+Zh3EUE2lSQ6kbDmdifzLtndza1jl085CZIWqw=; t=1794826918; x=2110186918; 
	b=QabxuAwSteZpDJ+qHNUfOJnOhwvoPeT5XQj6ZMlThEX+m7Bf0aBhLU5X5y+TPz6PVOpIdrOqUF4
	A/PaICJQiu0WntHICTldl7pTha+ZPzHB8Q7R5/dii9OQBFgYGTuNNc3NoK4TWfagpa1vrvxygssi1
	dnPZguz1U982CVR/HtKgziDAst1bJASs53kYVPqc3KSF5GcWhmaslTMQTRJTJX/EjyeXz/C2DnfCZ
	cGDn9ndQ/g9/dRw7Ugc1SUl0Xsl0IvBpMUyZKcIA2F7J9RQJdMzRFhpjZkMqqYDWtwDpghnPM9awU
	Ic4RHHkWOkROVZ/VKH33To36jbjd9UOpUHOg==;
Received: from [137.101.48.64] (helo=[192.168.0.17])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xSuTA-000000009mR-1nOX;
	Mon, 16 Nov 2026 12:01:52 +0100
Message-ID: <08699944b70494159b0f750c1ffb4d8dc14bfe82.camel@igalia.com>
Subject: Re: [PATCH v2 0/3] drm/vc4: Fix async page flip completion
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 12:01:41 +0100
In-Reply-To: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
References: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
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

Thanks! Looks good to me:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El s=C3=A1b, 14-11-2026 a las 16:16 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> VC4 implements async page flips with a custom code path that waits
> for
> the BO fence before completing the flip. On VC4_GEN_4 (RPi 0-3), the
> completion also decrements the usecnt of the old FB's BO. This series
> fixes three bugs in that path.
>=20
> Since commit e8941ac97f28 ("drm/vc4: Remove BOs seqnos"), the
> completion
> runs from a dma_fence callback. VC4 signals that fence from the
> render
> job IRQ handler. As v
> c4_bo_dec_usecnt() takes a mutex, running an SDL
> application with SDL_VIDEODRIVER=3Dkmsdrm on the RPi 3 triggers:
>=20
> =C2=A0 [ 2511.636319] BUG: sleeping function called from invalid context
> at kernel/locking/mutex.c:623
> =C2=A0 [ 2511.636667] in_atomic(): 1, irqs_disabled(): 1, non_block: 0,
> pid: 0, name: swapper/0
> =C2=A0 [ 2511.636681] preempt_count: 1000002, expected: 0
> =C2=A0 [ 2511.636689] RCU nest depth: 0, expected: 0
> =C2=A0 [ 2511.636698] locks held by swapper/0/0: 1, on CPU#0:
> =C2=A0 [ 2511.636711]=C2=A0 #0: ffff000037183198 (&fence->inline_lock){-.=
..}-
> {3:3}, at: dma_fence_signal+0x88/0xec
> =C2=A0 <snip>
> =C2=A0 [ 2511.636892] Hardware name: Raspberry Pi 3 Model B Plus Rev 1.3
> (DT)
> =C2=A0 [ 2511.636899] Call trace:
> =C2=A0 <snip>
> =C2=A0 [ 2511.636991]=C2=A0 mutex_lock_nested+0x24/0x30
> =C2=A0 [ 2511.637002]=C2=A0 vc4_bo_dec_usecnt+0x40/0x124 [vc4]
> =C2=A0 [ 2511.637070]=C2=A0 vc4_async_page_flip_complete_with_cleanup+0xa=
0/0xc4
> [vc4]
> =C2=A0 [ 2511.637102]=C2=A0 dma_fence_signal_timestamp_locked+0x118/0x290
> =C2=A0 [ 2511.637116]=C2=A0 dma_fence_signal+0x9c/0xec
> =C2=A0 [ 2511.637126]=C2=A0 vc4_irq_render_job_done+0x24/0x114 [vc4]
> =C2=A0 [ 2511.637158]=C2=A0 vc4_irq+0x16c/0x274 [vc4]
>=20
> While looking into this issue, I also noticed that, since commit
> 4d12c36fb73b ("drm/vc4: crtc: Move the BO handling out of common
> page-flip
> callback"), the old FB is released before decrementing its BO usecnt.
> If
> userspace removes the old FB and closes its handle while the flip is
> pending, vc4_bo_dec_usecnt() runs on a freed or recycled BO.
>=20
> Patch 1 fixes the use-after-free, patch 2 moves the completion to a
> worker
> and patch 3 returns fence lookup errors to userspace instead of
> leaving
> the flip pending forever.
>=20
> In v1, Sashiko reported that a flip waiting on its fence can complete
> after, or concurrently with, a later flip that has no fence. This has
> been
> possible since commit 82faa3276012 ("drm/vc4: kms: Remove async
> modeset
> semaphore") and isn't changed by this series. The best way to fix it
> would be moving to the generic async helpers, which is on my TODO
> list.
> Until then, this series keeps the current behavior and only fixes the
> bugs
> above.
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> v1 -> v2:
> https://lore.kernel.org/r/20261112-vc4-async-flip-fixes-v1-0-42449a703840=
@igalia.com
>=20
> - [1/3] Add the refcount underflow warning to the commit message.
> - [2/3] Allocate the workqueue after initializing the CRTC, so it's
> =C2=A0 released before the CRTC is cleaned up and named after the CRTC
> (Sashiko).
> - [3/3] New patch.
>=20
> ---
> Ma=C3=ADra Canal (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Drop BO usecnt before releasing t=
he old FB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Complete async page flips from an=
 ordered workqueue
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/vc4: Look up the async page flip fence=
 before committing
> the flip
>=20
> =C2=A0drivers/gpu/drm/vc4/vc4_crtc.c | 136 +++++++++++++++++++-----------=
-
> ----------
> =C2=A0drivers/gpu/drm/vc4/vc4_drv.h=C2=A0 |=C2=A0=C2=A0 6 ++
> =C2=A02 files changed, 70 insertions(+), 72 deletions(-)
> ---
> base-commit: d48ea86919434695da12d280dccab72b094397e1
> change-id: 20261111-vc4-async-flip-fixes-1b1ab17dc795
>=20
>=20

