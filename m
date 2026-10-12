Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1169842C50D;
	Mon, 12 Oct 2026 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787987; cv=none; b=cmyBoZNjcfqWse73idQvlaCEasN2SWyzfJ+A5xTEuZWohOnV+ULwzKXYyEqaG5069Q6E8+alEIIcONgSqnw16x1kTnatIwIghBey4S08YaB682PaHF/DnHsQnm4/cP7iZWx548vQxxapRZ7jtzVGZMrVzJMgGjMEQQnkr5cCR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787987; c=relaxed/simple;
	bh=a9M/IvBUm64P8kzbSiZrshQ/lLTkP1b15elsYZW507Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHa/3Q4QKvsyk2GfYcdRylM+5R89UQR2I25R1pOFZmxl2Ql7b13xmPzyt0SdKB+KSF4G3TIXmC9QgH27SnaHE09lo8t4iUrHVB0XjRjUT4sCQXV3oZXlnIqxTBMHLV28D62hC1SsV7LnucvGrlCxy4OsRQF5OkliFZNdZadYhH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S2FvHAhB; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S2FvHAhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dY
	zWyZB2DtnJo3u32Ab3+ix/KB4RIS6OXoVEh0znORg=; b=S2FvHAhBU6vrY7YIPk
	t+/464+y9PohuvJz1KMZ9jNfL6o0tMPDahHJ9OparcaWBEsue8fIBgrdZXCY+O9Y
	ha0tO98sI90XevnUC37AUHWGb64jcfSw3qwjrhS/O2+fn8DljmxanTh6DirOWexh
	6kOie8xglG+bPAXahWl0MjMUs=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBnh8Fmg8xqkSYeDw--.46906S2;
	Mon, 12 Oct 2026 14:51:19 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	sh_def@163.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Cover strict-core CPU selection shortcuts
Date: Mon, 12 Oct 2026 15:51:14 +0900
Message-ID: <20261012065114.3516902-3-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012065114.3516902-1-sh_def@163.com>
References: <20261012065114.3516902-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBnh8Fmg8xqkSYeDw--.46906S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3trW8Cw4rAFW3uF15Gr1UAwb_yoWDKrWDpa
	y0kayUtrWUtFW3Xw43tw4kArW3Zr9rZw43KryfGFySkFW2qFWktFZ5tF13ZFy3GrZ5uFy3
	AFsrKFW8CF4jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi5CzJUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwgfHJ2rMg2dcWgAA3h

Exercise scx_bpf_select_cpu_and() with a task whose candidate CPU is
individually idle while its SMT sibling is occupied by the test runner.
Verify that SCX_PICK_IDLE_CORE rejects the candidate, while the same
restricted path without the flag still selects it.

Also cover both WAKE_SYNC shortcuts with SCX_PICK_IDLE_CORE set, including
the waker-CPU path. The test uses a separate sleeping target task and
private allowed masks so strict-core checks do not depend on task-affinity
intersection or mutate the scheduler's configured mask.

Retain the generic user-space smoke test when no SMT pair is available, and
skip only the strict-core cases in that configuration.

Signed-off-by: Hui Su <sh_def@163.com>
---
 .../selftests/sched_ext/allowed_cpus.bpf.c    |  36 +-
 .../selftests/sched_ext/allowed_cpus.c        | 316 +++++++++++++++++-
 2 files changed, 342 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
index 9dd72d0da29b..4e0a798b696e 100644
--- a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
@@ -148,22 +148,54 @@ void BPF_STRUCT_OPS(allowed_cpus_exit, struct scx_exit_info *ei)
 
 struct task_cpu_arg {
 	pid_t pid;
+	int prev_cpu;
+	int allowed_cpu;
+	__u64 wake_flags;
+	__u64 flags;
+	__u32 check_idle;
 };
 
 SEC("syscall")
 int select_cpu_from_user(struct task_cpu_arg *input)
 {
+	const struct cpumask *idle;
 	struct task_struct *p;
+	struct bpf_cpumask *mask;
 	int cpu;
 
 	p = bpf_task_from_pid(input->pid);
 	if (!p)
 		return -EINVAL;
 
+	mask = bpf_cpumask_create();
+	if (!mask) {
+		bpf_task_release(p);
+		return -ENOMEM;
+	}
+
+	if (input->allowed_cpu < 0)
+		bpf_cpumask_setall(mask);
+	else
+		bpf_cpumask_set_cpu(input->allowed_cpu, mask);
+
 	bpf_rcu_read_lock();
-	cpu = scx_bpf_select_cpu_and(p, bpf_get_smp_processor_id(), 0, p->cpus_ptr, 0);
-	bpf_rcu_read_unlock();
+	if (input->check_idle) {
+		idle = scx_bpf_get_idle_cpumask();
+		if (!bpf_cpumask_test_cpu(input->prev_cpu, idle)) {
+			scx_bpf_put_idle_cpumask(idle);
+			bpf_rcu_read_unlock();
+			bpf_cpumask_release(mask);
+			bpf_task_release(p);
+			return -EAGAIN;
+		}
+		scx_bpf_put_idle_cpumask(idle);
+	}
 
+	cpu = scx_bpf_select_cpu_and(p, input->prev_cpu, input->wake_flags,
+				     cast_mask(mask), input->flags);
+
+	bpf_rcu_read_unlock();
+	bpf_cpumask_release(mask);
 	bpf_task_release(p);
 
 	return cpu;
diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c b/tools/testing/selftests/sched_ext/allowed_cpus.c
index 093f285ab4ba..8e67c7598c4d 100644
--- a/tools/testing/selftests/sched_ext/allowed_cpus.c
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
@@ -3,7 +3,11 @@
  * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
  */
 #include <bpf/bpf.h>
+#include <linux/kernel.h>
 #include <scx/common.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdlib.h>
 #include <sys/wait.h>
 #include <unistd.h>
 #include "allowed_cpus.bpf.skel.h"
@@ -23,17 +27,95 @@ static enum scx_test_status setup(void **ctx)
 	return SCX_TEST_PASS;
 }
 
-static int test_select_cpu_from_user(const struct allowed_cpus *skel)
+struct task_cpu_arg {
+	pid_t pid;
+	int prev_cpu;
+	int allowed_cpu;
+	uint64_t wake_flags;
+	uint64_t flags;
+	uint32_t check_idle;
+};
+
+static int find_smt_sibling(const char *list, int cpu,
+			    const cpu_set_t *affinity, int *sibling)
+{
+	const char *pos = list;
+
+	while (*pos) {
+		char *end;
+		long first = strtol(pos, &end, 10);
+		long last = first;
+		long candidate;
+
+		if (end == pos)
+			break;
+		pos = end;
+		if (*pos == '-') {
+			last = strtol(pos + 1, &end, 10);
+			if (end == pos + 1)
+				break;
+			pos = end;
+		}
+
+		for (candidate = first; candidate <= last; candidate++) {
+			if (candidate != cpu && candidate >= 0 &&
+			    candidate < CPU_SETSIZE &&
+			    CPU_ISSET(candidate, affinity)) {
+				*sibling = candidate;
+				return 0;
+			}
+		}
+
+		while (*pos && *pos != ',')
+			pos++;
+		if (*pos == ',')
+			pos++;
+	}
+
+	return -ENOENT;
+}
+
+static int find_smt_pair(const cpu_set_t *affinity, int *first, int *second)
+{
+	char path[128], list[128];
+	FILE *file;
+	int cpu;
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (!CPU_ISSET(cpu, affinity))
+			continue;
+
+		snprintf(path, sizeof(path),
+			 "/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list",
+			 cpu);
+		file = fopen(path, "r");
+		if (!file)
+			continue;
+		if (!fgets(list, sizeof(list), file)) {
+			fclose(file);
+			continue;
+		}
+		fclose(file);
+
+		if (!find_smt_sibling(list, cpu, affinity, second)) {
+			*first = cpu;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static int test_select_cpu_from_user(const struct allowed_cpus *skel,
+				     struct task_cpu_arg *input, int *result)
 {
 	int fd, ret;
-	__u64 args[1];
 
 	LIBBPF_OPTS(bpf_test_run_opts, attr,
-		.ctx_in = args,
-		.ctx_size_in = sizeof(args),
+		.ctx_in = input,
+		.ctx_size_in = sizeof(*input),
 	);
 
-	args[0] = getpid();
 	fd = bpf_program__fd(skel->progs.select_cpu_from_user);
 	if (fd < 0)
 		return fd;
@@ -42,22 +124,240 @@ static int test_select_cpu_from_user(const struct allowed_cpus *skel)
 	if (ret < 0)
 		return ret;
 
-	fprintf(stderr, "%s: CPU %d\n", __func__, attr.retval);
+	*result = (int)attr.retval;
+	fprintf(stderr, "%s: prev=%d allowed=%d wake=0x%llx flags=0x%llx result=%d\n",
+		__func__, input->prev_cpu, input->allowed_cpu,
+		(unsigned long long)input->wake_flags,
+		(unsigned long long)input->flags, *result);
 
 	return 0;
 }
 
+static pid_t start_target(const cpu_set_t *affinity)
+{
+	char ready;
+	int pipefd[2];
+	ssize_t n;
+	int err;
+	pid_t pid;
+
+	if (pipe(pipefd))
+		return -1;
+
+	pid = fork();
+	if (pid < 0) {
+		close(pipefd[0]);
+		close(pipefd[1]);
+		return -1;
+	}
+	if (!pid) {
+		close(pipefd[0]);
+		/* Let stop_target() terminate the sleeping child. */
+		(void)signal(SIGTERM, SIG_DFL);
+		if (sched_setaffinity(0, sizeof(*affinity), affinity) ||
+		    write(pipefd[1], "R", 1) != 1)
+			_exit(1);
+		close(pipefd[1]);
+		for (;;)
+			pause();
+	}
+
+	close(pipefd[1]);
+	n = read(pipefd[0], &ready, 1);
+	if (n != 1) {
+		err = n < 0 ? errno : EIO;
+		close(pipefd[0]);
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+		errno = err;
+		return -1;
+	}
+	close(pipefd[0]);
+
+	return pid;
+}
+
+static void stop_target(pid_t pid)
+{
+	if (pid > 0) {
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+	}
+}
+
+static int pin_current_cpu(int cpu)
+{
+	cpu_set_t affinity;
+
+	CPU_ZERO(&affinity);
+	CPU_SET(cpu, &affinity);
+	return sched_setaffinity(0, sizeof(affinity), &affinity);
+}
+
+static int expect_selection(const struct allowed_cpus *skel,
+			    const struct task_cpu_arg *input, int expected)
+{
+	struct task_cpu_arg attempt = *input;
+	int result, ret, i;
+
+	for (i = 0; i < 64; i++) {
+		ret = test_select_cpu_from_user(skel, &attempt, &result);
+		if (ret)
+			return ret;
+		ret = result;
+		if (ret == -EAGAIN || (expected >= 0 && ret == -EBUSY)) {
+			usleep(1000);
+			continue;
+		}
+		if (ret == expected)
+			return 0;
+		return ret ? ret : -EINVAL;
+	}
+
+	return -ETIMEDOUT;
+}
+
+struct selection_case {
+	struct task_cpu_arg input;
+	int expected;
+};
+
+static int run_selection_cases(const struct allowed_cpus *skel,
+			       const cpu_set_t *original, int second,
+			       const cpu_set_t *target_affinity,
+			       struct selection_case *cases, int nr_cases)
+{
+	pid_t pid = -1;
+	int ret = 0, i;
+
+	if (pin_current_cpu(second))
+		return -errno;
+
+	pid = start_target(target_affinity);
+	if (pid < 0) {
+		ret = -errno;
+		goto out;
+	}
+
+	for (i = 0; i < nr_cases; i++) {
+		cases[i].input.pid = pid;
+		ret = expect_selection(skel, &cases[i].input, cases[i].expected);
+		if (ret)
+			goto out;
+	}
+
+out:
+	stop_target(pid);
+	if (sched_setaffinity(0, sizeof(*original), original) && !ret)
+		ret = -errno;
+	return ret;
+}
+
+static int test_restricted_path(const struct allowed_cpus *skel,
+				const cpu_set_t *original,
+				int first, int second)
+{
+	cpu_set_t target_affinity;
+	struct selection_case cases[] = {
+		{
+			.input = {
+				.prev_cpu = first,
+				.allowed_cpu = first,
+				.flags = SCX_PICK_IDLE_CORE,
+				.check_idle = 1,
+			},
+			.expected = -EBUSY,
+		},
+		/* flags=0 must retain individual-idle behavior on an SMT system. */
+		{
+			.input = {
+				.prev_cpu = first,
+				.allowed_cpu = first,
+				.flags = 0,
+				.check_idle = 1,
+			},
+			.expected = first,
+		},
+	};
+
+	CPU_ZERO(&target_affinity);
+	CPU_SET(first, &target_affinity);
+
+	return run_selection_cases(skel, original, second, &target_affinity,
+				   cases, ARRAY_SIZE(cases));
+}
+
+static int test_wake_sync_path(const struct allowed_cpus *skel,
+			       const cpu_set_t *original,
+				int first, int second)
+{
+	cpu_set_t target_affinity;
+	struct selection_case cases[] = {
+		{
+			.input = {
+				.prev_cpu = first,
+				.allowed_cpu = first,
+				.wake_flags = 1ULL << 4, /* SCX_WAKE_SYNC */
+				.flags = SCX_PICK_IDLE_CORE,
+				.check_idle = 1,
+			},
+			.expected = -EBUSY,
+		},
+		/* A busy waker CPU exercises the second WAKE_SYNC shortcut. */
+		{
+			.input = {
+				.prev_cpu = first,
+				.allowed_cpu = second,
+				.wake_flags = 1ULL << 4, /* SCX_WAKE_SYNC */
+				.flags = SCX_PICK_IDLE_CORE,
+				.check_idle = 1,
+			},
+			.expected = -EBUSY,
+		},
+	};
+
+	CPU_ZERO(&target_affinity);
+	CPU_SET(first, &target_affinity);
+	CPU_SET(second, &target_affinity);
+
+	return run_selection_cases(skel, original, second, &target_affinity,
+				   cases, ARRAY_SIZE(cases));
+}
+
 static enum scx_test_status run(void *ctx)
 {
 	struct allowed_cpus *skel = ctx;
 	struct bpf_link *link;
+	struct task_cpu_arg generic = {
+		.pid = getpid(),
+		.prev_cpu = sched_getcpu(),
+		.allowed_cpu = -1,
+	};
+	cpu_set_t original;
+	int first, second, ret, result;
 
 	link = bpf_map__attach_struct_ops(skel->maps.allowed_cpus_ops);
 	SCX_FAIL_IF(!link, "Failed to attach scheduler");
 
-	/* Pick an idle CPU from user-space */
-	SCX_FAIL_IF(test_select_cpu_from_user(skel), "Failed to pick idle CPU");
+	SCX_FAIL_IF(sched_getaffinity(0, sizeof(original), &original),
+		    "Failed to read affinity");
+	ret = test_select_cpu_from_user(skel, &generic, &result);
+	SCX_FAIL_IF(ret, "Failed to run select_cpu test (%d)", ret);
+
+	if (find_smt_pair(&original, &first, &second)) {
+		fprintf(stderr, "SKIP: no SMT pair for strict-core cases\n");
+		goto out;
+	}
+
+	ret = test_restricted_path(skel, &original, first, second);
+	SCX_FAIL_IF(ret, "Failed to validate restricted strict-core selection (%d)",
+		    ret);
+
+	ret = test_wake_sync_path(skel, &original, first, second);
+	SCX_FAIL_IF(ret, "Failed to validate WAKE_SYNC strict-core selection (%d)",
+		    ret);
 
+out:
 	/* Just sleeping is fine, plenty of scheduling events happening */
 	sleep(1);
 
-- 
2.55.0

