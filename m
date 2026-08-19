Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC64432EC
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138079; cv=none; b=uyVsOEcrJojYqYWGT0Q36A+8McQVjSKbq1jw3fDAd+o/6xX+HqGUuECJeSKQOP9nzCMIlsNfwYHRBPAHRXfyJtuyS7tlX6J1tGZZ6b84uzAronlUZPnlCXzqsJZfFM+PS5qA2Baqg6eew4tGPhWI1B32DWlBhcohtmoFmUe2mFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138079; c=relaxed/simple;
	bh=17zymLgfZKyWNuWCOgFo46TwhRoAlVbXii4UWl5bUh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQheC9H6lTgGSozZSLKExS/r4kBE4RKBQEcmjEuHVIYbuUtUahYXhpa2AOjjHSbHqs0PbCBOhmNeLRndB485k6Yr/LU4yANvPWy+bBSA/zm0B6Vluv7P4cJisiVod9cJSO5VBM6bjCOdW/sAPcp7tGmtdPme43/2lLuwTHjKwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dspMvI8o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dspMvI8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961E61F000E9;
	Wed, 19 Aug 2026 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138078;
	bh=bXlTTBdqOJ8THZUujrbYreha9uI5dgjjN4heNWLuuaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dspMvI8odxSB1eus8YJSJRKlXW39FmZRTqPzEDRMOFsZegEOgtsK4QW0TDFXMq4bn
	 ifzovO2w+RpbP6KqLJGAvo96XzRGKfjPFW1Ns/WCJIOZ+RAa8bEGWEapPz1QKS9YV+
	 XsYEWV1VgCMlUlMosowI/8HLnw+Hq5ur1W66+4vcdlUmjyBrbBL1HtCoYmDdrNPCEP
	 nFX3UFfrXxeAnAmaaCsnmJ/X+AMyk7HDWoguldcnCuhACcfqUrq9PVKONIgXPCxBYD
	 YKbmZhYnEh58STI9Z8x9FKo5P1mOT8LWKU18i1pJuhpXmcEtuh00eqM9gHS/o/MFkJ
	 r2Y53Y4BaxJmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] ring-buffer: Add helper functions for allocations
Date: Wed, 19 Aug 2026 07:14:34 -0400
Message-ID: <20260819111436.3550258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081708-platonic-evade-02c3@gregkh>
References: <2026081708-platonic-evade-02c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit b1e7a590a0133606d3efd41aee38cdeac630b52f ]

The allocation of the per CPU buffer descriptor, the buffer page
descriptors and the buffer page data itself can be pretty ugly:

  kzalloc_node(ALIGN(sizeof(struct buffer_page), cache_line_size()),
               GFP_KERNEL, cpu_to_node(cpu));

And the data pages:

  page = alloc_pages_node(cpu_to_node(cpu),
                          GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO, order);
  if (!page)
	return NULL;
  bpage->page = page_address(page);
  rb_init_page(bpage->page);

Add helper functions to make the code easier to read.

This does make all allocations of the data page (bpage->page) allocated
with the __GFP_RETRY_MAYFAIL flag (and not just the bulk allocator). Which
is actually better, as allocating the data page for the ring buffer tracing
should try hard but not trigger the OOM killer.

Link: https://lore.kernel.org/all/CAHk-=wjMMSAaqTjBSfYenfuzE1bMjLj+2DLtLWJuGt07UGCH_Q@mail.gmail.com/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251125121153.35c07461@gandalf.local.home
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 7c727dfce6be ("ring-buffer: Prevent resizing of persistent ring buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 97 +++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fefa16e51e0e..7b14b6911f9a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -404,6 +404,41 @@ static void free_buffer_page(struct buffer_page *bpage)
 	kfree(bpage);
 }
 
+/*
+ * For best performance, allocate cpu buffer data cache line sized
+ * and per CPU.
+ */
+#define alloc_cpu_buffer(cpu) (struct ring_buffer_per_cpu *)		\
+	kzalloc_node(ALIGN(sizeof(struct ring_buffer_per_cpu),		\
+			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu));
+
+#define alloc_cpu_page(cpu) (struct buffer_page *)			\
+	kzalloc_node(ALIGN(sizeof(struct buffer_page),			\
+			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu));
+
+static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
+{
+	struct buffer_data_page *dpage;
+	struct page *page;
+	gfp_t mflags;
+
+	/*
+	 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
+	 * gracefully without invoking oom-killer and the system is not
+	 * destabilized.
+	 */
+	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO;
+
+	page = alloc_pages_node(cpu_to_node(cpu), mflags, order);
+	if (!page)
+		return NULL;
+
+	dpage = page_address(page);
+	rb_init_page(dpage);
+
+	return dpage;
+}
+
 /*
  * We need to fit the time_stamp delta into 27 bits.
  */
@@ -2214,7 +2249,6 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	struct ring_buffer_cpu_meta *meta = NULL;
 	struct buffer_page *bpage, *tmp;
 	bool user_thread = current->mm != NULL;
-	gfp_t mflags;
 	long i;
 
 	/*
@@ -2228,13 +2262,6 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	if (i < nr_pages)
 		return -ENOMEM;
 
-	/*
-	 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
-	 * gracefully without invoking oom-killer and the system is not
-	 * destabilized.
-	 */
-	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
-
 	/*
 	 * If a user thread allocates too much, and si_mem_available()
 	 * reports there's enough memory, even though there is not.
@@ -2251,10 +2278,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		meta = rb_range_meta(buffer, nr_pages, cpu_buffer->cpu);
 
 	for (i = 0; i < nr_pages; i++) {
-		struct page *page;
 
-		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
-				    mflags, cpu_to_node(cpu_buffer->cpu));
+		bpage = alloc_cpu_page(cpu_buffer->cpu);
 		if (!bpage)
 			goto free_pages;
 
@@ -2277,13 +2302,10 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 			bpage->range = 1;
 			bpage->id = i + 1;
 		} else {
-			page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
-						mflags | __GFP_COMP | __GFP_ZERO,
-						cpu_buffer->buffer->subbuf_order);
-			if (!page)
+			int order = cpu_buffer->buffer->subbuf_order;
+			bpage->page = alloc_cpu_data(cpu_buffer->cpu, order);
+			if (!bpage->page)
 				goto free_pages;
-			bpage->page = page_address(page);
-			rb_init_page(bpage->page);
 		}
 		bpage->order = cpu_buffer->buffer->subbuf_order;
 
@@ -2334,14 +2356,12 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 static struct ring_buffer_per_cpu *
 rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 {
-	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) = NULL;
+	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
+		alloc_cpu_buffer(cpu);
 	struct ring_buffer_cpu_meta *meta;
 	struct buffer_page *bpage;
-	struct page *page;
 	int ret;
 
-	cpu_buffer = kzalloc_node(ALIGN(sizeof(*cpu_buffer), cache_line_size()),
-				  GFP_KERNEL, cpu_to_node(cpu));
 	if (!cpu_buffer)
 		return NULL;
 
@@ -2357,8 +2377,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
 	mutex_init(&cpu_buffer->mapping_lock);
 
-	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
-			    GFP_KERNEL, cpu_to_node(cpu));
+	bpage = alloc_cpu_page(cpu);
 	if (!bpage)
 		return NULL;
 
@@ -2380,13 +2399,10 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 			rb_meta_buffer_update(cpu_buffer, bpage);
 		bpage->range = 1;
 	} else {
-		page = alloc_pages_node(cpu_to_node(cpu),
-					GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
-					cpu_buffer->buffer->subbuf_order);
-		if (!page)
+		int order = cpu_buffer->buffer->subbuf_order;
+		bpage->page = alloc_cpu_data(cpu, order);
+		if (!bpage->page)
 			goto fail_free_reader;
-		bpage->page = page_address(page);
-		rb_init_page(bpage->page);
 	}
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
@@ -6493,7 +6509,6 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_data_read_page *bpage = NULL;
 	unsigned long flags;
-	struct page *page;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return ERR_PTR(-ENODEV);
@@ -6515,22 +6530,16 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	arch_spin_unlock(&cpu_buffer->lock);
 	local_irq_restore(flags);
 
-	if (bpage->data)
-		goto out;
-
-	page = alloc_pages_node(cpu_to_node(cpu),
-				GFP_KERNEL | __GFP_NORETRY | __GFP_COMP | __GFP_ZERO,
-				cpu_buffer->buffer->subbuf_order);
-	if (!page) {
-		kfree(bpage);
-		return ERR_PTR(-ENOMEM);
+	if (bpage->data) {
+		rb_init_page(bpage->data);
+	} else {
+		bpage->data = alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
+		if (!bpage->data) {
+			kfree(bpage);
+			return ERR_PTR(-ENOMEM);
+		}
 	}
 
-	bpage->data = page_address(page);
-
- out:
-	rb_init_page(bpage->data);
-
 	return bpage;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
-- 
2.53.0

