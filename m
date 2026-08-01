Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F11371D01
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785586048; cv=none; b=TadCXdjmAf5/qEvt95dmJmbD+RBjdq8xrbV8gVkA8c6AnBy7NTlimkVmFzRlfoUFlrrWeRmHfgvTODyNSXPF9MlRtEyB6FVy+jcX4HQF/ZqlHrWVId+GBBUWWycKZaI/3wsc5xdO05QHptjd1yF3EYuKuyoH9RLKgk7FM69Uz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785586048; c=relaxed/simple;
	bh=mKF9HjLDc/TjDUHKR7MgNZpwjiO1uaCuTdTS6n0AW5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gb1juWirugjajl0XMmlSN1wT37qD3UwcLZ5V5wZGSEVZ1yfOvoAb1oSl5pIbDyiCNUdlNjphlRARHSnDbuIv72DCqSLJyRH4BMSWM+U4kiFZvAVLpLdlrBDCGw7Fw71qtaOdl/RXKa4tcrVKAcwdCgHLOeSHjn5ocruj+OCLMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTncAk9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTncAk9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672A31F00AC4;
	Sat,  1 Aug 2026 12:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785586046;
	bh=U3lkMVrVynpZiJGyP5wAXypySA7oT04b8z3ugibl3OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oTncAk9bg57Ve4Otjn28wtr2pmu5eVwviaCNBPMFSZshvtGn3HqhJDrkGqTfsKEHQ
	 fjyjhUcofcA/YN4zJ7liN52xuM6+/UL7ibI0y98PjNnrO9q89mZDLwU9XzB+BlQf0b
	 bL5iaNb1EiqFvqNBoNl748dhBd9G3LpJCryzVYVT+i9wU4el/yg12OkeB7gLhHBdx+
	 ZpWaSvpEoqlUvfWAjIiNFwTT8g4Lpj3IhYhOateY+l8ylKHpjzWh8HBVmZK2nMnyVW
	 3+hI6CM/j5jedwFvmmfrKYKNGxTluCqsCxOxJEZqTdpS8y2GZj2Ud0wR+xevsIuKrX
	 7kBTSj7vE49MA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] drm/xe/reg_sr: Do sanity check for MCR vs non-MCR
Date: Sat,  1 Aug 2026 08:07:20 -0400
Message-ID: <20260801120724.2790990-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801120724.2790990-1-sashal@kernel.org>
References: <2026072935-vicinity-override-18e2@gregkh>
 <20260801120724.2790990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Gustavo Sousa <gustavo.sousa@intel.com>

[ Upstream commit 058da4a2b164e477b02ca0562f01a9eb9e621cdd ]

The type struct xe_reg_mcr exists to ensure that the correct API is used
when handling MCR registers.  However, for the register save/restore
functionality, the RTP processing always cast the register to a struct
xe_reg and then apply_one_mmio() selects the MMIO API based on the "mcr"
field of the register instance.

This allows the developer to commit mistakes like passing a MCR register
for an RTP action for a GT where the respective register is not MCR; and
vice-versa.

To capture such scenarios, do a sanity check in xe_reg_sr_add() that,
upon an inconsistency:

- "fixes" the register type by favoring what we have in our MCR range
  tables instead of what the developer selected for the save/restore
  entry;
- raises a notice-level message to inform about the inconsistency.

Note: As a collateral of this change, we need to include MCR
initialization in xe_wa_test.c, otherwise a bunch of test cases end up
failing because xe_gt_mcr_check_reg() will always return false, meaning
that will incorrectly say that a MCR register is not MCR.

v2:
  - Downgrade messages to notice level so as not to block CI execution
    when inconsistencies are found. (Matt)
  - Add missing EXPORT_SYMBOL_IF_KUNIT() calls. (Gustavo)

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patch.msgid.link/20260514-rtp-mcr-check-v3-7-30dd47855fee@intel.com
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
Stable-dep-of: 4fe2844b0f0c ("drm/xe/rtp: Generalize whitelist_apply_to_hwe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/tests/xe_rtp_test.c | 71 +++++++++++++++++++++++---
 drivers/gpu/drm/xe/tests/xe_wa_test.c  | 10 +++-
 drivers/gpu/drm/xe/xe_gt_mcr.c         | 52 ++++++++++++++-----
 drivers/gpu/drm/xe/xe_gt_mcr.h         |  2 +
 drivers/gpu/drm/xe/xe_reg_sr.c         | 36 +++++++++++++
 5 files changed, 151 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_rtp_test.c b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
index 36a3b5420fef..28b21815e5ab 100644
--- a/drivers/gpu/drm/xe/tests/xe_rtp_test.c
+++ b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
@@ -9,24 +9,30 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_kunit_helpers.h>
 
+#include <kunit/static_stub.h>
 #include <kunit/test.h>
 
 #include "regs/xe_gt_regs.h"
 #include "regs/xe_reg_defs.h"
 #include "xe_device.h"
 #include "xe_device_types.h"
+#include "xe_gt_mcr.h"
 #include "xe_kunit_helpers.h"
 #include "xe_pci_test.h"
 #include "xe_reg_sr.h"
 #include "xe_rtp.h"
 
-#define REGULAR_REG1	XE_REG(1)
-#define REGULAR_REG2	XE_REG(2)
-#define REGULAR_REG3	XE_REG(3)
-#define MCR_REG1	XE_REG_MCR(1)
-#define MCR_REG2	XE_REG_MCR(2)
-#define MCR_REG3	XE_REG_MCR(3)
-#define MASKED_REG1	XE_REG(1, XE_REG_OPTION_MASKED)
+#define REGULAR_REG1		XE_REG(1)
+#define REGULAR_REG2		XE_REG(2)
+#define REGULAR_REG3		XE_REG(3)
+#define REGULAR_REG4		XE_REG(4)
+#define BAD_REGULAR_REG5	XE_REG(5)
+#define MCR_REG1		XE_REG_MCR(1)
+#define MCR_REG2		XE_REG_MCR(2)
+#define MCR_REG3		XE_REG_MCR(3)
+#define BAD_MCR_REG4		XE_REG_MCR(4)
+#define MCR_REG5		XE_REG_MCR(5)
+#define MASKED_REG1		XE_REG(1, XE_REG_OPTION_MASKED)
 
 #undef XE_REG_MCR
 #define XE_REG_MCR(...)     XE_REG(__VA_ARGS__, .mcr = 1)
@@ -48,6 +54,23 @@ struct rtp_test_case {
 	const struct xe_rtp_entry *entries;
 };
 
+static bool fake_xe_gt_mcr_check_reg(struct xe_gt *gt, struct xe_reg reg)
+{
+	/*
+	 * All supported platforms in this imaginary setup will always have REG4
+	 * as a non-MCR register and REG5 as MCR, meaning that BAD_MCR_REG4 and
+	 * BAD_REGULAR_REG5 represent programming errors to be captured by our
+	 * tests.
+	 */
+	if (reg.raw == BAD_REGULAR_REG5.raw)
+		return true;
+
+	if (reg.raw == BAD_MCR_REG4.raw)
+		return false;
+
+	return reg.mcr;
+}
+
 static bool match_yes(const struct xe_gt *gt, const struct xe_hw_engine *hwe)
 {
 	return true;
@@ -302,6 +325,38 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			{}
 		},
 	},
+	{
+		.name = "bad-mcr-reg-forced-to-regular",
+		.expected_reg = REGULAR_REG4,
+		.expected_set_bits = REG_BIT(0),
+		.expected_clr_bits = REG_BIT(0),
+		.expected_active = BIT(0),
+		.expected_count_sr_entries = 1,
+		.expected_sr_errors = 1,
+		.entries = (const struct xe_rtp_entry_sr[]) {
+			{ XE_RTP_NAME("bad-mcr-regular-reg"),
+			  XE_RTP_RULES(FUNC(match_yes)),
+			  XE_RTP_ACTIONS(SET(BAD_MCR_REG4, REG_BIT(0)))
+			},
+			{}
+		},
+	},
+	{
+		.name = "bad-regular-reg-forced-to-mcr",
+		.expected_reg = MCR_REG5,
+		.expected_set_bits = REG_BIT(0),
+		.expected_clr_bits = REG_BIT(0),
+		.expected_active = BIT(0),
+		.expected_count_sr_entries = 1,
+		.expected_sr_errors = 1,
+		.entries = (const struct xe_rtp_entry_sr[]) {
+			{ XE_RTP_NAME("bad-regular-reg"),
+			  XE_RTP_RULES(FUNC(match_yes)),
+			  XE_RTP_ACTIONS(SET(BAD_REGULAR_REG5, REG_BIT(0)))
+			},
+			{}
+		},
+	},
 };
 
 static void xe_rtp_process_to_sr_tests(struct kunit *test)
@@ -520,6 +575,8 @@ static int xe_rtp_test_init(struct kunit *test)
 	xe->drm.dev = dev;
 	test->priv = xe;
 
+	kunit_activate_static_stub(test, xe_gt_mcr_check_reg, fake_xe_gt_mcr_check_reg);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/tests/xe_wa_test.c b/drivers/gpu/drm/xe/tests/xe_wa_test.c
index c96d1fe34151..9e260549e2e9 100644
--- a/drivers/gpu/drm/xe/tests/xe_wa_test.c
+++ b/drivers/gpu/drm/xe/tests/xe_wa_test.c
@@ -9,6 +9,8 @@
 #include <kunit/test.h>
 
 #include "xe_device.h"
+#include "xe_gt.h"
+#include "xe_gt_mcr.h"
 #include "xe_kunit_helpers.h"
 #include "xe_pci_test.h"
 #include "xe_reg_sr.h"
@@ -95,8 +97,10 @@ static int xe_wa_test_init(struct kunit *test)
 		.graphics_step = param->step.graphics,
 		.media_step = param->step.media,
 	};
-	struct xe_device *xe;
 	struct device *dev;
+	struct xe_device *xe;
+	struct xe_gt *gt;
+	int id;
 	int ret;
 
 	dev = drm_kunit_helper_alloc_device(test);
@@ -109,6 +113,10 @@ static int xe_wa_test_init(struct kunit *test)
 	ret = xe_pci_fake_device_init(xe);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
+	/* Needed for sanitize_mcr(). */
+	for_each_gt(gt, xe, id)
+		xe_gt_mcr_init_early(gt);
+
 	if (!param->graphics_verx100)
 		xe->info.step = param->step;
 
diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mcr.c
index 6295cd639f5c..d7159f4796d4 100644
--- a/drivers/gpu/drm/xe/xe_gt_mcr.c
+++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
@@ -3,6 +3,9 @@
  * Copyright © 2022 Intel Corporation
  */
 
+#include <kunit/static_stub.h>
+#include <kunit/visibility.h>
+
 #include "xe_gt_mcr.h"
 
 #include "regs/xe_gt_regs.h"
@@ -413,25 +416,17 @@ static const struct {
  *
  * Perform early software only initialization of the MCR lock to allow
  * the synchronization on accessing the STEER_SEMAPHORE register and
- * use the xe_gt_mcr_multicast_write() function.
+ * use the xe_gt_mcr_multicast_write() function, and select the MCR
+ * ranges applicable to this GT.
  */
 void xe_gt_mcr_init_early(struct xe_gt *gt)
 {
+	struct xe_device *xe = gt_to_xe(gt);
+
 	BUILD_BUG_ON(IMPLICIT_STEERING + 1 != NUM_STEERING_TYPES);
 	BUILD_BUG_ON(ARRAY_SIZE(xe_steering_types) != NUM_STEERING_TYPES);
 
 	spin_lock_init(&gt->mcr_lock);
-}
-
-/**
- * xe_gt_mcr_init - Normal initialization of the MCR support
- * @gt: GT structure
- *
- * Perform normal initialization of the MCR for all usages.
- */
-void xe_gt_mcr_init(struct xe_gt *gt)
-{
-	struct xe_device *xe = gt_to_xe(gt);
 
 	if (IS_SRIOV_VF(xe))
 		return;
@@ -468,6 +463,19 @@ void xe_gt_mcr_init(struct xe_gt *gt)
 			gt->steering[DSS].ranges = xelp_dss_steering_table;
 		}
 	}
+}
+EXPORT_SYMBOL_IF_KUNIT(xe_gt_mcr_init_early);
+
+/**
+ * xe_gt_mcr_init - Normal initialization of the MCR support
+ * @gt: GT structure
+ *
+ * Perform normal initialization of the MCR for all usages.
+ */
+void xe_gt_mcr_init(struct xe_gt *gt)
+{
+	if (IS_SRIOV_VF(gt_to_xe(gt)))
+		return;
 
 	/* Select non-terminated steering target for each type */
 	for (int i = 0; i < NUM_STEERING_TYPES; i++)
@@ -519,6 +527,26 @@ static bool reg_in_steering_type_ranges(struct xe_gt *gt,
 	return false;
 }
 
+/*
+ * xe_gt_mcr_check_reg - check if a register is recognized by this GT as MCR
+ * @gt: GT structure
+ * @reg: The register to check
+ *
+ * Returns true if the register offset falls within one of the MMIO ranges
+ * classified as MCR for the GT.
+ */
+bool xe_gt_mcr_check_reg(struct xe_gt *gt, struct xe_reg reg)
+{
+	KUNIT_STATIC_STUB_REDIRECT(xe_gt_mcr_check_reg, gt, reg);
+
+	for (int type = 0; type <= IMPLICIT_STEERING; type++)
+		if (reg_in_steering_type_ranges(gt, reg, type))
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL_IF_KUNIT(xe_gt_mcr_check_reg);
+
 /*
  * xe_gt_mcr_get_nonterminated_steering - find group/instance values that
  *    will steer a register to a non-terminated instance
diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.h b/drivers/gpu/drm/xe/xe_gt_mcr.h
index 8d119a0d5493..fa6b856674c2 100644
--- a/drivers/gpu/drm/xe/xe_gt_mcr.h
+++ b/drivers/gpu/drm/xe/xe_gt_mcr.h
@@ -26,6 +26,8 @@ void xe_gt_mcr_unicast_write(struct xe_gt *gt, struct xe_reg_mcr mcr_reg,
 void xe_gt_mcr_multicast_write(struct xe_gt *gt, struct xe_reg_mcr mcr_reg,
 			       u32 value);
 
+bool xe_gt_mcr_check_reg(struct xe_gt *gt, struct xe_reg reg);
+
 void xe_gt_mcr_steering_dump(struct xe_gt *gt, struct drm_printer *p);
 void xe_gt_mcr_get_dss_steering(struct xe_gt *gt, unsigned int dss, u16 *group, u16 *instance);
 
diff --git a/drivers/gpu/drm/xe/xe_reg_sr.c b/drivers/gpu/drm/xe/xe_reg_sr.c
index ae9e6df2f4e1..6f18b5fb4537 100644
--- a/drivers/gpu/drm/xe/xe_reg_sr.c
+++ b/drivers/gpu/drm/xe/xe_reg_sr.c
@@ -72,14 +72,49 @@ static void reg_sr_inc_error(struct xe_reg_sr *sr)
 #endif
 }
 
+static struct xe_reg sanitize_mcr(struct xe_reg_sr *sr,
+				  const struct xe_reg_sr_entry *e,
+				  struct xe_gt *gt)
+{
+	struct xe_reg reg = e->reg;
+	bool is_mcr;
+
+	/*
+	 * We need the gt structure to check MCR ranges.
+	 */
+	if (!gt)
+		return reg;
+
+	is_mcr = xe_gt_mcr_check_reg(gt, reg);
+
+	if (is_mcr && !reg.mcr) {
+		reg.mcr = 1;
+		xe_gt_notice(gt, "xe_reg_sr_entry using non-MCR register for address 0x%x, forcing MCR\n",
+			     reg.addr);
+		reg_sr_inc_error(sr);
+	}
+
+	if (!is_mcr && reg.mcr) {
+		reg.mcr = 0;
+		xe_gt_notice(gt, "xe_reg_sr_entry using MCR register for address 0x%x, forcing non-MCR\n",
+			     reg.addr);
+		reg_sr_inc_error(sr);
+	}
+
+	return reg;
+}
+
 int xe_reg_sr_add(struct xe_reg_sr *sr,
 		  const struct xe_reg_sr_entry *e,
 		  struct xe_gt *gt)
 {
 	unsigned long idx = e->reg.addr;
 	struct xe_reg_sr_entry *pentry = xa_load(&sr->xa, idx);
+	struct xe_reg reg;
 	int ret;
 
+	reg = sanitize_mcr(sr, e, gt);
+
 	if (pentry) {
 		if (!compatible_entries(pentry, e)) {
 			ret = -EINVAL;
@@ -100,6 +135,7 @@ int xe_reg_sr_add(struct xe_reg_sr *sr,
 	}
 
 	*pentry = *e;
+	pentry->reg = reg;
 	ret = xa_err(xa_store(&sr->xa, idx, pentry, GFP_KERNEL));
 	if (ret)
 		goto fail_free;
-- 
2.53.0

