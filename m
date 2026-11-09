Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213499;
	b=wRK471Q1ddqkxKir+9DRExEJSu8SDuZK1rml9FrxswnuyOwOy3nI16oXmrOzA00GXTbv
	 pQHCqBDA/TpGlbKYXzdUeDF9YfQwC7w6ytN9lFYu6TcuwuuL6iDaokI43hqKgncAZxhQu
	 qFiZlYt3ql34HQ+cZ5yhPDUYEIIs/YFPuPVB+D324SzzKmoD44bPPDkvtqI1as4fjmNrQ
	 nwIQYGnzBBJfro0pm2ZbhQSlzBn5Gc6OSsgHxDjCGjcken6dN35q5Z41b2eoZeVoaK26F
	 65qmg8RFVmjt3T3q2Cmf2x5ocylpZQ/StrRceysy2jLk5EaZOCA4Hu0K+gu/uIjhjXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213499;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=FBDLV/EoKl28Ol/xyBl61MA3kGvnoSRF5fzvP1+IGQc=;
	b=UzkS9bGfEU14HIiPYXZLrGjiDWR0qRmN92Fr33YZPKzuxWNzvjdEoeT690sJmZXRhrFa
	 vxBU9n7NxNrlDyDJuE2NGVnD/ITGGOXP0hf8kJhqGwKQDoVeGVK/H5cYcBecxZu6gkRND
	 xwotdKvu/qcp+d6U/i9wXwzPc/Gydk0wfwrj7Dpjqp03TdTT4USPfvqOZiAyZa8xO9Ol3
	 VyJAysYv+By4WpaoezXsM1eXrC7atn799u9MbVYXmw3pcls8+VkO0cWHxvjCbpFv+GUZ1
	 kNIoFEFqnQcpkFQbx3J+Tzagc7e8eB8ZBe2OrvWNAiuyZT5hfoxqAlg898qAmbVT7oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=mrJx8++s;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=opqgERrm;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051976082BC6;
	Mon,  9 Nov 2026 08:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 051976082BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=mrJx8++s;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=opqgERrm
Date: Mon, 09 Nov 2026 08:38:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794213497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBDLV/EoKl28Ol/xyBl61MA3kGvnoSRF5fzvP1+IGQc=;
	b=mrJx8++sk+iqJu6DByNCHlQlQkLNbPX48eWnvsGeGSGZyHodDbUGolEN6KnxYQLjLf/ALl
	Qu7+m2a7q9IYYjfphSivU65mMCRJTFofbENWTmuZ/E50MEG2J6CKhlvtybmiSf3SNFBS93
	PlyzjfzhC4GawQgQpf3gvthwcpwPe6Syodj1q0TLxyppyA18wYVYlBUbYrPS0V2IpN1kLR
	UC0SeMvXdML2dsc5ls1ypTMxQ1kT5+HQyxnelIxbhCpd5yV6GDRdLpdQ86RrPn4nB6MYTj
	Auc9V07iLrhnM6s570P4HuLiyRj7lEmO2uhvEzdexDERb/6KVXtrjGF2J05teA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794213497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBDLV/EoKl28Ol/xyBl61MA3kGvnoSRF5fzvP1+IGQc=;
	b=opqgERrmc+uP6eQuYJ//ZeZQVFle1ynqykjnzZuMPUbYI7yjwPdgUfYx2jAe4pHaimOM+w
	APuqYCXBe458J9Bg==
From: "tip-bot2 for Andrea Parri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix cpuset_mutex double unlock in
 __sched_setscheduler()
Cc: Sashiko <sashiko-bot@kernel.org>, Andrea Parri <parri.andrea@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, Kayra Cizmeci <kayracizmeci@gmail.com>,
 Juri Lelli <juri.lelli@redhat.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
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
Message-ID: <179421349532.2093942.7837275632332518113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     986efdec58355e41e213bbef125da2d2b766eee0
Gitweb:        https://git.kernel.org/tip/986efdec58355e41e213bbef125da2d2b76=
6eee0
Author:        Andrea Parri <parri.andrea@gmail.com>
AuthorDate:    Mon, 02 Nov 2026 14:46:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Nov 2026 11:45:17 +01:00

sched: Fix cpuset_mutex double unlock in __sched_setscheduler()

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
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://sashiko.dev/#/patchset/20261016062629.2102883-1-sh_def%40163.com
Cc: stable@vger.kernel.org
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
