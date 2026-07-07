Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29B40860E;
	Tue,  7 Jul 2026 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431983; cv=none; b=nAW0epQK5LxhxO9gW0f3d55NJBEYVZxPPQhqsPMpDHPOwaMulz8ZI7Sg1M7pFveLB2wwe/B3CT2zwOsEWKaGqynA4hP+ZN248ajP7/1nzBSgd9aHwXCeT+6mrk0NzcgnPJ1Y2mfKkZXvhmZa19x/bO89WoCFuuDo3CguU3m2rOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431983; c=relaxed/simple;
	bh=beh7K05wSH/lp98tzrG3+yPBpvaD+6+uCfta4EDrejM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=edursBmcAQZLXjo18oNq1ethCcr4JLrGBZN5sPQV9oC/NG9u1jN5hFnePB07nwKMZ3a1451Ya4t1i+n1hu28NcESUY5y6bLEndRDb036+Du2qM2bBVmGVUWoD20OeXlcayO4XkHcOtiHpfObHXHRuZ6ZGAS2SgSzXRF9Bca6UlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZpFqpTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZpFqpTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F961F00A3E;
	Tue,  7 Jul 2026 13:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431980;
	bh=MtARyupKBSFTeggqMDtbHRlrQ4fC3iIQB6yfLh3wFqA=;
	h=Date:From:To:Cc:Subject:References;
	b=IZpFqpTqsWLVO9Uzpharapt7JTm855eIA5aYKxsjwIEuC1976sjK/utvhkmNSs8Cg
	 m5SmIhnQb9zbq97k5vTrr4gLw6rl0Y8U/DcRQF1eXtNhZbFbJnKTf/sct7bZm9fngU
	 dDKFm5E6t7Vd2oS9cNrIXvCzC52TclsL1ryBKJrmSP8BAbCDnvDgv8LXaKXXp2a/SU
	 ZxYa7g9mP22kMZ6UsAVDlYUU1Bci5dM4W4RR1QUyUHklEI8YoLCugYhFO2146NIOaj
	 RumVQb6tY60KBWExkc8KanLg8V1ntWWqlOAkvIPCgod5QfRiXG6BY4UwS4DIPBdFE/
	 6gt1k/KU4N1fw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wh680-00000000h34-0HKk;
	Tue, 07 Jul 2026 09:46:24 -0400
Message-ID: <20260707134623.914907495@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 07 Jul 2026 09:46:09 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com,
 Yash Suthar <yashsuthar983@gmail.com>
Subject: [for-linus][PATCH 05/13] ring_buffer: Check page order under reader_lock
References: <20260707134604.275787924@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Yash Suthar <yashsuthar983@gmail.com>

When the ring_buffer_subbuf_order_set() is called the same time as the
ring_buffer_read_page(), the wrong buffer->subbuf_size can be used as
there is nothing keeping that in sync. This can cause an incorrect
allocation and initialization that can cause a crash.

Move the saving of the subbuf_size into a variable within the
cpu_buffer->reader_lock, and use that throughout the function.
The size only needs to be consistent throughout the allocation and
initialization. If the buffer->subbuf_size changes when used, the reader
data page will be found to be invalid and the read function will return an
error (this is as expected).

syzbot did not provide a reproducer for this crash, the race
condition is logically sound and found via code inspection of the
trace.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260611151736.255767-1-yashsuthar983@gmail.com
Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
Reported-by: syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2dd9d02f60775ce5c1fb
Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
[ Rebased to 7.2-rc2 ]
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d9af2bbaf9c0..3ec173e22eeb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7070,6 +7070,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	struct ring_buffer_event *event;
 	struct buffer_data_page *dpage;
 	struct buffer_page *reader;
+	unsigned int subbuf_size;
 	long missed_events;
 	unsigned int commit;
 	unsigned int size;
@@ -7092,15 +7093,22 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (!data_page || !data_page->data)
 		return -1;
 
-	if (data_page->order != buffer->subbuf_order)
-		return -1;
-
 	dpage = data_page->data;
 	if (!dpage)
 		return -1;
 
 	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 
+	/*
+	 * Check data_page order under lock to prevent a race with a
+	 * concurrent ring_buffer_subbuf_order_set() swap, which can
+	 * cause an outofbounds memset() if the subbuf_size changes.
+	 */
+	if (data_page->order != buffer->subbuf_order)
+		return -1;
+
+	subbuf_size = (PAGE_SIZE << data_page->order) - BUF_PAGE_HDR_SIZE;
+
 	reader = rb_get_reader_page(cpu_buffer);
 	if (!reader)
 		return -1;
@@ -7226,7 +7234,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		 * missed events, then record it there.
 		 */
 		if (missed_events > 0 &&
-		    buffer->subbuf_size - size >= sizeof(missed_events)) {
+		    subbuf_size - size >= sizeof(missed_events)) {
 			memcpy(&dpage->data[size], &missed_events,
 			       sizeof(missed_events));
 			local_add(RB_MISSED_STORED, &dpage->commit);
@@ -7246,8 +7254,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/*
 	 * This page may be off to user land. Zero it out here.
 	 */
-	if (size < buffer->subbuf_size)
-		memset(&dpage->data[size], 0, buffer->subbuf_size - size);
+	if (size < subbuf_size)
+		memset(&dpage->data[size], 0, subbuf_size - size);
 
 	return read;
 }
-- 
2.53.0


