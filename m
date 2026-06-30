Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1A26A1C4;
	Tue, 30 Jun 2026 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799426; cv=none; b=A370/ecBsBH68wMqB/ot4r7pvqrSVGM3JMKLAJnZoINrjQyRY9+UKnX3R/atF4PulUR1FXHwmMtPA8MmMSjygmeeQ2bHc5FuP4QGpXahs0/6LGw/wfbzxc8rRGuDLoqR8s6cOh1qHe/J+ftIlilUXDZrcoGemT6q4seUmjlx/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799426; c=relaxed/simple;
	bh=M0nnLU7vMMeoiA8EZursO1OOQqLGtOyhTaCh5nLeXT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuPChmam1CAs/4TCuJU7YL1wy1L79ngke0eqmjxwGCV03/NxtFv9HRhh93DmdL6jzr1Vk/ds4Z71oSCcmMC1PsCNWRFhoIzyE2ggI0LSpC+d//UvRvzp5X+NGMuhhxhDr/ZbRsMvFVRx+QiSqyNRnLtM4AdLfjsBVWClYrbu7Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=cUMnkwGZ; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="cUMnkwGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1782799425; x=1814335425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rmr4btVRER2BX4fPtwmlV+JwydvNU/M1KH18CiqhJ18=;
  b=cUMnkwGZV758SQwH8Y164FyyiL0FFVDJlDZzvlES1st2Y5z4ZPbg0oRg
   lPkBLBvNhMkUD5YHVEFJg8UbpKgu/fdxJPOsdwELSpLtOEIT80dCbc9vP
   DajpjWOwNeqw8X9zdIE7x9fbAoPZ3TQNqRK3NJ8O0XujotyeVHBPKIR3H
   g3R22QU9Gx0ItTw/rryZDSU5YWGhSbgdXNQnkaOpiabb0qJFCRCvNyl/C
   xv6l2aiUyrD4VcHdOkF3tBu67p1/hB9f5oD5p/z3dNKjQNwVXASRW9g1M
   eaQfyWW0lCrHKsFYTA32z/5O7wzzbGnzB3lKXmGlC+WnYWNKlm7LFAQKi
   Q==;
X-CSE-ConnectionGUID: aLTCayzKS5uagxBZ79M2iw==
X-CSE-MsgGUID: cIQflDt8SZuJDSooLJSyqg==
X-IronPort-AV: E=Sophos;i="6.24,233,1774310400"; 
   d="scan'208";a="22733540"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 06:03:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:20408]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.142:2525] with esmtp (Farcaster)
 id 1296e2c2-a45e-46af-8e7a-292d17548063; Tue, 30 Jun 2026 06:03:42 +0000 (UTC)
X-Farcaster-Flow-ID: 1296e2c2-a45e-46af-8e7a-292d17548063
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 30 Jun 2026 06:03:42 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 30 Jun 2026 06:03:40 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: <sashal@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <dhowells@redhat.com>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<doebel@amazon.de>
Subject: [PATCH v2 5.15.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Tue, 30 Jun 2026 06:03:21 +0000
Message-ID: <20260630060321.1494832-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260625054005.0014.ringbuf-515@kernel.org>
References: <20260625054005.0014.ringbuf-515@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ Upstream commit 119a5d573622ae90ba730d18acfae9bb75d77b9a ]

When the ring buffer was first introduced, reading the non-consuming
"trace" file required disabling the writing of the ring buffer. To make
sure the writing was fully disabled before iterating the buffer with a
non-consuming read, it would set the disable flag of the buffer and then
call an RCU synchronization to make sure all the buffers were
synchronized.

The function ring_buffer_read_start() originally  would initialize the
iterator and call an RCU synchronization, but this was for each individual
per CPU buffer where this would get called many times on a machine with
many CPUs before the trace file could be read. The commit 72c9ddfd4c5bf
("ring-buffer: Make non-consuming read less expensive with lots of cpus.")
separated ring_buffer_read_start into ring_buffer_read_prepare(),
ring_buffer_read_sync() and then ring_buffer_read_start() to allow each of
the per CPU buffers to be prepared, call the read_buffer_read_sync() once,
and then the ring_buffer_read_start() for each of the CPUs which made
things much faster.

The commit 1039221cc278 ("ring-buffer: Do not disable recording when there
is an iterator") removed the requirement of disabling the recording of the
ring buffer in order to iterate it, but it did not remove the
synchronization that was happening that was required to wait for all the
buffers to have no more writers. It's now OK for the buffers to have
writers and no synchronization is needed.

Remove the synchronization and put back the interface for the ring buffer
iterator back before commit 72c9ddfd4c5bf was applied.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250630180440.3eabb514@batman.local.home
Reported-by: David Howells <dhowells@redhat.com>
Fixes: 1039221cc278 ("ring-buffer: Do not disable recording when there is an iterator")
Tested-by: David Howells <dhowells@redhat.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Assisted-by: Kiro:claude-opus-4.8
[doebel@amazon.de: move patch section using guard() macro into a
separate block to address declaration after statement warning.]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
 include/linux/ring_buffer.h |  4 +--
 kernel/trace/ring_buffer.c  | 72 ++++++++-----------------------------
 kernel/trace/trace.c        | 14 +++-----
 kernel/trace/trace_kdb.c    |  8 ++---
 4 files changed, 22 insertions(+), 76 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 3e7bfc0f65aee..b53335ed2d0ef 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -130,9 +130,7 @@ ring_buffer_consume(struct trace_buffer *buffer, int cpu, u64 *ts,
 		    unsigned long *lost_events);
 
 struct ring_buffer_iter *
-ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags);
-void ring_buffer_read_prepare_sync(void);
-void ring_buffer_read_start(struct ring_buffer_iter *iter);
+ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags);
 void ring_buffer_read_finish(struct ring_buffer_iter *iter);
 
 struct ring_buffer_event *
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e44115db0efe3..e7c472729542d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5037,28 +5037,20 @@ ring_buffer_consume(struct trace_buffer *buffer, int cpu, u64 *ts,
 EXPORT_SYMBOL_GPL(ring_buffer_consume);
 
 /**
- * ring_buffer_read_prepare - Prepare for a non consuming read of the buffer
+ * ring_buffer_read_start - start a non consuming read of the buffer
  * @buffer: The ring buffer to read from
  * @cpu: The cpu buffer to iterate over
  * @flags: gfp flags to use for memory allocation
  *
- * This performs the initial preparations necessary to iterate
- * through the buffer.  Memory is allocated, buffer recording
- * is disabled, and the iterator pointer is returned to the caller.
- *
- * Disabling buffer recording prevents the reading from being
- * corrupted. This is not a consuming read, so a producer is not
- * expected.
- *
- * After a sequence of ring_buffer_read_prepare calls, the user is
- * expected to make at least one call to ring_buffer_read_prepare_sync.
- * Afterwards, ring_buffer_read_start is invoked to get things going
- * for real.
+ * This creates an iterator to allow non-consuming iteration through
+ * the buffer. If the buffer is disabled for writing, it will produce
+ * the same information each time, but if the buffer is still writing
+ * then the first hit of a write will cause the iteration to stop.
  *
- * This overall must be paired with ring_buffer_read_finish.
+ * Must be paired with ring_buffer_read_finish.
  */
 struct ring_buffer_iter *
-ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
+ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_iter *iter;
@@ -5083,51 +5075,15 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 
 	atomic_inc(&cpu_buffer->resize_disabled);
 
-	return iter;
-}
-EXPORT_SYMBOL_GPL(ring_buffer_read_prepare);
+	{
+		guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 
-/**
- * ring_buffer_read_prepare_sync - Synchronize a set of prepare calls
- *
- * All previously invoked ring_buffer_read_prepare calls to prepare
- * iterators will be synchronized.  Afterwards, read_buffer_read_start
- * calls on those iterators are allowed.
- */
-void
-ring_buffer_read_prepare_sync(void)
-{
-	synchronize_rcu();
-}
-EXPORT_SYMBOL_GPL(ring_buffer_read_prepare_sync);
-
-/**
- * ring_buffer_read_start - start a non consuming read of the buffer
- * @iter: The iterator returned by ring_buffer_read_prepare
- *
- * This finalizes the startup of an iteration through the buffer.
- * The iterator comes from a call to ring_buffer_read_prepare and
- * an intervening ring_buffer_read_prepare_sync must have been
- * performed.
- *
- * Must be paired with ring_buffer_read_finish.
- */
-void
-ring_buffer_read_start(struct ring_buffer_iter *iter)
-{
-	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long flags;
-
-	if (!iter)
-		return;
-
-	cpu_buffer = iter->cpu_buffer;
+		arch_spin_lock(&cpu_buffer->lock);
+		rb_iter_reset(iter);
+		arch_spin_unlock(&cpu_buffer->lock);
+	}
 
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-	arch_spin_lock(&cpu_buffer->lock);
-	rb_iter_reset(iter);
-	arch_spin_unlock(&cpu_buffer->lock);
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	return iter;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_start);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 537360be8e4e0..1a29a9d9e8685 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4803,21 +4803,15 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
 			iter->buffer_iter[cpu] =
-				ring_buffer_read_prepare(iter->array_buffer->buffer,
-							 cpu, GFP_KERNEL);
-		}
-		ring_buffer_read_prepare_sync();
-		for_each_tracing_cpu(cpu) {
-			ring_buffer_read_start(iter->buffer_iter[cpu]);
+				ring_buffer_read_start(iter->array_buffer->buffer,
+						       cpu, GFP_KERNEL);
 			tracing_iter_reset(iter, cpu);
 		}
 	} else {
 		cpu = iter->cpu_file;
 		iter->buffer_iter[cpu] =
-			ring_buffer_read_prepare(iter->array_buffer->buffer,
-						 cpu, GFP_KERNEL);
-		ring_buffer_read_prepare_sync();
-		ring_buffer_read_start(iter->buffer_iter[cpu]);
+			ring_buffer_read_start(iter->array_buffer->buffer,
+					       cpu, GFP_KERNEL);
 		tracing_iter_reset(iter, cpu);
 	}
 
diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 59857a1ee44cd..628c25693cef2 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -43,17 +43,15 @@ static void ftrace_dump_buf(int skip_entries, long cpu_file)
 	if (cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
 			iter.buffer_iter[cpu] =
-			ring_buffer_read_prepare(iter.array_buffer->buffer,
-						 cpu, GFP_ATOMIC);
-			ring_buffer_read_start(iter.buffer_iter[cpu]);
+			ring_buffer_read_start(iter.array_buffer->buffer,
+					       cpu, GFP_ATOMIC);
 			tracing_iter_reset(&iter, cpu);
 		}
 	} else {
 		iter.cpu_file = cpu_file;
 		iter.buffer_iter[cpu_file] =
-			ring_buffer_read_prepare(iter.array_buffer->buffer,
+			ring_buffer_read_start(iter.array_buffer->buffer,
 						 cpu_file, GFP_ATOMIC);
-		ring_buffer_read_start(iter.buffer_iter[cpu_file]);
 		tracing_iter_reset(&iter, cpu_file);
 	}
 
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

