Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD53E7145;
	Wed, 29 Jul 2026 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314391; cv=none; b=o8We4qi2cFQJGEsUISCp/kdyoe+jz8kWE+uPVvuzWK9YwwMdCtSD93rUl59B/avzLBaPC1UK0I5qC4y7FSkWBVoXh43hzZqOIZzC9ddCsTxJD0oXf0ss3Qmv5aA/pyuHOQ1XsozW4i/nNQc91sO2mTTEaK4P6B9Sco0g+Fpvd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314391; c=relaxed/simple;
	bh=GUzSoFaKz5DMVCWuwVcFwOo+QdbAuDd5B/SZRt3XeKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5f7qdT3N0Xbp/0TSqAGd9VjDYQirHVgnVLIITvN9YUtK8vqPgyaIYKMaj1wObXKw8g4vJvW8l1kqGeNc6z6ep5ChstLM5Lxxchx5GL33vSLvh4htnvmKFCgvG710PNnOwm4tb7OAyeflR7f8KIsJz9H3f8LQIH1oMzsK16CQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aChbaZEX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aChbaZEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8141F000E9;
	Wed, 29 Jul 2026 08:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314389;
	bh=cTkdOFU+9thCF8abUe4ScDrwFUe6cCFgBFE87DzMCY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aChbaZEXcvZPLJz+8LIFkjnmkXs4qrkAH0ujz42OprAAVN6UIatJ0lbZJ/T6hLsNr
	 UiL13LJW0u1UDc68W0Ad60vD3vbjZaNbgiBHC+WHEdIv/BQ+yO3jETp7MfW+u9yUXS
	 fPodOhI1RJXcSpvNMMa7/J30svjZyO+72r+qE7iLFgFRrqNhUcpNQ0zyjIdcKmmAWL
	 PYwKoAI5v6kUodPdetc2NgoQsNtq9JhJJPkytDOyoSMs+zgOSMFUKafw8gzLv5/ULt
	 HDtMe8Ek9kiF3qWKpmRen2WSd8rEDQQCcwNiEZN94FUGfJg1/PCSZ7Sv6mmh8i0hwb
	 zXGSU6TPhjYuQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCHv2 bpf-next 10/11] bpf: Disable preemption in __bpf_get_stack
Date: Wed, 29 Jul 2026 10:38:06 +0200
Message-ID: <20260729083807.1588544-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729083807.1588544-1-jolsa@kernel.org>
References: <20260729083807.1588544-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <borkmann@iogearbox.net>

get_perf_callchain() returns a per-CPU perf_callchain_entry buffer and
releases its recursion slot via put_callchain_entry() before returning,
so nothing keeps the entry reserved while __bpf_get_stack() consumes
it below.

A preemptible BPF program (e.g. a non-sleepable raw tracepoint program
on a PREEMPT kernel, which runs under migrate_disable() but not
preempt_disable()) can be scheduled out between obtaining the entry
and the copy. Another task scheduled on the same CPU then reuses the
same per-CPU buffer and overwrites trace->nr with a larger value.
copy_len is then computed from the inflated trace->nr and can exceed
the caller's buffer, causing an out-of-bounds write in the memcpy()
and in the build_id path.

The rcu_read_lock() taken here alone does not prevent this. It is
only taken on the may_fault path, and under CONFIG_PREEMPT_RCU it does
not disable preemption; it merely keeps perf's callchain buffer array
alive (freed via call_rcu()) and does nothing to stop another task
from reusing the entry.

Disable preemption around obtaining the callchain entry and copying
it into the caller's buffer, so the entry cannot be reused underneath
us and trace->nr stays bounded by max_depth. Build ID resolution may
fault and is therefore deferred until after preemption is re-enabled;
by then the instruction pointers have already been copied into buf,
so it operates only on that private copy. Note, preempt_disable() also
subsumes the buffer-lifetime guarantee the rcu_read_lock() provided,
since a preempt-disabled section is an RCU read-side critical section
for the callchain buffers' call_rcu() reclaim.

Cc: stable@vger.kernel.org
Fixes: c195651e565a ("bpf: add bpf_get_stack helper")
Reported-by: Tao Chen <chen.dylane@linux.dev>
Closes: https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@linux.dev/
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <borkmann@iogearbox.net>
[ changed Fixes: commit ]
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index bdf48a7ad2e8..f4827afbfed9 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -820,6 +820,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 	if (may_fault)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
+	preempt_disable();
 
 	if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
@@ -831,6 +832,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
 			rcu_read_unlock();
+		preempt_enable();
 		goto err_fault;
 	}
 
@@ -839,6 +841,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	/* trace should not be dereferenced after this point */
 	if (may_fault)
 		rcu_read_unlock();
+	preempt_enable();
 
 	return callchain_finalize(buf, size, trace_nr, elem_size, user_build_id, user, may_fault);
 
-- 
2.54.0

