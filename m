Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1755347BC6
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384264; cv=none; b=ZHe6RZT1Ls+V30ph1/X3Ld5UinJuEhMN0kC+EpIWoHM2neEQC0RcxZnWA7ZgEou7X7StfAAPR9GAlVmZx85y/CimVNi6KCCEaDrjYRFOU2kVI8aasIFvFV7O+sMEOw+VitWUbB84ltOzNduD5g78BNAAWIGOrFCBc5hVe8pkIlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384264; c=relaxed/simple;
	bh=U1zk6Y2TXpDJxdcrfKxY4jbseCRnsIusZvdsn/lnFsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yq6QiH47ywcRTif+AfOL6Or5rvcF1/2IqIuEKn39HWGrT38UqA9VKmoRrXmC2ObDlVCc7njtYcCGMwWbP09aQJX4shech4hqTeadKVKYRBA7PHHycCWvZxf4MSituAFiY75B5nE5HKcKBFNZoWRurdLi1xcXpt1xeh3oEEfEbRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=L3TjL2rH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="L3TjL2rH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0/xmktmPrrIYCJHOQlDHmeOVRloHcWNYMzI+S6Krurg=; b=L3TjL2rHuiSycbWTZmJJJcVe8Y
	1UpHm6fxn4ELXfn3N9loojiTfvGpRtvFl6Vil/9XtvjfbjSb6yTT3zkdtUqJzncouIe85culIX/nQ
	10fqYp9qa5dkxWrsdU1qD7JZ1OMAb77wDwBa53ti70B14VkgGnmIPp0fV/VrSk8q6gkEslMXTxhmK
	wO8QTUrfa8Pw57Gd1VVCSCrDtTT0aaf2zVFak//cH+zCfS5YxTow7LE+B7lrkpZnqZfS49xwRDvPj
	c4pqU0j2UgSQHK6kR/iXKs0FGeDsyx7OGCRso8YZ+92YTWnvlNhBazOiXS7xMCHVBC3Xpk8A/LLze
	dGl9WHDw==;
Received: from static-234-112-85-188.ipcom.comunitel.net ([188.85.112.234] helo=[192.168.0.17])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wUJGz-00BZZf-Vo; Tue, 02 Jun 2026 09:10:50 +0200
Message-ID: <68bb463c77c3d65f23f53b4a2c64fd4547e45aa3.camel@igalia.com>
Subject: Re: [PATCH v2 2/2] drm/v3d: Skip CSD when it has zeroed workgroups
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
	 <mwen@igalia.com>, Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org
Date: Tue, 02 Jun 2026 09:10:39 +0200
In-Reply-To: <20260601-v3d-fix-indirect-csd-v2-2-aaebf035b936@igalia.com>
References: <20260601-v3d-fix-indirect-csd-v2-0-aaebf035b936@igalia.com>
	 <20260601-v3d-fix-indirect-csd-v2-2-aaebf035b936@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

El lun, 01-06-2026 a las 16:13 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> A compute shader dispatch encodes its workgroup counts in the
> CFG0..CFG2
> registers. Kicking off a dispatch with a zero count in any of the
> three
> dimensions is invalid. First, the hardware will process 0 as 65536,
> causing an illegitimate submission. But over that, a submission with
> a
> zeroed workgroup dimension should be a no-op.
>=20
> These zeroed counts can reach the dispatch path through an indirect
> CSD
> job, whose workgroup counts are only known once the indirect buffer
> is
> read and may legitimately be zero, but such scenario should only
> result in
> a no-op.
>=20
> Don't submit the job to the hardware when any of the workgroup counts
> is
> zero, so the job completes immediately instead of running the shader.
>=20
> Cc: stable@vger.kernel.org
> Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader
> dispatch.")
> Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c
> b/drivers/gpu/drm/v3d/v3d_sched.c
> index 47f83936cd73..681d10af4c8e 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -352,6 +352,15 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
> =C2=A0		return NULL;
> =C2=A0	}
> =C2=A0
> +	/* For dispatch dimensions, HW interprets 0 as 65536,
> causing
> +	 * illegitimate submissions that must be rejected. Note that
> +	 * 65535 (2^16 - 1) is the maximum number of workgroups per
> dimension.
> +	 */

I am not sure this description is accurate. I think passing in 0
doesn't cause illegitimate submissions. I think the issue is that if we
allow 0 to be interpreted as 65536 then can't tell if an indirect job=20
actually configured 0 as the dimension. So I'd rephrase this as:

/* The hw interprets a workgroup size of 0 as 65536, however,
 * the user-space driver exposes a maximum of 65535. So a 0 on any
 * dimension means that=C2=A0we have no workgroups and the compute shader
 * should not be dispatched.
 */

With that change, both patches are:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

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
>=20

