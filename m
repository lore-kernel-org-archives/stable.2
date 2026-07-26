Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C622F1FD7;
	Sun, 26 Jul 2026 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785033328; cv=none; b=WIKHAnYmGqOzI5Fq1P1z0C+wRiyMv85a5yrhGdT9MIQH+1SQLY3U+dYkO10Gw6xOvD4tt9305pYYblidejL34eHhd55FWjo0VlxstUvjLSFebycG1Tq2Fh4yeanFgk4Tk/oB+Ip/FmQLbDuNRWMTMwTyiUeCQ0K8/A0H2iqpYuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785033328; c=relaxed/simple;
	bh=REb1RYhi+Yn1rmmlumWNaH8hVXTrwZ2Qp35ltHgqeVI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WeY284TonMhaB5G8JIrqSCTpnA6ej5GsO/aLtebA60kTIGiqaMHtMZlMLplWBCOUirL+b9iWg025bdtLPlGnbEupSxZHYmz/nwOubgCBvrC8nefO3VcpozDmORbqzSFIhW6cSXg9Aevd3WNjoY9AbWGo735XhjBFAUMJiq/EVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8O2e710; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8O2e710"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BA71F00A3F;
	Sun, 26 Jul 2026 02:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785033326;
	bh=47zt0EKTNUZslwP4KjyNWZDPVBSfqLVOwueSHNPSEP8=;
	h=Date:From:To:Cc:Subject:References;
	b=D8O2e710zXVeLLbmeWtnoNxAsh89M5z5u8JUgvyR4Xwo+5PbaJ2Xgf8m/aNkWR+Rd
	 HZalR37ehTZQ0QJ4sCnT4qAIJAEuikdCQP6oshhxCc1g5vUz/W+Xr5uT9w1MaxyY5l
	 eVPGjgD+0kSc2oUs22BT5pG7h0LlnrE8QKaVpW43H7W1iN2EqpTl8JWh8Yi0/YYA5I
	 F+QwQ2ykXCov30fWi1aGJQh/3SmPdQPwRTjTKnwgkY75inDNsHE7HL4oY4qQgH7wfE
	 yZJ19D0Bc4jsoQUs+hibDU7vrYnt+SDc4uWTpCtAm5L4TD/7BrrY+4QAeQjY0KBDY3
	 ZDHpRZV/cBnoQ==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wnoiZ-00000004c0N-0hAx;
	Sat, 25 Jul 2026 22:35:55 -0400
Message-ID: <20260726023555.021150171@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 25 Jul 2026 22:35:44 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 2/2] tracing: perf: Fix stale head for perf syscall tracing
References: <20260726023542.092577615@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The code that can read the user space parameters of a system call may
enable preemption and migrate. The head of the per CPU perf events list
may be pointing to the wrong CPU event if the code migrates the task.

Reassign the head pointer if the system call event called the code that
may have caused a migration.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260724193210.03fae1d6@gandalf.local.home
Reported-by: Sashiko <>
Link: https://sashiko.dev/#/patchset/20260717173252.3431565-1-usama.arif%40linux.dev
Fixes: edca33a56297d ("tracing: Fix failure to read user space from system call trace events")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e98ee7e1e66f..8a4f3c75e39f 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1451,6 +1451,11 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 		if (syscall_get_data(sys_data, args, &user_ptr,
 				     &size, user_sizes, &uargs, buf_size) < 0)
 			return;
+
+		/* The above may have caused a migration */
+		head = this_cpu_ptr(sys_data->enter_event->perf_events);
+		if (hlist_empty(head))
+			return;
 	}
 
 	/* get the size after alignment with the u32 buffer size field */
-- 
2.53.0


