Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42183B2AA
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191289; cv=none; b=McfbZPGDzRYI3fr3tpJ8QzYVufy3i7Gq5brP8mkM9+4J5n6J8855PZjYEhYx1H6OVjvBowusMFJ/NXdTKYAyEa9OyUXKFDEXi3ssITDZuO0EdH7vS5LJhE1WVsu7QqwIXmhW0Gp7hzM6VTu9ap67b7r1cDT7Dh6wj6FAqm16eJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191289; c=relaxed/simple;
	bh=iE5PAbMMog2SxG6r0T33gdxPgeSe49yLUjzn1kRovLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CS4nr09oCFEAQe7nWWpLGY8e9qyW/WoZo2xtW53Ch8ijfCyzZc/OYwyz6GF9W+Vaghr/RABJgOHiBIELXrgtXh9e6iyxCh8IVCaeFH1K3YXBJ0GCwLu1mJ4VXsuAXLIgok8MHRkmXzzIs41Bx85WB73s9+zxurog34gONvb6Tnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSQCkVQy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSQCkVQy"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cedda2ce6fso3880075ad.1
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786191287; x=1786796087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fR3OipClJn+6ckgYC/3aH7kLb8zueZhnpSjG/5qdPqk=;
        b=RSQCkVQyVCNs0xzzva2u8P0iUco0kN8U6rDCIO+tUucYlTX92ybr9/ciEyp5PbAFqp
         42Lb85+GE9fau9z+6BpR8jy8eRGnQxI26yiN7iM0Nhiz6+Y2S09TBtLvvjY8OabpLxQJ
         MIBffNrtW/JA2qx8QvrDKqaKZCbzCVbSQFigyqX5IytpFO+giub5JtowHO1e6vT9WZXf
         3nL3LrvJiLPdnZPZzZtBE361BV7OFXmxvA9tQj0leIM+taOZMQsoYY2jHwTD0IjR17PJ
         tCCiNYkd1aDCqirG9lvTf8L7Ip3k2MnwUOhlthTbA4ed0Iq1NVN55MZD7rQNU7xR4P47
         M6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786191287; x=1786796087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fR3OipClJn+6ckgYC/3aH7kLb8zueZhnpSjG/5qdPqk=;
        b=kOzzwl/4ZK49Le5GijDU/AvfVwpX5XaUGYG2Sf2/fYj0DVgYZtaYV4FQ5rXajX32Zw
         HP6AoyzWoiS3ZZRc3lrAzlMfN2cMdWlTjuFE9vy/Rux+yQp6T91lBz8Z9TF8LT1VXKQD
         jiQgDHnCs27i6oYFZzypjW8ZJov17TaS349Qer3yct+0g4W6NucZSIcBMyGed3QXYCXD
         c2TSOu+xukLrd6RH51PuQNFsAC9wEg585svaY7J+bwbbSoFWuGUeKHEs4QGbXxeA8BLd
         QU0ZZG3My2xAoPCOsjbEJVXPsVdlmBCvpDD/MKT0Pyt9+5Qh1G7aVjtlMdaSigCKgOIv
         xw+g==
X-Forwarded-Encrypted: i=1; AHgh+RrYajmZjHoVacSe/rzMyfOm682FOy0pl6Qk5DTQEFecnCPdOZZTlayF0SR6l0ahthQ2E7oQT3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPusJFCiA99jD26rtf4w0h7+aoyzkQK7IGHWOzR+oyL9c5KSJ
	DmtWaa6/MaybKvUK7tQ9A0WB7Xx8URp++tqLdQ4tMCgPn3BmyihBVoZ1
X-Gm-Gg: AR+sD11WKDj51xLvzsftVGyihgCSYbEDrHSMwSF9bMPwNYEh0NMCMMhCv9an3XeSOWr
	PURzwVl0VPZnvhryJvBNLkSlaT0rDpZjUPgdGRLdVX3ivXIRDiylF6rhIsn/Jqvt5kVY9Z+PFB6
	/UvGQykrZCyu4OyEQzhYBzX76StHcYjLQphstg+axxhPKw0QVRE/drMGHtHldigFI6FJhViSBEi
	mQ6dRojpMiRnyrfZV4mUVg8JikSDCCV2DCYy43hpGEm/H8btyrf8WU3KaRpcIsMTmPhu1BP1umt
	xbtzeIfrmCkl/RYFrzRlLHxfEXBWHydghYnC42//osht0M1KtabSFWXCPiFxbFBf9S1Ul1x2TLu
	POunkN+JTfHAjt3FOWR6nyxiEwstd4dE9RgcQ7NLuVl1w1FvPk7h7R4Ha0G7ozVT/+SI8F+i5PX
	7x3IhhWUQcl0TAG0cWVruHvE9Mr9a4bgPumfG3P7AGD855wQBYh0DS3WpO1A==
X-Received: by 2002:a17:902:e945:b0:2ca:d151:383a with SMTP id d9443c01a7336-2d0ca98f97dmr360786285ad.20.1786191287049;
        Sat, 08 Aug 2026 05:14:47 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccdb26bsm18584345ad.22.2026.08.08.05.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 05:14:46 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/etnaviv: fix runtime PM cleanup during teardown
Date: Sat,  8 Aug 2026 20:14:34 +0800
Message-ID: <20260808121434.2815841-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

etnaviv_gpu_platform_probe() calls pm_runtime_use_autosuspend() and
enables runtime PM before registering the component. If component_add()
fails, the probe path returns without undoing the autosuspend setting
or disabling runtime PM. The remove path also disables runtime PM
without calling the matching pm_runtime_dont_use_autosuspend().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Undo the autosuspend setting on both probe failure and device removal,
and disable runtime PM on the component registration failure path.

This issue was found by manual code inspection.

Fixes: a8c21a5451d8 ("drm/etnaviv: add initial etnaviv DRM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index c314b3cb5e70..7acf2ed651f3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1964,6 +1964,8 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	err = component_add(dev, &gpu_ops);
 	if (err < 0) {
 		dev_err(dev, "failed to register component: %d\n", err);
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_disable(dev);
 		return err;
 	}
 
@@ -1975,6 +1977,7 @@ static void etnaviv_gpu_platform_remove(struct platform_device *pdev)
 	struct etnaviv_gpu *gpu = dev_get_drvdata(&pdev->dev);
 
 	component_del(&pdev->dev, &gpu_ops);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	mutex_destroy(&gpu->lock);
-- 
2.43.0

