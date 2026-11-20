Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196479;
	b=k3rj/ejUw689oTH9TowPJuO2ZcMUiYyh3eM7DUbRIbl5n6CIdbLFtiiMFQNHlCClzUsz
	 09Gpl0Olh2+uCwUsHrTbxW0KbbdcVPT7unOixyGKpW83UDIlFff/6AydBpy6I0kqTegNq
	 eb4UgkqAnomYM2XXrrvICjPlvRR7OxhKRHNTjQj0nUOwQ87RgZPPuF3AxbSYjiK9PMmKu
	 Ex6pWRwZeR9yleaLRWesvE9yYUXaZnXGtRoiuOgs56y06RocKQ82op867VFaAbDpXA7lh
	 7IWxlnt9+46ekaxW/Ck/yb6lmA5OTQ64u+dp89wI7hL977A6JHdAhRj091ECaDgV85g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196479;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=lLHe99j0H7z4qGlyV8j8JNJiq4f64W4G+h4fzRpJrxk=;
	b=ejs/qrDUYDcNycpHlGSBl2wg9PmX04UUDMU+rxJZcp52CmlAN01zYB8MM3v3Txl9czOH
	 OaUOM94J+fIWQp2t9oBv/WsoSfhga0AxsU2g1UEoZhCXULc0+aSrqhMIZiNSHLW7cN1rv
	 jRB+mBdAM1NSRRBMpxPJxAeyTTBk1n5KiIHgPvz+ACOq9UeJyj3Ft3no1NA8Kw1Etg68u
	 INptAZPMESXuegbEpU13g9VentAH/H7vnGgkk9q9E+MpbdYpKHD6b1cBJpwuIOA9EQJSX
	 Yg2nZsWDJDofWN2rEdu16l/hlcd7mK/84iAJEN5ImGx3HC/SEB4CIN5zrHWcJIIDJPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMH6dgjg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B9760A2610;
	Fri, 20 Nov 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMH6dgjg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AC21F000EE;
	Fri, 20 Nov 2026 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196479;
	bh=lLHe99j0H7z4qGlyV8j8JNJiq4f64W4G+h4fzRpJrxk=;
	h=Date:From:To:Cc:Subject:References;
	b=LMH6dgjgEvFkrv+n0yer/WGLOF8o9m9kRmz6oqgz04c9NZllizTSNZshFx7RUQt8C
	 jpGNpv+GeZx4GmyRxj+mNWDT82dhofsUf+222XWoyVy17oVWEXj7bl0pPR4zAdToog
	 HUOa5QSBhTyvJQCC9yONGQW7DKuZRVa65S41E5bYzmMPkmycCC+AWmqgMPic1sbSOA
	 e8dCazUJcNGWaCXenrAh+s5nJIZK317LvTuuYevrugjqL5tU0bfcfYW0/nRJ/nqzRh
	 A3lQBJ8vrHfyGWcjTefDDAsYiXljFOF2UYjMWWMOer++wEj3Y0xHaUJ5tmyFtrT27i
	 RxfxnKuW8VCaA==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbu-00000004aQb-1NMD;
	Fri, 20 Nov 2026 12:41:18 -0500
Message-ID: <20261120174118.166817590@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:14 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 22/32] ring-buffer: Check remote reader page commit before meta entries
References: <20261120173852.687189370@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

__rb_get_reader_page_from_remote() bails out when rb_num_of_entries() is
zero before verifying if there is more data committed on the current
reader_page (rb_page_size()), while simple_ring_buffer updates
page::commit before meta::entries. As a consequence, a race between the
writer and reader could lead to __rb_get_reader_page_from_remote()
returning NULL, while more data is available for reading on the ring
buffer.

  CPU0 (writer)                       CPU1 (reader)
  -------------                       -------------
  local_set(&page->commit, write);
                                      __rb_get_reader_page_from_remote()
                                        !rb_read_remote_meta_page()
                                          return NULL;
  simple_rb_meta_inc(meta->entries, 1);

This is an issue for rb_advance_reader() which always expects
rb_get_reader_page() to return a page.

Fix this issue by swapping the checks in
__rb_get_reader_page_from_remote(): first it verifies if there is more
to read in the current reader page, then it verifies if there's anything
at all in the ring buffer.

Also, if the reader observes the meta::entries update before
page::commit while the writer moves tail_page, it could swap reader_page
out and drop unread events. Order page::commit before meta::entries on
the writer and rb_read_remote_meta_page() before rb_page_size() on the
reader size.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261113152729.837429-3-vdonnefort@google.com
Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c        | 19 +++++++++++++------
 kernel/trace/simple_ring_buffer.c |  6 ++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 15ccb65de35b..f728ee82cf54 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5615,14 +5615,12 @@ unsigned long ring_buffer_overruns(struct trace_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_overruns);
 
-static bool rb_read_remote_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+static void rb_read_remote_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	local_set(&cpu_buffer->entries, READ_ONCE(cpu_buffer->meta_page->entries));
 	local_set(&cpu_buffer->overrun, READ_ONCE(cpu_buffer->meta_page->overrun));
 	local_set(&cpu_buffer->pages_touched, READ_ONCE(cpu_buffer->meta_page->pages_touched));
 	local_set(&cpu_buffer->pages_lost, READ_ONCE(cpu_buffer->meta_page->pages_lost));
-
-	return rb_num_of_entries(cpu_buffer);
 }
 
 static void rb_update_remote_head(struct ring_buffer_per_cpu *cpu_buffer)
@@ -5825,8 +5823,13 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct buffer_page *new_reader, *prev_reader, *prev_head, *new_head, *last;
 
-	if (!rb_read_remote_meta_page(cpu_buffer))
-		return NULL;
+	rb_read_remote_meta_page(cpu_buffer);
+
+	/*
+	 * Order meta::entries read before page::commit, most likely paired with
+	 * simple_ring_buffer_commit().
+	 */
+	smp_rmb();
 
 	/* More to read on the reader page */
 	if (cpu_buffer->reader_page->read < rb_page_size(cpu_buffer->reader_page)) {
@@ -5835,6 +5838,9 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 		return cpu_buffer->reader_page;
 	}
 
+	if (!rb_num_of_entries(cpu_buffer))
+		return NULL;
+
 	prev_reader = cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
 
 	if (cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
@@ -6909,7 +6915,8 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 		cpu_buffer = buffer->buffers[cpu];
 
 		guard(raw_spinlock)(&cpu_buffer->reader_lock);
-		if (rb_read_remote_meta_page(cpu_buffer))
+		rb_read_remote_meta_page(cpu_buffer);
+		if (rb_num_of_entries(cpu_buffer))
 			rb_wakeups(buffer, cpu_buffer);
 
 		return 0;
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index d5c84af01925..5f14ba152fba 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -309,6 +309,12 @@ void simple_ring_buffer_commit(struct simple_rb_per_cpu *cpu_buffer)
 {
 	local_set(&cpu_buffer->tail_page->page->commit,
 		  cpu_buffer->tail_page->write);
+
+	/*
+	 * Order page::commit before meta::entries. Paired with
+	 * __rb_get_reader_page_from_remote().
+	 */
+	smp_wmb();
 	simple_rb_meta_inc(cpu_buffer->meta->entries, 1);
 
 	/*
-- 
2.53.0
