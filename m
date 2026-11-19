Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105303;
	b=dFfS6YU+volKjmhUnspEp7hdwnRv51caV94ULxlGlR7nr6phk+aa2EEqWztkuAoA1FV5
	 gfAyOhqFwdzRdOmY43nUlbWSHlCo11tVqaBkQkp2m2JOXaxOd4eB5cO/WzMu7JQsPUYEq
	 kbUEpflDR7kTwbTgpXWZHFkJ1GjBquHW5fXPX0zuLZyVOeemDHAIY8L8HrtM4LOtzu+7k
	 AofwCq5f4A4JnvhmKjGyw0HX7Q/zPoRsUKwBsaiSpxebR1xTjdYxuGt98iuFYIb90y3hj
	 j5HlQMH799TqjelMiU3Viz6lsaX63Q34m8IfNu6ePObZMr3/nJbjdmo10t0ENts6F2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105303;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hjTYAqi/gpMkX55Y0igyLpnABuy/mfhM7aTE6x5O19I=;
	b=4u01bcBTsd+PM5Yr085TSfPmpmOd0/cecjdr2qpov1zVFWR1LHhMp5F4T4QRZf0iTcR7
	 FXBqJgUQHNmDONuSUV9P7ZZ/J2OftyhzRsxQDWDDSgwkL8uzgKMuorn4UrNdyQWOgWIoC
	 Qkfao3tcj/bAe1qhJDy2gpKHFl5ixH1+zuwq6Q/Xa7wVzh5QkjyexIEqr0jsg1oLWz7TF
	 G7jjPZXT/d7Op+RSls1bfvNz8n27OkLMKwvPhkEftARt5sDClhWu/xixMfNZXHUTW9yVp
	 KLiJNwphzxgfaMOSelxwlIC3O3lqB31Icm/Ghm6zBfhFAuIIO8wEuHqUIepmQNUfOkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=vQvtDhgR;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8560A261C;
	Thu, 19 Nov 2026 16:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92A8560A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=vQvtDhgR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795105301;
	bh=hjTYAqi/gpMkX55Y0igyLpnABuy/mfhM7aTE6x5O19I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQvtDhgR35+O/7OZugHX8sxfnMYeARv10n4773OhY4dLIcNVYCyaMOwmjwSntVJ1y
	 mskOIp7nSayvMtLiiyqhRems7A9smQCSSAJh8FLlIPWgvC2W6nzZjYEqjaSWeT/TLa
	 dYzDpWJqmoLPIXg2bPGYXs5zyuSp4pfNBKWphVhAh6YCKEBOQ3SSdNrNdOGJFhEctD
	 mwgAkiIftXXEFDTugFele46lknS8icV5wwuWGSNgqMV/s0lFicXXQp+eqUw4ok2YU4
	 6tI9Vj6QRPICLoXqXNqinmclj/MUfTcD3cqFpLTNNd9LJ6jI1+9IELkhJdJfudNh/B
	 mqRHsXyAxs5nQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVkHn2CJBzRqX;
	Thu, 19 Nov 2026 11:21:41 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Weiheng Qiu <weihengqiuu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 12/17] sched/deadline: Reject SCHED_DEADLINE on exited tasks
Date: Thu, 19 Nov 2026 11:21:33 -0500
Message-Id: <fc5726c1bccbe93851a61d8931de98a0d3a4cd3c.1795103339.git.mathieu.desnoyers@efficios.com>
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

From: Juri Lelli <juri.lelli@redhat.com>

sched_setattr(SCHED_DEADLINE) on a zombie task succeeds and charges
total_bw via sched_dl_overflow(), but the task has already done its
final schedule() and will never run again. Nothing releases the reserved
bandwidth. Repeating this fills total_bw to the admission cap, after
which sched_setattr(SCHED_DEADLINE) and CPU offline fail with -EBUSY.

Reject sched_setattr(SCHED_DEADLINE) on exited tasks with -ESRCH.

A task of the class that exited, switched to another policy, runs
switched_from_dl(), which decrements the count of deadline tasks of its
cpuset that cgroup_task_dead() decremented already: at 0 with a deadline
task left in it, the cpuset is skipped by the next rebuild of the root
domains' accounting, and that task's bandwidth with it. Reject that as
well. The deadline_bw_test selftest added later in this series has the
case, death_zombie_switched: on v7.4-rc1 the switch is accepted, and
the one-CPU partition root the zombie ran in admits 9 tasks of 10% after
a rebuild, with a task of 30% still in it, where 6 are due.

Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
Reported-by: Weiheng Qiu <weihengqiuu@gmail.com>
Closes: https://lore.kernel.org/all/3f6e6c87-645b-45fd-8fc6-8da5bc5b82d8@gmail.com/
Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-4-dd761fe005b4@redhat.com/
Cc: stable@vger.kernel.org
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[mathieu: reject a task of the class leaving it too, found by the
 Sashiko AI review of the patch]
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/syscalls.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 9b04e77297ae..b87b878be63f 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -592,6 +592,19 @@ int __sched_setscheduler(struct task_struct *p,
 	if (retval)
 		goto unlock;
 
+	/*
+	 * Reject SCHED_DEADLINE on exited tasks. A zombie will never be
+	 * scheduled again, so sched_dl_overflow() would charge total_bw
+	 * that nothing will ever release. And reject a change of policy of
+	 * one in the class: cgroup_task_dead() took it off the count of
+	 * deadline tasks of its cpuset, which switched_from_dl() would
+	 * decrement a second time.
+	 */
+	if ((dl_policy(policy) || dl_task(p)) && p->exit_state) {
+		retval = -ESRCH;
+		goto unlock;
+	}
+
 	/*
 	 * If not changing anything there's no need to proceed further,
 	 * but store a possible modification of reset_on_fork.
-- 
2.47.3

