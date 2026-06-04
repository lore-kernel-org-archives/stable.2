Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A71F1534;
	Thu,  4 Jun 2026 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583723; cv=none; b=QDCL5zc5ETILiO06aZ7v/clRrVVfzk6eT2Uo9Zz4tioJHMZZw4mcxOGOStfaPJjqJMqHhyEFhmPI/il8RQCmffv+TlG62GXa6oJ+/B6Cbz862CX9uZQjg/7eSPOxWSxwBMcvKsdzlnpghvTdyQoX0nzJkaw3q/WefzkCNS+XmuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583723; c=relaxed/simple;
	bh=sLdz640Nny3Q+uhLCrx8j2DCb9DIqaeRvn21Qp7p43M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+BitSEfwWHmL4nDPxheHyOvxfMitPY9u1anEQI7cTFOwT2mGn6U+4VPtTiweVH05bHGfc7Huu/ZhdLHEEF8bbIINeIrCGgz7gcpHgImuuq5EVxKOOJZnxxbvhd1YMi6A2xDXoz8+189QZpqa17giUv/vH84S7d1sLc4vnteLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElwbEHai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElwbEHai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56451F00893;
	Thu,  4 Jun 2026 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780583722;
	bh=vgLl/p3qkGVQ4J0lmKFNqcECALdu6p7bDPIjji6x+rw=;
	h=From:To:Cc:Subject:Date;
	b=ElwbEHaiF9IANaaSytaLz7EQlu4/Ut/lrGHBqHUmDI9GqM32kqROX2k3s6R9oZ7HO
	 CmFNXNc0tCreViLwZ1EdrWC3D015+uxhUrLiO6o2N3iVQmMduj0A9lILeInKuNAScc
	 TArZZ0o463TVLgqlK5TyivceCRd8CIN+6YhOurHJSSdn1eR5pmqUV9XdkJSTnpTQlF
	 9FQxxclMfLLMtP+ub6Sg+x6B8UJCcwqpK+w8wNYNMn2y+dNwgaPq4caZHJK3WAhPNN
	 hTMKViaQXzV5jQjjDG+Ltjy3udAOEvOXzyity8vnqeCRDkuvmzN4BKu5WemCBhTMGB
	 i+W1jgcaDdg+g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 11 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1] mm/damon/core: always put unsuccessfully committed target pids
Date: Thu,  4 Jun 2026 07:35:08 -0700
Message-ID: <20260604143514.84310-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_commit_target() puts and gets the destination and the source
target pids.  It puts the destination target pid because it will be
overwritten by the source target pid.  It gets the source pid because
the caller is supposed to eventually put the pids.  In more detail, the
caller will call damon_destroy_ctx() after damon_commit_ctx() to destroy
the entire source context.  And in this case, [f]vaddr operation set's
cleanup_target() callback will put the pids.

The commit operation is made at the context level.  The operation can
fail in multiple places including in the middle and after the targets
commit operations.  For any such failures, immediately the error is
returned to the damon_commit_ctx() caller.  If some or all of the source
target pids were committed to the destination during the unsuccessful
context commit attempt, those pids should be put twice.

The source context will do the put operations using the above explained
routine.  However, let's suppose the destination context was not
originally using [f]vaddr operation set and the commit failed before the
ops of the source context is committed.  The destination does not have
the cleanup_target() ops callback, so it cannot put the pids via the
damon_destroy_ctx().

As a result, the pids are leaked.  The issue in the real world would be
not very common.  The commit feature is for changing parameters of
running DAMON context while inheriting internal status like the
monitoring results.  The monitoring results of a physical address range
ain't have things that are beneficial to be inherited to a virtual
address ranges monitoring.  So the problem-causing DAMON control would
be not very common in the real world.  That said, it is a supported
feature. And damon_commit_target() failure due to memory allocation is
relatively realistic [1] if there are a huge number of target regions.

Fix by putting the pids in the commit operation in case of the failures.

The issue was discovered [2] by Sashiko.

[1] https://lore.kernel.org/20260603112306.58490-1-akinobu.mita@gmail.com
[2] https://lore.kernel.org/20260320020056.835-1-sj@kernel.org

Fixes: 83dc7bbaecae ("mm/damon/sysfs: use damon_commit_ctx()")
Cc: <stable@vger.kernel.org> # 6.11.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC
- rfc: https://lore.kernel.org/20260604042349.67720-1-sj@kernel.org
- Check destination cleaanup availability using the cleanup callback.
- Do the cleanup for all commit failure points in
  [targets commit, ops commit] scope.
- Wordsmith the commit message.
- Add 'Fixes:' and Cc: stable@.

 mm/damon/core.c | 55 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 265d51ade25bf..7e4b9affc5b06 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1387,10 +1387,36 @@ static int damon_commit_target(
 	return 0;
 }
 
+/*
+ * damon_revert_target_commits() - revert unsuccessful target commits.
+ * @dst:	Commit destination context
+ * @failed:	Commit failed destination target
+ * @src:	Commit source context
+ *
+ * Revert target states that changed by damon_commit_target(), and cannot be
+ * cleaned up by the destination context's ops.cleanup_target().
+ */
+static void damon_revert_target_commits(struct damon_ctx *dst,
+		struct damon_target *failed, struct damon_ctx *src)
+{
+	struct damon_target *target;
+
+	if (!damon_target_has_pid(src))
+		return;
+	if (dst->ops.cleanup_target)
+		return;
+	damon_for_each_target(target, dst) {
+		if (target == failed)
+			return;
+		put_pid(target->pid);
+	}
+}
+
 static int damon_commit_targets(
 		struct damon_ctx *dst, struct damon_ctx *src)
 {
 	struct damon_target *dst_target, *next, *src_target, *new_target;
+	struct damon_target *failed;
 	int i = 0, j = 0, err;
 
 	damon_for_each_target_safe(dst_target, next, dst) {
@@ -1404,8 +1430,10 @@ static int damon_commit_targets(
 					dst_target, damon_target_has_pid(dst),
 					src_target, damon_target_has_pid(src),
 					src->min_region_sz);
-			if (err)
-				return err;
+			if (err) {
+				failed = dst_target;
+				goto out;
+			}
 		} else {
 			struct damos *s;
 
@@ -1419,25 +1447,34 @@ static int damon_commit_targets(
 		}
 	}
 
+	failed = NULL;
 	damon_for_each_target_safe(src_target, next, src) {
 		if (j++ < i)
 			continue;
 		/* target to remove has no matching dst */
-		if (src_target->obsolete)
-			return -EINVAL;
+		if (src_target->obsolete) {
+			err = -EINVAL;
+			goto out;
+		}
 		new_target = damon_new_target();
-		if (!new_target)
-			return -ENOMEM;
+		if (!new_target) {
+			err = -ENOMEM;
+			goto out;
+		}
 		err = damon_commit_target(new_target, false,
 				src_target, damon_target_has_pid(src),
 				src->min_region_sz);
 		if (err) {
 			damon_destroy_target(new_target, NULL);
-			return err;
+			goto out;
 		}
 		damon_add_target(dst, new_target);
 	}
 	return 0;
+
+out:
+	damon_revert_target_commits(dst, failed, src);
+	return err;
 }
 
 static void damon_commit_filter(struct damon_filter *dst,
@@ -1571,8 +1608,10 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	 */
 	if (!damon_attrs_equals(&dst->attrs, &src->attrs)) {
 		err = damon_set_attrs(dst, &src->attrs);
-		if (err)
+		if (err) {
+			damon_revert_target_commits(dst, NULL, src);
 			return err;
+		}
 	}
 	dst->pause = src->pause;
 	dst->ops = src->ops;

base-commit: eeac72cb1b86b53f95c1596ec43db17827a8355e
-- 
2.47.3
