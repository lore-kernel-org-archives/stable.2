Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602994;
	b=f0TL7H+dbBDqU2uUzggwHKse+W+KTMlf1UpND+esIe8QVjObSxJ472i3nCegrY02MItS
	 MkNJkyWU6ESEEoHznljiJnd3CIIVLgSKnUd6+3JI9xyh1m3EbdzEmbDKXFnlRVXOprS2d
	 iEfNxD/1GsS5n16oqhZRzPKhKXsOLPGPYVPZNdm/IMaqtABbamftiT+/kgEYmCrY28RQQ
	 6dhXsoNARgbDxiPFeh1M8ycoO50ui1ZLUfuv9xzblPmViXTPmPw+DWRL4boE98zMlIu07
	 ho1iQKq+fhFEsZEw1CPwiZFLs+B3txZQ8RBj0wTbj+11JW2DcVGab+de86AWsIa+Edw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602994;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yZdBisUQ6cEPGuGW4i9SlhV+1hxaw0vwwdsdSttHLZA=;
	b=lI1FdfQmL33cC1AHQu2hK2/NJlkPvE4VC0mGgM9q8spcCswmGXQAR+TwJa7wbbdznecg
	 HIfy/6WiTNXR4JjB4fO51ZvQ0/TGYzYvwBDDh68eD2qfmhmA+fas8FQ4FpPM/U1EdDXH9
	 VSDk9/kRshqTXItrvsXMSvuzWh8fRLnXO51nxA8r66WzuS0BecHLltmUm9UAQMCqMPy7B
	 cpfyT+sjkEsS/9E/d7VMj5TjFjtkiSXZK39NTi5uYUVXWZaQjGV/3UF9HCWgS1x1bmXJW
	 5ZDePpKd1FOoBtb6zbdJoI4Sx0f5DD/gOeN3Uglk1F+qaae4+irYF5nH1zFSU6iSzcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=C5+l0Pdq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E60606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=C5+l0Pdq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6361F000E0;
	Wed, 25 Nov 2026 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602993;
	bh=yZdBisUQ6cEPGuGW4i9SlhV+1hxaw0vwwdsdSttHLZA=;
	h=Subject:To:Cc:From:Date;
	b=C5+l0PdqxqbvfdQfJgugvygSXQoOuv5I2Go2ZR9aYTOOTdnkdVRpCuSwD7KCtCQY9
	 By6GS12JqBLeT7Dv8kR1oA7d7m90EL5xDyH3cRxa+x+00V+mydqxXUzxU3MgZVvVb6
	 KTgruRWvGQtrWx2cwvFVqj6mv1efXkgwvnawLI4w=
Subject: FAILED: patch "[PATCH] sched/core: Fix cpuset_mutex double unlock in" failed to apply to 5.15-stable tree
To: parri.andrea@gmail.com,juri.lelli@redhat.com,kayracizmeci@gmail.com,longman@redhat.com,mingo@kernel.org,peterz@infradead.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:21:27 +0100
Message-ID: <2026112527-fruit-graph-9946@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f7141257dd67d4936f906a6cfd1d0007721f6898
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112527-fruit-graph-9946@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7141257dd67d4936f906a6cfd1d0007721f6898 Mon Sep 17 00:00:00 2001
From: Andrea Parri <parri.andrea@gmail.com>
Date: Mon, 2 Nov 2026 14:46:05 +0100
Subject: [PATCH] sched/core: Fix cpuset_mutex double unlock in
 __sched_setscheduler()

A sched_setattr() with SCHED_FLAG_KEEP_POLICY on a SCHED_DEADLINE task
unlocks cpuset_mutex twice if the task's policy changes concurrently:

  WARNING: bad unlock balance detected!
  7.4.0-rc1 #1 Not tainted
  -------------------------------------
  repro/126 is trying to release lock (cpuset_mutex) at:
  [<ffffffff9a17cacc>] __sched_setscheduler+0x9cc/0xc40
  but there are no more locks to release!
  ...
  Call Trace:
   print_unlock_imbalance_bug.part.0+0xfb/0x110
   lock_release+0x286/0x2e0
   __mutex_unlock_slowpath+0x1a/0x400
   __sched_setscheduler+0x9cc/0xc40
   __x64_sys_sched_setattr+0xa3/0x1b0
   do_syscall_64+0x106/0x5f0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

__sched_setscheduler() samples p->policy before taking any lock, and
restarts from the recheck label if p->policy differs under the rq lock.
The restart drops cpuset_mutex but leaves cpuset_locked set, so a pass
that no longer needs the mutex still unlocks it on its way out:

  CPU 1                                CPU 2
  __sched_setscheduler(KEEP_POLICY)
    policy = p->policy /* DEADLINE */
                                       __sched_setscheduler(SCHED_OTHER)
                                         p->policy = SCHED_OTHER
    cpuset_locked = true
    cpuset_lock()
    rq = task_rq_lock(p)
    oldpolicy != p->policy
      cpuset_unlock()
      goto recheck
    /* no cpuset_lock() this time */
    ...
    if (cpuset_locked)
      cpuset_unlock()

Without CONFIG_DEBUG_MUTEXES, or CONFIG_DEBUG_RT_MUTEXES on PREEMPT_RT,
nothing warns. The second unlock still clears the owner field regardless
of who holds the mutex, so another task can lose cpuset_mutex inside its
critical section. Entering SCHED_DEADLINE needs CAP_SYS_NICE, but a
racing caller that owns the task does not need it if it samples a policy
other than SCHED_DEADLINE.

Clear cpuset_locked when dropping the mutex for the restart. This should be
safe because the flag is only tested on the paths leaving the next pass,
after that pass has set it again if it took the mutex.

The following program, run as root, reproduces the splat, which no longer
appears with this applied. On PREEMPT_RT it crashes the kernel within
seconds, which this also fixes:

  #define _GNU_SOURCE
  #include <pthread.h>
  #include <stdint.h>
  #include <sys/syscall.h>
  #include <unistd.h>

  struct attr {
      uint32_t size, policy;
      uint64_t flags;
      int32_t nice;
      uint32_t prio;
      uint64_t runtime, deadline, period;
  };

  static volatile int stop;
  static volatile pid_t target;

  static void set(struct attr a)
  {
      a.size = sizeof(a);
      syscall(SYS_sched_setattr, target, &a, 0);
  }

  static void *sleeper(void *arg)
  {
      target = syscall(SYS_gettid);
      while (!stop)
          usleep(1000);
      return arg;
  }

  static void *switcher(void *arg)
  {
      while (!stop) {
          /* SCHED_DEADLINE, 2us every 1s */
          set((struct attr){ .policy = 6, .runtime = 2000,
                             .deadline = 1000000000,
                             .period = 1000000000 });
          set((struct attr){ .policy = 0 }); /* SCHED_OTHER */
      }
      return arg;
  }

  static void *racer(void *arg)
  {
      /* KEEP_POLICY | KEEP_PARAMS */
      while (!stop)
          set((struct attr){ .flags = 0x18 });
      return arg;
  }

  int main(void)
  {
      pthread_t t[5];
      int i;

      pthread_create(&t[0], NULL, sleeper, NULL);
      while (!target)
          usleep(100);
      pthread_create(&t[1], NULL, switcher, NULL);
      for (i = 2; i < 5; i++)
          pthread_create(&t[i], NULL, racer, NULL);
      sleep(30);
      stop = 1;
      for (i = 0; i < 5; i++)
          pthread_join(t[i], NULL);
      return 0;
  }

An LLM helped find the PREEMPT_RT crash and write this patch and its test.

Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20261016062629.2102883-1-sh_def%40163.com
Link: https://patch.msgid.link/20261102134606.242743-1-parri.andrea@gmail.com

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 98be11a9d5d7..0ec401af80d1 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -640,8 +640,10 @@ int __sched_setscheduler(struct task_struct *p,
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
-		if (cpuset_locked)
+		if (cpuset_locked) {
 			cpuset_unlock();
+			cpuset_locked = false;
+		}
 		goto recheck;
 	}
 

