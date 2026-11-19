Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105301;
	b=4IlgRdeIheeT8CPTa8bMqtAKM+du5AHsgJ5ryz6kIPt17lWPctChppX9mg2fH10N8PD6
	 1dKan93NsXbrVQoEgpwgd7tjhe63+0eDJoOtrJvqduQnZjOHaTYPieldOJ+0y8LTEwsSa
	 Ot3doM4ETzJwchukdpnQVyFVBbhF/P8JcMokFgLIFGXlGUwMBTahLhOqul3/h6QOH9Pzu
	 dqiZm0HAPmXALvhhzpPV+3DfDFLOWTERsAi5xSHTUyOsbbd6AuxlF1Jx6sdT9A/IkEvZY
	 Hz/BbS146RG26uZwVibqNT9jrXK0trTjwydtBtsCnNzZ9oaQyPHSilNUngD/QZwIjxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105301;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VF8D/NpkOVfXwYS7vocB3YSAlBjCCPP6hp45RuIin7I=;
	b=L3S831jjd61j/lgYlGtS/+iew9kn370O/KZ+yN6avB5RcQuLur/5QgmXGKPAhFxx/YhJ
	 MVx78pUXno/Etx8RJ3wOjwJRkacPs98VycZp2unY3+rhWY57Zj6/brw8ayi4FcJ7WfSoG
	 lAyD2yi+psBdFRL+sjpeehmujERgIRpZc493rlZbvAJcvDdvv9URbCAhZJ2rsPEPEHfZN
	 MRQUj8qICxXBso1Kj2j1ZGLmg4H1Q8YEqBiT5M2m5iBrHs0fyZKupZILY+VXzcNWF4jbD
	 UyH00wfWvqoLe2y9+RrgybwnyJkF6fFTNhlLFJZ8SvEk9Bow+1ysuAHGwWu63IBnZ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=L+EyDo21;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB1606A324;
	Thu, 19 Nov 2026 16:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDDB1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=L+EyDo21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795105300;
	bh=VF8D/NpkOVfXwYS7vocB3YSAlBjCCPP6hp45RuIin7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+EyDo21HN8fuRQLHIPckTPkRRI8MjBEowAAG998Ptv5eC8uwbv3hmR8uOGdEdNek
	 AdiZClmJ3trdTG5YAZU+nfInz8Ek4jEhMNZc2g2/XK5pHu7FiTSSEtI1i3BHS6d3SS
	 78BenUwrnFkS9bBd9+eEBtFs0hMmYWvo4Jg9hHvCyWu7E1x/6PmhsIcjRKJxbV+Xm/
	 rojoi66FS+xSImksp8Yby+DlzPuvgNc9vMR/rQUiivHxkAiCJXYriwefJKQ5Y09i4O
	 MXUnJjnT0krorcVh1R+Zb0V9pe3mn8FV/bdzv1WAe9ysNNM4rYBoCkv8QO3C8URad3
	 Z99Qry8vpfQig==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVkHm1fPjzSkh;
	Thu, 19 Nov 2026 11:21:40 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 02/17] sched/deadline: Do not admit bandwidth for parameters that are kept
Date: Thu, 19 Nov 2026 11:21:23 -0500
Message-Id: <ab5b150fe61d5db767aa98f1b1255661ad5de333.1795103339.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
References: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
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

__sched_setscheduler() runs the deadline admission test on a request
with SCHED_FLAG_KEEP_PARAMS. But the task keeps its parameters: the
call skips __setscheduler_params().

Commit f4dddf90d58d ("sched: Skip priority checks with
SCHED_FLAG_KEEP_PARAMS") made sys_sched_setattr() copy the task's own
parameters into such a request. Then the priority checks pass.
get_params() copies them without a lock.

Another call can change the task's parameters before
__sched_setscheduler() takes the runqueue lock. The request is then
stale, and dl_param_changed() takes it for a change. sched_dl_overflow()
would put the stale bandwidth in place of the task's own in total_bw,
and in this_bw for a sleeping task. But the task keeps its own dl_bw.
Its release at the 0-lag time takes that dl_bw, and the difference
stays behind.

Fix this by skipping sched_dl_overflow() for SCHED_FLAG_KEEP_PARAMS.
There is nothing to admit for parameters that are kept.

Found by reading, after the Sashiko AI review of this series raised the
boosted case of the previous patch. Not reproduced: the parameter change
must land inside that window.

Fixes: a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/syscalls.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 89b0d5787f45..6f8ce5fd94a1 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -690,8 +690,16 @@ int __sched_setscheduler(struct task_struct *p,
 	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
 	 * is available. Keep this check last. If a later check failed,
 	 * nothing would give back the bandwidth it reserves.
+	 *
+	 * With SCHED_FLAG_KEEP_PARAMS, the task keeps its parameters, so
+	 * there is nothing to admit. Such a call changes other attributes,
+	 * such as the utilization clamps. A deadline task does not use its
+	 * clamps, but keeps them for when it leaves the class. The
+	 * parameters in attr may also be stale: sys_sched_setattr() read
+	 * them from the task without a lock.
 	 */
-	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) &&
+	    (dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
 		retval = -EBUSY;
 		goto unlock;
 	}
-- 
2.47.3

