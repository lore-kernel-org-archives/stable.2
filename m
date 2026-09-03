Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B51A6815
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474653; cv=none; b=FAYQZnsazZZzOllKtFYC6k9vQA2ZdwcJRfQA+z8nYNyvL3+LfiX+IauZoTLxSHlBodP+rx77F8g94CFZqvh9Dv2oodTpWODVaht3mf0pwKXG1+48etcNTWmSZu56cwuLEY5DiERj21tdN90DL1Y4GnWsHkmZh6jNjWfiQo7wLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474653; c=relaxed/simple;
	bh=UlZ3d9baChf51rg+7u9BjCiuJJiuKZU17NyYicVN+Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgYGoe2JL4SrJyrHIqIpj9Gk7LOOXpkoG9eZ9NawYoJKVEDHBoR/BwWcQtmzeS9LPlok9Gc42uLDbV5nJCb/keguti+eh/qn5xwlnRwU0t5aDmZNI51/AT9Efk7fdQ2+cVtNsEAeVsn+ko70LmptEjBVD7tEFPhZrpD/FiL3cLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlByrtx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlByrtx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6EC1F000E9;
	Thu,  3 Sep 2026 22:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474651;
	bh=Uns8dAvW633oiVjm80ME3O6jslt7Dzel+RgROo/5QNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LlByrtx9ehxXcb30EfxEEuhLKbC3x6JjY2/R05Sk3SQuQcISUZMGKvF+ugWVJogql
	 +fiol/BketV8G6/L3DMm4YNu1g2QWXaWqSZBKB3iTKkK+be7YTW8Ya4WHxwe6gp4I+
	 3OYwYW13MyXnQPTJXaiSdKSteJdrUttAIsAJAEP1k2sGQFaLntQzBamR4Cg0yxnl8O
	 TCLG5rztw0pm3PujXEuxKiIu0nYCU41+tsGQQhlGKSZfrs1Bqfs/n7sn+Ag6qF9Hu0
	 cVjZepBP3ofRoKjZXVHHW93crcNMTegAYRpMz3198vmAOJCYR3XwtRpb6TPccBxxHd
	 2HDtGbeI+I+/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/7] mm/kmemleak: use _irq lock/unlock variants in kmemleak_scan/_clear()
Date: Thu,  3 Sep 2026 18:30:43 -0400
Message-ID: <20260903223049.1740340-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090334-dreamboat-playpen-3c4e@gregkh>
References: <2026090334-dreamboat-playpen-3c4e@gregkh>
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
index b977c8b6af7e5..64f1033986e28 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1407,7 +1407,6 @@ static void scan_gray_list(void)
  */
 static void kmemleak_scan(void)
 {
-	unsigned long flags;
 	struct kmemleak_object *object;
 	struct zone *zone;
 	int __maybe_unused i;
@@ -1418,7 +1417,7 @@ static void kmemleak_scan(void)
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		raw_spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irq(&object->lock);
 #ifdef DEBUG
 		/*
 		 * With a few exceptions there should be a maximum of
@@ -1435,7 +1434,7 @@ static void kmemleak_scan(void)
 		if (color_gray(object) && get_object(object))
 			list_add_tail(&object->gray_list, &gray_list);
 
-		raw_spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irq(&object->lock);
 	}
 	rcu_read_unlock();
 
@@ -1503,14 +1502,14 @@ static void kmemleak_scan(void)
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
 
@@ -1530,7 +1529,7 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		raw_spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irq(&object->lock);
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
@@ -1540,7 +1539,7 @@ static void kmemleak_scan(void)
 
 			new_leaks++;
 		}
-		raw_spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irq(&object->lock);
 	}
 	rcu_read_unlock();
 
@@ -1742,15 +1741,14 @@ static int dump_str_object_info(const char *str)
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

