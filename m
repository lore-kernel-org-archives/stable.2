Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A913EB809
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287126; cv=none; b=XdruJdnet3alx62xDMZE80G9usU5J/oiKjz/UwTyaTpSyvk5jTjhZ1t7BHMsEM2XkkjdANUzst3cYxjY6Ytna3dMbomRw4V7BFu4EGDiWorF9fipO3F/bKxOX8ssuJzhsyjNz1gT4QHbUGC3oYLthnefuv/Iuc7m9pb7CpIUjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287126; c=relaxed/simple;
	bh=qaI73K46iDZopOxNBte2g/geeGE1zZ6VHkYhfn1tXr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZpkaqAU5GQaZh0Rb7xdk/5bQ2qykivUxpI5UKYluagsFKxRgTXWd4u3SjPgUi9/OTyWqpGX5Cv6hNOcJLbCPIuXEBZt60fiHmjDgO+hpK1UtsCjXbRyUF/2rad6d+4i9EMpfLXBFBfyXu0hXhAXeUJlPqHdPtLtY4YbtNWPFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihMnyaMe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihMnyaMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A9D1F00A3A;
	Fri, 17 Jul 2026 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287117;
	bh=3B6lFosyLkjsaebN56yFBLlivX2QQUwrdbXUpG/Nwy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ihMnyaMevsnXK4Yg7UVSRu8h8CihkVD5rr+pBUk3js3Uz8rdjqv1+Az6kA61boAwj
	 jCqEw7fEuB6HV47rRTDYdTGF7Kb7ijZKjDMz2DQ1NgovOZG+CWIWDGUt7r6RDlFkbX
	 3nnyfj1srpWe43dOn1dLedi5G+B3fVgFaKyTpWxZ58Zco6NauW89zc1nWYGolQYiix
	 uxSE3MRZvhI0d7MhHOnMJ04g+mimqM1ptkTYgII2YGoryjaX2wUGRqBQ0uT89qtWCa
	 yvBOdMRADy4xoEBcZw4r7QS8TJ2ncEYHoVrrXqdZOmqbyM3pJiVgsLFK+513dCf82s
	 f0khHiCOcwfFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] seqlock: Change do_task_stat() to use scoped_seqlock_read()
Date: Fri, 17 Jul 2026 07:18:33 -0400
Message-ID: <20260717111835.1574543-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717111835.1574543-1-sashal@kernel.org>
References: <2026071444-fraction-t-shirt-9b49@gregkh>
 <20260717111835.1574543-1-sashal@kernel.org>
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
index 038d4b57127fef..4602a38f85d829 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -481,7 +481,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long flags;
 	int exit_code = task->exit_code;
 	struct signal_struct *sig = task->signal;
-	unsigned int seq = 1;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -538,10 +537,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
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
@@ -563,8 +559,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
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

