Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC185382373
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785586063; cv=none; b=pXnVjjcsYBcCttvHOCOtiUqg7tkP9M7+8kw62EvTmsp2BEmufSBYLo+VZzGQVcbszpr1eD/IqbD3y1iRCajctsAz55JUPYzZ0XoZM7zEP6O7co3Ee7U3YgCxKh1gBhT3Qy9t2IGAY3jLAFB6jmQJJAF+ns7gcMlDkQ1RtWayKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785586063; c=relaxed/simple;
	bh=i0Iujc6740fnlK89vgP60lZwjezqMN/OVn7AEXAPAeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5eOhtH6qMhzAjfX8M0libcSkVdbxHMYQihxCPH6BiFJjmF50+G8gORHQjM8cvr02vkcBf9vMDoZ8/V4DVBoNQXvPNlTkSkf8X+chMPYHd8t8ETxKbNcPtXEfiLwglNuYLgECu8w5TM7SfOej0iUFVRmtJGS+auvh3/IgfLr+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOb0yOZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOb0yOZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22491F00AC4;
	Sat,  1 Aug 2026 12:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785586062;
	bh=lENnrbr6BCvEqY03QPDT3hcO5NgveyO5eC5j4YZlbNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mOb0yOZz5KLKJ5ShuuWgJ79iIK3fmSwsgKNovnd2rXLeBLoAW6+esOndMkonmpSy0
	 dOSgSO+I1uJIY4zbZGWgQpBsUrL6DAlAEHQqSCL5k70s/Cc4NWzlPrgSVukQAQEEU5
	 KESnJQFXHZlGv1RUr511CmCHHQmHQZGgGkRdy60xDJ49DYMzFe3ORODv+MvuMdBPCc
	 sWlVc/0+YY/HIvzmdZbQKcr3gS6oR5qVzN+YgXWppk5AhUptWn4xGtKG4LNhRDo4oM
	 uN1D/gpStOg+MYLcwY+BYf5/7L6R/3tj7REYUYy68rHgFM+SK1INufGj88Z1xda4uz
	 nXGqPB9NQifng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@nvidia.com>
Subject: [PATCH 6.12.y] drm/xe/rtp: Maintain OA whitelists separately
Date: Sat,  1 Aug 2026 08:07:40 -0400
Message-ID: <20260801120740.2791308-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072914-overstep-liable-afcd@gregkh>
References: <2026072914-overstep-liable-afcd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ashutosh Dixit <ashutosh.dixit@intel.com>

[ Upstream commit 31e2437561621b4867c08efc890bf629d017df03 ]

OA registers are dynamically whitelisted (and again dewhitelisted) on OA
stream open/close. Maintaining OA whitelists separately from non-OA
register whitlists simplifies this management of OA register
whitelisting/dewhitelisting.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-3-ashutosh.dixit@intel.com
(cherry picked from commit c478244a9e2d14b3f1f92e8bd293919e554622a5)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
[ Split `register_whitelist[]` into a second sentinel-terminated `oa_whitelist[]` array instead of upstream's `XE_RTP_TABLE_SR()` table struct, and called the 3-arg `xe_rtp_process_to_sr()` without the absent `whitelist_apply_to_hwe()` helper. ]
Signed-off-by: Sasha Levin <sashal@nvidia.com>
---
 drivers/gpu/drm/xe/xe_gt_debugfs.c      | 4 +++-
 drivers/gpu/drm/xe/xe_hw_engine.c       | 2 ++
 drivers/gpu/drm/xe/xe_hw_engine_types.h | 8 ++++++++
 drivers/gpu/drm/xe/xe_reg_whitelist.c   | 5 +++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_debugfs.c b/drivers/gpu/drm/xe/xe_gt_debugfs.c
index 8f95d3a5949b..15ff52dfe461 100644
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
index 45d0ae074e65..5eb139a662d6 100644
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
index 8be6d420ece4..ac876a8c3eec 100644
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
index 3de0a867149d..b8f1e1a91fc0 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -64,6 +64,10 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(CSBE_DEBUG_STATUS(RENDER_RING_BASE), 0))
 	},
+	{}
+};
+
+static const struct xe_rtp_entry_sr oa_whitelist[] = {
 	{ XE_RTP_NAME("oa_reg_render"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED),
 		       ENGINE_CLASS(RENDER)),
@@ -102,6 +106,7 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
 	xe_rtp_process_to_sr(&ctx, register_whitelist, &hwe->reg_whitelist);
+	xe_rtp_process_to_sr(&ctx, oa_whitelist, &hwe->oa_whitelist);
 }
 
 /**
-- 
2.53.0

