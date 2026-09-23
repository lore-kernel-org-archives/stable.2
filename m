Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9E396D1C;
	Wed, 23 Sep 2026 05:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142706; cv=none; b=UVWwI/Bjrjpcrp6/JH5f5oMa4DL0Y/QYTky1Qfl7ZhObSDxZrXLi0LPvH0XlEE8cul820ituxyu1p12HHv6VV2OFm8LJREu/2W3DlRr5npJjHQN24kCJrPN6Oc0X6j2kfOJdlGPfVO34xBDybIE5QLG80Yf9xzbrcttxvfqC3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142706; c=relaxed/simple;
	bh=hl+lctSgHeH8LsGLS9EjhS79ndVepOyxbkJiqZbhjS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GxaUtVLxRFP9VHiLh4fv4WJZX9BhRXZhh9ri0Cep6tXYHLEP3J25p3OWyrfsDyQ7YdOmhmmukszCw2UtnAfD7wX+lf9oax8O0XPFPDc7g+4pqN49712QQ7MD+5loRe9x4QTO0BkxbsRmU8N4i+Xi6rltW9dTLz4mqSv9dgV9fQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+L1P/dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+L1P/dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0421F00893;
	Wed, 23 Sep 2026 05:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142704;
	bh=uqgctrpnFzYOtbOt5wZGBlKqk7cGr2WeKbcX5dCUKD4=;
	h=From:To:Cc:Subject:Date;
	b=e+L1P/dhR24eSLFlOTson5Yi/0/8uoPtR9P4xlGDvFJ1hRE5HBfmlRYmtmgBRZc83
	 GQ4h253+BzvB7O/Q1WJx+uk0UcoAFDyeI+HB9xYjDrgAayPLJxAtLGzxmY9qJgKTEA
	 Of3wjRxTN3wZzfYYHaJCh36Cf8L1dH0BbzkgXMqhVf9wLOrsFehMQUE6xyeIAHXIFQ
	 gSNWV87N3n4eVef6VVrnrCUqMZT2PA9ZQ4D0uMErG9v6Ve0JZt6dDrn5KwBxTSytR+
	 BDBDYA69md4T5reqcZ3B+btSCkCRXDLF9cb5HuF4HcnfkTbhhcBrMlojMnLnKuoDKX
	 UDxMLcR2VubAQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 mm-unstable] mm/damon/core: keep the temporal tuner quota over an unmeasured PSI round
Date: Tue, 22 Sep 2026 22:51:37 -0700
Message-ID: <20260923055139.2982-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

The patch in mm-unstable of subject "mm/damon/core: handle uninitialized
damos_quota_goal->last_psi_total" scores a PSI quota goal without a
previous sample as achieved. This leaves the consist tuner's input
unchanged, but the temporal tuner sets its quota to zero for an achieved
goal. A running scheme with a nonzero temporal quota therefore loses a
charge window after a quota-goal commit.

Use the effective quota to preserve the temporal tuner's previous
goal-achievement state during an unmeasured round, as SJ suggested [1].
Score the goal as achieved when the effective quota is zero and as not
achieved otherwise. A new scheme's initially zero quota stays zero, and
the consist tuner's behavior is unchanged.

Move the PSI current-value calculation and last_psi_total update into a
helper that takes the current PSI total. This lets a unit test cover the
unmeasured and measured rounds without depending on system memory
pressure.

Link: https://lore.kernel.org/damon/20260916001311.101024-1-sj@kernel.org/ [1]
Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goal")
Cc: <stable@vger.kernel.org> # 6.9.x
Cc: Lian Wang <lianux.mm@gmail.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Suggested-by: SJ Park <sj@kernel.org>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
This is a fixup of a patch [1] that is still in mm-unstable tree.

[1] https://lore.kernel.org/20260902002725.108635-3-sj@kernel.org

Changes from v2
- v2: https://lore.kernel.org/20260921020013.33105-1-kmehltretter@gmail.com
- Split out of the series for squashing into the broken patch.
- Collect R-b: from SJ.
- Update commit message to make clear this is a fixup of a patch in
  mm-unstable.
Changes since v1
 - v1: https://lore.kernel.org/20260915060937.3423-1-kmehltretter@gmail.com/
 - Use the previous effective quota for the temporal decision, including
   when it is zero. Keep resetting last_psi_total for new and updated
   goals.
 - Move the current-value calculation and last_psi_total update into a
   helper. Test both tuners with explicit samples and check
   last_psi_total after each call.

 mm/damon/core.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4687b909d42c..733025b36745 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2956,6 +2956,28 @@ static inline u64 damos_get_some_mem_psi_total(void)
 
 #endif	/* CONFIG_PSI */
 
+static void damos_set_psi_current_val(u64 now_psi_total,
+		struct damos_quota_goal *goal, struct damos *s)
+{
+	u64 last_psi_total = goal->last_psi_total;
+
+	goal->last_psi_total = now_psi_total;
+	if (last_psi_total != U64_MAX) {
+		goal->current_value = now_psi_total - last_psi_total;
+		return;
+	}
+	/* uninitialized last_psi_total; make no effect this round */
+	if (s->quota.goal_tuner == DAMOS_QUOTA_GOAL_TUNER_CONSIST) {
+		goal->current_value = goal->target_value;
+		return;
+	}
+	/* let temporal tuner show the same achievement as in the last round */
+	if (!s->quota.esz)
+		goal->current_value = goal->target_value;
+	else
+		goal->current_value = 0;
+}
+
 #ifdef CONFIG_NUMA
 static bool invalid_mem_node(int nid)
 {
@@ -3208,13 +3230,7 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 		break;
 	case DAMOS_QUOTA_SOME_MEM_PSI_US:
 		now_psi_total = damos_get_some_mem_psi_total();
-		/* uninitialized last_psi_total; make no effect this round */
-		if (goal->last_psi_total == U64_MAX)
-			goal->current_value = goal->target_value;
-		else
-			goal->current_value = now_psi_total -
-				goal->last_psi_total;
-		goal->last_psi_total = now_psi_total;
+		damos_set_psi_current_val(now_psi_total, goal, s);
 		break;
 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:

base-commit: 4b811cf44e3dd87981f18631be832027385f7d4f
-- 
2.47.3
