Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C3364934
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081436; cv=none; b=WgjnYQrCTPXzm+6hz5SpFPVyjf7exTRh1xloUR5d/4vr6HhgI+20SQW1zSy7m7Dt+MxjJR5PlclDy5kwGFvz3VZ1qB+KXSWPEX7J/KI/ujlXh58lU8gUQ0LhFRXXYjIZacWgzigjYEWhNjEhc3/yHgRggC8Ihf0W/n/KEgBwfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081436; c=relaxed/simple;
	bh=qR3N8tuTqUfCaOCKj/huj4q2L3RWWuk51IfQ05N+4aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaPLP+x/dTf1geulTRlhq+yKOGChhHFsQqCByFsJWl+IgF5msnqdFkHTNp3W/foUZI6OFVWQGEathTNuZLqJ0cmJwXq+cg/B3viKGAhlqBHqmNw05HBEjkXL+vZJjc23jnfw7UfGOgqmWpAi3DYU/+9hUelMrDa/oQMb8cXH9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVmWVuqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVmWVuqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92161F000E9;
	Tue, 18 Aug 2026 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787081435;
	bh=MTuaroHe24ySh56cicXejL7sMfya7EiPjKI/sojlFOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVmWVuqgLGF5WQWm330N43kgsxJ+uvGJBIpTO5qImYeeQQYyQ2XdR58z6gstZyMBp
	 Ydqbg6KNffcwFHur1S0gl6y0juOLyDj+q7tTFT29KalsUXMqmtb/Gi2vbcN7hGAWxv
	 AGFBoOgwaE2bMG1KmKPy7n8WvGeH9ER2uk8O/68Ly96n8OqzMwMzE2yT5pE5MJ13R0
	 2Je9LVB6AiGf+lmMtI+oRypbBYj76RmRJ4v/dSYArOHC0jXVB/tX362DPKOyK8A+QS
	 UFaxaBHhMzzX47Nkos8nX1hlLR2uUtQymw7VxjCdsUc3ELTT0t0/u6Qk21YURI10Qh
	 H9zlW/F+mGcbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ring-buffer: Simplify functions with __free(kfree) to free allocations
Date: Tue, 18 Aug 2026 15:30:31 -0400
Message-ID: <20260818193032.3302299-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081707-pajamas-stoplight-328c@gregkh>
References: <2026081707-pajamas-stoplight-328c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 99d232804405e35d7a9af1536a057578a1442e81 ]

The function rb_allocate_pages() allocates cpu_buffer and on error needs
to free it. It has a single return. Use __free(kfree) and return directly
on errors and have the return use return_ptr(cpu_buffer).

The function alloc_buffer() allocates buffer and on error needs to free
it. It has a single return. Use __free(kfree) and return directly on
errors and have the return use return_ptr(buffer).

The function __rb_map_vma() allocates a temporary array "pages". Have it
use __free() and not worry about freeing it when returning.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250527143144.6edc4625@gandalf.local.home
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 6d014e44b68d ("ring-buffer: Initialise reader page order in rb_allocate_cpu_buffer()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fcd2363d1296..7c9c7f2b4db9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2193,7 +2193,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 static struct ring_buffer_per_cpu *
 rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 {
-	struct ring_buffer_per_cpu *cpu_buffer;
+	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) = NULL;
 	struct ring_buffer_meta *meta;
 	struct buffer_page *bpage;
 	struct page *page;
@@ -2219,7 +2219,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
 	if (!bpage)
-		goto fail_free_buffer;
+		return NULL;
 
 	rb_check_bpage(cpu_buffer, bpage);
 
@@ -2285,13 +2285,11 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		rb_head_page_activate(cpu_buffer);
 	}
 
-	return cpu_buffer;
+	return_ptr(cpu_buffer);
 
  fail_free_reader:
 	free_buffer_page(cpu_buffer->reader_page);
 
- fail_free_buffer:
-	kfree(cpu_buffer);
 	return NULL;
 }
 
@@ -2335,7 +2333,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 unsigned long end,
 					 struct lock_class_key *key)
 {
-	struct trace_buffer *buffer;
+	struct trace_buffer *buffer __free(kfree) = NULL;
 	long nr_pages;
 	int subbuf_size;
 	int bsize;
@@ -2349,7 +2347,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		return NULL;
 
 	if (!zalloc_cpumask_var(&buffer->cpumask, GFP_KERNEL))
-		goto fail_free_buffer;
+		return NULL;
 
 	buffer->subbuf_order = order;
 	subbuf_size = (PAGE_SIZE << order);
@@ -2441,7 +2439,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		atomic_notifier_chain_register(&panic_notifier_list, &buffer->flush_nb);
 	}
 
-	return buffer;
+	return_ptr(buffer);
 
  fail_free_buffers:
 	for_each_buffer_cpu(buffer, cpu) {
@@ -2453,8 +2451,6 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
  fail_free_cpumask:
 	free_cpumask_var(buffer->cpumask);
 
- fail_free_buffer:
-	kfree(buffer);
 	return NULL;
 }
 
@@ -7007,7 +7003,7 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 {
 	unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
 	unsigned int subbuf_pages, subbuf_order;
-	struct page **pages;
+	struct page **pages __free(kfree) = NULL;
 	int p = 0, s = 0;
 	int err;
 
@@ -7075,10 +7071,8 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 		struct page *page;
 		int off = 0;
 
-		if (WARN_ON_ONCE(s >= nr_subbufs)) {
-			err = -EINVAL;
-			goto out;
-		}
+		if (WARN_ON_ONCE(s >= nr_subbufs))
+			return -EINVAL;
 
 		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
 
@@ -7093,9 +7087,6 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 
 	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
 
-out:
-	kfree(pages);
-
 	return err;
 }
 #else
-- 
2.53.0

