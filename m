Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4323B62B;
	Sun, 16 Aug 2026 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786887430; cv=none; b=CcXAKcNkltgamjhRHCUnY/gweolgPGS4hWx5yAVjyO+er7GPdrZ28dtteE8ffF/MM62QIuTGyzxD7J5qmGnsXUlINyYeTdjvxuOvfwmE75kYEluRDZ+56Jq2yu8SHK9d2hB4gXqqy4COXVvSoEgcMV/znisM/ei4ZhSnYXKegVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786887430; c=relaxed/simple;
	bh=0z8X7wom4hIo3XWtTWIOxcyhSIIm2cgNyTJsTbuvFzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcW78b6/msnyhLLwMGzoOX7rNejHlaJQTxTdSrclstUbSbV2HPihvt+P85FUlAdhFV9OyClGzrLXejMWgGX6KFQV0dUF/b57E3xPJOwiGVehJSf5iA0a2rg/bmJHJ80mwQ18dSPJXaryyrABgB0yjpoJClAQtE/29G7oa3I9jOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ptr1337.dev; spf=pass smtp.mailfrom=ptr1337.dev; dkim=pass (2048-bit key) header.d=ptr1337.dev header.i=@ptr1337.dev header.b=ThXV3rs1; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ptr1337.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ptr1337.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ptr1337.dev header.i=@ptr1337.dev header.b="ThXV3rs1"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 932A02815B5;
	Sun, 16 Aug 2026 15:31:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ptr1337.dev; s=dkim;
	t=1786887071; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=cY/5/mjQStAGoa5AtH+HsUDyJj6Qqf5cI3Ktzm3zuZY=;
	b=ThXV3rs10J3ToJxfCsYaOcYhiGDjHkVALh2mesPPajDUwX6NGI2tB6hmKDvEe6k9Ls0coS
	DBC5MKv8fkCUKe6nH1UQNtOMFE8gbP8xs3fz5osy/qogS3weXNRGHIVViBf98NKmH1/qvh
	4QXyKWgjK4lCn/omfikLlnlnAIr9cJeCn36I0c80E5v26HhFSzAmkf8gr78m6j1PK1MExp
	rT2oOKhwJHhbHSe8ekWOV+m3S28mI3jRFG7/3LNvS+PPSmzCHVsvuPx26Tm+9RzW0hqmy0
	kZesPSocP9ULqwwfWKyujPWIUEqL4YqVPwkO5lNQfXBJVD2AxmoqbQF/rhsXfw==
From: Peter Jung <admin@ptr1337.dev>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Peter Jung <admin@ptr1337.dev>
Subject: [PATCH 7.1.y] Revert "tracing: perf: Fix stale head for perf syscall tracing"
Date: Sun, 16 Aug 2026 15:31:01 +0200
Message-ID: <20260816133101.83109-1-admin@ptr1337.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This reverts commit be94a3a77e7eb99c53418de7d4a01bc7eb3f634e.

The upstream commit was applied after commit 57918341dd19 ("bpf: Add
sleepable support for classic tracepoint programs"), which moved BPF
program execution before the per-CPU perf event list is checked.

The 7.1.y implementation has not undergone that restructuring. It handles
BPF and perf consumers together, and already reloads the current CPU's
perf event list after syscall_get_data().

As a result, the backport adds an unconditional hlist_empty() return before
bpf_prog_array_valid() is consulted. A syscall trace event can have a valid
BPF program array while the current CPU's perf event list is empty. In that
case the early return prevents the BPF program from running.

This breaks BPF consumers of faultable syscall-enter tracepoints such as
sys_enter_execve. One observed consequence is that Proton VPN's app-based
split tunneling no longer receives exec argument events and therefore
cannot match newly started processes.

Revert the stable backport. The existing head assignment below the removed
block preserves its intended stale-head protection while retaining the
previous BPF-aware handling.

Fixes: be94a3a77e7e ("tracing: perf: Fix stale head for perf syscall tracing")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Peter Jung <admin@ptr1337.dev>
---
 kernel/trace/trace_syscalls.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 8dcedff8429a..8ad72e17d8eb 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1436,11 +1436,6 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 		if (syscall_get_data(sys_data, args, &user_ptr,
 				     &size, user_sizes, &uargs, buf_size) < 0)
 			return;
-
-		/* The above may have caused a migration */
-		head = this_cpu_ptr(sys_data->enter_event->perf_events);
-		if (hlist_empty(head))
-			return;
 	}
 
 	head = this_cpu_ptr(sys_data->enter_event->perf_events);
-- 
2.51.0
