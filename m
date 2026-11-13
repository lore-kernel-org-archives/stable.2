Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559789;
	b=Vl1Pp2hqANm2PH6pf1XhoJ/WSxqp25osUOto3hK8DUOG+h54XvsPKxszv3KzUvIskl/g
	 G/AjAEG3cYuWwUPGZlUZH2tqSBIIzErBXYz2Dkpsm06vtQHRQu9z8oXAXId5AhT3Ixi1h
	 on9jaWmbBjQzUAMC6qZx/kHd6+rDd+GbUDB+XH1R1vC16DT6Hrx++1e072CGmqOw5XDDm
	 gpQiLunpDI4i0BcO2aMnOyZNX9upbtw2Oz10e/DJiBzMpGqvkHgshZHpd6hUKkZmb1Rya
	 +kMoQpj804NYevyuAH4tDCJ2d0riaVhjT3g0FecnuLMAoVcaX83p3/acP1kc56gckpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uYCF/j3Berl6MM/JQ+PGmzcBwIXAJx/VQr0A1zxvBKY=;
	b=iH4Qq3EKFMw+ntA/worf2aEDutluk60gOqFkqHWa63KBwSBZ3grZqm9w0nrCbgvqxt8e
	 2P0GLFdpw9ZxGFbgUVZo9eJA677PDaUGcpP2NAoklsqB7RHlqnnpMowc4Toszrt0RfCOt
	 E+tI+tJs6v4wjYgTkHAWHDz4Ws5Ele6Z8Y27DBUAQNG8rniIpntDk7zG8W9O5HYSWSdIA
	 n6JfGbS91n5KLsgeC5XBvl3wD/dZl0ole1gKqVyMeq/R4c7BXxzNdisqflp0++UG0VsjE
	 6eOB4Jp27lKCKQ5rQJnTl6k09QKMOR956Uz5WcI5RYeO9mz+BrzekWc81yQw1QF1R1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZxHKOg9;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F1606D93E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 227F1606D93E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZxHKOg9
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3720addb068so1134980eec.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559788; x=1795164588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uYCF/j3Berl6MM/JQ+PGmzcBwIXAJx/VQr0A1zxvBKY=;
        b=qZxHKOg9sWmn6bGlJ4C9tduJ1fzHeH+/ZndhFC9p4jUzJb84HdEYGd0xEX/U5JKnkC
         2TTA8tkp193y+sOsHVxSdoTRrgMM+6jigdlR1n875Mnqd/e08frQUZjepA872XMqFTWP
         a38zf+Sprpr9xwIZweMvM9ua0QL9RStTZQWcGDXBXnxTcS9yVOsVM2E4+MUvrQJ672GR
         mmEOtPNeahrPUuYHew/YgXP6LVWfGVrHjJTWuh2Y7qlTbEO3Tdr29h+sUOwmqidwOHbt
         3qjQm6isMVD3u+cRlgNk4HyrSmxt4dCVfWQBOj3+dW32DMdks+LY2VytYZ3bu4MUELLS
         weiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559788; x=1795164588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYCF/j3Berl6MM/JQ+PGmzcBwIXAJx/VQr0A1zxvBKY=;
        b=QsLzOYsKe9XH+iV2WOKSLMWyYIxC4W8W4Qk4EMIgSuspBnZkb52LQ+jh3dBA3PN92i
         Fhxi3gv7D1e248klF4MxW/fLWIsdVuHcW95oUylqFF5cQSWP1zUboDxNOCO2pczTT9Nw
         +TudSGioNeADrhup98kBD9wREuNPc7SSyKl+jB1Zae7MluXUBJ7R5z/agqK1fIJW+Ve2
         VBeq0dvGJk2dm9DaAmVaax+tpRqzkugw1fhGU6ETFJJvOFzrhG7LWkQ6u6GVAsxSxarS
         Qnh+t2XrlNy2F95My4wVswjEsSYqPNaKzl5dhpGVrOFh5BlQpcBlu1SLftLWRI1IEz04
         JJBw==
X-Forwarded-Encrypted: i=1; AL+hErFXy37B+PB9b6pbS688YS5O/ourklithdzG5LxXkd7JVMuNHwB3vE4JK7oYqk08ZLmpXfiWjBM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ogu7k3SMYJVYif1zNSIpm8xxir+c1aL9zJt1IfRgoM4VknWsh
	BW9RnMl0LGqb+22kZ+TzmS1Dtk+NPXPmWbDBSoS//7xoqtbooiv4HchC
X-Gm-Gg: AYBFou1cDogDKnA+qDtxMi2jDTEAIlTQYpmuizNT04luQwz78DF3g975Sa7Gj9rLJ8N
	EEe6XKHGJWe9zzCkp63kp6WYVlBySZXJUvDCZOTfKZyDjt5tSNa4gosyc0glC8rwE3F0wO69xdJ
	z+dOspv26fH41L7lXXtrr6B2u6nk6wK9sHgPff8OC856bnXA06uTKqEjX9wLJeGw0S4ouxvbI7+
	SQ++v0OIzSmrJv6Dagj+aL73uXTMPFeiva5wHE4+n27zcE6ftXRAPs8znJCERSRPoQWHVDlws2I
	mCJ/n9MCAeIyMA/rm+gpdhgqs5r76sD3u9D9ACtvRd/nkK4hpKW1cX/KbQoHU/4Tntd9o1ajfnq
	yTyaIP9+Q746uvQsyHZMxwIxbnjJyy6srKUwyGRNgklOzHn+/FfWde1eD95r/cgClh0Hl1QFOW7
	bbqxrDUZQGX3gki/MEf9Pb8ljpoLUulzP0nqdEW/XsA/d7zT7pXPIbt2/uw0eY1FH5e+4YgRZF5
	RX4RUOmMfx8XNaC0Gq3rLTPG5wzh34jWOLK9FIXbiCWL4DF9zakT7eisCwE4KLKN3xAWGmuBfUA
	MOzLpgrREmruSyRK9BrmZSy/xxBEWKQ0XmIi8nunx9FgPZZ+6emN82MjiBm1G9sjfD/dksYVXx0
	W+Bhw5oG7XUelGljdTHla2rqcIdM9GatnBXbMsmEQgok=
X-Received: by 2002:a05:7300:fb8c:b0:376:a62b:ae09 with SMTP id 5a478bee46e88-3796676a1e8mr2333338eec.16.1794559787921;
        Fri, 13 Nov 2026 00:49:47 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:38a8:0:1866])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379558231eesm5387695eec.12.2026.11.13.00.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:49:47 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: mchehab@kernel.org
Cc: hverkuil@kernel.org,
	nicolas.dufresne@collabora.com,
	ezequiel@vanguardiasur.com.ar,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] media: v4l2-mem2mem: wait for job-finish scheduling before freeing a context
Date: Fri, 13 Nov 2026 16:49:40 +0800
Message-Id: <20261113084940.211907-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
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

When vicodec finishes a job, it calls v4l2_m2m_job_finish(). This clears
TRANS_RUNNING, but the function still uses the context afterwards to
schedule the next job. If another thread closes the file or stops
streaming at that point, v4l2_m2m_cancel_job() can see the job as no
longer running and return; the context may then be freed while the
scheduling code is still using it.

I reproduced this with vicodec by delaying the scheduling path after the
running flag was cleared. The unpatched kernel reported a KASAN
use-after-free in the scheduling tail.

Keep a count of scheduling tails that are still using each context.
Update the count under job_spinlock and make cancellation wait until both
the running job and all scheduling tails have finished. This keeps the
context alive until the last user of it is done.

The count also handles two jobs finishing close together: the first tail
cannot make the context look idle to a waiter while the second tail is
still registered. The wait condition is checked under the same lock that
protects the count, so the last tail does not wake a waiter before it has
finished with the context.

Fixes: cbd9463da1b12 ("media: v4l2-mem2mem: Avoid calling .device_run in v4l2_m2m_job_finish")
Cc: stable@vger.kernel.org
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
Changes since v1:
- Replace the completion with a count of active scheduling tails.
  The count is updated under job_spinlock and cancellation waits
  until it reaches zero.
- Simplify the comments to explain why the context must remain
  alive after TRANS_RUNNING is cleared.
- Reproduce overlapping tails with vicodec and targeted injection.
  A test-only release call entered cancellation with two tails
  active and returned after both had completed. This was not a
  userspace close test.

AI tools assisted with source review, test harness development, and
drafting the commit message and source comments. The author reviewed the
resulting code, comments and test results.

v1: https://lore.kernel.org/r/179378462223.70003.3811321311940400468@gmail.com/

 drivers/media/v4l2-core/v4l2-mem2mem.c | 44 ++++++++++++++++++++++++--
 include/media/v4l2-mem2mem.h           |  5 +++
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index a65cbb124cfe0..62c4ab542b58a 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -404,6 +404,21 @@ static void v4l2_m2m_device_run_work(struct work_struct *work)
 	v4l2_m2m_try_run(m2m_dev);
 }
 
+/* A context is idle only when its job and scheduling tails are done. */
+static bool v4l2_m2m_ctx_idle(struct v4l2_m2m_ctx *m2m_ctx)
+{
+	struct v4l2_m2m_dev *m2m_dev = m2m_ctx->m2m_dev;
+	unsigned long flags;
+	bool idle;
+
+	spin_lock_irqsave(&m2m_dev->job_spinlock, flags);
+	idle = !(m2m_ctx->job_flags & TRANS_RUNNING) &&
+	       !m2m_ctx->sched_tail_active;
+	spin_unlock_irqrestore(&m2m_dev->job_spinlock, flags);
+
+	return idle;
+}
+
 /**
  * v4l2_m2m_cancel_job() - cancel pending jobs for the context
  * @m2m_ctx: m2m context with jobs to be canceled
@@ -427,8 +442,6 @@ static void v4l2_m2m_cancel_job(struct v4l2_m2m_ctx *m2m_ctx)
 		if (m2m_dev->m2m_ops->job_abort)
 			m2m_dev->m2m_ops->job_abort(m2m_ctx->priv);
 		dprintk("m2m_ctx %p running, will wait to complete\n", m2m_ctx);
-		wait_event(m2m_ctx->finished,
-				!(m2m_ctx->job_flags & TRANS_RUNNING));
 	} else if (m2m_ctx->job_flags & TRANS_QUEUED) {
 		list_del(&m2m_ctx->queue);
 		m2m_ctx->job_flags &= ~(TRANS_QUEUED | TRANS_RUNNING);
@@ -439,6 +452,17 @@ static void v4l2_m2m_cancel_job(struct v4l2_m2m_ctx *m2m_ctx)
 		/* Do nothing, was not on queue/running */
 		spin_unlock_irqrestore(&m2m_dev->job_spinlock, flags);
 	}
+
+	/*
+	 * Wait for the running job, if any, and its scheduling tail.
+	 * TRANS_ABORT prevents new jobs from being queued.  A job that
+	 * was already running may still finish and register its tail;
+	 * the idle check covers both states.
+	 *
+	 * As with the original cancellation path, progress depends on
+	 * the active job eventually completing or being aborted.
+	 */
+	wait_event(m2m_ctx->finished, v4l2_m2m_ctx_idle(m2m_ctx));
 }
 
 /*
@@ -453,6 +477,8 @@ static void v4l2_m2m_schedule_next_job(struct v4l2_m2m_dev *m2m_dev,
 	 * allow more than one job on the job_queue per instance, each has
 	 * to be scheduled separately after the previous one finishes.
 	 */
+	unsigned long flags;
+
 	__v4l2_m2m_try_queue(m2m_dev, m2m_ctx);
 
 	/*
@@ -460,6 +486,15 @@ static void v4l2_m2m_schedule_next_job(struct v4l2_m2m_dev *m2m_dev,
 	 * but the job must be run in non-atomic context.
 	 */
 	schedule_work(&m2m_dev->job_work);
+
+	/*
+	 * The scheduling tail is done with this context.
+	 * Wake any thread waiting to close it.
+	 */
+	spin_lock_irqsave(&m2m_dev->job_spinlock, flags);
+	m2m_ctx->sched_tail_active--;
+	wake_up_all(&m2m_ctx->finished);
+	spin_unlock_irqrestore(&m2m_dev->job_spinlock, flags);
 }
 
 /*
@@ -475,6 +510,11 @@ static bool _v4l2_m2m_job_finish(struct v4l2_m2m_dev *m2m_dev,
 	}
 
 	list_del(&m2m_dev->curr_ctx->queue);
+	/*
+	 * The scheduling code still uses this context after TRANS_RUNNING
+	 * is cleared. Keep it alive until that code has finished.
+	 */
+	m2m_dev->curr_ctx->sched_tail_active++;
 	m2m_dev->curr_ctx->job_flags &= ~(TRANS_QUEUED | TRANS_RUNNING);
 	wake_up(&m2m_dev->curr_ctx->finished);
 	m2m_dev->curr_ctx = NULL;
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index 31de25d792b98..e9f390aff3664 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -97,6 +97,10 @@ struct v4l2_m2m_queue_ctx {
  * @job_flags: Job queue flags, used internally by v4l2-mem2mem.c:
  *		%TRANS_QUEUED, %TRANS_RUNNING and %TRANS_ABORT.
  * @finished: Wait queue used to signalize when a job queue finished.
+ * @sched_tail_active: Number of in-flight job-finish scheduling tails for
+ *		this context, protected by the device job spinlock.
+ *		v4l2_m2m_cancel_job() waits for it to drop to zero before the
+ *		context can be released.
  * @priv: Instance private data
  *
  * The memory to memory context is specific to a file handle, NOT to e.g.
@@ -125,6 +129,7 @@ struct v4l2_m2m_ctx {
 	struct list_head		queue;
 	unsigned long			job_flags;
 	wait_queue_head_t		finished;
+	unsigned int			sched_tail_active;
 
 	void				*priv;
 };
-- 
2.34.1

