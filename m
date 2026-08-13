Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF36381B0C;
	Thu, 13 Aug 2026 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655964; cv=none; b=tI9qMvlU0o1MngHFl5iYTn6ZP0Z1dKUim5liDMBBtCMKS2D58wMW8sm2fbb1f+YiBPv6dwj+lsdO5yvDlIHJ53owUjAQ4RbHrd68WqY0XOOIElz24gFYVirJSOFjqiQdFmYclbyKiE5qSUA9EdIPDV7+XDoqFsopufcoF7dCGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655964; c=relaxed/simple;
	bh=drEiQ4Vb5t7drAwrcxOPtTvK5P+J6gBeRJxjCxi1YiQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uvMtMhlh5ow5G6Lb5cY1Y/RTJLvR2A+XntlBH7/gib03vmC2Db05wO2aJXQuHbP88l6S8V2+v772M10VJmbh8i/5YdgLPROwo0/0GkKqLQ8zDcvKwbgriDIK1UDgQqjA4tch4DkYkTwq+fgtIp9Ng5u08ymC7+6F4iCgSCvp9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3cOtecP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3cOtecP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20C21F00A3A;
	Thu, 13 Aug 2026 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786655949;
	bh=7TySX38qpXOkdseJZaIINs0UNHO118jzm0H0b714RJc=;
	h=Date:From:To:Cc:Subject:References;
	b=j3cOtecPiz10ZbLibZYci1buEOAcZ3YbgPR7B9lz9otO+lePyM0CFV9tXgY/CAmnU
	 JTc55cm96sJxgJoWQM6xNUx4DtWwPyldeJ49vGWtMh/IWfJkutosZ+++3G09UWYpch
	 SJns66SrHblRNUUkRIuTrwP1ldB8/fVy6FPz/Lj9OaCXVvBbYDCKDZj4Q3BbkkLUAW
	 CLKwImccGrcgReuGiLbIzxggtd76EbCjbW67m7GvHVVYPa/sGh5u78yxxZKcioz4cj
	 zos2N9byDgmYjMq2ImQFuWm4Nx0b5FnBgQny9fHx5inIDBhNZzEir43bEERKVdNnep
	 X6xNZxYL9pKCw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wucpi-00000003k8s-3AB6;
	Thu, 13 Aug 2026 17:19:26 -0400
Message-ID: <20260813211926.612218140@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 13 Aug 2026 17:19:14 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+4d3143c8e28f6266c636@syzkaller.appspotmail.com,
 Hui Su <sh_def@163.com>
Subject: [for-linus][PATCH 1/2] tracing: Fix NULL pointer dereference in module event cache removal
References: <20260813211913.824371874@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Hui Su <sh_def@163.com>

A module-only event filter such as ":mod:foo" is cached with a NULL
event_mod->match when foo has not been loaded. If a later write tries to
remove a specific match from the same module, remove_cache_mod() passes
the NULL cached match to strcmp(), causing a NULL pointer dereference.

The issue can be reproduced from userspace:

  echo ':mod:trace_events_kunit_missing' > /sys/kernel/tracing/set_event
  echo '!foo_bar:mod:trace_events_kunit_missing' >> /sys/kernel/tracing/set_event

The second write must be a concatenation (">>") to not include O_TRUNC as
that would cause ftrace_clear_events() to clear the cached modules lines.

The crash was reproduced on x86_64 QEMU while KUnit workers contended on
the event tracing path:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  RIP: 0010:strcmp+0x10/0x30
  Call Trace:
   __ftrace_set_clr_event_nolock+0x373/0x4a0
   ftrace_set_clr_event+0xf0/0x180
   ftrace_event_write+0xdf/0x110
   vfs_write+0xf6/0x440
   ksys_write+0x68/0xe0
   do_syscall_64+0xf9/0x540
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Check event_mod->match before comparing it, consistent with the existing
NULL checks for the cached system and event fields. The mismatched removal
continues to return -EINVAL; a broad cached module filter is removed with
"!:mod:<module>".

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260811173902.1927376-2-sh_def@163.com
Fixes: b355247df104 ("tracing: Cache \":mod:\" events for modules not loaded yet")
Reported-by: syzbot+4d3143c8e28f6266c636@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6a7a6b7f.9c11d2ce.289b96.00f8.GAE@google.com/
Signed-off-by: Hui Su <sh_def@163.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c01b10b99f67..032f741ba616 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -945,7 +945,7 @@ static int remove_cache_mod(struct trace_array *tr, const char *mod,
 		if (strcmp(event_mod->module, mod) != 0)
 			continue;
 
-		if (match && strcmp(event_mod->match, match) != 0)
+		if (match && (!event_mod->match || strcmp(event_mod->match, match) != 0))
 			continue;
 
 		if (system &&
-- 
2.53.0


