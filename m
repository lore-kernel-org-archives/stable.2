Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099B3EA955
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696660; cv=none; b=RLOJpcXffP3y4/zQDVbVzqRWImgSC85aZ1CN1XMuSIPQs8hHR/8MUxp2sDwxtoPdsDsPiQmpuj3pHN3kZsSD3xOVPBJaBfnWkBdqbpd+SjMGPWRV6pvn8qsI8cZJSupqPt2c+cSmWCw7PyS7mkLsdLPDG0LSEx63FSt8niUrfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696660; c=relaxed/simple;
	bh=FsC9z+5KqjTqBr7jf9uBgCkDB9qmd1T3Zp3yITNmu64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JiJ2hmEbmUE5opoXujr28MrCkJnmJ0COj3CjQuPKCQdW1QiXyXixWGVJE9+b/CkLRZyn4ZCCxGk5aRirWsvkB6RdTxuw6HX2aOF3v6BH+hPTkZwntOUTEhyQ4tx4hKt3EthOqttJvjfkmkKU+yBIXFVSE8Fc2rJ1wt1r5XV5Gcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8uOxm2c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvidQL6A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8uOxm2c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvidQL6A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781696658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HW7N5ERr5Ko13FP1e+xp+U+3cKGn0k0mN8ikI4Rsw8s=;
	b=J8uOxm2cNuNUZLuxh2V4y54yleGRkhPulJv0tgD9KddOR6GYmCEiU9JRh10GmpJ54gCS+9
	22yD9Xnx8Vb2L9gEimZq6W+1VYmY/4PXEbke0BwkuVi9S7QGU40RK8+V9lBvQR00ELw503
	rz0IXLzlr1MMqsMIQlLxJCy1oyWmdDo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-_fxlc_DRPYe4dP24hgtf2A-1; Wed, 17 Jun 2026 07:44:16 -0400
X-MC-Unique: _fxlc_DRPYe4dP24hgtf2A-1
X-Mimecast-MFC-AGG-ID: _fxlc_DRPYe4dP24hgtf2A_1781696656
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460153ce644so4144596f8f.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 04:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781696655; x=1782301455; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HW7N5ERr5Ko13FP1e+xp+U+3cKGn0k0mN8ikI4Rsw8s=;
        b=SvidQL6AFYjgrcTuBgSBITFGVTHa9XYNuMP+gXBqKXwyX+GTX/p10snbKsdtIwBkT4
         o6BHJ1tG5TgzLVpVPj7l9Y46ktaR+wrdvSZmSbuZXZzq0WUwLsKO5JAWEsfd3XLpL5qA
         hiJe4YS+2okoRp6HyRl72AXRSY8w5m0msNKTmOT56qOsHMao3jWPPMXeIbS6oi8SXySS
         8mQVQ4VByA/nfm4FM5pJYgiWfGt+eosTCQuZeJOzaY4PBjd5zlnchVaYe2XdWmAF6+Li
         JAaNsVVD7cAnOgZCBgjnoq2xM6j1ilLIAMlpxa3Pid3y+Idm1SCDjrFjARK6YMxGlSE2
         FvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781696655; x=1782301455;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HW7N5ERr5Ko13FP1e+xp+U+3cKGn0k0mN8ikI4Rsw8s=;
        b=qa1ic7KZZx8ya1dhdhN1psylZgEG0tkLGqJgpBncFbj8/4LWiZ0SWsmKdVXZx6q6RS
         6zZaDnLqkRn2hvHCQkN26j11hWRqyZhYA9rNriVpKJyJ3sul7JgSSudzMiccWkm+r4dm
         IRvpylfq6YMWhHv5g3vfSorUW3+uoxWYstsxYVT5x6jPRZySQVozUeJ3+byDr5Z6Hu2G
         zMm35aprJf2MdNtNri00rsAGCtoNzIFRt8aCW84AMXbji+Jd37h1zVb+MlFQ4VAp/6af
         eUJ/i7fmVmDu6UxlZB404GxoqIYoaLi4MkpR4zP2BrbHslTODxwMeAeXLaIGZWX4g/jQ
         Pn1g==
X-Forwarded-Encrypted: i=1; AFNElJ/uEJ8QITkJ2IHAFM83eezyy+5eiQH5tCUQ/lXhWWnFgATwQin9NYvlMkpyuYez+LZHpCNyotQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJnP64Len/K11WJaE+Wdvt9tNaH83AZWfghJuld9pmZG7A0shS
	jJ0e1SKcvucP3PMLGHQpAcOzmIILOBLdaFb4VL1EHCgWpWo7JkzDGzsQ3wX5Ah863GzRZWBirZg
	gIj5bYEvZaFeVcrbSgNCuziLYyFXi0xWgIdNkfBIciqOYZEJ+w2t9tbLgkA==
X-Gm-Gg: AfdE7cnvZ4dTjETEypJ8pB6y8eOdUyy7xmVs4sfbUiJwgQATW2kK8Deh+sKnXO7vFWj
	H9VGvIdi4qHR/LbWcaXxHArR+36egGNhh+tyRjqQ28r4K4dBjRUskq5MCKaumcfwW34rtdpQkGr
	pnWbPIbZdaJKwSysDv2qM2t5VO+ZJr6m1JivGDT+l/yWHAKqp2OlXQ0yPL2Tx24yzXi94nIr0XH
	pS1Ke22q6f4XcpwHumaPOGFU7zNwTICabLfZmpR79vjrD4WZqlYtB/hUmyTgklvpzsKfeEGcsED
	3iwYjGt8Bjb6H6t3j5iWuwSf4ycaBBxz99CRmliLwWdWKbbz/wUvJGWUN3s0HjlEcqG9bTDzeDB
	t+E7SPaTjKenzF0fqfI53WeMS0Wwetzo3Tvv3VDaE2xD0s7iXDARZ/o6/blGgYkb6jz9FWA==
X-Received: by 2002:a05:6000:4b13:b0:462:e086:35f with SMTP id ffacd0b85a97d-462e08603dfmr3383258f8f.21.1781696655451;
        Wed, 17 Jun 2026 04:44:15 -0700 (PDT)
X-Received: by 2002:a05:6000:4b13:b0:462:e086:35f with SMTP id ffacd0b85a97d-462e08603dfmr3383197f8f.21.1781696655005;
        Wed, 17 Jun 2026 04:44:15 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3782sm47931839f8f.25.2026.06.17.04.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 04:44:14 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/sysfb: Do not page-align visible size of the
 framebuffer
In-Reply-To: <20260617112932.511657-2-tzimmermann@suse.de>
References: <20260617112932.511657-1-tzimmermann@suse.de>
 <20260617112932.511657-2-tzimmermann@suse.de>
Date: Wed, 17 Jun 2026 13:44:13 +0200
Message-ID: <874ij1z90y.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Only return the actually visible size of the system framebuffer in
> drm_sysfb_get_visible_size_si(). Drivers use this size value for
> reserving access to framebuffer memory. Increasing the value can
> make later attempts to do so fail.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
> Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+
> ---
>  drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> index 749290196c6a..361b7233600c 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
> @@ -67,7 +67,7 @@ EXPORT_SYMBOL(drm_sysfb_get_stride_si);
>  u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
>  				  unsigned int height, unsigned int stride, u64 size)
>  {
> -	u64 vsize = PAGE_ALIGN(height * stride);

Do you know why the original efidrm_get_visible_size_si() (from where
you took this code to make it generic) did the page align ?

The change makes sense to me though from your explanation:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

