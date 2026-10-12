Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD549DB9D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819128; cv=none; b=O/5Rx9xtNo9Lk+5amp3r8+mtii0oWaRsNoW6upajshFbd/XRsp7XYcFNiBr6c7DmyofCZ90Y7rbHYhb+4WJV5v0RqBAAE9YiMCFfGzZ0pA4cp4AWzdT9oyzjMSBx/rdoglntNgWJmubXbeJx1g7Abn4E6ELeTTKAvnYbiLWVR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819128; c=relaxed/simple;
	bh=H6OAiqNCJ8DyKxGab/xwS470h19ByxNh5GBNY1/AdeU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uGrcXvl6mjxjcok55O+vykGiS+mrNgnEeGswYuCa1gwrf1fuJu0ErFzKR+zhRThz5gQEVI2mQ9TJNFPFpa0pai2zJXy7kOC13JErnls9XwnlwMVNh3ysluDxfTRWN7D4nilfs0v94g0LUFgfgWXrjVnAK41Zm0t+3ajckawF6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NmbiKpux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NmbiKpux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9141F0089B;
	Mon, 12 Oct 2026 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819127;
	bh=Ze4dimQ7AvGIw/39Hh/ysXUGXW29zcO+nzycxWD2BPo=;
	h=Subject:To:Cc:From:Date;
	b=NmbiKpuxIP7Qov1jzHI0fVGU47eHVsw6X7myM9XsKSBZR6ZbtiZyXKHjpRPluR0er
	 n9pOulD893rqQF79JwCX/Cl5E79S2fuVYpFewyKFN0UJzX1iWJA4MlVEjzjLCFyL9w
	 tu4o7TVbeBUWnmVYRfj4+mNSYBUG9W2wTVAekbJA=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: validate pitch coming from userspace" failed to apply to 6.1-stable tree
To: zack.rusin@broadcom.com,hfa.youness@gmail.com,maaz.mombasawala@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:31:08 +0200
Message-ID: <2026101208-profusely-rockfish-2948@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 21bc51cb89ced74d6645a138cc2f21184bc75094
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101208-profusely-rockfish-2948@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 21bc51cb89ced74d6645a138cc2f21184bc75094 Mon Sep 17 00:00:00 2001
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Sun, 9 Aug 2026 16:45:15 -0400
Subject: [PATCH] drm/vmwgfx: validate pitch coming from userspace

Validate the pitch, alongside the box dimensions before trying
to copy data from the underlying surface. Fixes possible
out of bounds reads with cursor snooping.

Fixes: 2ac863719e51 ("vmwgfx: Snoop DMA transfers with non-covering sizes")
Cc: stable@vger.kernel.org
Reported-by: Youness HFA <hfa.youness@gmail.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Link: https://patch.msgid.link/20260809204515.211045-1-zack.rusin@broadcom.com

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index d1e7df500190..5a69606a0593 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -324,6 +324,7 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 	unsigned long kmap_num;
 	SVGA3dCopyBox *box;
 	u32 box_count;
+	u64 src_extent;
 	void *virtual;
 	bool is_iomem;
 	struct vmw_dma_cmd {
@@ -335,6 +336,8 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 		vmw_surface_get_desc(VMW_CURSOR_SNOOP_FORMAT);
 	const u32 image_pitch = VMW_CURSOR_SNOOP_WIDTH * desc->pitchBytesPerBlock;
 
+	BUILD_BUG_ON(sizeof(*srf->snooper.image) != desc->pitchBytesPerBlock);
+
 	cmd = container_of(header, struct vmw_dma_cmd, header);
 
 	/* No snooper installed, nothing to copy */
@@ -372,8 +375,19 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
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
-	kmap_num = (VMW_CURSOR_SNOOP_HEIGHT * image_pitch) >> PAGE_SHIFT;
+	kmap_num = PFN_UP(src_extent);
 
 	ret = ttm_bo_reserve(bo, true, false, NULL);
 	if (unlikely(ret != 0)) {
@@ -387,14 +401,16 @@ void vmw_kms_cursor_snoop(struct vmw_surface *srf,
 
 	virtual = ttm_kmap_obj_virtual(&map, &is_iomem);
 
-	if (box->w == VMW_CURSOR_SNOOP_WIDTH && cmd->dma.guest.pitch == image_pitch) {
+	if (box->w == VMW_CURSOR_SNOOP_WIDTH &&
+	    box->h == VMW_CURSOR_SNOOP_HEIGHT &&
+	    cmd->dma.guest.pitch == image_pitch) {
 		memcpy(srf->snooper.image, virtual,
 		       VMW_CURSOR_SNOOP_HEIGHT * image_pitch);
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
 	srf->snooper.id++;

