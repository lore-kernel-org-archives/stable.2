Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735DA53CA74
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870042; cv=none; b=nY1rW3D4TvW0ZMETSgRiJOfzFrHKmycRt4X1KwCBGv/Hj4k5GRzCa6zEZ7MqmupkA8+OvHeteY8YyPrFJqVDJ6WsNOUWqwMaB9wTUBW/J70iTudoLbiW6nn+fbP5vAjxcy+7z+iyLZrjubX2DmNc4LLj8xIRZtPoBn3O4eWvIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870042; c=relaxed/simple;
	bh=2GRvRdSSRbb/jKR6CIM/2BbYKTLFTecs8w+c3YpU6pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I42yJgqFoU4Kv7kQcOCjnE+0E79/6Di3+aXcmurOBTddwmyU9iPREb0ZeAqB+Pzxl3H+z4eATTLErIdeLQKBIBdKtjXPIuJTGmC7/17bMbvNm9hV9+ZJJz33TKkXKwNiTP9aSoSKNEfFUuPcSjOZtVQXwX12cZ0OLgb7atyFjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B7F1F00ACA;
	Tue,  8 Sep 2026 12:20:35 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] entry: Fix seccomp bypass after ptrace with TSYNC
Date: Tue,  8 Sep 2026 08:20:30 -0400
Message-ID: <20260908122030.2052577-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908122030.2052577-1-sashal@kernel.org>
References: <2026090331-spouse-sprawl-968e@gregkh>
 <20260908122030.2052577-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 4a3591287fb7f808e209b4974ed337f609a2006b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/entry-common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 0f672ee152dfc..a601b3b52009e 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -73,6 +73,9 @@ static __always_inline long syscall_trace_enter(struct pt_regs *regs,
 		if (!arch_ptrace_report_syscall_permit_entry(regs) ||
 		    (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
+
+		/* ptrace might have changed work flags */
+		work = READ_ONCE(current_thread_info()->syscall_work);
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
-- 
2.53.0

