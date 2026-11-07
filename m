Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046136;
	b=2UMH7pZnJFqK8myO8E9WTHBflc7BQo2nv2wPXKE7r7DYzD0G5a0/i9KhmkuYFzs27BZj
	 fxo/Ad3BRmhc7Avh3i0XtdUhogXA9oTwiXlP/9DfYgNaXZvgEWG6O4ONhc628aTK6uVRM
	 yWRr8YtFL8mBNUcxvChw4sBnLRCjFoiYn18izxPixtGjYX01sG4aRRX5BQoUjzSsIqpPy
	 tFm15j9dyKES4FlZNlxbSMytvWXwblLACfCHvd+Xam2budtF/Bu0iMEr8BdoBVfnn8rtr
	 ll5ddqaz5Mk807714gIPQtsYlgXU1N3djfiTmdj3KuR+NaDaGv9jDwxf/D6ync+S2MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046136;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SAmLEHMj9g1iGWa9alP+3PpTscT3uLacngLCcO6DFik=;
	b=bK7YSnDJgtJZPq81VXxvLkWvJB5Ud4wy98NY4ybCNxGutYJxvVeNKnf0qKUL7XzGgl15
	 kCeIXINn0MTnLMffz9Bvmy2DGk5Xa7vrw5reHIztQniuEzhw4x3FGD7APmYhDtTE+lXcF
	 NMxIG5mTE+xxVhctRY8lP2okNbuXBiKYTxbC5RDhB2luLzqXaAqhsO48HrXXSYrgsgWBb
	 GQTMTu13dDmu9oNaLqsh1Cxcvr0GnK69eC/rohc6mrcmj+3rqVVBealoOORPFzzNbz+dD
	 +uigEBM+nLntFUYvVmaayWzmxj++r1ISfia0zdh01Oq+ttSOsB1R9dVXoXPZnZxTamg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KE6B3tKS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC874606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KE6B3tKS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192E11F0089F;
	Sat,  7 Nov 2026 10:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046135;
	bh=SAmLEHMj9g1iGWa9alP+3PpTscT3uLacngLCcO6DFik=;
	h=From:To:Cc:Subject:Date;
	b=KE6B3tKSS0xy+gu+kKFe4QsCYR2NCx36haP3/tuy/kx6F3Sw0orVzbNIn0HyUkXgL
	 kkAUlnJHZ3DQnK3G8tevJdXxWFdCCabK30h/mhp9zuIDv75/n8jkbXhv6uasoO2JII
	 xz6IeyUjFbmBPdVUEwKn4Ls9ClG5OBbBfHDCm6AI7tgjqP5fDXOrmkGRcN+97E88pw
	 4Od8KsZ6wqT8cCwhuZEY894Re/Uuj/l09tUo7wlAIeYmzZwdu/BznF3mkAublm4jNT
	 9cnI9fL+0MLBJzMrjdr2s6/vFN+E5/27DTfxnEr9yjcxMlN0LG+xIjASkfs7nlcViQ
	 kpvWaYVRVDfuw==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: keep the temporal tuner quota over an unmeasured PSI round" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:54 -0500
Message-ID: <20261107050853-failed-6.18-df7d9a0f8d91@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x df7d9a0f8d916eeea375430ae3360724afecde15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050853-failed-6.18-df7d9a0f8d91@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




