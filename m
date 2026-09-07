Received: from mail.scd31.com (mail.scd31.com [205.209.125.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A694F1ACEDE;
	Mon,  7 Sep 2026 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.209.125.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823077; cv=none; b=itvdEwhoMPJZaKh3xW9uSsFCxnmnmDm4JmbQPazyDBDWBxSbxidBpj/7Bo5JP0RMlxVVw38A3MM2Zgjsr3c8lAycB2PyAzv8qId+QgaWY/BdqfT99iM/JQGFDXQH3KBJcQSUF/F61+3Mj9CkPtNPvlSWYsouTBNYacKWERB7PsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823077; c=relaxed/simple;
	bh=lV9kR7Jsg6perTbU8lLHGoXar0ayjsO2lhp5NE1n5WI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NiOl/LSDMngVFm0nCl7MPYbAvinePlHnN6iz5QkihTGkypOpJirt2AkNzMUB2n8suH0ouCN+rFj3hGxKvZe1o+VuKc+QEiFnfLgrXvHInswqSV9I6KzOIStG6XgG9irHOJaEWElqp2NypQ2EbOO4zferyxVGzy/orksxXVFzm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scd31.com; spf=pass smtp.mailfrom=scd31.com; dkim=pass (2048-bit key) header.d=scd31.com header.i=@scd31.com header.b=geiiv1CT; arc=none smtp.client-ip=205.209.125.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scd31.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scd31.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scd31.com header.i=@scd31.com header.b="geiiv1CT"
From: Sophie D <patches@scd31.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scd31.com; s=mail;
	t=1788822555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T06vifKHL7yEbLNrVUuV8RvhfyCc7zgQ6Avu87PwioM=;
	b=geiiv1CT1hbFVfMh4FolpsJKS87PssPspxI7VECeE38dFAMkhznAt5Vg9UnG0EdmokvLN0
	BTF/a6ySFp2nvlYw2lK3KJZHqoQEU2ABdci2cMbOhkQYpjjuOuqeibaDSYw3RWSUksNOjC
	9IOGHLDb5jiQOKArfdHpgVX+mK/U0+NJ+dAxOLejuakZNWVLut0UsjHEFKGj8WHDR/8m9o
	lnqb+vxyx6wZaePWwm5lCy7LBpMSEjZE7Q2q50S3yzDBZPxM/FVv7t5X33V8VlWJBn2chP
	wOjmeZ6GMhchhQUezzz9ouD7CiANPXl1fhHT9GVq5fEFMYMOXRS0k3+p+h7bcw==
To: rubenru09@aol.com
Cc: tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sophie D <patches@scd31.com>
Subject: [PATCH] drm/gud: Merge damage clips in full update mode
Date: Mon,  7 Sep 2026 19:08:49 -0400
Message-ID: <20260907230849.31032-1-patches@scd31.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running in full update mode, previously small updates (such as
moving the mouse across the screen) would cause many full frames to be
generated. This would bog down the bus and lower the effective framerate
significantly - I was seeing a drop from 60 FPS to 2 FPS.

This patch fixes the bug by merging damage clips together.

Fixes: 73cfd166e045 ("drm/gud: Replace simple display pipe with DRM atomic helpers")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Sophie D <patches@scd31.com>
---
 drivers/gpu/drm/gud/gud_pipe.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 5ef887d84..20418bf81 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -647,9 +647,14 @@ void gud_plane_atomic_update(struct drm_plane *plane,
 	if (ret)
 		goto out;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
-	drm_atomic_for_each_plane_damage(&iter, &damage)
-		gud_fb_handle_damage(gdrm, fb, &shadow_plane_state->data[0], &damage);
+	if (gdrm->flags & GUD_DISPLAY_FLAG_FULL_UPDATE) {
+		if (drm_atomic_helper_damage_merged(old_state, new_state, &damage))
+			gud_fb_handle_damage(gdrm, fb, &shadow_plane_state->data[0], &damage);
+	} else {
+		drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
+		drm_atomic_for_each_plane_damage(&iter, &damage)
+			gud_fb_handle_damage(gdrm, fb, &shadow_plane_state->data[0], &damage);
+	}
 
 	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
 
-- 
2.55.0

