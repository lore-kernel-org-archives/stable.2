Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561182;
	b=iBNnmVRnPxy6N0WrAi+PwvAqaZ+xIcw1GhRasha2/iP24ZSHyH+jMaKRkqBRTGOlV5c6
	 622hWQbIxT/ejhqxBwnyGnwgA3ezRSdFvh5k4QkcHh0P9R0pRTwh5kcvKMmhBw7JSXj1h
	 XwiWq9Zu8K3kZrj3Dp4DaiaUAyqjW1z07lLhR5YACb1aqK26LYq+xXhhPefDMcpqKkbHw
	 Am/X1u4hVWHHqxQRdSFBKkkKx/9FEOJHNXvn7zTLc/Z0Ui2raSkpB35T/xeK94AW/ompo
	 VMEkXjaClPmni3uhAwWZn8sXxVHa4X3FEhMPzOv2C6LIte3QEMR7liN05gusWB6Ij4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561182;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=We7g4rjlDEvC14Rt3aeSkNWIUyaxM8r0Z8+EijuZ/qU=;
	b=eGbea6CmLkkAdWeRnLKncxQK7Qz/Lt4NgBq4rCyfdAwchwx2+Wg20e+kghIDg9+Sedut
	 4SN1RUUU0NR/bBAusgvpbwJCEho4fGS5O/cmOvgE0UD5xplwDOBGsrjdjDa/v4v5j98N/
	 lb4NBAJXQHOzTMkA9pjrvpT6tTV6hfqo1MBEhBj4envkBs6cZQaPYmMOJxE7yLa9w5XDv
	 ehOWU3wrJfyGFgkSWlbRBWgyG8KugJdn4dEQAKJB+6/7pwTpnBRQpzGsay07MUAz6tDkM
	 k6J32Z4uUO/DwTZGkaXAlqNH3E1Yvxx1AWXu1/lSk5jk1c2f3TIDAtpYqoQWPX0EXhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ri/17j1R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16966606A31E;
	Tue, 24 Nov 2026 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ri/17j1R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83301F000EC;
	Tue, 24 Nov 2026 22:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561181;
	bh=We7g4rjlDEvC14Rt3aeSkNWIUyaxM8r0Z8+EijuZ/qU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ri/17j1Rt5RKcLJGc3pX2deQYRZ+LZ+G1bAtYDCVYKtkC1Zy5A/Z5GdnbhjahIGwy
	 wr9Ad+6N8dCt7b6yCsWdI431ikhDYv0G/k5QQdEHmX/FhNTxKFwMCYadUzmRnFLJU3
	 5hj4kv5olhynXTApByY3rhShBCwcPUNgHwBISSz1esbVTSAfsjpt81sHNdGMj2Is0Y
	 23kfqQE862hULGihGBIz83ALL46EiiZjaBylYJxDDfQhlasNrzlbNQmnCCqKfwiOT9
	 qk34Wbyf4zVQxAhuXG4ioOz0nYi28zS1qcw2gMw/HSnF1EbYstxQ8uTWXvwQxANjCc
	 RR2nzSPZOEt6A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:26 +0100
Subject: [PATCH RFC 03/19] perf: copy counter values after dropping
 ctx->mutex
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-work-exec-update_lock-v1-3-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 selinux@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=6259; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rc/rAON3FyLKLA9sJD24e24XLxM38HdsZD8TQYVeAlE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSzie1QVTh+4/ME7u4/7/zrpW8dV3CSakh0OF8TxXbyg
 vpf/ZpdHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5soXhn/V3+YtrBRPOqi19
 dpmra5bp3WuC+R2+Hpxn8rbLqG1r+M3I8OquE/PHx1OK6gotRabXL7ntKHmrszRUJuT1rxUXbQT
 tGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

perf_read() copies the values to userspace with the mutex of the
event's context held. If that faults the mutex is held for as long as
the fault takes. With a buffer in a mapping of a file on a FUSE
filesystem or in a range registered with userfaultfd it's the caller who
decides how long that is:

  locks held by perf-reader/212:
   #0: (&ctx->mutex){+.+.}-{4:4}, at: perf_event_ctx_lock_nested+0x18f/0x360

Since commit 2e498d0a74e5 ("perf: Add support for event removal on
exec") perf_event_exec() takes that mutex whenever the task has a perf
context. And begin_new_exec() calls it with exec_update_lock held. So an
exec of the task the event counts for hangs past the point of no return
until the fault is resolved. It can't be killed either:

  locks held by exec-task/211:
   #0: (&sig->cred_guard_mutex){+.+.}-{4:4}, at: bprm_execve+0xb7/0x1400
   #1: (&sig->exec_update_lock){++++}-{4:4}, at: begin_new_exec+0xa4b/0x2df0
   #2: (&ctx->mutex){+.+.}-{4:4}, at: perf_event_exec+0x17e/0xe40

  task:exec-task       state:D pid:211
  Call Trace:
   __schedule+0x1691/0x4b00
   schedule+0xe0/0x2e0
   schedule_preempt_disabled+0x11/0x20
   __mutex_lock+0x6d7/0x2700
   perf_event_exec+0x17e/0xe40
   begin_new_exec+0x1c1e/0x2df0
   load_elf_binary+0x340/0x4af0
   bprm_execve+0x772/0x1400
   do_execveat_common.isra.0+0x3d9/0x540
   __x64_sys_execve+0x8c/0xc0
   do_syscall_64+0x110/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

And everyone who needs the exec_update_lock of the task waits with it.
Since commit 6650527444da ("proc: protect ptrace_may_access() with
exec_update_lock (part 1)") that includes a read of /proc/<pid>/stat:

  task:stat-reader     state:D pid:214
  Call Trace:
   __schedule+0x1691/0x4b00
   schedule+0xe0/0x2e0
   schedule_preempt_disabled+0x11/0x20
   rwsem_down_read_slowpath+0x5cc/0x10c0
   down_read_killable+0xf1/0x5f0
   do_task_stat+0x13b/0x2870
   proc_single_show+0x110/0x1d0
   seq_read_iter+0x2e4/0x1280
   seq_read+0x29b/0x550
   vfs_read+0x171/0xb20
   ksys_read+0x111/0x250
   do_syscall_64+0x110/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

The values are gathered in a kernel buffer anyway. So hand that buffer
to perf_read() and copy it out after the mutex has been dropped. What a
read returns goes into a struct on the stack of perf_read() that the
helpers fill in.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/events/core.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e870f12c3ad81..f00eeded212c4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6188,8 +6188,15 @@ static int __perf_read_group_add(struct perf_event *leader,
 	return ret;
 }
 
-static int perf_read_group(struct perf_event *event,
-				   u64 read_format, char __user *buf)
+/* What a read of an event returns, filled in with ctx->mutex held. */
+struct perf_read_buf {
+	size_t	count;		/* room in the buffer of the reader */
+	u64	values[5];	/* a single event */
+	u64	*group_values;	/* PERF_FORMAT_GROUP, allocated */
+};
+
+static int perf_read_group(struct perf_event *event, u64 read_format,
+			   struct perf_read_buf *rb)
 {
 	struct perf_event *leader = event->group_leader, *child;
 	struct perf_event_context *ctx = leader->ctx;
@@ -6218,23 +6225,20 @@ static int perf_read_group(struct perf_event *event,
 
 	mutex_unlock(&leader->child_mutex);
 
-	ret = event->read_size;
-	if (copy_to_user(buf, values, event->read_size))
-		ret = -EFAULT;
-	goto out;
+	rb->group_values = values;
+	return event->read_size;
 
 unlock:
 	mutex_unlock(&leader->child_mutex);
-out:
 	kfree(values);
 	return ret;
 }
 
-static int perf_read_one(struct perf_event *event,
-				 u64 read_format, char __user *buf)
+static int perf_read_one(struct perf_event *event, u64 read_format,
+			 struct perf_read_buf *rb)
 {
 	u64 enabled, running;
-	u64 values[5];
+	u64 *values = rb->values;
 	int n = 0;
 
 	values[n++] = __perf_event_read_value(event, &enabled, &running);
@@ -6247,9 +6251,6 @@ static int perf_read_one(struct perf_event *event,
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&event->lost_samples);
 
-	if (copy_to_user(buf, values, n * sizeof(u64)))
-		return -EFAULT;
-
 	return n * sizeof(u64);
 }
 
@@ -6270,7 +6271,7 @@ static bool is_event_hup(struct perf_event *event)
  * Read the performance event - simple non blocking version for now
  */
 static ssize_t
-__perf_read(struct perf_event *event, char __user *buf, size_t count)
+__perf_read(struct perf_event *event, struct perf_read_buf *rb)
 {
 	u64 read_format = event->attr.read_format;
 	int ret;
@@ -6283,14 +6284,14 @@ __perf_read(struct perf_event *event, char __user *buf, size_t count)
 	if (event->state == PERF_EVENT_STATE_ERROR)
 		return 0;
 
-	if (count < event->read_size)
+	if (rb->count < event->read_size)
 		return -ENOSPC;
 
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 	if (read_format & PERF_FORMAT_GROUP)
-		ret = perf_read_group(event, read_format, buf);
+		ret = perf_read_group(event, read_format, rb);
 	else
-		ret = perf_read_one(event, read_format, buf);
+		ret = perf_read_one(event, read_format, rb);
 
 	return ret;
 }
@@ -6299,6 +6300,7 @@ static ssize_t
 perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct perf_event *event = file->private_data;
+	struct perf_read_buf rb = { .count = count };
 	struct perf_event_context *ctx;
 	int ret;
 
@@ -6307,9 +6309,14 @@ perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		return ret;
 
 	ctx = perf_event_ctx_lock(event);
-	ret = __perf_read(event, buf, count);
+	ret = __perf_read(event, &rb);
 	perf_event_ctx_unlock(event, ctx);
 
+	/* The copy can sleep in a page fault. Don't hold ctx->mutex for it. */
+	if (ret > 0 && copy_to_user(buf, rb.group_values ?: rb.values, ret))
+		ret = -EFAULT;
+
+	kfree(rb.group_values);
 	return ret;
 }
 

-- 
2.53.0

