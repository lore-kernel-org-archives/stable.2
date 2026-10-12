Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88C21D00A;
	Mon, 12 Oct 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787985; cv=none; b=VX1m20N2XR/3qrJvYDvK2agOJ8eGVl1XiJvuQvF4UeFcxtyTSPtFkadvKDrUacGaWTOigjdKNWZx0spVMrXWHqWOlWK9sXtaLLNOp2fxzo5ewPmIZnjpO9cG4aVbZ10+1pZqBcsqJ91qCfgD9q6CxE1Jv+5SrXEeS3hKLs/d6P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787985; c=relaxed/simple;
	bh=7RZyCjjqnrrE6A55BJPufD/QzIFgteSIBOnZ4RE4WfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqr5I6RsQqsXFCyP4obL9azQ7M6G6ybRgOy5EM2lhVEaJGDUBujFsk628siQB9fGW2hjmt2bwDQxD09jcfPu/+j/CMfvEoHbWlvS6ezGONkdoxmt9fWykuXhDvTUDVrdD9BEVBKhzwc9UXzMuRPu53yyoJfk5gZER9+pWPrVJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mmal001f; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mmal001f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=An
	C8IT+4dyaxMPdiQgKfS8XtYt9lQbNk/TImwHhWU74=; b=Mmal001ftQhvKao90R
	ZBBRTNFnUag3bs+DohXDKDg8J7lzH+2uhs3O0d4I1lvCHEpznEs5CouoiFzzFNFx
	5d3Ikh8hniKLGhWUU/ZhohtRtDbJ+oFZMB+19TEGLLPMwGo0UXL5BZy4azbaNhyj
	nSvwUkTiMOPgJ/H6tOOl5nT5c=
Received: from localhost (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCHVBVkg8xqDNsKDg--.48626S2;
	Mon, 12 Oct 2026 14:51:17 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	sh_def@163.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: idle: Honor SCX_PICK_IDLE_CORE in CPU selection shortcuts
Date: Mon, 12 Oct 2026 15:51:13 +0900
Message-ID: <20261012065114.3516902-2-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012065114.3516902-1-sh_def@163.com>
References: <20261012065114.3516902-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCHVBVkg8xqDNsKDg--.48626S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw47Cw15JF1xCFWrur48WFg_yoW8Ww45pF
	yYkaya9w4UJF1Fy3y7Jr48C343ur1kuw4agF4rGFsayrW5Kr4FqFyvq3W2qFW5GFn5Zr1f
	uF1vqrnrKa1UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi038rUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6QXHJ2rMg2W2+gAA3A

SCX_PICK_IDLE_CORE requires selecting a CPU whose SMT siblings are all
idle. The restricted select_cpu kfunc path now derives its candidate from
task state, but it does not check that condition before claiming the CPU.

The WAKE_SYNC shortcuts in scx_select_cpu_dfl() can bypass strict-core
selection on SMT systems as well. Skip those shortcuts when
SCX_PICK_IDLE_CORE is requested, and validate restricted candidates against
their idle SMT mask before consuming the idle bit.

Preserve individual-idle selection when the flag is not set and on
non-SMT systems.

Fixes: 683d2d0faba1 ("sched_ext: idle: Introduce scx_bpf_select_cpu_and()")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/ext/idle.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 28ed9e327085..09e40928aef4 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -523,7 +523,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
 	 */
-	if (wake_flags & SCX_WAKE_SYNC) {
+	if ((wake_flags & SCX_WAKE_SYNC) && !(sched_smt_active() && (flags & SCX_PICK_IDLE_CORE))) {
 		int waker_node;
 
 		/*
@@ -976,6 +976,10 @@ static s32 select_cpu_restricted(struct task_struct *p, s32 prev_cpu,
 			return -EBUSY;
 	}
 
+	if ((flags & SCX_PICK_IDLE_CORE) && sched_smt_active() &&
+	    !cpumask_test_cpu(cpu, idle_cpumask(scx_cpu_node_if_enabled(cpu))->smt))
+		return -EBUSY;
+
 	if (!scx_idle_test_and_clear_cpu(cpu))
 		return -EBUSY;
 
-- 
2.55.0

