Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF33F9F46;
	Wed,  5 Aug 2026 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922228; cv=none; b=M/aAl23x8LKk4A9VdVdgg1VjBfOnYC7H+qOPNROLkqGjFD8FophnuBSqdnlEVny/t4GPkewJhAtXiJKpwcZHSbcRAUEtZUOaYyPFPoKF16tf1kVbhM5r55FE04Z6KhzwEabIotSrbOMueWEpNntm4bH2XNe3oqoSUsnjaHieMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922228; c=relaxed/simple;
	bh=xIrBsfxd+4GfMLP8Lshd2UHQZLKHMfYKpNmsTNYPX/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdW/7i29EK2Cq0WPAwULJe31cAYIavAvABHxZtbLCYxNRXDKMxT+UHNdMB6kY7lnC2UfDsIy5Oq5Qdi9qtURXxtPm/fB2ry8dq1FFRh/MAHYmUL/PrQNU3FJbYRA4ZrIJBCegbTACZCr947OJ3cMuuX+8QMQSTp77J/hdmbdjjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhswdTFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhswdTFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021871F00A3A;
	Wed,  5 Aug 2026 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922227;
	bh=S4rfurStD8BbVjYojW5mAZYu3LdwwK5k7Jgz6d+nezQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UhswdTFnwzvZ2AR2KDxp2OVn9T06k7JQq2muXkJJxGGnqa96BMaEsjYuOfqoQAL6N
	 GwEwz3Gp/zCar2rJw22pGBpvlkDg7mBivBhWIQa6QRpDvNS0FCq6PT5UC8mo4CaSmA
	 VcetxftQAyPCHwWN9d96yuhWHiPYWAh2c0Q+Rfd06dWHERg7Mi3toa36WIjgeGXzQ+
	 VVamhv+ls2R0+/VZ4XRZ7rpODMUjsokoDagC5jvknx/sKLVxK1j+MMNTU405lcqqKL
	 MMiOdfdxHHjqxCmy6dmb/NVAUUMqMK1F5BSdcmw8CsKMZmlQe4WymHVdYFU0/BS+gb
	 z7jksA+VNuDDw==
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
Subject: [PATCHv4 bpf-next 10/12] bpf: Disable preemption in __bpf_get_stack
Date: Wed,  5 Aug 2026 11:28:41 +0200
Message-ID: <20260805092843.516315-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805092843.516315-1-jolsa@kernel.org>
References: <20260805092843.516315-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

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
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
[ changed Fixes: commit ]
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index eabeaef31b63..789fe35b893a 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -817,6 +817,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 	if (may_fault)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
+	preempt_disable();
 
 	if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
@@ -828,6 +829,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
 			rcu_read_unlock();
+		preempt_enable();
 		goto err_fault;
 	}
 
@@ -836,6 +838,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	/* trace should not be dereferenced after this point */
 	if (may_fault)
 		rcu_read_unlock();
+	preempt_enable();
 
 	return callchain_finalize(buf, size, trace_nr, elem_size, flags, may_fault);
 
-- 
2.54.0

