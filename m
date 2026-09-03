Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7FB388887
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461257; cv=none; b=uDWeQH+tLTnSy5OFACO1kPPDhV5BDsHiZFmo89ERA6ROxy5rJrZ63CSaq9Id0/3GQyrokKsogsnH++sfZ8votu4YMCTuncziOhoYpnYBjoFZKk+uOrQLwmvkaGDbwcA1qRYTJJjdUpTw9R+4A7mAUHv1htKxq6avPizQO4Zeyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461257; c=relaxed/simple;
	bh=rpOkNHVJnBMrLmLTLBYQQmsvRMTeTPs4hQNbIoiypb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byyKCAfIXdyIkQnV2IuzXjzr/hF5S9WP4tS5hAhMrc3gVsUXsO4o5kkOUZAxkdxpMza2mxQtCq7j6wsn86cAoc15YCe1EfCHGM5n6rFZ8x1u0i8qiLi+wq4GG7j9uAtym1kMKSK+Yy24cdAMljOZFp0rzJiGczlsoZCa/NI0NL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj8RhtUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj8RhtUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D251F000E9;
	Thu,  3 Sep 2026 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788461256;
	bh=6yrOEz03TWfjS3NwtSe8fXlXXVqyhT/szgV94ap/+J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nj8RhtUxfzYnIoG+nNWLoYt/ak2DiXOeYnbwpql6uDQqAps2r90AhUpIMIrwFSyFY
	 ZNR2Q02yHwABsWMV7ch4ThOaIZwim592bGiy5ySgTJLjuLHraLkJpYc0BXZimv3Ig0
	 5TOH/t3XExMBwVCgUlo3AHn5kCFXe9yasktKUGlYoogRNKvjMiOYRYIAXQ0x8nd1nt
	 TFjyoMNfDPy1bwVIdmTeMo1oy84rfShNZQr0APYzIR0Zx2TpletwbSI9lUx+KW2rsb
	 P1yAtiYtfpi3H2zJ+sQYUPAY+9LqDTSJeE7MAPNHGrGZRe1v/JNq1CsUTqyOrMqXMA
	 KynlkuOPpZDqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/7] mm/kmemleak: use _irq lock/unlock variants in kmemleak_scan/_clear()
Date: Thu,  3 Sep 2026 14:47:27 -0400
Message-ID: <20260903184733.1484444-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090333-boney-opium-0272@gregkh>
References: <2026090333-boney-opium-0272@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit 00c155066eca8bcfc9b255db017119b84eea6909 ]

Patch series "mm/kmemleak: Avoid soft lockup in kmemleak_scan()", v2.

There are 3 RCU-based object iteration loops in kmemleak_scan().  Because
of the need to take RCU read lock, we can't insert cond_resched() into the
loop like other parts of the function.  As there can be millions of
objects to be scanned, it takes a while to iterate all of them.  The
kmemleak functionality is usually enabled in a debug kernel which is much
slower than a non-debug kernel.  With sufficient number of kmemleak
objects, the time to iterate them all may exceed 22s causing soft lockup.

  watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [kmemleak:625]

This patch series make changes to the 3 object iteration loops in
kmemleak_scan() to prevent them from causing soft lockup.

This patch (of 3):

kmemleak_scan() is called only from the kmemleak scan thread or from write
to the kmemleak debugfs file.  Both are in task context and so we can
directly use the simpler _irq() lock/unlock calls instead of the more
complex _irqsave/_irqrestore variants.

Similarly, kmemleak_clear() is called only from write to the kmemleak
debugfs file. The same change can be applied.

Link: https://lkml.kernel.org/r/20220614220359.59282-1-longman@redhat.com
Link: https://lkml.kernel.org/r/20220614220359.59282-2-longman@redhat.com
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 5d10d4e19e6d ("mm/kmemleak: avoid soft lockup when scanning task stacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 527d4dce3baa3..8f7aa881566e5 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1409,7 +1409,6 @@ static void scan_gray_list(void)
  */
 static void kmemleak_scan(void)
 {
-	unsigned long flags;
 	struct kmemleak_object *object;
 	struct zone *zone;
 	int __maybe_unused i;
@@ -1420,7 +1419,7 @@ static void kmemleak_scan(void)
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		raw_spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irq(&object->lock);
 #ifdef DEBUG
 		/*
 		 * With a few exceptions there should be a maximum of
@@ -1437,7 +1436,7 @@ static void kmemleak_scan(void)
 		if (color_gray(object) && get_object(object))
 			list_add_tail(&object->gray_list, &gray_list);
 
-		raw_spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irq(&object->lock);
 	}
 	rcu_read_unlock();
 
@@ -1505,14 +1504,14 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		raw_spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irq(&object->lock);
 		if (color_white(object) && (object->flags & OBJECT_ALLOCATED)
 		    && update_checksum(object) && get_object(object)) {
 			/* color it gray temporarily */
 			object->count = object->min_count;
 			list_add_tail(&object->gray_list, &gray_list);
 		}
-		raw_spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irq(&object->lock);
 	}
 	rcu_read_unlock();
 
@@ -1532,7 +1531,7 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		raw_spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irq(&object->lock);
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
@@ -1542,7 +1541,7 @@ static void kmemleak_scan(void)
 
 			new_leaks++;
 		}
-		raw_spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irq(&object->lock);
 	}
 	rcu_read_unlock();
 
@@ -1744,15 +1743,14 @@ static int dump_str_object_info(const char *str)
 static void kmemleak_clear(void)
 {
 	struct kmemleak_object *object;
-	unsigned long flags;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		raw_spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irq(&object->lock);
 		if ((object->flags & OBJECT_REPORTED) &&
 		    unreferenced_object(object))
 			__paint_it(object, KMEMLEAK_GREY);
-		raw_spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irq(&object->lock);
 	}
 	rcu_read_unlock();
 
-- 
2.53.0

