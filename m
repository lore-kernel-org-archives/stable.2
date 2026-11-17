Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932243;
	b=Krd+sV6RCEsMCMKsUVrJXWzbBmbuntbyYhPKFtEE2Qrn+j2DdPd3RL1hZMw7symW8NmH
	 0hrOBs/cXFqYkkbgToM4VoHmYAyFS5XCaXIcbFXNyRY6UdRI4XOxI6b1g2cshOyFeSMuV
	 bhRA1q+yz0wXuWKvG5//BqEuL3QghYRyVUKHDFI1MtqTqHu3XlppKrprfs8bHBBdw9skG
	 +S5gGckhF/fPWNNv29eCwLrE35jVdP+XrUPtFf+zFiTiwepa9EZEYLnAYH2CrRl62alw0
	 iVPcnjhTNy67u1izRKUid2Kq0pzDNf7DiousLt3UuVFYeRCWFLDCOgAta8sn6HapjyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932243;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J5ObJtDP34I/BMfHer6YxrOqpSiQsGpA7S8X4Rx45Ro=;
	b=UlKP2rh4dVRccEGxrfILTb/52BsnmILSYENKcYkSGMiZk/IX1L9SHSoN14BrzG8SyERd
	 n3GEHYozLYxRMHtc+oEaZ1lMJiWYpkH3ZyL7D6dlOFCSvnnwdAXpxW5qkIBUD6lDWIP5W
	 UCbE+3KORw81J0LENnl6KGDYaFZpQ+UPYInP+m55ZzEs1UHNwmEwk1p1lH7pWsqnjT6f5
	 jelfgw79LxBaAAEyC8pbsp7WyO6PwT3RDsYG+1d3OLMiT0gT2VJR9kn2HAs0T+3XvmgfI
	 Pw65zZ49w87h3aOmoCg7D9rdPG+b5066ybxfihj9meYBP307qqWXrIJQFN7X6e2K9ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=dAHGJJBy;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC6606A32A;
	Tue, 17 Nov 2026 16:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CCC6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=dAHGJJBy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932241;
	bh=J5ObJtDP34I/BMfHer6YxrOqpSiQsGpA7S8X4Rx45Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAHGJJByTy4EHpW5ej+bdYloHhOBu2GBE4ssFO3r+UHxSeQ4MY4O7+YwycJk/tEps
	 OrX88u+pLS4veb+ki3/QKoXO4/bR2rsV6lppLyZ/xB281s2DfSuTv1e+2BMWh7X2Mi
	 61QAnCNi9mENrqE42GFxcjILKfrEUy3NfLv0ftdbqmnYsn3htVIaIIaOqH6PHOXFxh
	 DpzsXi3FN1R0vgqDDw7s68uwUNlqZq51AJceX6vUmHy4LP9w6nYBPTT1mevY58eCKS
	 3V1i53pVcZ14nG6DI+4ziIomLJT6dRAG8PjWo6b4RE+JVTSyewWk4XU+0Rk9ELWVJ1
	 3pG4Z3U5neg8Q==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHj3vvxzRWZ;
	Tue, 17 Nov 2026 11:17:21 -0500 (EST)
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
Subject: [PATCH 01/17] sched/mmcid: Give a CID to a task that joins its mm while running
Date: Tue, 17 Nov 2026 11:17:01 -0500
Message-Id: <87f01a2eacf8aeea751d8f48b3aab752d825a4bf.1794932121.git.mathieu.desnoyers@efficios.com>
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

sched_mm_cid_fork() makes a task a user of the CIDs of its mm. In per
CPU mode the new user gets no CID there. It takes the CID of its CPU
when it is scheduled in.

This relies on the new user not running yet. That holds for a fork()
child. A successful execve() joins a new mm as its first user, and the
first user gets a CID directly.

A failed execve() is missed. bprm_execve() leaves the mm in
sched_mm_cid_before_execve(). Its error path rejoins the same mm in
sched_mm_cid_after_execve(). If the execve() fails before
begin_new_exec() kills the other threads, they are still users of the
mm. The mm can then be in per CPU mode. The task is running, so it
returns to user space with no schedule in. Its CID is still
MM_CID_UNSET, and rseq_force_update() makes the kernel write it to the
rseq area. User space reads an mm_cid of 0x80000000 until its next
context switch. A program that indexes per-CID data with it would read
out of bounds.

An execve() of a file that no binfmt handler recognises fails in that
window. In testing, with 20 threads on a machine with 8 CPUs:

  mm_cid 2147483648 (0x80000000) after a failed execve, round 0

Fix this by giving a running joiner its CID in sched_mm_cid_fork(). It
takes the CID a schedule in would give it, under the runqueue lock.

The switch back to per task mode has the same problem. Since
commit 7dbc307b6c72 ("sched/mmcid: Fix affinity-triggered switch back to
per-task mode"), a join can do the switch that an affinity change
queued. For a running joiner:

 1. sched_mm_cid_fork() runs mm_cid_fixup_cpus_to_tasks().
 2. The joiner is preempted. It takes a CID at its schedule in.
 3. sched_mm_cid_fork() allocates a CID for the new user. That
    overwrites the CID of step 2.

The bit of the first CID stays set in the bitmap, with no owner. In
testing, three threads on two CPUs then read an mm_cid of 3 or more.
Leave that allocation to a joiner that is not running. A running joiner
takes its CID as above if it has none.

Fixes: 653fda7ae73d ("sched/mmcid: Switch over to the new mechanism")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/core.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a088d4576f5..f2a981d418eb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10986,10 +10986,19 @@ static bool sched_mm_cid_add_user(struct task_struct *t, struct mm_struct *mm)
 	return mm_update_max_cids(mm);
 }
 
+/*
+ * Make @t a user of the CIDs of its mm. Called on fork(2) and on
+ * execve(2). A failed execve(2) rejoins the mm it left.
+ *
+ * In per CPU mode a new user gets no CID here. It takes the CID of its
+ * CPU when it is scheduled in. A task that joins while it is running
+ * returns to user space before that, so it takes its CID here. This is
+ * the case of a failed execve(2) when the mm has other users.
+ */
 static void sched_mm_cid_fork(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	bool percpu;
+	bool percpu = false, flip = false;
 
 	if (!mm)
 		return;
@@ -11012,10 +11021,14 @@ static void sched_mm_cid_fork(struct task_struct *t)
 		if (!sched_mm_cid_add_user(t, mm)) {
 			if (!cid_on_cpu(mm->mm_cid.mode))
 				t->mm_cid.cid = mm_get_cid(mm);
-			return;
+			break;
 		}
 
-		/* Handle the mode change and transfer current's CID */
+		/*
+		 * Handle the mode change and transfer current's CID. A
+		 * running joiner has no CID yet. It takes one below.
+		 */
+		flip = true;
 		percpu = cid_on_cpu(mm->mm_cid.mode);
 		if (!percpu)
 			mm_cid_transit_to_task(current, pcp);
@@ -11023,11 +11036,25 @@ static void sched_mm_cid_fork(struct task_struct *t)
 			mm_cid_transit_to_cpu(current, pcp);
 	}
 
-	if (percpu) {
-		mm_cid_fixup_tasks_to_cpus();
-	} else {
-		mm_cid_fixup_cpus_to_tasks(mm);
-		t->mm_cid.cid = mm_get_cid(mm);
+	if (flip) {
+		if (percpu) {
+			mm_cid_fixup_tasks_to_cpus();
+		} else {
+			mm_cid_fixup_cpus_to_tasks(mm);
+			/*
+			 * A running joiner may have taken a CID at a
+			 * schedule in. If not, it takes one below.
+			 */
+			if (t != current)
+				t->mm_cid.cid = mm_get_cid(mm);
+		}
+	}
+
+	/* A running joiner with no CID takes one now, see above. */
+	if (t == current) {
+		guard(task_rq_lock)(t);
+		if (t->mm_cid.cid == MM_CID_UNSET)
+			mm_cid_schedin(t);
 	}
 }
 
-- 
2.47.3

