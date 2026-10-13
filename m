Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED40051CF48
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909576; cv=none; b=BlqsrTqN6mF1mqthe+36idSMsF/XW4L8kBZV0j2Fa1rtTO0RagcdprFx/hJ3qOrHUNaPIjwZi3CT4/KUOMLhHM/L5TMFNdWbdHqF3O4twg9PAuy1XAyagzhwAKpGN6C9cS4oKn0YmjZoiWCYZVFESJB+qG9NsEeaCD18f9mexHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909576; c=relaxed/simple;
	bh=KaVi1mH5KqVnoXdZfyCZyx7KdHR8r7UM+IH9h/TVCy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8lJWbkbHly518Smj4wzva4j+r2g3QZFNkQWQUpYoE7Qlg1IOL97s1gWS9KoL5oa8GFTmI1N6+RZcZzs9/72/X39Ba9zm1b3yRe583GcjsDW1ADkHNvEDaZdp5DZ/9+bkdNSgiD9JTY7QUmTcnuSGMpC46AQvLRjlucfnTPCVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvFqI7Kn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvFqI7Kn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9D31F00899;
	Tue, 13 Oct 2026 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909574;
	bh=ewTRJ/soX09J/jxb0PR8onrgIltUIfRp0NzK5Cya5Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EvFqI7Kns9Sjt57lJFkTHqsKOYis/PAEZZ9Knm6C68rAv54LiucDvnWstEvujzUoH
	 BBT0RZfO+4vH8scLx60vU4bWr2d3paN9nEQKA0EMpAvh1STvsNXzMMuqn5xsc4lu35
	 9ob8tgMjarPGrELlAZirkFky6Qfc0SZbl/ra3ZJ25KgoRU1y+Yn9JtCuMniJvLwOkI
	 rnmRRhvYFcBDhZNvUNee8G1zx37KuIndi8PK+vPc6H07RYtSiwC+OEH0SWOhbx7bWe
	 fy7Gq8Ob7exSVsHFuUtS3993jVTgZO75Uv+JBO2VjG9W2CAyy7jOATfDreSUGd6WLy
	 A4KlWgL6oXiLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] drm/vc4: Use video aperture helpers
Date: Tue, 13 Oct 2026 12:39:30 -0400
Message-ID: <20261013163917.466761-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013163917.466761-1-sashal@kernel.org>
References: <2026101258-operator-prior-e880@gregkh>
 <20261013163917.466761-1-sashal@kernel.org>
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
index c133e96b8aca2..dd6bd490d4da9 100644
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
@@ -352,7 +352,7 @@ static int vc4_drm_bind(struct device *dev)
 		}
 	}
 
-	ret = drm_aperture_remove_framebuffers(driver);
+	ret = aperture_remove_all_conflicting_devices(driver->name);
 	if (ret)
 		goto err;
 
-- 
2.53.0

