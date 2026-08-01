Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDD639C017
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553858; cv=none; b=GgcUNt4J+rRpq3h6YvSKnm0Udfbw4zr6eqKBvpAuk2C7EdcR8zSOUY0/CV/PiKAkp2/HJlyvFwC8wdeZsGiO2YptNgzoHep6huhxAPdkdelD9DbZSAWHWdQaEyGbXdQmje5fYgedA5qzFi1PO+SsigWmEECeJ+FrbLUTH8dnZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553858; c=relaxed/simple;
	bh=WJ73DUqmgxGRywcIHNfaKE/8zZHRydFRgGkSFFUtUY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0CHdl1vdUFnEloXFDSyP1X0BkT/uSmX+keZ8SvNpzK/YWrzrrXjcSuIRpnfFcn4G0ChZtbBrFuItV2UJrC5WvOQYiok3wwrTB1MAJaYF3MpaC+PNtqSDpnP4mX4a09fYNn+Ty+1Kj/DYCglxdpAaw4KsJ+Yhr38JO189+5xjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg72efTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg72efTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F281F00ACA;
	Sat,  1 Aug 2026 03:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553856;
	bh=QE6GdaOMq1zibL6mK+YB63KkiL8AkWitN6fJVz40+fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tg72efTTN7xZ2zT6JPuv67E123exMvDjOfd3WdSrGbpl0DB6u/9IIumm4Ujzg9Hav
	 rSFz6kH5gVBtaClo67M4UGs4PaXQNK5kbYt7ZnebqlLdWMyMapw6sEv0cYAF6Z5Bx4
	 CCM4QZ6H65FV52MIa/iaGaNOVFY5IkYU2WNekwSxhxig2Z07wHDChxQgvfHIJQeYxB
	 P5q7n1a7c7iKC/bRiYayuHYTK7V+PeGwHTZMJxnxWgLn6QWemFNDLsDLX0HidKqmZB
	 CnRTIWnzmV5skEBJON+E11FfhED397Etd2cRhzAit59943O+aXjmykstp9ssRPt+gA
	 8RXmROd/rGuKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	kernel test robot <lkp@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/8] drm/xe/rtp: Drop sentinels from arg to xe_rtp_process_to_sr()
Date: Fri, 31 Jul 2026 23:10:47 -0400
Message-ID: <20260801031050.987390-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801031050.987390-1-sashal@kernel.org>
References: <2026072902-purity-frenzy-fc0b@gregkh>
 <20260801031050.987390-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas De Marchi <lucas.demarchi@intel.com>

[ Upstream commit cedf23842d7433eb32cb782a637bb870fb096a3b ]

There's a mismatch on API: while xe_rtp_process_to_sr() processes
entries until an entry without name, the active tracking with
xe_rtp_process_ctx_enable_active_tracking() needs to use the number of
elements. The number of elements is taken everywhere using ARRAY_SIZE(),
but that will have one entry too many. This leads to the following
warning, as reported by lkp:

   drivers/gpu/drm/xe/xe_tuning.c: In function 'xe_tuning_dump':
>> include/drm/drm_print.h:228:31: warning: '%s' directive argument is null [-Wformat-overflow=]
     228 |         drm_printf((printer), "%.*s" fmt, (indent), "\t\t\t\t\tX", ##__VA_ARGS__)
         |                               ^~~~~~
   drivers/gpu/drm/xe/xe_tuning.c:226:17: note: in expansion of macro 'drm_printf_indent'
     226 |                 drm_printf_indent(p, 1, "%s\n", engine_tunings[idx].name);
         |                 ^~~~~~~~~~~~~~~~~

That's because it will still process the last entry when tracking the
active tunings. The same issue exists in the WAs. Change
xe_rtp_process_to_sr() to also take the number of elements so the empty
entry can be removed and the warning should go away. Fixing on the
active-tracking side would more fragile as the it would need a `- 1`
everywhere and continue to use a different approach for number of
elements.

Aside from the warning, it's a non-issue as there would always be enough
bits allocated and the last entry would never be active since
xe_rtp_process_to_sr() stops on the sentinel.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503021906.P2MwAvyK-lkp@intel.com/
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250306-fix-print-warning-v1-1-979c3dc03c0d@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 8aa8c2d4214e1771c32101d70740002662d31bb7)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Stable-dep-of: e70086a3a06d ("drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/tests/xe_rtp_test.c |  2 +-
 drivers/gpu/drm/xe/xe_hw_engine.c      |  6 ++----
 drivers/gpu/drm/xe/xe_reg_whitelist.c  |  4 ++--
 drivers/gpu/drm/xe/xe_rtp.c            |  6 +++++-
 drivers/gpu/drm/xe/xe_rtp.h            |  2 +-
 drivers/gpu/drm/xe/xe_tuning.c         | 12 ++++--------
 drivers/gpu/drm/xe/xe_wa.c             | 12 +++---------
 7 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_rtp_test.c b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
index 36a3b5420fef..b0254b014fe4 100644
--- a/drivers/gpu/drm/xe/tests/xe_rtp_test.c
+++ b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
@@ -320,7 +320,7 @@ static void xe_rtp_process_to_sr_tests(struct kunit *test)
 		count_rtp_entries++;
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, &active, count_rtp_entries);
-	xe_rtp_process_to_sr(&ctx, param->entries, reg_sr);
+	xe_rtp_process_to_sr(&ctx, param->entries, count_rtp_entries, reg_sr);
 
 	xa_for_each(&reg_sr->xa, idx, sre) {
 		if (idx == param->expected_reg.addr)
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index ca4c2dee276b..5a7ebbf03c2c 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -389,10 +389,9 @@ xe_hw_engine_setup_default_lrc_state(struct xe_hw_engine *hwe)
 					   PREEMPT_GPGPU_THREAD_GROUP_LEVEL)),
 		  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE)
 		},
-		{}
 	};
 
-	xe_rtp_process_to_sr(&ctx, lrc_setup, &hwe->reg_lrc);
+	xe_rtp_process_to_sr(&ctx, lrc_setup, ARRAY_SIZE(lrc_setup), &hwe->reg_lrc);
 }
 
 static void
@@ -454,10 +453,9 @@ hw_engine_setup_default_state(struct xe_hw_engine *hwe)
 		  XE_RTP_ACTIONS(FIELD_SET(RCU_MODE, RCU_MODE_FIXED_SLICE_CCS_MODE,
 					   RCU_MODE_FIXED_SLICE_CCS_MODE))
 		},
-		{}
 	};
 
-	xe_rtp_process_to_sr(&ctx, engine_entries, &hwe->reg_sr);
+	xe_rtp_process_to_sr(&ctx, engine_entries, ARRAY_SIZE(engine_entries), &hwe->reg_sr);
 }
 
 static void hw_engine_init_early(struct xe_gt *gt, struct xe_hw_engine *hwe,
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 30bef5c7c300..57c6d39b2f1e 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -88,7 +88,6 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 				   RING_FORCE_TO_NONPRIV_ACCESS_RD |
 				   RING_FORCE_TO_NONPRIV_RANGE_4))
 	},
-	{}
 };
 
 static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
@@ -137,7 +136,8 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
-	xe_rtp_process_to_sr(&ctx, register_whitelist, &hwe->reg_whitelist);
+	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
+			     &hwe->reg_whitelist);
 	whitelist_apply_to_hwe(hwe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
index 86c705d18c0d..9b0cf7871604 100644
--- a/drivers/gpu/drm/xe/xe_rtp.c
+++ b/drivers/gpu/drm/xe/xe_rtp.c
@@ -237,6 +237,7 @@ static void rtp_mark_active(struct xe_device *xe,
  *                        the save-restore argument.
  * @ctx: The context for processing the table, with one of device, gt or hwe
  * @entries: Table with RTP definitions
+ * @n_entries: Number of entries to process, usually ARRAY_SIZE(entries)
  * @sr: Save-restore struct where matching rules execute the action. This can be
  *      viewed as the "coalesced view" of multiple the tables. The bits for each
  *      register set are expected not to collide with previously added entries
@@ -247,6 +248,7 @@ static void rtp_mark_active(struct xe_device *xe,
  */
 void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
 			  const struct xe_rtp_entry_sr *entries,
+			  size_t n_entries,
 			  struct xe_reg_sr *sr)
 {
 	const struct xe_rtp_entry_sr *entry;
@@ -259,7 +261,9 @@ void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
 	if (IS_SRIOV_VF(xe))
 		return;
 
-	for (entry = entries; entry && entry->name; entry++) {
+	xe_assert(xe, entries);
+
+	for (entry = entries; entry - entries < n_entries; entry++) {
 		bool match = false;
 
 		if (entry->flags & XE_RTP_ENTRY_FLAG_FOREACH_ENGINE) {
diff --git a/drivers/gpu/drm/xe/xe_rtp.h b/drivers/gpu/drm/xe/xe_rtp.h
index 827d932b6908..064260cfe91b 100644
--- a/drivers/gpu/drm/xe/xe_rtp.h
+++ b/drivers/gpu/drm/xe/xe_rtp.h
@@ -430,7 +430,7 @@ void xe_rtp_process_ctx_enable_active_tracking(struct xe_rtp_process_ctx *ctx,
 
 void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
 			  const struct xe_rtp_entry_sr *entries,
-			  struct xe_reg_sr *sr);
+			  size_t n_entries, struct xe_reg_sr *sr);
 
 void xe_rtp_process(struct xe_rtp_process_ctx *ctx,
 		    const struct xe_rtp_entry *entries);
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index 1fb12da21c9e..42c87babaabe 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -83,8 +83,6 @@ static const struct xe_rtp_entry_sr gt_tunings[] = {
 	  XE_RTP_RULES(MEDIA_VERSION(2000)),
 	  XE_RTP_ACTIONS(SET(XE2LPM_SCRATCH3_LBCF, RWFLUSHALLEN))
 	},
-
-	{}
 };
 
 static const struct xe_rtp_entry_sr engine_tunings[] = {
@@ -93,7 +91,6 @@ static const struct xe_rtp_entry_sr engine_tunings[] = {
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(SET(SAMPLER_MODE, INDIRECT_STATE_BASE_ADDR_OVERRIDE))
 	},
-	{}
 };
 
 static const struct xe_rtp_entry_sr lrc_tunings[] = {
@@ -131,15 +128,13 @@ static const struct xe_rtp_entry_sr lrc_tunings[] = {
 	  XE_RTP_ACTIONS(FIELD_SET(FF_MODE, VS_HIT_MAX_VALUE_MASK,
 				   REG_FIELD_PREP(VS_HIT_MAX_VALUE_MASK, 0x3f)))
 	},
-
-	{}
 };
 
 void xe_tuning_process_gt(struct xe_gt *gt)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(gt);
 
-	xe_rtp_process_to_sr(&ctx, gt_tunings, &gt->reg_sr);
+	xe_rtp_process_to_sr(&ctx, gt_tunings, ARRAY_SIZE(gt_tunings), &gt->reg_sr);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_tuning_process_gt);
 
@@ -147,7 +142,8 @@ void xe_tuning_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
-	xe_rtp_process_to_sr(&ctx, engine_tunings, &hwe->reg_sr);
+	xe_rtp_process_to_sr(&ctx, engine_tunings, ARRAY_SIZE(engine_tunings),
+			     &hwe->reg_sr);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_tuning_process_engine);
 
@@ -163,5 +159,5 @@ void xe_tuning_process_lrc(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
-	xe_rtp_process_to_sr(&ctx, lrc_tunings, &hwe->reg_lrc);
+	xe_rtp_process_to_sr(&ctx, lrc_tunings, ARRAY_SIZE(lrc_tunings), &hwe->reg_lrc);
 }
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index 6fd8a41aefac..b8e6db930e82 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -278,8 +278,6 @@ static const struct xe_rtp_entry_sr gt_was[] = {
 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F10(0), RAMDFTUNIT_CLKGATE_DIS)),
 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
 	},
-
-	{}
 };
 
 static const struct xe_rtp_entry_sr engine_was[] = {
@@ -605,8 +603,6 @@ static const struct xe_rtp_entry_sr engine_was[] = {
 		       FUNC(xe_rtp_match_first_render_or_compute)),
 	  XE_RTP_ACTIONS(SET(TDL_TSL_CHICKEN, RES_CHK_SPR_DIS))
 	},
-
-	{}
 };
 
 static const struct xe_rtp_entry_sr lrc_was[] = {
@@ -815,8 +811,6 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
 			     DIS_PARTIAL_AUTOSTRIP |
 			     DIS_AUTOSTRIP))
 	},
-
-	{}
 };
 
 static __maybe_unused const struct xe_rtp_entry oob_was[] = {
@@ -858,7 +852,7 @@ void xe_wa_process_gt(struct xe_gt *gt)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, gt->wa_active.gt,
 						  ARRAY_SIZE(gt_was));
-	xe_rtp_process_to_sr(&ctx, gt_was, &gt->reg_sr);
+	xe_rtp_process_to_sr(&ctx, gt_was, ARRAY_SIZE(gt_was), &gt->reg_sr);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_wa_process_gt);
 
@@ -876,7 +870,7 @@ void xe_wa_process_engine(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.engine,
 						  ARRAY_SIZE(engine_was));
-	xe_rtp_process_to_sr(&ctx, engine_was, &hwe->reg_sr);
+	xe_rtp_process_to_sr(&ctx, engine_was, ARRAY_SIZE(engine_was), &hwe->reg_sr);
 }
 
 /**
@@ -893,7 +887,7 @@ void xe_wa_process_lrc(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.lrc,
 						  ARRAY_SIZE(lrc_was));
-	xe_rtp_process_to_sr(&ctx, lrc_was, &hwe->reg_lrc);
+	xe_rtp_process_to_sr(&ctx, lrc_was, ARRAY_SIZE(lrc_was), &hwe->reg_lrc);
 }
 
 /**
-- 
2.53.0

