Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA2D17B50A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474655; cv=none; b=LyEgR3g9MkSN4UepmnG5QvTgFiekKEP8OqWApR+THwwq0CArR+uXSKd5GPinye/wMu7hW+eUMAuEDAtHbRwjQ7/g0RGi6SRf0rDMnwZ8EubyaBfUevHh2222D5aeid5FpHngFA6FkBsfToNzF8Ozxz03SaQj0jm8bXd4rgx7gAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474655; c=relaxed/simple;
	bh=LGG/27Ko/XotSh2ZsTg28sj274yKmhMEvY0rVxn3sDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmt6nD0ZxfojQHWRV2GUt4cj5k840IfZSwBmQnRbUVAIH6xNWk7UF/+SKRUqexH4y0b0gUFYbnE/BmoVuDsk4hKn9r++pHIK1VzR3eEy4jz0CdsZVolyrcOO9ddbCxhhoQMiYGXVUG5x6b7LfU9aDq9p1LK18uUY4hQErLM515M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny++Pq9v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny++Pq9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C2A1F000E9;
	Thu,  3 Sep 2026 22:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474654;
	bh=w2b29Xrs9UJhUZy8m4Uq4cm/qpm4H+V4FgVSE99/7SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ny++Pq9vA7QEDLP9PEDDMsA23fHuU6Zyx8Z9jegfhtqahpXRt6Eeu/Xo9VLa89Kne
	 N8rHpLtWgFKFuHqlAuZUaPigF13GhWP6k5t9eKnEX3tCqrpJPPrOOqZev0I/3peQMw
	 HJ5QSGaGh3xl93CCHke8NR87K+TcvaGMZRpDdXtPhI8N+dr3DI/oEldyxfTHnVnY8P
	 mH427S0fYlwVKepFsBgGhb+oscNkAFImnuNnTJnxqXx7ISF/ndTvSa4/J/Z6UvMldb
	 KgNkEqC1B5UTUlBj5NTUT9Cvx5DbkPlzlu+ivUloS3W+5Axmc33kck1+dgTvGAdf+j
	 kpI7o+DYVTZrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/7] mm/kmemleak: prevent soft lockup in kmemleak_scan()'s object iteration loops
Date: Thu,  3 Sep 2026 18:30:46 -0400
Message-ID: <20260903223049.1740340-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903223049.1740340-1-sashal@kernel.org>
References: <2026090334-dreamboat-playpen-3c4e@gregkh>
 <20260903223049.1740340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit 984a608377cb623351b8a3670b285f32ebeb2d32 ]

Commit 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first object
iteration loop of kmemleak_scan()") adds cond_resched() in the first
object iteration loop of kmemleak_scan().  However, it turns that the 2nd
objection iteration loop can still cause soft lockup to happen in some
cases.  So add a cond_resched() call in the 2nd and 3rd loops as well to
prevent that and for completeness.

Link: https://lkml.kernel.org/r/20221020175619.366317-1-longman@redhat.com
Fixes: 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first object iteration loop of kmemleak_scan()")
Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 5d10d4e19e6d ("mm/kmemleak: avoid soft lockup when scanning task stacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 61 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 276c8a1e2476f..7de39d541a2e7 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1400,6 +1400,27 @@ static void scan_gray_list(void)
 	WARN_ON(!list_empty(&gray_list));
 }
 
+/*
+ * Conditionally call resched() in a object iteration loop while making sure
+ * that the given object won't go away without RCU read lock by performing a
+ * get_object() if !pinned.
+ *
+ * Return: false if can't do a cond_resched() due to get_object() failure
+ *	   true otherwise
+ */
+static bool kmemleak_cond_resched(struct kmemleak_object *object, bool pinned)
+{
+	if (!pinned && !get_object(object))
+		return false;
+
+	rcu_read_unlock();
+	cond_resched();
+	rcu_read_lock();
+	if (!pinned)
+		put_object(object);
+	return true;
+}
+
 /*
  * Scan data sections and all the referenced memory blocks allocated via the
  * kernel's standard allocators. This function must be called with the
@@ -1411,7 +1432,7 @@ static void kmemleak_scan(void)
 	struct zone *zone;
 	int __maybe_unused i;
 	int new_leaks = 0;
-	int loop1_cnt = 0;
+	int loop_cnt = 0;
 
 	jiffies_last_scan = jiffies;
 
@@ -1420,7 +1441,6 @@ static void kmemleak_scan(void)
 	list_for_each_entry_rcu(object, &object_list, object_list) {
 		bool obj_pinned = false;
 
-		loop1_cnt++;
 		raw_spin_lock_irq(&object->lock);
 #ifdef DEBUG
 		/*
@@ -1443,24 +1463,11 @@ static void kmemleak_scan(void)
 		raw_spin_unlock_irq(&object->lock);
 
 		/*
-		 * Do a cond_resched() to avoid soft lockup every 64k objects.
-		 * Make sure a reference has been taken so that the object
-		 * won't go away without RCU read lock.
+		 * Do a cond_resched() every 64k objects to avoid soft lockup.
 		 */
-		if (!(loop1_cnt & 0xffff)) {
-			if (!obj_pinned && !get_object(object)) {
-				/* Try the next object instead */
-				loop1_cnt--;
-				continue;
-			}
-
-			rcu_read_unlock();
-			cond_resched();
-			rcu_read_lock();
-
-			if (!obj_pinned)
-				put_object(object);
-		}
+		if (!(++loop_cnt & 0xffff) &&
+		    !kmemleak_cond_resched(object, obj_pinned))
+			loop_cnt--; /* Try again on next object */
 	}
 	rcu_read_unlock();
 
@@ -1527,7 +1534,15 @@ static void kmemleak_scan(void)
 	 * scan and color them gray until the next scan.
 	 */
 	rcu_read_lock();
+	loop_cnt = 0;
 	list_for_each_entry_rcu(object, &object_list, object_list) {
+		/*
+		 * Do a cond_resched() every 64k objects to avoid soft lockup.
+		 */
+		if (!(++loop_cnt & 0xffff) &&
+		    !kmemleak_cond_resched(object, false))
+			loop_cnt--;	/* Try again on next object */
+
 		/*
 		 * This is racy but we can save the overhead of lock/unlock
 		 * calls. The missed objects, if any, should be caught in
@@ -1561,7 +1576,15 @@ static void kmemleak_scan(void)
 	 * Scanning result reporting.
 	 */
 	rcu_read_lock();
+	loop_cnt = 0;
 	list_for_each_entry_rcu(object, &object_list, object_list) {
+		/*
+		 * Do a cond_resched() every 64k objects to avoid soft lockup.
+		 */
+		if (!(++loop_cnt & 0xffff) &&
+		    !kmemleak_cond_resched(object, false))
+			loop_cnt--;	/* Try again on next object */
+
 		/*
 		 * This is racy but we can save the overhead of lock/unlock
 		 * calls. The missed objects, if any, should be caught in
-- 
2.53.0

