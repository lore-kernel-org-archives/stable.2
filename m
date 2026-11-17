Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926989;
	b=lh8ZLKeMdv8d4O9x4lMH8jyITdBYTGafvaW9/7QaVaPj3laObMoOpmHph3blRVEzz/I1
	 SBKmIo6DOHp4HI2xF5SmB2m1X3UQxg/tVBQA95xzMHov813qAuwX9mrgvOqiO8mtsF01o
	 HQbfmpKF29hOPwgr0G1hivtVTMB+M1Xzpygo/uTTmW7xAwKFiulkh7RjXuYCSLpy2niTm
	 exWQad7VCk4OtnFNnrhgg/Lbe3a05uwNWh/7BpV6IYZ5g25BGUjmYcyouUWUD5+V5pTaL
	 3tT8z/MNiHhGdIR1YXLPnMEjt0JF7gCnLEhZRgaaZjF4Q/tg7IHerNtUZDkGb/de4Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926989;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HQU7Zc5/d9vE5Fp6P6RKgPNaKUT8ZRu2XkxGJFG1JBY=;
	b=S0SRXzEK9Vm2mBawbdnvENFRlMkMzocEk7pQkHviSvn7l8cL14BxMkegG5FIAmJic4Ef
	 qD8CF+adL4+WMeNQCDkkG/Rh7bEzgYFYgjis6q+CKQDsjwD4bOCmtROWXOFvRmCJalNsl
	 p8KeurEjVPhS3EF57EdKbQIwsV8tmN7ZKcirrs7FOWzzWNw6yBRsaU6lOUsnF0o6Mkb3c
	 nIN7sZRHSprivhW9UIJS7kUlNe3GyGiNiKRq6zBmNPkgx2PXYngu9MpiSgKoObpGHdM3/
	 r04A90krs0lnYS5UWqcJGck/Rfs9p5PlfkVmS8z4J7r/ONiTXNAazmIjiclnIq2IdgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=SZsUabxG;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D992D606A323;
	Tue, 17 Nov 2026 14:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D992D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=SZsUabxG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794926988;
	bh=HQU7Zc5/d9vE5Fp6P6RKgPNaKUT8ZRu2XkxGJFG1JBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZsUabxGuJOPv6V8cOVFUGneQfTNEJ58JSgGVQl1iAoqr+43t+r/RUB5RcvCwB1Bo
	 j1XcTnWfa4yqiwHVxO6npRxcWU32J72vmmfdb/s4KH1YMeYtlWzgWEyugYz0eUgL97
	 tzwjCNIYljpb3h+8r3mr/SXHP2GqxGirWfKfCuWDvn5z+WD8cJj07CM+zAxNgYVYUt
	 vvcVZ/O8Q9HbdHp7Y91H6cG65NgtN1PZMpPKTLqQdY5B2oSBOFu0ctgTzDkNij4pqD
	 yJ/EtDxnpLBjvzUhvkAcWeot+wuIbDzs9/B2hR41Fxm/mYkAn8/vv1+wi+CCFQFhbA
	 FDJlm//c6dqZA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTSLh0HGFzRZT;
	Tue, 17 Nov 2026 09:49:48 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: juri.lelli@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	luca.abeni@santannapisa.it,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sched/deadline: Fix an overflow of the 0-lag time with long periods
Date: Tue, 17 Nov 2026 09:49:44 -0500
Message-Id: <0863470611fb7fda03d12c4c12cc8e715476d9ae.1794926626.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794926626.git.mathieu.desnoyers@efficios.com>
References: <cover.1794926626.git.mathieu.desnoyers@efficios.com>
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

When a deadline task blocks, task_non_contending() computes its 0-lag
time:

  zerolag_time = deadline - runtime * dl_period / dl_runtime

A task that ran at its reserved bandwidth would use up its runtime left
at that time. Until then, the task still counts in running_bw. A task
that leaves SCHED_DEADLINE also keeps its bandwidth in total_bw until
then. This comes from commit 209a0cbda7a0 ("sched/deadline: Improve the
tracking of active utilization"), which adds the inactive timer of the
GRUB algorithm.

The product runtime * dl_period is computed on 64 bits, then divided as
an s64 by div64_long(). With a period of 4s, it passes S64_MAX once the
runtime left is above 2.3s. The default limit on the period is about
4.2s, so this needs no sysctl change. The quotient is then negative, and
the 0-lag time lands after the deadline.

On 32-bit, div64_long() also truncates dl_runtime to an s32. A
dl_runtime above about 2.1s then gives a wrong 0-lag time too. If root
raises the period limit, a dl_runtime that is a multiple of 2^32 ns
would divide by zero. This was found by reading.

The bandwidth is then released seconds late. Until then, the root domain
refuses deadline tasks that would fit. I tested this in an x86-64 guest
with one CPU. A task took a reservation of 3.1s every 4s, then went back
to SCHED_OTHER at once. A second task that asked for the same
reservation got EBUSY for 5.95s, in 6 tries of 6. That is the deadline
at 4s, plus the 1.95s that the wrapped product adds.

Fix this by multiplying on 128 bits with mul_u64_u64_div_u64().
cputime_adjust() uses the same helper. Its operands are unsigned. So
take the magnitude of the runtime, which is negative after an overrun,
and add or subtract the result. With the fix, the second task got its
reservation at once.

Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f1d259df8f2a..8c0c982810c1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -693,9 +693,20 @@ static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_task)
 
 	WARN_ON(dl_se->dl_non_contending);
 
-	zerolag_time = dl_se->deadline -
-		 div64_long((dl_se->runtime * dl_se->dl_period),
-			dl_se->dl_runtime);
+	/*
+	 * The 0-lag time is the deadline minus the runtime left, scaled by
+	 * dl_period / dl_runtime. The product of the runtime and dl_period
+	 * can overflow s64 with periods of a few seconds, so multiply on 128
+	 * bits. The runtime is negative after an overrun.
+	 */
+	if (dl_se->runtime >= 0)
+		zerolag_time = dl_se->deadline -
+			mul_u64_u64_div_u64(dl_se->runtime, dl_se->dl_period,
+					    dl_se->dl_runtime);
+	else
+		zerolag_time = dl_se->deadline +
+			mul_u64_u64_div_u64(-dl_se->runtime, dl_se->dl_period,
+					    dl_se->dl_runtime);
 
 	/*
 	 * Using relative times instead of the absolute "0-lag time"
-- 
2.47.3

