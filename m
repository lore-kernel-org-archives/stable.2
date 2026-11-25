Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602977;
	b=kWy/wgckWS87MIvRmYp8a1fEWJly2SZ934jTCmyliw6S4p+ohNk31QnjePKN5ZejWAlh
	 DKFuX+waC4jrPlSHXADuRFtEU7lmN7tM8yu8LvFS3WYqR2fc2r6M7Xqk/nwujmo4iTrjr
	 3uAMYT5ckMV0lG6xAKjxk3sHakddx0dP6Y+6rrDo0TsgM5acTxCYuK4Z/L5fZSCYsi/w3
	 GWZX8M90gukHFltLkt2yrkmwWD3BWpHBbJfiil2A7K/1I7U+0nYKy1jSPOc4tnwfX6PbX
	 4KCX7QLx3fs9BRE/5uFh3El1dhwa9OX62MIBihSX6ihmwHXNHNDs4VFGKAhpfmEor7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602977;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AE9pPIIkz7ab5v7pY3VWUYeCfWO5tJEZPutLrfZZjlU=;
	b=IVy3ZyoCxzMe9qPPIBPUduUc+4jfFZNp5y+04B0YUtTIkwl8sbBRs97FTB0uZUiQPER8
	 mZMfW3nZxQ7PjLT1GGzwZI7dn5YnktcLE02d1+Crc8tdCxsLeheWN8CRfJxeQDie20Rg+
	 WWhulQEkxeOvoXe+NJHCAmyHchLlHWpPMDAOpbyEE+g47dcb5VJdIwNBSejAOXTR9Vnqs
	 nmN04sPB8Cj3PAl4B+rWqHay4tAHeRx/kM2bHT97OCvnvFOP1tSc/F2uKGljCzcoxpGpz
	 6gvKJ4b//uOINZGnhA7cQr2lM/SIKHRukVNveNXtvAgggmx9rLcvQ3Y1weF7YVaryLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pyNXvqGi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F6606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=pyNXvqGi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAD41F000D1;
	Wed, 25 Nov 2026 10:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602977;
	bh=AE9pPIIkz7ab5v7pY3VWUYeCfWO5tJEZPutLrfZZjlU=;
	h=Subject:To:Cc:From:Date;
	b=pyNXvqGiDsoo0bFC1z9FZF5U2BhtYpyf3AVnybWrcuuPhBxPR0tbExC8QoJDXxjte
	 /KY24OoX+N03IJMmy+UrFH1qSMG7hjDzDmkK3yAOnE7ORQNuIktMsGQDPLmOSNy7VC
	 bFjk6+Lx3PQdoUhjB/yYnGTZuwEKSi5C9xyJzD/w=
Subject: FAILED: patch "[PATCH] sched/uclamp: Reject clamp values above SCHED_CAPACITY_SCALE" failed to apply to 6.6-stable tree
To: parri.andrea@gmail.com,mingo@kernel.org,peterz@infradead.org,sashiko-bot@kernel.org,vincent.guittot@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:21:05 +0100
Message-ID: <2026112505-zigzagged-widget-9e48@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8127ec8458df29bd702db602473042ccb9e619b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112505-zigzagged-widget-9e48@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8127ec8458df29bd702db602473042ccb9e619b9 Mon Sep 17 00:00:00 2001
From: Andrea Parri <parri.andrea@gmail.com>
Date: Mon, 2 Nov 2026 14:48:30 +0100
Subject: [PATCH] sched/uclamp: Reject clamp values above SCHED_CAPACITY_SCALE

sched_setattr() accepts sched_util_min and sched_util_max values that do
not fit in uclamp_se::value. A single thread can do:

  sched_setattr(max = 800)		returns 0
  sched_setattr(min = 0xfffffffe)	returns 0
  sched_getattr()			min=2046 max=800

which leaves the minimum above both SCHED_CAPACITY_SCALE and the task's own
maximum.

The range check in uclamp_validate() relies on the + 1 wrapping -1, the
reset value, to 0:

	if (util_min + 1 > SCHED_CAPACITY_SCALE + 1)

That only works for an unsigned type. util_min and util_max are int and
SCHED_CAPACITY_SCALE is a long, so every negative value passes the check,
and so does INT_MAX, whose + 1 wraps.

uclamp_se_set() then truncates what got through to the 11 bits of
uclamp_se::value, but computes the bucket from the full value. A minimum
of 0xfffff800 is stored as 0 in the top bucket, where uclamp_rq_max_value()
takes it for the highest active clamp once a higher value leaves the rq.
The rq clamp falls below what the remaining tasks requested, and emptying
their bucket trips the WARN_ON_ONCE() in uclamp_rq_dec_id(), without any
privilege:

  WARNING: kernel/sched/core.c:1862 at dequeue_task+0x2a3/0x2b0, CPU#0: repro/126
  Call Trace:
   __schedule+0x933/0x1320
   schedule+0x36/0x100
   do_nanosleep+0x61/0x190
   hrtimer_nanosleep+0xb5/0x1d0

Make util_min and util_max unsigned int, so that -1 is the only value that
wraps. The pair check below is unaffected, since it skips -1 explicitly and
anything else is at most SCHED_CAPACITY_SCALE by then.

Requests that were only accepted because of this now fail with -EINVAL.

The following program triggers the warning when run by any user outside
a child cpu cgroup. With this applied, its 0xfffff800 request fails with
-EINVAL and the warning no longer appears:

  #define _GNU_SOURCE
  #include <pthread.h>
  #include <sched.h>
  #include <stdint.h>
  #include <sys/syscall.h>
  #include <time.h>
  #include <unistd.h>

  struct attr {
      uint32_t size, policy;
      uint64_t flags;
      int32_t nice;
      uint32_t prio;
      uint64_t runtime, deadline, period;
      uint32_t util_min, util_max;
  };

  static volatile int stop;

  static void set_min(uint32_t v)
  {
      /* KEEP_POLICY | KEEP_PARAMS | UTIL_CLAMP_MIN */
      struct attr a = { .size = sizeof(a), .flags = 0x38, .util_min = v };

      syscall(SYS_sched_setattr, 0, &a, 0);
  }

  static void burn(long us)
  {
      struct timespec s, n;

      clock_gettime(CLOCK_MONOTONIC, &s);
      do
          clock_gettime(CLOCK_MONOTONIC, &n);
      while ((n.tv_sec - s.tv_sec) * 1000000 +
             (n.tv_nsec - s.tv_nsec) / 1000 < us);
  }

  static void *bogus(void *arg)
  {
      set_min(0xfffff800);
      while (!stop)
          burn(1000);
      return arg;
  }

  static void *worker(void *arg)
  {
      long v = (long)arg;

      set_min(v);
      while (!stop) {
          burn(v == 800 ? 300 : 1500);
          usleep(100);
      }
      return arg;
  }

  int main(void)
  {
      pthread_t t[3];
      cpu_set_t c;
      int i;

      CPU_ZERO(&c);
      CPU_SET(0, &c);
      sched_setaffinity(0, sizeof(c), &c);
      pthread_create(&t[0], NULL, bogus, NULL);
      usleep(50000);
      pthread_create(&t[1], NULL, worker, (void *)500L);
      pthread_create(&t[2], NULL, worker, (void *)800L);
      sleep(15);
      stop = 1;
      for (i = 0; i < 3; i++)
          pthread_join(t[i], NULL);
      return 0;
  }

An LLM helped find the warning and write this patch and its tests.

Fixes: 480a6ca2dc6e ("sched/uclamp: Allow to reset a task uclamp constraint value")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20261016062629.2102883-1-sh_def%40163.com
Link: https://patch.msgid.link/20261102134831.243255-1-parri.andrea@gmail.com

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index fb8f332074b8..98be11a9d5d7 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -318,8 +318,8 @@ static inline void __setscheduler_dl_pi(int newprio, int policy,
 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
 {
-	int util_min = p->uclamp_req[UCLAMP_MIN].value;
-	int util_max = p->uclamp_req[UCLAMP_MAX].value;
+	unsigned int util_min = p->uclamp_req[UCLAMP_MIN].value;
+	unsigned int util_max = p->uclamp_req[UCLAMP_MAX].value;
 
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		util_min = attr->sched_util_min;

