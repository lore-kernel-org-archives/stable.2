Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBC55C1B3
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874399; cv=none; b=hnT9KVxoSqYcdIxYpdMR1aj8tY7Hy1U+QzpOOpU+hmAIAD5OiFzNSu5FvpDzkrr9b3gp+qOCGZTlEVyiy2y01k1vY3dlPP4dDghENYVs/wrn2lx+i2G4uFOPp/kdL1vQdno8QLYZsDOmgISYM3K+iV5TP/WbXO3VoHQNrNPnsus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874399; c=relaxed/simple;
	bh=VtKukd6CGamzB6rmrmOSlBbKLy5vWSX7Sw7kAgUygn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SM5x5v9EImtRIqqwSdLbhl1E2iLCMPwzsa6ATbaF4HQL5FEFLe/VyzcXFjmi1kvLMibZvDvNwj2YVK8IcZjciytNBvhfbsohul3px4R0VtdOqdGWJGn04YVxSOL4Nzd/fQUXiOyLTl2A2+tJmD1yzRWlTgOBhQ5FZsavLMuu3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435E71F00ACF;
	Tue,  8 Sep 2026 13:32:55 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Borkmann <borkmann@iogearbox.net>,
	Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] bpf: Disable preemption in __bpf_get_stack
Date: Tue,  8 Sep 2026 09:32:51 -0400
Message-ID: <20260908133251.2324526-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908133251.2324526-1-sashal@kernel.org>
References: <2026090326-saturate-wobbling-7457@gregkh>
 <20260908133251.2324526-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <borkmann@iogearbox.net>

[ Upstream commit b1a47b2708d4e95dbd23aee2ec83752190897b3f ]

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

Fixes: c195651e565a ("bpf: add bpf_get_stack helper")
Reported-by: Tao Chen <chen.dylane@linux.dev>
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <borkmann@iogearbox.net>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/20260803210149.296496-11-jolsa@kernel.org

Closes: https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@linux.dev/
[ changed Fixes: commit ]

[ adapted helper-based callchain handling to the older inline implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index fac13cfb32eec..ff5e0fa94bf15 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -438,6 +438,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (sysctl_perf_event_max_stack < max_depth)
 		max_depth = sysctl_perf_event_max_stack;
 
+	preempt_disable();
 	if (trace_in)
 		trace = trace_in;
 	else if (kernel && task)
@@ -445,11 +446,10 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else
 		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
 					   crosstask, false);
-	if (unlikely(!trace))
-		goto err_fault;
-
-	if (trace->nr < skip)
+	if (unlikely(!trace) || trace->nr < skip) {
+		preempt_enable();
 		goto err_fault;
+	}
 
 	trace_nr = trace->nr - skip;
 	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
@@ -462,11 +462,15 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 		for (i = 0; i < trace_nr; i++)
 			id_offs[i].ip = ips[i];
-		stack_map_get_build_id_offset(buf, trace_nr, user);
 	} else {
 		memcpy(buf, ips, copy_len);
 	}
 
+	preempt_enable();
+
+	if (user && user_build_id)
+		stack_map_get_build_id_offset(buf, trace_nr, user);
+
 	if (size > copy_len)
 		memset(buf + copy_len, 0, size - copy_len);
 	return copy_len;
-- 
2.53.0

