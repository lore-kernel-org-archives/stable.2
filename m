Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35C41BA92
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296830; cv=none; b=ljBvzGlgEbzUjfWNJ/vS3OlzNRQ3E5gD7QiYFe2+zhSMiao+shQBI4oJ0hGZJ/ETbzTd7EDSA0nR7Kg9JJNz/pwvk1UQ9DiNQApWpa2RJmsLgCPE5XipQ6QRDQo/X5vTHaJqwEN6QIqmDfNkkaIwZvimp9QoPlIVWbtgHCoTh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296830; c=relaxed/simple;
	bh=Hx48YZ/dNHthp7/RsrnwCe7TKff5OwUCsoMruaDY6OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Etu8rNyyYEN0I0ATrqzUAwlHFb36TtY78Na2chb3YgImg6xhhaSy6LprcW9KYSEHQjioj/j1Q/RFC2tdl83XvPpadI9QPFYy3aUlN+rgaM9Xs3v6+HQ8YT3/uqEd9uwq6DPxqJGMgJ66wrQf4x43iVqQa/VNs8obH7SMG2JVWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn1S6tZ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn1S6tZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD781F00A3D;
	Fri, 17 Jul 2026 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784296828;
	bh=VXFj4EflelvkOCYtDQxRCItk8ewXVFWEWm93TRO1/yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hn1S6tZ3uF7aMSPQPohr/MB/+5etyHYNGH2PE7BPHsRvX3mlUs4jgKdUTUYxki8Q2
	 hG32i9vkKNxe9bpjekBtHxh3XVN99VZvKf1fsdJRpsNF3EtqhMV770m4X9ays8jLf5
	 NIxDIr72asZIMWuMFjj3aZzU19/+rRfqqykLRGIzxIu9utamtNCP071NAT+qA0FEPy
	 zeTm2YNCm1TkCUpW1bUPJiGEeaKAKT5A08z0VD95C7U2Aow6mQ4uEY4bts7i6GScFE
	 AdDJejCWCGauv7WZMlMr6oNGXamIRgVNDkJbeYrm9pqEi9Em6a0tebD5tY5WTplFt0
	 LJ9ArI2PBXN8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] seqlock: Change do_task_stat() to use scoped_seqlock_read()
Date: Fri, 17 Jul 2026 10:00:24 -0400
Message-ID: <20260717140025.1717514-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717140025.1717514-1-sashal@kernel.org>
References: <2026071445-sadden-utmost-ad28@gregkh>
 <20260717140025.1717514-1-sashal@kernel.org>
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

