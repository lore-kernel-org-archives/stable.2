Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90E43E4BB;
	Thu, 13 Aug 2026 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655961; cv=none; b=slET7JDutdwAy8dJzAR9B797RJeBdCsvppU6j9BRGPuZ7/VJiEQS7qc/O8RfZemxng1qXl5VhSqli8FKWAmtqYBkrMfaDS4/lLrHtME5kNGt+D3YWnv+cr2SarowKl3GeSqm2uFKYWUF+ozUqqDu9xP88+RLmOdzqEXbQbYimps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655961; c=relaxed/simple;
	bh=3cUJ2kbgAda/3KuyQsg5scFPZj1YIUFT4vrVWZpCcBc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=B+PqBv6BdaHZhxTrcWtOCsL/8Jh9sLrZs44x7O/NmTswMJjwH9qeBXxqfAlA0WX7LWAhl7FZg3Ks11HuGvQ3IA4C91PAWJOhlCQojPBj+zgyAcCEaiWMmYMLXkUFF3mVjPavRgyKtSBJj0uBk/oh4hhM0fhveBzr/Ep/xR18zas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYYdJvwK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYYdJvwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF43E1F00A3E;
	Thu, 13 Aug 2026 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786655949;
	bh=i+tiIW9fCiXODs9ZRk07BdX+/ESQJtYU52s3f4oUmVY=;
	h=Date:From:To:Cc:Subject:References;
	b=AYYdJvwK3fiTKhE/9OKdtyhpH0duaZiEZs7oF/Dr/74KUWgGzksHl3y3XMfeVI8ob
	 ko0ng9aIdJW25hxV0eJeBD1VXr5QNz+TFAvevBtCJdRzbUZsytSrC1u8UYCFajCWS6
	 7BumFrnkH7O0NtnoqNwgombPVrfx3v08TwFuHlyMul6Qi5uonOBopJu70Uk9k0ZhnS
	 0K1mpVYdQEYt5H36OTN/tIHNAxZbnaAijt0fhu5TJd/jLU0DXybbhdP48hECE87duv
	 vQQgrXtEykIf6Z30DlhYnl/KuQFfnxMBQGC/nU5lwfIZOP2K9Cn1TwxsHlNLuQvUKF
	 0wXW+FqujSJCQ==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wucpi-00000003k9M-3quG;
	Thu, 13 Aug 2026 17:19:26 -0400
Message-ID: <20260813211926.773252765@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 13 Aug 2026 17:19:15 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Michael Wu <michael@allwinnertech.com>
Subject: [for-linus][PATCH 2/2] tracing: Fix race between update_event_fields and,
 event_define_fields
References: <20260813211913.824371874@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Michael Wu <michael@allwinnertech.com>

The following sequence may leads race between event_define_fields()
and update_event_fields():

 CPU0 (loads module A)                      CPU1 (loads module B)
 ===============================            ===============================
 load_module(A)                             load_module(B)
   notifier_call_chain                        notifier_call_chain
     trace_module_notify                        trace_module_notify
       mutex_lock(&event_mutex)                   trace_event_update_all()
         trace_module_add_events(A)                 down_write(&trace_event_sem)
            __register_event(call_A)
              __add_event_to_tracers(call_A)
                event_define_fields(call_A)
                  for each f:                         list_for_each_entry(field,
                    list_add(&f->link,                                    &class->fields, link)
                             &class->fields)            field = class->fields->next;

Where access to the class->fields is not protected by the event_mutex in
trace_event_update_all().

This produces the following panic:
   Unable to handle kernel access ... at virtual address 0000000000000018
   pc : update_event_fields+0xf8/0x368
   Call trace:
    update_event_fields+0xf8/0x368
    trace_event_update_all+0x7c/0x2b4
    trace_module_notify+0x4c/0x1dc
    notifier_call_chain+0x84/0x168
    blocking_notifier_call_chain_robust+0x64/0xd4
    load_module+0x10c8/0x123c
    __arm64_sys_finit_module+0x230/0x31c

Fix by taking event_mutex in trace_event_update_all() before
trace_event_sem.

Cc: stable@vger.kernel.org
Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event types as well")
Link: https://patch.msgid.link/2e5730d2-c631-da41-3a3a-ae35bb4895f3@allwinnertech.com
Signed-off-by: Michael Wu <michael@allwinnertech.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 032f741ba616..3650d84d4f16 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3566,6 +3566,7 @@ void trace_event_update_all(struct trace_eval_map **map, int len)
 	int last_i;
 	int i;
 
+	mutex_lock(&event_mutex);
 	down_write(&trace_event_sem);
 	list_for_each_entry_safe(call, p, &ftrace_events, list) {
 		/* events are usually grouped together with systems */
@@ -3604,6 +3605,7 @@ void trace_event_update_all(struct trace_eval_map **map, int len)
 		cond_resched();
 	}
 	up_write(&trace_event_sem);
+	mutex_unlock(&event_mutex);
 }
 
 static bool event_in_systems(struct trace_event_call *call,
-- 
2.53.0


