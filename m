Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49729B77E
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792251345; cv=none; b=c150/beOW/z4gdjA9VV28O7U1meuJQQ1Q0/59TZ0a3pPIdqOpdDOU5O9TT5HecHEGEhb1gLTJjWEs9H0ZUR4rXU/riJ0cR6tLoGZPfdqMFcihKAGo3sefc6j2xGAmnvpV/wucY4QSS1QAxsEtzChwYhP4IaMtIq9pm2MS5tgDPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792251345; c=relaxed/simple;
	bh=k3HCyPTxpXGvpKq4TRkpfHcOBtMlzvsEWWtmUiLQiuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDSS8A9zYX0j8ZXYVlM/fOr+TyzuH29tdZCyaCfNKNcFfj4Bi+AEOa57R5dCEJZpNGj3imqCJBkw/w8Aa1CLLIgfABtUkkeaFO3u5mWaPr07X6KWyn9yIZp8hjJBxi5sRMmkcGSWjr9pEN3X9RA6K6WTRsGErp22vqn8r+tMsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzlH6ECx; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzlH6ECx"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so320842a12.0
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792251343; x=1792856143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cSCIoQiIuzOVCfYEbcmwZdLYkQEpSik/mWoNdRkPnwc=;
        b=OzlH6ECxqw9eLlizxl1He1AgStAeWoFfEb4YrhT61So534iqlytu36mbTOoabeLwai
         7IHHvn4A14qHrOynJOsWwW2Yj+j3vzfe1nfuDuQtHBBNAeL9Xgtrxd79cb5Eg6qyxo78
         nHVOlCVGgnHswL/3AcDdChkupt4pKC8JWhFYckPkmn8fopv7my9UUxVLvPlcse53FU5z
         9UQarbxQEBI1W9BSjaPGRLFkfI6G6qkF7TFnhqPXNffb5HUbf+eh8mzFLlK+PB52m6G9
         +05YVCWgrUKGH0AExqfkLuqbcayMA+gi6gLZwdQ9RTd+GwVQH/J9ZgR0AhIAyu8eenVU
         b6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792251343; x=1792856143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cSCIoQiIuzOVCfYEbcmwZdLYkQEpSik/mWoNdRkPnwc=;
        b=Zuq8gTrx9nJEaPx1P/70ICEg+UCBOVByTd9ixLsI7UgIql/SUCbt5LP+gFSvBcmCQP
         KN7bL6A4NixE4QypjfPxDi5hSD6vStT3Y5IOEkBf+J/5KzK3PIKMaymXGh8GK3q3K6An
         qOJchYa0hejTghzLt9zO0orgz45h3HrsvTIkA46QVu2V+rMuusEuoQhkuQQN9jiPODWI
         /ezYllcBOEP0qrqyto/oRYvftvetzPvd3N5kfNMPj/mOksfa/7sT1ZdO/ufX1tAssgFK
         K5iNRX9S/wKqgJBNDzSJaNMeuKnYOQ/ngXSIIFtEZEAG08YK4ZFqHtPy6RgjPbk4R0J6
         qMdA==
X-Forwarded-Encrypted: i=1; AKwUvBw5Xfuu1C3IKag2WlkswfsXDx+jcBDndg7QSXdeJrcSPffWBQh5WX5vK6q6qR+QFM5s9a+ummc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPrK6tXF2I1CB317jyp05QjtktsrgFBF+DrMP7uR5xlFcgQT3d
	vlHrDsuFi+vJuQSIdZxSN2mPX6VRiO4Q0cr9oUsgUTj/juy5xq/uVDcS
X-Gm-Gg: AYBFou0sz+BaqFiJVGbeycY/As5h1ZlYNI/DHIwEvReBPvNGKZt5bedg8JPSgz9IdqS
	bkoyo21Dzz/W1EQBOyE8b0rQd/JZL3KMdVPYjI11ebeA6lQFZ0MkNUF81FK/+GL2f4X/i6I9mOG
	faz75NOkqWhexymqKVI8+9QLpvC644QYoxoyuBcB3D6qJLeucksL6KGDh/X2x9ZpMa8IT8//tgA
	Yg4ivP7gn3emyRDI8ggNdaun0+/oKCylLOgFLBPjbkovIubSoIxEQXJPKc0rk8fbC9+WDm5sWOM
	jAuagKDtU8gsN0wHKymCgmDjbzDQisPJrXNkA0vvaXaCdfB9nt2kjuBjFaF4K20XcQXunxTp5tP
	mrtJ6bif3CKS8iMHBQi8DkZCiYQeeGP4/2N0J1autwmLC2eF/5KXDWl0AkQqeraWxrQvURyZ9V5
	D8KwwamtT/VEKIC2yGBtFpnRSHXesNrEnLEfPpVzwOJZwZHwZy60IwJnu/XpS3UCxq+U0Q
X-Received: by 2002:a17:90b:590c:b0:3ab:1b19:78f0 with SMTP id 98e67ed59e1d1-3acef2b52e6mr3075121a91.41.1792251343394;
        Sat, 17 Oct 2026 08:35:43 -0700 (PDT)
Received: from hachimi ([101.5.168.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm15330221a91.9.2026.10.17.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:35:42 -0700 (PDT)
From: Lanfeng Wei <xlfylawarthur@gmail.com>
To: Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-hyperv@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Lanfeng Wei <xlfylawarthur@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
Date: Sat, 17 Oct 2026 23:34:30 +0800
Message-ID: <20261017153524.8870-1-xlfylawarthur@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A performance regression has been observed on Hyper-V causing serious
frame rate drops since commit 52e6b1988334 ("drm/hypervdrm: Use vblank
timer").

The regression occurs when using Xorg with a software rendered cursor.
The offending commit uses the DRM vblank hrtimer to pace atomic update
completion events, making each event wait for the next simulated vblank.
However, cursor damage invoked by mouse movement is unconstrained by
screen refresh rate, and therefore consumes most of Xorg's update
opportunities, starving normal graphical updates, resulting in
plummeting frame rate.

Hyper-V virtual display framebuffer is able to accept multiple writes in
one update window, so the commit broke this expected behavior.

The regression is also reported by other users:

Link: https://www.mail-archive.com/ubuntu-bugs@lists.ubuntu.com/msg6302857.html

Add a read-only module parameter hyperv_drm.vblank_timer, which is
enabled by default. Disabling it prevents the timer's enable callback
from starting the timer. The vblank framework and the existing atomic
callbacks remain registered. When disabled, the first
drm_crtc_vblank_get() fails through the callback, so the existing helper
sends the atomic event immediately and skips the vblank wait, matching
the behavior before the timer was introduced.

This provides an opt-out for affected virtual display users.

Benchmark results:

Workload: Inject mouse movement at 125 Hz against a flashing
animation running at 60 Hz, matching the screen refresh rate, for 4
seconds.

Tested versions: 6.18 (the last major version before the offending
commit), version 6.19 (the first major version containing that commit),
version 7.1.8 (on which the patch is based), and its patched version.

Version  Anim. Hz            Mouse Hz         Max client-request gap
====================================================================
6.18     59.66-60.00        122.00-123.33     17.0 ms
6.19     0-0.162            59.73-59.86       7.53 s
7.1.8    0.133-0.162        59.83-59.86       6.16 s
Patched  59.75-60.00        122.75-124.50     14.0 ms

The patch restores both animation and mouse update rates, and reduces
the maximum client-request gap from seconds to milliseconds.

Fixes: 52e6b1988334 ("drm/hypervdrm: Use vblank timer")
Cc: stable@vger.kernel.org
Signed-off-by: Lanfeng Wei <xlfylawarthur@gmail.com>
---
The parameter defaults to enabled to preserve the current kernel
behavior. I do not know the full set of users who rely on the vblank
timer, so changing the default could introduce a different regression.
Affected users can set hyperv_drm.vblank_timer=0.

If the maintainers prefer the parameter to default to disabled, or if
there is a better way to detect the affected configuration
automatically, I'm happy to send a v2.
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 23 ++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index d48ca6c23..527385748 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/hyperv.h>
+#include <linux/moduleparam.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_crtc_helper.h>
@@ -25,6 +26,19 @@
 
 #include "hyperv_drm.h"
 
+static bool vblank_timer = true;
+module_param(vblank_timer, bool, 0444);
+MODULE_PARM_DESC(vblank_timer,
+		 "Enable the Hyper-V DRM vblank timer (default: true)");
+
+static int hyperv_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	if (!vblank_timer)
+		return -EOPNOTSUPP;
+
+	return drm_crtc_vblank_helper_enable_vblank_timer(crtc);
+}
+
 static int hyperv_blit_to_vram_rect(struct drm_framebuffer *fb,
 				    const struct iosys_map *vmap,
 				    struct drm_rect *rect)
@@ -132,7 +146,14 @@ static const struct drm_crtc_funcs hyperv_crtc_funcs = {
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
-	DRM_CRTC_VBLANK_TIMER_FUNCS,
+	/*
+	 * expanded DRM_CRTC_VBLANK_TIMER_FUNCS to override
+	 * enable_vblank with hyperv_crtc_enable_vblank
+	 */
+	.enable_vblank = hyperv_crtc_enable_vblank,
+	.disable_vblank = drm_crtc_vblank_helper_disable_vblank_timer,
+	.get_vblank_timestamp =
+		drm_crtc_vblank_helper_get_vblank_timestamp_from_timer,
 };
 
 static int hyperv_plane_atomic_check(struct drm_plane *plane,
-- 
2.55.0

