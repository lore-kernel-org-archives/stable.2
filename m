Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282A4457DC
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513021; cv=none; b=PWPNBBO2hdk/nv0PhJTG70u4rPneKEVptR6BXdlwM4LXeiv2ArGVpGcGfZ1a49kArh75bCDzTVUS77j72jI89Rs12DK8shwxHaECDDLMj+VEw8yKUEonR0jTFcGpydhNEt5n08Hdi3e7dyZOjshICfT0TXEu/wOAku936cBVH9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513021; c=relaxed/simple;
	bh=eGHCTgqqtqSQmrpln1OdadLVxdj/jXgO8sxk7gawmPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScS9QiFkF2JuvUv8C+mzYL6dMVWZaCckWn23d/vFOp5CRrrD641L7bK8qTcNGKqlmK9mfpky1uk36Ve+E572B4QbuByfLoTikEZ7LRF35vDWKGi0qDg+Hta+6dM7rVbQRKfCDDjmS8RpjhZkQdHM7VunY1M7gh0jO3E+bpJ9hs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUc3LtZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUc3LtZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF841F00A3D;
	Fri, 31 Jul 2026 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513018;
	bh=9Xs6i/NF94IKEEuMUmBKUif1XE2bTRPHKDe7LRG7J0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oUc3LtZY1wjORqLFW3b6q6lc1bSp874O6c77dp1sIVR/U/CkB/I3iai45HqibZ+j5
	 YOGr3xnFuk4EP1aKqWEqt7Lts/EvYdx6UfO2U/+QPE3tItLq3hNirMaCri8cAFe4zU
	 1fCYhGJl+xojWwZY7gvAd4fp+U7Q8mCDp9cHQsS9AL29ASn3J94tP0o/IC1BnPtclB
	 UCW9VA/C5LOzRy9+UWd2HgLOTZ3NFmzlXeycW9fSsnq/SM2xYSk2PrP5oa7nEweN5F
	 iVFZrHll8/7F4JsJSJIYi7vX3qMmqty1tkPHzJccwnDuZ+X9YVFqh4RMapS27Je74C
	 VKU1WZtD+wi+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] drm/xe/pat: define coh_mode 2way
Date: Fri, 31 Jul 2026 11:50:14 -0400
Message-ID: <20260731155015.604147-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731155015.604147-1-sashal@kernel.org>
References: <2026051515-treble-unwieldy-f489@gregkh>
 <20260731155015.604147-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejas Upadhyay <tejas.upadhyay@intel.com>

[ Upstream commit 411389d29eab5325e2b250b1cd2ddb567abb7bbb ]

Defining 2way (two-way coherency) is critical for
Xe3p_LPG (Nova Lake P) platforms to support L2 flush
optimization safely.

This mode allows the driver to skip certain manual cache
flushes (L2 flush optimization) without risking memory
corruption because the hardware ensures the most recent
data is visible to both entities.

Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260305121902.1892593-8-tejas.upadhyay@intel.com
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Stable-dep-of: 662f9ddc8077 ("drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pat.c        | 14 +++++++-------
 drivers/gpu/drm/xe/xe_pat.h        |  5 +++--
 drivers/gpu/drm/xe/xe_vm.c         |  2 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c |  2 +-
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pat.c b/drivers/gpu/drm/xe/xe_pat.c
index 2e7cb99ae87a..5001233d83f7 100644
--- a/drivers/gpu/drm/xe/xe_pat.c
+++ b/drivers/gpu/drm/xe/xe_pat.c
@@ -61,7 +61,7 @@ struct xe_pat_ops {
 };
 
 static const struct xe_pat_table_entry xelp_pat_table[] = {
-	[0] = { XELP_PAT_WB, XE_COH_AT_LEAST_1WAY },
+	[0] = { XELP_PAT_WB, XE_COH_1WAY },
 	[1] = { XELP_PAT_WC, XE_COH_NONE },
 	[2] = { XELP_PAT_WT, XE_COH_NONE },
 	[3] = { XELP_PAT_UC, XE_COH_NONE },
@@ -71,19 +71,19 @@ static const struct xe_pat_table_entry xehpc_pat_table[] = {
 	[0] = { XELP_PAT_UC, XE_COH_NONE },
 	[1] = { XELP_PAT_WC, XE_COH_NONE },
 	[2] = { XELP_PAT_WT, XE_COH_NONE },
-	[3] = { XELP_PAT_WB, XE_COH_AT_LEAST_1WAY },
+	[3] = { XELP_PAT_WB, XE_COH_1WAY },
 	[4] = { XEHPC_PAT_CLOS(1) | XELP_PAT_WT, XE_COH_NONE },
-	[5] = { XEHPC_PAT_CLOS(1) | XELP_PAT_WB, XE_COH_AT_LEAST_1WAY },
+	[5] = { XEHPC_PAT_CLOS(1) | XELP_PAT_WB, XE_COH_1WAY },
 	[6] = { XEHPC_PAT_CLOS(2) | XELP_PAT_WT, XE_COH_NONE },
-	[7] = { XEHPC_PAT_CLOS(2) | XELP_PAT_WB, XE_COH_AT_LEAST_1WAY },
+	[7] = { XEHPC_PAT_CLOS(2) | XELP_PAT_WB, XE_COH_1WAY },
 };
 
 static const struct xe_pat_table_entry xelpg_pat_table[] = {
 	[0] = { XELPG_PAT_0_WB, XE_COH_NONE },
 	[1] = { XELPG_PAT_1_WT, XE_COH_NONE },
 	[2] = { XELPG_PAT_3_UC, XE_COH_NONE },
-	[3] = { XELPG_PAT_0_WB | XELPG_2_COH_1W, XE_COH_AT_LEAST_1WAY },
-	[4] = { XELPG_PAT_0_WB | XELPG_3_COH_2W, XE_COH_AT_LEAST_1WAY },
+	[3] = { XELPG_PAT_0_WB | XELPG_2_COH_1W, XE_COH_1WAY },
+	[4] = { XELPG_PAT_0_WB | XELPG_3_COH_2W, XE_COH_2WAY },
 };
 
 /*
@@ -115,7 +115,7 @@ static const struct xe_pat_table_entry xelpg_pat_table[] = {
 			REG_FIELD_PREP(XE2_L4_POLICY, l4_policy) | \
 			REG_FIELD_PREP(XE2_COH_MODE, __coh_mode), \
 		.coh_mode = (BUILD_BUG_ON_ZERO(__coh_mode && comp_en) || __coh_mode) ? \
-			XE_COH_AT_LEAST_1WAY : XE_COH_NONE \
+			__coh_mode : XE_COH_NONE \
 	}
 
 static const struct xe_pat_table_entry xe2_pat_table[] = {
diff --git a/drivers/gpu/drm/xe/xe_pat.h b/drivers/gpu/drm/xe/xe_pat.h
index fa0dfbe525cd..290c4b810573 100644
--- a/drivers/gpu/drm/xe/xe_pat.h
+++ b/drivers/gpu/drm/xe/xe_pat.h
@@ -26,8 +26,9 @@ struct xe_pat_table_entry {
 	/**
 	 * @coh_mode: The GPU coherency mode that @value maps to.
 	 */
-#define XE_COH_NONE          1
-#define XE_COH_AT_LEAST_1WAY 2
+#define XE_COH_NONE		1
+#define XE_COH_1WAY		2
+#define XE_COH_2WAY		3
 	u16 coh_mode;
 };
 
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 8f7b8f2da06b..b31859fec555 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3368,7 +3368,7 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 			goto free_bind_ops;
 		}
 
-		if (XE_WARN_ON(coh_mode > XE_COH_AT_LEAST_1WAY)) {
+		if (XE_WARN_ON(coh_mode > XE_COH_2WAY)) {
 			err = -EINVAL;
 			goto free_bind_ops;
 		}
diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index da306013a013..e4bcfeed2232 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -278,7 +278,7 @@ static bool madvise_args_are_sane(struct xe_device *xe, const struct drm_xe_madv
 		if (XE_IOCTL_DBG(xe, !coh_mode))
 			return false;
 
-		if (XE_WARN_ON(coh_mode > XE_COH_AT_LEAST_1WAY))
+		if (XE_WARN_ON(coh_mode > XE_COH_2WAY))
 			return false;
 
 		if (XE_IOCTL_DBG(xe, args->pat_index.pad))
-- 
2.53.0

