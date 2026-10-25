Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949240;
	b=SHj9A+CyEzqiGZCsAuhmF8Grv95NIi5z6SnkPSeTOsFftw3lAN11+iwoK+Q6LUwXNKBZ
	 nvGj4o4vcjTY+f6orBPCkRuQfOIPet+bfLrBy/KTfNIjPC6S9FnOIkzsGApDohRmekFfZ
	 B1gI5Ij5QAeQ5ZQfM4fdEdWY+miGn0a4N5P+LAkZyFBZAMLqDmoR6l8XpEddkoYC/A7k5
	 65xkEp23N0jituhjijMz0Bbx4vkI9PJoSKUhpoKCZIVKWH3/fF+4uFOT0yrRvBvRsy6WG
	 Bgw8W9E3C0yxuemcDvw5Y3O6T5TY5F/6NJFmYVYZOpv4R3J1QjDXQjXwtpX/0zwPM2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949240;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uOoKQ2PnkH09Vk1jw7K1oh5n4BU041veL5ZwyfeSI9g=;
	b=1zQouGOAmfc+AhpJYbQ572035rk5SYH6HalCnHxoqk7PloTcWsBF+/y++kaLLRAhB9OW
	 sBgR/v4D3+IRYxVVUACI4qHLxNOzfrg/KflDcHeYVi/z6Ixiq9OzLU/ozJYZitYawLhw6
	 BR6IEb/V6+UPad/DeA0k+alW1e4w07Y9EflGK1+ki1VuM3Zvr81KXixvnRu7oZujapw8B
	 W+oYmrRfAnuZmqX/8/4iGV0NFUDhcAtCjTCmsRhf9wZg+tf7sbljot5XtIymjr1foXHrX
	 yn4R81SAv/XjdB/mkiVYXN86OmsJJoxO6ot0++RXTHvux78zEbL48BJ/C15BtaWV1mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LKbdKhtl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE3606A31A;
	Sun, 25 Oct 2026 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LKbdKhtl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC121F01825;
	Sun, 25 Oct 2026 17:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792949239;
	bh=uOoKQ2PnkH09Vk1jw7K1oh5n4BU041veL5ZwyfeSI9g=;
	h=From:To:Cc:Subject:Date;
	b=LKbdKhtlyoXURqlHoGmzBroiGrBMDMwQO1Q9HBle3p+cQ765zXSLB2jNShjsJ5ykb
	 N10s504jTVCUf4j+0yDuodsW8/2mDeb7BAzowMIQcOo7lCzbVhf5VBSKelePNmpO+p
	 5Rs16+C1rzGZ50gNvBXCwwHzeZBWKnmYEZctC5hF/0CJUf7lL/e6GBS3no8v5VxUs2
	 EBC9QhmAPQHktZ/2ASugUX9625olkz8QfRHdWMAFVZFsdSxhXQfNLp3k8iFswsOjSL
	 HF0oxKb2vyt2QN1VsBNaidu+ax5pfO7ZNVnJh6ha2A47FpgMdRbC8pvOLXBiZgV/CF
	 kYfb5EgoFAAAQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [RFC PATCH 6.18.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Sun, 25 Oct 2026 10:27:10 -0700
Message-ID: <20261025172712.164385-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch series "mm/damon: move zero damos quota target_value handling to the
core layer".

Having zero DAMOS quota target value can cause division by zero.  DAMON
API callers are checking the target value parameters to avoid that.  It is
easy to make mistakes in some of the multiple API callers.  Move that to
the core layer.

Patch 1 adds the corner case handling into the core layer DAMON parameters
validation logic.  Patches 2 and 3 remove no more needed DAMON API callers
side handling of the corner case in DAMON_LRU_SORT and DMON_SAMPLIE_MTIER,
respectively.

This patch (of 3):

If a DAMOS scheme has a damos_quota_goal of zero target_value,
damos_quota_goal() could trigger division-by-zero error.  Hence each DAMON
API callers should do the zero target_value validation.  It is easy to
make mistakes.  Actually such bugs in DAMON_LRU_SORT and
DAMON_SAMPLE_MTIER were found and fixed [1].

It is better to handle the corner case only once in the core layer,
instead of multiple places in all DAMON API callers.  One straightforward
option is using an alternative denominator for the corner case in the
damos_quota_goal().  However, the zero target_value is meaningless.  In
this case, the quota goal is always evaluated as achieved or
over-achieved.  The quota will only keep being reduced.

Simply avoid using zero target_value by adding a check in the core layer
DAMOS quota goal parameters validation/commit path,
damos_commit_quota_goal().  Update it to return an error in the case.
Also update its caller to propagate the error.

Notes for stable kernel porting.  The upstream commit doesn't have
Fixes: and therefore not ported to stable kernels.  It turned out it
fixes commit 8b549a4fd3c5 ("mm/damon/sysfs-schemes: commit damos quota
goals user input to DAMOS") which was merged into v6.8.  The user impact
is a race condition that can result in divide-by-zero.  Hence backport.
Reproducing the issue requires sysfs write permission, certain DAMON ABI
usages that are supposed to be uncommon, and a rare race timing, though.
The issue was discovered [2] by Sashiko as a part [3] of its bug report.

[2] https://sashiko.dev/#/bug/linux-7f814c9a-986f-4103-a55a-ef9537dcf62b
[3] https://lore.kernel.org/20261021005234.94107-1-sj@kernel.org

Link: https://lore.kernel.org/20260903010722.94244-1-sj@kernel.org
Link: https://lore.kernel.org/20260903010722.94244-2-sj@kernel.org
Link: https://lore.kernel.org/20260803134034.15217-1-sj@kernel.org [1]
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 610c4438fb66e06d9e693c0ad3b2c1be54c0d61f)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4e6e3d7d0a5c0..8fa788b0d709c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -807,15 +807,18 @@ static void damos_commit_quota_goal_union(
 	}
 }
 
-static void damos_commit_quota_goal(
+static int damos_commit_quota_goal(
 		struct damos_quota_goal *dst, struct damos_quota_goal *src)
 {
+	if (!src->target_value)
+		return  -EINVAL;
 	dst->metric = src->metric;
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
 	/* keep last_psi_total as is, since it will be updated in next cycle */
 	damos_commit_quota_goal_union(dst, src);
+	return 0;
 }
 
 /**
@@ -833,14 +836,17 @@ static void damos_commit_quota_goal(
 int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 {
 	struct damos_quota_goal *dst_goal, *next, *src_goal, *new_goal;
-	int i = 0, j = 0;
+	int i = 0, j = 0, err;
 
 	damos_for_each_quota_goal_safe(dst_goal, next, dst) {
 		src_goal = damos_nth_quota_goal(i++, src);
-		if (src_goal)
-			damos_commit_quota_goal(dst_goal, src_goal);
-		else
+		if (src_goal) {
+			err = damos_commit_quota_goal(dst_goal, src_goal);
+			if (err)
+				return err;
+		} else {
 			damos_destroy_quota_goal(dst_goal);
+		}
 	}
 	damos_for_each_quota_goal_safe(src_goal, next, src) {
 		if (j++ < i)
@@ -849,7 +855,11 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 				src_goal->metric, src_goal->target_value);
 		if (!new_goal)
 			return -ENOMEM;
-		damos_commit_quota_goal(new_goal, src_goal);
+		err = damos_commit_quota_goal(new_goal, src_goal);
+		if (err) {
+			damos_free_quota_goal(new_goal);
+			return err;
+		}
 		damos_add_quota_goal(dst, new_goal);
 	}
 	return 0;

base-commit: 2926d88bb7fc4608fd942453d929c39e4e5ec006
-- 
2.47.3
