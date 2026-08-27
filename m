Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF49477995;
	Thu, 27 Aug 2026 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843365; cv=none; b=XwXIIFS9JZyWKAgrUuBnhc3Mke5OtokBbV52PO2FhEZhtX47sZlWuGRe7psXZxQ5lA6MO24LoKDgecFCx73S1d9VZRLp44CNzrSVRsnta0SFgtYYFQj0YAKKeSFrw1PKoFQ6EK2livtmAd7xhkr0de1IA9umvcXUrZl4vOww/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843365; c=relaxed/simple;
	bh=JPELbtqDwmev8QYHC4CJVOnU1QVGCPg6zDW7t3hN2BI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pO07s3q2HhDihoQOb4sm11/H2Pym8eW+ctYec1nEuzIyqR02DzHBr/YrVDq665dnGIND+6GPUsnZ8iheAVUEEqOtvjil26mI2YucXHC52mr/uMb8UUg2EGs9k8eM2vjKrgG1/8ec7ThoQZvbG//wLmuLgsDDp5euDLuuFXnyzww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2dFF7+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2dFF7+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC9E1F00A3D;
	Thu, 27 Aug 2026 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843363;
	bh=5EI51HQq89GNPsww2hRYcznaJIDs1nehxu0amxKuebQ=;
	h=Date:From:To:Cc:Subject:References;
	b=M2dFF7+2iJR3VaGO+VmUr/x0KYGvHzQJoodyYFFpjxLXMyCGdp9mwSSujt7AcoUAU
	 +oR9HKyUGgBjdFcVlblHEydPKb/UTsspMbXPJKXpK+aOtgrJDN2STTtpfa33G1CSg6
	 hoJX/0dbLdT0tg7uwmcJpv4DdzQobI+0ieNG0cFenzYpYMNZRJgNG7bOF12oOHrH8N
	 pVVPVcOKAs6mAWrO3NongioS+zSjQ3UvmJDd/YEt9OBP4nRZ2ecaiZFqm8RWVq8bn3
	 GhR4Dt6lvJM6YmwVQxkMiIKzsCjVOMDXZjptjJA8BOFn8rpHbc7iGLS2mPuG+GToV7
	 dILqDrtEaJMXA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wzbk3-00000008PF2-0E0v;
	Thu, 27 Aug 2026 11:10:11 -0400
Message-ID: <20260827151010.884247572@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 27 Aug 2026 11:09:51 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Deepanshu Kartikey <kartikey406@gmail.com>,
 Haotian Zhang <vulab@iscas.ac.cn>,
 Hui Su <sh_def@163.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 2/7] tracing: Fix use-after-free with same-name named triggers
References: <20260827150949.304280511@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Hui Su <sh_def@163.com>

When two hist triggers on different events are registered with the same
name=, the second one reuses the first as named_data.  Both are added to
tr->hist_vars by save_hist_vars() during event_hist_trigger_parse(),
because save_hist_vars() is called before event_trigger_register() while
the named reuse is only detected later, in hist_register_trigger().

In the named-data branch hist_register_trigger() then frees the second
histogram's hist_data via destroy_hist_data(), but never removes its
tr->hist_vars list entry, leaving a dangling pointer and leaking the
trace_array reference it holds.

A later hist trigger that references a variable makes find_var_file()
walk tr->hist_vars and dereference the freed hist_data.  The bug is
reproducible from userspace by writing three hist triggers to tracefs:

  cd /sys/kernel/tracing
  echo 'hist:keys=common_pid:x=common_pid:name=mh' > events/sched/sched_switch/trigger
  echo 'hist:keys=common_pid:x=common_pid:name=mh' > events/sched/sched_process_fork/trigger
  echo 'hist:keys=common_pid:vals=$x' > events/sched/sched_process_exit/trigger

The third write panics the kernel:

  BUG: KASAN: slab-use-after-free in find_var_file.part.0+0x272/0x290
  Read of size 8 at addr ffff888001f8a0e0 by task sh/1
  CPU: 1 UID: 0 PID: 1 Comm: sh Tainted: G      D          N
  Call Trace:
    find_var_file.part.0
    find_event_var
    parse_atom
    parse_expr
    __create_val_field
    event_hist_trigger_parse
    trigger_process_regex
    event_trigger_write
    vfs_write
    ksys_write
    do_syscall_64
    entry_SYSCALL_64_after_hwframe
  Allocated by task 1:
    event_hist_trigger_parse
  Freed by task 1:
    hist_register_trigger+0x618/0xa30
    event_hist_trigger_parse
  The buggy address belongs to freed 2048-byte region
  Oops: general protection fault ... RIP: find_var_file.part.0
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Fix by removing the hist_data from tr->hist_vars and releasing the
trace_array reference in the named-data branch of hist_register_trigger()
before freeing the hist_data.

Cc: stable@vger.kernel.org
Fixes: 6f86bdeab633 ("tracing: Fix bad hist from corrupting named_triggers list")
Link: https://patch.msgid.link/20260816100427.33642-3-sh_def@163.com
Signed-off-by: Hui Su <sh_def@163.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 893bd8b0e48a..963e0d6b61fd 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6661,8 +6661,10 @@ static int hist_register_trigger(char *glob,
 		tracing_set_filter_buffering(file->tr, true);
 	}
 
-	if (named_data)
+	if (named_data) {
+		remove_hist_vars(hist_data);
 		destroy_hist_data(hist_data);
+	}
  out:
 	return ret;
 }
-- 
2.53.0


