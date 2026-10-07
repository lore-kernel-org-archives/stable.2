Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42841685C
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408085; cv=none; b=YLiONfdQxOXVU56qq7g+OmFjbq7azgWf9g0BzHbNRolWDTRT3tQ9Kb6rR52sM/5gooq5VsLUnj/7klymer3kWqFunaShS1kHkozmsQ3E6HerS+7flIRkZBhnKaDL0NdlcLYbSlgJZfzMtnbFxZKvNp/f8XU5AUBjI6ltm6jNx/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408085; c=relaxed/simple;
	bh=W2uuaqjBoZK0+2XaHmqucLpzZaL+DbyyIq9cuWIAsR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+C0UynK2p4ZpXQpTpOanfw5rm8dGuenfMC3tmX/6Ba6Ilyk3peE52PsPISccCy+HnW48IsmmW00LOx61EA3gKJI7WrkzofRfYZc618CzZ9H3QQ5h9P4Cs7ab8Y2Ur1WJnKmjXS5Zo4dOF/1KUZABVcid+gyhnuJdORnx9uUajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNmHoc4S; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNmHoc4S"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ce65316337so3449815e0c.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791408080; x=1792012880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e14mQQiltcvPeO/AMh2B9KgoOUXPqFLUs2pJsfGY66Q=;
        b=SNmHoc4SKLW6ClGhjUyyOx5mhmWephib3Ep0eq51N2MFQtOJyC9azhzC+rhNG3VPWB
         /f6UpLAgMfFC8KAId74MVtNRZ944SXNgT+1tRVCrMqpF64MN13lA1zxVYBaqMs/TWA01
         B8woXJn7uqfDIxnyXLTEsePzTvUdzuMso0LhITECm9oRd7kZxvkKtkZJjzF+iy6nAyyB
         dRfkjfgKcz4zI6oqNRBIZLtk9Mw6YblPDkRt5VO6vlPFRfW+J0XlnjieMwFJhc6lyOSm
         W5KkhG6KfGyXOE/6mB78pm1DHtYZACQb4LoFCQX3oHyTHyid5muo/5sSqAHC7e31LFz0
         rYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791408080; x=1792012880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e14mQQiltcvPeO/AMh2B9KgoOUXPqFLUs2pJsfGY66Q=;
        b=DXAO1TnokmAWZZ7qXldi/1oqfTxHqe0xTG7ZhAzsxf+hEaBNolJhzxXOntBFKSMXrQ
         S3BgDODAqwLXpfDenf/8uztAt/5bmjPMN+SGOJl30WQDji9hvbtsauyLinLFYdnYk4eP
         7KhKB8f5vKcM7lKtQhUkCkeHeSvffs24zDexMsfMJdMNHVrDGtvRckLR7yXE02CiBIhe
         yyl7UMAU2Mf1l4+Y0i0zEziqmPQ7bvTV2bFBX0I1zw1MpYDWi5hUJxl2nP17SMZDV6MB
         8DtV2LsoMeQCdj2G/6tv2O0qUEZzra+0v+xJl8piKvimNLvUw6TgwiW8/CIGmO6LucaX
         SpSg==
X-Forwarded-Encrypted: i=1; AKwUvByDmG+TvzZgNmdzawyOK9LPEnNL4wYZFxr5GlWOEyBUGNx1YO5LKQL3EHTHLN3w0UMPhkwQjf0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLZCRzzfmg7/iZ5RwILDabxNHLBWE6A/6VjLBtN81EQH4dyUxG
	5LPhJqJqCya+WneKngD2/FAT/KMUl27Mxc66e2+PV/4+9X5QaEmxFHGn
X-Gm-Gg: AYBFou1ORH5y/A7SWFmTs1TMqquhnHOooOsw0ytBugYkbn+7Oe7IOQSruUXpR9D+4zr
	nuiEV2JKYKbkJCuHnlOrrGP2DS+YYbbZwsEG+IoeQ0cG64xkD4vKtEOiGyj/s1b8qDMne0gCjQr
	IP21gVpjnU9omvYyWv4aM/aj72Sf/laRwxJA8yrul06n+owrWQAM/wY2W0/5e6vjkYUNpQjTmmH
	+6NyhTkRoLxCSGNRdx/OiaIeqI/M3rkxLM1mv9cLCo/MDVqVLGm2BPwKl/dfztZG6Mt3pTZT6+j
	oge4/PjFkwRHyABY7NkglNCZns0iQE3fWqElfNb7pD5plCtMG6y9IvM4C2JiiP4lRkJXeDwq+9Y
	8EPOB0pnA3zFt2fzsLBvRgkauqMWgofOgvEHR4FmkZf8lTaaX56w3EoqFhcwPkZMYPr+rBGrzbm
	eKf9MUwkR/tBIDfDj0TZ/Bg9XmmojhMHtV6TtszhKbz7x88i/40KhahNsVHCzdGRQ=
X-Received: by 2002:a05:6122:390f:b0:5c9:c60e:5cf6 with SMTP id 71dfb90a1353d-5e6d3701681mr1419054e0c.20.1791408080617;
        Wed, 07 Oct 2026 14:21:20 -0700 (PDT)
Received: from beelink.. ([187.13.30.250])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e6c4d62704sm3115891e0c.10.2026.10.07.14.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 14:21:20 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org,
	maaz.mombasawala@broadcom.com,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/2] drm/vmwgfx: close TOCTOU on guest_memory_bo in surface reference ioctl
Date: Wed,  7 Oct 2026 18:20:49 -0300
Message-ID: <20261007212051.2574235-3-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007212051.2574235-1-qwe.aldo@gmail.com>
References: <20261007212051.2574235-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmw_gb_surface_reference_internal() checks srf->res.guest_memory_bo
for NULL and reads its vma_node offset and base.size outside the
cmdbuf_mutex scope that protects the backup pointer.

A concurrent backup switch, e.g. from SVGA_3D_CMD_BIND_GB_SURFACE
via vmw_resource_unreserve(), drops its reference to the old buffer
and installs a new one under cmdbuf_mutex. The unlocked check in
the surface reference ioctl can see a transient NULL. The reads
after the unlock can return another buffer's offset and size; a
further switch can drop that buffer's last reference and free it
while the ioctl reads from it.

Move the NULL check inside the mutex, and read buffer_map_handle
and buffer_size while still holding it.

Fixes: a97e21923b42 ("drm/vmwgfx: Hook up guest-backed surfaces")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 97966d849583..291e3efad9ad 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1718,23 +1718,32 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 
 	user_srf = container_of(base, struct vmw_user_surface, prime.base);
 	srf = &user_srf->srf;
+	metadata = &srf->metadata;
+
+	mutex_lock(&dev_priv->cmdbuf_mutex);
+
 	if (!srf->res.guest_memory_bo) {
+		mutex_unlock(&dev_priv->cmdbuf_mutex);
 		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
 		ret = -EINVAL;
 		goto out_bad_resource;
 	}
-	metadata = &srf->metadata;
 
-	mutex_lock(&dev_priv->cmdbuf_mutex); /* Protect res->backup */
 	ret = drm_gem_handle_create(file_priv, &srf->res.guest_memory_bo->tbo.base,
 				    &backup_handle);
-	mutex_unlock(&dev_priv->cmdbuf_mutex);
 	if (ret != 0) {
+		mutex_unlock(&dev_priv->cmdbuf_mutex);
 		drm_err(dev, "Wasn't able to create a backing handle for surface sid = %u.\n",
 			req->sid);
 		goto out_bad_resource;
 	}
 
+	rep->crep.buffer_map_handle =
+		drm_vma_node_offset_addr(&srf->res.guest_memory_bo->tbo.base.vma_node);
+	rep->crep.buffer_size = srf->res.guest_memory_bo->tbo.base.size;
+
+	mutex_unlock(&dev_priv->cmdbuf_mutex);
+
 	rep->creq.base.svga3d_flags = SVGA3D_FLAGS_LOWER_32(metadata->flags);
 	rep->creq.base.format = metadata->format;
 	rep->creq.base.mip_levels = metadata->mip_levels[0];
@@ -1747,9 +1756,6 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	rep->crep.handle = user_srf->prime.base.handle;
 	rep->crep.backup_size = srf->res.guest_memory_size;
 	rep->crep.buffer_handle = backup_handle;
-	rep->crep.buffer_map_handle =
-		drm_vma_node_offset_addr(&srf->res.guest_memory_bo->tbo.base.vma_node);
-	rep->crep.buffer_size = srf->res.guest_memory_bo->tbo.base.size;
 
 	rep->creq.version = drm_vmw_gb_surface_v1;
 	rep->creq.svga3d_flags_upper_32_bits =
-- 
2.43.0

