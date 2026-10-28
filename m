Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222617;
	b=Ks81hsS57m0iv/eJhvIKSlzJVWaq7v/uOX4SWaHTzjvQYJyZvJHUgGEB7PUvA5Uqbuvn
	 u7V1t2r5JsQ83o2Krs/hAfy+nRZwSUxK7a7GVPTySf9478UfUXG8BrSafzIRE3MGiZTiG
	 1rMDtBXclz4K0MBe+0vhz2Ru/wYwQ/ErowtQIFI/ERPfQXLOslrhuvK89LDdid4xDxo7K
	 0t28xJu5rPLLw+fj8VEShknQJMOKV3BEZSVijaKRhaaxlYQ7Uo2OeQYgAsVs/QN5my0Z0
	 hwrVBMFO6uOq1sfGc68xb3ryxj8oY13ruBEbutVmajtYRex7/dbkARZ5By0/1/vYINA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FQcCz7kORXSYgc7G1jAsRlvMGdpA/Kf4rXJDDVpXV2c=;
	b=4sH05vhUzcTGLngIgx5pbF4S6uRliaddDdANVV1olbZPfHe4B+8srk/RgWhn6x9nj2Fa
	 ElFmMGXnjUgyttGwvdQnckmxAPFsTmOMSc3z6N8wfdtGrSx7/rndjL77g4nCyPf2NMDaL
	 gPywPFEesN0pnSv4LO+dBg6+QtsnygmlaQkdFLHYPnFljOPyYcNGJ3yGEllsgmkHZFHLN
	 IJqzE6p8xma5r+WKZDCvCsG8N+gJdeS+UkZs92onqkHPh5j89kWUm0C1bfLgnBV4zrInq
	 ovfXurK23aADXTahg7GUR11B5mYZlPG3OqJK4z8epahKkD2xnSvpyEVUtVnGAPC8ewQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwByTERy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05348606A330
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwByTERy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FABA1F01829;
	Wed, 28 Oct 2026 21:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793222616;
	bh=FQcCz7kORXSYgc7G1jAsRlvMGdpA/Kf4rXJDDVpXV2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GwByTERyefoOLTDBHbXyoGizKkhiUEVPBunWdakCLEjsgFUYlJyL6BdotSqf6Dpq/
	 z6PH8cHl90kx6Rj9bHxWsW5Bi5dcRrWlIwb0hNdmL91OEdOfP5VXSttsBAFBTLNPS1
	 DgxEibJsM8UaDNCmLn5UrSm5kQ9+GFxJ3tOWNftoWhKhGUCl82/gfSbQMJGnWYEGf3
	 l+CDEnDD7OrivjNOgNJOBYSkxavE/3QtTk5Zh6JAZZuRZEQcQ2rw5uXvZEp6BzePPk
	 d982hxILnK1TY3DMm5/X1jkZKKaHL9YBsLcUKwmA9F4JzCfjPX0CIbulKWqGOeKYjZ
	 SajHcmUXmDG+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
Date: Wed, 28 Oct 2026 17:23:34 -0400
Message-ID: <20261028212317.2257095-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102837-poem-blog-9727@gregkh>
References: <2026102837-poem-blog-9727@gregkh>
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
[ sashal: Assigned PF_NO_NOTIFY_SIGNAL to 0x01000000 instead of 0x00800000 to avoid colliding with PF_SWAPWRITE. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h        |  1 +
 include/linux/sched/signal.h | 27 +++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 561fb81675fa5..523d727d27a70 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1703,6 +1703,7 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_NO_NOTIFY_SIGNAL	0x01000000	/* see no_notify_signal_save() */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 324a3fd0f3c3e..19298445a6ce6 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCHED_SIGNAL_H
 #define _LINUX_SCHED_SIGNAL_H
 
+#include <linux/cleanup.h>
 #include <linux/rculist.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -365,14 +366,36 @@ static inline int task_sigpending(struct task_struct *p)
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

