Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B884A2064
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948649; cv=none; b=uxCiYQIaG97YaTxw0XKkOqEuaDqPrRaTxcCCbtUZ3NxunDLsRAj4QTXAWesPx//SVSiHgQgpf06BT5k/utDfiDWHG9y4M8CJnF7sIYZQZUUVSBAPQJG4sVDENVXu9UDL0awcslNyG48NhCe22laYA7k5Umgcy5jXGSmUiYDtb3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948649; c=relaxed/simple;
	bh=j3uySCeV0qDUJYOs7wisNzDLRjxzSjznQi/UQB/hhUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOrr07RC0LYfPb/O95ly0BM2dmylRTgjvP7T5A4BbdN8UyDD0LM5mIgXZSbcQgBfK7UcdI9qwfb0tciXnoIXV00oFUHi5VrIwRZiKKsOfEiDM/wl42E5vtTJXBZ9vVyzxA9X6fQ2fLedbfCgEcIfwr+E8e3iX1xPk+IBuJOFWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfBVpDTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfBVpDTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104ED1F00A3D;
	Wed,  9 Sep 2026 10:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948646;
	bh=KXZIuTE+XZ+JyIQKME8h/Kjngkp4iLtIJRbXkfq+a2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NfBVpDTkRPoQq4whojxrk1+JBvpBQHAS84TnSIA+8ZEGNpxjPZAZrIqEcwNE2DyQi
	 LhJR20TijybtG3vH730sGHc5zNFD35/H8WsPqC8L1S/44tq9ngtZ+wyJIl2bDvm/9d
	 jA5XgMbW3Px8lHWEmu7KDItQvFdO/AzJYUSEZw2295mLSGi6umBbrMSC9y1XH9zo3z
	 STGwx+svOnNcxDJJU5+NVp/xjTg6f/s+Snw0aSoF4qXHDGmqd5gHw92TSfOlLRa1ub
	 sVRaM6udYNDTs5W2eK4citHHFRQeZbqx4JDhe0Sgsi476zL9a1W55XpjJWtvamWcXg
	 uEH5fr3Fs076w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ring-buffer: Add helper functions for allocations
Date: Wed,  9 Sep 2026 06:10:43 -0400
Message-ID: <20260909101044.1457737-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-announcer-magnify-98b4@gregkh>
References: <2026090352-announcer-magnify-98b4@gregkh>
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

Stable backport adjustment for e743527c5bfd:

Keep only the read-page allocation refactor needed by the target. Express
alloc_cpu_data as a statement-expression macro instead of adding a C
function, retaining NUMA allocation, __GFP_RETRY_MAYFAIL, compound/zeroed
pages, NULL failure handling, and data-page initialization.

Rename the existing rb_init_page initializer to rb_init_data_page, without
changing its implementation, and update its callers. This supplies the
context expected by the target without importing the unrelated cleanup
from 7cf02d0aa6bd or introducing additional functions.

Drop the CPU-buffer and buffer-page descriptor refactors and the bulk and
internal reader-page allocator conversions. These are not needed by the
target; leaving them intact preserves this tree's ring_buffer_meta type,
__GFP_RETRY_MAYFAIL descriptor allocations, and the existing bpage->order
and resize-disabled fixes. Only newly allocated external read pages switch
from __GFP_NORETRY to __GFP_RETRY_MAYFAIL in this backport.

The target's change to allocate using the saved bpage->order is deliberately
left for e743527c5bfd itself.

Stable-dep-of: e743527c5bfd ("ring-buffer: Fix subbuf resize race with ring_buffer_alloc_read_page()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 50 ++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 47e6e1088e428..dafcf77b3d78e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -382,7 +382,7 @@ struct buffer_page {
 #define RB_WRITE_MASK		0xfffff
 #define RB_WRITE_INTCNT		(1 << 20)
 
-static void rb_init_page(struct buffer_data_page *bpage)
+static void rb_init_data_page(struct buffer_data_page *bpage)
 {
 	local_set(&bpage->commit, 0);
 }
@@ -411,6 +411,21 @@ static void free_buffer_page(struct buffer_page *bpage)
 	kfree(bpage);
 }
 
+/* Try hard to allocate data pages without invoking the OOM killer. */
+#define alloc_cpu_data(cpu, order) ({						\
+	struct buffer_data_page *__rb_data = NULL;				\
+	struct page *__rb_page;							\
+										\
+	__rb_page = alloc_pages_node(cpu_to_node(cpu),				\
+		GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO,	\
+		(order));							\
+	if (__rb_page) {							\
+		__rb_data = page_address(__rb_page);				\
+		rb_init_data_page(__rb_data);					\
+	}									\
+	__rb_data;								\
+})
+
 /*
  * We need to fit the time_stamp delta into 27 bits.
  */
@@ -2013,7 +2028,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 		 */
 		for (i = 0; i < meta->nr_subbufs; i++) {
 			meta->buffers[i] = i;
-			rb_init_page(subbuf);
+			rb_init_data_page(subbuf);
 			subbuf += meta->subbuf_size;
 		}
 	}
@@ -2184,7 +2199,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 			if (!page)
 				goto free_pages;
 			bpage->page = page_address(page);
-			rb_init_page(bpage->page);
+			rb_init_data_page(bpage->page);
 		}
 		bpage->order = cpu_buffer->buffer->subbuf_order;
 
@@ -2290,7 +2305,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		if (!page)
 			goto fail_free_reader;
 		bpage->page = page_address(page);
-		rb_init_page(bpage->page);
+		rb_init_data_page(bpage->page);
 	}
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
@@ -6006,7 +6021,7 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 {
 	local_set(&page->write, 0);
 	local_set(&page->entries, 0);
-	rb_init_page(page->page);
+	rb_init_data_page(page->page);
 	page->read = 0;
 }
 
@@ -6392,7 +6407,6 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_data_read_page *bpage = NULL;
 	unsigned long flags;
-	struct page *page;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return ERR_PTR(-ENODEV);
@@ -6414,22 +6428,16 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
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
+		rb_init_data_page(bpage->data);
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
@@ -6638,7 +6646,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		cpu_buffer->read_bytes += rb_page_size(reader);
 
 		/* swap the pages */
-		rb_init_page(bpage);
+		rb_init_data_page(bpage);
 		bpage = reader->page;
 		reader->page = data_page->data;
 		local_set(&reader->write, 0);
-- 
2.53.0

