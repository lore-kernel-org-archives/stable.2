Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8C1E3DDE
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545140; cv=none; b=UYAdiIQbBF93xCqcFFsTouGSTn5QYAUjzaknerJM89WgcWFOQnKK+pJBOARESC7zPMYPmtDT4mneipwl63ml1v74NyMuVVJruVi4o+T4jlMhXPmN1+kWwdm8Z+x2/0TRRrLQ9OvNFTqDUpoOFN8QmPNxleSzbs0/BfZ5g8IaYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545140; c=relaxed/simple;
	bh=PuEBSzOdirG96U6SIqE+6MUYsb8mnZc1IO8WTvVWgd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSFMPQng1ASa++6PxXjyTegSDCuEHteRx7iUDoeIAEYCDofaPRz8cP8N105EyCeAbcINzv0mW/CHygPAcMWrxkhb6ULcFCEH9UsJyXU6JnAt2Hu6jJMrDRduuAGGVzWUv1IZOEhAxzhpZ6oLvqk0HBNIaCYOOs4QuK09DewlFq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF+zQlBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF+zQlBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124BF1F00ACA;
	Sat,  1 Aug 2026 00:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545128;
	bh=dQYunxbJh9vVaZRpaAI/TiiYMl0/dJygJqxQRuBsnU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gF+zQlBgTcq4pUoE8gEIalzAZK5UiVcfKFGNAvPEjJ+9TggV9iGXfyuNK5TyhHSrL
	 mue2k+vu+/gruNugnvG9i5vNRs3fwoLHQTLjk0aPCtDzdmCMtT/Hqxj8MNidUd4lqR
	 R+NohRpzETYR1RflIlaKumLaY9YMBrKZJZ5x4Jz6bjuV1JLWxygh7QLX6Vw/PBmNW5
	 pfZSB7uiphMTe90RMtenAgYhb8MgHOPLaN1db4De9ev/dJTd5XlZKrKi66DbY1DRc/
	 nldnvlBQtklL0iO1IOkvqHGmPpCxZxPfEzc/iWWpvstHMj9rJQJMk/OBXZUNFZjxP5
	 lxVHZXmYiEd/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y] drm/xe/rtp: Maintain OA whitelists separately
Date: Fri, 31 Jul 2026 20:45:26 -0400
Message-ID: <20260801004526.3662973-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072958-unmasked-acting-7c2a@gregkh>
References: <2026072958-unmasked-acting-7c2a@gregkh>
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
[ adapted RTP table from struct wrapper macro `XE_RTP_TABLE_SR()` back to plain `struct xe_rtp_entry_sr[]` array and restored the 5-arg `xe_rtp_process_to_sr()` call with `ARRAY_SIZE()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_debugfs.c      | 4 +++-
 drivers/gpu/drm/xe/xe_hw_engine.c       | 2 ++
 drivers/gpu/drm/xe/xe_hw_engine_types.h | 8 ++++++++
 drivers/gpu/drm/xe/xe_reg_whitelist.c   | 6 ++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_debugfs.c b/drivers/gpu/drm/xe/xe_gt_debugfs.c
index f45306308cd6..c38bcacb27e4 100644
--- a/drivers/gpu/drm/xe/xe_gt_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_debugfs.c
@@ -149,8 +149,10 @@ static int register_save_restore(struct xe_gt *gt, struct drm_printer *p)
 	drm_printf(p, "\n");
 
 	drm_printf(p, "Whitelist\n");
-	for_each_hw_engine(hwe, gt, id)
+	for_each_hw_engine(hwe, gt, id) {
 		xe_reg_whitelist_dump(&hwe->reg_whitelist, p);
+		xe_reg_whitelist_dump(&hwe->oa_whitelist, p);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index a7441a66e94c..b5a869c720af 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -575,6 +575,8 @@ static void hw_engine_init_early(struct xe_gt *gt, struct xe_hw_engine *hwe,
 	hw_engine_setup_default_state(hwe);
 
 	xe_reg_sr_init(&hwe->reg_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_sr, hwe->name, gt_to_xe(gt));
 	xe_reg_whitelist_process_engine(hwe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_types.h b/drivers/gpu/drm/xe/xe_hw_engine_types.h
index e4191a7a2c31..04ca7545d22c 100644
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
index 8cc313182968..089335b185d1 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -89,6 +89,9 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 			 WHITELIST(VFLSKPD,
 				   RING_FORCE_TO_NONPRIV_ACCESS_RW))
 	},
+};
+
+static const struct xe_rtp_entry_sr oa_whitelist[] = {
 
 #define WHITELIST_OA_MMIO_TRG(trg, status, head) \
 	WHITELIST(trg, RING_FORCE_TO_NONPRIV_ACCESS_RW), \
@@ -191,6 +194,9 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
 			     &hwe->reg_whitelist, false);
 	whitelist_apply_to_hwe(hwe);
+
+	xe_rtp_process_to_sr(&ctx, oa_whitelist, ARRAY_SIZE(oa_whitelist),
+			     &hwe->oa_whitelist, false);
 }
 
 /**
-- 
2.53.0

