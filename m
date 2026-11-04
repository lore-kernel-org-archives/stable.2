Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793789392;
	b=Qxoo6RcgABhKYyVmmT9wCijNU1jGcN4O6B8POTTFixM4uQIO2h4700aoeCGkvhWLz2tr
	 9U8UP30RUCqueQXZ3oREYjqWwaibWFEt6ae3MReZg2lpoUzDg1fDwtu2OlQQpW855ERu8
	 XSJU+NER4QTzvGJ7b/CWgLn3J6BUhXX2bNxydr2BGDaMF13gU8EvFeUb5vrEa0LcS4znp
	 +VioifsfIorxYb9fUgrGc4K07y4s8iI1Qg2UFfc/zQRqGnxXXr2azOVuk6SmSSVKHt6rS
	 7mXohhihQH95dgteI2zacZRS/i1XHZYC7AYCc6ERKKFL92YPStvby6ocOmFv7WGrtIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789392;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=rC2RxAX+EQ/uLmXWenUT4kaK0zKIniQLwrGlH5DtkjE=;
	b=Fn5GmguLSwj6+DD9+/x75khaj/LXDbSAeBlH7g/OmM2coJ9OzO+3a8vgGJwm+DOpQ8XR
	 B1uwGbdQL3H8m54Bzez4usELyB/rV/Y0TCFooOIU8wF/4OmvlCfcVdqVxwF+c0o0GmmBc
	 UfLe7lYRWHglT1gomp+RwhrNQdK5kIwqp3fG2mfwuoqs8IylQREpZzANLOFfXNEuOvHcM
	 dVuFD8UGSd1B3WLu90qPpDTxsDF28PSZrhQx/3wdCWKsIkB6j9x4RH0bgDb5IHzkSvMaI
	 fcDrgApT6bHfs+pyX2XSp62T4QYSmdNcTPq7NybYgc0v035sKqp07phNaWcGCr5nkZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HoMtkAUk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114FB606A31B;
	Wed,  4 Nov 2026 10:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 114FB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HoMtkAUk
Received: from [IPv6:::1] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: lst@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E8FCA2015ED;
	Wed, 04 Nov 2026 11:49:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793789388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC2RxAX+EQ/uLmXWenUT4kaK0zKIniQLwrGlH5DtkjE=;
	b=HoMtkAUk5IAgbWZZ5fLGLyoQW4ZXp1MIRYwsxRlCxRz5EMMRyPbDtOwDFC+jcTlkDIO722
	UnfnT+pf2HzdqHh16k9kMdkDOW7kUnUNLEt1+ULQTBA13qaxmmwHCpDk21mBqI6UED7Ha1
	KBGrQFb7hQLOUw+YNMhXFEUzVKOvp+MzSzRw/T9sN/5ldgFIkM967mNthR8cUz48SfNpFm
	cTzIM9oaEp4r+AwMZAQuc0paN+IoChoRAKn9Vs6c9egoq/BQ+4eyc4HlPEClDvVbmJbLaE
	zM3sPYa7W2rN5PUjpFuQNUt8ysZegAy2wdwZtqQZmGTeJfSWPaZyengQNoEGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793789388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC2RxAX+EQ/uLmXWenUT4kaK0zKIniQLwrGlH5DtkjE=;
	b=GdfMNcMaFTzq7k3PT91OoEQtVbNroPM4rpOkQ/krDCtRNPI1UHtOit1qlipmOie1GetmKe
	3Se3mkKjc3ywudDLITGkePWgfVUBV3GS0WvYqllzY02el1XQV9ply+d2aUqKgQjCSkrhjG
	M0icQGsfumelRwEVPThAE3sJ/EDGSXmveYAlVdWfMBqY4oal7Oy3fFSJqH0T4b/Jde7kbL
	+VtBlR8o10gN9nVI8GIYg2H9LuNOhFJtufEeOzBAYuUD8FoQ1xRwAzNWHBmUS8Mj0WWZ3x
	iQGuGzGTNOS1K5RGkqHNkUYKrb741EWm4sVV8BvY2L5MRa/yjMAbB7lFnZt5zQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=lst@pengutronix.de smtp.mailfrom=l.stach@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793789388; a=rsa-sha256;
	cv=none;
	b=BfDXYk5Hg5jbUf+6Lr6E4lMkUyQO9Q/oAxZ5hTfPWuTHucvJjWQlI4d+jL7PYD9AiqAhXZ
	SwSqulSk25JjrG5X8WcqOozc4DVIMCJ4EbXYqes05fBFOQKoMU9WVZCNI6gR/PBcE++VMA
	Z92OL4T+z8wka1YLFl0/HOictIO5iAHSmShxL+QT5B+Gj2XYLBfJ76J8GXj3paq65pUaPK
	697cC+ww9N0TOfOkeU/6hGrXg1vJpra3OUZ6e3I4mqem37uygPqZ13X4emZ2J/+diRwDSc
	irl70ol/arUyOWEPOo3L1mCPyUpXWSAQkM1gBYLr5UOOY18c8pOjPF2hEVCRDw==
Message-ID: <eb6dc4502166eac99f1c5f8f579cc4c4fff94ef4.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Cycle through the MMUv1 address space again
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>, 
	stable@vger.kernel.org
Date: Wed, 04 Nov 2026 11:49:47 +0100
In-Reply-To: <20261102-etna-mmuv1-iova-cycle-v1-1-1148f02da254@igalia.com>
References: <20261102-etna-mmuv1-iova-cycle-v1-1-1148f02da254@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Christian,

Am Montag, dem 02.11.2026 um 13:22 +0100 schrieb Christian Gmeiner:
> From: Christian Gmeiner <cgmeiner@igalia.com>
>=20
> On MMUv1, all clients share one address space and the allocator
> always picks the lowest free IOVA. When a process frees a range,
> it can immediately be reused by another process.
>=20
> The GL.FLUSH_MMU write before the next submit does not reliably
> invalidate stale TLB entries for that range. The GPU may therefore
> continue translating accesses to the old pages. Writes through
> these stale entries are lost for the new owner and may corrupt
> memory that has already been freed.
>=20
> The vendor driver works around this in a similar way. It does not
> return freed MMUv1 ranges to its free list until the address space
> is exhausted.
>=20
Do you have more info on which engine inside the GPU causes those
issues? If the TLB flush doesn't work reliably we have a much bigger
issue than just address space reuse. If the TLB entries of freed memory
are not properly shot down the GPU may write to memory that has been
reused for something other than GPU buffers with a malicious command
stream. That would be a security issue that is not currently checked by
our command stream validation.

Can you help me understand this a bit better? Which circumstances do
trigger this issue?

Regards,
Lucas

> Restore the address space cycling for MMUv1 that was previously
> removed as no longer needed. Start searching after the last
> allocation and only wrap around to the beginning before trying
> to evict existing mappings. This keeps freed ranges in the
> allocator but delays their reuse until the search wraps around.
>=20
> MMUv2 has a proper TLB flush and keeps the current behavior.
>=20
> Fixes: ccae45928fc4 ("drm/etnaviv: remove cycling through MMU address spa=
ce")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 21 ++++++++++++++++++++-
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.h |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etna=
viv/etnaviv_mmu.c
> index e3572461b599..c4e4dd3d4235 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -141,10 +141,20 @@ static int etnaviv_iommu_find_iova(struct etnaviv_i=
ommu_context *context,
>  {
>  	struct etnaviv_vram_mapping *free =3D NULL;
>  	enum drm_mm_insert_mode mode =3D DRM_MM_INSERT_LOW;
> +	u64 start =3D 0;
>  	int ret;
> =20
>  	lockdep_assert_held(&context->lock);
> =20
> +	/*
> +	 * MMUv1 does not reliably drop stale TLB entries on a flush, so a
> +	 * freed IOVA that is handed out again right away can still be
> +	 * translated to the old pages. Cycle through the address space so
> +	 * recently freed IOVAs are only reused once the search wraps around.
> +	 */
> +	if (context->global->version =3D=3D ETNAVIV_IOMMU_V1)
> +		start =3D context->last_iova;
> +
>  	while (1) {
>  		struct etnaviv_vram_mapping *m, *n;
>  		struct drm_mm_scan scan;
> @@ -152,10 +162,16 @@ static int etnaviv_iommu_find_iova(struct etnaviv_i=
ommu_context *context,
>  		bool found;
> =20
>  		ret =3D drm_mm_insert_node_in_range(&context->mm, node,
> -						  size, 0, 0, 0, U64_MAX, mode);
> +						  size, 0, 0, start, U64_MAX, mode);
>  		if (ret !=3D -ENOSPC)
>  			break;
> =20
> +		/* Retry from the start of the address space before evicting. */
> +		if (start) {
> +			start =3D 0;
> +			continue;
> +		}
> +
>  		/* Try to retire some entries */
>  		drm_mm_scan_init(&scan, &context->mm, size, 0, 0, mode);
> =20
> @@ -215,6 +231,9 @@ static int etnaviv_iommu_find_iova(struct etnaviv_iom=
mu_context *context,
>  		 */
>  	}
> =20
> +	if (!ret && context->global->version =3D=3D ETNAVIV_IOMMU_V1)
> +		context->last_iova =3D node->start + node->size;
> +
>  	return ret;
>  }
> =20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h b/drivers/gpu/drm/etna=
viv/etnaviv_mmu.h
> index 7f8ac0178547..7fa6e3ab427a 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
> @@ -75,6 +75,7 @@ struct etnaviv_iommu_context {
>  	struct list_head mappings;
>  	struct drm_mm mm;
>  	unsigned int flush_seq;
> +	u64 last_iova;
> =20
>  	/* Not part of the context, but needs to have the same lifetime */
>  	struct etnaviv_vram_mapping cmdbuf_mapping;
>=20
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-etna-mmuv1-iova-cycle-2fc0e6200fa6
>=20
> Best regards,
