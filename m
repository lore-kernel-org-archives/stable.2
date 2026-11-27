Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804963;
	b=Z0InanH67Fx7AWfUyFR7CDgFMhazJPbLJHK8sAeAqHEZKZW/w/qQYLBig5ZWNDzWYrHT
	 rcOgVsHgQ78z8i+flc2+mvemILCECLkj4SJvl90NbJYACWFcYl3u6TUZil4yWUG/DQwWR
	 WyRmgi9zBxHtSWvY08uQKWGtfxBs3ISHySvNWTeidxXhFeoMLV8LFtC/+pYnlBAB3dHC1
	 +j8vyTKxTD6NBHEsMbR+UTIAL2NEI0r+PxAbifO+kJktFr1D8mgfl0jf/LTbDDc7DtXDD
	 VBD/JSHofLiPXgcdDNz1xk5qFPHYrpuVbvU6EI/HlYoP9INylSAxLXaf1lxkcqvXV5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804963;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=A7Y/nzn7caR25n0KaV+D3jc/5c+H1DXCH0PNb3VMMqg=;
	b=Lh+j5jFfreTf9yt+q5rqHP9cBEFc5nJ9UC5xj/QXMC9yb1CUZ03yX3uXR/Q4wcL/i+xf
	 4iSekWgLwrdmxro5wp40z+xqVLj1L+ycoUujE+bGV4ms9binEagFcrSjz7aE3GYxl+l8p
	 nKgd5Oe1yO8ZK2p5V/0SOeSUfkh5NEbcEmp06J25wCbPTf7wNo6OJ5gcI0XRQGUMtnmEP
	 WRh4yuHo3UUZ0dBGFjxszUNVMX/NXsYvtTjJMRqfDv+qIFkC/gInCgw5W+5nn0o+mpS0l
	 1bcEnDyLDGybE7+cP11woogky9PSiXCkaoZ6gRxa/9z1O0AUucusFsHBO3zw4+REAbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWloFxq4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1860A2619;
	Fri, 27 Nov 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWloFxq4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470C11F00A17;
	Fri, 27 Nov 2026 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804963;
	bh=A7Y/nzn7caR25n0KaV+D3jc/5c+H1DXCH0PNb3VMMqg=;
	h=Date:From:To:Cc:Subject:References;
	b=cWloFxq41CCcpp5BF6/xePiDtxHZL+QIMcITIOFZg6LD+bIMokGYK5D+O+DWr3B3+
	 DFFRYNNuHzRrNrzaBwykjK5C3yKJizdq9Fpwoy/4OCHbiNuNySKLktUFFl/3t8VRaX
	 HhGhJBg1z75l5Yvs1UqwoUp7S+Ak91GQnnYPUex+eGISu+X/3Mj7Ppo+oEEwyoEaN6
	 e2kQdgsmdM2SycTUmV6CMj2m9cDK4W0kenMPP1RoseghhiPMPswsx5JNeJuWITlgg/
	 jV13r4vHGahBAfcvrsKcsjU1SBPstAC2q8E/ILg3qdRv6MLs5/Z+zHggVzXWu0m1Xl
	 nLbVfQpLaokCw==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xX0uA-000000085b0-2YJa;
	Fri, 27 Nov 2026 13:42:42 -0500
Message-ID: <20261127184242.411375401@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 27 Nov 2026 13:42:08 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+1faa12be48036b80e416@syzkaller.appspotmail.com
Subject: [for-linus][PATCH 5/5] tracing/filters: Use atomic bitops and READ_ONCE() for
 trace_event_file::flags
References: <20261127184203.439481361@kernel.org>
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

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

syzbot reported a KCSAN data race on struct trace_event_file::flags
between filter_disable() and __trace_trigger_soft_disabled():

  BUG: KCSAN: data-race in __trace_trigger_soft_disabled /
  apply_subsystem_event_filter

  write to 0xffff888100172888 of 8 bytes by task 5433 on cpu 0:
   filter_disable [inline]
   process_system_preds [inline]
   create_system_filter [inline]
   apply_subsystem_event_filter+0x28f/0xcd0
   subsystem_filter_write+0x79/0xd0

  read to 0xffff888100172888 of 8 bytes by task 5440 on cpu 1:
   __trace_trigger_soft_disabled+0x20/0x1a0
   trace_trigger_soft_disabled [inline]

filter_disable() and event_set_filtered_flag() update
EVENT_FILE_FL_FILTERED using non-atomic read-modify-write operations on
file->flags and compare old_flags != file->flags to decide whether to
call trace_buffered_event_disable() / trace_buffered_event_enable().

Because other bits in file->flags (such as
EVENT_FILE_FL_SOFT_DISABLED_BIT from event enable/disable triggers) can
be modified concurrently without event_mutex using atomic bitops, the
non-atomic RMW can lose concurrent bit updates or misdetect a flag
transition and unbalance the buffered event refcount.

Use test_and_clear_bit() / test_and_set_bit() on
EVENT_FILE_FL_FILTERED_BIT in filter_disable() and
event_set_filtered_flag(), and use READ_ONCE() / test_bit() for lockless
readers of file->flags in the trace event fast paths.

CC: stable@vger.kernel.org
Link: https://patch.msgid.link/179533184612.139632.4029978219979965754.stgit@devnote2
Reported-by: syzbot+1faa12be48036b80e416@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6b0234dc.44b41460.34b83f.0019.GAE@google.com
Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/trace_events.h        |  2 +-
 kernel/trace/trace.c                |  7 ++++---
 kernel/trace/trace.h                | 18 ++++++++++--------
 kernel/trace/trace_events.c         |  2 +-
 kernel/trace/trace_events_filter.c  | 12 ++----------
 kernel/trace/trace_events_trigger.c |  5 +++--
 6 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 321f2f3a6c8e..7a0aa23825de 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -764,7 +764,7 @@ bool __trace_trigger_soft_disabled(struct trace_event_file *file);
 static __always_inline bool
 trace_trigger_soft_disabled(struct trace_event_file *file)
 {
-	unsigned long eflags = file->flags;
+	unsigned long eflags = READ_ONCE(file->flags);
 
 	if (likely(!(eflags & (EVENT_FILE_FL_TRIGGER_MODE |
 			       EVENT_FILE_FL_SOFT_DISABLED |
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 65b9d67647e5..fa65ef8d7fbe 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1886,7 +1886,8 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	*current_rb = tr->array_buffer.buffer;
 
 	if (!tr->no_filter_buffering_ref &&
-	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED))) {
+	    (READ_ONCE(trace_file->flags) &
+	     (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED))) {
 		preempt_disable_notrace();
 		/*
 		 * Filtering is on, so try to use the per cpu buffer first.
@@ -1947,7 +1948,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	 * to store the trace event for the trigger to use. It's recursive
 	 * safe and will not be recorded anywhere.
 	 */
-	if (!entry && trace_file->flags & EVENT_FILE_FL_TRIGGER_COND) {
+	if (!entry && (READ_ONCE(trace_file->flags) & EVENT_FILE_FL_TRIGGER_COND)) {
 		*current_rb = temp_buffer;
 		entry = __trace_buffer_lock_reserve(*current_rb, type, len,
 						    trace_ctx);
@@ -1978,7 +1979,7 @@ static void output_printk(struct trace_event_buffer *fbuffer)
 
 	file = fbuffer->trace_file;
 	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
-	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
+	    (unlikely(test_bit(EVENT_FILE_FL_FILTERED_BIT, &file->flags)) &&
 	     !filter_match_preds(file->filter, fbuffer->entry)))
 		return;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1fec567e789e..32997b58a8a0 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1729,24 +1729,26 @@ __event_trigger_test_discard(struct trace_event_file *file,
 			     void *entry,
 			     enum event_trigger_type *tt)
 {
-	unsigned long eflags = file->flags;
+	unsigned long eflags = READ_ONCE(file->flags);
 
-	if (eflags & EVENT_FILE_FL_TRIGGER_COND)
+	if (eflags & EVENT_FILE_FL_TRIGGER_COND) {
 		*tt = event_triggers_call(file, buffer, entry, event);
+		eflags = READ_ONCE(file->flags);
+	}
 
-	if (likely(!(file->flags & (EVENT_FILE_FL_SOFT_DISABLED |
-				    EVENT_FILE_FL_FILTERED |
-				    EVENT_FILE_FL_PID_FILTER))))
+	if (likely(!(eflags & (EVENT_FILE_FL_SOFT_DISABLED |
+			       EVENT_FILE_FL_FILTERED |
+			       EVENT_FILE_FL_PID_FILTER))))
 		return false;
 
-	if (file->flags & EVENT_FILE_FL_SOFT_DISABLED)
+	if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
 		goto discard;
 
-	if (file->flags & EVENT_FILE_FL_FILTERED &&
+	if (eflags & EVENT_FILE_FL_FILTERED &&
 	    !filter_match_preds(file->filter, entry))
 		goto discard;
 
-	if ((file->flags & EVENT_FILE_FL_PID_FILTER) &&
+	if ((eflags & EVENT_FILE_FL_PID_FILTER) &&
 	    trace_event_ignore_this_pid(file))
 		goto discard;
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7f89160aeff3..394d7cde1a70 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -707,7 +707,7 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 {
 	struct trace_event_call *event_call = trace_file->event_call;
 
-	if ((trace_file->flags & EVENT_FILE_FL_PID_FILTER) &&
+	if (test_bit(EVENT_FILE_FL_PID_FILTER_BIT, &trace_file->flags) &&
 	    trace_event_ignore_this_pid(trace_file))
 		return NULL;
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index a9d77df3e19a..b3ac2519a62d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1349,11 +1349,7 @@ static void free_prog(struct event_filter *filter)
 
 static void filter_disable(struct trace_event_file *file)
 {
-	unsigned long old_flags = file->flags;
-
-	file->flags &= ~EVENT_FILE_FL_FILTERED;
-
-	if (old_flags != file->flags)
+	if (test_and_clear_bit(EVENT_FILE_FL_FILTERED_BIT, &file->flags))
 		trace_buffered_event_disable();
 }
 
@@ -2331,11 +2327,7 @@ static int process_preds(struct trace_event_call *call,
 
 static inline void event_set_filtered_flag(struct trace_event_file *file)
 {
-	unsigned long old_flags = file->flags;
-
-	file->flags |= EVENT_FILE_FL_FILTERED;
-
-	if (old_flags != file->flags)
+	if (!test_and_set_bit(EVENT_FILE_FL_FILTERED_BIT, &file->flags))
 		trace_buffered_event_enable();
 }
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index a2487ad7fef8..96203ba72ab9 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -214,7 +214,7 @@ EXPORT_SYMBOL_GPL(event_triggers_call);
 
 bool __trace_trigger_soft_disabled(struct trace_event_file *file)
 {
-	unsigned long eflags = file->flags;
+	unsigned long eflags = READ_ONCE(file->flags);
 
 	if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
 		event_triggers_call(file, NULL, NULL, NULL);
@@ -1692,7 +1692,8 @@ event_enable_count_func(struct event_trigger_data *data,
 		return false;
 
 	/* Skip if the event is in a state we want to switch to */
-	if (enable_data->enable == !(enable_data->file->flags & EVENT_FILE_FL_SOFT_DISABLED))
+	if (enable_data->enable == !test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT,
+					     &enable_data->file->flags))
 		return false;
 
 	if (data->count != -1)
-- 
2.53.0
