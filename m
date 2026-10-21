Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596577;
	b=psHf2qfsABJESqmwsKkGI7oVKHyYxbsJ54FXPj8CrAFan8PMG2HjHUEobHpNSbTWp2V7
	 GsKYKAoHSaChgt/OHo9ugu2v/Raj1fdE2u3FV/n16whM1UhE40rcOzfOWaXqzrPUCdopd
	 00CYTAtvznIgHdvqmeVL7f+fsU7rZDHeHpabzAqgV93Rrd6YcIX9eOyzgz2mmOcmB7DYJ
	 03ryYgvWcIotfiA8ak3dbIfjL9Q6D4/YbMVDTcDhhRSA27uG2af8GnMM7Mmbm7j9fz1Wu
	 xfHlUuREmIFhBzUMxN+RtKWc55PdFY+8hayTehZz/kReEajqo8rSQtmgZaJtpIFoK0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596577;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+X3qCqixGgSGKfy3q1JWj3vUX17xbPi4tZjtXhGE22k=;
	b=M3Vg/80lsaAIVPDRkuGiMY2O5Uf5q728vrELIOKStXWI17OuD+ROU0xie2lMjE5CEgQk
	 A48vonAJZTie3vMp3DOiXLDfcUEddYH4tVtrOiKTEX7Lp3enrL85Qb/N1DlN4VbNJtC5O
	 8mA1RZ5fwYeMnr9rtFwahf//lTbBxUaGOKpbDTEC9B9D+5yy/GWLTge82Tahn/fjIid0O
	 85aEu2RSofgTuXiIM+oX5zdO8bjH8QEFxG7x2C/X09yo+IPZcg224OHygaJAesyT5rRwG
	 KRb4gw4QmwyI4yLzsWMuur95bT6MZgLaB0hjk8c+uDgnQWBg3h+5kXE0p7bWks2Ftww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iy6fUE6E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695C606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iy6fUE6E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D351F000C2;
	Wed, 21 Oct 2026 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596576;
	bh=+X3qCqixGgSGKfy3q1JWj3vUX17xbPi4tZjtXhGE22k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iy6fUE6EVLykfW2/Uf7tVU4uvk9Z+j+Vwn/4ny4dC/1XiZ6S0Azrfh2nw72lKPwOl
	 qxSSDDwijgtXFBTV54I6ao9OQnTkn3w63ZaMYnYJAH8UhoyEefFjd/fBFJKUp5FQ9v
	 0oWhJtEadrVlI6oOx/ORkoRAg7B5bn/4UC64gzlPMttO59AJv/iu3I3Kt7Kz5VMxZt
	 Io6eHPx1ZT5P24vUFr2jjOUw6w8sBparlOQMjrZihgtoW0gk7etOUxV7YfIJu06bsP
	 0VzuxbuMqa1OGeuHxhrWLHM4hWuTh41zD713r0TLGqBO0uyZ4H/N88K462hEC8m/QI
	 02+39e9llNUYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] exit: move core of do_wait() into helper
Date: Wed, 21 Oct 2026 11:29:34 -0400
Message-ID: <20261021152921.291520-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102159-hunchback-poppy-cf49@gregkh>
References: <2026102159-hunchback-poppy-cf49@gregkh>
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
index 55a8aa868298f..07a17f0916107 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1590,16 +1590,10 @@ static int do_wait_pid(struct wait_opts *wo)
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
@@ -1611,24 +1605,23 @@ static long do_wait(struct wait_opts *wo)
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
@@ -1638,14 +1631,32 @@ static long do_wait(struct wait_opts *wo)
 
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

