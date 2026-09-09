Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1E94B487B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948701; cv=none; b=np9cqLTs+TAJzJHULC34UXQjd/wPbOqnVnlj2A77Qr7cJ7bnsEPk+uaVtBfKnu0326SyPxb6BzA2SGKRSO6yGwHkm3xNptSLWgFNAk0OC9sEr3ENnQVjRJCiqFYsRpx0Ug39l+4IWAxSzmhBm+rtRYSSNCFLOeBkwG4QgyWDZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948701; c=relaxed/simple;
	bh=RamOxJ5Z7TVPbczBY6erBs7luYUj8rXEFbnp6TrXVQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeEo9qncOzE/yg9PuzyfO4xKDhkCv5tqnKOcor6WLP4lCkj/43cWP3VAgJG2ykWlApi5szSf51M/i0vHX1XCmPWIiAbdcO4eaZhHMSlpeVFq2niVHUhvcnMh3muw59Q5+Wxlk0bzsvdc5NXRr65jRlAzmeI4JkdHdASQ0kcO/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR9Cgo8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR9Cgo8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE601F00A3D;
	Wed,  9 Sep 2026 10:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948697;
	bh=xYUACib9CPzNnl8f4PI3xu4mj1nfozKz/pOB2ZW72Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eR9Cgo8kU0kT2lCoYPIRTeCG38XhSmQ1mUtHWrwuG661z1z81ikgtFg5hg/Cj1+gs
	 Gotl0slTWL1Mn0sd/xUnVggckJ4qoltOp6JvMF2suAI6rtCtAub8MIhlvtbvALaLLa
	 rVvC9PZpdjJDTTXA9zmempk2n6HhapNGlG7NM3RnDuJlLOCEnWMlep6g88v4DIz0+M
	 oMsngPdMuLdd6VpGh085Ty6LsOHVvM2/BHN9nJ/xk0P/XtXde4NrYird4BVPUBHmTr
	 Gn95MI7Nf4VozdBagtRccKf2VpMJtUKbyJFiBlf8A4SCUIqGW0s8dlo8fvhm4shEVX
	 fl3EdcFE7rQ6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ring-buffer: Make cpu_buffer::free_page a buffer_data_read_page
Date: Wed,  9 Sep 2026 06:11:35 -0400
Message-ID: <20260909101135.1461760-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090315-spinout-ditto-bd8b@gregkh>
References: <2026090315-spinout-ditto-bd8b@gregkh>
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
index 5936389188bd7..31c7ef21b526a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -531,7 +531,7 @@ struct ring_buffer_per_cpu {
 	raw_spinlock_t			reader_lock;	/* serialize readers */
 	arch_spinlock_t			lock;
 	struct lock_class_key		lock_key;
-	struct buffer_data_page		*free_page;
+	struct buffer_data_read_page	free_page;
 	unsigned long			nr_pages;
 	unsigned int			current_context;
 	struct list_head		*pages;
@@ -2514,7 +2514,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
-	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
+	free_pages((unsigned long)cpu_buffer->free_page.data, cpu_buffer->free_page.order);
 
 	kfree(cpu_buffer);
 }
@@ -6570,9 +6570,9 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
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
@@ -6624,8 +6624,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
-	if (!cpu_buffer->free_page) {
-		cpu_buffer->free_page = bpage;
+	if (!cpu_buffer->free_page.data) {
+		cpu_buffer->free_page = *data_page;
 		bpage = NULL;
 	}
 
@@ -6978,7 +6978,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	for_each_buffer_cpu(buffer, cpu) {
-		struct buffer_data_page *old_free_data_page;
+		struct buffer_data_read_page old_free_data_page;
 		struct list_head old_pages;
 		unsigned long flags;
 
@@ -7021,7 +7021,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		arch_spin_lock(&cpu_buffer->lock);
 		old_free_data_page = cpu_buffer->free_page;
-		cpu_buffer->free_page = NULL;
+		cpu_buffer->free_page.data = NULL;
 		arch_spin_unlock(&cpu_buffer->lock);
 
 		rb_head_page_activate(cpu_buffer);
@@ -7033,7 +7033,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 			list_del_init(&bpage->list);
 			free_buffer_page(bpage);
 		}
-		free_pages((unsigned long)old_free_data_page, old_order);
+		free_pages((unsigned long)old_free_data_page.data, old_free_data_page.order);
 
 		rb_check_pages(cpu_buffer);
 	}
-- 
2.53.0

