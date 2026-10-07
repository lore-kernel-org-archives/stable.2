Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D74C6507
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387425; cv=none; b=ixjvWhv/1Dwr0Ji76n0/Zlkf8NQfG2agIQPw67X3SCpGK7r+omiT8AGM1V3YM8A1FEFRF1TnzAqK4D5o/lBJybzDQO/Cw4/oqN2dgs5tWuX9a0pC1rwTrGVU0mBi7UMPmdum9Edl7A2tOMx1fk8+a3WM2UtWKm14D4KfG4NCnIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387425; c=relaxed/simple;
	bh=5XmbMx+f5qCzLcoMpiCVCy78XcU2I52lCRiyH2KgYlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uR265AR+N3omL1nxgtLil1TKhiDsvvDr6XlG1lut8C34RIXf+hfEi4NQTJT+6jFlGpYc5LZovEmC/DYQMUkk5ulucm2uTgcZQSKGVBM60ssIZMy/crx4VnbNZv5QyF8YQhLjm6M7/2Oh5FSuaDyMZAV3OpZpD9TiLeYjQ3hYvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYf7xVuC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYf7xVuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791387412; x=1822923412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5XmbMx+f5qCzLcoMpiCVCy78XcU2I52lCRiyH2KgYlQ=;
  b=kYf7xVuCh/2j+Bcbha1SU3ptRJOz5HubZTFcjFGwuVGtM/GTa9Q84KmQ
   6QygDSBuffB3knXOS+Q1gElJ0EHUYcGnMtbzR40wjG47Hbg8TiujWnIW6
   hcB03PpL2yZWbsIjpgFNYanxIrJ82WNTCKxZNAFGSWl/WM+KUywI6bKwI
   9cMOsO7bwb96NWjwGt88vXXSRxbA8LB/XHj6kwqOzL9KrE9wMaIqK5ypk
   JR4iCcE/SQ2RjbIVdAdWgGSFC8H/cSjk54KEczJVzw9QgvxJYTIqb6oX6
   G3XADC293MY3e08iGqhh6Fb28ML7vi4GIUk74HH45BgagcYqZfmzC/rDj
   Q==;
X-CSE-ConnectionGUID: yjfTvH7aSJK61KAb24U6wA==
X-CSE-MsgGUID: LWyLaFdMQ5OtjGGDXLMafQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="148788"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="148788"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 08:36:52 -0700
X-CSE-ConnectionGUID: 8da4bCF/R5OFEdb41NLCmA==
X-CSE-MsgGUID: YNIGV1BsRfOgSKpKZWuSHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="277583540"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.246])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 08:36:51 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] drm/xe: skip p2p for suspected display buffers
Date: Wed,  7 Oct 2026 16:36:09 +0100
Message-ID: <20261007153605.1743626-8-matthew.auld@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007153605.1743626-5-matthew.auld@intel.com>
References: <20261007153605.1743626-5-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If p2p is allowed on the CPU (like on AMD), we currently permit p2p for
all exported VRAM buffers. However, in some multi-GPU setups, like with
prime rendering on a dgpu and scanout/compositor using the igpu, it
looks like the exported dma-buf window buffer can in some cases end up
using p2p.

However, user is reporting a kernel regression where performance here
massively tanks across many games/workloads, where it looks like on each
frame, the igpu is reading/sampling from VRAM over pcie for the window
buffer, since it uses p2p. p2p is currently more intended for dgpu <->
dgpu, and not so much display buffers with igpu <-> dgpu, at least for
now.

We don't currently have any hints to say "please use p2p for this
buffer, or please don't", however we can use some heuristics to try to
determine if this is likely a display buffer being exported to an igpu,
which probably never intended for p2p:

 1. FLAG_SCANOUT being set on the buffer. Window buffers usually get
    tagged with this, but not always.

 2. Importer being a PCI device with display, which is not xe driver.

We also rely on the existing p2p Intel CPU whitelist to stop this
happening on xe igpu. Currently p2p is only enabled for server CPUs, on
Intel. We also limit the above to dual placement buffers.

The original regression was bisected to commit 609fc8766d68 ("dma-buf:
Always build with DMABUF_MOVE_NOTIFY"), however the behaviour was
already present when enabling that knob, so this goes back even further.

User has confirmed that along with the sticky dma-buf TT placement fix,
to prevent ping-ponging, the performance is back to normal.

Assisted-by: LLM
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.12
---
 drivers/gpu/drm/xe/xe_bo.c      |  3 +-
 drivers/gpu/drm/xe/xe_bo.h      |  1 +
 drivers/gpu/drm/xe/xe_dma_buf.c | 63 +++++++++++++++++++++++++--------
 3 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 5065a7bac39c..e63437a261cb 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -3658,7 +3658,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 	 * Display scanout is always non-coherent with the CPU cache.
 	 */
 	if (args->flags & DRM_XE_GEM_CREATE_FLAG_SCANOUT)
-		bo_flags |= XE_BO_FLAG_FORCE_WC;
+		bo_flags |= XE_BO_FLAG_FORCE_WC | XE_BO_FLAG_SCANOUT;
 
 	if (args->flags & DRM_XE_GEM_CREATE_FLAG_NO_COMPRESSION) {
 		if (XE_IOCTL_DBG(xe, GRAPHICS_VER(xe) < 20))
@@ -4228,6 +4228,7 @@ int xe_bo_dumb_create(struct drm_file *file_priv,
 			       DRM_XE_GEM_CPU_CACHING_WC,
 			       XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
 			       XE_BO_FLAG_FORCE_WC |
+			       XE_BO_FLAG_SCANOUT |
 			       XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 1ddf3b6d4a9e..6965c2655731 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -56,6 +56,7 @@
 #define XE_BO_FLAG_FORCE_USER_VRAM	BIT(25)
 #define XE_BO_FLAG_NO_COMPRESSION	BIT(26)
 #define XE_BO_FLAG_NEEDS_1G		BIT(27)
+#define XE_BO_FLAG_SCANOUT		BIT(28)
 
 /* this one is trigger internally only */
 #define XE_BO_FLAG_INTERNAL_TEST	BIT(30)
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index b973579a69b8..0a347f09cee4 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -36,10 +36,40 @@ static void xe_ddebug_flip_bool(const struct _ddebug *desc, bool *flag)
 #define xe_dma_buf_p2p_debug_flip(flag) do { } while (0)
 #endif
 
+static void xe_dma_buf_move_notify(struct dma_buf_attachment *attach)
+{
+	struct drm_gem_object *obj = attach->importer_priv;
+	struct xe_bo *bo = gem_to_xe_bo(obj);
+	struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
+
+	XE_WARN_ON(xe_bo_evict(bo, exec));
+}
+
+static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
+	.allow_peer2peer = true,
+	.invalidate_mappings = xe_dma_buf_move_notify
+};
+
+static struct pci_dev *xe_find_parent_pci_dev(struct device *dev)
+{
+	while (dev) {
+		if (dev_is_pci(dev))
+			return to_pci_dev(dev);
+		dev = dev->parent;
+	}
+	return NULL;
+}
+
+static bool xe_dma_buf_attach_is_xe_device(struct dma_buf_attachment *attach)
+{
+	return attach->importer_ops == &xe_dma_buf_attach_ops;
+}
+
 static int xe_dma_buf_attach(struct dma_buf *dmabuf,
 			     struct dma_buf_attachment *attach)
 {
 	struct drm_gem_object *obj = attach->dmabuf->priv;
+	struct xe_bo *bo = gem_to_xe_bo(obj);
 	bool verbose_p2p_dist = drm_debug_enabled(DRM_UT_DRIVER);
 
 	xe_dma_buf_p2p_debug_flip(&verbose_p2p_dist);
@@ -48,7 +78,24 @@ static int xe_dma_buf_attach(struct dma_buf *dmabuf,
 	    pci_p2pdma_distance(to_pci_dev(obj->dev->dev), attach->dev, verbose_p2p_dist) < 0)
 		attach->peer2peer = false;
 
-	if (!attach->peer2peer && !xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
+	if (attach->peer2peer && xe_bo_can_migrate(bo, XE_PL_TT)) {
+		struct pci_dev *client = xe_find_parent_pci_dev(attach->dev);
+
+		/*
+		 * There are perf issues with using p2p with display buffers,
+		 * like with igpu (compositor) <-> dgpu (exported p2p window
+		 * buffer). Probably we need some actual userspace hints. We
+		 * shouldn't really assume anything. Also, note that some of
+		 * these buffers are not always tagged with SCANOUT.
+		 */
+		if (bo->flags & XE_BO_FLAG_SCANOUT)
+			attach->peer2peer = false;
+		else if (client && pci_is_display(client) &&
+			 !xe_dma_buf_attach_is_xe_device(attach))
+			attach->peer2peer = false;
+	}
+
+	if (!attach->peer2peer && !xe_bo_can_migrate(bo, XE_PL_TT))
 		return -EOPNOTSUPP;
 
 	xe_pm_runtime_get(to_xe_device(obj->dev));
@@ -349,20 +396,6 @@ xe_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 	return ret ? ERR_PTR(ret) : &bo->ttm.base;
 }
 
-static void xe_dma_buf_move_notify(struct dma_buf_attachment *attach)
-{
-	struct drm_gem_object *obj = attach->importer_priv;
-	struct xe_bo *bo = gem_to_xe_bo(obj);
-	struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
-
-	XE_WARN_ON(xe_bo_evict(bo, exec));
-}
-
-static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
-	.allow_peer2peer = true,
-	.invalidate_mappings = xe_dma_buf_move_notify
-};
-
 #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
 
 struct dma_buf_test_params {
-- 
2.55.0

