Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35DA41B8F7
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517024; cv=none; b=WyK1o6w0AUo6cairJZZM44n2xcBdWtwYI0BlB+vGhc4vhvMiXY+58qlBbtCMRV7Lid1tw8DaYKHQhl8+8JdH0f0EfgmFFNE+In6EmG/WKf+JTygclFu6UJVZEAQx8Ce5N24BSn+B87PBUYP2AoewqxtJUqTlXQUP1eFD0fMQ4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517024; c=relaxed/simple;
	bh=U9dUlJdzFTkw++YkyWLqUxqRv6RFlx+YR14kP113rP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft3QJVI8f4G7fcc3JssNcNWw0q2EtS5gVKZ5EGGqh+8MsBbUpmm9EgVqAJ71seHrtWbptLpy2nqqecmnQhSc0dXc8AmcCeA26pxdIKr0Y5+6lPv+pTR1+mAnMZg5p6T/AXCouoeenqOscT3tyElAXFD2EYu430ir7SrAiAbh7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkcqFMkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkcqFMkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CC31F00AC4;
	Fri, 31 Jul 2026 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517022;
	bh=9kVC56Yv44v6qUO1w7EEgHM1DRoAxc7Pr0sNCFSVRhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dkcqFMkKyQeWnITee2hD7MFVV+/o4VAIVb2xcoQvXMTcWCUdOKPWJj7klKRRCVNWp
	 XS4/sYEuIR+vIN7EMvPvMKJlt5DUYgG44wtX6MZltrNL94CDl2YiUoWWkvrfyaLfbD
	 RqdHuI7WNgSfzpeWK3suprPk6XAbQwep6Bfp7rzmLUs8TnZ1dQXiwrUR1lKNO0kVkU
	 fWHkwoUkq6EzRLF+7ZdxhWToQ3zYnDncZA2jgA6mMbloguBLhF8zdMOkR69isn0+wb
	 paUiErVxLgdQksyuAhPWu5kT+Qn9J3vO+af5yiehGcFw5Arq+tzAOU4Hlw/1IIaGOw
	 x02YKBNFrbQRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 4/5] drm/xe: Separate early xe_device initialization
Date: Fri, 31 Jul 2026 12:56:57 -0400
Message-ID: <20260731165658.883265-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731165658.883265-1-sashal@kernel.org>
References: <2026072950-giggling-gooey-3782@gregkh>
 <20260731165658.883265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 2841cea001b983db79dc1fdf160e65318dfda3cd ]

We would like to initialize more of the xe_device struct also from
the kunit code, as it should be safe to use most of the generic drm
or xe components without doing any additional tweaks. Separate early
xe initialization code to a new function, so it can be reused.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patch.msgid.link/20260526195452.20545-6-michal.wajdeczko@intel.com
Stable-dep-of: ba7fd1634228 ("drm/xe: Set TTM device beneficial_order to 9 (2M)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device.c | 39 ++++++++++++++++++++++++----------
 drivers/gpu/drm/xe/xe_device.h |  1 +
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index fb81b6ff29c2..58cec453b9ad 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -458,27 +458,45 @@ struct xe_device *xe_device_create(struct pci_dev *pdev)
 	if (IS_ERR(xe))
 		return xe;
 
+	err = xe_device_init_early(xe);
+	if (err)
+		return ERR_PTR(err);
+
+	return xe;
+}
+ALLOW_ERROR_INJECTION(xe_device_create, ERRNO); /* See xe_pci_probe() */
+
+/**
+ * xe_device_init_early() - Initialize a new &xe_device instance
+ * @xe: the &xe_device to initialize
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int xe_device_init_early(struct xe_device *xe)
+{
+	int err;
+
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
 			      xe->drm.anon_inode->i_mapping,
 			      xe->drm.vma_offset_manager, 0);
-	if (WARN_ON(err))
-		return ERR_PTR(err);
+	if (err)
+		return err;
 
 	xe_bo_dev_init(&xe->bo_device);
 	err = drmm_add_action_or_reset(&xe->drm, xe_device_destroy, NULL);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
 	err = xe_shrinker_create(xe);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
 	xe->atomic_svm_timeslice_ms = 5;
 	xe->min_run_period_lr_ms = 5;
 
 	err = xe_irq_init(xe);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
 	xe_validation_device_init(&xe->val);
 
@@ -488,7 +506,7 @@ struct xe_device *xe_device_create(struct pci_dev *pdev)
 
 	err = xe_pagemap_shrinker_create(xe);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
 	xa_init_flags(&xe->usm.asid_to_vm, XA_FLAGS_ALLOC);
 
@@ -507,7 +525,7 @@ struct xe_device *xe_device_create(struct pci_dev *pdev)
 
 	err = xe_bo_pinned_init(xe);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
 	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq",
 						       WQ_MEM_RECLAIM);
@@ -521,16 +539,15 @@ struct xe_device *xe_device_create(struct pci_dev *pdev)
 		 * drmm_add_action_or_reset register above
 		 */
 		drm_err(&xe->drm, "Failed to allocate xe workqueues\n");
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 
 	err = drmm_mutex_init(&xe->drm, &xe->pmt.lock);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
-	return xe;
+	return 0;
 }
-ALLOW_ERROR_INJECTION(xe_device_create, ERRNO); /* See xe_pci_probe() */
 
 static bool xe_driver_flr_disabled(struct xe_device *xe)
 {
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index e363b4a8ff13..72848c5b896b 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -44,6 +44,7 @@ static inline struct xe_device *ttm_to_xe_device(struct ttm_device *ttm)
 }
 
 struct xe_device *xe_device_create(struct pci_dev *pdev);
+int xe_device_init_early(struct xe_device *xe);
 int xe_device_probe_early(struct xe_device *xe);
 int xe_device_probe(struct xe_device *xe);
 void xe_device_remove(struct xe_device *xe);
-- 
2.53.0

