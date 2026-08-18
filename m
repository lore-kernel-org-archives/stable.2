Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251243290B9
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787084328; cv=none; b=n7DW2YBWZLRJmNhGe5/U6MHCKNaFqqq8ub013VSL1KSJlxJ3SsDh0Albxyi2Pdv+lJkgq1oQ95eVk8OlnuUAWoVK/SYWxJzrdtDa+h629i+hhFjUMjM128fXZI6kOJyGKCvZbSw5z0x23T04y+0Hk7O9d2skTftMeQJ6N6pTnXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787084328; c=relaxed/simple;
	bh=QSjEJ+3oiIlDrlfXsEdJ5jpNGIkTPrgzJoW6lljP6f8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akMWzliLPnJYkSnAdM+Ep7at5BvZxmO/2jP5vbnILIEvut0tPROBN6siL+OG6vIdNGRpkGVFE/pLDCekyoABm/HgO+/RH5Ff6X1r8ZFpYDLok3DqGyO8Y2zbUePiUoJAAQY8XuJOsO+J3f+xrc/d1B2kqUn7fZfLb8WRTwnR1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cx/4bFqE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ssI6nvWl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cx/4bFqE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ssI6nvWl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787084326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9OWuHNZhe61OBLjXm8D+LZBFST1XmHdZMCDCW5KK8E=;
	b=cx/4bFqEFoXVIBAUFafdi1KhtIsYYeNbC3hp0IENT3OGULF8KwFOvRqyXmCg5CWKiscLUW
	WoWWq11FVJtG0/H6oKwLLGw62NYL00YFHgXpJhE661xyopXOtovzi2ivLDBLIa03QH6kMF
	55Y+OU1P6RTWRjOrz1rrIpgxrbILuI8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-0aE8XyQ-NMWdYlyuyk_lcA-1; Tue, 18 Aug 2026 16:18:44 -0400
X-MC-Unique: 0aE8XyQ-NMWdYlyuyk_lcA-1
X-Mimecast-MFC-AGG-ID: 0aE8XyQ-NMWdYlyuyk_lcA_1787084324
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ef8249f871so4215046d6.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787084324; x=1787689124; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=g9OWuHNZhe61OBLjXm8D+LZBFST1XmHdZMCDCW5KK8E=;
        b=ssI6nvWlaS8pbxt7AN6Y1dEZxZK5CF/GMbsaacl4FI5QXSBiEjIcVoeWdhasLbFi0/
         5i5dJQMeTBa6jG68CJAZG6BjwT04X3YBultRhDWeM8wV/ymruRzkqyM09N9PFimelDGJ
         cKhn9iEBWMYFvLuYETILE+UqGQ+znB8lRLQSnFqt9zVzerfawn1W62MuM4V4tO/XFG2p
         U3XAcSQeaH6ccbVqiv8+W9ewn/kilH+bGkg3NhCGiu3SMkTNvQ+9bdEJNfbfwnUrWiO9
         Jm86Y9XHU3eOsqIWFO3KIH9+5R/7cFX7HVZJCfNwv4pnNLADWxBnlFE9JIp7xJf0wXBo
         rG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787084324; x=1787689124;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9OWuHNZhe61OBLjXm8D+LZBFST1XmHdZMCDCW5KK8E=;
        b=pITMfkIoW8Ihb430l81p7REH2vhgh2LfK92BnSW+mGlFOljL/3/Q99WAY4CebFc5ft
         lkHyGxUr9A6f23R9dVP4XAwt0mn8L38QlfB7v1neZ3JRVXh3nmPxvgcUfyErnHSzMtoe
         hhLeqb5F+OFGRxDFrriDML6a1vQTLcm1AC8JTA1NxxXGvMb45VuNEi+kGAtEyf36LnOa
         hWAdaFZ3Z1Fn3RgYwN7j3j2icXdvrz/E697AbWRlRma5NE9dN9RriWX3PGMa9NLLNonq
         6ugBpGbPdKzAW0aYW/JnlY49EFhwnwiM4PuRClAX3jgAYwW6UWSnTFkn9YLAoE33Os1o
         NSxA==
X-Forwarded-Encrypted: i=1; AHgh+RopqV5RFEuFWlJIAhc0H/JazS780onBPFUIYdd3ccBGugWxx8XLsJsM/DHZ9Y4bT7xEzdNJSTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM0CUqtE2USB+pxq789IKH3aAn13Xfd5eZ3t55n7xOieU7pxrr
	LnheaE4c46E+v7REmBhIX5wB7tzzp/F5ANV040o0u0kINRtNqi0mFwVlKaH87ehEctCRVUuRrU6
	H5VXnZe3Vue1fELuIVsHpUIE+JsKsviSOtIPPGlilB1UR/QMDVTrASJjmOg==
X-Gm-Gg: AR+sD11eQbkGBnUG8kbxpp2K+XUBcSaBnKqbksSCcP1ExE0Hf/vcZlgMUrtvAg9Ivkd
	6VqmfMdX4/f4XuX7qgVE2gOPl49C+5/4dAGQo4RnONsgIA/Wj63rPK2AvGXcRW3UVMl/jUWVGAS
	7VBFHA4MBqFSrw7BrOqR5M0p8/QDxDiuqwGjWfEWl2NjjVc8QgdQO7R2LhczuMYM0WufBlyXGqM
	i69aqTM+PGk5D4X6YAWJTvwlw94gqjz7bk+sjnijHpZieZDl8KSrHZeUuNIhI1PKFs5YOPqhFfx
	DsQHRexZnbeumt78lkS8O0XrLpXjGwWgzBcvfh+V978+XRafHUDp/9TKF65guG5UQhDpyPkx
X-Received: by 2002:a05:6214:4518:b0:8be:7779:d1b1 with SMTP id 6a1803df08f44-90c5c14e795mr13754636d6.30.1787084323989;
        Tue, 18 Aug 2026 13:18:43 -0700 (PDT)
X-Received: by 2002:a05:6214:4518:b0:8be:7779:d1b1 with SMTP id 6a1803df08f44-90c5c14e795mr13753966d6.30.1787084323495;
        Tue, 18 Aug 2026 13:18:43 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4597793esm39672716d6.41.2026.08.18.13.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 13:18:42 -0700 (PDT)
Message-ID: <d7adac6cd62cdf816e0caf96f524d3ff30811186.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau/svm: drain fault handler before freeing
 svmm
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Ben Skeggs
 <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
	stable@vger.kernel.org
Date: Tue, 18 Aug 2026 16:18:42 -0400
In-Reply-To: <20260814-nouveau-svm-svmm-uaf-v2-1-8e6590519f07@gmail.com>
References: <20260814-nouveau-svm-svmm-uaf-v2-1-8e6590519f07@gmail.com>
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

Will push to drm-misc-next in just a moment

On Fri, 2026-08-14 at 18:00 +0800, Zhenhao Wan wrote:
> The SVM fault handler nouveau_svm_fault() looks up each fault's
> nouveau_svmm under svm->mutex, caches it in the fault array, then
> drops
> svm->mutex and dereferences the svmm across blocking faults
> (mmu_interval_notifier_insert(), hmm_range_fault()).
>=20
> nouveau_svmm is not refcounted. On DRM file close nouveau_svmm_fini()
> ->
> mmu_notifier_put() frees it asynchronously via call_srcu() without
> waiting for the handler, and mmget_not_zero() pins the mm, not the
> svmm.
> flush_work() on the fault buffer otherwise runs only at device
> removal
> and suspend, never on close, so a fault handled concurrently with a
> close
> can dereference a freed svmm.
>=20
> The instance is already unlinked by nouveau_svmm_part() earlier in
> the
> same close, so no new fault can resolve to it. Drain the handler in
> nouveau_svmm_fini() before the free, guarding the flush with a NULL
> check
> on drm->svm: on device teardown nouveau_svm_fini() runs first and
> frees
> drm->svm (NULL) after blocking the notify and flushing the buffer, so
> the
> handler is already drained; on per-client close drm->svm is alive and
> the
> flush runs.
>=20
> Fixes: eeaf06ac1a55 ("drm/nouveau/svm: initial support for shared
> virtual memory")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> Changes in v2:
> - Fix a NULL deref introduced in v1: guard flush_work() with a NULL
> =C2=A0 check on drm->svm.=C2=A0 On device teardown nouveau_svm_fini() fre=
es
> =C2=A0 drm->svm before the per-client svmm teardown, so
> nouveau_svmm_fini()
> =C2=A0 would deref NULL (reported by Sashiko AI review); the handler is
> =C2=A0 already drained there, so there is nothing left to flush.
> - Tighten the commit message and the code comment; no functional
> change.
> - Link to v1:
> https://patch.msgid.link/20260813-nouveau-svm-svmm-uaf-v1-1-2d3112dea734@=
gmail.com
>=20
> To: Lyude Paul <lyude@redhat.com>
> To: Danilo Krummrich <dakr@kernel.org>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Ben Skeggs <bskeggs@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_svm.c | 13 +++++++++++++
> =C2=A01 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c
> b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index dcc92131488e..a87406d3da30 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -304,6 +304,19 @@ nouveau_svmm_fini(struct nouveau_svmm **psvmm)
> =C2=A0{
> =C2=A0	struct nouveau_svmm *svmm =3D *psvmm;
> =C2=A0	if (svmm) {
> +		struct nouveau_svm *svm =3D svmm->vmm->cli->drm->svm;
> +
> +		/* The fault handler caches svmm pointers under svm-
> >mutex and
> +		 * dereferences them after dropping it, across
> blocking faults.
> +		 * The instance is already unlinked
> (nouveau_svmm_part), so drain
> +		 * the handler before the free to release any in-
> flight reference.
> +		 *
> +		 * On device teardown nouveau_svm_fini() ran first
> and freed
> +		 * drm->svm (NULL) after draining the buffer;
> nothing to flush.
> +		 */
> +		if (svm)
> +			flush_work(&svm->buffer[0].work);
> +
> =C2=A0		mutex_lock(&svmm->mutex);
> =C2=A0		svmm->vmm =3D NULL;
> =C2=A0		mutex_unlock(&svmm->mutex);
>=20
> ---
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> change-id: 20260813-nouveau-svm-svmm-uaf-bbcf36265aaa
>=20
> Best regards,
> --=C2=A0=20
> Zhenhao Wan <whi4ed0g@gmail.com>

