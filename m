Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AD46C4B7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987924; cv=none; b=dw6+Xh/Iue8BqdMSO5cI9updQBY6ynalm0Ye2q4JhW03S0am3Wz24OLwZKoZqXt9YW5yMKmDlE4P0aCCQPGqyfKhluuUDVXsBDOG287vTDB+0AZEp9jot5dWwgJRC+izyFA6PCPFvOnr6cwyRx7MYSRzRTt/1ncv6UwkS97D8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987924; c=relaxed/simple;
	bh=An5sjr701+uTZSAKiGE4zuzp7oK+BAyHsWNQv6ZsanA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P85pIZIngzqr7pSDmwk3ZczA9xRyjQqcpoq7UD6jygFDMTZPS+I1t10QzO2/WcLyNunknj5A2C0os088SfvsbHbhAG9SUSudRhqqf6weL2xINIvrI1BGnmX8Krp34dTL2Wk0FV/i1zXduIwsoyV9EwSricCWMqz8iSFhsCFYHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=H80HpOxS; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="H80HpOxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1788987922; x=1820523922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eaRmQcL2It+j1Zjlr68r3jfT1FdckQXYGCXK4ZRcMrA=;
  b=H80HpOxSs4WvYGzFe4JB1BvGWBtsd71O8/rypAQDc7ljaN2yLoc+nD2O
   4/6LU5LaxNWfezE3DIsdGpzhEGi0JjcMnVOSFnJpTHYOEIC9ay/OLgBZs
   JQLu7Ps0zxByRK1UoDx7X78WOdse2oU/DhCTPDHtm1/wNnQJHICazaonR
   CtA2j6Uqupm0jLB5MJuj4f6QUsjhgfMtyNp3PAY6yPMMkYirMaA34UXoi
   myMwCijokXhRXITCFA66KxfeD/IpKKu3hWpRXkIJE/dval6t0FIrbWkPC
   bHIHGPgZ/ThxtS+dpVbZwjFo4kvSrOjbetDwEhIVtpNQIfkiv4wStaL+e
   w==;
X-CSE-ConnectionGUID: XiuaNPfZRg60h/NAkn5pXg==
X-CSE-MsgGUID: eGlxVDMCQ42eqEIpD7zwng==
X-IronPort-AV: E=Sophos;i="6.25,271,1779148800"; 
   d="scan'208";a="28052927"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 21:05:19 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:25980]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.113:2525] with esmtp (Farcaster)
 id 7e17ead4-b25a-44ea-8f49-d5ffea9e9cbe; Wed, 9 Sep 2026 21:05:15 +0000 (UTC)
X-Farcaster-Flow-ID: 7e17ead4-b25a-44ea-8f49-d5ffea9e9cbe
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 9 Sep 2026 21:05:15 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 9 Sep 2026 21:05:14 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>, <doebel@amazon.de>
Subject: [PATCH 5.10.y] perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
Date: Wed, 9 Sep 2026 21:04:59 +0000
Message-ID: <20260909210503.199459-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 5949d339f5ec98752d56dcd4e36f619a59d513a5 upstream.

register_pid() has several issues when processing untrusted perf.data:

1. Integer overflow: (pid + 1) * sizeof(struct task_desc *) can wrap
   to a small value on 32-bit systems when pid is large (e.g.
   0x40000000), causing realloc to return a tiny buffer followed by
   out-of-bounds writes in the initialization loop.

2. Heap buffer overflow: strcpy(task->comm, comm) copies the
   untrusted comm string into a fixed 20-byte COMM_LEN buffer with
   no length check.

3. BUG_ON on allocation failure: perf.data is untrusted input, so
   allocation failures should be handled gracefully rather than
   killing the process.

4. Realloc of sched->tasks assigned directly back, leaking the old
   pointer on failure; nr_tasks incremented before the realloc,
   leaving corrupted state on failure.

Cap pid at PID_MAX_LIMIT (4194304, matching the kernel's maximum
on 64-bit), replace strcpy with strlcpy, guard against NULL comm,
replace BUG_ON with NULL returns using safe realloc patterns, and
add NULL checks in callers that dereference the result.

Fixes: ec156764d424 ("perf sched: Import schedbench.c")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[doebel: context adjustment for 5.10]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>

---
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 4f8658f5f9de..c57df485cc91 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -50,6 +50,7 @@
 #define COMM_LEN		20
 #define SYM_LEN			129
 #define MAX_PID			1024000
+#define PID_MAX_LIMIT		4194304 /* kernel limit on 64-bit */
 
 static const char *cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -446,17 +447,28 @@ static void add_sched_event_sleep(struct perf_sched *sched, struct task_desc *ta
 static struct task_desc *register_pid(struct perf_sched *sched,
 				      unsigned long pid, const char *comm)
 {
-	struct task_desc *task;
+	struct task_desc *task, **tasks_p;
 	static int pid_max;
 
+	/* perf.data is untrusted — cap pid to prevent overflow in size calculations */
+	if (pid >= PID_MAX_LIMIT) {
+		pr_err("pid %lu exceeds limit %d, skipping\n", pid, PID_MAX_LIMIT);
+		return NULL;
+	}
+
 	if (sched->pid_to_task == NULL) {
 		if (sysctl__read_int("kernel/pid_max", &pid_max) < 0)
 			pid_max = MAX_PID;
-		BUG_ON((sched->pid_to_task = calloc(pid_max, sizeof(struct task_desc *))) == NULL);
+		sched->pid_to_task = calloc(pid_max, sizeof(struct task_desc *));
+		if (sched->pid_to_task == NULL)
+			return NULL;
 	}
 	if (pid >= (unsigned long)pid_max) {
-		BUG_ON((sched->pid_to_task = realloc(sched->pid_to_task, (pid + 1) *
-			sizeof(struct task_desc *))) == NULL);
+		void *p = realloc(sched->pid_to_task, (pid + 1) * sizeof(struct task_desc *));
+
+		if (p == NULL)
+			return NULL;
+		sched->pid_to_task = p;
 		while (pid >= (unsigned long)pid_max)
 			sched->pid_to_task[pid_max++] = NULL;
 	}
@@ -467,9 +479,11 @@ static struct task_desc *register_pid(struct perf_sched *sched,
 		return task;
 
 	task = zalloc(sizeof(*task));
+	if (task == NULL)
+		return NULL;
 	task->pid = pid;
-	task->nr = sched->nr_tasks;
-	strcpy(task->comm, comm);
+	if (comm)
+		strlcpy(task->comm, comm, sizeof(task->comm));
 	/*
 	 * every task starts in sleeping state - this gets ignored
 	 * if there's no wakeup pointing to this sleep state:
@@ -477,10 +491,12 @@ static struct task_desc *register_pid(struct perf_sched *sched,
 	add_sched_event_sleep(sched, task, 0, 0);
 
 	sched->pid_to_task[pid] = task;
-	sched->nr_tasks++;
-	sched->tasks = realloc(sched->tasks, sched->nr_tasks * sizeof(struct task_desc *));
-	BUG_ON(!sched->tasks);
-	sched->tasks[task->nr] = task;
+	tasks_p = realloc(sched->tasks, (sched->nr_tasks + 1) * sizeof(struct task_desc *));
+	if (!tasks_p)
+		return NULL;
+	sched->tasks = tasks_p;
+	sched->tasks[sched->nr_tasks] = task;
+	task->nr = sched->nr_tasks++;
 
 	if (verbose > 0)
 		printf("registered task #%ld, PID %ld (%s)\n", sched->nr_tasks, pid, comm);
@@ -824,6 +840,8 @@ replay_wakeup_event(struct perf_sched *sched,
 
 	waker = register_pid(sched, sample->tid, "<unknown>");
 	wakee = register_pid(sched, pid, comm);
+	if (waker == NULL || wakee == NULL)
+		return -1;
 
 	add_sched_event_wakeup(sched, waker, sample->time, wakee);
 	return 0;
@@ -866,6 +884,8 @@ static int replay_switch_event(struct perf_sched *sched,
 
 	prev = register_pid(sched, prev_pid, prev_comm);
 	next = register_pid(sched, next_pid, next_comm);
+	if (prev == NULL || next == NULL)
+		return -1;
 
 	sched->cpu_last_switched[cpu] = timestamp;
 
-- 
2.50.1

