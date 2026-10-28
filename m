Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227828;
	b=R5qbNOukSm/UtKgUu3yyAjBeKDz//TyzuXVXiuBAD1D9EwjobuYBZgvhQWDMbpS96VtJ
	 K0bbgSKTlXB5TSxq3CFiYo6C+fxDMuao22DBX1qpSAY/S3APNiNVvJTMpOThfw0Xof3an
	 lZVCLjpoPM4/zLO0kfROxs+WASkrOFdgtZ+k+8kZkeJUKyRfC9i2Gej5Eu4E3iWxItcCS
	 LPjI2JaW8PwF9ga5bDX2JekY/jHsBauYreuxBwtEjrQmbGAoif2F4nxCTK5Za+qXFffN3
	 6vWpuvoTLfglbq9XU14qyjUBvgkzUbLoX+zByE8mxcYfOker0f/lo8IXfKUmC7ySPWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0d6Qs0FvC4wuXk+s1dtFS35yJ1qNS4dLH/otZy61PIE=;
	b=TaaN2K7jgMImiVwJD5VplI39qyN8bHlYIDG9oZdYetEvb7wwMdz3uJBmPDZwP1C0Yt+J
	 0B/IN7uglPnadyGASALHfBp62yhbZ5WjE1QI2BF3V0IuapS7o8ovJf/vOY0VUEVpamtF4
	 eN9iyPhSOWoUxu1NKI760v1CSTfrZdLoqb16qKjSNwK1lELgIAAP1nmU9sYuGJ7p4c2jY
	 KTXdvjBjrEFiDXoDRwDEoGU0OeN9qdWX5hDb7Kws3U8jiQCTLMTVxE2MK5VwOk+jv5nTW
	 dUwMLX1VafZG3a2LcJ6E1vA/VcZUksEaRh58cOaf4aNWGrdShv7OWG7H/Qh+bDLc5iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGXmRI1N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2C606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGXmRI1N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D541B1F01825;
	Wed, 28 Oct 2026 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793227827;
	bh=0d6Qs0FvC4wuXk+s1dtFS35yJ1qNS4dLH/otZy61PIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZGXmRI1N2Hs+MwyDpdgHzZb+9mQ3cZOKPD3+xJw5NaNaQ4gIkIFR/3UdrR7/jnkAG
	 tAepsFByAmne6OkPjmy3JteaDCq21OAnVt5dMXTBWadEaQwTArV6yntqD80fpHZGHN
	 P28/6OHPRbdun14RmMldqdY2q38ngcLBHIHnCg6oVQ2K393HbqehThUkOq3GeTkbts
	 LsaGcoT9n1JXYtN8ri5BtWcpFg3o+dw5p6U59B7d600O1lQuxyef8Aoagf5JKTl1hX
	 I8gkZWVnRA5fXlSrl7C45uEiJEJXKFkg2AhQofxdxaDj5/UqMlPWx10r9iP7nQmIBJ
	 zNEwPjHdkN8+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
Date: Wed, 28 Oct 2026 18:50:25 -0400
Message-ID: <20261028224958.2405498-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102838-repayment-hyphen-7ccb@gregkh>
References: <2026102838-repayment-hyphen-7ccb@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 22b7f491be8f93ff72de0a3fe02b8ee9e64d3f21 ]

TIF_NOTIFY_SIGNAL is used to kick a task in uninterruptible sleep to
return to userspace and run task work and then go back to sleep. This
mechanism works well but breaks e.g., coredumps. dump_interrupted() only
allows fatal signals to interrupt a coredump and the whole regular write
path going to actual filesystems is impervious to TIF_NOTIFY_SIGNAL as
well.

Add PF_NO_NOTIFY_SIGNAL and helpers to raise and restore it. This is the
same approach as memalloc_nofs_save(). signal_pending() will not report
a fake pending signal via TIF_NOTIFY_SIGNAL if inside a
PF_NO_NOTIFY_SIGNAL section.

No functional changes.

Link: https://patch.msgid.link/20260824-work-tif_notify_signal-v2-1-6609e42b3157@kernel.org
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: Moved PF_NO_NOTIFY_SIGNAL to 0x01000000 because PF_SWAPWRITE occupies 0x00800000. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h        |  1 +
 include/linux/sched/signal.h | 27 +++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c5bd595f560c..52624ff4a1f5e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1564,6 +1564,7 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_NO_NOTIFY_SIGNAL	0x01000000	/* see no_notify_signal_save() */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3a1b4c5118cd2..dd468059ce713 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCHED_SIGNAL_H
 #define _LINUX_SCHED_SIGNAL_H
 
+#include <linux/cleanup.h>
 #include <linux/rculist.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -366,14 +367,36 @@ static inline int task_sigpending(struct task_struct *p)
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }
 
+/* Prevent TIF_NOTIFY_SIGNAL from interrupting this task. */
+static inline unsigned int no_notify_signal_save(void)
+{
+	unsigned int flags = current->flags;
+
+	current->flags |= PF_NO_NOTIFY_SIGNAL;
+	return flags;
+}
+
+/* Restore the previous PF_NO_NOTIFY_SIGNAL state. */
+static inline void no_notify_signal_restore(unsigned int flags)
+{
+	current_restore_flags(flags, PF_NO_NOTIFY_SIGNAL);
+}
+
+DEFINE_LOCK_GUARD_0(no_notify_signal,
+		    _T->flags = no_notify_signal_save(),
+		    no_notify_signal_restore(_T->flags),
+		    unsigned int flags)
+
 static inline int signal_pending(struct task_struct *p)
 {
 	/*
 	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
 	 * behavior in terms of ensuring that we break out of wait loops
-	 * so that notify signal callbacks can be processed.
+	 * so that notify signal callbacks can be processed. Not for a task
+	 * that asked not to be interrupted by it, see no_notify_signal_save().
 	 */
-	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
+	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)) &&
+	    likely(!(READ_ONCE(p->flags) & PF_NO_NOTIFY_SIGNAL)))
 		return 1;
 	return task_sigpending(p);
 }
-- 
2.53.0

