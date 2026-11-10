Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330765;
	b=LxTq5iEhNiBjEG90IE7g8tYQW5UYj3g/4O7hNZfL2jevQ4q/y9F0cjW7TifSSe83t9RB
	 qjeb4anYDNWYZfpoX/SlP0/2I5Ri5r0Oq0h1zhnrwuUEEuaN3ExvfoTnuq3Q0ahegG6eX
	 e0s3hxo1uEt4K2+e8++L1aIAInouu+/DNoXyxCgiTXLWra0nzGtaye2ns3e4cqKJS2iQo
	 6rRnJr9EkmpSSnKC7lh2OHGhFL/SRJVGsUJeytET7ZEYLVYxFop3+cA/Z3py65E2aAN8C
	 QFVYRVdDukzQT1RjguMZVq5vm5xQAawhh9aIjyh/oaVcoGmdD87b58FxsBYPFeFWCcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ia7Tj4i8iZdcMCBLGwIMGLnKy0VMg0Y9GoGxexyrqII=;
	b=jJNWbD2oNTkNC/+/UourdKt4JvQ2mV2VgEG2KsAjwT9DNVexPpEr07Dxb3Few4dhYiSz
	 OHw68Lyd5b24nxxja+qOoKEMypmisIkMURtl01BK5xpcIm4NiBtyihOkJlNc+mE57uvr6
	 FJkyOZgpRDyCul0MiI7zXX8pYyR5kUTNkEyfYGTi/TbTCCoVmnLOfcHcQHb2MuWZ7ySxN
	 omzuGL/0EBGWyP8BSvQ/jAXQGbtMCDDGOjBH6UcyMx+8208E28/M+VVBb21JWcSQHPdBb
	 cLv+xKPKA0+5fCveUqrMOF7qjF7Ii/X4+Ex/c4O998TpPuPep/0fFa6RIwopH/N2nbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArsVgep5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20D606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArsVgep5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEAD1F0089F;
	Tue, 10 Nov 2026 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330764;
	bh=ia7Tj4i8iZdcMCBLGwIMGLnKy0VMg0Y9GoGxexyrqII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ArsVgep5knrWqap26LCVKV89AgrbM01BJ3ZMqegUnZXXO65A3aSbr+e1JuEWFjiIV
	 CqyqtKAwTAdF7svKpNchh6mgkrqWzr3moqKB0N9DDiehA+J8DVxaOVOBuuwdwU93Ga
	 tFEeUpdtg3o9jdh7ikOdVhER9q6h6zVh9OBoCwlgVKsnTbZJPGKv2U0fqbgPjyHigu
	 WlTM2M70W2rBPUZ9gRss1WfmWXxWWlPvsd3rGdPZPFs8BE/cHdEzqDkrY8hGUNdx/n
	 zvum6Yx4Xb6BNJy4QBMB8iabSdCyiOajD2TmGMmyBguEDqvAuppmANrdoaY1U9H7ST
	 P+uuDJVcl4Sow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imran Khan <imran.f.khan@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@linux.ie>,
	Dmitry Vyukov <dvyukov@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] lib, stackdepot: add helper to print stack entries
Date: Tue, 10 Nov 2026 12:12:38 -0500
Message-ID: <20261110171139.2520111-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060713-failed-5.15-56453199d28f@kernel.org>
References: <20261107060713-failed-5.15-56453199d28f@kernel.org>
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

From: Imran Khan <imran.f.khan@oracle.com>

[ Upstream commit 505be48165fa2f2cb795659b4fc61f35563d105e ]

To print a stack entries, users of stackdepot, first use stack_depot_fetch
to get a list of stack entries and then use stack_trace_print to print
this list.  Provide a helper in stackdepot to print stack entries based on
stackdepot handle.  Also change above mentioned users to use this helper.

Link: https://lkml.kernel.org/r/20210915014806.3206938-3-imran.f.khan@oracle.com
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: 56453199d28f ("net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/stackdepot.h |  2 ++
 lib/stackdepot.c           | 18 ++++++++++++++++++
 mm/kasan/report.c          | 15 +++------------
 mm/page_owner.c            | 13 ++++---------
 4 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 22919a94ca19d..02b055af4128b 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -19,6 +19,8 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
 
+void stack_depot_print(depot_stack_handle_t stack);
+
 #ifdef CONFIG_STACKDEPOT
 int stack_depot_init(void);
 #else
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index d31f23570a867..f2a3e6f3207b2 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -213,6 +213,24 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
 	return NULL;
 }
 
+/**
+ * stack_depot_print - print stack entries from a depot
+ *
+ * @stack:		Stack depot handle which was returned from
+ *			stack_depot_save().
+ *
+ */
+void stack_depot_print(depot_stack_handle_t stack)
+{
+	unsigned long *entries;
+	unsigned int nr_entries;
+
+	nr_entries = stack_depot_fetch(stack, &entries);
+	if (nr_entries > 0)
+		stack_trace_print(entries, nr_entries, 0);
+}
+EXPORT_SYMBOL_GPL(stack_depot_print);
+
 /**
  * stack_depot_fetch - Fetch stack entries from a depot
  *
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8786cdfeaa917..b9587b2ec7d60 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -124,20 +124,11 @@ static void end_report(unsigned long *flags, unsigned long addr)
 	kasan_enable_current();
 }
 
-static void print_stack(depot_stack_handle_t stack)
-{
-	unsigned long *entries;
-	unsigned int nr_entries;
-
-	nr_entries = stack_depot_fetch(stack, &entries);
-	stack_trace_print(entries, nr_entries, 0);
-}
-
 static void print_track(struct kasan_track *track, const char *prefix)
 {
 	pr_err("%s by task %u:\n", prefix, track->pid);
 	if (track->stack) {
-		print_stack(track->stack);
+		stack_depot_print(track->stack);
 	} else {
 		pr_err("(stack is not available)\n");
 	}
@@ -206,12 +197,12 @@ static void describe_object_stacks(struct kmem_cache *cache, void *object,
 		return;
 	if (alloc_meta->aux_stack[0]) {
 		pr_err("Last potentially related work creation:\n");
-		print_stack(alloc_meta->aux_stack[0]);
+		stack_depot_print(alloc_meta->aux_stack[0]);
 		pr_err("\n");
 	}
 	if (alloc_meta->aux_stack[1]) {
 		pr_err("Second to last potentially related work creation:\n");
-		print_stack(alloc_meta->aux_stack[1]);
+		stack_depot_print(alloc_meta->aux_stack[1]);
 		pr_err("\n");
 	}
 #endif
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 62402d22539b8..eff29be1218bc 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -394,8 +394,6 @@ void __dump_page_owner(const struct page *page)
 	struct page_ext *page_ext = lookup_page_ext(page);
 	struct page_owner *page_owner;
 	depot_stack_handle_t handle;
-	unsigned long *entries;
-	unsigned int nr_entries;
 	gfp_t gfp_mask;
 	int mt;
 
@@ -423,20 +421,17 @@ void __dump_page_owner(const struct page *page)
 		 page_owner->pid, page_owner->ts_nsec, page_owner->free_ts_nsec);
 
 	handle = READ_ONCE(page_owner->handle);
-	if (!handle) {
+	if (!handle)
 		pr_alert("page_owner allocation stack trace missing\n");
-	} else {
-		nr_entries = stack_depot_fetch(handle, &entries);
-		stack_trace_print(entries, nr_entries, 0);
-	}
+	else
+		stack_depot_print(handle);
 
 	handle = READ_ONCE(page_owner->free_handle);
 	if (!handle) {
 		pr_alert("page_owner free stack trace missing\n");
 	} else {
-		nr_entries = stack_depot_fetch(handle, &entries);
 		pr_alert("page last free stack trace:\n");
-		stack_trace_print(entries, nr_entries, 0);
+		stack_depot_print(handle);
 	}
 
 	if (page_owner->last_migrate_reason != -1)
-- 
2.53.0

