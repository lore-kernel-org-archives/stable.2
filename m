Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8C4FC8FC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457716; cv=none; b=VdHkhQsfxAMZRlRXo5lu2QGBN3PsTwJ8yV8b+wLN13THgsbBmoEJGsWg9nI/91h7OXOfjuwRRH+2gV0MFBdS0SmuoixGvbcs1llMzt20k+ls7HOvvpvc0M0MIz9WFztf41Jdf8CrCHuDIojwGUJAbXMyNmzTObGtS6NZI9bj5+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457716; c=relaxed/simple;
	bh=LLM7j1D1k7zj5nY+sZ/O93n0eysLxRCtI80EBnGA2dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOL4y679NoJnQ71pwwfN/kyVz/vg6oM235cy1YIVhaXfUfMZjJ0luNf85h3SdfdrMI+lduxxRqvzhCbzcfL+KQBev2tgu3r1k+yAVDSbL3B4hkqLRXyn2YWZ++qfwR76dgU0xWoTfuF05RuTUroRil/kQdynrD+XZXdgNERKR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE8N0EHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE8N0EHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA151F000E9;
	Thu,  3 Sep 2026 17:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788457714;
	bh=SYrqsleLgvHItJhh4JOTWTWJ79EdLVRelMtAxg1HQUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CE8N0EHOM8+Wbc1S9F9SCKsGVKjuxe29cpM6neZM6kGyjXbYJg6Kjd7MrrhZoqgVs
	 nWORdTCMQYo4DiA41XUcOW8Ym46VAd6ZC8tJ26tAzLL4IslpdIKQ0n+CGUxXIai1eP
	 sGdaHU9/0rMMH6lfk/sf0FprUS8Dl91IWpm0jnQ5ELUlIEaJSwJ7JL7Jm+6zGHK5w9
	 SIcAbw9Y74U66+pgUbjCOt41JZ4g4XR4qUD2rjPPNGw1pwvuen9J6DEZXo4NUCc1We
	 Bki3hrV+Cz1Olh+VuXwcfq9C4MINhFzF8H6txD/A9rwf5wThxD2XEMqeI58Xcn6M1H
	 olb3NhsmTvMCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"ke.wang" <ke.wang@unisoc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zhaoyang Huang <huangzhaoyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] mm: use stack_depot for recording kmemleak's backtrace
Date: Thu,  3 Sep 2026 13:48:29 -0400
Message-ID: <20260903174832.1263842-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-elliptic-contort-6cb3@gregkh>
References: <2026090332-elliptic-contort-6cb3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

[ Upstream commit 56a61617dd2276cbc56a6c868599716386d70041 ]

Using stack_depot to record kmemleak's backtrace which has been
implemented on slub for reducing redundant information.

[akpm@linux-foundation.org: fix build - remove now-unused __save_stack_trace()]
[zhaoyang.huang@unisoc.com: v3]
  Link: https://lkml.kernel.org/r/1667101354-4669-1-git-send-email-zhaoyang.huang@unisoc.com
[akpm@linux-foundation.org: fix v3 layout oddities]
[akpm@linux-foundation.org: coding-style cleanups]
Link: https://lkml.kernel.org/r/1666864224-27541-1-git-send-email-zhaoyang.huang@unisoc.com
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: ke.wang <ke.wang@unisoc.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 5d10d4e19e6d ("mm/kmemleak: avoid soft lockup when scanning task stacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/Kconfig.debug |  1 +
 mm/kmemleak.c     | 46 ++++++++++++++++++++++++++++------------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d00c695bf4921..cfff3f1e4713d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -737,6 +737,7 @@ config DEBUG_KMEMLEAK
 	select STACKTRACE if STACKTRACE_SUPPORT
 	select KALLSYMS
 	select CRC32
+	select STACKDEPOT
 	help
 	  Say Y here if you want to enable the memory leak
 	  detector. The memory allocation/freeing is traced in a way
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d3c9a63d7a9d5..eaa89f20cd35d 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -79,6 +79,7 @@
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
 #include <linux/stacktrace.h>
+#include <linux/stackdepot.h>
 #include <linux/cache.h>
 #include <linux/percpu.h>
 #include <linux/memblock.h>
@@ -159,8 +160,7 @@ struct kmemleak_object {
 	u32 checksum;
 	/* memory ranges to be scanned inside an object (empty for all) */
 	struct hlist_head area_list;
-	unsigned long trace[MAX_TRACE];
-	unsigned int trace_len;
+	depot_stack_handle_t trace_handle;
 	unsigned long jiffies;		/* creation timestamp */
 	pid_t pid;			/* pid of the current task */
 	char comm[TASK_COMM_LEN];	/* executable name */
@@ -346,18 +346,21 @@ static void print_unreferenced(struct seq_file *seq,
 			       struct kmemleak_object *object)
 {
 	int i;
+	unsigned long *entries;
+	unsigned int nr_entries;
 	unsigned int msecs_age = jiffies_to_msecs(jiffies - object->jiffies);
 
+	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
 	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
-		   object->pointer, object->size);
+			  object->pointer, object->size);
 	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
-		   object->comm, object->pid, object->jiffies,
-		   msecs_age / 1000, msecs_age % 1000);
+			   object->comm, object->pid, object->jiffies,
+			   msecs_age / 1000, msecs_age % 1000);
 	hex_dump_object(seq, object);
 	warn_or_seq_printf(seq, "  backtrace:\n");
 
-	for (i = 0; i < object->trace_len; i++) {
-		void *ptr = (void *)object->trace[i];
+	for (i = 0; i < nr_entries; i++) {
+		void *ptr = (void *)entries[i];
 		warn_or_seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
 	}
 }
@@ -370,15 +373,16 @@ static void print_unreferenced(struct seq_file *seq,
 static void dump_object_info(struct kmemleak_object *object)
 {
 	pr_notice("Object 0x%08lx (size %zu):\n",
-		  object->pointer, object->size);
+			object->pointer, object->size);
 	pr_notice("  comm \"%s\", pid %d, jiffies %lu\n",
-		  object->comm, object->pid, object->jiffies);
+			object->comm, object->pid, object->jiffies);
 	pr_notice("  min_count = %d\n", object->min_count);
 	pr_notice("  count = %d\n", object->count);
 	pr_notice("  flags = 0x%x\n", object->flags);
 	pr_notice("  checksum = %u\n", object->checksum);
 	pr_notice("  backtrace:\n");
-	stack_trace_print(object->trace, object->trace_len, 4);
+	if (object->trace_handle)
+		stack_depot_print(object->trace_handle);
 }
 
 /*
@@ -594,12 +598,18 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
 	return object;
 }
 
-/*
- * Save stack trace to the given array of MAX_TRACE size.
- */
-static int __save_stack_trace(unsigned long *trace)
+static noinline depot_stack_handle_t set_track_prepare(void)
 {
-	return stack_trace_save(trace, MAX_TRACE, 2);
+	depot_stack_handle_t trace_handle;
+	unsigned long entries[MAX_TRACE];
+	unsigned int nr_entries;
+
+	if (!kmemleak_initialized)
+		return 0;
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
+	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+
+	return trace_handle;
 }
 
 /*
@@ -656,7 +666,7 @@ static void __create_object(unsigned long ptr, size_t size,
 	}
 
 	/* kernel backtrace */
-	object->trace_len = __save_stack_trace(object->trace);
+	object->trace_handle = set_track_prepare();
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 
@@ -695,7 +705,6 @@ static void __create_object(unsigned long ptr, size_t size,
 	rb_link_node(&object->rb_node, rb_parent, link);
 	rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
 					  &object_tree_root);
-
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
@@ -1094,7 +1103,7 @@ void __ref kmemleak_update_trace(const void *ptr)
 	}
 
 	raw_spin_lock_irqsave(&object->lock, flags);
-	object->trace_len = __save_stack_trace(object->trace);
+	object->trace_handle = set_track_prepare();
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
@@ -2092,6 +2101,7 @@ void __init kmemleak_init(void)
 	if (kmemleak_error)
 		return;
 
+	stack_depot_init();
 	jiffies_min_age = msecs_to_jiffies(MSECS_MIN_AGE);
 	jiffies_scan_wait = msecs_to_jiffies(SECS_SCAN_WAIT * 1000);
 
-- 
2.53.0

