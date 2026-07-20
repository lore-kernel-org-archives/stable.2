Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CF13CFF6B;
	Mon, 20 Jul 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537727; cv=none; b=kXipmpAF5D0fwhO7F6AXoGpOIUVL7yUdnYi+T6pMfGu+xMVD1kEUG/E5N0aXpvhBp68uRkrjI+cCpSE3XSYVqdq5gMqV6AdXuXxq1H4TVEBzSsfZd7EzwKhOldS7Pz1MQlYK/YfL4cZaf1Z+/RR0B1lLIddRZHfBlyJ9n/vxKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537727; c=relaxed/simple;
	bh=6kDWmnBaOGN9mIgLZxZAGshikUf2cPz7qahnJgxmS2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIEc8OM7JmLrlgokaMmKc/Oz2CibbIFAWxICksg/mFx2JLzudORfvBRvHD9fFDwVDhELo8kneZLgxQ45brS8xFR6DBlh0IAXYw3cG6BN39CdTSs9sdXpTy7BjcVWAp6mlf4dZ0KMePgHBhpGBGvcU3JhqYfaOk13XjP0bgNQHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvrhHfwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvrhHfwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1A61F000E9;
	Mon, 20 Jul 2026 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537726;
	bh=IVvg3iyIecPWVJOKr+bqU7r+J25fao6Gg09Zf2QWVVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FvrhHfwCd5dmJKoeRqAPDyW+zB7L2TkNgY5my9D9drVT2AJ1Xtmr0PAnXk0SszFij
	 iSrNwxMgiiiILx+syzVN38gDiTLc2AbGvUYsfglk7fX231fjLv7tAeftdqNB1swkqE
	 9SaBmbIt6btVHOrQ1LBx3187EUSyp9A1y7UEQ4FPanCeLOhWUuT+TjpeWOdfNRzWEp
	 e6VpjVi1BeL2hRc1N/DaVt9GOa2LFr0DSYmvBJ8BvNkIcmKXojt0xZztTj4xRZowsU
	 HA6OdyW3dwosaNWe5ZDmG3Rr2QKoFLhifaeEl86wwq4SnEEifA3JlB6sG363rwmAax
	 fpAoDirY/nBFg==
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
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 9/9] bpf: Disable preemption in __bpf_get_stack
Date: Mon, 20 Jul 2026 10:53:51 +0200
Message-ID: <20260720085351.655075-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720085351.655075-1-jolsa@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
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

The rcu_read_lock() previously taken here does not prevent this. It is
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
 kernel/bpf/stackmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 57cd4c33403b..37f8e46319b3 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -819,8 +819,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
-	if (may_fault)
-		rcu_read_lock(); /* need RCU for perf's callchain below */
+	preempt_disable();
 
 	if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
@@ -830,16 +829,14 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	if (unlikely(!trace) || trace->nr < skip) {
-		if (may_fault)
-			rcu_read_unlock();
+		preempt_enable();
 		goto err_fault;
 	}
 
 	trace_nr = callchain_store(trace, buf, size, elem_size, flags);
 
 	/* trace should not be dereferenced after this point */
-	if (may_fault)
-		rcu_read_unlock();
+	preempt_enable();
 
 	return callchain_finalize(buf, size, trace_nr, elem_size, user_build_id, user, may_fault);
 
-- 
2.54.0

