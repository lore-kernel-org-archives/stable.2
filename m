Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529F42847B
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517023; cv=none; b=NuiMjcWNsVw0rn4ujSFJJ4g+IUpjE5i5o0Qk2Hn1P+wqYzAWD32Sm/5CCTbTZBguF9oncZnrhkd17E9H5yOmpCDwhadafq7OKBuKMiY/NTrihIMmGoD/4d16rursCuT3FLmoT9O28z5ZMQKEYkfdGB3Dqdqra/UDumVp9SdMiMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517023; c=relaxed/simple;
	bh=lmTdlIk/lYHSnifjXrPuYiRLB2GyHjailVxZq0RTF9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8lIcb6NcDXXGytdU8hQSTJ7Xe5VqoN+S6secsLhEhsgIYY6mFkJFGwfZZx1yPZRgMrD+pBOvHBUDPUuGlecCnG177vU3kGdharbJ5XTD0Cf1Nc4Wxn9QChsnMdr72fPxcHjoH5qkLURhHKI5+vG01xTiW3E+LOOAWtzej+qJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3Oq4eq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3Oq4eq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D24F1F00ACF;
	Fri, 31 Jul 2026 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517022;
	bh=1FOBTldBmFnK8zOJ2ErDp8+2LZoxhXgoesypPo2SdP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q3Oq4eq4dmOjaO011RvuvZJDSpKcMiCcrvoP92lu+ffLmH5yV0zxnWcb02Uko27cW
	 sDpVYut9Ct7+cHt7rgHDOQZAL6ksjBJ4haB+3CaQpgOxO5SgjlCzXv85KAlK5UZYni
	 qwzKIf26EwbuTb99LaKLv/JXjfBI12cGyexHgXnn8euJIYM2Svkfoou7/MsFTTTw0G
	 6nfcBUZoKZYvoEJi66udeAhmlHAK69lLOBasKLiH61yR3Sx29L9A/Bn9C/UspLPkYO
	 SyUskTKidK2+wpTn5BIxpbSJ7sezFZGSMhTC6DPMR3KtXeWCZVL7jqja+qywAmf50X
	 Oqgiil5Dd08EQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 3/5] drm/xe: Move xe->info.devid|revid initialization
Date: Fri, 31 Jul 2026 12:56:56 -0400
Message-ID: <20260731165658.883265-3-sashal@kernel.org>
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

[ Upstream commit c03d9fbe77ec5002a2345b9be464683e0b157709 ]

The xe_info_init_early() is a place where we initialize those of
the xe->info fields that do not require any additional hardware
probes. Move the initialization of the devid/revid also there, but
to avoid breaking the kunit helper, which also calls this function,
keep their initialization separate in sub-function so we can easily
stub it when running the kunit test.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Gustavo Sousa <gustavo.sousa@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patch.msgid.link/20260526195452.20545-5-michal.wajdeczko@intel.com
Stable-dep-of: ba7fd1634228 ("drm/xe: Set TTM device beneficial_order to 9 (2M)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/tests/xe_pci.c |  6 ++++++
 drivers/gpu/drm/xe/xe_device.c    |  2 --
 drivers/gpu/drm/xe/xe_pci.c       | 12 ++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
index 8a32fb469147..8bd0c5b03406 100644
--- a/drivers/gpu/drm/xe/tests/xe_pci.c
+++ b/drivers/gpu/drm/xe/tests/xe_pci.c
@@ -310,6 +310,11 @@ const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, char *desc
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_pci_id_gen_param);
 
+static void fake_init_devid(struct xe_device *xe)
+{
+	/* Nothing to do, just keep zero. */
+}
+
 static int fake_read_gmdid(struct xe_device *xe, enum xe_gmdid_type type,
 			   u32 *ver, u32 *revid)
 {
@@ -368,6 +373,7 @@ int xe_pci_fake_device_init(struct xe_device *xe)
 	xe->sriov.__mode = data && data->sriov_mode ?
 			   data->sriov_mode : XE_SRIOV_MODE_NONE;
 
+	kunit_activate_static_stub(test, init_devid, fake_init_devid);
 	kunit_activate_static_stub(test, read_gmdid, fake_read_gmdid);
 	kunit_activate_static_stub(test, xe_info_probe_tile_count,
 				   fake_xe_info_probe_tile_count);
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 9ac9e7b2dcbf..fb81b6ff29c2 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -473,8 +473,6 @@ struct xe_device *xe_device_create(struct pci_dev *pdev)
 	if (err)
 		return ERR_PTR(err);
 
-	xe->info.devid = pdev->device;
-	xe->info.revid = pdev->revision;
 	xe->atomic_svm_timeslice_ms = 5;
 	xe->min_run_period_lr_ms = 5;
 
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 5e21c1d683dc..a9df0913c688 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -723,6 +723,16 @@ static int handle_gmdid(struct xe_device *xe,
 	return 0;
 }
 
+static void init_devid(struct xe_device *xe)
+{
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+
+	KUNIT_STATIC_STUB_REDIRECT(init_devid, xe);
+
+	xe->info.devid = pdev->device;
+	xe->info.revid = pdev->revision;
+}
+
 /*
  * Initialize device info content that only depends on static driver_data
  * passed to the driver at probe time from PCI ID table.
@@ -738,6 +748,8 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.subplatform = subplatform_desc ?
 		subplatform_desc->subplatform : XE_SUBPLATFORM_NONE;
 
+	init_devid(xe);
+
 	xe->info.dma_mask_size = desc->dma_mask_size;
 	xe->info.va_bits = desc->va_bits;
 	xe->info.vm_max_level = desc->vm_max_level;
-- 
2.53.0

