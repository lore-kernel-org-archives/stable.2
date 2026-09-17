Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101A44AB8A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675206; cv=none; b=lM/OwnJid2q3PKuznmywKzIZwsW8u8MGJm1ZR7AnwT5sbCkQWrHbxgMZqzblMagxpqQEZm0aQPLFjjclTu01MWHA/IKkWdQlySmXKRw+guSmqGEYcqHCqLTVU/AHaWjDZJ59jkoxCBNooFBQh70EtHiXglZRzY5MfAGlQQYZwkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675206; c=relaxed/simple;
	bh=vW1PEVXQ9jSdeXqvu/sHm4RW6P/OoSsC0JrMfDOrePU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mqns2/ycBnsq9TwKDhDCL1Z21dMxihYzWyGjLdcdSWBi2aYXtI+hEmKqYSNkQlQpkN36HQtnimmoAwxcwcLpUvptFSVXr12idfP4/62YjhszUA79yl5QwsfnZm6AAzWcvpuE9YxOCgodANp7wWZFv2l1Wrl5dRO8mI5PRVvmClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMi18HIv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmIixB3f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMi18HIv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmIixB3f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789675203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKJHwYoHwtxGXYRY1vkeptYjZQfzNjxi9ZIJDlWS3xE=;
	b=iMi18HIvgUTW0NjINTSt/+demP+eRT6zXYzndaKVVyE+hUy/J2IS2fJDFu9HZfCW8nKjge
	+xRIORPaxpuXZ6zo2GUFAn4grtxY6Az9C0ic0GguqSjFsfV+dw9964MMyA5JwSB2/rWI4w
	hj0VESbdQzwUN0dpzM94eaXJUeyG7Zw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-93tiUvPFNimRUZNQO_ih4Q-1; Thu, 17 Sep 2026 16:00:02 -0400
X-MC-Unique: 93tiUvPFNimRUZNQO_ih4Q-1
X-Mimecast-MFC-AGG-ID: 93tiUvPFNimRUZNQO_ih4Q_1789675202
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53000c06184so36026301cf.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789675202; x=1790280002; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QKJHwYoHwtxGXYRY1vkeptYjZQfzNjxi9ZIJDlWS3xE=;
        b=KmIixB3fRUIQw4iswbxGK+7IF5sSXuI1Wv6IHjm5GNSmR8ZGPbjC1oH0uhk9zfmHty
         HE45PZal4cvDMMSG9p+BAFMgD93bXZOpM75AyXhz+lqDw5uMKK1bKSp/i9XHIBsOlePx
         JWhtiqJerY8YWz71CNH2/iWlLA4tPzYArHZhkFG1IaFe4EpNEFmGENbGqduTJfsZmUP/
         Dmwh+SJZwPX3JA34aePFPKJUXVRuvfehgAh6VtMYLsZQS1SWOpffFn3lS3VWjmoBDu+C
         b0E4QfOi9Pg+kpSsFhslbIrOwmTSaFTyE950IN2paQhM3Y+9lFPrCXbl8PLH4MnsZeOY
         B7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675202; x=1790280002;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKJHwYoHwtxGXYRY1vkeptYjZQfzNjxi9ZIJDlWS3xE=;
        b=2JZfBa1uwiGJ7hIsg97uXPx0w+jN6iBNXs9ydohH7DGxXQDV1m5fkALa/4DY98fOcg
         rd5adZLAGlfgFCHznY4P1dolSwJIwNpGg2OvMwk32T4E5QpCUgvNxmv+l/z2b4s5kr2a
         zdX1LM9rhG19kM2P9xUfoXahlY1p8twEn2vd2Uy8WAGkNbwcXBolN2n06Ox1JHdGGpuj
         UHCv+DeKdv2fa7m6puLIdzj4dQpU6XmrPYFTF+raToU4bLnGB86baOTH0aVgnWvVkujk
         HomDjsxSFYXSezRow1Qg4vOUmtgavW1R1J97o2ClsXfyBgoaQKz3Z/Yi0qCvJiRvhRr9
         InHA==
X-Forwarded-Encrypted: i=1; AKwUvBy/71Az5nUtf06n3T+bFc+/smRuEfShVAo/slEJEpvn2k9pAck1MBAnX38bAHhbDiEuN9xKvqc=@vger.kernel.org
X-Gm-Message-State: AFuF++neqJo7Rh+IJwRx9Zzf4ssIQT3LuUvLXtkWElE8YoQxZKgochpB
	BMphu536fAB+z0V6BqTR95Pncp0ze8iMDMZvL8wh/ZpFQ6VKnE/TpeoBA6O5gPHdP9R8xR8m5KO
	2B1tsLSud0SGBGRoPt1ZG5cEweJqSgdUSlgtvIA4mbps2NCsyxq/DprYYIg==
X-Gm-Gg: AYBFou2YOHP3iEEO6Oo1fom4duFQXN1Gbz6aQMF8KnHZNerYwVk9k6aCvYLoEwb9Pul
	QB256sxRBX+jLJNBSrk2s3RoXqJgCh3ADVVfnYAPDio7SUif3a1Vg9HpEZ9BTUbSE8WMEvlOLxS
	I5UfqIY7veHY6s0gKdPG2Pcdcs5lg7EdWDgcskrE1jJpnwjd1TuDvAWVRKd7dQP4MdTAdY50bkQ
	Ms/+pAjTyogfN9aS3TLH4U66nOLMlqRIEeZdUEg7c1koyOAIFQXFKPijX4IHd9zhWhllcbJKUY/
	oVPZddOecAY1H9XE0hjkrjRfldZ3n0K9Eh6rOha/B6AxA6fRJ+A8qNoN1xaqW/SRL8s4mVum
X-Received: by 2002:a05:622a:389:b0:530:dcc7:aede with SMTP id d75a77b69052e-5329e3d16c9mr5804001cf.30.1789675201609;
        Thu, 17 Sep 2026 13:00:01 -0700 (PDT)
X-Received: by 2002:a05:622a:389:b0:530:dcc7:aede with SMTP id d75a77b69052e-5329e3d16c9mr5803511cf.30.1789675200978;
        Thu, 17 Sep 2026 13:00:00 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620843dfsm59146421cf.22.2026.09.17.12.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 12:59:59 -0700 (PDT)
Message-ID: <41bd4250f6833a7aa8de54b84e182ce922281d24.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/nouveau/dmem: pin VRAM for the whole registered
 range
From: lyude@redhat.com
To: moonafterrain@outlook.com, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>, Balbir Singh	 <balbirs@nvidia.com>, Mary
 Guillemard <mary@mary.zone>, Mohamed Ahmed	
 <mohamedahmedegypt2001@gmail.com>, James Jones <jajones@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
	stable@vger.kernel.org
Date: Thu, 17 Sep 2026 15:59:58 -0400
In-Reply-To: <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
	 <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push patch 1 to drm-misc-fixes in just a moment

On Mon, 2026-08-17 at 14:50 +0800, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
>=20
> Commit c32287471077 ("gpu/drm/nouveau: enable THP support for GPU
> memory
> migration") grew the device-private region that
> nouveau_dmem_chunk_alloc() registers from DMEM_CHUNK_SIZE to
> DMEM_CHUNK_SIZE * NR_CHUNKS, but left the VRAM buffer object backing
> that
> region at DMEM_CHUNK_SIZE.
>=20
> nouveau_dmem_page_addr() returns chunk->bo->offset plus the page's
> offset
> within the registered region, so every page past the first chunk
> resolves
> to VRAM outside the buffer object.
>=20
> Size the buffer object to the region it backs.
>=20
> Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU
> memory migration")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_dmem.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 9442ec6e1f6c..356ff8f3c1b8 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -325,8 +325,8 @@ nouveau_dmem_chunk_alloc(struct nouveau_drm *drm,
> struct page **ppage,
> =C2=A0	chunk->pagemap.ops =3D &nouveau_dmem_pagemap_ops;
> =C2=A0	chunk->pagemap.owner =3D drm->dev;
> =C2=A0
> -	ret =3D nouveau_bo_new_pin(&drm->client,
> NOUVEAU_GEM_DOMAIN_VRAM, DMEM_CHUNK_SIZE,
> -				 &chunk->bo);
> +	ret =3D nouveau_bo_new_pin(&drm->client,
> NOUVEAU_GEM_DOMAIN_VRAM,
> +				 DMEM_CHUNK_SIZE * NR_CHUNKS,
> &chunk->bo);
> =C2=A0	if (ret)
> =C2=A0		goto out_release;
> =C2=A0

