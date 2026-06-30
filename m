Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4A368D4B;
	Tue, 30 Jun 2026 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828872; cv=none; b=eZnxxqjIH0yfUWYU370xd9R2wwFvmPn9T/qIzQX+NH0cSfEDIaxZXIH2uKQovHG7v2dGL3HoH7ys5CXsKFb5Tj2HUvC5SbCJgYjiwmaTwSufucy74MJeJk3gT2hk/FiGIOpZ+4fiu6kO1zk+S8PGujne/1YkgssJfuxd5WTZfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828872; c=relaxed/simple;
	bh=PwH310FBQTBvdHCoLfGzmSrANp3Bqt2FpZDKA7Nhyk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUZKrjzc0X7Vl9Q2LOaS+mfaBTQw2lq7EqoOyviD+sxoWv7bA5G1R6ZTgXikg/h/NSw4IUcE5k/DNgLwVtEv/A6Xdxyr5jJKMDqa4xDW3p9wEGkbGp9xj65QOpK6iPrzm8GCINrFu2yxXVewnvTlOVxvJEAoKFK2WHWL0qDtOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 0FEBF403E0;
	Tue, 30 Jun 2026 14:14:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id DCA7332;
	Tue, 30 Jun 2026 14:14:26 +0000 (UTC)
Date: Tue, 30 Jun 2026 10:14:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Petr Pavlu <petr.pavlu@suse.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
Subject: Re: [PATCH] ring-buffer: serialize read-page order with subbuffer
 resize
Message-ID: <20260630101425.2f7cfbea@robin>
In-Reply-To: <20260628004653.28065-1-alhouseenyousef@gmail.com>
References: <20260628004653.28065-1-alhouseenyousef@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DCA7332
X-Stat-Signature: 7cyemezwwtjp9i8xnwhcd9wdf9fqtk7h
X-Rspamd-Server: rspamout04
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19L+GwPBECdO2so7eCvp2QiHCbJnt0mzyA=
X-HE-Tag: 1782828866-826489
X-HE-Meta: U2FsdGVkX1+K2fEh98m5XirtWDc/lRmH2GJcUL11VG+llqtyQQg8h+Fzi4h47dG1P77zbXgabiZ+wTsJ8ZVfPszC0FkZ2+lFCUBqZvnktLuSyHMS2o+TTra7oGpVh7ncx8cL1uPCDHubH+/0mN2cKVdFG+YZ0yQ1fopaWMs1eBdyOi12ZRnXrKE/gTKKiqE7mt+/PMwj4/YYSui4ua4jYVMS8dGGe44P4QGVFZmPOpW1oJ1mODVjzLuIjLMNaLjq30wLnyh2f60gxr5hPEHBvb+WZNKJ+AxLUbDuD6Mudye1LY0quxDwvLUCKf9G0c3+8wZjukV1WFIuxMD4p/g2kzaChxM8ji+0groZCrAYlsVdZ2lSdlAV8njxOHQLNzoaxE9dnswBCw1GjmhAURfUXK8h8BUa4fbZ8l8F+9+KFo5ztZ7eiPCyw8A984kCMPgT347ez1U0pMru0Z5eyvE7XlLtr0Zogcs1ajVd27L0m1g=

On Sun, 28 Jun 2026 02:46:53 +0200
Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:

> ring_buffer_read_page() checks that its spare page has the current
> subbuffer order before taking cpu_buffer->reader_lock. A concurrent
> ring_buffer_subbuf_order_set() can change the order and replace the
> reader page after that check. The reader then copies a larger subbuffer
> into the old allocation, causing an out-of-bounds write.
> 
> Keep spare-page allocation and release under buffer->mutex, which already
> serializes order changes. Move the read-side order check under
> reader_lock, the lock used by resize when replacing per-CPU pages.
> 
> Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> Reported-by: syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2dd9d02f60775ce5c1fb
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  kernel/trace/ring_buffer.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 56a328e94395..eed5d7cffdee 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6950,6 +6950,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  		return ERR_PTR(-ENODEV);
>  
> +	guard(mutex)(&buffer->mutex);
> +
>  	bpage = kzalloc_obj(*bpage);

First, do not grab locks around allocations unless the are really needed.
This is bad practice, as it extends the critical section and may even add
the allocation locking to the lock chain.

That said, just moving things around the current locks should work.

Like this (not compiled nor tested):

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 56a328e94395..8352f935a223 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6954,11 +6954,11 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (!bpage)
 		return ERR_PTR(-ENOMEM);
 
-	bpage->order = buffer->subbuf_order;
 	cpu_buffer = buffer->buffers[cpu];
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
+	bpage->order = buffer->subbuf_order;
 	if (cpu_buffer->free_page) {
 		bpage->data = cpu_buffer->free_page;
 		cpu_buffer->free_page = NULL;
@@ -7007,13 +7007,13 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	 * is different from the subbuffer order of the buffer -
 	 * we can't reuse it
 	 */
-	if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
+	if (page_ref_count(page) > 1)
 		goto out;
 
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
-	if (!cpu_buffer->free_page) {
+	if (!cpu_buffer->free_page && data_page->order == buffer->subbuf_order)
 		cpu_buffer->free_page = dpage;
 		dpage = NULL;
 	}
@@ -7091,15 +7091,15 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (!data_page || !data_page->data)
 		return -1;
 
-	if (data_page->order != buffer->subbuf_order)
-		return -1;
-
 	dpage = data_page->data;
 	if (!dpage)
 		return -1;
 
 	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 
+	if (data_page->order != buffer->subbuf_order)
+		return -1;
+
 	reader = rb_get_reader_page(cpu_buffer);
 	if (!reader)
 		return -1;

-- Steve
