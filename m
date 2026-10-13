Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869151A14C
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908503; cv=none; b=itXpj8sjExYEqgvJF4avcVqHtyAx/B14EhH1VGlaqhx6wpbj1fIaRUXKa1WmJJW+tPTaANkBH0VykwwUv81BZTBsGWjh2V+kmJxLlxb6agSSJ5K8aox2Sp8ozX9mVYU5DPVaJ3WPVwutxMrUKla76EqK/fWRTpNVUqtPIxADO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908503; c=relaxed/simple;
	bh=b8B8Ezbd8RPMMvx7rJqCx1+I/rpKoaw4CAWmAR4QTCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhoIeWE4pF2VrWWTEMs5P/hbUuBXgXtHsukwJmb3lGEch3WlDyI1jNCuoxzU8NwsvJLMkMxeBZW+gCEADTPXYAjNylmAtuzNU1/nWceU0aDYki3taRkS6Fnzr7Xzxjdb9U6KjgI+EbWoviVjRbZ4TjRU1qYvjZS5rA3pM9boSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdOSv47q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdOSv47q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD471F000FF;
	Tue, 13 Oct 2026 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908501;
	bh=rT45dG+VPnWiybSqaZbmOfAVxTKtjQZUqUy+uZqnZyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RdOSv47qE/dR3l57ngAzHAALucMa5XYrbXCEgD0Kl35mSLV9XA0mJc8vCJdwwtqM8
	 azKNgpvkdgnXT3Ab3nx95PWxp6mP/H2OIizu/ncJ+5GTW3X6VGMI9dFyAqMInNhsPM
	 +yhAC7xp8lQBVI54qc8qh9T8bR63Kiqj3DO1/kkk73hOQVRxbxF4QlOg0m7yz77sHL
	 Tf7UUxW3ZOxAkM5227RGLXYRf6xaCsNrvmWkhqEAuN3X1KgoYCMcsEB1sVFKPXQOFP
	 Mi4HJ9AgMVraQsU3aIdMNrKNzHYWgNjbEGdzaWaJwz+fWHnc+BwAlKFWpM9kHHfffz
	 P0kei/f45ARxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/vc4: Use video aperture helpers
Date: Tue, 13 Oct 2026 12:21:38 -0400
Message-ID: <20261013162126.419852-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101258-emporium-attempt-639f@gregkh>
References: <2026101258-emporium-attempt-639f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 7e89e4365fd36ca006670788ec2c1527bfd0c61c ]

DRM's aperture functions have long been implemented as helpers
under drivers/video/ for use with fbdev. Avoid the DRM wrappers by
calling the video functions directly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240930130921.689876-25-tzimmermann@suse.de
Stable-dep-of: b816da5d5df1 ("drm/vc4: Fix firmware reference leak in vc4_drm_bind()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 8c104ace3dc6e..802e716f7dc83 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -20,6 +20,7 @@
  * driver.
  */
 
+#include <linux/aperture.h>
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/device.h>
@@ -30,7 +31,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
-#include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
@@ -356,7 +356,7 @@ static int vc4_drm_bind(struct device *dev)
 		}
 	}
 
-	ret = drm_aperture_remove_framebuffers(driver);
+	ret = aperture_remove_all_conflicting_devices(driver->name);
 	if (ret)
 		goto err;
 
-- 
2.53.0

