Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216542;
	b=ZLByJlD4tFcB11Dg3mED2eAls5bvWEocGjhD7kbUEFxvsXHTGjPmOVfgwqd14pM284hp
	 hVhKG2k0eZy5r7DrNw3MLvaKC3dX+rhl3ZM8cK0CnogPDYRT5FGEWdT8+HdRmsGPSSsNd
	 Cd8EElxkVQ4aiodNfzEAfpOqRr5SrEGv7Co5T4RpWvfDSlqev1oG8iwT9/kOo5YmgYHiC
	 iMbRSKdouJkA0wGIaRoVR1z7ymVA/uEP4e5ZFIvBo6AzIDKvircbHINCyiNqwa/Aujzrt
	 y26FnbS+P7ILkfRK+tXEkQCU5qPA8/SJ+5e0KEhQSzvY/4TaIRXL6ePq+rouO9yI3Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216542;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=DtDuV9+DNLMCOx4WI8othldQ2OXDeK3bq3UTOQXllzU=;
	b=H9MbVgNrDPFbt5licJoczfbwDG069fe01D2DZTwp50S6p5AXrds8eUhJfuCYP0Xh7Xfm
	 SHCOPkBvoDK3/19zRwuZmMDXRM4m4QsCdEg7giaqbUV+oPgIosfF8KHzZorEMO8dbWIvB
	 ZMibGF4wCa/ZT8JrWxIQOPR7GnU3ZNowMXzOsmF6NzOtidL+ZjaKFIDzMGraJzaOiX1ge
	 DByIroZtImPnog/n7SC7ku4Ap8i7U0btpLXOSdaen2jd4RgjKHqNqh5EFVV0f5c6QZ3e4
	 6ZJguewNUgm0yB8WvJyPQvxH+DIxRQhAfQ/xwx9PTerpBQ7PqPhC0UGcg4Rmcq64aJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=WnO29ofA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="/4NJubqM";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9AD60A2613;
	Mon,  9 Nov 2026 09:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A9AD60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=WnO29ofA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/4NJubqM
Date: Mon, 09 Nov 2026 09:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794216540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtDuV9+DNLMCOx4WI8othldQ2OXDeK3bq3UTOQXllzU=;
	b=WnO29ofACIuoX5XXG341quEjI5ZghgC6e1qfOnu7K4PKsNHDCyXJOHmMousbmOCNttUvSS
	0gP8PiZuwA1QxB2F5JBku14NhjwK0221OVqcHq3faSrYELJriB5RDrLl71g8Z18rpp7e92
	m4u99qxOPlhhgzzwjmo68zwklThl/CGG9GuPDgh3nqtpRQpMzNCcF9Z0JYskKSy87TR2le
	L9evIjAQKkwnkHqnLJRWLw9yNjDDiH06mRGwFzuU5yBjH6I0o64Qy+Pn2CcpgULNmccuk3
	XRUGYL+IRtPiH5qEwdAIFZtMyXjtsMFJO+xslSW5d8ucdK3VPQMOLf276BD6Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794216540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtDuV9+DNLMCOx4WI8othldQ2OXDeK3bq3UTOQXllzU=;
	b=/4NJubqMQIEzDDYcu31UWFA65XiU1sO3qIX0z6TJLLW0TBMprR7xD7gw8D7LwjXnKCeQR9
	BCJ9+XY1GB/8OmAA==
From: "tip-bot2 for Andrea Parri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Fix cpuset_mutex double unlock in
 __sched_setscheduler()
Cc: Sashiko <sashiko-bot@kernel.org>, Andrea Parri <parri.andrea@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Waiman Long <longman@redhat.com>,
 Kayra Cizmeci <kayracizmeci@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261102134606.242743-1-parri.andrea@gmail.com>
References: <20261102134606.242743-1-parri.andrea@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179421653833.2093942.14995996685714651787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f7141257dd67d4936f906a6cfd1d0007721f6898
Gitweb:        https://git.kernel.org/tip/f7141257dd67d4936f906a6cfd1d0007721=
f6898
Author:        Andrea Parri <parri.andrea@gmail.com>
AuthorDate:    Mon, 02 Nov 2026 14:46:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Nov 2026 10:09:18 +01:00

sched/core: Fix cpuset_mutex double unlock in __sched_setscheduler()

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
    policy =3D p->policy /* DEADLINE */
                                       __sched_setscheduler(SCHED_OTHER)
                                         p->policy =3D SCHED_OTHER
    cpuset_locked =3D true
    cpuset_lock()
    rq =3D task_rq_lock(p)
    oldpolicy !=3D p->policy
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
      a.size =3D sizeof(a);
      syscall(SYS_sched_setattr, target, &a, 0);
  }

  static void *sleeper(void *arg)
  {
      target =3D syscall(SYS_gettid);
      while (!stop)
          usleep(1000);
      return arg;
  }

  static void *switcher(void *arg)
  {
      while (!stop) {
          /* SCHED_DEADLINE, 2us every 1s */
          set((struct attr){ .policy =3D 6, .runtime =3D 2000,
                             .deadline =3D 1000000000,
                             .period =3D 1000000000 });
          set((struct attr){ .policy =3D 0 }); /* SCHED_OTHER */
      }
      return arg;
  }

  static void *racer(void *arg)
  {
      /* KEEP_POLICY | KEEP_PARAMS */
      while (!stop)
          set((struct attr){ .flags =3D 0x18 });
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
      for (i =3D 2; i < 5; i++)
          pthread_create(&t[i], NULL, racer, NULL);
      sleep(30);
      stop =3D 1;
      for (i =3D 0; i < 5; i++)
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
---
 kernel/sched/syscalls.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 98be11a..0ec401a 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -640,8 +640,10 @@ change:
 	if (unlikely(oldpolicy !=3D -1 && oldpolicy !=3D p->policy)) {
 		policy =3D oldpolicy =3D -1;
 		task_rq_unlock(rq, p, &rf);
-		if (cpuset_locked)
+		if (cpuset_locked) {
 			cpuset_unlock();
+			cpuset_locked =3D false;
+		}
 		goto recheck;
 	}
=20
