Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C413E5595
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918786; cv=none; b=p2rSLeiZ1uiw+a/50Nk0jev/r3Rhusdu2W7kAyKRJr95y8WYSVpQKKnWp6Vm2ZJhNOEi231TZyfpuOsUmJexOmByKzcnHwdsiJcTKUF21WcieD4HJ2PFMHbgCeHZx0DDF9TtAh6PKlSMOsSbVfKBVeJ1lwYRvrdNYqZld0I6TOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918786; c=relaxed/simple;
	bh=WVRxyzp9/78KTtZrm7banrC7MD8lrtrpynltTBwIQg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpFzxtbVTGChfmWNpFbLj5wjTm6p7QIMLUOVvwd7bCRRIokM3cKQP/T3zTmF4Ysi6e8tAGpBPGqA7abzWi9GpT7TXMGiYMv/bLRgkBvfPt37vDJl+FLxAiYUg54rWt+Zwn6VINKlW+IZvrsrvzId1LWzkK4VrkEUbXDzArucXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6XYVkU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6XYVkU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED111F000FF;
	Tue, 13 Oct 2026 19:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791918781;
	bh=bbZ+Pm3urWyX353JYUXgzGUzg5DuEBBgoB2g9i6sf6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K6XYVkU/j2ZVvLD7rgrJbVKic99x7VKlxIMoqQXSQwfDjliTZzqf2i660LO+qNvyJ
	 FYB88s7YqS1veXM+Yx/oMZqfW70LJaJh4F/H4hCsyVsDAJh6bVETjBOR9BYh08zOZ6
	 KEDUX3FLYV9xEg10NRbNDpJMmbX3RS5PS5YqF5wr+4c00xwshGjHMYcEs3NgEjfJ7M
	 FlRqYozaA0e8Omi25vSz7AgN67oub2JT/FqRg4Dc/rsvD/YVDk2ejiYvGutnKXpq/1
	 bDajb9N2KHMl2Z7E0i+5yGrsx+xo6vi3E9G+jeN7zqmFYeZbyC1vs+9v3Z+OOGyz6j
	 JR9DEVCLCFu+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	Youness HFA <hfa.youness@gmail.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/vmwgfx: validate pitch coming from userspace
Date: Tue, 13 Oct 2026 15:13:00 -0400
Message-ID: <20261013191213.668530-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101208-profusely-rockfish-2948@gregkh>
References: <2026101208-profusely-rockfish-2948@gregkh>
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
[ sashal: Adapted the changes to the existing cursor snooping function using fixed 64×64 dimensions and four-byte pixels. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 5210b8084217c..38abdaf663ff6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -277,6 +277,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	unsigned long kmap_num;
 	SVGA3dCopyBox *box;
 	unsigned box_count;
+	u64 src_extent;
 	void *virtual;
 	bool dummy;
 	struct vmw_dma_cmd {
@@ -285,6 +286,8 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	} *cmd;
 	int i, ret;
 
+	BUILD_BUG_ON(sizeof(*srf->snooper.image) != 4);
+
 	cmd = container_of(header, struct vmw_dma_cmd, header);
 
 	/* No snooper installed */
@@ -322,8 +325,19 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
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
@@ -337,13 +351,13 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 
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

