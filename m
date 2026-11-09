Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216543;
	b=S8KgMwdbeMrEJBJBqKcezNbv56Ymf5yxv0myQMPF2v2d2WFkcjmO2USms3Btqlh/jPT7
	 KRBDa5vvANwE19lNsbamfvVg1ZAYDvcRYN9iLJQV3mjuUGuCaye2kut7O+MoYBQWPVh48
	 3B3c88nPFC60dXQmpbUZQdiq+hI52mY+4gBfrQ36x/RjVmgs8KyUdIR98y6tzr3ri9gDQ
	 zDMLnQoFsiz9CY4JP0kN4CZlQLS8KpZleIP3KIa673nfkxTe96lEdU9v00iMHR6RLsj3d
	 Fwk5CG3k7GSV7cyEqx8hAiSTLjcNXufjtAfBFFKWv8cEQ1h/dBj7NAw5HTB/nhrfWVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216543;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=qbotQLjDf3or+XZjbpPemRjx+1SgujjO0xtjN9X3lDA=;
	b=cUTaPSdbWglLrlA9gcL7weMN8SxkvsS/zLNStE1kJcpy51hNaeSkK1mXw5uaIVyILxFz
	 kxC2BraxsCdPR8tpOdJ0lOwq/F6Zd8wWdX+iU1Ej14vAi+Uxt3AXR0N9bZ2je2OrzYdUy
	 l+U9IhP4XonXguet9hEyJKfYmN+fqpRs0FaFefAYPJciL/LTJ9cvQ2vqZwfi6l0I6Oe2p
	 9SdP/Yt9+AnSfiyMuTYohT74rHIYb/aF98ixi/0omU2bfpVUPmGGcOCSmfeFSD+AejuXB
	 xPrhLHMzzdYmsxKjhnnIQ70xbm6toi4Gx4DXFd+q2ORjddGjbzzArgX6MlOwHvZS1PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TMPBuRgM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5wFJED7x;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA360A2631;
	Mon,  9 Nov 2026 09:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CDA360A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TMPBuRgM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5wFJED7x
Date: Mon, 09 Nov 2026 09:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794216541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbotQLjDf3or+XZjbpPemRjx+1SgujjO0xtjN9X3lDA=;
	b=TMPBuRgMfcZC2xpY7N9my+VphR9mTSYkZ193bWcVkMjfiLc98ljD5PZluPULHfdx8ZUlOx
	lvIr9jz2WMs880/5OVMTr7jpBUeZZm2jry9FLB6GoKbfIbcEW+hLuBcN6lWVbyF6U5ooCj
	GlqX9B3RAXbNJimadp9430ykyli06oc6o9u+TBiDwl3tFDYOWkjvaNVdh7zJeM9VA3GsIy
	H5qfKlmcd7Y0D4LhRi3ow9NyL+dHAXrwtcc6Hwt+EtKENzlw7dIphUY/bfmGUPRyq9nrwx
	qJkEyEVRz09st63E6gDyrFDyhqTEGvJ3OZ/rVZtcTDmyhGZ8hgifANWb1KtWmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794216541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbotQLjDf3or+XZjbpPemRjx+1SgujjO0xtjN9X3lDA=;
	b=5wFJED7xWb80DROVtvoHSkuuxmExKcbg44XLtr8xlXy7Dukc1GQKrjBta9kUP7vlXpDHge
	WSeuNKaJ9gAQSwBw==
From: "tip-bot2 for Andrea Parri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Reject clamp values above
 SCHED_CAPACITY_SCALE
Cc: Sashiko <sashiko-bot@kernel.org>, Andrea Parri <parri.andrea@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261102134831.243255-1-parri.andrea@gmail.com>
References: <20261102134831.243255-1-parri.andrea@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179421653983.2093942.7959311069663921093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8127ec8458df29bd702db602473042ccb9e619b9
Gitweb:        https://git.kernel.org/tip/8127ec8458df29bd702db602473042ccb9e=
619b9
Author:        Andrea Parri <parri.andrea@gmail.com>
AuthorDate:    Mon, 02 Nov 2026 14:48:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Nov 2026 10:09:10 +01:00

sched/uclamp: Reject clamp values above SCHED_CAPACITY_SCALE

sched_setattr() accepts sched_util_min and sched_util_max values that do
not fit in uclamp_se::value. A single thread can do:

  sched_setattr(max =3D 800)		returns 0
  sched_setattr(min =3D 0xfffffffe)	returns 0
  sched_getattr()			min=3D2046 max=3D800

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

  WARNING: kernel/sched/core.c:1862 at dequeue_task+0x2a3/0x2b0, CPU#0: repro=
/126
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
      struct attr a =3D { .size =3D sizeof(a), .flags =3D 0x38, .util_min =3D=
 v };

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
      long v =3D (long)arg;

      set_min(v);
      while (!stop) {
          burn(v =3D=3D 800 ? 300 : 1500);
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
      stop =3D 1;
      for (i =3D 0; i < 3; i++)
          pthread_join(t[i], NULL);
      return 0;
  }

An LLM helped find the warning and write this patch and its tests.

Fixes: 480a6ca2dc6e ("sched/uclamp: Allow to reset a task uclamp constraint v=
alue")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20261016062629.2102883-1-sh_def%40163.com
Link: https://patch.msgid.link/20261102134831.243255-1-parri.andrea@gmail.com
---
 kernel/sched/syscalls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index fb8f332..98be11a 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -318,8 +318,8 @@ static inline void __setscheduler_dl_pi(int newprio, int =
policy,
 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
 {
-	int util_min =3D p->uclamp_req[UCLAMP_MIN].value;
-	int util_max =3D p->uclamp_req[UCLAMP_MAX].value;
+	unsigned int util_min =3D p->uclamp_req[UCLAMP_MIN].value;
+	unsigned int util_max =3D p->uclamp_req[UCLAMP_MAX].value;
=20
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		util_min =3D attr->sched_util_min;
