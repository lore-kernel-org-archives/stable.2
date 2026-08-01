Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEE3264CE
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553421; cv=none; b=AuMvK+Dw69ph1q6pim6NoqpbuZD7JV03oL/0mDkLZRTUrs59gji1HOZ/kXOWmEvtmzWso2W27//8O0e1HVuMrmiByEdQMpbJk3fWutwT6ajNBt1DK5lkpmgIfVR+sqgoOFmZvXPSiDGsbkqgG4scD6FhAQB3XA6wl8Iy6BpNAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553421; c=relaxed/simple;
	bh=s+3TQat45AZ9Q3hGaOoyrQZBqT/7bjd4j/9L3ddkgMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpl+RodjJlYZ6Lv0Af/u8d8aznVOBHg6FGYvpRyhFcdbYfgxK+RrMKlqaDekRdkjuV44Ird7HbVVngGTmQGJR/U8eoZvJ/1fcR9OPKNJvov8MMLDTzkptQXV9kYcpY07l0xmOJ0ltf4m/0O8Ey5naYc8oqgU6iJT74hWxyFHTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxuBIupx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxuBIupx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049DA1F00ACA;
	Sat,  1 Aug 2026 03:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553418;
	bh=rdOZuuIKtYvp0BcwGCqScJLwZQnsQ/5KI3sIlmuBN/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxuBIupxEGofJ3dy+xreQNdcmqQqOrcbvyP4/E1j0t8naemyNNXu5c4A9KTeUMeiL
	 G0rjgTx4sOHO0s4KD3F87zUCPBk3GkKuom/1jAHTgD6kGuf17Ps5/Hgk4faXjqSO3j
	 SbzP1rGD9rlsJqLzBNcHSg4fTT0xmHYzXXfkTXXRbz7dEohlCt8M9pYlwvraJhzFel
	 nweybY9VpKCwP9QqKCA6+hwnM5w/qlzQrqS54jZTlhAOAaS/jHa4sZjuvgkBb7PZLA
	 u4lz/SEhJJxDyjxPTrLjOlViywEj62sjRl0yIw3iwMvWJrD27i2lqbL2UHexMmG5bZ
	 vKfXgO1+m7i8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Violet Monti <violet.monti@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/6] drm/xe/rtp: Add struct types for RTP tables
Date: Fri, 31 Jul 2026 23:03:29 -0400
Message-ID: <20260801030332.859236-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801030332.859236-1-sashal@kernel.org>
References: <2026072913-snap-snuff-32d6@gregkh>
 <20260801030332.859236-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Gustavo Sousa <gustavo.sousa@intel.com>

[ Upstream commit e23fafb8594ea886ee03e005cc32dfda24f417cf ]

We currently have a mixture of styles for our RTP tables with respect of
how we define the number of entries:

  * xe_rtp_process_to_sr() expects to receive the number of entries as
    arguments;
  * xe_rtp_process() expects the array to have a sentinel at the end of
    the array;
  * in xe_rtp_test.c, even though xe_rtp_process_to_sr() does not
    require a sentinel value, we need to rely on that technique to be
    able to count xe_rtp_entry_sr entries because simply using
    ARRAY_SIZE() is not possible.

The style used by xe_rtp_process_to_sr() makes it hard to share the
tables with other compilation units (e.g. kunit tests), since the number
of entries is calculated with ARRAY_SIZE(), which is done at compile
time.

Since we use the size of the tables to create some bitmasks, using a
sentinel style doesn't seem great either.

A way to reconcile things into a single style is to have a struct type
that would hold the entries array and the number of entries.  Since we
have xe_rtp_entry and xe_rtp_entry_sr, we would have one type for each.

The advantage of the proposed approach is that now we have a nice way to
share the tables directly to kunit tests with information about their
size.

v6:
    - Removed sentinels that are not needed

v5:
    - Removed added code from conflict resolution issues

v4:
    - Removed conflicts with main branch

v3:
    - No changes

v2:
    - Add compatibility with new xe_rtp_table_sr format for
      "bad-mcr-reg-forced-to-regular" and
      "bad-regular-reg-forced-to-mcr"

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
Signed-off-by: Violet Monti <violet.monti@intel.com>
Link: https://patch.msgid.link/20260601200947.2032784-7-violet.monti@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
(cherry picked from commit 5ff004fdc7377905f2fe5264b8829d35e14608b8)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Stable-dep-of: 31e243756162 ("drm/xe/rtp: Maintain OA whitelists separately")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/tests/xe_rtp_test.c | 102 ++++++++++---------------
 drivers/gpu/drm/xe/xe_hw_engine.c      |  12 +--
 drivers/gpu/drm/xe/xe_reg_whitelist.c  |   7 +-
 drivers/gpu/drm/xe/xe_rtp.c            |  45 ++++++-----
 drivers/gpu/drm/xe/xe_rtp.h            |  17 ++++-
 drivers/gpu/drm/xe/xe_rtp_types.h      |  10 +++
 drivers/gpu/drm/xe/xe_tuning.c         |  43 +++++------
 drivers/gpu/drm/xe/xe_wa.c             |  86 +++++++++++----------
 8 files changed, 167 insertions(+), 155 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_rtp_test.c b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
index 61b75ca0db66..d6a7e51901bb 100644
--- a/drivers/gpu/drm/xe/tests/xe_rtp_test.c
+++ b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
@@ -45,13 +45,13 @@ struct rtp_to_sr_test_case {
 	unsigned long expected_count_sr_entries;
 	unsigned int expected_sr_errors;
 	unsigned long expected_active;
-	const struct xe_rtp_entry_sr *entries;
+	const struct xe_rtp_table_sr table;
 };
 
 struct rtp_test_case {
 	const char *name;
 	unsigned long expected_active;
-	const struct xe_rtp_entry *entries;
+	const struct xe_rtp_table table;
 };
 
 static bool fake_xe_gt_mcr_check_reg(struct xe_gt *gt, struct xe_reg reg)
@@ -90,7 +90,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1),
 		.expected_count_sr_entries = 1,
 		/* Different bits on the same register: create a single entry */
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -99,8 +99,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(1)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "no-match-no-add",
@@ -110,7 +109,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0),
 		.expected_count_sr_entries = 1,
 		/* Don't coalesce second entry since rules don't match */
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -119,8 +118,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_no)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(1)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "two-regs-two-entries",
@@ -130,7 +128,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1),
 		.expected_count_sr_entries = 2,
 		/* Same bits on different registers are not coalesced */
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -139,8 +137,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG2, REG_BIT(0)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "clr-one-set-other",
@@ -150,7 +147,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1),
 		.expected_count_sr_entries = 1,
 		/* Check clr vs set actions on different bits */
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -159,8 +156,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(CLR(REGULAR_REG1, REG_BIT(1)))
 			},
-			{}
-		},
+		),
 	},
 	{
 #define TEMP_MASK	REG_GENMASK(10, 8)
@@ -172,14 +168,13 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0),
 		.expected_count_sr_entries = 1,
 		/* Check FIELD_SET works */
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(FIELD_SET(REGULAR_REG1,
 						   TEMP_MASK, TEMP_FIELD))
 			},
-			{}
-		},
+		),
 #undef TEMP_MASK
 #undef TEMP_FIELD
 	},
@@ -191,7 +186,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1),
 		.expected_count_sr_entries = 1,
 		.expected_sr_errors = 1,
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -201,8 +196,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "conflict-not-disjoint",
@@ -212,7 +206,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1),
 		.expected_count_sr_entries = 1,
 		.expected_sr_errors = 1,
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -222,8 +216,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(CLR(REGULAR_REG1, REG_GENMASK(1, 0)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "conflict-reg-type",
@@ -233,7 +226,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1) | BIT(2),
 		.expected_count_sr_entries = 1,
 		.expected_sr_errors = 2,
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -248,8 +241,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(MASKED_REG1, REG_BIT(0)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "bad-mcr-reg-forced-to-regular",
@@ -259,13 +251,12 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0),
 		.expected_count_sr_entries = 1,
 		.expected_sr_errors = 1,
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("bad-mcr-regular-reg"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(BAD_MCR_REG4, REG_BIT(0)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "bad-regular-reg-forced-to-mcr",
@@ -275,13 +266,12 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0),
 		.expected_count_sr_entries = 1,
 		.expected_sr_errors = 1,
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("bad-regular-reg"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(BAD_REGULAR_REG5, REG_BIT(0)))
 			},
-			{}
-		},
+		),
 	},
 };
 
@@ -293,15 +283,12 @@ static void xe_rtp_process_to_sr_tests(struct kunit *test)
 	struct xe_reg_sr *reg_sr = &gt->reg_sr;
 	const struct xe_reg_sr_entry *sre, *sr_entry = NULL;
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(gt);
-	unsigned long idx, count_sr_entries = 0, count_rtp_entries = 0, active = 0;
+	unsigned long idx, count_sr_entries = 0, active = 0;
 
 	xe_reg_sr_init(reg_sr, "xe_rtp_to_sr_tests", xe);
 
-	while (param->entries[count_rtp_entries].rules)
-		count_rtp_entries++;
-
-	xe_rtp_process_ctx_enable_active_tracking(&ctx, &active, count_rtp_entries);
-	xe_rtp_process_to_sr(&ctx, param->entries, count_rtp_entries, reg_sr);
+	xe_rtp_process_ctx_enable_active_tracking(&ctx, &active, param->table.n_entries);
+	xe_rtp_process_to_sr(&ctx, &param->table, reg_sr, false);
 
 	xa_for_each(&reg_sr->xa, idx, sre) {
 		if (idx == param->expected_reg.addr)
@@ -334,56 +321,52 @@ static const struct rtp_test_case rtp_cases[] = {
 	{
 		.name = "active1",
 		.expected_active = BIT(0),
-		.entries = (const struct xe_rtp_entry[]) {
+		.table = XE_RTP_TABLE(
 			{ XE_RTP_NAME("r1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "active2",
 		.expected_active = BIT(0) | BIT(1),
-		.entries = (const struct xe_rtp_entry[]) {
+		.table = XE_RTP_TABLE(
 			{ XE_RTP_NAME("r1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			},
 			{ XE_RTP_NAME("r2"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "active-inactive",
 		.expected_active = BIT(0),
-		.entries = (const struct xe_rtp_entry[]) {
+		.table = XE_RTP_TABLE(
 			{ XE_RTP_NAME("r1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			},
 			{ XE_RTP_NAME("r2"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "inactive-active",
 		.expected_active = BIT(1),
-		.entries = (const struct xe_rtp_entry[]) {
+		.table = XE_RTP_TABLE(
 			{ XE_RTP_NAME("r1"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
 			{ XE_RTP_NAME("r2"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "inactive-active-inactive",
 		.expected_active = BIT(1),
-		.entries = (const struct xe_rtp_entry[]) {
+		.table = XE_RTP_TABLE(
 			{ XE_RTP_NAME("r1"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
@@ -393,13 +376,12 @@ static const struct rtp_test_case rtp_cases[] = {
 			{ XE_RTP_NAME("r3"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "inactive-inactive-inactive",
 		.expected_active = 0,
-		.entries = (const struct xe_rtp_entry[]) {
+		.table = XE_RTP_TABLE(
 			{ XE_RTP_NAME("r1"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
@@ -409,8 +391,7 @@ static const struct rtp_test_case rtp_cases[] = {
 			{ XE_RTP_NAME("r3"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
-			{}
-		},
+		),
 	},
 };
 
@@ -420,13 +401,10 @@ static void xe_rtp_process_tests(struct kunit *test)
 	struct xe_device *xe = test->priv;
 	struct xe_gt *gt = xe_device_get_root_tile(xe)->primary_gt;
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(gt);
-	unsigned long count_rtp_entries = 0, active = 0;
-
-	while (param->entries[count_rtp_entries].rules)
-		count_rtp_entries++;
+	unsigned long active = 0;
 
-	xe_rtp_process_ctx_enable_active_tracking(&ctx, &active, count_rtp_entries);
-	xe_rtp_process(&ctx, param->entries);
+	xe_rtp_process_ctx_enable_active_tracking(&ctx, &active, param->table.n_entries);
+	xe_rtp_process(&ctx, &param->table);
 
 	KUNIT_EXPECT_EQ(test, active, param->expected_active);
 }
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index d88770370eeb..e5241bf3024c 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -375,7 +375,7 @@ xe_hw_engine_setup_default_lrc_state(struct xe_hw_engine *hwe)
 	u32 blit_cctl_val = REG_FIELD_PREP(BLIT_CCTL_DST_MOCS_MASK, mocs_write_idx) |
 			    REG_FIELD_PREP(BLIT_CCTL_SRC_MOCS_MASK, mocs_read_idx);
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
-	const struct xe_rtp_entry_sr lrc_setup[] = {
+	const struct xe_rtp_table_sr lrc_setup = XE_RTP_TABLE_SR(
 		/*
 		 * Some blitter commands do not have a field for MOCS, those
 		 * commands will use MOCS index pointed by BLIT_CCTL.
@@ -398,9 +398,9 @@ xe_hw_engine_setup_default_lrc_state(struct xe_hw_engine *hwe)
 					   PREEMPT_GPGPU_THREAD_GROUP_LEVEL)),
 		  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE)
 		},
-	};
+	);
 
-	xe_rtp_process_to_sr(&ctx, lrc_setup, ARRAY_SIZE(lrc_setup), &hwe->reg_lrc);
+	xe_rtp_process_to_sr(&ctx, &lrc_setup, &hwe->reg_lrc, true);
 }
 
 static void
@@ -425,7 +425,7 @@ hw_engine_setup_default_state(struct xe_hw_engine *hwe)
 	u32 ring_cmd_cctl_val = REG_FIELD_PREP(CMD_CCTL_WRITE_OVERRIDE_MASK, mocs_write_idx) |
 				REG_FIELD_PREP(CMD_CCTL_READ_OVERRIDE_MASK, mocs_read_idx);
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
-	const struct xe_rtp_entry_sr engine_entries[] = {
+	const struct xe_rtp_table_sr engine_sr = XE_RTP_TABLE_SR(
 		{ XE_RTP_NAME("RING_CMD_CCTL_default_MOCS"),
 		  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED)),
 		  XE_RTP_ACTIONS(FIELD_SET(RING_CMD_CCTL(0),
@@ -462,9 +462,9 @@ hw_engine_setup_default_state(struct xe_hw_engine *hwe)
 		  XE_RTP_ACTIONS(FIELD_SET(RCU_MODE, RCU_MODE_FIXED_SLICE_CCS_MODE,
 					   RCU_MODE_FIXED_SLICE_CCS_MODE))
 		},
-	};
+	);
 
-	xe_rtp_process_to_sr(&ctx, engine_entries, ARRAY_SIZE(engine_entries), &hwe->reg_sr);
+	xe_rtp_process_to_sr(&ctx, &engine_sr, &hwe->reg_sr, false);
 }
 
 static const struct engine_info *find_engine_info(enum xe_engine_class class, int instance)
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 21763dc51150..7c37d20b0970 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -25,7 +25,7 @@ static bool match_not_render(const struct xe_gt *gt,
 	return hwe->class != XE_ENGINE_CLASS_RENDER;
 }
 
-static const struct xe_rtp_entry_sr register_whitelist[] = {
+static const struct xe_rtp_table_sr register_whitelist = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("WaAllowPMDepthAndInvocationCountAccessFromUMD, 1408556865"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210), ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(PS_INVOCATION_COUNT,
@@ -88,7 +88,7 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 				   RING_FORCE_TO_NONPRIV_ACCESS_RD |
 				   RING_FORCE_TO_NONPRIV_RANGE_4))
 	},
-};
+);
 
 static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 {
@@ -136,8 +136,7 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
-	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
-			     &hwe->reg_whitelist);
+	xe_rtp_process_to_sr(&ctx, &register_whitelist, &hwe->reg_whitelist, false);
 	whitelist_apply_to_hwe(hwe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
index b5f430d59f80..bb71f839832d 100644
--- a/drivers/gpu/drm/xe/xe_rtp.c
+++ b/drivers/gpu/drm/xe/xe_rtp.c
@@ -269,31 +269,35 @@ static void rtp_mark_active(struct xe_device *xe,
  * xe_rtp_process_to_sr - Process all rtp @entries, adding the matching ones to
  *                        the save-restore argument.
  * @ctx: The context for processing the table, with one of device, gt or hwe
- * @entries: Table with RTP definitions
- * @n_entries: Number of entries to process, usually ARRAY_SIZE(entries)
+ * @table: Table with RTP definitions
  * @sr: Save-restore struct where matching rules execute the action. This can be
  *      viewed as the "coalesced view" of multiple the tables. The bits for each
  *      register set are expected not to collide with previously added entries
+ * @process_in_vf: Whether this RTP table should get processed for SR-IOV VF
+ *      devices.  Should generally only be 'true' for LRC tables.
  *
- * Walk the table pointed by @entries (with an empty sentinel) and add all
- * entries with matching rules to @sr. If @hwe is not NULL, its mmio_base is
- * used to calculate the right register offset
+ * Walk the table pointed by @table and add all entries with matching rules to
+ * @sr. If @hwe is not NULL, its mmio_base is used to calculate the right
+ * register offset
  */
 void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
-			  const struct xe_rtp_entry_sr *entries,
-			  size_t n_entries,
-			  struct xe_reg_sr *sr)
+			  const struct xe_rtp_table_sr *table,
+			  struct xe_reg_sr *sr,
+			  bool process_in_vf)
 {
-	const struct xe_rtp_entry_sr *entry;
 	struct xe_hw_engine *hwe = NULL;
 	struct xe_gt *gt = NULL;
 	struct xe_device *xe = NULL;
 
 	rtp_get_context(ctx, &hwe, &gt, &xe);
 
-	xe_assert(xe, entries);
+	if (!process_in_vf && IS_SRIOV_VF(xe))
+		return;
+
+	xe_assert(xe, table->entries);
 
-	for (entry = entries; entry - entries < n_entries; entry++) {
+	for (size_t i = 0; i < table->n_entries; i++) {
+		const struct xe_rtp_entry_sr *entry = &table->entries[i];
 		bool match = false;
 
 		if (entry->flags & XE_RTP_ENTRY_FLAG_FOREACH_ENGINE) {
@@ -308,37 +312,40 @@ void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
 		}
 
 		if (match)
-			rtp_mark_active(xe, ctx, entry - entries);
+			rtp_mark_active(xe, ctx, i);
 	}
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_rtp_process_to_sr);
 
 /**
- * xe_rtp_process - Process all rtp @entries, without running any action
+ * xe_rtp_process - Process all entries in rtp @table, without running any action
  * @ctx: The context for processing the table, with one of device, gt or hwe
- * @entries: Table with RTP definitions
+ * @table: Table with RTP definitions
  *
- * Walk the table pointed by @entries (with an empty sentinel), executing the
+ * Walk the table pointed by @table, executing the
  * rules. One difference from xe_rtp_process_to_sr(): there is no action
  * associated with each entry since this uses struct xe_rtp_entry. Its main use
  * is for marking active workarounds via
  * xe_rtp_process_ctx_enable_active_tracking().
  */
 void xe_rtp_process(struct xe_rtp_process_ctx *ctx,
-		    const struct xe_rtp_entry *entries)
+		    const struct xe_rtp_table *table)
 {
-	const struct xe_rtp_entry *entry;
 	struct xe_hw_engine *hwe;
 	struct xe_gt *gt;
 	struct xe_device *xe;
 
 	rtp_get_context(ctx, &hwe, &gt, &xe);
 
-	for (entry = entries; entry && entry->rules; entry++) {
+	xe_assert(xe, table->entries);
+
+	for (size_t i = 0; i < table->n_entries; i++) {
+		const struct xe_rtp_entry *entry = &table->entries[i];
+
 		if (!rule_matches(xe, gt, hwe, entry->rules, entry->n_rules))
 			continue;
 
-		rtp_mark_active(xe, ctx, entry - entries);
+		rtp_mark_active(xe, ctx, i);
 	}
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_rtp_process);
diff --git a/drivers/gpu/drm/xe/xe_rtp.h b/drivers/gpu/drm/xe/xe_rtp.h
index ac12ddf6cde6..086b96417770 100644
--- a/drivers/gpu/drm/xe/xe_rtp.h
+++ b/drivers/gpu/drm/xe/xe_rtp.h
@@ -420,6 +420,16 @@ struct xe_reg_sr;
 		XE_RTP_PASTE_FOREACH(ACTION_, COMMA, (__VA_ARGS__))	\
 	}
 
+#define XE_RTP_TABLE_SR(...) { \
+	.entries = (const struct xe_rtp_entry_sr[]){__VA_ARGS__}, \
+	.n_entries = ARRAY_SIZE(((const struct xe_rtp_entry_sr[]){__VA_ARGS__})), \
+}
+
+#define XE_RTP_TABLE(...) { \
+	.entries = (const struct xe_rtp_entry[]){__VA_ARGS__}, \
+	.n_entries = ARRAY_SIZE(((const struct xe_rtp_entry[]){__VA_ARGS__})), \
+}
+
 #define XE_RTP_PROCESS_CTX_INITIALIZER(arg__) _Generic((arg__),							\
 	struct xe_hw_engine * :	(struct xe_rtp_process_ctx){ { (void *)(arg__) }, XE_RTP_PROCESS_TYPE_ENGINE },	\
 	struct xe_gt * :	(struct xe_rtp_process_ctx){ { (void *)(arg__) }, XE_RTP_PROCESS_TYPE_GT },	\
@@ -430,11 +440,12 @@ void xe_rtp_process_ctx_enable_active_tracking(struct xe_rtp_process_ctx *ctx,
 					       size_t n_entries);
 
 void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
-			  const struct xe_rtp_entry_sr *entries,
-			  size_t n_entries, struct xe_reg_sr *sr);
+			  const struct xe_rtp_table_sr *table,
+			  struct xe_reg_sr *sr,
+			  bool process_in_vf);
 
 void xe_rtp_process(struct xe_rtp_process_ctx *ctx,
-		    const struct xe_rtp_entry *entries);
+		    const struct xe_rtp_table *table);
 
 /* Match functions to be used with XE_RTP_MATCH_FUNC */
 
diff --git a/drivers/gpu/drm/xe/xe_rtp_types.h b/drivers/gpu/drm/xe/xe_rtp_types.h
index f4cf30e298cf..fbf108b9bb7e 100644
--- a/drivers/gpu/drm/xe/xe_rtp_types.h
+++ b/drivers/gpu/drm/xe/xe_rtp_types.h
@@ -109,6 +109,16 @@ struct xe_rtp_entry {
 	u8 n_rules;
 };
 
+struct xe_rtp_table_sr {
+	const struct xe_rtp_entry_sr *entries;
+	size_t n_entries;
+};
+
+struct xe_rtp_table {
+	const struct xe_rtp_entry *entries;
+	size_t n_entries;
+};
+
 enum xe_rtp_process_type {
 	XE_RTP_PROCESS_TYPE_DEVICE,
 	XE_RTP_PROCESS_TYPE_GT,
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index a524170a04d0..90e01b51dd36 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -17,7 +17,7 @@
 #undef XE_REG_MCR
 #define XE_REG_MCR(...)     XE_REG(__VA_ARGS__, .mcr = 1)
 
-static const struct xe_rtp_entry_sr gt_tunings[] = {
+static const struct xe_rtp_table_sr gt_tunings = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("Tuning: Blend Fill Caching Optimization Disable"),
 	  XE_RTP_RULES(PLATFORM(DG2)),
 	  XE_RTP_ACTIONS(SET(XEHP_L3SCQREG7, BLEND_FILL_CACHING_OPT_DIS))
@@ -85,9 +85,9 @@ static const struct xe_rtp_entry_sr gt_tunings[] = {
 	  XE_RTP_RULES(MEDIA_VERSION(2000)),
 	  XE_RTP_ACTIONS(SET(XE2LPM_SCRATCH3_LBCF, RWFLUSHALLEN))
 	},
-};
+);
 
-static const struct xe_rtp_entry_sr engine_tunings[] = {
+static const struct xe_rtp_table_sr engine_tunings = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("Tuning: L3 Hashing Mask"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210),
 		       FUNC(xe_rtp_match_first_render_or_compute)),
@@ -103,9 +103,9 @@ static const struct xe_rtp_entry_sr engine_tunings[] = {
 		       FUNC(xe_rtp_match_first_render_or_compute)),
 	  XE_RTP_ACTIONS(SET(RT_CTRL, DIS_NULL_QUERY))
 	},
-};
+);
 
-static const struct xe_rtp_entry_sr lrc_tunings[] = {
+static const struct xe_rtp_table_sr lrc_tunings = XE_RTP_TABLE_SR(
 	/* DG2 */
 
 	{ XE_RTP_NAME("Tuning: L3 cache"),
@@ -140,7 +140,7 @@ static const struct xe_rtp_entry_sr lrc_tunings[] = {
 	  XE_RTP_ACTIONS(FIELD_SET(FF_MODE, VS_HIT_MAX_VALUE_MASK,
 				   REG_FIELD_PREP(VS_HIT_MAX_VALUE_MASK, 0x3f)))
 	},
-};
+);
 
 /**
  * xe_tuning_init - initialize gt with tunings bookkeeping
@@ -154,9 +154,9 @@ int xe_tuning_init(struct xe_gt *gt)
 	size_t n_lrc, n_engine, n_gt, total;
 	unsigned long *p;
 
-	n_gt = BITS_TO_LONGS(ARRAY_SIZE(gt_tunings));
-	n_engine = BITS_TO_LONGS(ARRAY_SIZE(engine_tunings));
-	n_lrc = BITS_TO_LONGS(ARRAY_SIZE(lrc_tunings));
+	n_gt = BITS_TO_LONGS(gt_tunings.n_entries);
+	n_engine = BITS_TO_LONGS(engine_tunings.n_entries);
+	n_lrc = BITS_TO_LONGS(lrc_tunings.n_entries);
 	total = n_gt + n_engine + n_lrc;
 
 	p = drmm_kzalloc(&xe->drm, sizeof(*p) * total, GFP_KERNEL);
@@ -179,8 +179,8 @@ void xe_tuning_process_gt(struct xe_gt *gt)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx,
 						  gt->tuning_active.gt,
-						  ARRAY_SIZE(gt_tunings));
-	xe_rtp_process_to_sr(&ctx, gt_tunings, ARRAY_SIZE(gt_tunings), &gt->reg_sr);
+						  gt_tunings.n_entries);
+	xe_rtp_process_to_sr(&ctx, &gt_tunings, &gt->reg_sr, false);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_tuning_process_gt);
 
@@ -190,9 +190,8 @@ void xe_tuning_process_engine(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx,
 						  hwe->gt->tuning_active.engine,
-						  ARRAY_SIZE(engine_tunings));
-	xe_rtp_process_to_sr(&ctx, engine_tunings, ARRAY_SIZE(engine_tunings),
-			     &hwe->reg_sr);
+						  engine_tunings.n_entries);
+	xe_rtp_process_to_sr(&ctx, &engine_tunings, &hwe->reg_sr, false);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_tuning_process_engine);
 
@@ -210,8 +209,8 @@ void xe_tuning_process_lrc(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx,
 						  hwe->gt->tuning_active.lrc,
-						  ARRAY_SIZE(lrc_tunings));
-	xe_rtp_process_to_sr(&ctx, lrc_tunings, ARRAY_SIZE(lrc_tunings), &hwe->reg_lrc);
+						  lrc_tunings.n_entries);
+	xe_rtp_process_to_sr(&ctx, &lrc_tunings, &hwe->reg_lrc, true);
 }
 
 void xe_tuning_dump(struct xe_gt *gt, struct drm_printer *p)
@@ -219,14 +218,14 @@ void xe_tuning_dump(struct xe_gt *gt, struct drm_printer *p)
 	size_t idx;
 
 	drm_printf(p, "GT Tunings\n");
-	for_each_set_bit(idx, gt->tuning_active.gt, ARRAY_SIZE(gt_tunings))
-		drm_printf_indent(p, 1, "%s\n", gt_tunings[idx].name);
+	for_each_set_bit(idx, gt->tuning_active.gt, gt_tunings.n_entries)
+		drm_printf_indent(p, 1, "%s\n", gt_tunings.entries[idx].name);
 
 	drm_printf(p, "\nEngine Tunings\n");
-	for_each_set_bit(idx, gt->tuning_active.engine, ARRAY_SIZE(engine_tunings))
-		drm_printf_indent(p, 1, "%s\n", engine_tunings[idx].name);
+	for_each_set_bit(idx, gt->tuning_active.engine, engine_tunings.n_entries)
+		drm_printf_indent(p, 1, "%s\n", engine_tunings.entries[idx].name);
 
 	drm_printf(p, "\nLRC Tunings\n");
-	for_each_set_bit(idx, gt->tuning_active.lrc, ARRAY_SIZE(lrc_tunings))
-		drm_printf_indent(p, 1, "%s\n", lrc_tunings[idx].name);
+	for_each_set_bit(idx, gt->tuning_active.lrc, lrc_tunings.n_entries)
+		drm_printf_indent(p, 1, "%s\n", lrc_tunings.entries[idx].name);
 }
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index 51c5985830b1..20e51816695f 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -119,7 +119,7 @@
 __diag_push();
 __diag_ignore_all("-Woverride-init", "Allow field overrides in table");
 
-static const struct xe_rtp_entry_sr gt_was[] = {
+static const struct xe_rtp_table_sr gt_was = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("14011060649"),
 	  XE_RTP_RULES(MEDIA_VERSION_RANGE(1200, 1255),
 		       ENGINE_CLASS(VIDEO_DECODE),
@@ -322,9 +322,9 @@ static const struct xe_rtp_entry_sr gt_was[] = {
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3005)),
 	  XE_RTP_ACTIONS(SET(GUC_INTR_CHICKEN, DISABLE_SIGNALING_ENGINES))
 	},
-};
+);
 
-static const struct xe_rtp_entry_sr engine_was[] = {
+static const struct xe_rtp_table_sr engine_was = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("22010931296, 18011464164, 14010919138"),
 	  XE_RTP_RULES(GRAPHICS_VERSION(1200), ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(SET(FF_THREAD_MODE(RENDER_RING_BASE),
@@ -696,9 +696,9 @@ static const struct xe_rtp_entry_sr engine_was[] = {
 		       FUNC(xe_rtp_match_gt_has_discontiguous_dss_groups)),
 	  XE_RTP_ACTIONS(SET(TDL_CHICKEN, EUSTALL_PERF_SAMPLING_DISABLE))
 	},
-};
+);
 
-static const struct xe_rtp_entry_sr lrc_was[] = {
+static const struct xe_rtp_table_sr lrc_was = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("16011163337"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210), ENGINE_CLASS(RENDER)),
 	  /* read verification is ignored due to 1608008084. */
@@ -924,21 +924,29 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1, DIS_CLIP_NEGATIVE_BOUNDING_BOX))
 	},
-};
+);
 
-static __maybe_unused const struct xe_rtp_entry oob_was[] = {
+static const struct xe_rtp_entry oob_was_entries[] = {
 #include <generated/xe_wa_oob.c>
-	{}
 };
 
-static_assert(ARRAY_SIZE(oob_was) - 1 == _XE_WA_OOB_COUNT);
+static_assert(ARRAY_SIZE(oob_was_entries)  == _XE_WA_OOB_COUNT);
 
-static __maybe_unused const struct xe_rtp_entry device_oob_was[] = {
+static __maybe_unused const struct xe_rtp_table oob_was = {
+	.entries = oob_was_entries,
+	.n_entries = ARRAY_SIZE(oob_was_entries),
+};
+
+static const struct xe_rtp_entry device_oob_was_entries[] = {
 #include <generated/xe_device_wa_oob.c>
-	{}
 };
 
-static_assert(ARRAY_SIZE(device_oob_was) - 1 == _XE_DEVICE_WA_OOB_COUNT);
+static_assert(ARRAY_SIZE(device_oob_was_entries) == _XE_DEVICE_WA_OOB_COUNT);
+
+static __maybe_unused const struct xe_rtp_table device_oob_was = {
+	.entries = device_oob_was_entries,
+	.n_entries = ARRAY_SIZE(device_oob_was_entries),
+};
 
 __diag_pop();
 
@@ -954,10 +962,10 @@ void xe_wa_process_device_oob(struct xe_device *xe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(xe);
 
-	xe_rtp_process_ctx_enable_active_tracking(&ctx, xe->wa_active.oob, ARRAY_SIZE(device_oob_was));
+	xe_rtp_process_ctx_enable_active_tracking(&ctx, xe->wa_active.oob, device_oob_was.n_entries);
 
 	xe->wa_active.oob_initialized = true;
-	xe_rtp_process(&ctx, device_oob_was);
+	xe_rtp_process(&ctx, &device_oob_was);
 }
 
 /**
@@ -972,9 +980,9 @@ void xe_wa_process_gt_oob(struct xe_gt *gt)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(gt);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, gt->wa_active.oob,
-						  ARRAY_SIZE(oob_was));
+						  oob_was.n_entries);
 	gt->wa_active.oob_initialized = true;
-	xe_rtp_process(&ctx, oob_was);
+	xe_rtp_process(&ctx, &oob_was);
 }
 
 /**
@@ -989,8 +997,8 @@ void xe_wa_process_gt(struct xe_gt *gt)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(gt);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, gt->wa_active.gt,
-						  ARRAY_SIZE(gt_was));
-	xe_rtp_process_to_sr(&ctx, gt_was, ARRAY_SIZE(gt_was), &gt->reg_sr);
+						  gt_was.n_entries);
+	xe_rtp_process_to_sr(&ctx, &gt_was, &gt->reg_sr, false);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_wa_process_gt);
 
@@ -1007,8 +1015,8 @@ void xe_wa_process_engine(struct xe_hw_engine *hwe)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.engine,
-						  ARRAY_SIZE(engine_was));
-	xe_rtp_process_to_sr(&ctx, engine_was, ARRAY_SIZE(engine_was), &hwe->reg_sr);
+						  engine_was.n_entries);
+	xe_rtp_process_to_sr(&ctx, &engine_was, &hwe->reg_sr, false);
 }
 
 /**
@@ -1024,8 +1032,8 @@ void xe_wa_process_lrc(struct xe_hw_engine *hwe)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.lrc,
-						  ARRAY_SIZE(lrc_was));
-	xe_rtp_process_to_sr(&ctx, lrc_was, ARRAY_SIZE(lrc_was), &hwe->reg_lrc);
+						  lrc_was.n_entries);
+	xe_rtp_process_to_sr(&ctx, &lrc_was, &hwe->reg_lrc, true);
 }
 
 /**
@@ -1039,7 +1047,7 @@ int xe_wa_device_init(struct xe_device *xe)
 	unsigned long *p;
 
 	p = drmm_kzalloc(&xe->drm,
-			 sizeof(*p) * BITS_TO_LONGS(ARRAY_SIZE(device_oob_was)),
+			 sizeof(*p) * BITS_TO_LONGS(device_oob_was.n_entries),
 			 GFP_KERNEL);
 
 	if (!p)
@@ -1062,10 +1070,10 @@ int xe_wa_gt_init(struct xe_gt *gt)
 	size_t n_oob, n_lrc, n_engine, n_gt, total;
 	unsigned long *p;
 
-	n_gt = BITS_TO_LONGS(ARRAY_SIZE(gt_was));
-	n_engine = BITS_TO_LONGS(ARRAY_SIZE(engine_was));
-	n_lrc = BITS_TO_LONGS(ARRAY_SIZE(lrc_was));
-	n_oob = BITS_TO_LONGS(ARRAY_SIZE(oob_was));
+	n_gt = BITS_TO_LONGS(gt_was.n_entries);
+	n_engine = BITS_TO_LONGS(engine_was.n_entries);
+	n_lrc = BITS_TO_LONGS(lrc_was.n_entries);
+	n_oob = BITS_TO_LONGS(oob_was.n_entries);
 	total = n_gt + n_engine + n_lrc + n_oob;
 
 	p = drmm_kzalloc(&xe->drm, sizeof(*p) * total, GFP_KERNEL);
@@ -1089,9 +1097,9 @@ void xe_wa_device_dump(struct xe_device *xe, struct drm_printer *p)
 	size_t idx;
 
 	drm_printf(p, "Device OOB Workarounds\n");
-	for_each_set_bit(idx, xe->wa_active.oob, ARRAY_SIZE(device_oob_was))
-		if (device_oob_was[idx].name)
-			drm_printf_indent(p, 1, "%s\n", device_oob_was[idx].name);
+	for_each_set_bit(idx, xe->wa_active.oob, device_oob_was.n_entries)
+		if (device_oob_was.entries[idx].name)
+			drm_printf_indent(p, 1, "%s\n", device_oob_was.entries[idx].name);
 }
 
 void xe_wa_dump(struct xe_gt *gt, struct drm_printer *p)
@@ -1099,21 +1107,21 @@ void xe_wa_dump(struct xe_gt *gt, struct drm_printer *p)
 	size_t idx;
 
 	drm_printf(p, "GT Workarounds\n");
-	for_each_set_bit(idx, gt->wa_active.gt, ARRAY_SIZE(gt_was))
-		drm_printf_indent(p, 1, "%s\n", gt_was[idx].name);
+	for_each_set_bit(idx, gt->wa_active.gt, gt_was.n_entries)
+		drm_printf_indent(p, 1, "%s\n", gt_was.entries[idx].name);
 
 	drm_printf(p, "\nEngine Workarounds\n");
-	for_each_set_bit(idx, gt->wa_active.engine, ARRAY_SIZE(engine_was))
-		drm_printf_indent(p, 1, "%s\n", engine_was[idx].name);
+	for_each_set_bit(idx, gt->wa_active.engine, engine_was.n_entries)
+		drm_printf_indent(p, 1, "%s\n", engine_was.entries[idx].name);
 
 	drm_printf(p, "\nLRC Workarounds\n");
-	for_each_set_bit(idx, gt->wa_active.lrc, ARRAY_SIZE(lrc_was))
-		drm_printf_indent(p, 1, "%s\n", lrc_was[idx].name);
+	for_each_set_bit(idx, gt->wa_active.lrc, lrc_was.n_entries)
+		drm_printf_indent(p, 1, "%s\n", lrc_was.entries[idx].name);
 
 	drm_printf(p, "\nOOB Workarounds\n");
-	for_each_set_bit(idx, gt->wa_active.oob, ARRAY_SIZE(oob_was))
-		if (oob_was[idx].name)
-			drm_printf_indent(p, 1, "%s\n", oob_was[idx].name);
+	for_each_set_bit(idx, gt->wa_active.oob, oob_was.n_entries)
+		if (oob_was.entries[idx].name)
+			drm_printf_indent(p, 1, "%s\n", oob_was.entries[idx].name);
 }
 
 /*
-- 
2.53.0

