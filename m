Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAF47F788
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987923; cv=none; b=hh/q7Kvx6dZbiYNIG/pBedrGtAaZOsPqNxHBgxBbe56OXer/hu9nu2twePPSez6HTI/zvVhpqHuV3mLOLnOmBUKZLmqiE9cswpJW04ISYYzHowsQU03kd8fn/9I8disQFiQw3IvF2L+5Xtzvw9ivO1r8fWWb1HPBYUQ6pFjdlU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987923; c=relaxed/simple;
	bh=EFJ6604hW74UuqT5tVbbUNbHZ3EqSUf7/sqYIDO3i1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k3HowSzM7CjUpY3BW71QJjB6xSyQTnpc/QNFAoKG7fUUB1AQUIWo/oIOwegdHggyShAgrlQod4bGGyusynMsPruORMV7ymQ2tIAE24MZPr91yxESpcjTkFC77tP6PTOpaqplpWmGC+nj6lkTZ4oVYCJDQe+PMWAPcf7Oc0mukHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=gM/fuZBf; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="gM/fuZBf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1788987921; x=1820523921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=crsgtAGheGiWYpZv580amg56trrQ5RCgRQ+HW0hql2Y=;
  b=gM/fuZBfqERlWElvidgF3h0+XwelULIz3qo2kkJdptiFcblK/S4itgrm
   bCKNs+2JYjbHbGH0EDss6dMBzmaQLrjWCnb64fSjrVK+fwTREYJROlqPB
   2ykQmA1WGVe5CfXKS/pbi8bGPE9UkdnTBSFVPSmOwSKjDx5xRTZRS39+M
   N/hthnb6wftcO6o37fLk5VJ6VI6o3sabmQ0S1r9D+RbqxBwC3vFvCms2o
   EUgouBoVVS8vm1GPEv1/90GNSojkttZ9ui0INx36Rzdf6bMiDYJpYmkh4
   7RIcOiKtWqtzypNPMaa0QxolNmaq2iq76vgQ0magPPK9207X1ptc3PwUF
   g==;
X-CSE-ConnectionGUID: RfUJDVZmQFa00wJc+ZxDyA==
X-CSE-MsgGUID: ++7LgOvHSHGjoZB2bHhWZw==
X-IronPort-AV: E=Sophos;i="6.25,271,1779148800"; 
   d="scan'208";a="28045605"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 21:05:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:20375]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.160:2525] with esmtp (Farcaster)
 id f78f225d-3282-48b9-bb34-6d3a5659bf77; Wed, 9 Sep 2026 21:05:16 +0000 (UTC)
X-Farcaster-Flow-ID: f78f225d-3282-48b9-bb34-6d3a5659bf77
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 9 Sep 2026 21:05:16 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 9 Sep 2026 21:05:16 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>, <doebel@amazon.de>
Subject: [PATCH 6.1.y] perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
Date: Wed, 9 Sep 2026 21:05:01 +0000
Message-ID: <20260909210503.199459-3-doebel@amazon.de>
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
[doebel: context adjustment for 6.1]
Signed-off-by: Bjoern Doebel <doebel@amazon.de>

---
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 3ffb41fa82b8..95add0d1c2bf 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -51,6 +51,7 @@
 #define COMM_LEN		20
 #define SYM_LEN			129
 #define MAX_PID			1024000
+#define PID_MAX_LIMIT		4194304 /* kernel limit on 64-bit */
 
 static const char *cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -448,17 +449,28 @@ static void add_sched_event_sleep(struct perf_sched *sched, struct task_desc *ta
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
@@ -469,9 +481,11 @@ static struct task_desc *register_pid(struct perf_sched *sched,
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
@@ -479,10 +493,12 @@ static struct task_desc *register_pid(struct perf_sched *sched,
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
@@ -846,6 +862,8 @@ replay_wakeup_event(struct perf_sched *sched,
 
 	waker = register_pid(sched, sample->tid, "<unknown>");
 	wakee = register_pid(sched, pid, comm);
+	if (waker == NULL || wakee == NULL)
+		return -1;
 
 	add_sched_event_wakeup(sched, waker, sample->time, wakee);
 	return 0;
@@ -888,6 +906,8 @@ static int replay_switch_event(struct perf_sched *sched,
 
 	prev = register_pid(sched, prev_pid, prev_comm);
 	next = register_pid(sched, next_pid, next_comm);
+	if (prev == NULL || next == NULL)
+		return -1;
 
 	sched->cpu_last_switched[cpu] = timestamp;
 
-- 
2.50.1

