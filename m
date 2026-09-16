Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A2412C15
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551011; cv=pass; b=ux4nvCdLWl3r2iQlmIn9Y106ux0tktCUZPaW0k4Jeqe6oaRlt+tmn3tf2oQqQXtOOEv4mnMxjjYd8/Knxr69iNVu5owkOW8wrCBgadnVEJN3Hcoo34acSyVPVSYXEh7Lv5j0HxWPhHA1So7pUI0KQM8W/60l4CN7kA8Eg3F76Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551011; c=relaxed/simple;
	bh=rVlNPjI4P2z37o7qE9/JXBSWEwGmZChcHXGnM7D9n6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVPCrmYX5a6LN0NRNPRUGHNoQiNcBBUmLUIb4i6nkGXhONJxBX0c7TiqCD7alqSLrzJQ1ApVFQV9c6ekj/ieRFv0qQee7j0KE0gl8lwq/GGGJ7SFSgmX7KnBxUMZVYzT7MjuTSFVGVdU4bj5b2EkP5iKTJL+6YG+Dnfvfaq6OC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCaIdDCy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRnBBIGW; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCaIdDCy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRnBBIGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789550997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
	b=YCaIdDCyoE93yZmBAfESVoajo49TPwa7hyUImgklXjgAUauE0Chzl86f50GNoG1YHkECbX
	uKOo7D/Pns4ekjXFNcSGeDA73JAlN9XoMn0nntR3B7692bbvQVsqyPCtGxslQ+DCgKEJnz
	UEYk9QAiKvMY6GLKrQa4HtfSFvVHLhs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-BlJGR9kGMLWN7-mMx3cpKw-1; Wed, 16 Sep 2026 05:29:56 -0400
X-MC-Unique: BlJGR9kGMLWN7-mMx3cpKw-1
X-Mimecast-MFC-AGG-ID: BlJGR9kGMLWN7-mMx3cpKw_1789550995
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db22383e8fso28716375ad.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789550995; cv=none;
        d=google.com; s=arc-20260327;
        b=m4EUiVraiqZ/TxPpH9LAPgpSWhtUkeFJAEc/1xtX3x7M9/gJFy5VOLyZRZZ9odnm1q
         rBcMAwJSn5xfCcLdPDu+4nzAgEKCJjYl5v5V5AfNHmsq+oSHR5YGkD+HPCZxYfCJbS61
         pEPZ7ZAwhyGv7oJFtjo8lWUTtrvt353NjX/M5K1CLUPej8ZUjeiRHZ/uVO3ZWVR763ev
         Eu8BEnzXAZBwKoPtlLsa2pa9AKV7Gj3jcjX8mr7NohEfLa+++d2ZjXHZaDxXmcpaKDQ8
         yepLPVDn5IjiIYtnUBACD0oOKrFgVcc8/qCctvk0zWBFOQAc+hGIKfZG0pU+GpFVnhkJ
         iM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
        fh=lipP2dA1KwK94qDAKYnMJ8K2xrKqLXw56NlGv98QXJ8=;
        b=HKu4QSLLDpuGj3enJaDUSUyHlqk6OJ5vzHWGfvkcuGaup2xerKNqO4U1t7ah3oFn4u
         KRKgtof8rB4pDyH+3Y7ly6FPjkM4zgDTQ9HEatH5RMETLpOsx1bLMKWvomm8CWcOafsj
         mv6JG00IhG8R9V332WvYcrTvZ4G2BRZu5lCR97NkMLkCNLszkvxEUwRiNlmp3wfqxb33
         0Wnk5Kbm6sdwv/VZeDLEZ+s4AYY457Yf04AiZpcHyzMfwVYexYAtIHzfvoek4ZVxTnPr
         gyc08EhQ3AXiTNvS+tZ0c3jEW8OzfBvp4orQU6C38Dkp6Yw8AcT7yGdOP19j/9pJ91Pa
         fQrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789550995; x=1790155795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
        b=WRnBBIGWZwHMn0ZjkwESc0vAF9AHz6MKg5a+Le6ugPl2SpFowsXuhEonCafP6F+ZjS
         W0qMM4kk5aqErx/gFDyI3fCZvELr9KMvk0bjPR25BsIwqMIPUiCxlChn6VbCIGc8Hr8x
         P/l7JkuNt+enKPxChzh6cIms67RaPlFkSL/Z066e2tEsw+Uwc9bnKUAAbowsgS2leZRA
         OgzKAvyMwJprx4UXVctmV8jAdbojb3Py6EnFTTziuHf4d+aVJMrjh+5ZCUuLooOyDPkz
         pgiYOkdl6i/0sf1bBnzYeUh4vWE1OorhRxF4143F35mg7tBnNp2s1cEAK0jCLZDswaS7
         lZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789550995; x=1790155795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
        b=X46Qx/RkPYH4QorlVDArrSjkEVuJYq7aywCx3UZy003611QqhESdx2/jClhG3Ch63S
         Ikne+WiGuJxPqOSg1FaT32U0VW0EJu/OWwNNorys2EdbFg3S8Kvuj8W4lfP/ZfCPea+Y
         om4xN/xGgnCQ/19TGeIy4Veups3ZOJiHEQd9vOt/vOiDcM+hG8ht/k94VjyOQtHOUvG6
         0euAFvs0qv6XmY3p5RQQ1G46hoK21PaPZHlamkuSqkNdnbsgHo26dYpgKUF4lqn7hjvO
         6M6rcTL/B3WG+wC4RNirN97o/q82GJxAIQxbubYqEAnwXV5lW/2eHMY6Fm9NfEYIBMXm
         Psuw==
X-Forwarded-Encrypted: i=1; AKwUvBxwvkwG+9HwRhWmeTKGhHnRrWZYv8mtfvwWyOV0vbx4gNeCmlIsIfC5TtuOHAOAbrqzqxy9Ui8=@vger.kernel.org
X-Gm-Message-State: AFuF++mBVDFKsVYGNOVS5ied4o3PLr8bUpLNbvl3Paqj9srksh4D2O9m
	Dg1jS7c9IgkFyEQ7pGCG0bTDGETkQ0Jzf8oaBT7P2CIXX7fTzJ9AcQ+GdxiHrWnQE4Zaa0lW2WH
	pO3hmuf3k+elpNXj3lkgB/QlB7OC5erKdaMPlAFNnroAln4lLBZ1JpaNF4tTfsXEDdCzdhCxwVo
	0+/AB4t1M/S1tgE1hSEvmWqbrxvCy6UzjK
X-Gm-Gg: AYBFou2K6tz/CAOHtVozQ1KPQNnPfkcFZrYM2aYoOu4g9Nytbcw/Cmym8eqZewVlKJL
	/8Us3DIEL8NVZHM9Huubm/uIjhJ522FZ5nGFN8s09jYmsPUiTdH0zOKjkxiaYCXIuWt5mIH75mK
	T/ZJrdnPbdDmhwcsfakz+980k3YI5Uw8EZ3td921GkM2K8mHuWNfRqC3EM
X-Received: by 2002:a17:903:3b8f:b0:2d7:4bc8:41a4 with SMTP id d9443c01a7336-2dd8ea1cd1dmr23798615ad.10.1789550995058;
        Wed, 16 Sep 2026 02:29:55 -0700 (PDT)
X-Received: by 2002:a17:903:3b8f:b0:2d7:4bc8:41a4 with SMTP id
 d9443c01a7336-2dd8ea1cd1dmr23798155ad.10.1789550994573; Wed, 16 Sep 2026
 02:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911124540.279841-1-tzimmermann@suse.de> <20260911124540.279841-3-tzimmermann@suse.de>
In-Reply-To: <20260911124540.279841-3-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Wed, 16 Sep 2026 11:29:42 +0200
X-Gm-Features: AcwNN1VjQRR608PaSU5v9yXg9eP7o3aE9lu55JInhqrDujLUhvS3kxSMIUXF4N0
Message-ID: <CAFOAJEfWX09ZvnQvn1+SBeW4_MaSRO2JNLfoJRGYS4jXGr-09w@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] drm/panic: Test address from kmap op for NULL
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jfalempe@redhat.com, airlied@gmail.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, geert@linux-m68k.org, rdunlap@infradead.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev, 
	sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

On Fri, Sep 11, 2026 at 2:46=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Do nothing if kmap_local_page_try_from_panic() returns NULL. This is
> not likely to hapen, as the previous page from the same memory area
> has been mapped successfully.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 23437509a694 ("drm/panic: Fix 24bit pixel crossing page boundaries=
")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.18+
> ---
>  drivers/gpu/drm/drm_panic.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index ba21df4be338..d28ce8878e05 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -178,6 +178,8 @@ static void drm_panic_write_pixel24_xpage(void *vaddr=
, struct page *next_page,
>         u8 *p =3D vaddr + offset;
>
>         vaddr2 =3D kmap_local_page_try_from_panic(next_page);
> +       if (!vaddr2)
> +               return;
>
>         *p++ =3D color & 0xff;
>         color >>=3D 8;
> --
> 2.55.0
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

