Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128264F5E0
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897984; cv=none; b=HypwcCovp8FsmAlKEnA/juq57Jay7s9nIgSKkT4V7oLweRzqP7EI5iVoUyrI1xvmbjK31alLy+y5v5IzFncyDP3agRv5E97nEda+R/AYnQhO3x/ioyFN7qTU7hpGi/TUOE9icpNKDwGtPf8k0JFjZP02FevX4JTsfe4Q4zUM2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897984; c=relaxed/simple;
	bh=+AMN7FNPyBJaw+iEcB/X10HrWevVJoPdVh1xo0xnUjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiGtFJYITXE0A65NO57zAsEjZC2kLKnzkFT/Hn9aoFoBGDm2SL9x6X4vyIclIl78EAHX5dzJ8vuJvb8dsUafhcpICPiUb1AG7kyI3RF7eyAePH7E+hhijSxKtS6TZ/aUz1eCeI6DVo5xX3KD9uPvxcMd3P2dHsWgDzcFcvoA2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2seB+ls; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2seB+ls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897983; x=1817433983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+AMN7FNPyBJaw+iEcB/X10HrWevVJoPdVh1xo0xnUjg=;
  b=Z2seB+ls7Laz1PckmFGwppQGGm8UEqkrmHZ+l9/I6oklHcWSJipeR3KS
   bjz9Y0k1H9f7+xdVsTk/QUg0EmLgLAqP0Eu9MHdAk4VAl38fg9EWPo1qN
   Mx/+SuJF/dPlrtT2fB9Yorq+VpbCxG+gy0WqgE/49cwNsN7bWi6aFDaJ+
   Xgvf6odtHzsSrBCSBhy/lUW5IMazxho1eHHRqJDaOfjRFcoQWhgaS1CEi
   aUC1V35ZWKxtc8XnMX7kNaQN9huKv1VOFpf+Dms8af8/ADTnN7dHLW3Js
   FJTS3G8bcFZbWbnWUCbOGplQY5GIDhepBo+2Z7UvrdHO5x67OoBvUjUMS
   w==;
X-CSE-ConnectionGUID: X6w+XAIPS9mBYZB9uUKSWA==
X-CSE-MsgGUID: jjOg28X6SzGFjXA224i5hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85586046"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85586046"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
X-CSE-ConnectionGUID: GwuAwnZVRT+kADpk+lRTjQ==
X-CSE-MsgGUID: xAIY3OSRTYS0/Toq4ZH25A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265925512"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:46:20 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y v2 03/10] drm/xe/rtp: Maintain OA whitelists separately
Date: Tue,  4 Aug 2026 19:46:07 -0700
Message-ID: <20260805024614.3406679-4-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
References: <20260805024614.3406679-1-ashutosh.dixit@intel.com>
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
index f253e2df49077..1a4d8d4f44b4d 100644
--- a/drivers/gpu/drm/xe/xe_gt_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_debugfs.c
@@ -174,8 +174,10 @@ static int register_save_restore(struct xe_gt *gt, struct drm_printer *p)
 	drm_printf(p, "\n");
 
 	drm_printf(p, "Whitelist\n");
-	for_each_hw_engine(hwe, gt, id)
+	for_each_hw_engine(hwe, gt, id) {
 		xe_reg_whitelist_dump(&hwe->reg_whitelist, p);
+		xe_reg_whitelist_dump(&hwe->oa_whitelist, p);
+	}
 
 	xe_pm_runtime_put(gt_to_xe(gt));
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index d88770370eeb0..66a738f17a3ba 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -565,6 +565,8 @@ static void hw_engine_init_early(struct xe_gt *gt, struct xe_hw_engine *hwe,
 	hw_engine_setup_default_state(hwe);
 
 	xe_reg_sr_init(&hwe->reg_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_sr, hwe->name, gt_to_xe(gt));
 	xe_reg_whitelist_process_engine(hwe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_types.h b/drivers/gpu/drm/xe/xe_hw_engine_types.h
index e4191a7a2c318..04ca7545d22c3 100644
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
index 5cb7e0e3a66bd..6b7c90ba6d10c 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -66,6 +66,9 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(CSBE_DEBUG_STATUS(RENDER_RING_BASE), 0))
 	},
+};
+
+static const struct xe_rtp_entry_sr oa_whitelist[] = {
 
 #define WHITELIST_DENY(r, f) WHITELIST(r, (f) | RING_FORCE_TO_NONPRIV_DENY)
 
@@ -138,6 +141,9 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
 			     &hwe->reg_whitelist);
 	whitelist_apply_to_hwe(hwe);
+
+	xe_rtp_process_to_sr(&ctx, oa_whitelist, ARRAY_SIZE(oa_whitelist),
+			     &hwe->oa_whitelist);
 }
 
 /**
-- 
2.54.0

