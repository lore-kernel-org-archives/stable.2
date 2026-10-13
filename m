Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02E3932F7
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932676; cv=none; b=C4dpryiJ3sDE+He8n66HohI5gAzr+LG32627yOoHesyaVZzdY9DFQ9qiBKsr2OolbxiHRRVJ52+8XIAi+49X9AfRA38vb8sN1F4XqkDYatCLjV0gRLxC7CDOHaxckZa3vtYWQJKSXL794hnrx3JioFnrx0QOJTlDjHEwrWluCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932676; c=relaxed/simple;
	bh=ud3lrfzKYnbsNH+OAncUpkEJqPkcjdhFUnvyp1B6Tjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3iydWGXaPrbY2edKEpPl3T+Udofn2pUtGeCcdCxCVqfWPIJxrgH1a6GGqzFjCVqlGyX0myvwjHGhB/7pb2qBPK6X2JsylYBhvtW2EJ2e6ZMYp8MkjlQjI73hwxvMxkt2zo8yfLtjK6Y8XG7KtUdnYg6MyQxMB8z4ha7+3Ko3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTSRxac8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTSRxac8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E881F000FF;
	Tue, 13 Oct 2026 23:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932675;
	bh=aoYBlW+Tm+hyXcafRd/EcXv48Gzw8QjBAHn6SbGB5b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mTSRxac8xqn3RFrFS57OyeenD7byud1M7Luwia3ZvTzc4EfaBROKXHuUzbkMCFUHY
	 vV1wZerHm3AwfO2oE3m6rTZ/J0VbaWDSwbchITNYPL88xHs6Afc/9yypR04WJRBvKf
	 sYiXyeTPnsNk9N1uvE21fC2N51Z9VW5YDGbCmtLPBtXf8tr0XW4KqIc4/JguFqGxSW
	 Nchgld6T30TCY7f/cBE/+BG3Vbce6EViDa0J8s0pwtfLwerX1OL3nlB/voep6Gm/5N
	 5UnXCDhFOq8/r7DsJETYWbD3td7hfPFAlt9CNokI4dFzvfx5VPW7m1ICYjZHZztBA8
	 p4iEaE/lf1QTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	Youness HFA <hfa.youness@gmail.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/vmwgfx: validate pitch coming from userspace
Date: Tue, 13 Oct 2026 19:04:33 -0400
Message-ID: <20261013230333.1057757-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101209-sharply-cinema-3029@gregkh>
References: <2026101209-sharply-cinema-3029@gregkh>
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
[ sashal: Adapted cursor calculations to existing hard-coded 64-pixel dimensions and 4-byte pixels. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 73cbb94ff456b..b0f266b5c067f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -151,6 +151,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	unsigned long kmap_num;
 	SVGA3dCopyBox *box;
 	unsigned box_count;
+	u64 src_extent;
 	void *virtual;
 	bool dummy;
 	struct vmw_dma_cmd {
@@ -159,6 +160,8 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	} *cmd;
 	int i, ret;
 
+	BUILD_BUG_ON(sizeof(*srf->snooper.image) != 4);
+
 	cmd = container_of(header, struct vmw_dma_cmd, header);
 
 	/* No snooper installed */
@@ -196,8 +199,19 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
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
@@ -211,13 +225,13 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 
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

