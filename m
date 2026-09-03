Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE82C11E6
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474656; cv=none; b=Zt1/cVzo5A6mwfkAHx0VqxG6nWjQ1TRYW0IL1aZAV6EXBrgEGJik8UeWCIUaVZrTHs+92CzPRBFpAt74udGW3707QieO9L7OzZJAEcKxzrV1ghkiBPWk/IMhXQ5bhXJHPXZqH4mTvWiDALTieW4gbwqRiqhkuVqNOCUetXHdyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474656; c=relaxed/simple;
	bh=Ol+YG33clXCil4a2V09XykqF2qo1v10YML8wYtKlC/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqUC13FXj/bHvkbQguQJTVTYkBhhy6tUy7LE3tRWWDNwNws68Xzm5Ya2lprKXiaE3XmbIqjtlcigXcLZOmcEnDpaXoTWijEKOjwfnw+WjvCteIiefH/rzTMnPGL6MqbLPYoVFA6z4dlUHT0wpNa9O6E5KqLSTmn3cSy1OaOew44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHfbryNV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHfbryNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6601F00A3E;
	Thu,  3 Sep 2026 22:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474655;
	bh=3usAjBhl9+Lztdp8TAZ7lY3fK52X21fnhaZl3CsLW/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LHfbryNVCq9Dt9ofHUnruKNG20S0BEzpeYYrtpclEJgzDJXvcY3vb5egT0YnURSFV
	 jATFllY5d4WNrnqAtb3l+TIf38JEoNDjNWc/tL404SELkCMFNAeeddbjs5QqGtfzx4
	 EQMnhT+09+ysW2+oniYCp8YqjD+08PeubUQRea68ehGL83Mqhi512AiyuziTfLv89s
	 43qpEsp/cZ/pQgzL8x9xkNuOuo6McyNyz1NKaQQxBx1M5Bbm2O6GOOPDJMkQbSDFU2
	 R4sgGtgZHbZX8IHDL4psIuEa2nfxB+A1kZEj8wDZwr12mbdE0Gsy9xefbxDuGkZ4wd
	 xHov03JuhNabA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/7] mm/kmemleak: simplify kmemleak_cond_resched() usage
Date: Thu,  3 Sep 2026 18:30:47 -0400
Message-ID: <20260903223049.1740340-5-sashal@kernel.org>
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
index 7de39d541a2e7..091cc228c81a7 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1403,22 +1403,17 @@ static void scan_gray_list(void)
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
@@ -1432,15 +1427,12 @@ static void kmemleak_scan(void)
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
@@ -1455,19 +1447,13 @@ static void kmemleak_scan(void)
 #endif
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
 
@@ -1534,14 +1520,9 @@ static void kmemleak_scan(void)
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
@@ -1576,14 +1557,9 @@ static void kmemleak_scan(void)
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

