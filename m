Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F70353A84
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517023; cv=none; b=jALpK5A2Tnv+Jjilj+s44zha7DnI9SJPNlU01gRg/oib4CcTG5rPXzAkEk5A87PxTasnNN5ioIIWQKL1LcmFwCyGwV8y+hBa9FmptyTBwouxMtOpY4qrJMYeFr5KP7HQFBXyBHwRqXRPmVCdrvCOBaA9/LxktHb0aRBH6CdtE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517023; c=relaxed/simple;
	bh=uM+6w5wM0kb6Kq8BUMv8aJAMG07ajJbd2crf4fbcbcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5yWrE3FtvBLdU6ibMFA3CZGXVrOnresUBF5hjXdq0VuRhxdttQRcEUo3xda5EesfnE3rUxKiUQbPvspUmMQLbgoVyMdmB1uRwyKR/LSIYXC1btyKo8vg4bWktfDsvA630CTqMRyvcyNRSxRqIeyFho+jC9SNbK1O+4Nn5/x0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJkc/CGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJkc/CGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51421F00ACA;
	Fri, 31 Jul 2026 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517021;
	bh=xVBCzUxsDfgGocL6zKCuZ6ZX2D802mb+YluxBzs4Fjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJkc/CGbGD//Kadnk8zVkcCdfYULhf9ydoDeioBYK9w57KzCmByBzS7lPj8RQvW0+
	 GTRD04e/m7Ez/ERIF+sAN36Fbjag756Usd3NIdcVRgbufNn6lBHaRmBKz8AfgQYQ8C
	 6ymB3yNLk3XjUtt0OcqNWDMbfk3zA2qzi/DWOv3b+BzVGesV2Jga+197VinrjkE83R
	 CuQFctrwA6oPEOzPX+dHEz4kCgxL+8abMBHreDX9uoYKGyDYCI1L94U4fD6r/z1Vi/
	 XsqOddlmv8Cn4BH6Mp+g3dRwvqqHnW14xkJxoZYUtotnNhn/cRJvGaZTyuCRqmXMDx
	 8KGXWYj40Pztw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/5] drm/xe: Move xe->info.force_execlist initialization
Date: Fri, 31 Jul 2026 12:56:55 -0400
Message-ID: <20260731165658.883265-2-sashal@kernel.org>
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

[ Upstream commit f1d581bb50ed54b71a8121d3d46fe2627fddd147 ]

The xe_info_init_early() is a place where we initialize those of
the xe->info fields that do not require any additional hardware
probes. Move the initialization of the force_execlist flag there.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patch.msgid.link/20260526195452.20545-4-michal.wajdeczko@intel.com
Stable-dep-of: ba7fd1634228 ("drm/xe: Set TTM device beneficial_order to 9 (2M)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device.c | 1 -
 drivers/gpu/drm/xe/xe_pci.c    | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 688516d0b651..9ac9e7b2dcbf 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -475,7 +475,6 @@ struct xe_device *xe_device_create(struct pci_dev *pdev)
 
 	xe->info.devid = pdev->device;
 	xe->info.revid = pdev->revision;
-	xe->info.force_execlist = xe_modparam.force_execlist;
 	xe->atomic_svm_timeslice_ms = 5;
 	xe->min_run_period_lr_ms = 5;
 
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index b1ca4e711db0..5e21c1d683dc 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -774,6 +774,7 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.probe_display = IS_ENABLED(CONFIG_DRM_XE_DISPLAY) &&
 				 xe_modparam.probe_display &&
 				 desc->has_display;
+	xe->info.force_execlist = xe_modparam.force_execlist;
 
 	xe_assert(xe, desc->max_gt_per_tile > 0);
 	xe_assert(xe, desc->max_gt_per_tile <= XE_MAX_GT_PER_TILE);
-- 
2.53.0

