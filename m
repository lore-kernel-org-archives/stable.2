Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013274A0EF5;
	Thu,  1 Oct 2026 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873638; cv=none; b=F1IUFKAnP3OxlNs4EAMjxsTqdIFmKFTbULyDGxiSLKqio8I/ymCPD7PZe/Upk7KxEyjCtUkT0xga4StCROq43EFMc4rc30jG269IDuQ0VJ5lq7D89sIre5CLC8txBk/ZQx/tKR0jWsc+ADV0F9W2ck/ZXcDPHmfJ894Z2ojrZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873638; c=relaxed/simple;
	bh=cr0JgBaOGxeUmAV0tHlURp58ssiAgVzvnQYRPZLSJdo=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=DJ2zXXNNCB+0BeRY7nTYfBI+B5YOCmBUDG3eVrOrItY5Iae10cwZIg+hfQKj1aTWQrlRtfBxLcdlGMXs7X+YP7DR5rf3qoZ5V/ZWSTt89bXaxzvk70ZSjgXsvZMsqVvnKnUvCcA7tIiUK8abz+bRSS7F6E2fuo16o5glHXsP1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ndmShuIe; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=FG+EBxqY; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ndmShuIe";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="FG+EBxqY"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790873628; bh=v9VYgedc7ex7x73J5M0VpTW
	DDlACxkXFTUO7YiK3ajA=; b=ndmShuIeVrwejOG1JzT+1rvSzEPcrdILiTs4XpF2UUjrAf8EF+
	NJeUlLOLbzsphpRBWIdQlVfiVe2NRY24dXR/1TH7N1tIPjXhYK5hrt69N65ZVZO4KzbtpXnt1VW
	b/en18xFHJiYDjGbb+ROiVtm3OtosuJfkqNEUDihixLmwx8Ddr8zO4DKE+qlGtb5eUmXcylwN+f
	aD7HdZrNnmOcn4+BYeHg1RXvp6SbsdMsmEy8jP5EGh3NJTV1AygRRGHL1o/EEyiORJ4ECzgID0s
	xLiwmx0c1CDp2KFUb2EFtkdaNwsgBXGMlNVYRBQ9DpSQ3zaJI9FUc8o2iOBLQGF5nEA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790873628; bh=v9VYgedc7ex7x73J5M0VpTW
	DDlACxkXFTUO7YiK3ajA=; b=FG+EBxqYRCr89xS5YdTOxtt4GfocqDlGPWx5DvLMq37IKctK+l
	YBCmqkLPkUr179OIvhldBwsRbIZWLVhP9zCQ==;
Date: Thu, 01 Oct 2026 17:53:49 +0100
From: Bradley Morgan <brads@mainlining.org>
To: vaknins33@gmail.com
CC: brauner@kernel.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, oleg@redhat.com, ptikhomirov@virtuozzo.com,
 rafael@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pid_namespace: make zap_pid_ns_processes() freezable
In-Reply-To: <20261001121254.883973-1-vaknins33@gmail.com>
Message-ID: <795B0CD0-C64F-48D5-963C-544B83539A07@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 1 October 2026 13:12:54 BST, Aviv Vaknin <vaknins33@gmail.com> wrote:
>When the init of a pid namespace exits, zap_pid_ns_processes() waits
>until every other pid in the namespace has been freed. That wait has no
>upper bound: a tracer outside the namespace that doesn't reap its traced
>zombies keeps their pids allocated (see the comment above the final
>loop). While a task waits there, every suspend attempt fails:
>
>  Freezing user space processes failed after 20.006 seconds (2 tasks refusing to freeze, wq_busy=0):
>  task:pidns-freeze-re state:S stack:14200 pid:104   tgid:104   ppid:99     task_flags:0x40014c flags:0x00080000
>  task:pidns-freeze-re state:S stack:14160 pid:109   tgid:105   ppid:104    task_flags:0x40044c flags:0x00080802
>
>and keeps failing until the tracer reaps or exits, because neither wait
>can be frozen:
>
>- The first loop sleeps in kernel_wait4(). The freezer's fake signal
>  ends that wait with -ERESTARTSYS, then the loop clears TIF_SIGPENDING
>  and waits again without ever calling try_to_freeze().
>
>- The final loop sleeps in TASK_INTERRUPTIBLE without TASK_FREEZABLE.
>  Worse, nothing clears the TIF_SIGPENDING that the fake signal set, so
>  from the first suspend attempt on schedule() returns at once and the
>  task spins at 100% CPU for as long as the wait lasts.
>
>Neither loop has ever been freezable. The spin came with
>commit b9a985db9896 ("pid_ns: Sleep in TASK_INTERRUPTIBLE in
>zap_pid_ns_processes"),
>which replaced TASK_UNINTERRUPTIBLE to keep such long waits from
>triggering the hung task detector.
>
>This happens in practice with Chromium-based browsers, whose renderers
>are pid namespace inits. If a renderer crashes while the browser shuts
>down, crashpad (outside the namespace) ptrace-attaches its threads to
>dump it. When the renderer is SIGKILLed mid-dump, crashpad keeps the
>dead threads as unreaped traced zombies, and it can then block in
>waitpid() on the renderer's last thread, which is itself waiting in
>zap_pid_ns_processes() for those zombies. One such renderer blocks
>suspend system-wide until crashpad is killed or the machine reboots.
>The userspace side is being reported to Chromium separately.
>
>Call try_to_freeze() after kernel_wait4() in the first loop, and sleep
>in TASK_IDLE | TASK_FREEZABLE in the final loop, as coredump_task_exit()
>already does on the same exit path. Like TASK_INTERRUPTIBLE, TASK_IDLE
>keeps the hung task detector quiet and adds no load, but it is not
>woken by signals, so a pending signal can no longer turn the wait into
>a busy loop. TASK_FREEZABLE lets the freezer freeze the task in place;
>a free_pid() wakeup that arrives while it is frozen is kept in
>->saved_state and acted on at thaw.
>
>Tested on v7.3-rc5 in QEMU with PROVE_LOCKING, DEBUG_ATOMIC_SLEEP and
>DETECT_HUNG_TASK (10 s timeout), using a reproducer in which a tracer
>PTRACE_SEIZEs two threads of a nested pid namespace init and doesn't
>reap them (it works unprivileged too, from a user namespace), and using
>the real browser and crashpad trigger:
>
>- before: freezing fails after 20 s, and afterwards the final loop
>  spins (500 ticks of system time per 5 s).
>- after: freezing completes in 0.001 s, the waiting task sits in state
>  I without using CPU, no hung task or lockdep report appears over
>  30-45 s, and the task exits as soon as the zombies are reaped.
>
>Fixes: 3eb07c8c8adb ("pid namespaces: destroy pid namespace on init's death")
>Fixes: b9a985db9896 ("pid_ns: Sleep in TASK_INTERRUPTIBLE in zap_pid_ns_processes")
>Cc: stable@vger.kernel.org # 6.1+
>Assisted-by: Claude:claude-opus-5-5
>Signed-off-by: Aviv Vaknin <vaknins33@gmail.com>
>---
>Based on vfs kernel-7.4.signal (also in next-20260930), on top of
>5c0985dd3c32 ("pid_namespace: prevent TIF_NOTIFY_SIGNAL from
>interrupting the reaper"). That commit keeps TIF_NOTIFY_SIGNAL from
>waking the reaper; this one is about the freezer, whose fake signal
>sets TIF_SIGPENDING, which the guard doesn't cover. Retested on this
>base with the reproducer below (same debug config): freezing completes
>in 0.000 s, no spin, no warnings. A version for v7.3-rc5 is available
>if wanted.
>
>Reproducer (run as root in a VM, then follow its instructions):
>
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * pidns-freeze-repro: a task waiting in zap_pid_ns_processes() blocks suspend.
>   *
>   *   main (tracer, root pid ns)
>   *    `- A: pid 1 of pid ns A, single-threaded
>   *       `- B: pid 1 of nested pid ns B, multithreaded
>   *
>   * main PTRACE_SEIZEs non-leader threads of B, then A exits.  zap(A) kills B;
>   * the seized threads stay traced zombies until main reaps them, keeping ns B's
>   * pids allocated.  B's last thread waits in zap's final loop, A in zap's first
>   * loop (kernel_wait4() for B).  While "stuck" is shown, run as root:
>   *   echo freezer > /sys/power/pm_test; echo mem > /sys/power/state
>   * Unpatched, freezing fails after 20 s ("2 tasks refusing to freeze") and B's
>   * thread then busy-loops in zap.  At the end main reaps, ending the hang.
>   *
>   * Build: gcc -O2 -Wall -pthread -o pidns-freeze-repro pidns-freeze-repro.c
>   * Usage: ./pidns-freeze-repro [hold_seconds]  (root, in a VM; default: Enter)
>   * With -DUSERNS, A also gets a new user ns, so no privilege is needed.
>   */
>  #define _GNU_SOURCE
>  #include <dirent.h>
>  #include <pthread.h>
>  #include <sched.h>
>  #include <signal.h>
>  #include <stdarg.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/ptrace.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
>
>  #ifdef USERNS
>  #define NS_FLAGS (CLONE_NEWUSER | CLONE_NEWPID)
>  #else
>  #define NS_FLAGS CLONE_NEWPID
>  #endif
>  #define NTHREADS 4	/* B's threads besides its leader */
>  #define NSEIZE   2	/* how many of them main seizes */
>
>  static int ready[2], go[2];	/* B -> main: threads are up; main -> A: exit */
>  static char stack_a[256 << 10], stack_b[256 << 10];
>
>  static void *idle_thread(void *arg) { for (;;) pause(); return arg; }
>
>  static int init_b(void *arg)		/* pid 1 of ns B */
>  {
>  	pthread_t t;
>
>  	for (int i = 0; i < NTHREADS; i++)
>  		pthread_create(&t, NULL, idle_thread, arg);
>  	if (write(ready[1], "r", 1) != 1)
>  		_exit(1);
>  	for (;;) pause();
>  }
>
>  static int init_a(void *arg)		/* pid 1 of ns A */
>  {
>  	close(go[1]);			/* only main may hold the write end */
>  	if (clone(init_b, stack_b + sizeof(stack_b), CLONE_NEWPID | SIGCHLD, arg) < 0)
>  		_exit(1);
>  	while (read(go[0], &arg, 1) > 0)	/* EOF: main has seized */
>  		;
>  	_exit(0);			/* -> zap_pid_ns_processes(A) */
>  }
>
>  /* Read a small /proc file into buf ("" if it is gone). */
>  static char *slurp(char *buf, size_t len, const char *fmt, ...)
>  {
>  	char path[300];
>  	va_list ap;
>  	FILE *f;
>
>  	va_start(ap, fmt);
>  	vsnprintf(path, sizeof(path), fmt, ap);
>  	va_end(ap);
>  	buf[0] = 0;
>  	if ((f = fopen(path, "r"))) {
>  		buf[fread(buf, 1, len - 1, f)] = 0;
>  		fclose(f);
>  	}
>  	return buf;
>  }
>
>  /* Global pid of A's child B: the process whose PPid is A. */
>  static pid_t child_of(pid_t parent)
>  {
>  	DIR *d = opendir("/proc");
>  	struct dirent *e;
>  	char buf[512], *p;
>  	int ppid;
>
>  	while (d && (e = readdir(d))) {
>  		p = strrchr(slurp(buf, sizeof(buf), "/proc/%s/stat", e->d_name), ')');
>  		if (p && sscanf(p + 2, "%*c %d", &ppid) == 1 && ppid == parent)
>  			return atoi(e->d_name);	/* (leaks d; fine here) */
>  	}
>  	return -1;
>  }
>
>  /* Print a task's state and wchan; return whether it is exiting (PF_EXITING). */
>  static int show(const char *what, pid_t pid, pid_t tid)
>  {
>  	char st[512], wchan[64], *p, c = '?';
>  	unsigned int flags = 0;
>
>  	p = strrchr(slurp(st, sizeof(st), "/proc/%d/task/%d/stat", pid, tid), ')');
>  	if (p)
>  		sscanf(p + 2, "%c %*d %*d %*d %*d %*d %u", &c, &flags);
>  	slurp(wchan, sizeof(wchan), "/proc/%d/task/%d/wchan", pid, tid);
>  	printf("  %s tid %d: state %c, flags %#x, wchan %s\n", what, tid, c, flags, wchan);
>  	return flags & 0x4;
>  }
>
>  int main(int argc, char **argv)
>  {
>  	pid_t a, b, tid, seized[NSEIZE];
>  	int n = 0, status;
>  	struct dirent *e;
>  	char buf[64];
>  	DIR *d;
>
>  	if (pipe(ready) || pipe(go))
>  		return perror("pipe"), 1;
>  	if ((a = clone(init_a, stack_a + sizeof(stack_a), NS_FLAGS | SIGCHLD, NULL)) < 0)
>  		return perror("clone (run as root)"), 1;
>  	if (read(ready[0], buf, 1) != 1 || (b = child_of(a)) < 0)
>  		return fprintf(stderr, "setup failed\n"), 1;
>
>  	/* From outside both namespaces, seize non-leader threads of B. */
>  	snprintf(buf, sizeof(buf), "/proc/%d/task", b);
>  	for (d = opendir(buf); d && (e = readdir(d)) && n < NSEIZE; )
>  		if ((tid = atoi(e->d_name)) > 0 && tid != b && !ptrace(PTRACE_SEIZE, tid, 0, 0))
>  			seized[n++] = tid;
>  	printf("A=%d B=%d: seized %d threads of B\n", a, b, n);
>
>  	close(go[1]);				/* A exits now */
>  	sleep(2);
>  	if (!n || waitpid(a, &status, WNOHANG) != 0 || !show("A", a, a))
>  		return printf("not reproduced\n"), 1;
>  	for (rewinddir(d); (e = readdir(d)); )
>  		if ((tid = atoi(e->d_name)) > 0)
>  			show("B", b, tid);
>  	printf("stuck: A and B can't finish exiting until main reaps its %d traced threads\n", n);
>  	printf("now run: echo freezer > /sys/power/pm_test; echo mem > /sys/power/state\n");
>  	fflush(stdout);
>  	if (argc > 1)
>  		sleep(atoi(argv[1]));
>  	else
>  		getchar();
>
>  	/* Reap the traced zombies: ns B empties, then B and A finish exiting. */
>  	for (int i = 0, left = n; left && i < 500; i++, usleep(10000))
>  		for (int k = 0; k < n; k++)
>  			if (seized[k] && waitpid(seized[k], &status, __WALL | WNOHANG) == seized[k])
>  				seized[k] = 0, left--;
>  	for (int i = 0; i < 500; i++, usleep(10000))
>  		if (waitpid(a, &status, WNOHANG) == a)
>  			return printf("reaped the zombies: hang resolved\n"), 0;
>  	printf("still stuck after reaping\n");
>  	return 2;
>  }
>
> kernel/pid_namespace.c | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
>index 8bc9edb40..abdc05462 100644
>--- a/kernel/pid_namespace.c
>+++ b/kernel/pid_namespace.c
>@@ -23,6 +23,7 @@
> #include <linux/sched/task.h>
> #include <linux/sched/signal.h>
> #include <linux/idr.h>
>+#include <linux/freezer.h>
> #include <linux/nstree.h>
> #include <uapi/linux/wait.h>
> #include "pid_sysctl.h"
>@@ -243,6 +244,11 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
> 	do {
> 		clear_thread_flag(TIF_SIGPENDING);
> 		rc = kernel_wait4(-1, NULL, __WALL, NULL);
>+		/*
>+		 * The freezer's fake signal ends the wait with -ERESTARTSYS;
>+		 * freeze here, or one stuck pid namespace blocks suspend.
>+		 */
>+		try_to_freeze();
> 	} while (rc != -ECHILD);
> 
> 	/*
>@@ -269,7 +275,13 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
> 	 * free_pid() will awaken this task.
> 	 */
> 	for (;;) {
>-		set_current_state(TASK_INTERRUPTIBLE);
>+		/*
>+		 * TASK_IDLE: no hung task warning or load for a wait that can
>+		 * last as long as a tracer keeps a zombie, and a pending signal
>+		 * (e.g. the freezer's fake one) can't turn it into a busy loop.
>+		 * TASK_FREEZABLE: let the freezer freeze us while we wait.
>+		 */
>+		set_current_state(TASK_IDLE | TASK_FREEZABLE);
> 		if (pid_ns->pid_allocated == init_pids)
> 			break;
> 		schedule();
>
>base-commit: ed14a591175bb5f56c2936b082cffb9e4b935e6d
>

Fair enough:

Reviewed-by: Bradley Morgan <brads@mainlining.org>



--- Thanks!
"I'm not a very positive person" - Linus torvalds
