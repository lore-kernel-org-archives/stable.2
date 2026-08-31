Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC13E4506
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176386; cv=none; b=ebNXim+SWtzD/CGAFAigClpECoKZzwYGN4vwOe7J4Gz11/F3i5BoaQ2F+/si/ymcg0R+us3MtGFo5eEL5L9vOGAZ1rd3Ox4HD1HIO0khyQA+uHzscM4Y/eCmI/Ue+89vS2PMO9H67uzWKx0bUwxS0UXEwR0pfEoN9gON8e/VObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176386; c=relaxed/simple;
	bh=uDEVvM6ZlrBdrVamGlXKpE2SalK0Jlf4Utvwh8oXWAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1ZOWs+nInQUcyw8kiksM7EVKjIQpp2FnAG/V2iKaj74e4TC1RZ5QB8mWh3iKrzCVWmSCm8HR5ZG4QGehA70oilYjWqAT2iyDjkTj9nlSLyt6Hgb65xtIplBlaxWzA7xdrgTKvv7djZLeHO1h4sMBXSWGD+Q0KEtUgbV2pwZX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX1v8BxW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX1v8BxW"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c25099bb1fbso438037166b.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788176382; x=1788781182; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GSaKvfCewxq1tw/MPDZ73QfEYniPUyq5xZzUvs3KI9Q=;
        b=YX1v8BxWuMYkd9lKavS9GdI4e19To6XdpBUSwf5mof8l9gHhtibguP36h2o3oVI3uY
         LncZ2F/RvjGzoeVCDf4ZAkirgbnuugsSVj3kPTuc0UH7X0rjLZWqApKcj91gAi5mXc0o
         g05e2atLFBOOrgxPH+l9zsuwN0/4cJSlOjjKcZBTaVz1fQDavq7JqARyOkhc3SbiNDvV
         CheLjVRPdazWBpmnhXrPSM6J5vKomqCwwo4thl6/BXA37W5V+sbXevoNpoGHDgXaBvNL
         zWtJcEyr42cIrfKdo4Soj3H/xapnBCdwdNttYw3u03cmvvbgofbgZr7j+hpInpVc0EH+
         Fzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788176382; x=1788781182;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GSaKvfCewxq1tw/MPDZ73QfEYniPUyq5xZzUvs3KI9Q=;
        b=BIpJ7hvlfpmnz2VAoBeanTpu/eET4EXRW1DTQr0HaCUP88eWzeeOkcOhJ+zc/Yh0th
         khZCfGAkyqePbGdt2tamFBLjC51Ur4epF3oDj0GWKFF2Y573Y+7JOzM7Toj91X87D15b
         qb4GZy8tRjdNQbwe7u/UEuD5XyEOIhqz5tE0wrff5440gnhzafSb+bmSGhD5Ns1IijTM
         2/4Wf3VIqRmuRDXUvmTHrNj0NTy/VhzTGaMTLwJIjzdQ5YlFWuELGG22wCw/r71/78TT
         MaJfw69Xpq3ukcgNGuwlM3nSs353CTSugk2j6Lyj54d1EnDi6oUNzJwo0A4InqaGZ5IG
         YgRA==
X-Forwarded-Encrypted: i=1; AHgh+Rop85nHLVccP5wQ2iL5iVZI3O1MxHyPA45/c9ITzt/GyanordTV4AdxO00ze0Z4rvR+30JRuvE=@vger.kernel.org
X-Gm-Message-State: AFuF++kEZOwuIMn4b2cHXC69DPNviLDcIbWutkaH9AhNlHBSwibSO0RH
	ioWWB/uiq2Olr/astW25ImWgbmh2wYGQfUd6cI2XfjJym0XH7jSZP7TpQzeVsg==
X-Gm-Gg: AR+sD10kgVFHd4wDuIktqjcST3ik8KWcew2MRnjt+n1UV0NMs7zK1UxWB3LTHMjmjh2
	iVPsBqzTKHkLsvavKqom39tYd0OfHuYtkN/0DA5bSFjz5dV+qWovaerLCXx5CoF2rPb6mEscyDw
	dt+5C/kb+TSKtzy9XjwOmuegQ34ci+Ej3GR/T64mRTqE1ZiysPEaX1+nTqMsf5HogWjWav9pW50
	pSBicETf2oJLQssGXA0kFoxMSXAiKGhH0u/mx2mSgzWNp9uZbJiGqENW9mN3HKqJVNDu5fi9OVW
	bPcBl+pAlCMkvswsXz+ClLAvDnntDBB4NMcPu+rOYYZNIIJ3g58HFEkxtr2EkH/bRZgofv6Qa6x
	1FIA2mPnfzvgT36hoZWjwkXXR3yHGImjthbNQ/uDb7e8a3waO4ib9qgKeTSkJRq17zWnEnueUFJ
	kiY+bYSH3WC8V5FN7ZTz+mbmgCHnLOzJgXj/gOHPaDP3u7JTFYx/5ZIxPGkXQFAbOPIKJr5/w4R
	QOI6dLAUBzZrg6T3Y/KSfPVXQBxw5m+lwBQQJhcoOu+exiVioWcEFL+z1mcjBu/h6fyLCMopnMY
X-Received: by 2002:a17:907:9618:b0:c24:457b:86fc with SMTP id a640c23a62f3a-c25571d3b0dmr1534052066b.21.1788176382007;
        Mon, 31 Aug 2026 04:39:42 -0700 (PDT)
Received: from timur-max.localnet (20014C4E24D8F2005AA4D4F91F46DAE7.dsl.pool.telekom.hu. [2001:4c4e:24d8:f200:5aa4:d4f9:1f46:dae7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee75a36sm413076466b.28.2026.08.31.04.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:39:41 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: christian.koenig@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 stable@vger.kernel.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Subject:
 Re: [PATCH] drm/amdgpu: skip the VMID 0 flush for VRAM clear-on-release
Date: Mon, 31 Aug 2026 13:39:40 +0200
Message-ID: <voa7PnOgTa6oSIPH4Hu9jQ@gmail.com>
In-Reply-To: <20260828044734.135460-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260828044734.135460-1-Arunpravin.PaneerSelvam@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On 2026. augusztus 28., p=C3=A9ntek 6:47:34 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Arunpravin=20
Paneer Selvam wrote:
> Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
> via its direct MC address without programming a GART window, yet the wipe
> still forces a VMID 0 flush.

Makes sense.
We don't need the VM flush when we are not changing the page tables.

I agree with the patch, just would like to ask a few questions to better=20
understand the underlying problem:

> On GFX11 (e.g. Navi33) that spurious SDMA
> flush can wedge the engine

What is happening when the SDMA engine is wedged? Can it be recovered by an=
=20
SDMA queue reset? Is it just a hang, or can it cause other issues such as p=
age=20
faults?

> only flush when a GART window is actually used.

Does that mean that there is still a risk of the wedge when the GART window=
s=20
are used? Can you remind me when/why we need the GART windows exactly?

> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Cc: stable@vger.kernel.org
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Thanks and best regards,
Timur

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c index
> 6c07cee8e8777..2e6c98c2f1efa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2578,6 +2578,7 @@ int amdgpu_ttm_clear_buffer(struct
> amdgpu_ttm_buffer_entity *entity, struct amdgpu_device *adev =3D
> amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct dma_fence *fence =3D NULL;
>  	struct amdgpu_res_cursor dst;
> +	bool vm_needs_flush;
>  	int r;
>=20
>  	if (!entity)
> @@ -2585,6 +2586,8 @@ int amdgpu_ttm_clear_buffer(struct
> amdgpu_ttm_buffer_entity *entity,
>=20
>  	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &dst);
>=20
> +	vm_needs_flush =3D bo->tbo.resource->start =3D=3D=20
AMDGPU_BO_INVALID_OFFSET;
> +
>  	mutex_lock(&entity->lock);
>  	while (dst.remaining) {
>  		struct dma_fence *next;
> @@ -2605,7 +2608,7 @@ int amdgpu_ttm_clear_buffer(struct
> amdgpu_ttm_buffer_entity *entity,
>=20
>  		r =3D amdgpu_ttm_fill_mem(adev, entity,
>  					0, to, cur_size, resv,
> -					&next, true,=20
k_job_id);
> +					&next, vm_needs_flush,=20
k_job_id);
>  		if (r)
>  			goto error;




