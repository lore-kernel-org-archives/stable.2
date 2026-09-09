Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE63B05BB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949015; cv=none; b=cOakWtUQ6rJKMfqeK0EfKS0BMjtQCl32WlZSkg91c68IqUBrAZlMV59h/UuEVJwft7eOVObTRt+anlw+MygRMKBqIwGQT+GWiojO58qBE86D/qguke8VQqHgWe9BUV21kEpvjUMgMmfU2Tn6CFGwSBo9+bxdLZ7tk+nfkx2t8Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949015; c=relaxed/simple;
	bh=pvzAWb3KTMqWYooHeNlQBeFdF3vrmurrM4yxmKlpxfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHyi5Oedo0nr+HiaHFmMuZn1fLpPuUgPav16zg5TM0kczz6YYTx901YpFxyha6Hm+JQfvizGcMdqKbzGyd5qe4NN/2teEJM9mzbiXZd+3/qw1/hM4e4WuS2/0fPFD9POjY6vb1nHZvkoP/RMg5PVEc1rBKSB6n2fROEP25wCZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcS6/frb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcS6/frb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6BE1F00AC4;
	Wed,  9 Sep 2026 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788949001;
	bh=5frbU5NRf65wWbKKmE5eEk5yhPfSTCJkxWgDSgNGdZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcS6/frbwB8ClRAKFELX6US7/lAHZSHke+R6FVCZ5/vDlVoHhOmjvg8udAB/LQG5C
	 u0zqUW45shvmR/0AEcdjgvV3DE4sxxrb92MDQU0JJYvr4O7cLFUi5wwnV//rL9hzKk
	 iS4E+zZtJnLAH1Hm3cTwojOzAtkQWVCZwr8CNTCUJw+h2XhXVppbTlj1Uwf5yPKOF2
	 2kPUqCPPjvneMYF223fBWOhZGrMyUXMQaCuqjfS9FHsoMrz8dTvUBhiSZbQ0S6Lp5B
	 STGyRS6zGp2dY4RiWiL6841DYTcPk2ViHgihtKONnZwTtUkrkrQShF9r0LHGK3GB3z
	 JgNs8NVfE29lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ring-buffer: Make cpu_buffer::free_page a buffer_data_read_page
Date: Wed,  9 Sep 2026 06:16:39 -0400
Message-ID: <20260909101639.1487209-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090315-unify-unvisited-eed3@gregkh>
References: <2026090315-unify-unvisited-eed3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vincent Donnefort <vdonnefort@google.com>

[ Upstream commit 7a1fb95de5404134f8758c1295ce88986bdf117c ]

Discarding a cached reader page after a concurrent ring buffer resize
uses the new global subbuf_order for the free_pages() call. This
mismatched order may crashes the kernel or leaks memory because the cached
page was allocated under the old size.

Save the actual free_page order alongside the page address to ensure we
always refer to the correct value and do not rely on the potentially
stalled cpu_buffer->subbuf_order value. The simplest is to make
free_page a buffer_data_read_page which already covers exactly what we
need: a page address and a page order.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260813131152.3589632-4-vdonnefort@google.com
Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ Changed upstream’s dpage variable to bpage in ring_buffer_free_read_page(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 47e6e1088e428..90224cde8fdab 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -492,7 +492,7 @@ struct ring_buffer_per_cpu {
 	raw_spinlock_t			reader_lock;	/* serialize readers */
 	arch_spinlock_t			lock;
 	struct lock_class_key		lock_key;
-	struct buffer_data_page		*free_page;
+	struct buffer_data_read_page	free_page;
 	unsigned long			nr_pages;
 	unsigned int			current_context;
 	struct list_head		*pages;
@@ -2358,7 +2358,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
-	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
+	free_pages((unsigned long)cpu_buffer->free_page.data, cpu_buffer->free_page.order);
 
 	kfree(cpu_buffer);
 }
@@ -6406,9 +6406,9 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
-	if (cpu_buffer->free_page) {
-		bpage->data = cpu_buffer->free_page;
-		cpu_buffer->free_page = NULL;
+	if (cpu_buffer->free_page.data) {
+		*bpage = cpu_buffer->free_page;
+		cpu_buffer->free_page.data = NULL;
 	}
 
 	arch_spin_unlock(&cpu_buffer->lock);
@@ -6466,8 +6466,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
-	if (!cpu_buffer->free_page) {
-		cpu_buffer->free_page = bpage;
+	if (!cpu_buffer->free_page.data) {
+		cpu_buffer->free_page = *data_page;
 		bpage = NULL;
 	}
 
@@ -6820,7 +6820,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	for_each_buffer_cpu(buffer, cpu) {
-		struct buffer_data_page *old_free_data_page;
+		struct buffer_data_read_page old_free_data_page;
 		struct list_head old_pages;
 		unsigned long flags;
 
@@ -6863,7 +6863,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		arch_spin_lock(&cpu_buffer->lock);
 		old_free_data_page = cpu_buffer->free_page;
-		cpu_buffer->free_page = NULL;
+		cpu_buffer->free_page.data = NULL;
 		arch_spin_unlock(&cpu_buffer->lock);
 
 		rb_head_page_activate(cpu_buffer);
@@ -6875,7 +6875,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 			list_del_init(&bpage->list);
 			free_buffer_page(bpage);
 		}
-		free_pages((unsigned long)old_free_data_page, old_order);
+		free_pages((unsigned long)old_free_data_page.data, old_free_data_page.order);
 
 		rb_check_pages(cpu_buffer);
 	}
-- 
2.53.0

