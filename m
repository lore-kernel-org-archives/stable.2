Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328191;
	b=rfy3kEs/1W++ktX5uKfri/pYsu2R+gDzo5UkLE/xmr9BzZ81D1USc8D2a+wbi5vO+rZ2
	 6gX5VOOMyYxMx3Msa2G3UzOGTVqpBAFErEhY1mXnSLzVeG5HZlsvQDXnqWO6JRuifB2R1
	 hSN+RXxT1+WtPUo5qZYERyONaCldkpDXPTXftvOvpgKkoRJgJKguFNjG/H55RyiY9WZqA
	 reaVnxEGJgLxbnNNbNICuGrIanfkVBDOppg57wzeOLmrjUn56St87rJkou0jo09b4zcQ/
	 VcD+3ddkGUgGLcm/FjWzqA8HEx76ldHcw2/ltLpVgjgAJfpkoGWIsJeNeiTo648F87g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ghno+hRQROva7hSCWNdu9qZqAtG4kns6STUVUD10r1E=;
	b=QD/bTXaUP49+ghYRKpBfsEv2NNFRDOp47ZQdoInIFdKoY5nsfgZE9ney6HqQaUUVQW7s
	 /Gr1IfEYtc3O12xd42mtaVLN/O4dau0NgV3sazvCg95GnSkTk2XzZ2CJx0MHN3+JYvEB5
	 WlbtX99fUdgJ33O+7gFZmeRzGwtty8Mxp/sU+fYAyz/qyknUc5POq2RHzScXXSd7fVMgd
	 U3eNxqvDMHbYrrpQ9P7n5yHSrZYLDLIc6BrNXhJK3MXBNj5IQr4kpo9bsbXcyAPzEcXJp
	 dltm5DJfBgm+Bj5CUkQXjUQjLp4s+yOcEp+dQmbmerP+sF4q9DDjmEe26w1HQIo3Lng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CafID1kN;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B2606C6F8
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 346B2606C6F8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CafID1kN
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b56221d367so2132011a12.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794328189; x=1794932989; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghno+hRQROva7hSCWNdu9qZqAtG4kns6STUVUD10r1E=;
        b=CafID1kNa5rZv0DUMSqdxQBGAE+CQGaguFTQCJHFAqC68QM3fibXTw0pAIrf4nkGM+
         f3YNO1QNEEPJFiHhYKOpKOVmTzFQng6or9wdo43jBfzK9pmdKr2EUtegJtQHOOCFiD+X
         tpPlnd3xBu2/qYgOFdBpQCC3XecRC8nNulC4NjCvQEtJjREVnfskTaySOBFDzxQXA6sA
         PbHu0SCUyhJgIw3kHqf59HNoiN+9/txl1QR2stjyaFEe1/fEB8d/9MwhYKeeWHp5mzDM
         eJXzayu9j89T36nPNJh8WFWaEBKKl/hZC0OETeXFlD8oBtKd+tWhfbYJGdH+KcSklvuS
         6ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328189; x=1794932989;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghno+hRQROva7hSCWNdu9qZqAtG4kns6STUVUD10r1E=;
        b=QxvsfP8iqkL9mGcaxHgnQ3ZkRfKNuU7+cStJdLnzmbR3QW4QVPHj9ibpvXTWF8OR1Y
         1OnY9BNArEYhkH+sRUg3sS+ucMEoB0rIJKT/NmqfkBtgJ2Zcnj+t9YxzQqS/NhUL/drN
         wX4IgxmLmUQmKsDzsa8ZXmdBpsEZOu86Ad2G1TrIS6OF8xYt0V6y3diIE2IwhxuYjj4s
         wfyO30EAKmv1cabJLQCyrUycPnm30lj+FpgTq/8dzaZVOr0G54ekNZaV2YYglamMHh9h
         omtPqHIqIQaiA3SzxQe/0tMN9Nz4ig5YRbvudc+BpGqLRY0y/QYdLgzARXXZxMSry0YF
         NEbg==
X-Gm-Message-State: APuU4Z/wPS+r/zBypNtAaiWLiITIYDeYTz3rbbW+l5lM3ZPO+XdsvuOV
	aDQphrMcvPeEcXfU6K7oXcDtr3hgTHo1AOkaaNfiFvE1EkYwC2YR1eicdWxun2hvvlYtVFIgHYu
	a6QjmPNeNlp/2rYM1jd/ITX7dPCOQjsTtz9tHQrUjkQPNZjjjgYu/XF/mDz8CyTfKeVqSkA+ZqR
	hf5SUBBh3MwWBIcTj3e2VzEyyK7DpPBgqosS2SKeDvGLV6El+okIrm
X-Received: from edvj8.prod.google.com ([2002:aa7:de88:0:b0:6b5:80a6:e6cc])
 (user=michalblk job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:15cc:b0:6ab:7700:9371 with SMTP id 4fb4d7f45d1cf-6b756aead38mr1888199a12.25.1794328189201;
 Tue, 10 Nov 2026 08:29:49 -0800 (PST)
Date: Tue, 10 Nov 2026 16:29:46 +0000
In-Reply-To: <20261107051240-failed-6.18-993e8fbfecbb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107051240-failed-6.18-993e8fbfecbb@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110162946.2141451-1-michalblk@google.com>
Subject: [PATCH 6.18.y] sched_ext: Reset runnable_at when a task leaves its scheduler
From: Michal Blaszczyk <michalblk@google.com>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	Michal Blaszczyk <michalblk@google.com>
Content-Type: text/plain; charset="UTF-8"

The watchdog measures how long a task has been waiting from
p->scx.runnable_at, which set_task_runnable() resets when the task becomes
runnable after it last ran. ops_dequeue() never asks for a reset, as the
dequeue of a waiting task is temporary, e.g. for a migration or an
attribute change.

Leaving the scheduler isn't temporary. A task which is switched out of
SCHED_EXT while it's waiting keeps its runnable_at. When it's switched back
and becomes runnable, its wait appears to have started before it left, and
the time it spent in another class counts towards the timeout. If the
watchdog checks before the task runs, it aborts the scheduler:

  sched_ext: class_switch_stall: runner[418] failed to run for 3.010s

Here, the task waited for a few milliseconds before it was switched to
SCHED_OTHER, slept outside of SCHED_EXT for three seconds, and was charged
for all of it as soon as it woke up on SCHED_EXT again.

The same happens when scx_sub_enable_workfn() hands a waiting task over to
a new sub-scheduler, which can then be blamed for time the task waited
under the parent. scx_rehome_task() isn't affected, as it moves the task
through SCX_TASK_INIT, which resets runnable_at. The stale runnable_at also
skews the default core-sched ordering in scx_prio_less().

Reset runnable_at in scx_disable_task(), when the task leaves the control
of its scheduler.

Fixes: 8a010b81b3a5 ("sched_ext: Implement runnable task stall watchdog")
Cc: stable@vger.kernel.org # v6.12+
Assisted-by: LLM
Signed-off-by: Michal Blaszczyk <michalblk@google.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 993e8fbfecbbf284b9644c6f10741b28fb914094)
[ michalblk: applied to kernel/sched/ext.c; adjusted context ]
Signed-off-by: Michal Blaszczyk <michalblk@google.com>
---
 kernel/sched/ext.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 78f15ddc0aa5a..3117d1ef869c5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1438,7 +1438,11 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	struct scx_sched *sch = scx_root;
 	unsigned long opss;
 
-	/* dequeue is always temporary, don't reset runnable_at */
+	/*
+	 * Don't reset runnable_at. If @p is waiting, the wait continues across
+	 * temporary dequeues, e.g. for a migration or an attribute change.
+	 * scx_disable_task() ends it if @p leaves its scheduler.
+	 */
 	clr_task_runnable(p, false);
 
 	/* acquire ensures that we see the preceding updates on QUEUED */
@@ -2959,6 +2963,14 @@ static void scx_disable_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, disable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
+
+	/*
+	 * If @p is runnable but not running, its wait started at runnable_at,
+	 * which ops_dequeue() didn't reset. Leaving @sch ends the wait. Reset
+	 * runnable_at the next time @p is enqueued on SCX, so that the watchdog
+	 * doesn't count the time @p spends elsewhere.
+	 */
+	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 }
 
 static void scx_exit_task(struct task_struct *p)
-- 
2.56.0.506.g506a7eabc5-goog

