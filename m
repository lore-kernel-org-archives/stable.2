Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5852269C
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912107; cv=none; b=cWFijLK9rxCRD+6Jw6KIq6IfRUFkA1UCkn1kAoEh3/rGtGisiX9FHquBl/669oXBO62fzGwjAR2FOL8KQJEzwX8pbIQQq6vf8iiUtaMUil+3hkYOgtqJHLVFkkCn/BNDpG1AmJv7RCD039lp8utDYBDY+xK8W8LEXZdyqgTt55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912107; c=relaxed/simple;
	bh=86CdBQjTLrKauF+8nXzka7O9M/qjBXH5BPMEGDeu9bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnaF7cE48MIkymtyScQtcAX3ab43gi9sSG8nfa0Ppa0aVPq7CA2vZdhOLL+ht0V/tGw2rd3FHkH4kZo8p+GrdsfCVchq2cGCA1LFWCpQu0JCxJM+iI9YKNFo2tR4Vgr57g8sUlwU4iQs7BkiWvrgdls3Di549U/NZ0jdBT+6Lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzuLBDEB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzuLBDEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B5C1F000FF;
	Tue, 13 Oct 2026 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912106;
	bh=tvd7EDs6rXSTIX/w5XCMjbE4jzhAxt0aDAAPrSMYpwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VzuLBDEBRmTCc5oHN6zGlhG46uKaQ4DDBZ+HjXlcjBBuzVjCuRbZJO+uotfBZbfbb
	 ZHWm5gaTTgVJvUl1nwoj6r3E1RZjW0f+F0GxFG6fH4mdSoz4nRfZs9gDqHatCdhhU2
	 6FsGc2YjOvDeEZ8NMyheayL5GF25FUL2rGXsu0VXDvS2UUMO3voEbwiVYoQ0xkjSWk
	 /LNbPhlP6SZKcWhX5AfkwU4qkI3dRDHXKcGoYWMYVw9IV8DZQkv2e800Lc22iyZ+Uc
	 M/bKFN0Tg068N6j02ZZxNnTe+aeOWvRrTtpsnJVdMV5AK1lyeFsD5uVlS1Hd58SKAE
	 7yez5sMHoZUtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	Youness HFA <hfa.youness@gmail.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/vmwgfx: validate pitch coming from userspace
Date: Tue, 13 Oct 2026 13:21:44 -0400
Message-ID: <20261013172119.606412-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101208-evidence-strategic-fea5@gregkh>
References: <2026101208-evidence-strategic-fea5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
[ sashal: Adjusted context for vmw_kms_cursor_snoop() residing in the KMS code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 33f73d559be72..7524403427c7b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -370,6 +370,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	unsigned long kmap_num;
 	SVGA3dCopyBox *box;
 	unsigned box_count;
+	u64 src_extent;
 	void *virtual;
 	bool is_iomem;
 	struct vmw_dma_cmd {
@@ -381,6 +382,8 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 		vmw_surface_get_desc(VMW_CURSOR_SNOOP_FORMAT);
 	const u32 image_pitch = VMW_CURSOR_SNOOP_WIDTH * desc->pitchBytesPerBlock;
 
+	BUILD_BUG_ON(sizeof(*srf->snooper.image) != desc->pitchBytesPerBlock);
+
 	cmd = container_of(header, struct vmw_dma_cmd, header);
 
 	/* No snooper installed, nothing to copy */
@@ -418,8 +421,19 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 		return;
 	}
 
+	if (box->w == 0 || box->h == 0)
+		return;
+
+	src_extent = (u64)(box->h - 1) * cmd->dma.guest.pitch +
+		     (u64)box->w * desc->pitchBytesPerBlock;
+	if (src_extent > bo->base.size) {
+		DRM_ERROR("Cursor snoop source of %llu bytes exceeds the %zu byte buffer\n",
+			  src_extent, bo->base.size);
+		return;
+	}
+
 	kmap_offset = cmd->dma.guest.ptr.offset >> PAGE_SHIFT;
-	kmap_num = (VMW_CURSOR_SNOOP_HEIGHT*image_pitch) >> PAGE_SHIFT;
+	kmap_num = PFN_UP(src_extent);
 
 	ret = ttm_bo_reserve(bo, true, false, NULL);
 	if (unlikely(ret != 0)) {
@@ -433,14 +447,16 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 
 	virtual = ttm_kmap_obj_virtual(&map, &is_iomem);
 
-	if (box->w == VMW_CURSOR_SNOOP_WIDTH && cmd->dma.guest.pitch == image_pitch) {
+	if (box->w == VMW_CURSOR_SNOOP_WIDTH &&
+	    box->h == VMW_CURSOR_SNOOP_HEIGHT &&
+	    cmd->dma.guest.pitch == image_pitch) {
 		memcpy(srf->snooper.image, virtual,
 		       VMW_CURSOR_SNOOP_HEIGHT*image_pitch);
 	} else {
-		/* Image is unsigned pointer. */
+		/* The destination stride is in pixels. */
 		for (i = 0; i < box->h; i++)
-			memcpy(srf->snooper.image + i * image_pitch,
-			       virtual + i * cmd->dma.guest.pitch,
+			memcpy(srf->snooper.image + i * VMW_CURSOR_SNOOP_WIDTH,
+			       virtual + (size_t)i * cmd->dma.guest.pitch,
 			       box->w * desc->pitchBytesPerBlock);
 	}
 
-- 
2.53.0

