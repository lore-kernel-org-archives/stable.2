Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65782E612E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830585; cv=none; b=JVTNA0vm9A26pExAncyXyfvu1juSW2/YjhFFJ1fmq0M4uNxmnM1iYPDpvkGglrroM7LqBzBhY4LfIYFiZvh+13felr0jqjU6aTJVytdsiC2hmX0ZYydHxoDskiKsbaZ+PY0SQObpfcoM1N1mjm1VAwZ5PUg+opOfFTHYZ9V1cXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830585; c=relaxed/simple;
	bh=J0oAoHe37Sz4FZ+eBfLqRg3gNk5RBhjxH4b7HCi6qMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKFftH3eqjLrhgxvh0f8ALLWqwl5HJp4OuyUfLFjJ4xj0fkCaz0+WJ2hyQuRPnv69BCJA8a/ZwEa+Aeq3Y+edvg9ABv8e3Q46Q/NjyQ3W32xjuQhOejpUW20RWi690GMwc5GOZa6siB7DNUxfaEERdxMDMv2QU1sAv86RadKC5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7g15KTP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7g15KTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BDC1F00A3D;
	Tue,  8 Sep 2026 01:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830574;
	bh=MczkZMnYjOo+Sm6pQ96kLQld78JMD7LDB512h7EMALs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b7g15KTPWYXlyq2j16eyXOyqGUKz2mGHwaGHtQU53AMRPIXly12zULhhlDs80tprn
	 M+jNyN0ofb1Asm5PnzI2DByyt2ZRDZvG8++MhN0XzUHSxsZm1rSPx14aHPJWpLlYj3
	 GK2Ewr533pfNT35oKTlJM02D4TQD79WPaBkFJU845nY5IXHz4sTMg7hVxJFigOCc1X
	 5bwb4dBzhZYq9+v+6dvl5IqJAbVD9TMzCRlRnvRjjmHXOmlEAnHcvFD4MVDxw7sPtO
	 gsKn0Xd+rGMTyUaBs43XeyyqebnONpbe3FpjXaF4C4dAgsTeDy7nKfnEd56G62NJTm
	 xPcsXIsLnXq9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] entry: Clean up header
Date: Mon,  7 Sep 2026 21:22:47 -0400
Message-ID: <20260908012250.1760990-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908012250.1760990-1-sashal@kernel.org>
References: <2026090330-squeak-freehand-d54a@gregkh>
 <20260908012250.1760990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 5204be16790f305febbf331d0ec2cead7978b3c3 ]

Clean up the include ordering, kernel-doc and other trivialities before
making further changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.590338411@linutronix.de
Stable-dep-of: 4a3591287fb7 ("entry: Fix seccomp bypass after ptrace with TSYNC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/entry-common.h     | 5 +++--
 include/linux/irq-entry-common.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 31467bb9deb96..047983310291f 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -3,11 +3,11 @@
 #define __LINUX_ENTRYCOMMON_H
 
 #include <linux/irq-entry-common.h>
+#include <linux/livepatch.h>
 #include <linux/ptrace.h>
+#include <linux/resume_user_mode.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
-#include <linux/livepatch.h>
-#include <linux/resume_user_mode.h>
 
 #include <asm/entry-common.h>
 #include <asm/syscall.h>
@@ -33,6 +33,7 @@
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
 				 ARCH_SYSCALL_WORK_ENTER)
+
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 85b7345375bad..4603f181985be 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -54,6 +54,7 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) {}
 
 /**
  * enter_from_user_mode - Establish state when coming from user mode
+ * @regs:	Pointer to currents pt_regs
  *
  * Syscall/interrupt entry disables interrupts, but user mode is traced as
  * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
@@ -340,6 +341,7 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  * Conditional reschedule with additional sanity checks.
  */
 void raw_irqentry_exit_cond_resched(void);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
-- 
2.53.0

