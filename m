Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949082;
	b=bH9N/mvC6Fxza7Inp+TSRR3fsSQ9h0pz83CokP2ygPo7UpTSlKMQh4JW/HJDEB/1MbHr
	 lTnBrlqbYE/eODWgkH8f8RVhd8kKuto98nyd096IR7QRldIB25yRqjVDnMiRgOnuprLOP
	 82VnNZivd2Jpnm+e9KyDU7H41lnNBZYKMXAw/1ZtNHeUvfzL7RIhSMJy1AC278bK0IXmU
	 kEO8Scftv4KaL8VOzpJgow/YDzkkqdRD6WwKrWTiRszFuDBqqlziAI0wNFirIZJA+NY8Q
	 5H3x4Tb+1wgPeuQoFFwYb56ulR/USBJD8OfW9ieZc68i0bRr0GBPN2r+83jW5H1Gqyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949082;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nkyq5l5Ghq356yzBoCQoLTfgpUWLS8pHN4Yf4mmGPPY=;
	b=P1X6zkluvDluIqSaidL90nrEw81UohkK0TbeUzT0vHfNfKFWeehyHJOMCeZE9r8pSphg
	 qYh7KqKgPkxjkJ8aJaXgONN6nhmeFxQVwYKyXxm4hmdgxNlQkdecZIu9lj4fVt7QJIa6w
	 KyJgtzpnM0yrT+7l4LbNoH2OVyc+aNznEiQuBy98e/QB+jvHdSHuk7s8xkl2DLe9w+6cY
	 oDg52xRPOEErY3d+y/44hynrYO+IzUfQ15UGndpbDFg+JNkNV95yh5pD3uqfpWjxm93el
	 XTc3P3OGZhHYWbN+F1Ss/VBEawe5iBEML9HD/szQQRG6IJIpd4H8Tf50dJHKzxtghFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRuk66ln;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A823606A31A;
	Sun, 25 Oct 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRuk66ln
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D951F01825;
	Sun, 25 Oct 2026 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792949082;
	bh=Nkyq5l5Ghq356yzBoCQoLTfgpUWLS8pHN4Yf4mmGPPY=;
	h=From:To:Cc:Subject:Date;
	b=HRuk66lnQ323DJ5rahzb6qhwxDGn6mSnG/OoMieII1aNcbThS8GTGdhLTWrMRwnHE
	 jyNNoBGOE67u6yYAPu6VzYdJLoOlkJG/GkCT21fg0Bt5bV/XcZq8Sx3bhmXa6+oGMD
	 kDzVMGAhpkkIj9e1nKkws1Lz1Gk+LEz9z0GRDh/lEvNybeG8VQ+r3CbijM0ZhKppYH
	 P9Cdd0dhVEgRz1hsmzXhwo2kNh8xhyDBcbM+EIZpiYTau95GgtpIjAdqp3Wpb3WC9b
	 2zAXuHxg80A09TjU+nt/ThqpAZwveIpWQjb/xKZVq5B/U3WnpTz+FVXDUpAr6SS+N8
	 oitVY8v1hQbSg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [RFC PATCH 7.2.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Sun, 25 Oct 2026 10:24:33 -0700
Message-ID: <20261025172434.161597-1-sj@kernel.org>
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
index 40714c69d1b18..0aefaef46d655 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -999,15 +999,18 @@ static void damos_commit_quota_goal_union(
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
@@ -1025,14 +1028,17 @@ static void damos_commit_quota_goal(
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
@@ -1041,7 +1047,11 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
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

base-commit: cc9de5d4b5ab6459f5774946aa3195ad51236fa8
-- 
2.47.3
