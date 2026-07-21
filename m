Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D673403E1;
	Tue, 21 Jul 2026 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611629; cv=none; b=WW1bhqG6oI1qguX4TxQb4sWW3D+BXNA36dJaWAa79Grs4fWchKlIm13qRKFZTGF8nijx65R/VXfpF3yRZGrIDNytuD7AMiaBzXA1BOZZq0Gw9yXumpoVQ3CxtsVzaMLlxR4WrVJ1pKb1UwcQUnN98yt+fcFv1GvJ07fGbx8uJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611629; c=relaxed/simple;
	bh=In/7xE4xOKhCQwKX2GwH37KZiKLFTMuvVFb0sseK64Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5LROO9Vxew9xaGNAIyMm65rLYBm7TLVsqaFAcisd8LIyrSwxYT0mPYZH8vOgsSvqvKD6kwhm5FBVUtrsoRZAyd+9taSu67Cx63kd+Mx+nm64RGzjaqesC/arDOeDKOjjtjnMg/DGMOcPX8W258MMIgdXE6gmkbxQgT2Oj12zBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS9zdTtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS9zdTtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129811F000E9;
	Tue, 21 Jul 2026 05:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784611628;
	bh=aTn/tdiIdUd/VKwE0RBna1J0T6yQ7J8btE4WeJ6zkKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aS9zdTtkzddMpH7LODNohJiPOeIVqF+jc/enVpEXw9aFXZ13RHh6RnmscRR85aMpZ
	 4o4ZfQ359NbXU3ZKzvo5kko5s808JbCrP9sFni77UiP+hfTeIAfumRkRbwwpfjPDnF
	 uUo9Dvj9H5fEWhXG0mcWqO7eAx9h4fzJBoQgqFC8w1srOeZ/4VvLicO2+t+ONvWOTA
	 oYCvgibX1K7RG3VRstVVKZe1Li8xDyT8GFoIwzis54//2+K9WdLsdJvZGJlKV20qKM
	 ezqqWsnnbkKIp98Yuwyq8OnScLjpAkqeR38uXnHWXzE9noARyT9fL5rsI3jbl1ILd1
	 l5jadjP+7CAZg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/core: always put unsuccessfully committed target pids
Date: Mon, 20 Jul 2026 22:26:59 -0700
Message-ID: <20260721052659.166596-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072031-machine-rectified-f366@gregkh>
References: <2026072031-machine-rectified-f366@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

damon_commit_target() puts and gets the destination and the source target
pids.  It puts the destination target pid because it will be overwritten
by the source target pid.  It gets the source pid because the caller is
supposed to eventually put the pids.  In more detail, the caller will call
damon_destroy_ctx() after damon_commit_ctx() to destroy the entire source
context.  And in this case, [f]vaddr operation set's cleanup_target()
callback will put the pids.

The commit operation is made at the context level.  The operation can fail
in multiple places including in the middle and after the targets commit
operations.  For any such failures, immediately the error is returned to
the damon_commit_ctx() caller.  If some or all of the source target pids
were committed to the destination during the unsuccessful context commit
attempt, those pids should be put twice.

The source context will do the put operations using the above explained
routine.  However, let's suppose the destination context was not
originally using [f]vaddr operation set and the commit failed before the
ops of the source context is committed.  The destination does not have the
cleanup_target() ops callback, so it cannot put the pids via the
damon_destroy_ctx().

As a result, the pids are leaked.  The issue in the real world would be
not very common.  The commit feature is for changing parameters of running
DAMON context while inheriting internal status like the monitoring
results.  The monitoring results of a physical address range ain't have
things that are beneficial to be inherited to a virtual address ranges
monitoring.  So the problem-causing DAMON control would be not very common
in the real world.  That said, it is a supported feature.  And
damon_commit_target() failure due to memory allocation is relatively
realistic [1] if there are a huge number of target regions.

Fix by putting the pids in the commit operation in case of the failures.

The issue was discovered [2] by Sashiko.

Link: https://lore.kernel.org/20260605013849.83750-1-sj@kernel.org
Link: https://lore.kernel.org/20260603112306.58490-1-akinobu.mita@gmail.com [1]
Link: https://lore.kernel.org/20260320020056.835-1-sj@kernel.org [2]
Fixes: 83dc7bbaecae ("mm/damon/sysfs: use damon_commit_ctx()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.11.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 6a66c557a2ab2609575bafd15e093669c05f9711)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 49 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 00c80b7c8c3f6..2b7e0ee772f32 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1173,10 +1173,36 @@ static int damon_commit_target(
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
@@ -1186,8 +1212,10 @@ static int damon_commit_targets(
 					dst_target, damon_target_has_pid(dst),
 					src_target, damon_target_has_pid(src),
 					src->min_sz_region);
-			if (err)
-				return err;
+			if (err) {
+				failed = dst_target;
+				goto out;
+			}
 		} else {
 			struct damos *s;
 
@@ -1201,22 +1229,29 @@ static int damon_commit_targets(
 		}
 	}
 
+	failed = NULL;
 	damon_for_each_target_safe(src_target, next, src) {
 		if (j++ < i)
 			continue;
 		new_target = damon_new_target();
-		if (!new_target)
-			return -ENOMEM;
+		if (!new_target) {
+			err = -ENOMEM;
+			goto out;
+		}
 		err = damon_commit_target(new_target, false,
 				src_target, damon_target_has_pid(src),
 				src->min_sz_region);
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
 
 /**
@@ -1255,8 +1290,10 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	 */
 	if (!damon_attrs_equals(&dst->attrs, &src->attrs)) {
 		err = damon_set_attrs(dst, &src->attrs);
-		if (err)
+		if (err) {
+			damon_revert_target_commits(dst, NULL, src);
 			return err;
+		}
 	}
 	dst->ops = src->ops;
 	dst->addr_unit = src->addr_unit;
-- 
2.47.3

