Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438A471437
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546853; cv=none; b=QF+24fONmS2C+n55CRxPhXljdxKxqJ+aYwE5+Z/KIUxZQ5tL6jIKJXfxuJxhAVQgmiRuLXF+XU3bErfQtu442G4d+DNQtR48UPfySrAmDUXZQOmsLhr/yJiKz3VoZbVV94t7mM9c+ntaJ3+eDtbDz4FQlt0cOi6ITFgWyD011EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546853; c=relaxed/simple;
	bh=DHIfdikRkZ3mKShlh/+V7tgkqvRSlEckIAj2mwx7osQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KC2INdrDJk2m8phGwZjjkreIBXMCFdqjem8AzYQVJSPyCOtupeZYiHx+hKFZ9lH2Aq5mjaHTM3HOUNy6Hr5XwTMom0ovgx/AvbaQJn1yHAUvgSeOgu3UKYWXq0ktJlqd/QUAF7uyh17mSpNsN87Ha51n94eSZTa6n3YbY7rcopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCx51Aij; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCx51Aij"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1249130a91.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546842; x=1787151642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gMOizgIP9BJQteM6A8h6tNJgWMELd3MPmjUznwQtZHY=;
        b=DCx51AijNjNrBVKXBrN/3lItroBwd/0OwR30xPUd0FwzXYNZWbP7SHn1G/Wxzxcjyu
         mztfeW8ZJ99H3ukQsMnYYhvGkmUPguUr3or4uhCkdSP8ji+nUfOu+Z+W+GzLccB1bhXD
         p0vGHt65yLsO3rNYf2E/JaMZphV7AFUPMqNeBlY1PFcJ44iKpBC9WVdDmy562Wm4Y5/c
         yyxnd5QnEqHM7+WSn8PPwQL1shzTGQBRz/pmJRVbCJtV54XxV9lojqaI9RBZG3dBMt5s
         8ZWvF0PYFcKwH0T9OeHiLg2RGLaoowRKk5gmmDr2ZVB2R+btBlvgGTApWlzedijPQVR5
         NBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546842; x=1787151642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMOizgIP9BJQteM6A8h6tNJgWMELd3MPmjUznwQtZHY=;
        b=FhWhrV7LBDBBr73U9U8iHfG5ywJB2COJj8RH3sxo4UffX8J6U10DuorNAU3kSqUJJU
         tvQXbRMCrbs/kWeUOharq4zlMfCmAmfix8T4ejbmwBEAddPdASd9F5uEHSkiU1q+8RPm
         oMe6GzARauYff0gqxB+kPEt405kTkiK8E6hnH4dxBr4FFKoozCnXeoiJ0raVH0jZD7Z1
         zn13wtL6AQjanGZW8HkGQRQ80kDri5fv5fMGvUpjSw92MIbqw9fucXgAtgkDRZAYr8vO
         XyLR88sCsrNV+P6SSNySdTmEtSvegoDRsrn2H36eqb6MFpnz2vG7bHydDr4cUbHYnvFT
         KiDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqM2XgtFi1LUStMSaigE1pKcv8gEwkb/awhy44XKfdWpsD1AqJpUBZ9hTQt9+fokSSLrGu6pxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTv0yexhvW14X4e8xAyG6hyIzDbzKRmZYV0OeNpvzA3OYG5TVw
	YzddYsnggp8bWQI5OiNxGheS2K1TzDhtHWMxWgK8NlXaNHDfceu9Kn8u
X-Gm-Gg: AR+sD10ugfOdFn/sk/TRrGlQDXW04L9NFbFstUzpE+B4mi/qfoEMbvLsZa8YccqbjZF
	IZEZuhu9UcXqmhivD8exxYSGTQMn3gXkwV4wsic4CtDGsSnfP70WjqVwNkkOrUqDTBiP6mHeYJT
	NdVoKB07r3hgpBXwYMMVdhx+dSVj+6oBxnLlDc9D3+RDLHb22RTzKFt0HMsO/D9fMvJ1FsyC4Di
	+pQMQJrpwC/3XX/XlWuD4LPgpwDE6ZMBhvaaNpGlnI3sUVsdqKpwA1Dbqh7xDmx//Dhh3fQ4z3d
	NBoQXNZSd/LBhWmL+nvDDYBhfpfjSiiv37YfMAYh6OPatwOrrrQ95kKjyvuj1cDvhJLSnWi4B58
	FwOqskNB/0KL3RvV8kCErFxB6NYlkLiFinxwPDD+RMU4LXQGLM6+lOf2EIbVOGYLQ7aoVN9/vsv
	NoaLDozCwa5vmGJJO7ryv8hfnVCtJfldBqmmQ3FkFjulINpQIcO+Ew1+JR5yI=
X-Received: by 2002:a17:90a:dfce:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-39300fe8cb7mr6781997a91.0.1786546841182;
        Wed, 12 Aug 2026 08:00:41 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f935f73csm3896491a91.6.2026.08.12.08.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:00:40 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 12 Aug 2026 23:00:05 +0800
Subject: [PATCH 2/2] drm/nouveau: prevent NULL deref of gr in
 GETPARAM_GRAPH_UNITS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-2-7e057f6aeba0@gmail.com>
References: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
In-Reply-To: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786546828; l=1659;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=DHIfdikRkZ3mKShlh/+V7tgkqvRSlEckIAj2mwx7osQ=;
 b=HXxJzWcsyd2sKVHR1T+erLcdLCL/gkjA+9ra5ROLCdEp3ElbPtmAtHX0Jsk42Eej69Bbe3s1z
 JWrY3tlQYitDwdc3sM1wMfPD79z2pvggbmWqZhaxh2KZjHZR0tFAaXe
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

nouveau_abi16_ioctl_getparam() fetches the graphics engine with
gr = nvxx_gr(drm) (i.e. drm->nvkm->gr) and, for the
NOUVEAU_GETPARAM_GRAPH_UNITS parameter, passes it straight to
nvkm_gr_units(), which dereferences gr->func with no NULL check.

When graphics-engine construction returns -ENODEV, NVKM treats it as an
optional absent engine: the NVKM_LAYOUT_ONCE device constructor deletes
the subdevice, leaves device->gr == NULL and continues probing, and
Nouveau still registers a render node. An unprivileged client holding a
/dev/dri/renderD* fd can then issue DRM_IOCTL_NOUVEAU_GETPARAM with
NOUVEAU_GETPARAM_GRAPH_UNITS and oops the kernel on the NULL gr.

Report 0 units when gr is absent. This matches nvkm_gr_units() itself,
which already returns 0 when the engine exposes no units callback.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index 291203121f0c..dd3f8d386377 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -306,7 +306,7 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
 		getparam->value = 1;
 		break;
 	case NOUVEAU_GETPARAM_GRAPH_UNITS:
-		getparam->value = nvkm_gr_units(gr);
+		getparam->value = gr ? nvkm_gr_units(gr) : 0;
 		break;
 	case NOUVEAU_GETPARAM_EXEC_PUSH_MAX: {
 		int ib_max = getparam_dma_ib_max(device);

-- 
2.34.1

