Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823E2D94BA
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247857; cv=none; b=XUBIbK67Y31kYGEVpxRptGSyfzcNIXq/rXDEeV76zGsdnLuD2mODI0q/RfNROqlj4hkuWCOCdF5m8PMfBj3HU52fUH5QlSg8MDLfDJ4D1kGFBAL9kBwlikCZn4KxZWTYt0ECN89EWCxJjXDgLZz2WoL9laQHSUKYv4OE/QaqzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247857; c=relaxed/simple;
	bh=6kwqU0zLEAgeeI/DL2ujqskXuExfGE4u6+mDD6PU7Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWQzr7MZRqoraUdRW6660uHY4PF73mqSeQ4EaRIc/UZzZYY/sUvfqTRviN887hr8sGfzinU8nYUMbSjnwgA/jXiOOS8Ep2Ouw7Oa9G99RSCZ10eJ5EuPPliSpunWnKVfwdwZN9zNX5NaeH3f5nXHM+W1ruOSRmBbh3JwI6eTBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMfki1yo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMfki1yo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781247856; x=1812783856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6kwqU0zLEAgeeI/DL2ujqskXuExfGE4u6+mDD6PU7Y0=;
  b=WMfki1yorshpcPWPJATh+ihuBUUW5D8VbhYVdNpBHMo457H2dxH2RmZJ
   CEChcPQjIvRkkg3Qf//GKiQFaSiSup9ufpwm4qag+1kuCC2wPsG5FmLwo
   YrKyE4MRCyk7+ozVjqYbQ2nvqqrGklyoRHChvHtt1APiZ2tMCIAhe8axX
   xdMtbR28lEABxWX+qg2VmaFl42AmBgrZTYUbAEq8puRxKj6ErPmRNhTNM
   T+MRlMhAdmTwHSO2eNvME0Th74GVUXNf+R+kB94ttcHEKomgD8veaoTSg
   6Qd5XWacRL71RXOaOAneGLJoyjX92w3ofq95LQOMHtijp2Y4V0M8luj3z
   g==;
X-CSE-ConnectionGUID: cfjKmZVfRKGVeRBp3C9q3w==
X-CSE-MsgGUID: dBfIwCGiQNKj4hC0VjMNMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99652370"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="99652370"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 00:04:15 -0700
X-CSE-ConnectionGUID: VuryZ3gtTRq5W3XXdBVCDA==
X-CSE-MsgGUID: Pcxr6bzGRd+7Sk/ygUqTYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="240392871"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk) ([10.190.239.37])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 00:04:14 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/guc: Fix buffer overflow in steered register list allocation
Date: Fri, 12 Jun 2026 12:34:02 +0530
Message-ID: <20260612070401.543305-2-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size calculation for the steered register extarray uses only the
geometry DSS mask (g_dss_mask) to determine the number of entries to
allocate:

  total = bitmap_weight(gt->fuse_topo.g_dss_mask, ...) * steer_reg_num;

However, the filling loop uses for_each_dss_steering(), which iterates
over for_each_dss(), defined as the union of g_dss_mask and c_dss_mask
(geometry + compute DSS). On platforms with compute-only DSS bits, the
loop writes past the allocated buffer, corrupting adjacent slab objects.

This manifests as list_del corruption and SLUB redzone overwrites during
drm_managed_release on device unbind, since the overflow corrupts the
drmres list_head of neighboring allocations.

Fix by computing the allocation size using the union of both DSS masks,
matching the iteration pattern of for_each_dss_steering().

Fixes: b170d696c1e2 ("drm/xe/guc: Add XE_LP steered register lists")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/8049
Cc: Zhanjun Dong <zhanjun.dong@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Assisted-by: GitHub Copilot:Claude Opus 4.6
--
v2:
- use bitmap_weighted_or() (Zhanjun)
---
 drivers/gpu/drm/xe/xe_guc_capture.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
index 21f7caf9ea08..1a019137ddf4 100644
--- a/drivers/gpu/drm/xe/xe_guc_capture.c
+++ b/drivers/gpu/drm/xe/xe_guc_capture.c
@@ -461,8 +461,14 @@ static void guc_capture_alloc_steered_lists(struct xe_guc *guc)
 	if (!list || guc->capture->extlists)
 		return;
 
-	total = bitmap_weight(gt->fuse_topo.g_dss_mask, sizeof(gt->fuse_topo.g_dss_mask) * 8) *
-		guc_capture_get_steer_reg_num(guc_to_xe(guc));
+	{
+		xe_dss_mask_t all_dss;
+
+		total = bitmap_weighted_or(all_dss, gt->fuse_topo.g_dss_mask,
+					   gt->fuse_topo.c_dss_mask,
+					   XE_MAX_DSS_FUSE_BITS) *
+			guc_capture_get_steer_reg_num(guc_to_xe(guc));
+	}
 
 	if (!total)
 		return;
-- 
2.52.0

