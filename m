Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C82F90C5
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789291021; cv=none; b=k5YJo8m/NmYaxM0uEeJbFJSgper+drfauuBQdh8HSf4n1KEvy6m9NDHX+cigyPKjUIEXJx1hi3VKWSGnpKH3y2AdmXF+ve45OSyMyy1ehCWQVjgr2aqopcahZa64BeqnENkKj1vXzDwawAmhb7ZUG0GDtdrpkAAL6/qqYCmVWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789291021; c=relaxed/simple;
	bh=cMiptzkByQhLBMfPKZ95f4RtbJX+VASD+YXlH7rsAmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YA5waId1mqjMmLTqUV7uSmTaVcHJjxOdMHI4K8Pa76YPG/MelFuxMIMTP4mcKNuQNXPN+yp56ognlgelRdg8/QV/R22bBWJE7JBdwMZoUATUIn6fOl2vfSg84LBFlbVOm+IGhD6EQ2oQf0HpcQB0kbflSgFT4kcNZoMOu5E/urE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Klo2sO7v; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klo2sO7v"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so8232305ad.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789291019; x=1789895819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hl7UPP4ejrps6ty9GNEkOxkDv0jyU5q+6jxLFrutl80=;
        b=Klo2sO7vApGC/mdbM7sR466wLYFqnkzM4PfFL2nSB/QYUMW3Cx3883M2gZV5R9ZpeF
         itk1EVK6jGVKXJqQ9UZkuSTrMtH4mNMdmjg95OvWXgaa6RbaaqwS/tsuqhAWLGgpZcDK
         mI2p+nUqc2ByTuGjL4SbSL+ewuV7QkQop6L2+BRoWBC8pcgjhhixUrhKnE7Q9ZMDF283
         9JnroTAtMxDsANSrPU/1nCnGhwHauu5psijsQvRo5kwBbqpKuHe1BI8tWnXxv+dqw6xL
         FUOQO+WGkqQozHF8kJYc7b870gj87swgXgPBS4xrbv8S5yErV6AXqlKH64k9daKkFWQg
         iXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789291019; x=1789895819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hl7UPP4ejrps6ty9GNEkOxkDv0jyU5q+6jxLFrutl80=;
        b=f98GVBtNnux9hG5UlnFs6c69tNbP/XpttFBDxCw6SBELO5BFpBWp0PLYi9t5+05rvs
         LaL91Ry6scN9Ro83Q9FqCETAd1lO5ZcLAVfctOPna/plCZ2rLYJu7fOnfETmbgcE1gU/
         kz0mRRrJj43tVVC5j3+X+TZe+VKFNQ2E5QSgxUrLjj0sVDVPfPzcPqezG/b8cKK0ygRI
         wj1KvLxS6h1K5VzrwcF7cuum2MnRP7KWLn8ux+g9shB/gqkMSf9GvZ/lfauMk/BHIgw5
         +ik6jPrTIFqwhlFkOnz5dKgTZSGeO7JkhRctPoFwVmwZlUFuzDE4gHb9YtX7wFo9mtn5
         HDWg==
X-Forwarded-Encrypted: i=1; AKwUvBxn8doJBfIiQeo4m/K2t9/PsG+2vzJfMvFTmyVO89sixPS6xW3WUXTgG/xyPLeAkCVwrfjkq+s=@vger.kernel.org
X-Gm-Message-State: AFuF++m6Lc4vAhBjE0Aa6xDYIVZ8Qw8nQ50njU5nnKQ0Nk9W+FPzuZzo
	5PvAwDJiIY0s29dvM75MiqBIbJ6wmAe9jU5iMFsg0pXlhksW7cSs40yn
X-Gm-Gg: AYBFou0GQZNuW32SclEsHl7OZZxbB7nFfWmig4077odE8xMgJTcBidACy57SKghxvjZ
	XiYKhDRiKjSsWZgqDdDsvI+zDyzjHBNo/KrgPBldy6e8PYHG6sMnHU5mMkGDGXOrNfWKXPe+LOI
	EmyK+RqKXIymYvvTjX/4g0WnGv2ynymU9i2H++/KOW6eABZUy2Ik0c4Mmmr1DXoOqZ6lF+zrahB
	VwEjRCppUXUctbh68aSXpUWlNMeAqhHfinprR8LkYWH/Gfn4yCdVRCv2PNFRG/hIMy961xkGkc/
	bx4gcyiUTH4sByqDdrk+wlnI2k9aNPAJ10lmfgr7zpqWlcBfArm9wFkm1zvp7CU+7laTc2lCOUY
	UHDplxeCWsHoR2t0c/UhnUY5KtiV0FjblQuhitrfKciP053Re/Q1KmV3bYBqmiuS/NkmsY8l7FL
	+X3f7p7fAzMlCg6vTpLHVlslZsPmhecoihbCyqP7keOj55XyxWMW7y0A==
X-Received: by 2002:a17:903:390d:b0:2ca:e19c:986 with SMTP id d9443c01a7336-2dd4bc3302bmr114612235ad.1.1789291018960;
        Sun, 13 Sep 2026 02:16:58 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ceb7720sm32169865ad.37.2026.09.13.02.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 02:16:58 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Andy Gross <andy.gross@ti.com>,
	Rob Clark <rob@ti.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/omap: dmm_tiler: fix invalid cleanup on probe failure
Date: Sun, 13 Sep 2026 17:16:44 +0800
Message-ID: <20260913091644.1510151-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_dmm_probe() uses omap_dmm_remove() to clean up all probe failures,
but the remove path assumes that the MMIO mapping and IRQ registration
have completed successfully.

If probe fails before the MMIO resource is mapped, omap_dmm_remove()
attempts to disable DMM interrupts through an uninitialized MMIO base,
which can result in an invalid memory access.

There is a similar issue with the IRQ. The IRQ number is stored in
omap_dmm before request_irq() is called, so a later probe failure can
make omap_dmm_remove() call free_irq() even though the IRQ was never
successfully requested.

Initialize the stored IRQ to -1 and keep the IRQ number local until
request_irq() succeeds. Only access the interrupt registers and free
the IRQ when it has been successfully registered. Also avoid unmapping
the MMIO region when it has not been mapped.

Propagate errors returned by platform_get_irq() while at it.

This issue was found by manual code inspection.

Fixes: 71e8831f6407 ("drm/omap: DMM/TILER support for OMAP4+ platform")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 65 ++++++++++++++++++------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index a2c702b831a7..169a158e5e9d 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -769,14 +769,14 @@ static void omap_dmm_remove(struct platform_device *dev)
 
 static int omap_dmm_probe(struct platform_device *dev)
 {
-	int ret = -EFAULT, i;
+	int ret, i;
 	struct tcm_area area = {0};
 	u32 hwinfo, pat_geom;
 	struct resource *mem;
 
 	omap_dmm = kzalloc_obj(*omap_dmm);
 	if (!omap_dmm)
-		goto fail;
+		return -ENOMEM;
 
 	/* initialize lists */
 	INIT_LIST_HEAD(&omap_dmm->alloc_head);
@@ -791,7 +791,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 		if (!match) {
 			dev_err(&dev->dev, "failed to find matching device node\n");
 			ret = -ENODEV;
-			goto fail;
+			goto err_free_dmm;
 		}
 
 		omap_dmm->plat_data = match->data;
@@ -801,7 +801,8 @@ static int omap_dmm_probe(struct platform_device *dev)
 	mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&dev->dev, "failed to get base address resource\n");
-		goto fail;
+		ret = -ENODEV;
+		goto err_free_dmm;
 	}
 
 	omap_dmm->phys_base = mem->start;
@@ -809,12 +810,15 @@ static int omap_dmm_probe(struct platform_device *dev)
 
 	if (!omap_dmm->base) {
 		dev_err(&dev->dev, "failed to get dmm base address\n");
-		goto fail;
+		ret = -ENOMEM;
+		goto err_free_dmm;
 	}
 
 	omap_dmm->irq = platform_get_irq(dev, 0);
-	if (omap_dmm->irq < 0)
-		goto fail;
+	if (omap_dmm->irq < 0) {
+		ret = omap_dmm->irq;
+		goto err_unmap;
+	}
 
 	omap_dmm->dev = &dev->dev;
 
@@ -864,13 +868,13 @@ static int omap_dmm_probe(struct platform_device *dev)
 	if (!omap_dmm->dummy_page) {
 		dev_err(&dev->dev, "could not allocate dummy page\n");
 		ret = -ENOMEM;
-		goto fail;
+		goto err_workaround;
 	}
 
 	/* set dma mask for device */
 	ret = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
 	if (ret)
-		goto fail;
+		goto err_free_dummy;
 
 	omap_dmm->dummy_pa = page_to_phys(omap_dmm->dummy_page);
 
@@ -881,7 +885,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 	if (!omap_dmm->refill_va) {
 		dev_err(&dev->dev, "could not allocate refill memory\n");
 		ret = -ENOMEM;
-		goto fail;
+		goto err_free_dummy;
 	}
 
 	/* alloc engines */
@@ -889,7 +893,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 					 omap_dmm->num_engines);
 	if (!omap_dmm->engines) {
 		ret = -ENOMEM;
-		goto fail;
+		goto err_free_refill;
 	}
 
 	for (i = 0; i < omap_dmm->num_engines; i++) {
@@ -907,7 +911,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 	omap_dmm->tcm = kzalloc_objs(*omap_dmm->tcm, omap_dmm->num_lut);
 	if (!omap_dmm->tcm) {
 		ret = -ENOMEM;
-		goto fail;
+		goto err_free_engines;
 	}
 
 	/* init containers */
@@ -921,7 +925,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 		if (!omap_dmm->tcm[i]) {
 			dev_err(&dev->dev, "failed to allocate container\n");
 			ret = -ENOMEM;
-			goto fail;
+			goto err_free_tcm;
 		}
 
 		omap_dmm->tcm[i]->lut_id = i;
@@ -958,7 +962,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 		dev_err(&dev->dev, "couldn't register IRQ %d, error %d\n",
 			omap_dmm->irq, ret);
 		omap_dmm->irq = -1;
-		goto fail;
+		goto err_free_tcm;
 	}
 
 	/* Enable all interrupts for each refill engine except
@@ -980,8 +984,37 @@ static int omap_dmm_probe(struct platform_device *dev)
 
 	return 0;
 
-fail:
-	omap_dmm_remove(dev);
+err_free_tcm:
+	for (i = 0; i < ARRAY_SIZE(containers); i++)
+		containers[i] = NULL;
+
+	for (i = 0; i < omap_dmm->num_lut; i++)
+		if (omap_dmm->tcm[i])
+			omap_dmm->tcm[i]->deinit(omap_dmm->tcm[i]);
+	kfree(omap_dmm->tcm);
+
+err_free_engines:
+	kfree(omap_dmm->engines);
+
+err_free_refill:
+	dma_free_wc(omap_dmm->dev,
+		    REFILL_BUFFER_SIZE * omap_dmm->num_engines,
+		    omap_dmm->refill_va, omap_dmm->refill_pa);
+
+err_free_dummy:
+	__free_page(omap_dmm->dummy_page);
+
+err_workaround:
+	if (omap_dmm->dmm_workaround)
+		dmm_workaround_uninit(omap_dmm);
+
+err_unmap:
+	iounmap(omap_dmm->base);
+
+err_free_dmm:
+	kfree(omap_dmm);
+	omap_dmm = NULL;
+
 	return ret;
 }
 
-- 
2.43.0

