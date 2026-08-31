Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB41471D10
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183317; cv=none; b=VimeApIcyIryLwDmChARix8zLjYSNbCthrxmu9Jo9aeLmzWIrcAHSjScbYBA9dmFiVojttKynSKfoOcep25xdxYEEbw5O78ax5wGET0ckqR7nei/yU+xrOMgpgrl7iYn31Ym6ds961BBX3ZIldswyofRYBQGiOV6dU6OPn0byg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183317; c=relaxed/simple;
	bh=ORfUAka5aF071vjUJQCc8+CbcRtwiEONB9p9C5XGJX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTHvEtLUy8ZaJ6sMjrZ32lJ5g9KXkNk8/VcZGva3f8PFLi+gO5wlquojv7Q+EuNRKbI4Nqe1d66dsKou5EUsLy4hEAIothD/7Mn+WMYxZSLDPOFZwEcseCnUolMZMjyMNWPr6c9+SP/Yg3Lp4Nx3TrblfI78liO7TFvA4aXJbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyQGqnuU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyQGqnuU"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c20e70a0962so453288366b.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183313; x=1788788113; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AlPRm+hvhQgi2x1KLA+phsQE2yTD0m72zobSh9ptdrs=;
        b=VyQGqnuUIkJEpL8bsnunQCehh+o1ZmrPZE+j2rR5KR4thr86V1VePtVny4EgH6Fuye
         275oXnudg0Hio4cWZby9Q/lbkYSHoeNU2x4rgsRAmawNgVhOFeLPu6WG5MgB2xvogojs
         UI+s3cw0xZ36NBFWGAAQgncnbLtl7DUdZ5sohTYCri/+mMcrY9Ra38f7g4W1u+v65NqA
         Z4q0F8uyQd3gBAHjlIVE38xg3Pb9/mN1TVUwHfR/7vde0waRh7V7DtXBN3aMfZSiQRWi
         Cg2xzR0UsxOkRjV5fQRKt9yTieAhguTl8+5iZQ/WZ0McBFAYjtMHvIcNFXmJlH5Dmk+K
         jdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183313; x=1788788113;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AlPRm+hvhQgi2x1KLA+phsQE2yTD0m72zobSh9ptdrs=;
        b=Fel33+uLITCt3THTtMX/Y/xtBSTI/m01T1N0R1SnS635r+KgBZCnNm4POHA3PDd7FE
         HQBJsYALYYOXO3Wlzg/xyD88jWlX3W4SzURWiR9kaHiALPyugqisOlcAWRpgPIocm/Sb
         +vtk8A+lmfoTzK9W2rl5VciLOk7mDokxGRTAnBZ/VUo0j8Qy9E3y2jkN22/PIn6O8/Rk
         Tk0A+nrPwReZp+yEN8SHJ23ZUnVkOMxAXh59HullhUNXAmPkFo3lml4EkbQEjcH9Ako9
         iCp8Y/+QiiE+McKon33heAy01NImZwRacWfIqZwL8U4D6zdSA9Rqrkfo4ZIEc4Q+Bswi
         KGrw==
X-Forwarded-Encrypted: i=1; AHgh+RpAzX/nyfUf/26RmlQOGk+vQk1VCznvuGkbmQbmi4lBxvO+fypKjfisJobiYnOQdxEowBWSMzo=@vger.kernel.org
X-Gm-Message-State: AFuF++ngvPRwnd928m1XO5RJXyM/DqLMk94/+gWJGZXhODeTvpVMla6h
	r22254T4WGlycHRZPKSKjnyj//Xavg9Pvijz405a+rl8hTdushVr6j7b
X-Gm-Gg: AR+sD13WYgMNyPVtvKxWYfPCmebomIgjI4QkLxN6KI98AYtqYh413DycSLPQ1mrSk8u
	eZ9I0448t7YjzCWQ2ZB84rDjEFLpypv+S5zcDcnh1RIw3RuLKfrBq7GWk2yq+bVM2o/HBelZqnV
	WoJ1/GVlEA/MnKp+2SFvbou7DuVA/rE1K1Q0iqw0N4mx/33Y1FREOklQ3ah/vOoUt0KEKumHYo/
	jDd6raH/6ojy7lQUn7iIeyRTv8qyafVvyOkgD3NAojvhn1YrOmY8KXRI3g7XtN7+r6t+MOLIEmj
	m4vBL5LmBjjrmzLSJT8mhSli6suzJ2hDL4gnguf6QPndJ/GiWpwP07BYtPZM2Lg64CYd6PSzEQJ
	/eqtOV/J52nsJMwKMlcjLY9Li3+MTyKnwKQYzAMpf+WAt/BCseKSWOFd9zFk+UNxtSxmXjphi2r
	/9c+xUhCFcihNXw7qzehQeynVk7uSTV9cuLLn8Kb6NbAuH9+m9kH/GUDd/ljQqX2F37BC5eacZ2
	F8KalrNgBzMMWEGng5UdHKqSI7WqD6HvtRV
X-Received: by 2002:a17:907:73cd:b0:c24:b11a:470f with SMTP id a640c23a62f3a-c25b39d698cmr47469566b.0.1788183312971;
        Mon, 31 Aug 2026 06:35:12 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b1fdasm456873266b.37.2026.08.31.06.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:35:11 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: alexander.deucher@amd.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 stable@vger.kernel.org
Subject:
 Re: [PATCH v2] drm/amdgpu: skip the VMID 0 flush for VRAM clear-on-release
Date: Mon, 31 Aug 2026 15:35:11 +0200
Message-ID: <SGE410JQTUO82TOt1oxM1w@gmail.com>
In-Reply-To: <20260831122841.42160-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260831122841.42160-1-Arunpravin.PaneerSelvam@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, August 31, 2026 2:28:41=E2=80=AFPM Central European Summer Time =
Arunpravin=20
Paneer Selvam wrote:
> Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
> via its direct MC address without programming a GART window, yet the wipe
> still forces a VMID 0 flush. On GFX11 (e.g. Navi33) that spurious SDMA
> flush can wedge the engine; only flush when a GART window is actually use=
d.
>=20
> v2: Let amdgpu_ttm_map_buffer() return whether the VMID 0 flush is needed,
>     and drive the clear and copy paths from that. (Christian)
>=20
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5413
> Cc: stable@vger.kernel.org
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Looks good, thank you!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c index
> 6c07cee8e8777..e0bdd95c64de8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -190,6 +190,8 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, str=
uct
> amdgpu_ttm_buffer_entit * @tmz: if we should setup a TMZ enabled mapping
>   * @size: in number of bytes to map, out number of bytes mapped
>   * @addr: resulting address inside the MC address space
> + * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0
> flush + *		    needed) or false for a direct address; may be NULL
>   *
>   * Setup one of the GART windows to access a specific piece of memory or
> return * the physical address for local memory.
> @@ -199,7 +201,8 @@ static int amdgpu_ttm_map_buffer(struct
> amdgpu_ttm_buffer_entity *entity, struct ttm_resource *mem,
>  				 struct amdgpu_res_cursor=20
*mm_cur,
>  				 unsigned int window,
> -				 bool tmz, uint64_t *size,=20
uint64_t *addr)
> +				 bool tmz, uint64_t *size,=20
uint64_t *addr,
> +				 bool *vm_needs_flush)
>  {
>  	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->bdev);
>  	unsigned int offset, num_pages, num_dw, num_bytes;
> @@ -220,9 +223,14 @@ static int amdgpu_ttm_map_buffer(struct
> amdgpu_ttm_buffer_entity *entity, if (!tmz && mem->start !=3D
> AMDGPU_BO_INVALID_OFFSET) {
>  		*addr =3D amdgpu_ttm_domain_start(adev, mem->mem_type) +
>  			mm_cur->start;
> +		if (vm_needs_flush)
> +			*vm_needs_flush =3D false;
>  		return 0;
>  	}
>=20
> +	/* A GART window is programmed below, so its VMID 0 TLB needs a=20
flush */
> +	if (vm_needs_flush)
> +		*vm_needs_flush =3D true;
>=20
>  	/*
>  	 * If start begins at an offset inside the page, then adjust the=20
size
> @@ -322,6 +330,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct
> amdgpu_device *adev, while (src_mm.remaining) {
>  		uint64_t from, to, cur_size, tiling_flags;
>  		uint32_t num_type, data_format, max_com,=20
write_compress_disable;
> +		bool src_vm_flush, dst_vm_flush;
>  		struct dma_fence *next;
>=20
>  		/* Never copy more than 256MiB at once to avoid a=20
timeout */
> @@ -329,12 +338,12 @@ static int amdgpu_ttm_copy_mem_to_mem(struct
> amdgpu_device *adev,
>=20
>  		/* Map src to window 0 and dst to window 1. */
>  		r =3D amdgpu_ttm_map_buffer(entity, src->bo, src->mem,=20
&src_mm,
> -					  0, tmz, &cur_size,=20
&from);
> +					  0, tmz, &cur_size,=20
&from, &src_vm_flush);
>  		if (r)
>  			goto error;
>=20
>  		r =3D amdgpu_ttm_map_buffer(entity, dst->bo, dst->mem,=20
&dst_mm,
> -					  1, tmz, &cur_size,=20
&to);
> +					  1, tmz, &cur_size,=20
&to, &dst_vm_flush);
>  		if (r)
>  			goto error;
>=20
> @@ -362,7 +371,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct
> amdgpu_device *adev, }
>=20
>  		r =3D amdgpu_copy_buffer(adev, entity, from, to, cur_size,=20
resv,
> -				       &next, true, copy_flags);
> +				       &next, src_vm_flush ||=20
dst_vm_flush, copy_flags);
>  		if (r)
>  			goto error;
>=20
> @@ -2578,6 +2587,7 @@ int amdgpu_ttm_clear_buffer(struct
> amdgpu_ttm_buffer_entity *entity, struct amdgpu_device *adev =3D
> amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct dma_fence *fence =3D NULL;
>  	struct amdgpu_res_cursor dst;
> +	bool vm_needs_flush =3D false;
>  	int r;
>=20
>  	if (!entity)
> @@ -2599,13 +2609,13 @@ int amdgpu_ttm_clear_buffer(struct
> amdgpu_ttm_buffer_entity *entity, cur_size =3D min(dst.size, 256ULL << 20=
);
>=20
>  		r =3D amdgpu_ttm_map_buffer(entity, &bo->tbo, bo-
>tbo.resource, &dst,
> -					  0, false, &cur_size,=20
&to);
> +					  0, false, &cur_size,=20
&to, &vm_needs_flush);
>  		if (r)
>  			goto error;
>=20
>  		r =3D amdgpu_ttm_fill_mem(adev, entity,
>  					0, to, cur_size, resv,
> -					&next, true,=20
k_job_id);
> +					&next, vm_needs_flush,=20
k_job_id);
>  		if (r)
>  			goto error;




