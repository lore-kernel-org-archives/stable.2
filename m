Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A03531AFD
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171423; cv=none; b=s84EyZ9adtTG0fkAa24YKD05zxdMzm5hz0NQapVwTqal09KGm8p5hYpHDIaPZ+ERSZ6NwUnNZNLhXOrbBMuvRD2UbCcmsU404WfHdRNZ1wRvyFdZHT5C3//FrhdPAjGxnWCyaX7284JPdpmwpo1IlfavI5g3laUrXtOfYX846FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171423; c=relaxed/simple;
	bh=KVzJhu2tABubGhp/3X7B2oZ0AE+ZUq8i3GcO+Yyj17M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HzDEuk7JVO5p8b5U0nqo7umVd5bsrbQtkoU86uf/2DqOX7FUasivKKqV+g74FmQnOuYOkJM3qUpvnKL4C1bVcnO9hi/UUrc7mXiloPuzNBAZBGHT6c+au65gkfxUaUqipZMQCPUWUGVJsIIjUaJbmDHY/m+8nAsXFfqYkMrhO7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoeaklOB; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoeaklOB"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c8c0754so219207241.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171421; x=1790776221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VhOTBKxTDZE3kPAoPytB3fQqVT7gRViOvjJsKRH52ko=;
        b=HoeaklOBG8Yhd3aVUTiSagVy9ByINWsoFh5bf2i20cRUKAs1BbyhgwxYf8/zdSQ3bf
         1CYFRe1Gneuxq+ZSWCAFORo2MeHmk1Gd4l9QqH17Ocmp6Yadkr34azSzXLaogHdToFOb
         VkVLPDEPO/+eHnkyLoLg+iO+iY3Tn9uOsyVoyoB81lkQ93RoXAdrtyXRT9qpz9xAIWDU
         V3hXMEo9xSqRAHpHBfCLjI0TqKmxTC8+xoq9MBlDnD7M7CCnXnTL0nrHMN4ByFbPueaA
         l63J6JUWX6Ees5yp5X4veXu40TJjxp+99VRr69v+7W14LZ1CbwHoSJKTKqsUy4B8Ml63
         Qp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171421; x=1790776221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VhOTBKxTDZE3kPAoPytB3fQqVT7gRViOvjJsKRH52ko=;
        b=LTDz1FJs8s07Na83TEnCWUDRlooyTECY9Iil/byvaposDhvK7JLGn4pgo6BH2rUB+3
         waeKYah/gPaYX0h/xu7gFGiS5Ks2iZJgEM4SeSoN+Jh27sSHb9ceUhZdfouZqj3VdGT5
         IM6iRinRSmes42qamUgNNmPasTC1ElfrJu4r0CO66QHyU6aN1PjKk3KOLVb0ZoWnbywy
         9YreMcmxuOH+ehV20I8pvQ6OMiZv3DN+XlMCvsHnQIaw6j2FxO+LwtexYwVa7EWkndtR
         fQ5cqoJ+R0mdyM401qnzwUn2O1bkQJrPlj/7K61EWn2515mcPPVLB/Z22ld3EKeWc4aO
         MdfQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5FiqTE2ybR5pGUDnT6SraqWbYGGIx2V0mAdBIbdLbECnu1o9hrFijH4OJ+xgzCvg5ORXkBAY=@vger.kernel.org
X-Gm-Message-State: AFuF++kHfMbng/rvpDV9x6JQt1YilUpoVWmd8FGbPBYSnH5jJgqf8Wd0
	rnLhZsz3ZZ1EF0TuLOU132qfafHRanjPEkcsOp7lgOWZYbq6b63D90K/
X-Gm-Gg: AYBFou0QE4MC4kdwm5ubwAUQGfv8VChURPvNuVoxBuZ6HVjukoM0ewUbSaqtzMCODDY
	8zZzYL/+8Y3BHqoPH8/MBHQru0Hd5OQcNK5wgSFml+7+w5HAIHXKpkZoa74n9Nv5oILpQ36n/GN
	3tufT5oAr91Nl6eRbxhdOMeDeQx+3cruJ0+oUr3Nkf4RiNTEP5R3MkdC/lGcHGJfbzcVxJM9QVR
	nLHJTuarIxZU1rTVUn+k5DlxJxjdl2R/FxNG9tkGH4LOzCKzqOAY0xPxWss0tQHCzIywPSQtMsI
	4UrnSSs+iKm6iLRSDX4IkkzJvrl8o9bO1mHlxjVqOL5ixKENejK/tToki3bcQH5B0XLFVcvp6m7
	Sqmn0+QBG7lvGWWAjkpK13xQ3TnBeSiBAdjoesFY9KVm+7RijqlLtuZ82sln3GvL+LJVWh/fV/m
	03PBqf6uX69ZbFOCurmPE+VfuNn+ONVX6IHI7+JhS/V1tLbvIAVfoFnUizerA1HbMwmQaBdzKPz
	g==
X-Received: by 2002:a05:6102:f12:b0:7a6:accf:72bc with SMTP id ada2fe7eead31-7ac0754f89cmr2473350137.0.1790171420881;
        Wed, 23 Sep 2026 06:50:20 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf6087f6dsm4100538137.9.2026.09.23.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:50:20 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/vmwgfx: close TOCTOU on guest_memory_bo in surface reference ioctl
Date: Wed, 23 Sep 2026 10:50:12 -0300
Message-ID: <20260923135012.1823971-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmw_gb_surface_reference_internal() checks srf->res.guest_memory_bo for
NULL and reads its buffer_map_handle and buffer_size outside the
cmdbuf_mutex scope that protects the backup pointer.

A concurrent surface eviction can NULL out guest_memory_bo between the
check and the use, causing a NULL pointer dereference in
drm_gem_handle_create(). The post-mutex reads of vma_node and base.size
race with any concurrent backup change.

Move the NULL check inside the mutex, and read buffer_map_handle and
buffer_size while still holding it.

Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create and reference")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd05637..fff4402 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1718,15 +1718,21 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 
 	user_srf = container_of(base, struct vmw_user_surface, prime.base);
 	srf = &user_srf->srf;
+	metadata = &srf->metadata;
+
+	mutex_lock(&dev_priv->cmdbuf_mutex); /* Protect res->guest_memory_bo */
 	if (!srf->res.guest_memory_bo) {
+		mutex_unlock(&dev_priv->cmdbuf_mutex);
 		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
 		goto out_bad_resource;
 	}
-	metadata = &srf->metadata;
-
-	mutex_lock(&dev_priv->cmdbuf_mutex); /* Protect res->backup */
 	ret = drm_gem_handle_create(file_priv, &srf->res.guest_memory_bo->tbo.base,
 				    &backup_handle);
+	if (!ret) {
+		rep->crep.buffer_map_handle =
+			drm_vma_node_offset_addr(&srf->res.guest_memory_bo->tbo.base.vma_node);
+		rep->crep.buffer_size = srf->res.guest_memory_bo->tbo.base.size;
+	}
 	mutex_unlock(&dev_priv->cmdbuf_mutex);
 	if (ret != 0) {
 		drm_err(dev, "Wasn't able to create a backing handle for surface sid = %u.\n",
@@ -1746,10 +1752,7 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	rep->crep.handle = user_srf->prime.base.handle;
 	rep->crep.backup_size = srf->res.guest_memory_size;
 	rep->crep.buffer_handle = backup_handle;
-	rep->crep.buffer_map_handle =
-		drm_vma_node_offset_addr(&srf->res.guest_memory_bo->tbo.base.vma_node);
-	rep->crep.buffer_size = srf->res.guest_memory_bo->tbo.base.size;
-
+	/* buffer_map_handle and buffer_size set inside the mutex above */
 	rep->creq.version = drm_vmw_gb_surface_v1;
 	rep->creq.svga3d_flags_upper_32_bits =
 		SVGA3D_FLAGS_UPPER_32(metadata->flags);
-- 
2.43.0
