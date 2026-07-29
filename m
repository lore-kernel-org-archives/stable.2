Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4624657C6
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322687; cv=none; b=Qv9gkg1JbX7WmtM+6ukOwVzj5fW7F1EcjZnybbSLo6z7c+rIc6eZM+1HLqYizIJVkhfV8IjeV+u1nzPtWTOAnD/ZERD8ItZ+BlLWXdlh9D387s8mP7q+w0MIUBTapKe1zsvGSZitYUJeqzYdNmL6CZltq2gYdYOt6kNSnpzEO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322687; c=relaxed/simple;
	bh=g7ISlOJU6wqIuAEni0g3QRLtnSYVTp4CotZGzV+SlD4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XObeeL2cumiz1qUKyMAMGFA1VnJFrtEyhSo0+NvdS8e5wLhodq9xjMFpDSyDlne9dNKijeUl4kjvSFr6Gc0dgsBNK4OdqNcUEoZ1GA8hczEg0H5f5w9m+JP5Z0kEM2qPZmi+T1nu0c2yTP5Bt8AtiCQdAqRCoK5/EXMHQRUtSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eKrEjz5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eKrEjz5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0855B1F000E9;
	Wed, 29 Jul 2026 10:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785322684;
	bh=XcefSy9jqnW7DjgbIyl3VKNBERzJyGCIcdOWzO8xZbg=;
	h=Subject:To:Cc:From:Date;
	b=eKrEjz5q7fEfNUYYXXmavXTauPZW5OJ3XkOrup09MMGHHeNHLZiQ2E+a/YD3jBEq7
	 1LZCG/cDQHVfM7IdGsmPECjdvzjs6Vxlo74vI1xwahC+5vuk4ikVskImpl3FPdWdhV
	 648uQpyG2+Oqif58BfmAmiP9YyEz0pikLPVzlJu0=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Add struct types for RTP tables" failed to apply to 6.12-stable tree
To: gustavo.sousa@intel.com,matthew.d.roper@intel.com,thomas.hellstrom@linux.intel.com,violet.monti@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:57:44 +0200
Message-ID: <2026072944-gentleman-unmoving-8dff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e23fafb8594ea886ee03e005cc32dfda24f417cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072944-gentleman-unmoving-8dff@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e23fafb8594ea886ee03e005cc32dfda24f417cf Mon Sep 17 00:00:00 2001
From: Gustavo Sousa <gustavo.sousa@intel.com>
Date: Mon, 1 Jun 2026 13:09:47 -0700
Subject: [PATCH] drm/xe/rtp: Add struct types for RTP tables
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/xe/tests/xe_rtp_test.c b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
index 642f6e090ad0..3d0688d058d9 100644
--- a/drivers/gpu/drm/xe/tests/xe_rtp_test.c
+++ b/drivers/gpu/drm/xe/tests/xe_rtp_test.c
@@ -54,13 +54,13 @@ struct rtp_to_sr_test_case {
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
@@ -289,7 +289,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1),
 		.expected_count_sr_entries = 1,
 		/* Different bits on the same register: create a single entry */
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -298,8 +298,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(1)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "no-match-no-add",
@@ -309,7 +308,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0),
 		.expected_count_sr_entries = 1,
 		/* Don't coalesce second entry since rules don't match */
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -318,8 +317,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_no)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(1)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "two-regs-two-entries",
@@ -329,7 +327,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1),
 		.expected_count_sr_entries = 2,
 		/* Same bits on different registers are not coalesced */
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -338,8 +336,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG2, REG_BIT(0)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "clr-one-set-other",
@@ -349,7 +346,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1),
 		.expected_count_sr_entries = 1,
 		/* Check clr vs set actions on different bits */
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -358,8 +355,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(CLR(REGULAR_REG1, REG_BIT(1)))
 			},
-			{}
-		},
+		),
 	},
 	{
 #define TEMP_MASK	REG_GENMASK(10, 8)
@@ -371,14 +367,13 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
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
@@ -390,7 +385,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1),
 		.expected_count_sr_entries = 1,
 		.expected_sr_errors = 1,
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -400,8 +395,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "conflict-not-disjoint",
@@ -411,7 +405,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1),
 		.expected_count_sr_entries = 1,
 		.expected_sr_errors = 1,
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -421,8 +415,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(CLR(REGULAR_REG1, REG_GENMASK(1, 0)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "conflict-reg-type",
@@ -432,7 +425,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 		.expected_active = BIT(0) | BIT(1) | BIT(2),
 		.expected_count_sr_entries = 1,
 		.expected_sr_errors = 2,
-		.entries = (const struct xe_rtp_entry_sr[]) {
+		.table = XE_RTP_TABLE_SR(
 			{ XE_RTP_NAME("basic-1"),
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(REGULAR_REG1, REG_BIT(0)))
@@ -447,8 +440,7 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
 			  XE_RTP_RULES(FUNC(match_yes)),
 			  XE_RTP_ACTIONS(SET(MASKED_REG1, REG_BIT(0)))
 			},
-			{}
-		},
+		),
 	},
 	{
 		.name = "bad-mcr-reg-forced-to-regular",
@@ -458,13 +450,12 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
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
@@ -474,13 +465,12 @@ static const struct rtp_to_sr_test_case rtp_to_sr_cases[] = {
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
 
@@ -492,16 +482,12 @@ static void xe_rtp_process_to_sr_tests(struct kunit *test)
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
-	xe_rtp_process_to_sr(&ctx, param->entries, count_rtp_entries,
-			     reg_sr, false);
+	xe_rtp_process_ctx_enable_active_tracking(&ctx, &active, param->table.n_entries);
+	xe_rtp_process_to_sr(&ctx, &param->table, reg_sr, false);
 
 	xa_for_each(&reg_sr->xa, idx, sre) {
 		if (idx == param->expected_reg.addr)
@@ -534,56 +520,52 @@ static const struct rtp_test_case rtp_cases[] = {
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
@@ -593,13 +575,12 @@ static const struct rtp_test_case rtp_cases[] = {
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
@@ -609,8 +590,7 @@ static const struct rtp_test_case rtp_cases[] = {
 			{ XE_RTP_NAME("r3"),
 			  XE_RTP_RULES(FUNC(match_no)),
 			},
-			{}
-		},
+		),
 	},
 };
 
@@ -620,13 +600,10 @@ static void xe_rtp_process_tests(struct kunit *test)
 	struct xe_device *xe = test->priv;
 	struct xe_gt *gt = xe_device_get_root_tile(xe)->primary_gt;
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(gt);
-	unsigned long count_rtp_entries = 0, active = 0;
+	unsigned long active = 0;
 
-	while (param->entries[count_rtp_entries].rules)
-		count_rtp_entries++;
-
-	xe_rtp_process_ctx_enable_active_tracking(&ctx, &active, count_rtp_entries);
-	xe_rtp_process(&ctx, param->entries);
+	xe_rtp_process_ctx_enable_active_tracking(&ctx, &active, param->table.n_entries);
+	xe_rtp_process(&ctx, &param->table);
 
 	KUNIT_EXPECT_EQ(test, active, param->expected_active);
 }
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index 8c66ff6f3d3c..98265293f2dc 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -346,7 +346,7 @@ hw_engine_setup_default_lrc_state(struct xe_hw_engine *hwe)
 	u32 blit_cctl_val = REG_FIELD_PREP(BLIT_CCTL_DST_MOCS_MASK, mocs_write_idx) |
 			    REG_FIELD_PREP(BLIT_CCTL_SRC_MOCS_MASK, mocs_read_idx);
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
-	const struct xe_rtp_entry_sr lrc_setup[] = {
+	const struct xe_rtp_table_sr lrc_setup = XE_RTP_TABLE_SR(
 		/*
 		 * Some blitter commands do not have a field for MOCS, those
 		 * commands will use MOCS index pointed by BLIT_CCTL.
@@ -369,10 +369,9 @@ hw_engine_setup_default_lrc_state(struct xe_hw_engine *hwe)
 					   PREEMPT_GPGPU_THREAD_GROUP_LEVEL)),
 		  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE)
 		},
-	};
+	);
 
-	xe_rtp_process_to_sr(&ctx, lrc_setup, ARRAY_SIZE(lrc_setup),
-			     &hwe->reg_lrc, true);
+	xe_rtp_process_to_sr(&ctx, &lrc_setup, &hwe->reg_lrc, true);
 }
 
 void xe_hw_engine_setup_reg_lrc(struct xe_hw_engine *hwe)
@@ -408,7 +407,7 @@ hw_engine_setup_default_state(struct xe_hw_engine *hwe)
 	u32 ring_cmd_cctl_val = REG_FIELD_PREP(CMD_CCTL_WRITE_OVERRIDE_MASK, mocs_write_idx) |
 				REG_FIELD_PREP(CMD_CCTL_READ_OVERRIDE_MASK, mocs_read_idx);
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
-	const struct xe_rtp_entry_sr engine_entries[] = {
+	const struct xe_rtp_table_sr engine_sr = XE_RTP_TABLE_SR(
 		{ XE_RTP_NAME("RING_CMD_CCTL_default_MOCS"),
 		  XE_RTP_RULES(FUNC(xe_rtp_match_always)),
 		  XE_RTP_ACTIONS(FIELD_SET(RING_CMD_CCTL(0),
@@ -465,10 +464,9 @@ hw_engine_setup_default_state(struct xe_hw_engine *hwe)
 		  XE_RTP_ACTIONS(SET(GFX_MODE(0), GFX_MSIX_INTERRUPT_ENABLE,
 				     XE_RTP_ACTION_FLAG(ENGINE_BASE)))
 		},
-	};
+	);
 
-	xe_rtp_process_to_sr(&ctx, engine_entries, ARRAY_SIZE(engine_entries),
-			     &hwe->reg_sr, false);
+	xe_rtp_process_to_sr(&ctx, &engine_sr, &hwe->reg_sr, false);
 }
 
 static const struct engine_info *find_engine_info(enum xe_engine_class class, int instance)
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index d3bfc05949ae..2d8ddb57412c 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -41,7 +41,7 @@ static bool match_multi_queue_class(const struct xe_device *xe,
 	return xe_gt_supports_multi_queue(gt, hwe->class);
 }
 
-static const struct xe_rtp_entry_sr register_whitelist[] = {
+static const struct xe_rtp_table_sr register_whitelist = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("WaAllowPMDepthAndInvocationCountAccessFromUMD, 1408556865"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210), ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(WHITELIST(PS_INVOCATION_COUNT,
@@ -156,7 +156,7 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 	  XE_RTP_RULES(FUNC(match_has_mert), ENGINE_CLASS(COPY)),
 	  XE_RTP_ACTIONS(WHITELIST_OA_MERT_MMIO_TRG)
 	},
-};
+);
 
 static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 {
@@ -204,8 +204,7 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
-	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
-			     &hwe->reg_whitelist, false);
+	xe_rtp_process_to_sr(&ctx, &register_whitelist, &hwe->reg_whitelist, false);
 	whitelist_apply_to_hwe(hwe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
index dec9d94e6fb0..83a40e1f9528 100644
--- a/drivers/gpu/drm/xe/xe_rtp.c
+++ b/drivers/gpu/drm/xe/xe_rtp.c
@@ -326,8 +326,7 @@ static void rtp_mark_active(struct xe_device *xe,
  * xe_rtp_process_to_sr - Process all rtp @entries, adding the matching ones to
  *                        the save-restore argument.
  * @ctx: The context for processing the table, with one of device, gt or hwe
- * @entries: Table with RTP definitions
- * @n_entries: Number of entries to process, usually ARRAY_SIZE(entries)
+ * @table: Table with RTP definitions
  * @sr: Save-restore struct where matching rules execute the action. This can be
  *      viewed as the "coalesced view" of multiple the tables. The bits for each
  *      register set are expected not to collide with previously added entries
@@ -339,12 +338,10 @@ static void rtp_mark_active(struct xe_device *xe,
  * used to calculate the right register offset
  */
 void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
-			  const struct xe_rtp_entry_sr *entries,
-			  size_t n_entries,
+			  const struct xe_rtp_table_sr *table,
 			  struct xe_reg_sr *sr,
 			  bool process_in_vf)
 {
-	const struct xe_rtp_entry_sr *entry;
 	struct xe_hw_engine *hwe = NULL;
 	struct xe_gt *gt = NULL;
 	struct xe_device *xe = NULL;
@@ -354,9 +351,10 @@ void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
 	if (!process_in_vf && IS_SRIOV_VF(xe))
 		return;
 
-	xe_assert(xe, entries);
+	xe_assert(xe, table->entries);
 
-	for (entry = entries; entry - entries < n_entries; entry++) {
+	for (size_t i = 0; i < table->n_entries; i++) {
+		const struct xe_rtp_entry_sr *entry = &table->entries[i];
 		bool match = false;
 
 		if (entry->flags & XE_RTP_ENTRY_FLAG_FOREACH_ENGINE) {
@@ -371,37 +369,40 @@ void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
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
index e4f1930ca1c3..4e3cfd69f922 100644
--- a/drivers/gpu/drm/xe/xe_rtp.h
+++ b/drivers/gpu/drm/xe/xe_rtp.h
@@ -461,6 +461,16 @@ struct xe_reg_sr;
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
@@ -471,12 +481,12 @@ void xe_rtp_process_ctx_enable_active_tracking(struct xe_rtp_process_ctx *ctx,
 					       size_t n_entries);
 
 void xe_rtp_process_to_sr(struct xe_rtp_process_ctx *ctx,
-			  const struct xe_rtp_entry_sr *entries,
-			  size_t n_entries, struct xe_reg_sr *sr,
+			  const struct xe_rtp_table_sr *table,
+			  struct xe_reg_sr *sr,
 			  bool process_in_vf);
 
 void xe_rtp_process(struct xe_rtp_process_ctx *ctx,
-		    const struct xe_rtp_entry *entries);
+		    const struct xe_rtp_table *table);
 
 /* Match functions to be used with XE_RTP_MATCH_FUNC */
 
diff --git a/drivers/gpu/drm/xe/xe_rtp_types.h b/drivers/gpu/drm/xe/xe_rtp_types.h
index 0265c16d2762..58018ae4f8cc 100644
--- a/drivers/gpu/drm/xe/xe_rtp_types.h
+++ b/drivers/gpu/drm/xe/xe_rtp_types.h
@@ -112,6 +112,16 @@ struct xe_rtp_entry {
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
index 9a1b3862e192..bf3fad9cdbef 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -20,7 +20,7 @@
 #undef XE_REG_MCR
 #define XE_REG_MCR(...)     XE_REG(__VA_ARGS__, .mcr = 1)
 
-static const struct xe_rtp_entry_sr gt_tunings[] = {
+static const struct xe_rtp_table_sr gt_tunings = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("Tuning: Blend Fill Caching Optimization Disable"),
 	  XE_RTP_RULES(PLATFORM(DG2)),
 	  XE_RTP_ACTIONS(SET(XEHP_L3SCQREG7, BLEND_FILL_CACHING_OPT_DIS))
@@ -100,9 +100,9 @@ static const struct xe_rtp_entry_sr gt_tunings[] = {
 	  XE_RTP_ACTIONS(FIELD_SET(GAMSTLB_CTRL, BANK_HASH_MODE,
 				   BANK_HASH_4KB_MODE))
 	},
-};
+);
 
-static const struct xe_rtp_entry_sr engine_tunings[] = {
+static const struct xe_rtp_table_sr engine_tunings = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("Tuning: L3 Hashing Mask"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210),
 		       FUNC(xe_rtp_match_first_render_or_compute)),
@@ -129,9 +129,9 @@ static const struct xe_rtp_entry_sr engine_tunings[] = {
 		       FUNC(xe_rtp_match_first_render_or_compute)),
 	  XE_RTP_ACTIONS(SET(TDL_TSL_CHICKEN2, TILEY_LOCALID))
 	},
-};
+);
 
-static const struct xe_rtp_entry_sr lrc_tunings[] = {
+static const struct xe_rtp_table_sr lrc_tunings = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("Tuning: Windower HW Filtering"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3599), ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(SET(XEHP_COMMON_SLICE_CHICKEN4, HW_FILTERING))
@@ -171,7 +171,7 @@ static const struct xe_rtp_entry_sr lrc_tunings[] = {
 	  XE_RTP_ACTIONS(FIELD_SET(FF_MODE, VS_HIT_MAX_VALUE_MASK,
 				   REG_FIELD_PREP(VS_HIT_MAX_VALUE_MASK, 0x3f)))
 	},
-};
+);
 
 /**
  * xe_tuning_init - initialize gt with tunings bookkeeping
@@ -185,9 +185,9 @@ int xe_tuning_init(struct xe_gt *gt)
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
@@ -210,9 +210,8 @@ void xe_tuning_process_gt(struct xe_gt *gt)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx,
 						  gt->tuning_active.gt,
-						  ARRAY_SIZE(gt_tunings));
-	xe_rtp_process_to_sr(&ctx, gt_tunings, ARRAY_SIZE(gt_tunings),
-			     &gt->reg_sr, false);
+						  gt_tunings.n_entries);
+	xe_rtp_process_to_sr(&ctx, &gt_tunings, &gt->reg_sr, false);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_tuning_process_gt);
 
@@ -222,9 +221,8 @@ void xe_tuning_process_engine(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx,
 						  hwe->gt->tuning_active.engine,
-						  ARRAY_SIZE(engine_tunings));
-	xe_rtp_process_to_sr(&ctx, engine_tunings, ARRAY_SIZE(engine_tunings),
-			     &hwe->reg_sr, false);
+						  engine_tunings.n_entries);
+	xe_rtp_process_to_sr(&ctx, &engine_tunings, &hwe->reg_sr, false);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_tuning_process_engine);
 
@@ -242,9 +240,8 @@ void xe_tuning_process_lrc(struct xe_hw_engine *hwe)
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx,
 						  hwe->gt->tuning_active.lrc,
-						  ARRAY_SIZE(lrc_tunings));
-	xe_rtp_process_to_sr(&ctx, lrc_tunings, ARRAY_SIZE(lrc_tunings),
-			     &hwe->reg_lrc, true);
+						  lrc_tunings.n_entries);
+	xe_rtp_process_to_sr(&ctx, &lrc_tunings, &hwe->reg_lrc, true);
 }
 
 /**
@@ -259,18 +256,18 @@ int xe_tuning_dump(struct xe_gt *gt, struct drm_printer *p)
 	size_t idx;
 
 	drm_printf(p, "GT Tunings\n");
-	for_each_set_bit(idx, gt->tuning_active.gt, ARRAY_SIZE(gt_tunings))
-		drm_printf_indent(p, 1, "%s\n", gt_tunings[idx].name);
+	for_each_set_bit(idx, gt->tuning_active.gt, gt_tunings.n_entries)
+		drm_printf_indent(p, 1, "%s\n", gt_tunings.entries[idx].name);
 
 	drm_puts(p, "\n");
 	drm_printf(p, "Engine Tunings\n");
-	for_each_set_bit(idx, gt->tuning_active.engine, ARRAY_SIZE(engine_tunings))
-		drm_printf_indent(p, 1, "%s\n", engine_tunings[idx].name);
+	for_each_set_bit(idx, gt->tuning_active.engine, engine_tunings.n_entries)
+		drm_printf_indent(p, 1, "%s\n", engine_tunings.entries[idx].name);
 
 	drm_puts(p, "\n");
 	drm_printf(p, "LRC Tunings\n");
-	for_each_set_bit(idx, gt->tuning_active.lrc, ARRAY_SIZE(lrc_tunings))
-		drm_printf_indent(p, 1, "%s\n", lrc_tunings[idx].name);
+	for_each_set_bit(idx, gt->tuning_active.lrc, lrc_tunings.n_entries)
+		drm_printf_indent(p, 1, "%s\n", lrc_tunings.entries[idx].name);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index cb811f8a7781..b9d9fe0801aa 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -130,7 +130,7 @@
 __diag_push();
 __diag_ignore_all("-Woverride-init", "Allow field overrides in table");
 
-static const struct xe_rtp_entry_sr gt_was[] = {
+static const struct xe_rtp_table_sr gt_was = XE_RTP_TABLE_SR(
 	/* Workarounds applying over a range of IPs */
 
 	{ XE_RTP_NAME("14011060649"),
@@ -306,9 +306,9 @@ static const struct xe_rtp_entry_sr gt_was[] = {
 	  XE_RTP_RULES(GRAPHICS_VERSION(3510), GRAPHICS_STEP(A0, B0)),
 	  XE_RTP_ACTIONS(SET(GUC_INTR_CHICKEN, DISABLE_SIGNALING_ENGINES))
 	},
-};
+);
 
-static const struct xe_rtp_entry_sr engine_was[] = {
+static const struct xe_rtp_table_sr engine_was = XE_RTP_TABLE_SR(
 	/* Workarounds applying over a range of IPs */
 
 	{ XE_RTP_NAME("22010931296, 18011464164, 14010919138"),
@@ -614,9 +614,9 @@ static const struct xe_rtp_entry_sr engine_was[] = {
 		       FUNC(xe_rtp_match_first_render_or_compute)),
 	  XE_RTP_ACTIONS(SET(TDL_CHICKEN, BIT_APQ_OPT_DIS))
 	},
-};
+);
 
-static const struct xe_rtp_entry_sr lrc_was[] = {
+static const struct xe_rtp_table_sr lrc_was = XE_RTP_TABLE_SR(
 	{ XE_RTP_NAME("16011163337"),
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1210), ENGINE_CLASS(RENDER)),
 	  /* read verification is ignored due to 1608008084. */
@@ -794,21 +794,29 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
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
 
@@ -824,10 +832,10 @@ void xe_wa_process_device_oob(struct xe_device *xe)
 {
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(xe);
 
-	xe_rtp_process_ctx_enable_active_tracking(&ctx, xe->wa_active.oob, ARRAY_SIZE(device_oob_was));
+	xe_rtp_process_ctx_enable_active_tracking(&ctx, xe->wa_active.oob, device_oob_was.n_entries);
 
 	xe->wa_active.oob_initialized = true;
-	xe_rtp_process(&ctx, device_oob_was);
+	xe_rtp_process(&ctx, &device_oob_was);
 }
 
 /**
@@ -842,9 +850,9 @@ void xe_wa_process_gt_oob(struct xe_gt *gt)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(gt);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, gt->wa_active.oob,
-						  ARRAY_SIZE(oob_was));
+						  oob_was.n_entries);
 	gt->wa_active.oob_initialized = true;
-	xe_rtp_process(&ctx, oob_was);
+	xe_rtp_process(&ctx, &oob_was);
 }
 
 /**
@@ -859,9 +867,8 @@ void xe_wa_process_gt(struct xe_gt *gt)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(gt);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, gt->wa_active.gt,
-						  ARRAY_SIZE(gt_was));
-	xe_rtp_process_to_sr(&ctx, gt_was, ARRAY_SIZE(gt_was),
-			     &gt->reg_sr, false);
+						  gt_was.n_entries);
+	xe_rtp_process_to_sr(&ctx, &gt_was, &gt->reg_sr, false);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_wa_process_gt);
 
@@ -878,9 +885,8 @@ void xe_wa_process_engine(struct xe_hw_engine *hwe)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.engine,
-						  ARRAY_SIZE(engine_was));
-	xe_rtp_process_to_sr(&ctx, engine_was, ARRAY_SIZE(engine_was),
-			     &hwe->reg_sr, false);
+						  engine_was.n_entries);
+	xe_rtp_process_to_sr(&ctx, &engine_was, &hwe->reg_sr, false);
 }
 
 /**
@@ -896,9 +902,8 @@ void xe_wa_process_lrc(struct xe_hw_engine *hwe)
 	struct xe_rtp_process_ctx ctx = XE_RTP_PROCESS_CTX_INITIALIZER(hwe);
 
 	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.lrc,
-						  ARRAY_SIZE(lrc_was));
-	xe_rtp_process_to_sr(&ctx, lrc_was, ARRAY_SIZE(lrc_was),
-			     &hwe->reg_lrc, true);
+						  lrc_was.n_entries);
+	xe_rtp_process_to_sr(&ctx, &lrc_was, &hwe->reg_lrc, true);
 }
 
 /**
@@ -912,7 +917,7 @@ int xe_wa_device_init(struct xe_device *xe)
 	unsigned long *p;
 
 	p = drmm_kzalloc(&xe->drm,
-			 sizeof(*p) * BITS_TO_LONGS(ARRAY_SIZE(device_oob_was)),
+			 sizeof(*p) * BITS_TO_LONGS(device_oob_was.n_entries),
 			 GFP_KERNEL);
 
 	if (!p)
@@ -935,10 +940,10 @@ int xe_wa_gt_init(struct xe_gt *gt)
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
@@ -962,9 +967,9 @@ void xe_wa_device_dump(struct xe_device *xe, struct drm_printer *p)
 	size_t idx;
 
 	drm_printf(p, "Device OOB Workarounds\n");
-	for_each_set_bit(idx, xe->wa_active.oob, ARRAY_SIZE(device_oob_was))
-		if (device_oob_was[idx].name)
-			drm_printf_indent(p, 1, "%s\n", device_oob_was[idx].name);
+	for_each_set_bit(idx, xe->wa_active.oob, device_oob_was.n_entries)
+		if (device_oob_was.entries[idx].name)
+			drm_printf_indent(p, 1, "%s\n", device_oob_was.entries[idx].name);
 }
 
 /**
@@ -979,24 +984,24 @@ int xe_wa_gt_dump(struct xe_gt *gt, struct drm_printer *p)
 	size_t idx;
 
 	drm_printf(p, "GT Workarounds\n");
-	for_each_set_bit(idx, gt->wa_active.gt, ARRAY_SIZE(gt_was))
-		drm_printf_indent(p, 1, "%s\n", gt_was[idx].name);
+	for_each_set_bit(idx, gt->wa_active.gt, gt_was.n_entries)
+		drm_printf_indent(p, 1, "%s\n", gt_was.entries[idx].name);
 
 	drm_puts(p, "\n");
 	drm_printf(p, "Engine Workarounds\n");
-	for_each_set_bit(idx, gt->wa_active.engine, ARRAY_SIZE(engine_was))
-		drm_printf_indent(p, 1, "%s\n", engine_was[idx].name);
+	for_each_set_bit(idx, gt->wa_active.engine, engine_was.n_entries)
+		drm_printf_indent(p, 1, "%s\n", engine_was.entries[idx].name);
 
 	drm_puts(p, "\n");
 	drm_printf(p, "LRC Workarounds\n");
-	for_each_set_bit(idx, gt->wa_active.lrc, ARRAY_SIZE(lrc_was))
-		drm_printf_indent(p, 1, "%s\n", lrc_was[idx].name);
+	for_each_set_bit(idx, gt->wa_active.lrc, lrc_was.n_entries)
+		drm_printf_indent(p, 1, "%s\n", lrc_was.entries[idx].name);
 
 	drm_puts(p, "\n");
 	drm_printf(p, "OOB Workarounds\n");
-	for_each_set_bit(idx, gt->wa_active.oob, ARRAY_SIZE(oob_was))
-		if (oob_was[idx].name)
-			drm_printf_indent(p, 1, "%s\n", oob_was[idx].name);
+	for_each_set_bit(idx, gt->wa_active.oob, oob_was.n_entries)
+		if (oob_was.entries[idx].name)
+			drm_printf_indent(p, 1, "%s\n", oob_was.entries[idx].name);
 	return 0;
 }
 

