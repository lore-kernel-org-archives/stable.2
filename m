Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49853B14DE
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300413; cv=none; b=N2f1AP/GnIUqjMCy00Ua4NobKnk2ltwEYvZb1UlcK+rUseiyVGHVOGDdzAkqb5F0SYcebDnLU03GxxQ0NcKgRdeh/crDS8VYOhAXHZJ3inE2wL5kaREO8UvoSARC8H0+bDG4G52ydypK8/ROFJPQGmwOlIrFsos5HO0o6AIUY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300413; c=relaxed/simple;
	bh=QevwcSnVi3oLt0BodbNa9KmTOaXaS31oo8aTcRMZrf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6EMMZH7q4/SAoexVgHebh2g+d0HNkFG4raOKgwKBMLnIreReyXF0x4XywTwZwqxHGLIbRb2h9mNGVrCe25J4duMW2SUs1RshcwsnrPHu3/U2LWaVacup+XKKMor//T00aZb0Wy0Za4foswfVACaID9C9bAznv95C9rfefa0oLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVqHeFM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVqHeFM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B601F00A3E;
	Fri, 17 Jul 2026 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300409;
	bh=wYj6F6IYyuNKUd8WSg9JhPK9z69ufcNDyPg31vIgFAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VVqHeFM6q+BkMg92sYaE4PoOAPYKOE6np2tfWQZAt/fg9Sardc62vPF/BxNhgxk0X
	 DgFHtQvLaGZdYunMY4JKd7U3qu50nHcDaONtTeEsq3Ho4dzDbTiJpMpE9llgkAMGC7
	 UrYUvxioK2GbYzoZT5Y6t5i2A9urxH4h/fs8o2pheYWtvAVePLmd3N2RsDoniT2wQB
	 hKzgdxy1qsQC7ugYdk6WYVxEkoEkH10xRHrqbOEt/KSsf/GS7alC5QGBq1tIsMxVKU
	 aZx4oSCSmfirGJfu/pYiNd6GgS3Fh/pl/YSM9ka4MhRRtBwjYgjGONHuLAzoRiI9ew
	 Qo8UzsB/2+HAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] seqlock: Change do_task_stat() to use scoped_seqlock_read()
Date: Fri, 17 Jul 2026 11:00:06 -0400
Message-ID: <20260717150007.1930653-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717150007.1930653-1-sashal@kernel.org>
References: <2026071445-confusion-showing-c025@gregkh>
 <20260717150007.1930653-1-sashal@kernel.org>
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
index a3212f11a1b434..6c54ada35901ea 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -473,7 +473,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long flags;
 	int exit_code = task->exit_code;
 	struct signal_struct *sig = task->signal;
-	unsigned int seq = 1;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -530,10 +529,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
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
@@ -555,8 +551,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
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

