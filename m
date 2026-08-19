Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837F3AC0FC
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151401; cv=none; b=Q8GzS67G11FTMdJCdyWn8G972Te+IXJrC/Ce7SJewxWnYhRWQfNZJPNuHVm7cN/eM7JpC3pNFiVR8l9D/0BYuEsgUKHpWNXRlbZi1lBpMzUvAIXTpDfBJkWbbjCmWJOpW6+N/3Gbi0rsKPjURoYixZ2q1LB6KoZYkOS8Db1Mk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151401; c=relaxed/simple;
	bh=yw/iz8V5wXZiue6OMeHWpm2edtgvgSFZ9sjII5p9zjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5fVgrSS/l1as5RJbTtx42aoqR7s2WggSdYRIc1cziCga4YEdRUX8PnQXtjvo0WkFSLlRQZ62+RL1nXKmE6M7byNKLjZYIeU4YEMrbxoI/QYgyKT+N0smZToyEe66S4uL9qVS7NMKEtItxBNO6gu2Oy7uNr7n2H+7M3r7Rn0q+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2HKV2FF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2HKV2FF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2C41F000E9;
	Wed, 19 Aug 2026 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787151391;
	bh=VQRvDHzpHG/B2RJ6Y/Jeh7GBmn4JwFWKY4l6HgPx9YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2HKV2FFTQR094jPFvJx0WglbzYnjYuehpIw0lHOxNEEG2Va6Hi9Uccoz6PiEkgel
	 KcIi/DXqKDqbLWNozvHNjO2qUoTq2D+MS/nzAbwBfcslaDtw7s9qRzk0ggMlTC6eEU
	 5TMs6ug3Cq0jwIMCWamdvu40Ss5+ICPmlhBJQbsvzx++7At4LkUHiKKMONjJTPmA2B
	 D/enoO6n7QP5J/KMD9sn9jrrYuOs8ZvKg7+5UQxbxLagiIqcYFHacKKxJXQ8dru/2J
	 cvOu8HqehVBceMmW8gQRn2HAcoqeICFy+V+Y/FGbUnVCfZv761sbNdswRkV57F48r5
	 kMCQ3+PSVDUcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] ring-buffer: Simplify ring_buffer_read_page() with guard()
Date: Wed, 19 Aug 2026 10:56:26 -0400
Message-ID: <20260819145628.3900889-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081709-tank-childcare-2caa@gregkh>
References: <2026081709-tank-childcare-2caa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit b2e7c6ed26e90fab1e5e626071e54e3b9ec9cb5a ]

The function ring_buffer_read_page() had two gotos. One was simply
returning "ret" and the other was unlocking the reader_lock.

There's no reason to use goto to simply return the "ret" variable. Instead
just return the value.

The jump to the unlocking of the reader_lock can be replaced by
guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock).

With these two changes the "ret" variable is no longer used and can be
removed. The return value on non-error is what was read and is stored in
the "read" variable.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250527145216.0187cf36@gandalf.local.home
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 7c727dfce6be ("ring-buffer: Prevent resizing of persistent ring buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fcd2363d1296..93f5c8326aec 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6483,38 +6483,37 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	struct buffer_data_page *bpage;
 	struct buffer_page *reader;
 	unsigned long missed_events;
-	unsigned long flags;
 	unsigned int commit;
 	unsigned int read;
 	u64 save_timestamp;
-	int ret = -1;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
-		goto out;
+		return -1;
 
 	/*
 	 * If len is not big enough to hold the page header, then
 	 * we can not copy anything.
 	 */
 	if (len <= BUF_PAGE_HDR_SIZE)
-		goto out;
+		return -1;
 
 	len -= BUF_PAGE_HDR_SIZE;
 
 	if (!data_page || !data_page->data)
-		goto out;
+		return -1;
+
 	if (data_page->order != buffer->subbuf_order)
-		goto out;
+		return -1;
 
 	bpage = data_page->data;
 	if (!bpage)
-		goto out;
+		return -1;
 
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 
 	reader = rb_get_reader_page(cpu_buffer);
 	if (!reader)
-		goto out_unlock;
+		return -1;
 
 	event = rb_reader_event(cpu_buffer);
 
@@ -6548,7 +6547,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		if (full &&
 		    (!read || (len < (commit - read)) ||
 		     cpu_buffer->reader_page == cpu_buffer->commit_page))
-			goto out_unlock;
+			return -1;
 
 		if (len > (commit - read))
 			len = (commit - read);
@@ -6557,7 +6556,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		size = rb_event_ts_length(event);
 
 		if (len < size)
-			goto out_unlock;
+			return -1;
 
 		/* save the current timestamp, since the user will need it */
 		save_timestamp = cpu_buffer->read_stamp;
@@ -6615,7 +6614,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		if (reader->real_end)
 			local_set(&bpage->commit, reader->real_end);
 	}
-	ret = read;
 
 	cpu_buffer->lost_events = 0;
 
@@ -6642,11 +6640,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (commit < buffer->subbuf_size)
 		memset(&bpage->data[commit], 0, buffer->subbuf_size - commit);
 
- out_unlock:
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-
- out:
-	return ret;
+	return read;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
-- 
2.53.0

