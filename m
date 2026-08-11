Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCA40A943
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786482867; cv=none; b=EQ/lJF1WOzoND6VliJrxsyRq9moOuuz8EvbvnCdUO8p4RR6Wwzh75KITUzhd3rwBx6FLxfzjbiVYYMTAfKuiFawwzdsZ2SZAZjIx3j4cc1ObGOxLStOEKYyAmomB5qMq8REYvR98ZZvZtQm4LojeeGLlXxzT2SiVR+am5Mgd+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786482867; c=relaxed/simple;
	bh=DJlsgckZYzlASAM7E8A4/qDxmyOIaLaapT8XZAcOt5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxwkxrO6cmhPoYDmMVOhl9JjDA1ZIS/+9hAMa9ZyqBYsdPhCQsGtzOvFLfV/ukKmFWM3In0JtiTqRb20wK2nu/zJ7DQ6QQh+UxhSXxj41CLbWl8IpboNsOJggAubYmoJRYsSyAmFzL4s5/skMF6bQEkz+jkGN0N3qZWj/mhM9VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBuhaORv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oduX3cEz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBuhaORv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oduX3cEz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786482865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ouhsGoLziLRHCm+hWwEcaYZBRlXQpJLyEgr0LCF275A=;
	b=gBuhaORvgo+qRjZKqrpGpTRLdSPr2jimaxFkrCa4u/Tnr9DehswVktjrMGwVUdK9ytfWx5
	sboryWMasOfnTksFzH9SJEC/UqvxeQHdrOY0J0P5Sxpws4pkXFZz/9NOikDlK2ljXyeGY+
	O1IwAWhSYdaYc1rrBDuVGEkNzGhqyKQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-u0U_TDoKOZmEL9ju7DOZsg-1; Tue, 11 Aug 2026 17:14:24 -0400
X-MC-Unique: u0U_TDoKOZmEL9ju7DOZsg-1
X-Mimecast-MFC-AGG-ID: u0U_TDoKOZmEL9ju7DOZsg_1786482864
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9349c5af52bso69149485a.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786482864; x=1787087664; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ouhsGoLziLRHCm+hWwEcaYZBRlXQpJLyEgr0LCF275A=;
        b=oduX3cEzMIwgZrkgMDmgPpaLd+denstIld8z1ayDZ7dS15BNr1CPZl+qZcwuYJmQq2
         UmWXbLF3cIMOwN4N5uYZ+Qkj2Kq6pt6nnUoGaA9M34A2pNTPBhm7h538H6yx2G/+n5L1
         e4QbKcGySyUReaTwUMGtR4sZuB92SexxEBwnC++Mat86VCg1ObZZAKu10y1JaLekJd3d
         99xi+cLksa8swlEc4oNJ9c6Z1nasSLGbHGvoQZDnFG6auaoXolcA38O8zrNiAwZavzrG
         Sm/FE+jj6g3fbNgqcCbEMLjdqCrbZgKy4EsrlEl+6prRObhQcYs6fK1OKbgsCOqtDWEn
         GFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786482864; x=1787087664;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ouhsGoLziLRHCm+hWwEcaYZBRlXQpJLyEgr0LCF275A=;
        b=OrSUpb9dKNxUocK5uGu/lCTu2b872esHq7+EySMcwGoz/u+l+w4unJhZMGA39Q2/Ae
         X9sM/gn6EGkbuBJLVy9o/bcKNt1enpOAmCOtACXlWMtmhkKnRU6XnjuzxT6KN1pprylU
         40VWskyKiXSJUfyZEaCL+phpBZgrSPyabSPe+J/klf5LYlAroYmdWa6gPKjl7Z+UQLiZ
         C7xwb9hNNSYyYSmOQgE4QkVftCzNvFwPwE/ONluf5YLYcu+U4Mnw94SgyoWsLWQI0o7Z
         AjeAypY20o0jS/yxbGFwwo3BBrjYkXnJCN31UUgCEAtvdxO27d5h+h0db43WyMOnH8no
         RDCQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXe+yiTpDiFbRbI1vTh0xKdqk+PbkA4hnZ0BYLJ5NuE3GoZ3SPWcCBsOUZCgq9iBhobrXRDQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iY64mKXT5xoylI05mOLKiIqs/K1edIJf2wqJv6YLymdgKNhK
	Z5NCU+2wFtE3hwys6yLJhhGAaScZ8YVwGJW3v2ieSi9l4ZTiyBJDU+xw3PVxpstPh2NECcRpOdj
	ywNjS5iX4FOH6FoEVFIL0MHADeilCRJQJhqoMegVQ08Y9qkC5tSkjMLEsDA==
X-Gm-Gg: AR+sD11vajnvhdDkin+2SnJ3SWZouGRc9MPc2z/2D98xyVWiZDJzj5WksavMf95jLDF
	TBcd2i18IXU0TNEzymG3bZrzfHhtwE2P36GHu7nydK9fh9tRxxlIMmgSTYu1J6lpPek1CDlVyYm
	/Wf1Bk0VWm9nnavv9/fM/TbbsRK/wXHNp2LulwRziZxUIK4gonqDD8DDK+pkTKVixkbiaiQdQa8
	6UKucBH9KJK/8DHibl9u0LFcDp22oNiQMQ4Ww6VRSeFeqgHFFmIVxqX26dOuSYay6MjsDbObROx
	7c1Riwq3LosYGFJFAyq0oL5CO3mhI6S772Rxc34D0eNt767KcWZf+Xy2T8rR39j/lwqCLiwJ
X-Received: by 2002:a05:620a:25cf:b0:930:a718:bafb with SMTP id af79cd13be357-936b3a4201dmr39432485a.10.1786482863560;
        Tue, 11 Aug 2026 14:14:23 -0700 (PDT)
X-Received: by 2002:a05:620a:25cf:b0:930:a718:bafb with SMTP id af79cd13be357-936b3a4201dmr39428185a.10.1786482863056;
        Tue, 11 Aug 2026 14:14:23 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936a848e7ecsm196988185a.11.2026.08.11.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:14:22 -0700 (PDT)
Message-ID: <a24ff71ff94630ec818477ce6c590215ac3839e0.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm/nouveau/dmem: fix callocated underflow on large
 folio split
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>, Balbir Singh	 <balbirs@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
	stable@vger.kernel.org
Date: Tue, 11 Aug 2026 17:14:21 -0400
In-Reply-To: <20260811-b4-nouveau-dmem-thp-fixes-v1-2-2cdf9860af2a@gmail.com>
References: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
	 <20260811-b4-nouveau-dmem-thp-fixes-v1-2-2cdf9860af2a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

This patch looks suspiciously human written (or at the very least, the
commit message sure does). FWIW: if the code wasn't itself generated by
an LLM, it's fine by me to avoid adding the tag. Most of us are
concerned about generated LLM code that gets submitted, not human
written code written to fix a legitimate issue that an LLM managed to
help find. If we were concerned about the latter, I think anything
sashiko touched would end up having an assisted-by tag on it :).

Either way, this whole patch series is:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Issue looks quite legitimate, fix seems fine to me.

On Tue, 2026-08-11 at 22:28 +0800, Zhenhao Wan wrote:
> nouveau_dmem_folio_free() drops chunk->callocated once per freed
> folio,
> while a large (compound) device-private folio is only counted once
> when
> it is allocated.=C2=A0 When such a folio is split, the mm core invokes
> ->folio_split() (nouveau_dmem_folio_split()) once for each new
> sub-folio, but the hook only fixes up the sub-folio metadata and
> leaves
> chunk->callocated unchanged.
>=20
> Each resulting sub-folio is later freed separately, so after a split
> the single allocation (+1) is met by N frees (-N), leaving
> chunk->callocated short by N-1.=C2=A0 On the first split/free cycle it
> underflows: WARN_ON(!chunk->callocated) fires, the unsigned counter
> wraps and never returns to zero, so the chunk can no longer be
> reclaimed (nouveau_dmem_fini() also warns on the leaked count).
>=20
> Account for the new sub-folio in the split hook, under the same lock
> as
> nouveau_dmem_folio_free(), so the count stays balanced.
>=20
> Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU
> memory migration")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_dmem.c | 14 ++++++++++++++
> =C2=A01 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index d2abee3efb9a..ad4570c50be7 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -279,11 +279,25 @@ static vm_fault_t
> nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
> =C2=A0
> =C2=A0static void nouveau_dmem_folio_split(struct folio *head, struct
> folio *tail)
> =C2=A0{
> +	struct nouveau_dmem_chunk *chunk;
> +	struct nouveau_dmem *dmem;
> +
> =C2=A0	if (tail =3D=3D NULL)
> =C2=A0		return;
> =C2=A0	tail->pgmap =3D head->pgmap;
> =C2=A0	tail->mapping =3D head->mapping;
> =C2=A0	folio_set_zone_device_data(tail,
> folio_zone_device_data(head));
> +
> +	/*
> +	 * The split hands out a new independently-freeable folio
> that will
> +	 * later be released via nouveau_dmem_folio_free(); account
> for it so
> +	 * chunk->callocated stays balanced.
> +	 */
> +	chunk =3D nouveau_page_to_chunk(&head->page);
> +	dmem =3D chunk->drm->dmem;
> +	spin_lock(&dmem->lock);
> +	chunk->callocated++;
> +	spin_unlock(&dmem->lock);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct dev_pagemap_ops nouveau_dmem_pagemap_ops =3D {

