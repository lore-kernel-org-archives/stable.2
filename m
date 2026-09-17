Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE74DEC2E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675166; cv=none; b=JahjVBbQzEkYZya/BYRa3Ciq+Az1P/SsU4URRcIC+teq/SU+5zjdK3NiObiRfLJqyR9QrUnt94fEHvST/ByZ3/xPO4DRPPc1CEmTN9mmyHQdbtpEsXjdOrsJE8PfSnxHwgzLdg+MVUcid18427dAN2wh1EVqPa8pw9quc7j0B6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675166; c=relaxed/simple;
	bh=yk0ZZEfCsoFw6jUtj7ij8XhDzHLLwPW+p3DnKrJPG+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YOB1M88fvI/L6p4z6VQhqSohp4qbnRJd9sYl8d3pL/W7Ou83gEGdHWt9QoaHSPhSLXyWvvx5x9lbirwepvBKPeh9On18hanmOUbYmoF84HOwdE3TRlfDpwioRyf/IhBcohhD/OuBLn4tzAiFeCIF5j4Adq96Kl7+eFX9CqVEN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UseFq0HJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZT3qHJK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UseFq0HJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZT3qHJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789675163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9aXv8uRrrDfO592gJdgz9hZv2sNMllIL5UBHr09UAU=;
	b=UseFq0HJDrfIBd164+xgDxUwEl4UdGA4xd2imF8kQMMpboCN+j7QOKClyybgJsxjygG3ZY
	FrGVG8BnVSAowMLqBTYElOX6eXFrnGT3VqFy1c6bDd60HzPgDzfu/bEp9aEPPFiRHVvXKn
	azdIEMp8h9i8zDZVnkcdnkRsoW9ag1c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-jDJ3jR0FNjmWmDzqpe8odA-1; Thu, 17 Sep 2026 15:59:22 -0400
X-MC-Unique: jDJ3jR0FNjmWmDzqpe8odA-1
X-Mimecast-MFC-AGG-ID: jDJ3jR0FNjmWmDzqpe8odA_1789675162
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939f925ba4eso325563785a.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789675162; x=1790279962; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/9aXv8uRrrDfO592gJdgz9hZv2sNMllIL5UBHr09UAU=;
        b=DZT3qHJK+sLWrr6rntdk72Foag6+vL9Q0Ei3WXI41RFRMsjV+LcR5WYJ3cH2P4IKbq
         8ssPwQ8pIEIRPEnvyT2yKtt8WvgVUydbCOLLRLBfwKddt56t3eLNfUeANrRMp+3v9/2A
         wxf1Gw3z4gnWoKge/Md7r8RKPvX/lUi5eeN/CuHT7yC0JmFuJIjXm90AanRFNkiBXCsm
         wYsjPi79PjlZAkFHXxyz3FmqFdhYZhiPiVYiyJx10zdZwC0RLfWc0sChtImXkNunozQT
         bVCUMJD1bcCdzLTXkR9CQn+NvGBV9PJZdaK6gR6tHU32F9bF1NXl1Lxb9rdbp8+Qd07P
         nOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675162; x=1790279962;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/9aXv8uRrrDfO592gJdgz9hZv2sNMllIL5UBHr09UAU=;
        b=2YzoCMuZGGC3f+BqtzU92wNo+VdISAwFX7ufkDiOUKJdVeiE/0HH0E/bwaaNO1G2gj
         0Ax4sh71X3HdrYTDGBVnE5ufDvSbxEd/MdprQ71HBcue2wcc9HIjCQw5p7EDNkt6bLfN
         Z+ose7HXN0sLf1aIk9LlfoZ6CS1uBTxHGlxj0+o0LrHXgYzHZuM28vko2kNbn1Y2UwLA
         P2G2BQ+Eakqdi613EXVsPquS2eMJu151F9X6cmdwq2nAL2K5GTTlPo37R2ASLGP/j8/g
         DavCEvA0aGSCMfrErkgPMTKMSS5AHpvdcuqxrYygUzn5Yk5srKPcM+14IYCyZckqLl9B
         99xg==
X-Forwarded-Encrypted: i=1; AKwUvBy3At5QsYpHfSQUNyNFUZv3M6pEOtpTMbUBsyjzmF+FiAl0Me2tRo2aZD9mh4Qlu9EiJj+ZxHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lup7L1mRebl1ml8nEqOlCNHQM5WrPQktthneOfunKckdgaSMOl
	7XhlVluh10cLdtc0d43VMgtEuXxJRYc5MVUAsANV0We8Da2Nl4yI48RErdAixy5FoedUdh8RNB8
	aeo1IfObGpmKdHDBK/tAMfiIKvhI+p6dlW1AqJ5m1eFbCEnFHiSrs798a0Q==
X-Gm-Gg: AYBFou2J5KjoIvY7V5C2GlpC1trKVF0aJBPK6GZzpyoRAb+NMVQhVMV62AtuvY4RPKq
	3yhFuORXXnoovdEKlBUIaAKUC1UqRPNzpBmjXThvHeayrgBzgumJJeH0Wa9wmmp77FEDR4Mkm6u
	bnn11ofxxUP/p8OcVz7wUiUvNRgdZ9ZPkXZ+rmdhEGeS5MFPqhPPMy3o1ZAZA9Sn83elC3BrCHt
	QSQVZzwk6MFItujWyIGXl0lZSGE/leyxirznMh4yNvnkmqUmqxNcxxu6paDOvIndLCI+Zk2uQyp
	58QS1bJg1FxN1zIARKtV6ti39Qmgy6pVlK9r1Egbqypk2e9etwuLihIpRhJwRhci4J+vVQnO
X-Received: by 2002:a05:620a:800e:b0:937:1097:feb8 with SMTP id af79cd13be357-93bdc70b6b7mr2620385a.24.1789675161629;
        Thu, 17 Sep 2026 12:59:21 -0700 (PDT)
X-Received: by 2002:a05:620a:800e:b0:937:1097:feb8 with SMTP id af79cd13be357-93bdc70b6b7mr2616085a.24.1789675161049;
        Thu, 17 Sep 2026 12:59:21 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b78243f77sm542694385a.25.2026.09.17.12.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 12:59:20 -0700 (PDT)
Message-ID: <495954974fdaf275d65ea8ae1b76f8e496c09b79.camel@redhat.com>
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
Date: Thu, 17 Sep 2026 15:59:19 -0400
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

