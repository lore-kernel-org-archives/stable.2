Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4764BA9E5
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446482; cv=none; b=G99yYw6i4NKJEyLaVjLZACfUrgS3KKIbmofMEt4xazXra9PrB5/CoFpltL074sf2mPfNdbYEIH/eRc7q97J7Ds9XTCd56Q3e8+MrlXchLQ/5nWb7NLqW3Z+1UpKc1LZX6XONPJY8y7SdCcJ/0fE8FJEkWOi+ytQaVbSEuGPfW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446482; c=relaxed/simple;
	bh=wp+KdiNz60VaWoB6v1nh/vYQF3ELB+LsKCFVjYjgHTE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sRxPyecaTdum6U+/x4vr1N1D7inNRTdPQsWnyhlhACOcjqo8E6qUFgzXjs10TmV1/z2ly9O1dMMdTo/LfZUdoF/zTnTI5DymkBPXIlaqWAUsvVXUVQCjGbSz3PmBAtloBne6jUDPKPATDg6AZaDEUnQixyi6Ce4F8yIQoi2xVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TEKDDUhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TEKDDUhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D958F1F000E9;
	Thu,  3 Sep 2026 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788446476;
	bh=GLo/CaE0G4JrmvnbrhKnCphtbNIGIc4AHbf+35u7y0Y=;
	h=Subject:To:Cc:From:Date;
	b=TEKDDUhSU1T3VrSs3LQ7TYJYcoSYVkoW1Qbv0wpKly3lMu/oFcOMA9DAZu3ELXrt6
	 0BadA/ezh1YAUr4mvVyurofQ3mb+MGy1IPqhdVeVPebZJUnLDf+8IbhPIxYGgngemI
	 fCPiQ99bQgNiPpOydF6PCxjL9VMhK0J2PYm/nUPw=
Subject: FAILED: patch "[PATCH] ring-buffer: Make cpu_buffer::free_page a" failed to apply to 6.12-stable tree
To: vdonnefort@google.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:23:15 +0200
Message-ID: <2026090315-unify-unvisited-eed3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7a1fb95de5404134f8758c1295ce88986bdf117c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090315-unify-unvisited-eed3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a1fb95de5404134f8758c1295ce88986bdf117c Mon Sep 17 00:00:00 2001
From: Vincent Donnefort <vdonnefort@google.com>
Date: Thu, 13 Aug 2026 14:11:45 +0100
Subject: [PATCH] ring-buffer: Make cpu_buffer::free_page a
 buffer_data_read_page

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

