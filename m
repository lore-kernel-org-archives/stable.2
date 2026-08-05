Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD123D7DF
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898168; cv=none; b=nEhE+dgoaZaGXNZUSlSDbSrYGV1U8PHjd6l2peuKpW5rRWelSipRyk0+vIFXwSnclynX3DORwQK6RhpmnM113XR/qWNthT6kTTpaB3ZOx9FhBouOePKn0VRHOmELelDkalOaeg47yXE85Qapk38VgNlmhujXpYf0/NPReIIHjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898168; c=relaxed/simple;
	bh=0UctmTykckNrmHQ1y/alSqv0AifKi4RPj7QyKjWnODw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9ASDIXj5eR2+F0CIOf6Fi+Zg5YNTNj2cj4WkztYMy9gH9/WMG4fOuDqRoMFOKEzQea/Y6Cnka1J7SenPg+0Jvn286asD5YVADNiRn/DgtSD4lo5IqFG7iQnHsLPCjtivSfwZyLLs02W4dkZIgwUem66B7869XqV7g3NGK+Ne9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXawWSsm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXawWSsm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785898166; x=1817434166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0UctmTykckNrmHQ1y/alSqv0AifKi4RPj7QyKjWnODw=;
  b=VXawWSsmU+ZAs8T91gd2fh9YRYLjJK8HicNprLs/CiWqf+jLQWNxyBs2
   TOyijaEEEwQrNQijBSvWmthTq5R5z6k4Z74bKc0rSclJ99FfJR6kwvdc/
   q4eMto7QoBx3692yh0dkRwc8NkwrmPvANEonyru2Wv+d9thZTQ6kk+yat
   EBUgm5KGXIlZE25g9+TZayddINGwEwNZoPimUCNOPcHhcNW2V2mDT8DOs
   jT2YmwRT/ARgJr6NzJrglgiNAOXfb8AixBAJCkEB4jjR5M2h7ijTjrwRV
   bZMdVel4e8wlc32wqI6tpjYFlKJnWrbtatQaEs/yLFEuM9dTsjYQTcuu2
   A==;
X-CSE-ConnectionGUID: GzzmyuYyTheKTaCY++6Q/g==
X-CSE-MsgGUID: H745GMCFSau9HH5moymwWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97826129"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97826129"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
X-CSE-ConnectionGUID: He9tSLoTSO+NdDHwDkoIig==
X-CSE-MsgGUID: CeGXTONGQyWBKBZpX5JPjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="259911793"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:49:22 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y v2 05/12] drm/xe/rtp: Maintain OA whitelists separately
Date: Tue,  4 Aug 2026 19:49:08 -0700
Message-ID: <20260805024915.3407033-6-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
References: <20260805024915.3407033-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 31e2437561621b4867c08efc890bf629d017df03 ]

Contains minor modification of the above commit because of changed API.

OA registers are dynamically whitelisted (and again dewhitelisted) on OA
stream open/close. Maintaining OA whitelists separately from non-OA
register whitlists simplifies this management of OA register
whitelisting/dewhitelisting.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-3-ashutosh.dixit@intel.com
---
 drivers/gpu/drm/xe/xe_gt_debugfs.c      | 4 +++-
 drivers/gpu/drm/xe/xe_hw_engine.c       | 2 ++
 drivers/gpu/drm/xe/xe_hw_engine_types.h | 8 ++++++++
 drivers/gpu/drm/xe/xe_reg_whitelist.c   | 6 ++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_debugfs.c b/drivers/gpu/drm/xe/xe_gt_debugfs.c
index 8f95d3a5949bc..15ff52dfe461b 100644
--- a/drivers/gpu/drm/xe/xe_gt_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_debugfs.c
@@ -191,8 +191,10 @@ static int register_save_restore(struct xe_gt *gt, struct drm_printer *p)
 	drm_printf(p, "\n");
 
 	drm_printf(p, "Whitelist\n");
-	for_each_hw_engine(hwe, gt, id)
+	for_each_hw_engine(hwe, gt, id) {
 		xe_reg_whitelist_dump(&hwe->reg_whitelist, p);
+		xe_reg_whitelist_dump(&hwe->oa_whitelist, p);
+	}
 
 	xe_pm_runtime_put(gt_to_xe(gt));
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index ca4c2dee276bc..9f560ac9e2b8a 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -532,6 +532,8 @@ static void hw_engine_init_early(struct xe_gt *gt, struct xe_hw_engine *hwe,
 	hw_engine_setup_default_state(hwe);
 
 	xe_reg_sr_init(&hwe->reg_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_sr, hwe->name, gt_to_xe(gt));
 	xe_reg_whitelist_process_engine(hwe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_types.h b/drivers/gpu/drm/xe/xe_hw_engine_types.h
index 8be6d420ece40..ac876a8c3eec3 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_types.h
+++ b/drivers/gpu/drm/xe/xe_hw_engine_types.h
@@ -128,6 +128,14 @@ struct xe_hw_engine {
 	 * @reg_whitelist: table with registers to be whitelisted
 	 */
 	struct xe_reg_sr reg_whitelist;
+	/**
+	 * @oa_whitelist: oa registers to be whitelisted
+	 */
+	struct xe_reg_sr oa_whitelist;
+	/**
+	 * @oa_sr: oa nonpriv whitelist registers, changed on oa stream open/close
+	 */
+	struct xe_reg_sr oa_sr;
 	/**
 	 * @reg_lrc: LRC workaround registers
 	 */
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index d75bc87cb3cb1..d82b14f8d0716 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -66,6 +66,10 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(CSBE_DEBUG_STATUS(RENDER_RING_BASE), 0))
 	},
+	{}
+};
+
+static const struct xe_rtp_entry_sr oa_whitelist[] = {
 
 #define WHITELIST_DENY(r, f) WHITELIST(r, (f) | RING_FORCE_TO_NONPRIV_DENY)
 
@@ -138,6 +142,8 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_to_sr(&ctx, register_whitelist, &hwe->reg_whitelist);
 	whitelist_apply_to_hwe(hwe);
+
+	xe_rtp_process_to_sr(&ctx, oa_whitelist, &hwe->oa_whitelist);
 }
 
 /**
-- 
2.54.0

