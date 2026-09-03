Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B74FDE42
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457717; cv=none; b=IgZeUxYRfe53eNLRATWvX8xhx6qfsUlQm9JBWEX4UNEBXdaA/mULLEw9ibkIZJzLKBc2Jr0Lixq7IJbMLbKMEN0YgLs+mqoqEHA0hraTT9Jlfj9YnHK0ALSsWSLcqp6o7OuqWAjxbCFyQf2EVWYgRFlwprZu3s651O9GhQtRlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457717; c=relaxed/simple;
	bh=Xv1FDhdC+OCVthmmpLxp065jGD9Bmni4JiLzQO6ogxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9/e6m9+AKdryu9c1xUlYiaJnzZFuKm6o013t+6mCspiz0lfyt0yazPkHstjVkc7MSD1OFRJi7v5e0Xxg5pMcCxltmC6AkNL2/KEQl0pn6FEb2vNUbbuTT1UR3cRW6dFATiY3V9246FLq59Mtw7Vk+3gpc15qB9NEIoh+rS+ocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAwzz/s0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAwzz/s0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D731F00A3D;
	Thu,  3 Sep 2026 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788457715;
	bh=O1Bi5XYuxLAgTGhb2E03aODDxR6Y2F3xp0uv7lwzs+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BAwzz/s0yQzoSExNPnmv55d/jN4ORIvlK7k6pP8j5SFhrzuGtLsLpuWY0q63DmxDl
	 Jox5MsU5HTxLH25mrL+8zm6Kt8p4ABX3nN8WfX3yZvsE98SPXbAGfyujBqylB23zEt
	 +fpwI9fD2+JmR4VoPN4I/rNLVW2Ga56czgmMM2D/4mZiWSZhcVtQqcTByAwamc3mOf
	 pE/BxxHlHLmtg4dj0WVHgMIQOU3vztbZsQgm5VyGKaaKo0dC2909E2JciFH+AkgR0l
	 axZNO8fJMPFvepaVbLBYu3xjkc6xdcvEzl/eltkCacdr2Nuj0IsRqB1c+vRZNjP4qc
	 C4VFgAzSutH7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] mm/kmemleak: simplify kmemleak_cond_resched() usage
Date: Thu,  3 Sep 2026 13:48:30 -0400
Message-ID: <20260903174832.1263842-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903174832.1263842-1-sashal@kernel.org>
References: <2026090332-elliptic-contort-6cb3@gregkh>
 <20260903174832.1263842-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit 6061e740822530a4ef443548b19c4e0bc6342c7a ]

Patch series "mm/kmemleak: Simplify kmemleak_cond_resched() & fix UAF", v2.

It was found that a KASAN use-after-free error was reported in the
kmemleak_scan() function.  After further examination, it is believe that
even though a reference is taken from the current object, it does not
prevent the object pointed to by the next pointer from going away after a
cond_resched().

To fix that, additional flags are added to make sure that the current
object won't be removed from the object_list during the duration of the
cond_resched() to ensure the validity of the next pointer.

While making the change, I also simplify the current usage of
kmemleak_cond_resched() to make it easier to understand.

This patch (of 2):

The presence of a pinned argument and the 64k loop count make
kmemleak_cond_resched() a bit more complex to read.  The pinned argument
is used only by first kmemleak_scan() loop.

Simplify the usage of kmemleak_cond_resched() by removing the pinned
argument and always do a get_object()/put_object() sequence.  In addition,
the 64k loop is removed by using need_resched() to decide if
kmemleak_cond_resched() should be called.

Link: https://lkml.kernel.org/r/20230119040111.350923-1-longman@redhat.com
Link: https://lkml.kernel.org/r/20230119040111.350923-2-longman@redhat.com
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 5d10d4e19e6d ("mm/kmemleak: avoid soft lockup when scanning task stacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 48 ++++++++++++------------------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index eaa89f20cd35d..83f885a55bff7 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1475,22 +1475,17 @@ static void scan_gray_list(void)
 /*
  * Conditionally call resched() in a object iteration loop while making sure
  * that the given object won't go away without RCU read lock by performing a
- * get_object() if !pinned.
- *
- * Return: false if can't do a cond_resched() due to get_object() failure
- *	   true otherwise
+ * get_object() if necessaary.
  */
-static bool kmemleak_cond_resched(struct kmemleak_object *object, bool pinned)
+static void kmemleak_cond_resched(struct kmemleak_object *object)
 {
-	if (!pinned && !get_object(object))
-		return false;
+	if (!get_object(object))
+		return;	/* Try next object */
 
 	rcu_read_unlock();
 	cond_resched();
 	rcu_read_lock();
-	if (!pinned)
-		put_object(object);
-	return true;
+	put_object(object);
 }
 
 /*
@@ -1504,15 +1499,12 @@ static void kmemleak_scan(void)
 	struct zone *zone;
 	int __maybe_unused i;
 	int new_leaks = 0;
-	int loop_cnt = 0;
 
 	jiffies_last_scan = jiffies;
 
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		bool obj_pinned = false;
-
 		raw_spin_lock_irq(&object->lock);
 #ifdef DEBUG
 		/*
@@ -1538,19 +1530,13 @@ static void kmemleak_scan(void)
 
 		/* reset the reference count (whiten the object) */
 		object->count = 0;
-		if (color_gray(object) && get_object(object)) {
+		if (color_gray(object) && get_object(object))
 			list_add_tail(&object->gray_list, &gray_list);
-			obj_pinned = true;
-		}
 
 		raw_spin_unlock_irq(&object->lock);
 
-		/*
-		 * Do a cond_resched() every 64k objects to avoid soft lockup.
-		 */
-		if (!(++loop_cnt & 0xffff) &&
-		    !kmemleak_cond_resched(object, obj_pinned))
-			loop_cnt--; /* Try again on next object */
+		if (need_resched())
+			kmemleak_cond_resched(object);
 	}
 	rcu_read_unlock();
 
@@ -1617,14 +1603,9 @@ static void kmemleak_scan(void)
 	 * scan and color them gray until the next scan.
 	 */
 	rcu_read_lock();
-	loop_cnt = 0;
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		/*
-		 * Do a cond_resched() every 64k objects to avoid soft lockup.
-		 */
-		if (!(++loop_cnt & 0xffff) &&
-		    !kmemleak_cond_resched(object, false))
-			loop_cnt--;	/* Try again on next object */
+		if (need_resched())
+			kmemleak_cond_resched(object);
 
 		/*
 		 * This is racy but we can save the overhead of lock/unlock
@@ -1659,14 +1640,9 @@ static void kmemleak_scan(void)
 	 * Scanning result reporting.
 	 */
 	rcu_read_lock();
-	loop_cnt = 0;
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		/*
-		 * Do a cond_resched() every 64k objects to avoid soft lockup.
-		 */
-		if (!(++loop_cnt & 0xffff) &&
-		    !kmemleak_cond_resched(object, false))
-			loop_cnt--;	/* Try again on next object */
+		if (need_resched())
+			kmemleak_cond_resched(object);
 
 		/*
 		 * This is racy but we can save the overhead of lock/unlock
-- 
2.53.0

