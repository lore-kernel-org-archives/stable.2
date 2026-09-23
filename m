Received: from mail-vs2-f15.google.com (mail-vs2-f15.google.com [74.125.227.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D34F7CA0
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164737; cv=none; b=ZY8oQo3MQDRhzpIwPZMSmGZMpqFpeEDG0u2rNisWQ9V6uDtNfxoKAy1M/8jZk4FuPlb3zjMkvAOUTEVYUPo00ggJ6biUreyPzSaXq9I8mQRZkdA3fkb1zMQ+p0pgFrMerZ5NTBH25TUn2bGr7OONw5yPfqFxsm+tuqTqDzhPdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164737; c=relaxed/simple;
	bh=zgDWRJspStpa4jR47SeyYSy7tiYqlqolxBYKT8UwfIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouDyloyP3O7PcVgDGiybVRjU8hHX/fkKJqX3F7Hw1pbz9/rzYwVVXQUGwsOKxFP/VhCgh/hKlfpPzi0fl71LtS7jPHWklh8KEC9IUfuVbAi9UElx+eU5NkS34z4imkHBCfLkPg77MAuYKatYkkEJC5xkENXmaeL6JEdyWtPvdKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJKkDvQd; arc=none smtp.client-ip=74.125.227.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJKkDvQd"
Received: by mail-vs2-f15.google.com with SMTP id 71dfb90a1353d-5c981b0d59cso640803e0c.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790164727; x=1790769527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LP4UJ6rcNxj5vtQd0NWw+zniHfA0ViW+8Yb9WndmdNQ=;
        b=LJKkDvQdvS78tKVnF8LwOJIJKYm4Hy/lecFX7oewUmmlKzE81qLB6rzFV8qv9c50y/
         UwZlvuon4IuLL4rM8B0yfbgER2onV81uwU0753caZcl9kqPhxNUFnDkpQIw2M/wRxJiB
         TcPLDqjDq9eatYneP+92DWlPqHPkHoJeM0IGjmekWqV/AGB/+68tDxr1X158Rko1th4n
         GYBnRuuAIWnHw1vbVZfUUcdmT4ds370zsA8ML9qFNkBXqekhoDvF6QzoYB6knA+TnjPa
         64miMcqKivaJmxo1CJe7XFs7N/ZBvxJ13R1xsIBmEk0/nsFdnI/BE8JEUVrZgaqV/wdU
         G6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790164727; x=1790769527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LP4UJ6rcNxj5vtQd0NWw+zniHfA0ViW+8Yb9WndmdNQ=;
        b=QpwsGqzM4ZAHhp3ODTqvujLy3Ep8THkNul7H5cLS0A5reefQrtWi3xZn8sq8067q6H
         Erh31EV7ucQ+D1Ssn/sPoe0ljMbCdPB2Ed4X0lvgylkz2NquJVq0TYeFXVLIyk7zMDV8
         /ZBLPK0tngnC2NrvpD4nYUZvNtrud81+mvhrbfetd6n8DNv5u9jJ8wuzxupnvkGRs282
         5vjLJSYXqeOsQKCEEeQ9QL2oa8QcmwyTtArhPcdtKDxUpq46EOvEnIwyjMld0uDEWezo
         wnqnFbmqe/RbdpozgMaxlS1SGYrxrIvAhmXYeAmECJOGCsSdggEUJf8oGvS9EEFaWaT7
         Xk5Q==
X-Forwarded-Encrypted: i=1; AKwUvBw+BbZN1C5ubQWFThkJ0gzMb+U5SFFMmfA9Pkc75ocDsJosbtUqkQ5TtKIvSiA+7Nj2LtvLj8E=@vger.kernel.org
X-Gm-Message-State: AFuF++kIPP7h/KKoNiwAtdfHsMGgRmZ3b4meLGKUlJ83tQVDmnw5ejhs
	bjst5vrSae0vYQnCPWjO4qZrg+Yfj3C+HqzUsR2QFscfxEeRMmbOkOiHaKB0ZPaJ
X-Gm-Gg: AYBFou3StYaMuShN4gLiKHDxKT/rOpwJdWnuSaCLOgBegtNr42Spjun4HmApY+l4KBt
	VDRM0l+pCuEZ1xLiY92LDb8N0ABKKBTtyvKc3Q0LxFZlLBe6sZHNdnVV0yCHxyv+3cQ0ijQVMHs
	p7OpZJWxtDMAAQRXoaLZcxP0dXcGGuI4fLaDfQIbTIo1JzOPhB5ZJZDCqBx1qZz+2abvJvFqIIT
	vupPaPGjJFfvA6yMD4znWceuUzLKQsXkeGfYCNOHD8hdSfsg/EiCX0qTMfOJxy4rySgCV6iU8l0
	KB9e6bf2VsfLfN3/b+iIoF5gSg5dzZpZhDzVBobfzExreaIaAPvKii6WPsFT5rAJunbBgFRwbo3
	TfE76gvKDyjdKTjecLRMpTayMJDX0nw0hfRsw2KNISuwbapKzs5y2SdfXxYmij3FtqEwsfjycze
	xet0bNOF+Hm549OIl34H6w0lMU5xjcmcKpJd3ijR4+HhZs3mKkWMBYDiPUv6K/Uz9Jzlo5hlsp9
	KQVpau8/5UK
X-Received: by 2002:a05:6102:54a5:b0:7a7:19aa:8a85 with SMTP id ada2fe7eead31-7ac1d2d4823mr2262310137.32.1790164727264;
        Wed, 23 Sep 2026 04:58:47 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5674f44sm3099961137.3.2026.09.23.04.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:58:46 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] drm/vmwgfx: return an error when a shared GB surface has no backup buffer
Date: Wed, 23 Sep 2026 08:58:39 -0300
Message-ID: <20260923115839.3363885-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmw_gb_surface_reference_internal() rejects a surface that has no backup
buffer by logging an error and jumping to out_bad_resource, but it never
sets ret on that path. ret is still 0 from the earlier successful
vmw_surface_handle_reference(), so the ioctl returns success while
leaving the reply structure uninitialised. drm_ioctl() then copies the
72-byte reply back to user space; on a CONFIG_INIT_STACK_NONE build that
is an information leak of stale stack contents, and on every build user
space is handed a "successful" reply that was never produced.
DRM_VMW_GB_SURFACE_REF is DRM_RENDER_ALLOW, so an unprivileged local
user can reach it.

Set ret to -EINVAL and, on the error paths, drop the reference that
vmw_surface_handle_reference() took; once the ioctl fails user space no
longer releases it via DRM_VMW_UNREF_SURFACE. The unref is guarded by
ret so the shared success fall-through keeps the reference the caller
still owns, and it also plugs the same leak on the drm_gem_handle_create()
failure path.

Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create and reference")
Cc: stable@vger.kernel.org
Suggested-by: Zack Rusin <zack.rusin@broadcom.com>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2:
 - Shortened the commit message (Zack Rusin).
 - Also drop the reference taken by vmw_surface_handle_reference() on the
   error paths; with the ioctl now returning an error, user space no
   longer releases it via DRM_VMW_UNREF_SURFACE (Zack Rusin). This also
   plugs the same pre-existing leak on the drm_gem_handle_create() path.

v1: https://lore.kernel.org/all/20260808231002.67559-1-qwe.aldo@gmail.com/

 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741e..164886a3e6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1720,6 +1720,7 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	srf = &user_srf->srf;
 	if (!srf->res.guest_memory_bo) {
 		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
+		ret = -EINVAL;
 		goto out_bad_resource;
 	}
 	metadata = &srf->metadata;
@@ -1758,6 +1759,9 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	rep->creq.must_be_zero = 0;
 
 out_bad_resource:
+	if (ret)
+		ttm_ref_object_base_unref(vmw_fpriv(file_priv)->tfile,
+					  base->handle);
 	ttm_base_object_unref(&base);
 
 	return ret;
-- 
2.43.0

