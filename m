Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A824A0923
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819125; cv=none; b=RomNscAWrTBK/yrhrMojqCGYMjWQcIW3RWaH5KCVcNQDz6c1SeWLgtSbI6uVY7bWC4ozfbgz1JsAReagyzZMDIRqfRg0fcxl97AXpAt0A1NxkwUZt9KwUlJf8imscQjvVqlqHvrWmlk5wyifMqPCY6aqt4QG8eznkQD2b55JKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819125; c=relaxed/simple;
	bh=rmBM9uiUx75+gEDA6Mc1hQP0glcGpAob9px5/2P9tvI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QBAEjuKx1JExxFg/pkXHMR12a1DfqdvWBfAs/dB8aibEfSzbtqxif0tALSw+zSDr9bMqdO7KBJ2wGQ4H79T5UrFBv+O0Dbud3i/cKgfYttp+ip+poAhazucK2nJBijqgKTZ29ZBvh0gGPFftKoKd0v9RaOkMF99b7MULK/HF1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MLkKjRiT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MLkKjRiT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7192C1F0089B;
	Mon, 12 Oct 2026 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819124;
	bh=Tx5yFW0gykDRD3TMQv+g5N3K5OH2cAyu4iBs09WSUJY=;
	h=Subject:To:Cc:From:Date;
	b=MLkKjRiTCkxpVvrRXsa4bHcMzoFaeN3PsBxUSjrfLwHEQ0j6Iwdkpg+mbGIYbXviK
	 2QIXlli0Ewo07ukDEocBkF1dzsfNZdXuy9v24nctQVmZHlGOVyzlHp5hZ2X1gHRtz/
	 09/iovYpYnuj1BiaFp/SlLXEJ184qlp7dMe6etrE=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: validate pitch coming from userspace" failed to apply to 6.6-stable tree
To: zack.rusin@broadcom.com,hfa.youness@gmail.com,maaz.mombasawala@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:31:08 +0200
Message-ID: <2026101208-evidence-strategic-fea5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 21bc51cb89ced74d6645a138cc2f21184bc75094
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101208-evidence-strategic-fea5@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

