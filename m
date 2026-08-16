Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C4331A63;
	Sun, 16 Aug 2026 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786874964; cv=none; b=PeOZw1LlxG/oBzQAh99AWJJ7QW24hO1QNOtmvVIHzWasqrGtB0gcRzU7DOpuwhsjCseEFnVTFul1yeFP/rBZKZgOonLy2b8TPrPwAXmQHwtB23L9aAhCfR4OMh/izD1p4YkmDNfxW9+Lx+HO5DyZnHxBf4slUcdx243Gxj2ycHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786874964; c=relaxed/simple;
	bh=/mKAOxenTlVLV/NSiPNXhb+L3reSdCcDy8WrDgp0700=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqPIkUWuw/8okN9JdQDyojwjdR+++pQFxDIFAk9rp3gxJrLRneNnLcJMEoBRa0AGVDKK0GzDeU8Om0b49TH3LSNHGALWlDrsVkgmMu5aRlGqZV0D8FvkHhogwVBZCQLy1k93AZRGz/3yf72aHBJRLDw5Ad+wmzMJBJUbwunsXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QjVI20Fr; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QjVI20Fr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3k
	j3CWKVoqanhjaDiOQkFlbZwGd/reF0lfRSEGgryzY=; b=QjVI20FrC+RSFqFjn8
	y9aP891HD10WM9ugroKcbvgIrFU9CDUwB97s1G1o4MP47lKU/Vvm/ijPNoS5h9sC
	eWWnh8+kmkHtMDDdZLupqUDVf9BlMFLQtOhY4lDaftyizo7KNQUg4SUyNBU2ORiV
	5tVxM8Kf/HlVmjFU6DB7+dNac=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnV8cHjIFqSc7HPQ--.53482S2;
	Sun, 16 Aug 2026 18:08:08 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tracing/histograms: Fix use-after-free with same-name named triggers
Date: Sun, 16 Aug 2026 18:04:29 +0800
Message-ID: <20260816100427.33642-3-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnV8cHjIFqSc7HPQ--.53482S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw43CF48CF47ZFWfWF4DJwb_yoW5Ar4fpF
	WFgr13Kr48tr42vF4xuF48u347CrW8JrZrWF4UCw13t3s8Wr10gFZFgay7Z3WrtF48WrZ8
	KF4jgrWjgrW7XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQ0eLUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6Qggf2qBjAgMNwAA3q

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

  echo 'hist:keys=common_pid:x=common_pid:name=mh' > \
      /sys/kernel/tracing/events/sched/sched_switch/trigger
  echo 'hist:keys=common_pid:x=common_pid:name=mh' > \
      /sys/kernel/tracing/events/sched/sched_process_fork/trigger
  echo 'hist:keys=common_pid:vals=$x' > \
      /sys/kernel/tracing/events/sched/sched_process_exit/trigger

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

Fixes: 6f86bdeab633 ("tracing: Fix bad hist from corrupting named_triggers list")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/trace/trace_events_hist.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 58d28cd1afa3..6bf00710fd10 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6641,8 +6641,10 @@ static int hist_register_trigger(char *glob,
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
2.54.0

