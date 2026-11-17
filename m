Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932243;
	b=r96m4VjdrWFJXSRrAC6LlT+53FLlnZX2OWyivDFhKow4PtxplqqfZojUxYZ4p5cDF++I
	 jbvP9Wz2a0iJMxw3yMnRSKgYwMfcWmpDKodJI5SM5OZXkF1DVwFXtXTBpTCuUiHMvGg9E
	 /GvrlV+wHJTREvPO53KoAu5GZQtEfXBC4UCWsDpK0ZmjfB2rZJSn5xXDyUppJ1P8moJm+
	 OfI4oNwe8bRY3Re8Pof83+9JAITqL7F99169teLiqtgZUiUt9CrEa56Cj6ONsddy3ZyuY
	 6esovS2GWm11x96dWuUqewmoXfL/jGFGPaaBhwzMRRcRyD5/uxLyW41Wp/AshN+luFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932243;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NL0ww0G+wkmoUTIEcewt6rKahuqp+HU09ouoVDjGSdk=;
	b=oEnm0WDqc6FLhzgz7TG27/68oNlfbA0J0zgSPs6tv6lbev8q7gaU1xCGd73wj9Iw/YHL
	 olhfF43hvVUsetc+IF2Brs3XwRFPRXZgjZUhPifzQQJ0ZlaOV36CPJDI/b6CXMdgx7fOL
	 AjqrvVKmqJRetG6GqK6DccZvWLdXbx2KhKKfSDMWK30eHeHLgdeGkCNWUv/KEMvt5pNEd
	 le7w+02X7mwysYUl6OpWcixlVf6Inn9nrLivM3Egh6qrhLgiXkI665DIfsF/zSBo5DATC
	 NsvlTk95sQzzZDTALv0QUmtrhhiTR3eMVQkXy4oS8ybEflTwROrD6f8X2/Tha3qBLfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="QJaqZd/l";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E42606A332;
	Tue, 17 Nov 2026 16:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1E42606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=QJaqZd/l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932242;
	bh=NL0ww0G+wkmoUTIEcewt6rKahuqp+HU09ouoVDjGSdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJaqZd/lswb28KJv7VuKyyLVEX8putQ5zU6mfysWA403rCRMa/X3Q698mgVSM4CiH
	 61fjO4PRzFKG15uPcSInZMDf+JK97wLq1ngAZJK5UN96395jOviS6yY8I5M3t9LwVc
	 Drxtn40SvAxWCzTdADnlyyF0rWyJ2AesbvIi9fG7iKuaCEJjlJm36FP3fESgR8iVVR
	 76j8KgOsxI5nT/DuxccDsOHLX+4vVtcL6+WZRpkA3lDwXdk2auc9HCU58szXyHhV15
	 2fHTDun3rNrAvmHV/1RacMLz6THjAMEWVrZTDcEaxHJuYC8Mu7TzSA0nlcwC01Ie5e
	 QD7nW9Y0oMJfw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHk0XfczRmr;
	Tue, 17 Nov 2026 11:17:22 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: tglx@kernel.org,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	paulmck@kernel.org,
	boqun@kernel.org,
	shuah@kernel.org,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	oleg@redhat.com,
	bestswngs@gmail.com,
	xmei5@asu.edu,
	xujiakai24@mails.ucas.ac.cn,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 04/17] sched/mmcid: Let a running joiner take its CID after the fixups
Date: Tue, 17 Nov 2026 11:17:04 -0500
Message-Id: <f1b450d79e9ae67134ed3451b4af33e71cc5dd74.1794932121.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794932121.git.mathieu.desnoyers@efficios.com>
References: <cover.1794932121.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch to per CPU mode relies on the new user not running yet. The
comment above the code says so: the new user is not visible in the
system, and the task that forks it runs the fixup.

A failed execve() is missed. It rejoins its mm in
sched_mm_cid_after_execve(): the new user is the running task, and it
runs the fixup itself. If it is preempted before the fixup is done,
mm_get_cid() can loop forever at its schedule in, with the runqueue
lock held.

In the diagram below, the machine has two possible CPUs. A and B are
threads of one process, which is in per task mode with two CIDs. C is
the vfork() child of B. A holds mm_cid.mutex from sched_mm_cid_fork(A)
on.

  CPU 0                                     CPU 1

  A: execve()
     sched_mm_cid_before_execve()
       A leaves, users = 1
                                            B: vfork()
                                               sched_mm_cid_fork(C)
                                                 users = 2
                                                 C takes the last CID
  A: execve() fails
     sched_mm_cid_after_execve()
       sched_mm_cid_fork(A)
         users = 3, switch to per CPU mode
         A is active and has no CID
  A is preempted
  A is scheduled in
     mm_cid_schedin(A)
       mm_get_cid() loops:
       B and C hold both CIDs
                                            C: exit()
                                               sched_mm_cid_exit()
                                                 waits for mm_cid.mutex,
                                                 which A holds

Nothing ends the loop. Only the fixup could free a CID, and A is the
task that runs it.

A guest with two CPUs hangs on this sequence when a SCHED_FIFO task
wakes every 50us on CPU 0 to preempt A. CPU 0 stays in __schedule() and
CPU 1 in queued_spin_lock_slowpath(). With this change the same guest
completes 20000 attempts.

Fix this by keeping a running joiner inactive until the fixups are done.
A schedule in gives it no CID before that. sched_mm_cid_fork() then
marks it active, and it takes its CID under the runqueue lock.

Fixes: 653fda7ae73d ("sched/mmcid: Switch over to the new mechanism")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab68e8605eed..510cd775723b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11054,7 +11054,16 @@ static void sched_mm_cid_fork(struct task_struct *t)
 			return;
 		}
 
-		if (!sched_mm_cid_add_user(t, mm)) {
+		flip = sched_mm_cid_add_user(t, mm);
+		/*
+		 * A running joiner takes no CID at a schedule in before the
+		 * fixups are done. The users it joins can hold every CID
+		 * until then, and the fixups are its own work.
+		 */
+		if (t == current)
+			t->mm_cid.active = 0;
+
+		if (!flip) {
 			if (!cid_on_cpu(mm->mm_cid.mode))
 				t->mm_cid.cid = mm_get_cid(mm);
 			break;
@@ -11064,7 +11073,6 @@ static void sched_mm_cid_fork(struct task_struct *t)
 		 * Handle the mode change and transfer current's CID. A
 		 * running joiner has no CID yet. It takes one below.
 		 */
-		flip = true;
 		percpu = cid_on_cpu(mm->mm_cid.mode);
 		if (!percpu)
 			mm_cid_transit_to_task(current, pcp);
@@ -11077,18 +11085,16 @@ static void sched_mm_cid_fork(struct task_struct *t)
 			mm_cid_fixup_tasks_to_cpus();
 		} else {
 			mm_cid_fixup_cpus_to_tasks(mm);
-			/*
-			 * A running joiner may have taken a CID at a
-			 * schedule in. If not, it takes one below.
-			 */
+			/* A running joiner takes its CID below. */
 			if (t != current)
 				t->mm_cid.cid = mm_get_cid(mm);
 		}
 	}
 
-	/* A running joiner with no CID takes one now, see above. */
+	/* The running joiner takes part from here on, see above. */
 	if (t == current) {
 		guard(task_rq_lock)(t);
+		t->mm_cid.active = 1;
 		if (t->mm_cid.cid == MM_CID_UNSET)
 			mm_cid_schedin(t);
 	}
-- 
2.47.3

