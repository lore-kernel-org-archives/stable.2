Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980B17B50A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474657; cv=none; b=IHdls/CjH2v1MjbzqlWxWlv60uRyCmAoIUWDt8dLAwsG0KKxON4ajBMpJN4Vg/SWVr11K361Wog8Bk7aszaVfQPL0rHO5ej3hkhMGF3dc3G9icMZtZI4eG784CtB0gT7Bib3v4InG3FmHOBcqB0JNsIi8wNsYRsxfng9rX5APYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474657; c=relaxed/simple;
	bh=DW1NxoKpGfVZTlvRtvHIxH+UHOoS2yTH3GGDYNf9peY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NH6pq6nhfzE1gnUN0X0sAIEEtatDAT05uNwV6sHu6N59rpM8Qtr9Rj25v8ftE2L/HbYOcW9ZNlsKJxRLGpfKz3RuUGvp/EwnOZP0RE6u78FJhq0wXri9pc1nB76sp4DRw91h0rQfiYLf/qnyCK4jCBWJCmmTKlcu9dX0Y/S04LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUKXs9gx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUKXs9gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2D21F00A3D;
	Thu,  3 Sep 2026 22:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474656;
	bh=cvggMk3NH8y7cL1/wv/8ng7AMp7HWpRrcVB11KSZdGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lUKXs9gxg/7FJSwEDDTu3ecu5znLvkPZpCHcYhWRxBEobgzOrHbe1UhG+lUBdCmoy
	 JiY/UOKUyCrqgMX1cZfcwTAUk6ASKs96/NOzkhpQZmaCKbzc5YikPEgHbaySsBGnLr
	 hIs7OgXyMUfTdnNwpl2BYmhex9H0idacQfCH14k/e92GxCA+BW2JzVPKd9L/pklDHf
	 pCa99ZnflKr6jFkHfmR7SAINP5UwFUTeKuHu5D8vWhzr/C0CNFxD3GT+iGRrFH9GP2
	 AptaYzNmCxfC7a6dJwDWTd9eBycvTBQVTZoBPe3p9m9FZxjHnKBgbU+s1h98TOdNLN
	 qRJW656ZnTBWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/7] kmemleak: drop (age <increasing>) from leak record
Date: Thu,  3 Sep 2026 18:30:48 -0400
Message-ID: <20260903223049.1740340-6-sashal@kernel.org>
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

From: Jim Cromie <jim.cromie@gmail.com>

[ Upstream commit 88f9ee2b3040991ff40628fa9e3516ebe36dd6fa ]

Patch series "tweak kmemleak report format".

These 2 patches make minor changes to the report:

1st strips "age <increasing>" from output.  This makes the output
idempotent; unchanging until a new leak is reported.

2nd adds the backtrace.checksum to the "backtrace:" line.  This lets a
user see repeats without actually reading the whole backtrace.  So now
the backtrace line looks like this:

  backtrace (crc 603070071):

I surveyed for un-wanted effects upon users:

Syzkaller parses kmemleak in executor/common_linux.h:
static void check_leaks(char** frames, int nframes)

It just counts occurrences of "unreferenced object", specifically it
does not look for "age", nor would it choke on "crc" being added.

github has 3 repos with "kmemleak" mentioned, all are moribund.
gitlab has 0 hits on "kmemleak".

This patch (of 2):

Displaying age is pretty, but counter-productive; it changes with
current-time, so it surrenders idempotency of the output, which breaks
simple hash-based cataloging of the records by the user.

The trouble: sequential reads, wo new leaks, get new results:

  :#> sum /sys/kernel/debug/kmemleak
  53439    74 /sys/kernel/debug/kmemleak
  :#> sum /sys/kernel/debug/kmemleak
  59066    74 /sys/kernel/debug/kmemleak

and age is why (nothing else changes):

  :#> grep -v age /sys/kernel/debug/kmemleak | sum
  58894    67
  :#> grep -v age /sys/kernel/debug/kmemleak | sum
  58894    67

Since jiffies is already printed in the "comm" line, age adds nothing.

Notably, syzkaller reads kmemleak only for "unreferenced object", and
won't care about this reform of age-ism.  A few moribund github repos
mention it, but don't compile.

Link: https://lkml.kernel.org/r/20231116224318.124209-1-jim.cromie@gmail.com
Link: https://lkml.kernel.org/r/20231116224318.124209-2-jim.cromie@gmail.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 5d10d4e19e6d ("mm/kmemleak: avoid soft lockup when scanning task stacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 091cc228c81a7..bc7c70cdf6d4c 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -13,11 +13,12 @@
  *
  * The following locks and mutexes are used by kmemleak:
  *
- * - kmemleak_lock (raw_spinlock_t): protects the object_list modifications and
- *   accesses to the object_tree_root. The object_list is the main list
- *   holding the metadata (struct kmemleak_object) for the allocated memory
- *   blocks. The object_tree_root is a red black tree used to look-up
- *   metadata based on a pointer to the corresponding memory block.  The
+ * - kmemleak_lock (raw_spinlock_t): protects the object_list as well as
+ *   del_state modifications and accesses to the object_tree_root. The
+ *   object_list is the main list holding the metadata (struct
+ *   kmemleak_object) for the allocated memory blocks. The object_tree_root
+ *   is a red black tree used to look-up metadata based on a pointer to the
+ *   corresponding memory block. The
  *   kmemleak_object structures are added to the object_list and
  *   object_tree_root in the create_object() function called from the
  *   kmemleak_alloc() callback and removed in delete_object() called from the
@@ -143,6 +144,7 @@ struct kmemleak_object {
 	struct rcu_head rcu;		/* object_list lockless traversal */
 	/* object usage count; object freed when use_count == 0 */
 	atomic_t use_count;
+	unsigned int del_state;		/* deletion state */
 	unsigned long pointer;
 	size_t size;
 	/* pass surplus references to this pointer */
@@ -171,6 +173,11 @@ struct kmemleak_object {
 /* flag set to fully scan the object when scan_area allocation failed */
 #define OBJECT_FULL_SCAN	(1 << 3)
 
+/* set when __remove_object() called */
+#define DELSTATE_REMOVED	(1 << 0)
+/* set to temporarily prevent deletion from object_list */
+#define DELSTATE_NO_DELETE	(1 << 1)
+
 #define HEX_PREFIX		"    "
 /* number of bytes to print per line; must be 16 or 32 */
 #define HEX_ROW_SIZE		16
@@ -335,13 +342,11 @@ static void print_unreferenced(struct seq_file *seq,
 			       struct kmemleak_object *object)
 {
 	int i;
-	unsigned int msecs_age = jiffies_to_msecs(jiffies - object->jiffies);
 
 	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
 		   object->pointer, object->size);
-	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
-		   object->comm, object->pid, object->jiffies,
-		   msecs_age / 1000, msecs_age % 1000);
+	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
+		   object->comm, object->pid, object->jiffies);
 	hex_dump_object(seq, object);
 	warn_or_seq_printf(seq, "  backtrace:\n");
 
@@ -536,7 +541,9 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
 static void __remove_object(struct kmemleak_object *object)
 {
 	rb_erase(&object->rb_node, &object_tree_root);
-	list_del_rcu(&object->object_list);
+	if (!(object->del_state & DELSTATE_NO_DELETE))
+		list_del_rcu(&object->object_list);
+	object->del_state |= DELSTATE_REMOVED;
 }
 
 /*
@@ -598,6 +605,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	object->count = 0;			/* white color initially */
 	object->jiffies = jiffies;
 	object->checksum = 0;
+	object->del_state = 0;
 
 	/* task information */
 	if (in_irq()) {
@@ -1410,13 +1418,30 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
 	if (!get_object(object))
 		return;	/* Try next object */
 
+	raw_spin_lock_irq(&kmemleak_lock);
+	if (object->del_state & DELSTATE_REMOVED)
+		goto unlock_put;	/* Object removed */
+	object->del_state |= DELSTATE_NO_DELETE;
+	raw_spin_unlock_irq(&kmemleak_lock);
+
 	rcu_read_unlock();
 	cond_resched();
 	rcu_read_lock();
+
+	raw_spin_lock_irq(&kmemleak_lock);
+	if (object->del_state & DELSTATE_REMOVED)
+		list_del_rcu(&object->object_list);
+	object->del_state &= ~DELSTATE_NO_DELETE;
+unlock_put:
+	raw_spin_unlock_irq(&kmemleak_lock);
 	put_object(object);
 }
 
 /*
+ * Print one leak inline. The hex dump is gated on OBJECT_ALLOCATED so it
+ * does not touch user memory that was freed concurrently; the rest of the
+ * report is emitted under object->lock by print_unreferenced().
+ *
  * Scan data sections and all the referenced memory blocks allocated via the
  * kernel's standard allocators. This function must be called with the
  * scan_mutex held.
-- 
2.53.0

