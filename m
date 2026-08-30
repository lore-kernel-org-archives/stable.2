Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB01257ACF;
	Sun, 30 Aug 2026 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788051936; cv=none; b=RMn7WCR4nfSy+ZUHKvrSFwfa/0owb4a/Mc/a7GrY05Tpfg9VgZ7RH7deMFxLaQm+p4bkMW3iB3fg0CCK6gA5ZfyzEbtuooz3cg5z00Tyk5mGs92qJdAkDYRCWy8K3BheQyzPmQv6y7SUzpBDH93cCusJbQ4CRM9Z6hlSeibj0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788051936; c=relaxed/simple;
	bh=OQWyxaqu7DKBUM1SGG6Os5vGlC0Ne03Ma6gC/0wHa4g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Et1R4e9pwEqNB/15E/+SJroWAQvwe1DU/wrVNnOYHeEJpyAUBROC5vHGNlZENtfiLkQ01YrcmKphgG+9tdcGD9wcCDElo0gC33Q6MGNPqvpxPCmbMM0OdfofhxUPXfEgUe+85TbYmsyjGFOo56XsxgH9UBm+fsiwZWMtNZWXBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMU0NLJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMU0NLJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54E41F00A3D;
	Sun, 30 Aug 2026 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788051934;
	bh=UYxcBK6fM1KuMpSUtPj8kSRAS7+FWYTJ6/yqMO5ljB4=;
	h=Date:From:To:Cc:Subject:References;
	b=ZMU0NLJmnlx3hNphremnTG+0Amaqr19RtxgrT44wu+OJZUwgzf4tMkksbX/qRWOvm
	 lzbuJzUwufqkyFlBa81ZibegWwIHReOoSL/NB7iwnagFXj3buPCRDwcIdxmMZddd/8
	 39eYuRW8mW4sEn3XoPNs2ui8KmigyrZrDXEV0pkyrjlS5uHhZ6NqnqklNg8kKQfBm2
	 +OoqXHKgwPUsXBLjKZE2S6tDgBNU3HrvgJ7EJkEh2Kbtnrecj5uo/ZPEUEMKBLBK5A
	 ono2NVJbPwM3t1B+eIp3oWkXrHejkZzrr1ezQZfSUTfwkXKQ+7kGarI8mn3RmHtPXl
	 g6hcq/Z1LEtMg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x0U0C-0000000A490-07mR;
	Sat, 29 Aug 2026 21:06:28 -0400
Message-ID: <20260830010627.875981502@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 29 Aug 2026 21:05:32 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org,
 =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 Bradley Morgan <brads@mainlining.org>
Subject: [for-linus][PATCH 1/3] tracing/user_events: Clear copied tracing state before fork
 duplication
References: <20260830010531.847108845@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>

dup_task_struct() copies user_event_mm from the parent into the child,
without grabbing a reference to it. user_event_mm_dup() should
replace it, but it leaves that copied pointer unmodified if
user_event_mm_alloc() fails.

When the child exits, user_event_mm_remove() decrements a reference
the child never owned, which ultimately frees user_event_mm, while
the parent still as a stale pointer to it. This creates a UAF, which
KASAN reports as:

    BUG: KASAN: slab-use-after-free in
    current_user_event_mm+0x51/0x1d0 Write of size 4 at addr
    ffff888005010d30 by task init/44

    Call Trace:
     <TASK>
     kasan_report+0xce/0x100
     kasan_check_range+0x10f/0x1e0
     current_user_event_mm+0x51/0x1d0
     user_events_ioctl+0x82e/0x15c0
     __x64_sys_ioctl+0x139/0x1c0
     do_syscall_64+0xce/0x450
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Allocated by task 44:
     __kasan_kmalloc+0x8f/0xa0
     __kmalloc_cache_noprof+0x180/0x3a0
     user_event_mm_alloc+0x3c/0x1f0
     current_user_event_mm+0x88/0x1d0

    Freed by task 42:
     __kasan_slab_free+0x43/0x70
     kfree+0x13a/0x390
     process_one_work+0x696/0xf90
     worker_thread+0x420/0xba0

The fix simply clears the copied pointer before any possible failure.
In case of failure, the child then has nothing to free.

Cc: stable@vger.kernel.org
Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Link: https://patch.msgid.link/20260827184321.2964601-2-Jeremy.Jean@oss.cyber.gouv.fr
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2bbc89d4a266..93cda2f6f269 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -868,6 +868,9 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 	struct user_event_mm *mm = user_event_mm_alloc(t);
 	struct user_event_enabler *enabler;
 
+	/* On failure, do not free parent's copy */
+	t->user_event_mm = NULL;
+
 	if (!mm)
 		return;
 
-- 
2.53.0


