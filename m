Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D137C10A;
	Sun,  9 Aug 2026 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242738; cv=none; b=mXran7ZCU1zlSLwtiVMK2x9ifveHkjTcJD+UMWU0B3FPt50kveu++0mVPLzbK1GWPhBbP6ghfH/XDH1myy6RxbSbXVymC5z6qZRTNpBWJNVR7rjbLF/NYMD22LCrjjXV73T0Kbp4pol9FywZ/n9jewPqShyEe6pCl752RKLTUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242738; c=relaxed/simple;
	bh=7lujbEOmldkRiLrS41CTuOilo6e/XBJd+Wp/yIsUFyQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GiSkNocfIiS3uEyvj9Glb9UZ8btHtShUTtA45rM645B4oet7ji0gH89eshts+52E5tYMlpVuiUVEDO+7K8eUennrfrwTaQixOGWaH0mpwlkIkLLBIAbf6TkJX/JLTHowj1jIKe1bHQzsFnmz0Sdjy+YY8sbzRz8BhaV1LunyIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2e3LFQG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2e3LFQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9541F00A3E;
	Sun,  9 Aug 2026 02:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242736;
	bh=RsZajquT8PdTHqA0S7T6sbbrTm5qKWASenU4d6SqLAk=;
	h=Date:From:To:Cc:Subject:References;
	b=Q2e3LFQG19dSfuy6kAfEAxyiE6Vu2O8mHOH9xigpsRTgTKoUK4OC7RsPQSiWx75T2
	 DblYojEGTo44Cr0fmfCyV5V+Xe9zIQoAzGwcwWVGCWvGUPjOtdAZkEMxJAe3PnONAb
	 VQ6JFbn63ZlHDw39+2FNsNkgx65hQgyZAkY4zoZvObydSXNRohnGErdpN0zBvz+nKi
	 HX1p0nSelUE83OMvzIaZ60BXGhriCRNl3ByL1eSXW567sxHnYRzPBFCrNVogejgBD3
	 p8vmKlEpeBRdXRC0MWjqb2eLfOiIHdXezDeKNj7tv9LXhsGm+fu1hqiI69T6DJjjHl
	 uV9AIDJUMVPhA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wstKo-00000001N5h-20N7;
	Sat, 08 Aug 2026 22:32:22 -0400
Message-ID: <20260809023222.338674181@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 08 Aug 2026 22:31:51 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Tengda Wu <wutengda@huaweicloud.com>
Subject: [for-linus][PATCH 07/12] ring-buffer: Use current_context for safe per-CPU buffer swap
References: <20260809023144.852271250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tengda Wu <wutengda@huaweicloud.com>

The ring_buffer_swap_cpu() function currently checks the per-CPU
committing counter to determine if a buffer is actively being written to
before performing the swap. However, there exists a race window where
this check can be bypassed:

    ring_buffer_lock_reserve
        cpu_buffer = buffer->buffers[cpu];       // cpu_buffer_a
        rb_reserve_next_event
            rb_start_commit // inc committing
            if (unlikely(READ_ONCE(cpu_buffer->buffer) != buffer)) {...}
            __rb_reserve_next
                rb_move_tail
                    rb_end_commit(cpu_buffer);   // dec committing => 0
                    /* interrupt hits here, successfully swaps! */
                    local_inc(&cpu_buffer->committing);

    ring_buffer_unlock_commit
        cpu_buffer = buffer->buffers[cpu];      // cpu_buffer_b
        rb_commit
            rb_end_commit
            RB_WARN_ON(cpu_buffer, !local_read(&cpu_buffer->committing))
                                                // triggers warning

The committing counter can temporarily drop to 0 during a single write
operation (within rb_move_tail), creating a window where swap can
succeed even though the write is still in progress. This leads to
inconsistent buffer state and triggers the RB_WARN_ON in rb_commit().

Replace the committing counter check with current_context checks, which
are set at the entry of ring_buffer_lock_reserve() and remain valid
throughout the entire write operation, providing a reliable indicator of
buffer busy state during swap.

Cc: stable@vger.kernel.org
Fixes: 4239c38fe0b3 ("ring-buffer: Process commits whenever moving to a new page.")
Link: https://patch.msgid.link/20260803005640.2445666-2-wutengda@huaweicloud.com
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8e2485bb3aa8..58dc8995a88d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6852,7 +6852,7 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 {
 	struct ring_buffer_per_cpu *cpu_buffer_a;
 	struct ring_buffer_per_cpu *cpu_buffer_b;
-	int ret = -EINVAL;
+	int ret = -EBUSY;
 
 	if (!cpumask_test_cpu(cpu, buffer_a->cpumask) ||
 	    !cpumask_test_cpu(cpu, buffer_b->cpumask))
@@ -6893,10 +6893,10 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	atomic_inc(&cpu_buffer_a->record_disabled);
 	atomic_inc(&cpu_buffer_b->record_disabled);
 
-	ret = -EBUSY;
-	if (local_read(&cpu_buffer_a->committing))
+	/* Do not swap if either buffer is in the process of writing */
+	if (cpu_buffer_a->current_context)
 		goto out_dec;
-	if (local_read(&cpu_buffer_b->committing))
+	if (cpu_buffer_b->current_context)
 		goto out_dec;
 
 	/*
-- 
2.53.0


