Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597699;
	b=ZJmS6R7p666PeFZboglYdjxifK0bxm7UrFfILFszBBZIdO+UsrTG1L9Df2yHvj1fg8PU
	 AXRldMkexUtlq9bdOCoBpjLMmdrrQ0UXUu/fpbZcDyusjwx6wO7vJn21tYJtHHlbm9Zdh
	 Tr6tiszSOvHXQ7FYYBHhQFplHmLutfrzaFUzlFeeKw15o1S9qbqQwsRzhJU8h/SweQDhK
	 egwKYllMSfBNpGU18shwSI4G/VeDgprHJhn+geWGuYFvAqaUVll8vN55IqVrYDPfcD3XO
	 gRqUU61GL04pQmHn3HT3cBhtSJhz3tMsdHy/nyUSYtukal9cS4xpMG5kUbJhPDPtneA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597699;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IZpzJnxKh3w+OTjNcXecABBXii5XSw5j1B4o5PHMblU=;
	b=Us/WMimTfA3Hfj+t3JkToMgn8nB7gc/1nAmMrIWPlSypCZTHDvvJBn166UvOwojt/ErF
	 eugW5oRx1RLpoAO74RhGoB5c+OGXrq8gYKxerixujJsAraIW1h5Lp7vtxZaucgN9CQzKt
	 Z+J8/D+4veG/G6uoS+iDqDhTirZPBg7C7Mj/BkAsgU+vruLbIF7Ey08ZJ/pUwDk7M+6f6
	 rbp3u+ZDWL7JYSnvuPYOdESn5Uvk3D3U4o/rniOdXxtnNoAlxk7TEwCSFYn6Ma0smdtmB
	 L4VhOyx9ik00b4eMQWtbW7nTcOULN6GVcbsBH03u2P+MJtr5M30b3mNgk224Mg36k4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwNjqQH1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA4606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwNjqQH1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FABA1F000C1;
	Wed, 21 Oct 2026 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792597699;
	bh=IZpzJnxKh3w+OTjNcXecABBXii5XSw5j1B4o5PHMblU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WwNjqQH1DsVR6yNiH3NlO7UEMWxZdlWgF+Qp0KTvCUir3ZvD8dBjpw/OOO6jI1PG4
	 ItOUTMZRF0xs0TornaJK3aqAs6PovRU5QX3AFZVe4QHGoCFnJjM0Mk7Ic8tpl+V+Kq
	 kso4fKQKds0h3orzqPcpyJJhNonRd+9iWRYdC9Jmb5ShHRtIla7IGiVwxXb9tzSuvP
	 hfonLw7Z96vyT4Vo+4IluAoU0QhrsL0W8qhgG/c9RI07aJVGo2HA7eLSuoiq0rGeZU
	 qH0iGrms6BLa0AMYvGeq5BUWDiXOnSDw32/VKSV9Og401gDJQJr6wmb8zCNeJQ+8ll
	 lb1ezkUAhTRpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] exit: move core of do_wait() into helper
Date: Wed, 21 Oct 2026 11:48:16 -0400
Message-ID: <20261021154744.363841-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102100-lifter-velcro-2a2c@gregkh>
References: <2026102100-lifter-velcro-2a2c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 06a101ca45b296fe951692620b0bc49abf90c368 ]

Rather than have a maze of gotos, put the actual logic in __do_wait()
and have do_wait() loop deal with waitqueue setup/teardown and whether
to call __do_wait() again.

No functional changes intended in this patch.

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 81933038f5e2 ("pid_namespace: make zap_pid_ns_processes() freezable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 51 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 413540df3e185..d4addbc7aff20 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1588,16 +1588,10 @@ static int do_wait_pid(struct wait_opts *wo)
 	return 0;
 }
 
-static long do_wait(struct wait_opts *wo)
+static long __do_wait(struct wait_opts *wo)
 {
-	int retval;
-
-	trace_sched_process_wait(wo->wo_pid);
+	long retval;
 
-	init_waitqueue_func_entry(&wo->child_wait, child_wait_callback);
-	wo->child_wait.private = current;
-	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
-repeat:
 	/*
 	 * If there is nothing that can match our criteria, just get out.
 	 * We will clear ->notask_error to zero if we see any child that
@@ -1609,24 +1603,23 @@ static long do_wait(struct wait_opts *wo)
 	   (!wo->wo_pid || !pid_has_task(wo->wo_pid, wo->wo_type)))
 		goto notask;
 
-	set_current_state(TASK_INTERRUPTIBLE);
 	read_lock(&tasklist_lock);
 
 	if (wo->wo_type == PIDTYPE_PID) {
 		retval = do_wait_pid(wo);
 		if (retval)
-			goto end;
+			return retval;
 	} else {
 		struct task_struct *tsk = current;
 
 		do {
 			retval = do_wait_thread(wo, tsk);
 			if (retval)
-				goto end;
+				return retval;
 
 			retval = ptrace_do_wait(wo, tsk);
 			if (retval)
-				goto end;
+				return retval;
 
 			if (wo->wo_flags & __WNOTHREAD)
 				break;
@@ -1636,14 +1629,32 @@ static long do_wait(struct wait_opts *wo)
 
 notask:
 	retval = wo->notask_error;
-	if (!retval && !(wo->wo_flags & WNOHANG)) {
-		retval = -ERESTARTSYS;
-		if (!signal_pending(current)) {
-			schedule();
-			goto repeat;
-		}
-	}
-end:
+	if (!retval && !(wo->wo_flags & WNOHANG))
+		return -ERESTARTSYS;
+
+	return retval;
+}
+
+static long do_wait(struct wait_opts *wo)
+{
+	int retval;
+
+	trace_sched_process_wait(wo->wo_pid);
+
+	init_waitqueue_func_entry(&wo->child_wait, child_wait_callback);
+	wo->child_wait.private = current;
+	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
+
+	do {
+		set_current_state(TASK_INTERRUPTIBLE);
+		retval = __do_wait(wo);
+		if (retval != -ERESTARTSYS)
+			break;
+		if (signal_pending(current))
+			break;
+		schedule();
+	} while (1);
+
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
 	return retval;
-- 
2.53.0

