Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA20C415B71
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500220; cv=none; b=Xz9ydHa/xxGfVhQrkn+L2C8lGsHly9B/aqPyuP53TBtBrLVe5Q+bQf+IBr3hAVN62R+fGxQXGMOL4zuZHxNRssTlPCYibeh1mpMxhYABDTmFj4kyPYQBPovHN9VRR/gh0G8WumJtcBfKa1JIU7vQMhLXLxmxuC6M8RBvGZ9bCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500220; c=relaxed/simple;
	bh=CKQBjtLW2OAIZ23M87UUkaixWFnUkORqjMkdRU/cOu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BAdfswZ818elp2DDZMJvvDWjmPX3dx3ra7lSQtF5bGp+kNlNgpu9WFmudDcQeviqxrqEHj6U6QdnH+NijXEzeTlM/43dWC6u1RIqcmC0Ch2kuDt/L+aL3Qop98maazAgLmx5Oy3Kqb3wVbD+OOeuXvdustZSugVx5tSsKG9T5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZXk5hHe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZXk5hHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D831F00A3E;
	Fri,  4 Sep 2026 05:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788500218;
	bh=35oGggnYaL1BYq6dWIq7UbI7mZoQbYF7ydm0fzT6o6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MZXk5hHeotSmPfuikBCGBfbZn/2hNW5E+KEvOuCfKVFiCmnb7m1O0fDDLWHq1v9oP
	 BVbjoC5wgbEZ8Vx8LvQpDmBBLvRIoFKWc7mWDMJfJxNm5B4DBJ8hugb4IXPKtZku/m
	 GbiDMt2kql/8F3UBe0l6kf+Cp85KvTmBF+60ov6nEipBrrEoFav8fXIWS3KxJwQA54
	 k7zOOfPAF4jy6yTE2h1iWCLQ9qTMpbrGfoBvzucIZEMFARxkE4uP/wngBWASaP9E/Y
	 Hraskr5gTQQk4YOqRK6zJmgzfb7/qB4qhrGuKXSJeYVjqL3C3WwTxsRxd5HkbZl6ni
	 cM3G7lIoxNzgg==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, ruanjinjie@huawei.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1.y, 6.6.y, 6.12.y] entry: Fix seccomp bypass after ptrace
 with TSYNC
In-Reply-To: <2026090330-yearling-lemon-2d51@gregkh>
References: <2026090330-yearling-lemon-2d51@gregkh>
Date: Fri, 04 Sep 2026 07:36:55 +0200
Message-ID: <87fqzpa87c.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 4a3591287fb7f808e209b4974ed337f609a2006b upstream.

Sashiko review pointed out the following issue.

If a thread is stopped in syscall_trace_enter() for ptrace, another
thread can install a seccomp filter with SECCOMP_FILTER_FLAG_TSYNC
(e.g., via seccomp_attach_filter()). This will successfully set
SYSCALL_WORK_SECCOMP on the stopped thread, but syscall_trace_enter()
evaluates a cached 'work' variable sampled on entry. Consequently,
the subsequent check for SYSCALL_WORK_SECCOMP misses the newly
assigned flag, and the filter is silently bypassed.

This race condition could allow an unprivileged process to execute
a prohibited system call (e.g., execve) that the newly installed filter
was intended to block, especially since the tracer might have modified
the system call number during the ptrace stop.

Fix this by re-reading the syscall_work flags after ptrace handling,
so that any new SYSCALL_WORK_SECCOMP flag set by another thread via
TSYNC during the ptrace stop is observed before the subsequent
seccomp check.

Fixes: 142781e108b1 ("entry: Provide generic syscall entry functionality")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260629132914.1135C1F000E9@smtp.kernel.org/
Link: https://patch.msgid.link/20260713025712.416366-1-ruanjinjie@huawei.com
---
 kernel/entry/common.c |    3 +++
 1 file changed, 3 insertions(+)
---
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -45,6 +45,9 @@ long syscall_trace_enter(struct pt_regs
 		ret = ptrace_report_syscall_entry(regs);
 		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
+
+		/* ptrace might have changed work flags */
+		work = READ_ONCE(current_thread_info()->syscall_work);
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
