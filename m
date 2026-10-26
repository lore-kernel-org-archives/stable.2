Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021814;
	b=46t/PjrSS6ob5SsyE1rZeT3ADhmXXzrU8GNQraoe52JqOpIP+8Z9lpjl+zOP2A9qW+Wv
	 DS+CRNx6oYpd0AGniZc/lOnkfDw2A2Nr/Jm3BpPdkni//g6KY5xNjp56voXaw5kbkK2oJ
	 ij/6iqhyxijPZ86OySRu//ldP5iKsHjgC1qR6/wXusceZPvhL6EV4VxpnPXaKz4NFHrUK
	 qJYGUpzGpBWSEhUFBLLX/vlp9DDsA4q8pfz6bgYLSGi7pkkxze8c4a357kPZSW+L9SGPd
	 NdYn4QidGGjp6h1ycw45uTz9LVX3/uQynfvA/gwvqb5JsCT61U0ioMrmYSgOp1DQ49Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021814;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QYZ0XMP0Wi8hecXFzBwOfGQ9AN/zBa/t/RaItnxb0wg=;
	b=SJkeHy0X0DtSU9dpnm6Xr0xRWSIOHwWPJEyzT9PgXUG9eyh73So/UUt9kkPwZSTCfrZI
	 +fTLrJzQjHEUFJf5AgkbudvDastR5qeuI9k4cFsxQCewgYhtWRujejJVvNuNI1Uw3OWzN
	 I3BvrkyVMFQbE4dB9PX7weHgRDAFuRHAQlF80CtYbS09gXyCXPBWWJY28cl/Qg2511ouT
	 v749kLs62pDdGLDUI843YdbliIOSSYjtYdAMpmuAaXvMMQ8eX6ThnUFxz2Q8vxtU2M08P
	 u1ngjVJDkKHKu8qdte04nPxHScYUxO1P1env/Q/TyAdaUx5qVdT4KTIKOs7wJGmKIYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Nk/QG8F8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EED606A31B;
	Mon, 26 Oct 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nk/QG8F8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431841F01825;
	Mon, 26 Oct 2026 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021813;
	bh=QYZ0XMP0Wi8hecXFzBwOfGQ9AN/zBa/t/RaItnxb0wg=;
	h=From:To:Cc:Subject:Date;
	b=Nk/QG8F87cBP4iJGeTUTM8JjtvVnB52rR0VsL7gkPmHXSjlReJAJfz4uTnoMucvw9
	 ArjLJKQ6q5JP7JsQvMebOc1oI+NgAFJkpEL3XUQPA4sQZgMMYNjMBVAjKqJ4A6Q3S7
	 CEGZ9GFnUYrZT1cYNkE27HeTrAJypC7Ty40woI474vn37WU3XtNgpiQg1RB8JYLLE4
	 NQROOXGsCoO0oIHfTvibdAlt+ckfQytLwm+lVSFWbYBOYQJLB6yF7DDVAsX5T4DqAc
	 06NrMSxu5RwO5h4/lOuNP6htVihjZwB0q3HAYTjeqiGzKcIgb6v69dQks39XMWvUNK
	 LQ5XWOzmWxT9Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [RFC PATCH 7.2.y v2] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Mon, 26 Oct 2026 06:36:43 -0700
Message-ID: <20261026133645.119485-1-sj@kernel.org>
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

Also, the upstream commit on this stable kernel can fix the issue for
parameters commit paths but DAMON start path.  That's because DAMON
start path does not invoke damon_commit_quota_goals().  To fix the path
with minimum change, add a new small validation of quota goal target
value before damon_start() call.

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
- RFC: https://lore.kernel.org/20261025172434.161597-1-sj@kernel.org
- Add a validation for damon_start() path.

 mm/damon/core.c  | 22 ++++++++++++++++------
 mm/damon/sysfs.c | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+), 6 deletions(-)

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
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 26cdad603ad06..9c7e34f18b28f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2226,6 +2226,20 @@ static int damon_sysfs_repeat_call_fn(void *data)
 	return 0;
 }
 
+static bool damon_sysfs_valid_start_ctx(struct damon_ctx *ctx)
+{
+	struct damos *s;
+	struct damos_quota_goal *g;
+
+	damon_for_each_scheme(s, ctx) {
+		damos_for_each_quota_goal(g, &s->quota) {
+			if (!g->target_value)
+				return false;
+		}
+	}
+	return true;
+}
+
 static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 {
 	struct damon_ctx *ctx;
@@ -2251,6 +2265,11 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 		kfree(repeat_call_control);
 		return PTR_ERR(ctx);
 	}
+	if (!damon_sysfs_valid_start_ctx(ctx)) {
+		kfree(repeat_call_control);
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
 	err = damon_start(&ctx, 1, false);
 	if (err) {
 		kfree(repeat_call_control);

base-commit: cc9de5d4b5ab6459f5774946aa3195ad51236fa8
-- 
2.47.3
