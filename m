Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146664657D8;
	Fri, 14 Aug 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711289; cv=none; b=riUkp4VtNGUgky5EmL8xv0QMzbng1dwCTycH+PPAMTRKyYa4naNkycVU3alICMoc9xvqkXuR1DVZZVjLQfEHvB3hXOslrEFMHXZ9iK+kgMAPbU6xt3eO2D36HEZVX4jSbVrsDirgsp2mxBuZLNavGrUjMRowezyK8Spn3R7f6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711289; c=relaxed/simple;
	bh=F7KrOn3i2bhTfbaqoYvju3VNdkBiNfk3vhQ1jUwq4WM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dF1L7d0QcdQC1j+KXXaPAtOmKMQHpyb22lrHjRSGudi9WbYa0/CYOw4wxv6H6FA/ZZMunT4ovmTlWW35C+Hfy3EiVXlUqQwCB3JYvjDwM+Ou7wN5+nFBfEpIG3xVMzRlu2Vxag5zPJ1SpqaTsJlEKX4tAvgM6b1RsLcwF+MVX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttm/wj7k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ttm/wj7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98AE1F00A3D;
	Fri, 14 Aug 2026 12:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711283;
	bh=/MVJR7cBPw8zhUFy7MDVWoll+yuUDELWeajJ0WPK+Es=;
	h=Date:From:To:Cc:Subject:References;
	b=Ttm/wj7ksi2gX6HTOWBiQyfJ51orKMkkFSsmW5+JqQ+410QVzeItt2WUggRivMOsh
	 g6jhQtXN875JE9zdidfpj3TFV/4r7koo4KVibLVFtuw9WDT99/nd0Q/h0fJ/Xvk21w
	 h1lw5RxbAzQ2Mw0SeD0bx3R3tjylFbUDyCsxnHWget7Y6DBAbnNhldp+y8ING97RIx
	 6bRryCnZ8+BJne6qthlFWcEIAvnjGOif/8GE4Kr3/UJUWKmRvU16SqM4B8BsHiFHlu
	 JPD90HQ4ZiAqve7OKgoKWfdvcTjO983JcYH84IZA/vVBx+4igdGNh5FGefbBadzvO4
	 KTlfUwo2zcUaA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wurEE-00000003zlo-0VAq;
	Fri, 14 Aug 2026 08:41:42 -0400
Message-ID: <20260814124141.982170841@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 14 Aug 2026 08:41:27 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 4/9] ring-buffer: Make cpu_buffer::free_page a buffer_data_read_page
References: <20260814124123.133362396@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

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
---
 kernel/trace/ring_buffer.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0479c404db03..0d35fd90ea1d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -507,7 +507,7 @@ struct ring_buffer_per_cpu {
 	raw_spinlock_t			reader_lock;	/* serialize readers */
 	arch_spinlock_t			lock;
 	struct lock_class_key		lock_key;
-	struct buffer_data_page		*free_page;
+	struct buffer_data_read_page	free_page;
 	unsigned long			nr_pages;
 	unsigned int			current_context;
 	struct list_head		*pages;
@@ -2631,7 +2631,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
-	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
+	free_pages((unsigned long)cpu_buffer->free_page.data, cpu_buffer->free_page.order);
 
 	kfree(cpu_buffer);
 }
@@ -6962,9 +6962,9 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
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
@@ -7016,8 +7016,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
-	if (!cpu_buffer->free_page) {
-		cpu_buffer->free_page = dpage;
+	if (!cpu_buffer->free_page.data) {
+		cpu_buffer->free_page = *data_page;
 		dpage = NULL;
 	}
 
@@ -7390,7 +7390,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	for_each_buffer_cpu(buffer, cpu) {
-		struct buffer_data_page *old_free_data_page;
+		struct buffer_data_read_page old_free_data_page;
 		struct list_head old_pages;
 		unsigned long flags;
 
@@ -7433,7 +7433,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		arch_spin_lock(&cpu_buffer->lock);
 		old_free_data_page = cpu_buffer->free_page;
-		cpu_buffer->free_page = NULL;
+		cpu_buffer->free_page.data = NULL;
 		arch_spin_unlock(&cpu_buffer->lock);
 
 		rb_head_page_activate(cpu_buffer);
@@ -7445,7 +7445,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 			list_del_init(&bpage->list);
 			free_buffer_page(bpage);
 		}
-		free_pages((unsigned long)old_free_data_page, old_order);
+		free_pages((unsigned long)old_free_data_page.data, old_free_data_page.order);
 
 		rb_check_pages(cpu_buffer);
 	}
-- 
2.53.0


