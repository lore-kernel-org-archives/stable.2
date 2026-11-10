Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327811;
	b=OqSrCcbUpF5rgM5CMV8f8C2i3+hhbIVM3anFFk3wupwDzBiWfZjaLIIfbCu5FoVRg7jc
	 CDDscjLCCr7Wr7UKOBiv/9el0TUeeovdPOiAFlFCi55m5hfDwbIBc8XZkwAt0fD5I0yrh
	 elfixexwgQm0ZZCQMFW5UYws47ByY86lww6/6xcsAPW0+SAKFIMUzbAM/QIbyBBjRQKLH
	 t0rqAPh71aoes+QoNzs73+Fn7EyKqGiVwYTj7wFrWjvgjCo0BaYY/ycKTZ6YhCOgP0h1+
	 E2kGqPIAXkfIYF+vR82AzVw8SbPwx1gj9rkkh+/vFtcKGDEsZQJj1BwH2R84iQ2+scQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=TTgbH6RQNfqmOfI1QxheaONIegAGBbKbjZgXnlMazBQ=;
	b=ECrFW1KkzDNoJkgIxLC7m+fEJBVnDweSiojM7YNaCJOxHyBD4CDKJNlVJhNoXbw+t9m9
	 M2CeKixa0dqWArBwHgm6Ulw7u8uJ+QY2kUBBEupf2zaJ3DOLfb28pR20ktKRJ7WyFgsZr
	 7UDk+zQxUS7X9NOO7N80FliMW+MeoDp3wgF/PuKX1njmm8R4M6n0O92r+qaLO/0+RoVXX
	 y0KO87Pbk22VkEo3MQ+zWjhsulpm4T5laPFwGMKHU8ICVTCJITHf10YC0e6vpU5kKHBBA
	 zK+8wz1XafA0YAM4C9ulzEJx5sj/TVlg3WJplMLSIe0pNYZ1XYqZYgCxqnQQ+kUzntg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l5xXoLFv;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3D606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FA3D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--michalblk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l5xXoLFv
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a615ab0c06so2161025a12.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794327809; x=1794932609; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TTgbH6RQNfqmOfI1QxheaONIegAGBbKbjZgXnlMazBQ=;
        b=l5xXoLFvQyaZKSyitvfZI+FFsRWIUkQW67RiieJhQcE80Cv23jUJxLhO2T+DwFMP33
         d9vQatgms/dpLVox+QgQd3Hi7PsUVyW0GcJeLFw66RLXmttaCBuA7B6uL12pfSqfL/cH
         c6qvfI+ln23oUCbUVURPN4ENwfqtLyXsBl27KHn8BozSXhLuoEtGHdlbOt2jHI1+Mn3X
         Kj12AV8IZ3on8t+Z4i16zyIlLlX0Z+Z0CJxtObdPbY7wVvzvl2FV/etCPahQvYzyRED7
         bq9eNS19v2BAuuPOyyInAVmWXtd3VGxRXZ1xYID71PfH+1UgUIvPr1Rnx4HZGrKYVx3/
         3Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327809; x=1794932609;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TTgbH6RQNfqmOfI1QxheaONIegAGBbKbjZgXnlMazBQ=;
        b=1EZQ/a/Vizz7nkINjY9vwFptMEkjzOaBIzzxwlzonPEmZjzsyDduhmN0FWgGZJEQ/T
         zFeK7DOGV989goHlni9jGDFkSv9EvJHgatWp37hEhDsQj/O3sNrxF7WzkKklZ5wv/oDu
         q18i+Tvb6hwLk+tnuiJMOtlwjchEh9jyqyM8mF+j2E2FTT+51I2sI0DhWO0KeAN6EqL8
         f/tJ/+Q1VGMzOBN537sVeFypqt1MvLy7jwnGyZ0y3HA7bz2GyD46Y03ZcXtasQgdHQ+N
         vbiiSxODVNPe3Ss+jN5pEJpnI5oOjTTPDnA2bxgbXxEdmgU4reoUAWc3Ea2HS8vND/5s
         nEmA==
X-Gm-Message-State: APuU4Z910y/13QrNsZhT9SY2zJYSujzJPH9FJWIDoTZDKloFugJS7OmK
	QQNFrT7M0SL2e6yeC363uBRVE/oVw3EXacDU7m8fvMdPP4smmXJIHTHAQxjXKSdlktp9W72W9aF
	/vpaptpUNRH2ZljV8AkKHiGtybdtjQ5JqPFg0h0TgTrzOlQg2VIHsYjrPtCwbztcXbmaqFIMrAW
	qFOyHsh6PDbSDh8INwBm2huc2PruOuoT8jP90qovyCEpp3IHSp03nF
X-Received: from ejbsu10.prod.google.com ([2002:a17:907:3ca:b0:c3f:c35a:7704])
 (user=michalblk job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f03:b0:c50:475d:9804 with SMTP id a640c23a62f3a-c5049583bf0mr292107366b.13.1794327808825;
 Tue, 10 Nov 2026 08:23:28 -0800 (PST)
Date: Tue, 10 Nov 2026 16:23:21 +0000
In-Reply-To: <20261107052412-failed-6.12-993e8fbfecbb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107052412-failed-6.12-993e8fbfecbb@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110162321.2117930-1-michalblk@google.com>
Subject: [PATCH 6.12.y] sched_ext: Reset runnable_at when a task leaves its scheduler
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
[ michalblk: applied to kernel/sched/ext.c, where the function is
  scx_ops_disable_task() and has no @sch; adjusted the comments and
  context accordingly ]
Signed-off-by: Michal Blaszczyk <michalblk@google.com>
---
 kernel/sched/ext.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ded7a0dd2e533..d64803ab0ca23 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2173,7 +2173,11 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 {
 	unsigned long opss;
 
-	/* dequeue is always temporary, don't reset runnable_at */
+	/*
+	 * Don't reset runnable_at. If @p is waiting, the wait continues across
+	 * temporary dequeues, e.g. for a migration or an attribute change.
+	 * scx_ops_disable_task() ends it if @p leaves its scheduler.
+	 */
 	clr_task_runnable(p, false);
 
 	/* acquire ensures that we see the preceding updates on QUEUED */
@@ -3794,6 +3798,14 @@ static void scx_ops_disable_task(struct task_struct *p)
 	if (SCX_HAS_OP(disable))
 		SCX_CALL_OP_TASK(SCX_KF_REST, disable, p);
 	scx_set_task_state(p, SCX_TASK_READY);
+
+	/*
+	 * If @p is runnable but not running, its wait started at runnable_at,
+	 * which ops_dequeue() didn't reset. Leaving the BPF scheduler ends the
+	 * wait. Reset runnable_at the next time @p is enqueued on SCX, so that
+	 * the watchdog doesn't count the time @p spends elsewhere.
+	 */
+	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 }
 
 static void scx_ops_exit_task(struct task_struct *p)
-- 
2.56.0.506.g506a7eabc5-goog

