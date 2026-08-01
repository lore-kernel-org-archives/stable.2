Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5B537F8C9
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785586050; cv=none; b=FxDVSQiT/60LkrY8MKxEjOq3gvDoH0g7pY5K9jHYO3lT1KkgeYuKfl6r7C03EFoJVsiBW4qfgRyfkJ7OJJyAKU1FIwUbQYU4/+svOm1JLhB7IpWmCjbqkxizquuBtIoCyegCKsIyv9oTdkzG6lgLRGPgQ7qAlZxaKi5YgGI+uJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785586050; c=relaxed/simple;
	bh=JOV2QvgAg9MFwhqi2ETWQL8+q4cy9jHnWjKQLhNCe/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1PJNYPOHom3470cxbVcDpIIz4Wr0Ch5iWhq6RF5M03jK26993okNqMVvOw2U+EQsj8m5Spj9PpvwxY5TcVppSlxHQ9Z2HZ+jEnSfG303tEACvtRqZAykA5/CMbi+hXxnrJ2vaHC+nLhewT0tfgfgnYOtuc8zZzBCAfisQrImmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBTi/q4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBTi/q4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE511F00ACF;
	Sat,  1 Aug 2026 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785586048;
	bh=sKiQT3HgtFjGshJKYrdgxI+4zXcQy/hnY3eJCudGheU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bBTi/q4YW92G9lLGZ6GIyic1Ij92gCUv8YQO8wN9G6r+I0DYCLZGwBxEYSCLcjnWM
	 EUv0gjOy3eHQvhl03O/S6LpNszuKHUXqG9OyRbgYeUij8qPTN2on4QKfGrlxuqoWe2
	 QeuFpcJd46WNbv362WUALdYIz6zh6ZQ9NdqD6B2OLzc5jxhWbKijdqRrH2JIEWW0oF
	 yVRfcfG0BgEBVhIFrmtTIBjF7WL4T8S/debZvjkOcuivZf0zvdyLDoKE2tjkLCdH3I
	 cm3Au4SZbusUGyb+bwiy4W46WeWgggDklF2DEmeohXoeUr71GQnbsoVo3fgcqauu9d
	 nPk9NokGWB8oQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Violet Monti <violet.monti@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] drm/xe/rtp: Add struct types for RTP tables
Date: Sat,  1 Aug 2026 08:07:22 -0400
Message-ID: <20260801120724.2790990-4-sashal@kernel.org>
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
Stable-dep-of: 4fe2844b0f0c ("drm/xe/rtp: Generalize whitelist_apply_to_hwe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/tests/xe_rtp_test.c | 102 ++++++++++---------------
 drivers/gpu/drm/xe/xe_hw_engine.c      |  14 ++--
 drivers/gpu/drm/xe/xe_reg_whitelist.c  |   7 +-
 drivers/gpu/drm/xe/xe_rtp.c            |  35 +++++----
 drivers/gpu/drm/xe/xe_rtp.h            |  14 +++-
 drivers/gpu/drm/xe/xe_rtp_types.h      |  10 +++
 drivers/gpu/drm/xe/xe_tuning.c         |  23 +++---
 drivers/gpu/drm/xe/xe_wa.c             |  70 +++++++++--------
 8 files changed, 134 insertions(+), 141 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_rtp_test.c b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
index e0972d42f96c..0aeff548bb73 100644
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
-	xe_rtp_process_to_sr(&ctx, param->entries, reg_sr);
+	xe_rtp_process_ctx_enable_active_tracking(&ctx, &active, param->table.n_entries);
+	xe_rtp_process_to_sr(&ctx, &param->table, reg_sr);
 
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
index 45d0ae074e65..6b37b12f5a71 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -366,7 +366,7 @@ xe_hw_engine_setup_default_lrc_state(struct xe_hw_engine *hwe)
 	u32 blit_cctl_val = REG_FIELD_PREP(BLIT_CCTL_DST_MOCS_MASK, mocs_write_idx) |
 			    REG_FIELD_PREP(BLIT_CCTL_SRC_MOCS_MASK, mocs_read_idx);
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
-	const struct xe_rtp_entry_sr lrc_setup[] = {
+	const struct xe_rtp_table_sr lrc_setup = XE_RTP_TABLE_SR(
 		/*
 		 * Some blitter commands do not have a field for MOCS, those
 		 * commands will use MOCS index pointed by BLIT_CCTL.
@@ -389,10 +389,9 @@ xe_hw_engine_setup_default_lrc_state(struct xe_hw_engine *hwe)
 					   PREEMPT_GPGPU_THREAD_GROUP_LEVEL)),
 		  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE)
 		},
-		{}
-	};
+	);
 
-	xe_rtp_process_to_sr(&ctx, lrc_setup, &hwe->reg_lrc);
+	xe_rtp_process_to_sr(&ctx, &lrc_setup, &hwe->reg_lrc);
 }
 
 static void
@@ -417,7 +416,7 @@ hw_engine_setup_default_state(struct xe_hw_engine *hwe)
 	u32 ring_cmd_cctl_val = REG_FIELD_PREP(CMD_CCTL_WRITE_OVERRIDE_MASK, mocs_write_idx) |
 				REG_FIELD_PREP(CMD_CCTL_READ_OVERRIDE_MASK, mocs_read_idx);
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
-	const struct xe_rtp_entry_sr engine_entries[] = {
+	const struct xe_rtp_table_sr engine_sr = XE_RTP_TABLE_SR(
 		{ XE_RTP_NAME("RING_CMD_CCTL_default_MOCS"),
 		  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, XE_RTP_END_VERSION_UNDEFINED)),
 		  XE_RTP_ACTIONS(FIELD_SET(RING_CMD_CCTL(0),
@@ -454,10 +453,9 @@ hw_engine_setup_default_state(struct xe_hw_engine *hwe)
 		  XE_RTP_ACTIONS(FIELD_SET(RCU_MODE, RCU_MODE_FIXED_SLICE_CCS_MODE,
 					   RCU_MODE_FIXED_SLICE_CCS_MODE))
 		},
-		{}
-	};
+	);
 
-	xe_rtp_process_to_sr(&ctx, engine_entries, &hwe->reg_sr);
+	xe_rtp_process_to_sr(&ctx, &engine_sr, &hwe->reg_sr);
 }
 
 static void hw_engine_init_early(struct xe_gt *gt, struct xe_hw_engine *hwe,
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 3de0a867149d..4c442f643e68 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -23,7 +23,7 @@ static bool match_not_render(const struct xe_gt *gt,
 	return hwe->class != XE_ENGINE_CLASS_RENDER;
 }
 
-static const struct xe_rtp_entry_sr register_whitelist[] = {
+static const struct xe_rtp_table_sr register_whitelist = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("WaAllowPMDepthAndInvocationCountAccessFromUMD, 1408556865"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210), ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(PS_INVOCATION_COUNT,
@@ -86,8 +86,7 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 				   RING_FORCE_TO_NONPRIV_ACCESS_RD |
 				   RING_FORCE_TO_NONPRIV_RANGE_4))
 	},
-	{}
-};
+);
 
 /**
  * xe_reg_whitelist_process_engine - process table of registers to whitelist
@@ -101,7 +100,7 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
-	xe_rtp_process_to_sr(&ctx, register_whitelist, &hwe->reg_whitelist);
+	xe_rtp_process_to_sr(&ctx, &register_whitelist, &hwe->reg_whitelist);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
index 86c705d18c0d..867f2e3b2647 100644
--- a/drivers/gpu/drm/xe/xe_rtp.c
+++ b/drivers/gpu/drm/xe/xe_rtp.c
@@ -236,20 +236,19 @@ static void rtp_mark_active(struct xe_device *xe,
  * xe_rtp_process_to_sr - Process all rtp @entries, adding the matching ones to
  *                        the save-restore argument.
  * @ctx: The context for processing the table, with one of device, gt or hwe
- * @entries: Table with RTP definitions
+ * @table: Table with RTP definitions
  * @sr: Save-restore struct where matching rules execute the action. This can be
  *      viewed as the "coalesced view" of multiple the tables. The bits for each
  *      register set are expected not to collide with previously added entries
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
+			  const struct xe_rtp_table_sr *table,
 			  struct xe_reg_sr *sr)
 {
-	const struct xe_rtp_entry_sr *entry;
 	struct xe_hw_engine *hwe = NULL;
 	struct xe_gt *gt = NULL;
 	struct xe_device *xe = NULL;
@@ -259,7 +258,10 @@ void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
 	if (IS_SRIOV_VF(xe))
 		return;
 
-	for (entry = entries; entry && entry->name; entry++) {
+	xe_assert(xe, table->entries);
+
+	for (size_t i = 0; i < table->n_entries; i++) {
+		const struct xe_rtp_entry_sr *entry = &table->entries[i];
 		bool match = false;
 
 		if (entry->flags & XE_RTP_ENTRY_FLAG_FOREACH_ENGINE) {
@@ -274,37 +276,40 @@ void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
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
index 827d932b6908..21650bd37e5d 100644
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
 	struct xe_gt * :	(struct xe_rtp_process_ctx){ { (void *)(arg__) }, XE_RTP_PROCESS_TYPE_GT })
@@ -429,11 +439,11 @@ void xe_rtp_process_ctx_enable_active_tracking(struct xe_rtp_process_ctx *ctx,
 					       size_t n_entries);
 
 void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
-			  const struct xe_rtp_entry_sr *entries,
+			  const struct xe_rtp_table_sr *table,
 			  struct xe_reg_sr *sr);
 
 void xe_rtp_process(struct xe_rtp_process_ctx *ctx,
-		    const struct xe_rtp_entry *entries);
+		    const struct xe_rtp_table *table);
 
 /* Match functions to be used with XE_RTP_MATCH_FUNC */
 
diff --git a/drivers/gpu/drm/xe/xe_rtp_types.h b/drivers/gpu/drm/xe/xe_rtp_types.h
index 1b76b947c706..348786d25aae 100644
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
 	XE_RTP_PROCESS_TYPE_GT,
 	XE_RTP_PROCESS_TYPE_ENGINE,
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index 1fb12da21c9e..07c3687cb310 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -15,7 +15,7 @@
 #undef XE_REG_MCR
 #define XE_REG_MCR(...)     XE_REG(__VA_ARGS__, .mcr = 1)
 
-static const struct xe_rtp_entry_sr gt_tunings[] = {
+static const struct xe_rtp_table_sr gt_tunings = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("Tuning: Blend Fill Caching Optimization Disable"),
 	  XE_RTP_RULES(PLATFORM(DG2)),
 	  XE_RTP_ACTIONS(SET(XEHP_L3SCQREG7, BLEND_FILL_CACHING_OPT_DIS))
@@ -83,20 +83,17 @@ static const struct xe_rtp_entry_sr gt_tunings[] = {
 	  XE_RTP_RULES(MEDIA_VERSION(2000)),
 	  XE_RTP_ACTIONS(SET(XE2LPM_SCRATCH3_LBCF, RWFLUSHALLEN))
 	},
+);
 
-	{}
-};
-
-static const struct xe_rtp_entry_sr engine_tunings[] = {
+static const struct xe_rtp_table_sr engine_tunings = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("Tuning: Set Indirect State Override"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1274),
 		       ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(SET(SAMPLER_MODE, INDIRECT_STATE_BASE_ADDR_OVERRIDE))
 	},
-	{}
-};
+);
 
-static const struct xe_rtp_entry_sr lrc_tunings[] = {
+static const struct xe_rtp_table_sr lrc_tunings = XE_RTP_TABLE_SR(
 	/* DG2 */
 
 	{ XE_RTP_NAME("Tuning: L3 cache"),
@@ -131,15 +128,13 @@ static const struct xe_rtp_entry_sr lrc_tunings[] = {
 	  XE_RTP_ACTIONS(FIELD_SET(FF_MODE, VS_HIT_MAX_VALUE_MASK,
 				   REG_FIELD_PREP(VS_HIT_MAX_VALUE_MASK, 0x3f)))
 	},
-
-	{}
-};
+);
 
 void xe_tuning_process_gt(struct xe_gt *gt)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(gt);
 
-	xe_rtp_process_to_sr(&ctx, gt_tunings, &gt->reg_sr);
+	xe_rtp_process_to_sr(&ctx, &gt_tunings, &gt->reg_sr);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_tuning_process_gt);
 
@@ -147,7 +142,7 @@ void xe_tuning_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
-	xe_rtp_process_to_sr(&ctx, engine_tunings, &hwe->reg_sr);
+	xe_rtp_process_to_sr(&ctx, &engine_tunings, &hwe->reg_sr);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_tuning_process_engine);
 
@@ -163,5 +158,5 @@ void xe_tuning_process_lrc(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
-	xe_rtp_process_to_sr(&ctx, lrc_tunings, &hwe->reg_lrc);
+	xe_rtp_process_to_sr(&ctx, &lrc_tunings, &hwe->reg_lrc);
 }
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index a2af1a44b0e0..0da125a5c808 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -97,7 +97,7 @@
 __diag_push();
 __diag_ignore_all("-Woverride-init", "Allow field overrides in table");
 
-static const struct xe_rtp_entry_sr gt_was[] = {
+static const struct xe_rtp_table_sr gt_was = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("14011060649"),
 	  XE_RTP_RULES(MEDIA_VERSION_RANGE(1200, 1255),
 		       ENGINE_CLASS(VIDEO_DECODE),
@@ -278,11 +278,9 @@ static const struct xe_rtp_entry_sr gt_was[] = {
 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F10(0), RAMDFTUNIT_CLKGATE_DIS)),
 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
 	},
+);
 
-	{}
-};
-
-static const struct xe_rtp_entry_sr engine_was[] = {
+static const struct xe_rtp_table_sr engine_was = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("22010931296, 18011464164, 14010919138"),
 	  XE_RTP_RULES(GRAPHICS_VERSION(1200), ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(SET(FF_THREAD_MODE(RENDER_RING_BASE),
@@ -595,11 +593,9 @@ static const struct xe_rtp_entry_sr engine_was[] = {
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3001), FUNC(xe_rtp_match_first_render_or_compute)),
 	  XE_RTP_ACTIONS(SET(HALF_SLICE_CHICKEN7, CLEAR_OPTIMIZATION_DISABLE))
 	},
+);
 
-	{}
-};
-
-static const struct xe_rtp_entry_sr lrc_was[] = {
+static const struct xe_rtp_table_sr lrc_was = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("16011163337"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210), ENGINE_CLASS(RENDER)),
 	  /* read verification is ignored due to 1608008084. */
@@ -805,16 +801,18 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
 			     DIS_PARTIAL_AUTOSTRIP |
 			     DIS_AUTOSTRIP))
 	},
+);
 
-	{}
-};
-
-static __maybe_unused const struct xe_rtp_entry oob_was[] = {
+static const struct xe_rtp_entry oob_was_entries[] = {
 #include <generated/xe_wa_oob.c>
-	{}
 };
 
-static_assert(ARRAY_SIZE(oob_was) - 1 == _XE_WA_OOB_COUNT);
+static_assert(ARRAY_SIZE(oob_was_entries) == _XE_WA_OOB_COUNT);
+
+static __maybe_unused const struct xe_rtp_table oob_was = {
+	.entries = oob_was_entries,
+	.n_entries = ARRAY_SIZE(oob_was_entries),
+};
 
 __diag_pop();
 
@@ -830,9 +828,9 @@ void xe_wa_process_oob(struct xe_gt *gt)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(gt);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, gt->wa_active.oob,
-						  ARRAY_SIZE(oob_was));
+						  oob_was.n_entries);
 	gt->wa_active.oob_initialized = true;
-	xe_rtp_process(&ctx, oob_was);
+	xe_rtp_process(&ctx, &oob_was);
 }
 
 /**
@@ -847,8 +845,8 @@ void xe_wa_process_gt(struct xe_gt *gt)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(gt);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, gt->wa_active.gt,
-						  ARRAY_SIZE(gt_was));
-	xe_rtp_process_to_sr(&ctx, gt_was, &gt->reg_sr);
+						  gt_was.n_entries);
+	xe_rtp_process_to_sr(&ctx, &gt_was, &gt->reg_sr);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_wa_process_gt);
 
@@ -865,8 +863,8 @@ void xe_wa_process_engine(struct xe_hw_engine *hwe)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.engine,
-						  ARRAY_SIZE(engine_was));
-	xe_rtp_process_to_sr(&ctx, engine_was, &hwe->reg_sr);
+						  engine_was.n_entries);
+	xe_rtp_process_to_sr(&ctx, &engine_was, &hwe->reg_sr);
 }
 
 /**
@@ -882,8 +880,8 @@ void xe_wa_process_lrc(struct xe_hw_engine *hwe)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.lrc,
-						  ARRAY_SIZE(lrc_was));
-	xe_rtp_process_to_sr(&ctx, lrc_was, &hwe->reg_lrc);
+						  lrc_was.n_entries);
+	xe_rtp_process_to_sr(&ctx, &lrc_was, &hwe->reg_lrc);
 }
 
 /**
@@ -898,10 +896,10 @@ int xe_wa_init(struct xe_gt *gt)
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
@@ -924,21 +922,21 @@ void xe_wa_dump(struct xe_gt *gt, struct drm_printer *p)
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

