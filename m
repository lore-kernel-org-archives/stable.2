Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497784B1499
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444309; cv=none; b=gM+TyRAVF1TaiJga13cIzHwIkdlonZsCuLJTytwZZLV6PqN/lQN6s0x+wzrB+QshCubldRw+S6ZTSvmCd0jdOmrXFe2NlysRDls2W2ZBe/6WnBODLCbKsxkmM7NUL4XAj2rx3OQ6DCICgUPhBa7a3TSveSbv8g6BrrShRk4Xvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444309; c=relaxed/simple;
	bh=dFyFphtKe6jjeRIiOziV5+u3ASK5HZZ68r6RKgsLx2k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a9QNSyCvFw4HHRFt4DCor/W+2QyhbfhkJk17dcNETFUSCTJRDW7qrZaPo70N/nXXnlDi2KAMIC0M56zk2RplO9DYozsLaoE6jacp2RaMDPboDwQnMuoxus+o5QKynpnz6390DMS/8Z8CfCRE96+uF+3DUglQosJcEKIUEABqJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wHTXlK2a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wHTXlK2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C501F00A3D;
	Thu,  3 Sep 2026 14:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444298;
	bh=9SCPG0L67pNHuRT3jXczFN1Y+FsRWHT1qZVpqtjFh0o=;
	h=Subject:To:Cc:From:Date;
	b=wHTXlK2ahh+n9Gxwo7QG5a7XiuwMYlozVfgCpCso5eDcqsnLw7Rej8ZLjMsIO5pmc
	 m4JAb/x1wgNmRQmlS8fZzOA3/Dz9XPSO3EVGR69EcO73lhQJMDtXIGqbfy5tLj5DKt
	 8VEo5bPXEY/yuaRkkdwV26vyoYP6H1RQ76pCLmcw=
Subject: FAILED: patch "[PATCH] entry: Fix seccomp bypass after ptrace with TSYNC" failed to apply to 6.1-stable tree
To: ruanjinjie@huawei.com,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:40:31 +0200
Message-ID: <2026090331-spouse-sprawl-968e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4a3591287fb7f808e209b4974ed337f609a2006b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090331-spouse-sprawl-968e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4a3591287fb7f808e209b4974ed337f609a2006b Mon Sep 17 00:00:00 2001
From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Mon, 13 Jul 2026 10:57:12 +0800
Subject: [PATCH] entry: Fix seccomp bypass after ptrace with TSYNC

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

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 07d97def7dcb..299f13c78a6f 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -97,6 +97,9 @@ static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned l
 		if (!arch_ptrace_report_syscall_permit_entry(regs) ||
 		    (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
+
+		/* ptrace might have changed work flags */
+		work = READ_ONCE(current_thread_info()->syscall_work);
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */

