Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7963126DA
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464773; cv=none; b=WWDPOPdrvusHfKcbmzfsj9of8f5jcvk3E9alF+MbcXXRDkgO5B6wHBxe4zQ3dBJdCDA5/039laWShWFe9BGpgluETgdEtb1/I9fdxzTq8OHJgk3FAJJ9MQ6p4sb7HXQc/RmJSkwIieR9mwlMiSdj/4HYDOk4UGDZWxCaXxkcdcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464773; c=relaxed/simple;
	bh=lYMCbtzts2y35poUF6esDzLR/5cazFe2EIHnXzqa10g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cFw3o0C2HLVEWRVnMf7O5xt1flIfZHcZcrFS8gpe2gItmwWoDDgsaLti1EswmSrGITwN5xQMOGQn7c6NEZZyk8UK+WOye1B/SWjmtgFWNu9frA5jqcNK0q+y/R7CTZ/uQeHAmxtY3hYWM4Faj2BF6iFM+nvnm+ZNJbsC9HRhJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NdgWb9kS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NdgWb9kS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RWjY1TKUGF/Kl50g2OYv74usbZ24Y3l69wLSdBVZXM8=; b=NdgWb9kSviE2QCjYelvpBEF8iT
	ur8R1f5g6vgMsvQ23QSkhwBmdNswOPejnrHwcXUU/Id9cAUeeSrc4gZGPiJVvLGcriKvgiB7D6q3u
	brM41cxWBg9ZinYIk1XpoPFC3CCxDHAEox1DLWrKiJN6OrjUZ1jfThZ/f8MzgTVdix9a4sLJhTCLG
	SMx3uGfSi0Lj6onl3uJMxbFvjQaVnlr0eLwxbSpudB0Qcvd1jCuAt502H9jo4HZZqEWHMhlMET9+O
	bO6/g7svrDSb6V4l/wnT2yodxkFvu81agJR3F6SrziZlEZ0KpBvDvsBJhOmt2RbepwtGFnheQOFlu
	DFILOX/g==;
Received: from static-234-112-85-188.ipcom.comunitel.net ([188.85.112.234] helo=[192.168.0.17])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wUeDd-00C23r-TA; Wed, 03 Jun 2026 07:32:45 +0200
Message-ID: <b2342af30ae66a6bdfee7ff2d2389f4f94542b7f.camel@igalia.com>
Subject: Re: [PATCH v4 2/2] drm/v3d: Skip CSD when it has zeroed workgroups
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
	 <mwen@igalia.com>, Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org
Date: Wed, 03 Jun 2026 07:32:35 +0200
In-Reply-To: <20260602-v3d-fix-indirect-csd-v4-2-654309e32bc0@igalia.com>
References: <20260602-v3d-fix-indirect-csd-v4-0-654309e32bc0@igalia.com>
	 <20260602-v3d-fix-indirect-csd-v4-2-654309e32bc0@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El mar, 02-06-2026 a las 14:50 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> A compute shader dispatch encodes its workgroup counts in the
> CFG0..CFG2
> registers. Kicking off a dispatch with a zero count in any of the
> three
> dimensions is invalid. First, the hardware will process 0 as 65536,
> while the user-space driver exposes a maximum of 65535. Over that, a
> submission with a zeroed workgroup dimension should be a no-op.
>=20
> These zeroed counts can reach the dispatch path through an indirect
> CSD
> job, whose workgroup counts are only known once the indirect buffer
> is
> read and may legitimately be zero, but such scenario should only
> result in
> a no-op.
>=20
> Overwrite the indirect CSD job workgroup counts with the indirect BO
> ones, even if they are zeroed, and don't submit the job to the
> hardware
> when any of the workgroup counts is zero, so the job completes
> immediately
> instead of running the shader.
>=20
> Cc: stable@vger.kernel.org
> Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader
> dispatch.")
> Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c | 16 +++++++++++++---
> =C2=A01 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c
> b/drivers/gpu/drm/v3d/v3d_sched.c
> index 47f83936cd73..8a635a9ec046 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -352,6 +352,16 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
> =C2=A0		return NULL;
> =C2=A0	}
> =C2=A0
> +	/* The HW interprets a workgroup size of 0 as 65536;
> however, the
> +	 * user-space driver exposes a maximum of 65535. Therefore,
> a 0 in
> +	 * any dimension means that we have no workgroups and the
> compute
> +	 * shader should not be dispatched.
> +	 */
> +	if (!V3D_GET_FIELD(job->args.cfg[0],
> V3D_CSD_QUEUED_CFG0_NUM_WGS_X) ||
> +	=C2=A0=C2=A0=C2=A0 !V3D_GET_FIELD(job->args.cfg[1],
> V3D_CSD_QUEUED_CFG1_NUM_WGS_Y) ||
> +	=C2=A0=C2=A0=C2=A0 !V3D_GET_FIELD(job->args.cfg[2],
> V3D_CSD_QUEUED_CFG2_NUM_WGS_Z))
> +		return NULL;
> +
> =C2=A0	v3d->queue[V3D_CSD].active_job =3D &job->base;
> =C2=A0
> =C2=A0	v3d_invalidate_caches(v3d);
> @@ -402,13 +412,13 @@
> v3d_rewrite_csd_job_wg_counts_from_indirect(struct v3d_cpu_job *job)
> =C2=A0
> =C2=A0	wg_counts =3D (uint32_t *)(bo->vaddr + indirect_csd->offset);
> =C2=A0
> -	if (wg_counts[0] =3D=3D 0 || wg_counts[1] =3D=3D 0 || wg_counts[2]
> =3D=3D 0)
> -		goto unmap_bo;
> -
> =C2=A0	args->cfg[0] =3D wg_counts[0] <<
> V3D_CSD_CFG012_WG_COUNT_SHIFT;
> =C2=A0	args->cfg[1] =3D wg_counts[1] <<
> V3D_CSD_CFG012_WG_COUNT_SHIFT;
> =C2=A0	args->cfg[2] =3D wg_counts[2] <<
> V3D_CSD_CFG012_WG_COUNT_SHIFT;
> =C2=A0
> +	if (wg_counts[0] =3D=3D 0 || wg_counts[1] =3D=3D 0 || wg_counts[2]
> =3D=3D 0)
> +		goto unmap_bo;
> +
> =C2=A0	num_batches =3D DIV_ROUND_UP(indirect_csd->wg_size, 16) *
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (wg_counts[0] * wg_counts[1] * wg_=
counts[2]);
> =C2=A0
>=20

