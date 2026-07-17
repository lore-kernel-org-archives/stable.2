Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371742A145
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298894; cv=none; b=hTSjwdbBQpuTwQ1nqQm+ojPt6XABvm1eFzHisKHnQlo5gtjNjK8b31bJwe0GKHlkJO+XP3CmgKLs6D+Y0x+RmOMDdV5RnJtsVpD6vXHdulEkJqhJWIEbT1CqVS07JHFxHxc6jIYWaTQ3NRCkTDQglRklKmV+WKvbggaTlLUrhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298894; c=relaxed/simple;
	bh=Hx48YZ/dNHthp7/RsrnwCe7TKff5OwUCsoMruaDY6OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odvdiuFQyCJliAGI/n0cKsUIJwyRs1UA4auMUbFg1srv+nzIHPgvP7fflofybVTLTRsCklet1Ngb+ItA0jHscCudBj755qoiTyfNiHlSxXZnhJj2AofGPI0FTExu6Er27Jl6vd15PuYI9UDdN0xj0EKR+AC5bXCmbVtxwv+FzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2/jz515; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2/jz515"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DD51F00A3F;
	Fri, 17 Jul 2026 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298893;
	bh=VXFj4EflelvkOCYtDQxRCItk8ewXVFWEWm93TRO1/yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F2/jz515CVL2jxLBZnhVAolfc/pk+JI8oBqiMti/W3+lJKCNBzZJkNclH9j4EKm7L
	 BBDymOkXv0qOk6pSCl71yEsZckW4pZGujofladeunjNCfMHX78pFjKK3oJ6K/lE7Lr
	 R3IEfzaRKlFkMP0fGy9EMH13PJequCab4tklV18uy0DF35DZGSrVeXqe8lRgV1bjjn
	 8U4AgDkbG8yAvpkN8QlgdrTzfSlT8ViXPCprPN8OpYXQTkQKEXyYkvzu9kDTRlqqMG
	 HarNVCdbfgQ1dciKMIORzmxDge8JbxbSwLY9EB0YzgRaIZJWJHXwtRf30nWIdCYjIn
	 RTv/dLtT903uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] seqlock: Change do_task_stat() to use scoped_seqlock_read()
Date: Fri, 17 Jul 2026 10:34:49 -0400
Message-ID: <20260717143450.1877881-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717143450.1877881-1-sashal@kernel.org>
References: <2026071445-halved-nullify-54b3@gregkh>
 <20260717143450.1877881-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit b76f72bea2c601afec81829ea427fc0d20f83216 ]

To simplify the code and make it more readable.

[peterz: change to new interface]
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Stable-dep-of: 6650527444da ("proc: protect ptrace_may_access() with exec_update_lock (part 1)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/array.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 363d9331216b91..d5cf316f3eb429 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -483,7 +483,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long flags;
 	int exit_code = task->exit_code;
 	struct signal_struct *sig = task->signal;
-	unsigned int seq = 1;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -540,10 +539,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	if (permitted && (!whole || num_threads < 2))
 		wchan = !task_is_running(task);
 
-	do {
-		seq++; /* 2 on the 1st/lockless path, otherwise odd */
-		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
-
+	scoped_seqlock_read (&sig->stats_lock, ss_lock_irqsave) {
 		cmin_flt = sig->cmin_flt;
 		cmaj_flt = sig->cmaj_flt;
 		cutime = sig->cutime;
@@ -565,8 +561,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 			}
 			rcu_read_unlock();
 		}
-	} while (need_seqretry(&sig->stats_lock, seq));
-	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
+	}
 
 	if (whole) {
 		thread_group_cputime_adjusted(task, &utime, &stime);
-- 
2.53.0

