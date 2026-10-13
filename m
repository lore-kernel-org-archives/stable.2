Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498552BE4F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920294; cv=none; b=Gqw+LOYr/kHPlNl5xK59is1IHSy72BLnEp7YAEr5/Cjv1rxkeqnWAoIqQRy+BmsN1KnxK/ey3YtwnaPZppQD4UxMwQ0l8YWvXo2kwzlQ6A5E2ll4WE67cbGTpwViqTVdEIDdXHzbzHOl7oNCgYzrvrAlrWAFSafghsQVrNQfPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920294; c=relaxed/simple;
	bh=/Vfkta5z2BwP5nOE7cMYdUvhStFhCAo6L4Fq0Jlfreo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmboLI5uckMQDNgNVrsIipxoI0gVvjkAX9CoJEZEtYcEU/NblWcSZezWEMDm/UF7T14lIfgBkfpPIrO+dPKwPwX7UIGqr7fTLGLbKDI4Oe5Thdnnw8NlaK9LBsenWUQGRapQmiuexcDm8JlxlztM6JvLfmj7lkBsxuh9l6uEgiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKP7VbAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKP7VbAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDB71F00893;
	Tue, 13 Oct 2026 19:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791920293;
	bh=Z71YF/TQM3R1u7C9u09V5W8zAETrrdNm3XG4xPLdvtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kKP7VbAcPQoERjvANKY7YmZN+KB48u1O25tN8yW0XKhu177t7nZZiGpep3OhdIG1n
	 TkVxeBS4ikhILsJSTR3EdcSMhHrTxASy4NApNjMdM2ZsfVJgJ7pMWeH9MH2zk62s8V
	 8+xA8Ou9VVvuMYLXe5moAW4tLLwhY7r4TXcCCUdRm80C4HtFroaeIuL7bSDiGEDjXa
	 EEiW2dKZbrIQL2m7kTIeJpfQSpgbhEo7PhAM4T1kjuvTVxEy3+yZ1Eq3XowpCQptrp
	 zfgt4QpKE3Lk+D/GjX1XO5aLasg5bkW5H7PUGNV3x+MSI4kfW9rinBODS2YZumIWlq
	 OO4w6qO0TgYYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	Youness HFA <hfa.youness@gmail.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/vmwgfx: validate pitch coming from userspace
Date: Tue, 13 Oct 2026 15:38:11 -0400
Message-ID: <20261013193729.882548-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101209-yield-esteemed-f1ca@gregkh>
References: <2026101209-yield-esteemed-f1ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zack Rusin <zack.rusin@broadcom.com>

[ Upstream commit 21bc51cb89ced74d6645a138cc2f21184bc75094 ]

Validate the pitch, alongside the box dimensions before trying
to copy data from the underlying surface. Fixes possible
out of bounds reads with cursor snooping.

Fixes: 2ac863719e51 ("vmwgfx: Snoop DMA transfers with non-covering sizes")
Cc: stable@vger.kernel.org
Reported-by: Youness HFA <hfa.youness@gmail.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Link: https://patch.msgid.link/20260809204515.211045-1-zack.rusin@broadcom.com
[ sashal: Adapted descriptor-based cursor sizing to hard-coded 64×64 dimensions and 4-byte pixels. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 8a9b61920496a..590267c8a2fd9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -155,6 +155,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	unsigned long kmap_num;
 	SVGA3dCopyBox *box;
 	unsigned box_count;
+	u64 src_extent;
 	void *virtual;
 	bool dummy;
 	struct vmw_dma_cmd {
@@ -163,6 +164,8 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	} *cmd;
 	int i, ret;
 
+	BUILD_BUG_ON(sizeof(*srf->snooper.image) != 4);
+
 	cmd = container_of(header, struct vmw_dma_cmd, header);
 
 	/* No snooper installed */
@@ -200,8 +203,19 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 		return;
 	}
 
+	if (box->w == 0 || box->h == 0)
+		return;
+
+	src_extent = (u64)(box->h - 1) * cmd->dma.guest.pitch +
+		     (u64)box->w * 4;
+	if (src_extent > bo->base.size) {
+		DRM_ERROR("Cursor snoop source of %llu bytes exceeds the %zu byte buffer\n",
+			  src_extent, bo->base.size);
+		return;
+	}
+
 	kmap_offset = cmd->dma.guest.ptr.offset >> PAGE_SHIFT;
-	kmap_num = (64*64*4) >> PAGE_SHIFT;
+	kmap_num = PFN_UP(src_extent);
 
 	ret = ttm_bo_reserve(bo, true, false, NULL);
 	if (unlikely(ret != 0)) {
@@ -215,13 +229,13 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 
 	virtual = ttm_kmap_obj_virtual(&map, &dummy);
 
-	if (box->w == 64 && cmd->dma.guest.pitch == 64*4) {
+	if (box->w == 64 && box->h == 64 && cmd->dma.guest.pitch == 64*4) {
 		memcpy(srf->snooper.image, virtual, 64*64*4);
 	} else {
-		/* Image is unsigned pointer. */
+		/* The destination stride is in pixels. */
 		for (i = 0; i < box->h; i++)
 			memcpy(srf->snooper.image + i * 64,
-			       virtual + i * cmd->dma.guest.pitch,
+			       virtual + (size_t)i * cmd->dma.guest.pitch,
 			       box->w * 4);
 	}
 
-- 
2.53.0

