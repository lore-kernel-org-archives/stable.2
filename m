Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2267F341ADD
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689251; cv=none; b=oQ0ILsrDokbdEwHuQpsbq1oO9d9Tgx18D7guU4agnnf6StNOnorbMTOk9S+7/t1Fm0K9MCyljzvO9HaXNBpoZ+cEUHciDUwUk4HCeToi1KSbAqyGBGlOux0Zn7UOKS04MKzmhrhoDCbeyGQnFRKDnuU1nPn9T6GCuNQbfGsUAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689251; c=relaxed/simple;
	bh=GgrrVAWpoCRygfQJZKilkxtLSpPDQeU3bgjtbYMqmo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rhS4JBGZ92UbLg2ORk4WRWYS7UoxnsjM77E9AiHAlKyLtBmk5rKBOUo1wZPZxtY3Io132p/U6VyB3DDU+ZPQLhdPQY473DLPvbx7TQEiVSrATJgz1rdy3WrTtsIx4dUCkgMQv0UBM5icUsV61LDnWE+L72vA1laQ0vdk4BjhHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFbFcPvY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFbFcPvY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781689249; x=1813225249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GgrrVAWpoCRygfQJZKilkxtLSpPDQeU3bgjtbYMqmo8=;
  b=nFbFcPvY4OzA3uEHwXBolWOkPsitZnxy/CAieZeV4Q0RnSx3l+LyUtpU
   DLTvJFlLXECU0XA6xaC3y6DqaJ6+LTOH3uq098hyC+RSHF/8r88z/T4By
   Up/V82f6oAZ9GY3XLpVJnub1+8/zF1QNXy2oBOY6qzicu3EJifFJQsBoJ
   8S7M9zj4ez8sewjZRH1LuoDzzHS5zC2sM0Q8QscoSKzgADOuLomEb83sr
   FUsPEDtD7Wjuq0mLH3kpToRptrpGfLN3wDZwMjiSzKePEF/FdmkiHLeR4
   xYVWXyLEOf3mAvEacZFig5kzEklDrhCSSMgMZ79cJM+q+H5GI/dP8D7Sf
   A==;
X-CSE-ConnectionGUID: hNcBqTzWRHSWGxU75nnARg==
X-CSE-MsgGUID: Kg2wYx0wQqu47aVeVMNQqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="81605781"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="81605781"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:40:48 -0700
X-CSE-ConnectionGUID: OKYPK4mLSXapQ1RHu7+WRQ==
X-CSE-MsgGUID: girMir4/QiuzYOrxh2T8Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="245116333"
Received: from nitin-super-server.iind.intel.com ([10.190.238.72])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jun 2026 02:40:46 -0700
From: Nitin Gote <nitin.r.gote@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nitin Gote <nitin.r.gote@intel.com>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Christian Konig <christian.koenig@amd.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH] drm/xe: Create imported sg BO only after dma-buf attach
Date: Wed, 17 Jun 2026 15:46:55 +0530
Message-ID: <20260617101654.1989199-2-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xe_dma_buf_create_obj() creates a ttm_bo_type_sg BO whose resv points
at the exporter's dma_buf->resv, then dma_buf_dynamic_attach() is
called. If the attach fails, no importer attachment exists and xe does
not retain a dma-buf reference, yet the BO's resv still points at the
exporter's dma_resv. Since sg BO cleanup is deferred,
ttm_bo_delayed_delete() may later lock that stale resv and hit a
use-after-free.

Fix this by reversing the order: attach first with a NULL importer_priv,
then create the BO only after the attach succeeds. The
invalidate_mappings callback treats NULL importer_priv as an incomplete
import and returns early; at that point no importer BO has been created,
so there is nothing to invalidate.

If BO creation fails after attach succeeds, detach and return the error.
Since get_dma_buf() is only called after BO creation succeeds, the error
paths leave no extra dma-buf reference behind.

Tested with igt@xe_live_ktest@xe_dma_buf_kunit on BMG

v2: (Thomas)
  - Reworked the fix to avoid creating the imported sg BO before
    dma_buf_dynamic_attach() succeeds.
  - Attach with importer_priv == NULL and make invalidate_mappings ignore
    incomplete imports.
  - Keep get_dma_buf() after successful BO creation so error paths leave no
    extra dma-buf reference behind.

Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
Cc: stable@vger.kernel.org # v6.8+
Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Cc: Christian Konig <christian.koenig@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
---
 drivers/gpu/drm/xe/xe_dma_buf.c | 42 +++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 8a920e58245c..9fc4c5484519 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -317,10 +317,19 @@ xe_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 
 static void xe_dma_buf_move_notify(struct dma_buf_attachment *attach)
 {
-	struct drm_gem_object *obj = attach->importer_priv;
-	struct xe_bo *bo = gem_to_xe_bo(obj);
+	struct drm_gem_object *obj = READ_ONCE(attach->importer_priv);
+	struct xe_bo *bo;
 	struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
 
+	/*
+	 * The attachment is visible before the imported BO is created.
+	 * Until importer_priv is set, there is no importer object to
+	 * invalidate.
+	 */
+	if (!obj)
+		return;
+
+	bo = gem_to_xe_bo(obj);
 	XE_WARN_ON(xe_bo_evict(bo, exec));
 }
 
@@ -365,31 +374,34 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 		}
 	}
 
-	/*
-	 * This needs to happen before the attach, since it will create a new
-	 * attachment for this, and add it to the list of attachments, at which
-	 * point it is globally visible, and at any point the export side can
-	 * call into on invalidate_mappings callback, which require a working
-	 * object.
-	 */
-	obj = xe_dma_buf_create_obj(dev, dma_buf);
-	if (IS_ERR(obj))
-		return obj;
-
 	attach_ops = &xe_dma_buf_attach_ops;
 #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
 	if (test)
 		attach_ops = test->attach_ops;
 #endif
 
-	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, obj);
+	/*
+	 * xe_dma_buf_create_obj() creates a ttm_bo_type_sg BO whose resv points
+	 * at dma_buf->resv. Do not create that BO until attach succeeds;
+	 * otherwise an attach failure can leave delayed_delete with a stale
+	 * exporter resv. Attach with NULL importer_priv first; move_notify
+	 * skips incomplete attachments.
+	 */
+	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, NULL);
 	if (IS_ERR(attach)) {
-		xe_bo_put(gem_to_xe_bo(obj));
 		return ERR_CAST(attach);
 	}
 
+	obj = xe_dma_buf_create_obj(dev, dma_buf);
+	if (IS_ERR(obj)) {
+		dma_buf_detach(dma_buf, attach);
+		return obj;
+	}
+
 	get_dma_buf(dma_buf);
 	obj->import_attach = attach;
+	WRITE_ONCE(attach->importer_priv, obj);
+
 	return obj;
 }
 
-- 
2.50.1

