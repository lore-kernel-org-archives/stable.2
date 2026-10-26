Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021610;
	b=rtBBBlSoYkOaBYSMQmSdgNREMx5TkicOBGSf7r2nrJ9v6tbDb1WYHC52Pcuo4OvZczee
	 txZrezPpId5R4PezGMVs7LjsX4aPFv9HDBn4zFZwXQfn5dPeMPHJKnnqo50LqF2doL5ZW
	 JMBgnJXJ8SaR9dVhmIYupEzGP71xCLClkZhLc46IWIl84YSDA7CSYDwoyNYVXcXtGNb+Q
	 /kDg4uco9pJf+JNSV269L4MHZomJQQq1mSOk9G3MA9A6kZtHkEC/U6QoTeMz2lSsXq2bb
	 Kgk3iSKpOht/dmrCpHiJSmfeirCbAqn0foX3+GseE99ommGgxEj6ZvQnpSN8PItkr5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3QJjgBNhhMcU2h8ryMvyVAOJo+FmKjFcCzZY6PKW7M8=;
	b=FKz3SZcLF6d6fgxtF7czBHL/UUc2pm8GsTLTOC5Qg60XsUmuaxXg+6121d8wpQjyLS3a
	 m7AvWfHxHNUwKfH9MrjE495YbQ41aE8iY8pAx23gX3mlK2nDMzTL/hQEZOXqEJwpJ+YRO
	 uawo40HMfmjwpgnpVlXVXgNhC8JegmjF1rbs6HfrJl3UImjUgUDt7WcQZgSWfYLJITBPp
	 QsTLXaQ2RJvThhENeH+Hci1ej4dwzWpEfcIQEUaTd5I3iiZEApvqS4fyfdmTZ3NVlrzir
	 SgammXmqXzKmsSpD6L3ZUCNzaUOcjinU4pb3WbfjXf0S5vZasCs3IwEOL8KYJxG4TRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8gwXBfE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099B606A31A;
	Mon, 26 Oct 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8gwXBfE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1CE1F01825;
	Mon, 26 Oct 2026 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021609;
	bh=3QJjgBNhhMcU2h8ryMvyVAOJo+FmKjFcCzZY6PKW7M8=;
	h=From:To:Cc:Subject:Date;
	b=d8gwXBfEJjO1rmMFiYe3Ur+g7oPaJCfSXRVjqlORKGG4scOzcIY9NsU46uIErcxZP
	 nIXuqF7X/B78sTjJdf0FDC3r4xDSAp7rFeQsbBtQzCeToh74fGL2UHzvv/4uk3v5Fz
	 Ub0Pbei+dlTqQ0wNVDPmggdAPCto0QzjDesvuS5+rNk5mmgyMVTd8PbqAjBVOpe881
	 JCHNQvKyRtsz0/IMKprpdc9rVIJeU7Z8y/a2f0meIXaT6pDjYP9FK3ZtrXOwMKLHWm
	 k+LPldK9/bEqSHejvXSogwMO2m3PsAbAYtNNuRLYr0OUGJeB0hJSxKEd7aWIoFGSmt
	 A4Vxra7J4HCuQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7.3.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Mon, 26 Oct 2026 06:33:16 -0700
Message-ID: <20261026133320.68445-1-sj@kernel.org>
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
Changes from RFC
- RFC: https://lore.kernel.org/20261025171526.157414-1-sj@kernel.org
- Drop RFC tag.

 mm/damon/core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ab3c4d7549644..74d22a596fc13 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1136,15 +1136,18 @@ static void damos_commit_quota_goal_union(
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
@@ -1162,14 +1165,17 @@ static void damos_commit_quota_goal(
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
@@ -1178,7 +1184,11 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
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

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.47.3
