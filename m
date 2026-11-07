Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046791;
	b=IFGdIXskDQUHs9kbfLv2luKhZsjomkWaWrJmWLDE+wgEuihqxY51hoVgIM8VuDiDy6Qc
	 H8Hu9Kxo6R2DZb11iOL9kT7xJdVHDUNHCP4IJlTawCtNh0MVxFsA6yAFR9vCi1dYy0OyK
	 /vedmgzUissXMYEds2EYW7on4CAY3rsjOHejVBlQDMGBqcqQUlzR05YeMo1tNXn8TSADp
	 zyQhEUYfqbpMx0S4UH4VsuT485dv+T+2CRMeQPYtKCqxezr1R4PB4zgzHJ74pNwYpUHzJ
	 1ORIHhvmfsiOlUEXPNJGJndSugI1D6Zg+hXpshntFiRhwpgFHb0DdsObviD2dWFA2ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046791;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6IFWpKsTD4PdFQRKY/prX4oTwnX5GBpQY/TY6pZb478=;
	b=EDT4EfSvJDawThiwzsdCEU5uMD5YSoF4xCFEaBYD+zJ2MOZu1b0wdc8UHLLlvum42JC2
	 3FdoMhCkJTsy/1YFK9QlUXDbfhdjlSqv5oXe00cy56zuo/BsiOsCoOztG0i5593gWW0JD
	 4Rb651CUMTJ2fSI9YyfQKLH1X7/Ehh5qdcs1OhuvV63JxsGZCQDqxf/g+S9NN3th0HREY
	 6r8u5KzSV//dIRaqkTJLDKwTtLQoY4YyuS9Cs/76qYG9lIquCthi6wSSS5OAEh4TXYvHa
	 8kiTRInR+EEZT8rzjXEL7IAczoW0b9yXveE7EJ+fiJqh9M25vf6EkTz3X/qHFDhM+Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOZBl3s8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363C606EEBE
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOZBl3s8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E7B1F0089F;
	Sat,  7 Nov 2026 10:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046790;
	bh=6IFWpKsTD4PdFQRKY/prX4oTwnX5GBpQY/TY6pZb478=;
	h=From:To:Cc:Subject:Date;
	b=mOZBl3s8hBNIisLQ0NOutDdoVJBFpewji422HKTL2Iom7AlM5zJbl1wOlzZMRyu4c
	 5J95wtC9Y/1cDziMmjTLC1ZfULYxeMVeJn2n2Opndx9sJvumVvEAn0laHpfxG7pUCS
	 r57vb3oBq7Ow7ScNUWTupUYQ2l9K3cZgfSFK9lPXXyO1M72AlzuuKlLO+0YIR8OiOb
	 XdUVBKx5bK3o3exxr5eDTVru4OQN30UX6QVsWFjvIpg2qib4W5q5y7k8WF2Y9vQ35a
	 j35xmNdnM3aMCsdl1lGx6BglQp0h6D/pUcLCIof6lgDhWK0in0QBJs9CS0zx730KBB
	 eVypeyHrGhuyQ==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: keep the temporal tuner quota over an unmeasured PSI round" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:49 -0500
Message-ID: <20261107051949-failed-6.12-df7d9a0f8d91@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x df7d9a0f8d916eeea375430ae3360724afecde15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051949-failed-6.12-df7d9a0f8d91@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From df7d9a0f8d916eeea375430ae3360724afecde15 Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Tue, 22 Sep 2026 22:51:37 -0700
Subject: [PATCH] mm/damon/core: keep the temporal tuner quota over an
 unmeasured PSI round

The patch in mm-unstable of subject "mm/damon/core: handle uninitialized
damos_quota_goal->last_psi_total" scores a PSI quota goal without a
previous sample as achieved.  This leaves the consist tuner's input
unchanged, but the temporal tuner sets its quota to zero for an achieved
goal.  A running scheme with a nonzero temporal quota therefore loses a
charge window after a quota-goal commit.

Use the effective quota to preserve the temporal tuner's previous
goal-achievement state during an unmeasured round, as SJ suggested [1].
Score the goal as achieved when the effective quota is zero and as not
achieved otherwise.  A new scheme's initially zero quota stays zero, and
the consist tuner's behavior is unchanged.

Move the PSI current-value calculation and last_psi_total update into a
helper that takes the current PSI total.  This lets a unit test cover the
unmeasured and measured rounds without depending on system memory
pressure.

Link: https://lore.kernel.org/20260923055139.2982-1-sj@kernel.org
Link: https://lore.kernel.org/damon/20260916001311.101024-1-sj@kernel.org/ [1]
Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goal")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: SJ Park <sj@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Assisted-by: LLM
Cc: Lian Wang <lianux.mm@gmail.com>
Cc: <stable@vger.kernel.org> # 6.9.x
---
 mm/damon/core.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f950a3b9fcb99..71e8cedbc6439 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2891,6 +2891,28 @@ static inline u64 damos_get_some_mem_psi_total(void)
 
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
@@ -3143,13 +3165,7 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
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
-- 
2.53.0




