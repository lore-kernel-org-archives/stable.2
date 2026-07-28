Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8AD3C4B91
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785224910; cv=none; b=ouOphyf/UrlCVjsWVlUg5iTvzmmi7YnWqvcgiJqLG2gluMgNffu1riVyJJ2GSWEIdTfq084r0+ZxIYH78HsgKQMXi/nu5DzddhhTv+uuvWT9QjmqJa/2RLpq1m6gUUlqqYpYGKZF6X1CzmBCcb+lJRCRoGek8/LWJf+vUg2oB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785224910; c=relaxed/simple;
	bh=0FTW1M1vwSsXWY9pXaTg2eN5Q2N5rasmZqzLdtHUg5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=daCkb6HrGRUnWSQwgb5vZWlLFJpEKR6wWOLKs18d34+QjBLvtKtO4vI1y1/miSBSSb6aSLzaTBkc69YvoBa7xzDF52RJ2iDRldwLj5dK7stN+goSmI6ABBoNXTskCiBlhZuwT+lkHtSOp1CjrsRG1fimVsD3TGcvTUYNFQ5ZoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gwEv2jVe; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gwEv2jVe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:From:Reply-To;
	bh=CTmsRrNRSFJr+xugI6KJqr623UH/k8hZaWpMjc/PatY=; b=gwEv2jVeqKNSnVDu2L5A0vD90P
	JvUeZS//4cXhCMnVjO6B1DdCH1kXiEbD6KcPb/9oUmDzOQltwGRdq1ep5kYK5kLQ3R4MrXrZ9NVCd
	nq0OcqDxwNEHTm91NpbFNpSk9r02OWR7e5J8f6QN+McGzPcCKBhso2Db7TpjWGvB4+V6Vtq99wFpK
	7rtNtdYzCXZRPYPdsNnuLyTmxrNbVLaxWBRrO9OVZlG1KcePTtQ8eRGvv2If4DrZf+DQ/hiiibzPK
	hdZUv0DNpZb6+QleOKM1+HZjPG/5mgWPYL6JaQ7ZCBZiE2Fe266WH8YME0PfYQObGquVdwQfU133P
	t+ek0JQQ==;
Received: from [159.147.19.205] (helo=[192.168.0.17])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wocXx-006t0Z-Jv; Tue, 28 Jul 2026 09:48:17 +0200
Message-ID: <6124c03ab6b7a2a4fb885352449b076c30da10e5.camel@igalia.com>
Subject: Re: [PATCH RESEND v2 2/2] drm/vc4: Zero the tile state data array
 before each BIN job
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Jose Maria Casanova
 Crespo <jmcasanova@igalia.com>, Maxime Ripard <mripard@kernel.org>, Dave
 Stevenson <dave.stevenson@raspberrypi.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org
Date: Tue, 28 Jul 2026 09:48:06 +0200
In-Reply-To: <20260727-vc4-bin-oom-fixes-v2-2-0d8a5eddc7c9@igalia.com>
References: <20260727-vc4-bin-oom-fixes-v2-0-0d8a5eddc7c9@igalia.com>
	 <20260727-vc4-bin-oom-fixes-v2-2-0d8a5eddc7c9@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks Ma=C3=ADra, this is:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El lun, 27-07-2026 a las 11:32 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> The binner BO is a single 16MB buffer split into 512KB slots that are
> handed out to jobs at submission time and recycled as jobs complete,
> without ever being cleared. Each slot holds the job's Tile State Data
> Array (TSDA) at its start, followed by the tile allocation pool.
>=20
> While the tile allocation pool is only walked by the render thread
> through branches the binner generated during the current job, the
> TSDA is the PTB's own per-tile bookkeeping and is consumed by the
> hardware itself. Although the kernel sets the "Auto-initialise Tile
> State Data Array" flag in the tile binning mode configuration, the
> PTB demonstrably still acts on stale tile state left by the slot's
> previous user: the binner ends up creating invalid command streams
> with invalid primitive streams and branches, which can cause GPU
> hangs
> as observed in [1][2].
>=20
> Zero the TSDA when the job's binning slot is configured. This clears
> 48 bytes per tile (~24KB for a 1080p frame) in the submission path,
> and
> guarantees the PTB never sees another job's tile state.
>=20
> The tile count is only checked for being non-zero today, so the 8-bit
> fields it comes from can describe a tile state array almost six times
> larger than the slot it has to live in. Bound it before the slot is
> handed out, since such size decides how much of the slot is left for
> the tile alloc pool.
>=20
> Link: https://github.com/raspberrypi/linux/issues/3221=C2=A0[1]
> Link: https://github.com/raspberrypi/linux/issues/5780=C2=A0[2]
> Fixes: 553c942f8b2c ("drm/vc4: Allow using more than 256MB of CMA
> memory.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/vc4/vc4_validate.c | 29 +++++++++++++++++++++++----=
-
> -
> =C2=A01 file changed, 23 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_validate.c
> b/drivers/gpu/drm/vc4/vc4_validate.c
> index 7f2fadfde7a8..d2a65c968b1f 100644
> --- a/drivers/gpu/drm/vc4/vc4_validate.c
> +++ b/drivers/gpu/drm/vc4/vc4_validate.c
> @@ -385,6 +385,23 @@ validate_tile_binning_config(VALIDATE_ARGS)
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> +	/* The tile state data array is 48 bytes per tile, and we
> put it at
> +	 * the start of a BO containing both it and the tile alloc.
> +	 */
> +	tile_state_size =3D 48 * tile_count;
> +
> +	/* Since the tile alloc array will follow us, align. */
> +	tile_state_size =3D roundup(tile_state_size, 4096);
> +
> +	/* Reject configurations whose tile state would leave no
> room for
> +	 * the tile alloc pool that follows it in the slot.
> +	 */
> +	if (tile_state_size >=3D vc4->bin_alloc_size) {
> +		DRM_DEBUG("Tile binning config of %dx%d too
> large\n",
> +			=C2=A0 exec->bin_tiles_x, exec->bin_tiles_y);
> +		return -EINVAL;
> +	}
> +
> =C2=A0	bin_slot =3D vc4_v3d_get_bin_slot(vc4);
> =C2=A0	if (bin_slot < 0) {
> =C2=A0		if (bin_slot !=3D -EINTR && bin_slot !=3D -ERESTARTSYS)
> {
> @@ -400,13 +417,13 @@ validate_tile_binning_config(VALIDATE_ARGS)
> =C2=A0	exec->bin_slots |=3D BIT(bin_slot);
> =C2=A0	bin_addr =3D vc4->bin_bo->base.dma_addr + bin_slot * vc4-
> >bin_alloc_size;
> =C2=A0
> -	/* The tile state data array is 48 bytes per tile, and we
> put it at
> -	 * the start of a BO containing both it and the tile alloc.
> -	 */
> -	tile_state_size =3D 48 * tile_count;
> +	exec->tile_alloc_offset =3D bin_addr + tile_state_size;
> =C2=A0
> -	/* Since the tile alloc array will follow us, align. */
> -	exec->tile_alloc_offset =3D bin_addr +
> roundup(tile_state_size, 4096);
> +	/* The TSDA area must be zeroed out before use, otherwise
> the PTB might
> +	 * consume a stale tile state.
> +	 */
> +	memset(vc4->bin_bo->base.vaddr + bin_slot * vc4-
> >bin_alloc_size, 0,
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tile_state_size);
> =C2=A0
> =C2=A0	*(uint8_t *)(validated + 14) =3D
> =C2=A0		((flags &
> ~(VC4_BIN_CONFIG_ALLOC_INIT_BLOCK_SIZE_MASK |
>=20

