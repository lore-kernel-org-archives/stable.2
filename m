Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C43E8333;
	Thu, 25 Jun 2026 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401173; cv=none; b=QhhAq83rrtY6TN3EMRTI0ZYianOObDXy3KmZy53CAYnnOGeZ2Dt7x+UQoOZv4LZO+N0aHbDInkoRjHX+avIFJRSE1R0MH+a9EmFkJfYQ0OxaLWouiZZLKuXK7uZtKRI9Glv3YXsLCJ8VKkBX1ZUZjt5Vi2DSeTTiU19GcgbFm4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401173; c=relaxed/simple;
	bh=OHrMlpFezn3Di4/6XBky7FE4t9zdIjHNlmo4y6b61yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzbeEB135Q/DN+Er/fchGAmpDfCalJj/ZkQy6Kk6JxFJi68Ydlwi2zb3PU+SzS/A/zyK/9rDxfSjBIet4JcYxJ1cGejfYlsKobkzlOi65tnUSjzxGM0AGbQ9q9cRPlp5PYhCGfMSXYy0o5EUCzLqty7IWzEQynw3fHtjer0oyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=QXcT2dL/; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="QXcT2dL/"
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id DB5BD807E6;
	Thu, 25 Jun 2026 18:18:30 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:221f:0:640:b03f:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 629CDC00F6;
	Thu, 25 Jun 2026 18:18:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (smtp) with ESMTPSA id DIbMBTIdH0U0-mdd7Epgp;
	Thu, 25 Jun 2026 18:18:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1782400702; bh=8NQg9mqw8zBbJMcwecVSvlZHJ1JE4BFnWrwrF2BbF7A=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=QXcT2dL/k8M5RbOhYNhFlUOU5jtWfYXUCyN5lxYd3RQc2Ih1VuzyCV144MsLJ+eHs
	 qjLoDS/5rH18f4VfKFmj2Qgdo4N7a3yFPn/PwLx1tRFzCq7Zc9H661N+X6DPS4TpPH
	 1caTrKIfigb01wfGFnpOzrSoAMWSOQbL7WH5OW4M=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alex.hung@amd.com,
	mwen@igalia.com,
	tzimmermann@suse.de,
	Alvin.Lee2@amd.com,
	ray.wu@amd.com,
	dmitry.baryshkov@oss.qualcomm.com,
	chaitanya.kumar.borah@intel.com,
	pierre-eric.pelloux-prayer@amd.com,
	HaoPing.Liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] drm/amd/display: Fix dangling pointer in plane state reset on allocation failure
Date: Thu, 25 Jun 2026 18:17:12 +0300
Message-ID: <20260625151717.27757-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In amdgpu_dm_plane_drm_plane_reset(), the old plane state is freed
before allocating a new one. If kzalloc_obj() fails, the function
returns without updating plane->state, leaving a dangling pointer
to already freed memory.

Fix this by allocating the new state first. If allocation fails,
free the old state (if present) and set plane->state to NULL to
prevent any dangling references.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index e957657b06c7..0d81cef5fdaa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1490,20 +1490,30 @@ static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 {
 	struct dm_plane_state *amdgpu_state = NULL;
 
-	if (plane->state)
-		plane->funcs->atomic_destroy_state(plane, plane->state);
-
 	amdgpu_state = kzalloc_obj(*amdgpu_state);
-	WARN_ON(amdgpu_state == NULL);
 
 	if (!amdgpu_state)
-		return;
+		goto err_alloc;
+
+	/* Old state can now be safely destroyed. The new state is already allocated and will be assigned */
+	if (plane->state)
+		plane->funcs->atomic_destroy_state(plane, plane->state);
 
 	__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
 	amdgpu_state->degamma_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 	amdgpu_state->hdr_mult = AMDGPU_HDR_MULT_DEFAULT;
 	amdgpu_state->shaper_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 	amdgpu_state->blend_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
+
+	return;
+
+err_alloc:
+	/* Allocation failed: free old state (if present) and set plane->state to NULL */
+	if (plane->state) {
+		plane->funcs->atomic_destroy_state(plane, plane->state);
+		plane->state = NULL;
+	}
+	WARN_ON(amdgpu_state == NULL);
 }
 
 static struct drm_plane_state *amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
-- 
2.43.0

