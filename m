Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6B4B339F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444870; cv=none; b=dtgR+8MJOQwVqmQBmCknivhmb5fb+nsr/Ad9oYaD5Rz30RKrIbwlJ/w7+i92IUfwOMhzJRsoUoUcjKtOCV4bLq3lJZh4+UCoJEPXK3yQnRw0yqjrsMvbYWbD+Dt0eVyWPG8TAl5Ca8a15lOkn6cRzeJPot+DwisvPJz175pphE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444870; c=relaxed/simple;
	bh=4PgUqsb+Qmsike5QPcbcXe0tqgLW8Bdv+4u7eUR9Yv8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DtbyopF1uGT2oKieBziP6n0X2aQVNkxlrTZFJ58enQ3I9n4MCu0ZI89AMk7ygSzAnk9hFnfesc8h+dhvUUuhQVbYw1bRXFnyVt6O58Yq7G4w4vfFY55E2zmIUq/RRVNNDB4t770k/DDv/z0EO5DeENS7pk6xRNbtqk81Fs1FPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nR/rVBmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nR/rVBmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61281F00A3F;
	Thu,  3 Sep 2026 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444861;
	bh=1JLOj5G7LrkzApbWeejYOiMjSMVmoRSbEDa/O7IPJyE=;
	h=Subject:To:Cc:From:Date;
	b=nR/rVBmkWi0GtBbp95kJDiJKC7jjaEXDmT0LbiFOGf2i+NgzYKfhzqWocEfHK3YSC
	 S9Nltz7njSKC+0nkqxxy4auCrycBpNTHDiLHaVfWs/u66XKCqV2mHrsfnCovqwCJuK
	 iKS46hL4Ebo/46tPobDlLKPfPyTAk5IQJtTfU8Hs=
Subject: FAILED: patch "[PATCH] bpf: Disable preemption in __bpf_get_stack" failed to apply to 5.10-stable tree
To: borkmann@iogearbox.net,andrii@kernel.org,chen.dylane@linux.dev,info@starlabs.sg,jolsa@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:50:34 +0200
Message-ID: <2026090334-blatancy-survey-3de3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b1a47b2708d4e95dbd23aee2ec83752190897b3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090334-blatancy-survey-3de3@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1a47b2708d4e95dbd23aee2ec83752190897b3f Mon Sep 17 00:00:00 2001
From: Daniel Borkmann <borkmann@iogearbox.net>
Date: Mon, 3 Aug 2026 23:01:47 +0200
Subject: [PATCH] bpf: Disable preemption in __bpf_get_stack

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

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 7f728d319a65..121caa90707b 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -815,6 +815,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
+	preempt_disable();
 	if (may_fault)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
 
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
 

