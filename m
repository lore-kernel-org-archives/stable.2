Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F92449B05
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241725; cv=none; b=JGxCCc/Q9AVQtvolT6ks9aB7vUmcHOlxIYULBCx42aRwuOsKFGVV+SFaOZTVc8ns9s2pGcGCHJEqNFcKIbMs8mDVeu+IKC1TtDU0ePSfUmXemTjztAVNqI2bJdEzs33E+CGDlh1RlejYqxdRMjLCX25gRevdj55SeGnGQOJAqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241725; c=relaxed/simple;
	bh=fshvWfpZGmu6OxU4jA/4vo4ZS+70//Gu/JiFujJoev4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLg97vQLpoNFsPQsom9W/AhdLpwaXhf0dDgoXlD31Z/zOBnMpT2wnQnNhW35R8NOzjQvh/mIXlTlBRNFIqraglh5oz7yB08sy77d6yyn19qLnfEvDwZLah43G/FeZUTlSZQH4+JLT29YFfTDyQY4Qk5++ShkHjoQJaluFSPmYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rH1lSRyI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rH1lSRyI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so9381155e9.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790241720; x=1790846520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3i4XwsbTztFzn8Zx6bLGOqiaI42zayiDsFTcP+jZwAo=;
        b=rH1lSRyIOraJK2AgSqW52qL48bUgwfHYeoxrky6PV/bQs3awQ3Hjgbe+rRjbICktSL
         6DaDSwHTADxDLYG0icr8I9x98mpSbuCvsrGjBDvsfdK7VUNFEa3Y3wA3W1pmDokbZL/q
         mI89KfuMroCCR2uKzs3g79Yvutt6D9mwlE0IuJ9vHHD/DoRVQ/G30BIJ9RuCqbBmNt7L
         sIoP5UF/EFN7ePToMGJbjHPCVrxAYEclhZLiMZkXirl1oCygKCqQaZLVVQ9Ehem7AQIs
         qQ6IIbOZNiEVOeH1ozYeBPDwCKJvG8dN4MWuE2kihuSqy7dA15Ym5VdP4+dJaKNOWew3
         6eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790241720; x=1790846520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3i4XwsbTztFzn8Zx6bLGOqiaI42zayiDsFTcP+jZwAo=;
        b=W4ChPBIp/brEx2iTtsDT8vYxZUvdbM5Jns9sTG2VtfU06Y9H8H8oUtc37pqxoNrU4F
         Rq4DIwkGuUq3G1okfYDJ9ftrOhp6FQSnDD1Djxd6pt/DQD/og03CVixkaq1lKki9D9u2
         nPmXRCgbqwzc1zH6E+jyuDRNIkZs6Vn7lkIuAtTqTYSQmbEYFUzi2WCz04A0Mxrm+s7F
         t795tqfFasTipzUT8n0PXLhfuDonwcfccCMtAPecWT9msXwUOcZ0M1OBu6ZPeN86Sns/
         MkPbORZTaHaNIIIU6Xo167blERqJRqvtqC0VCdljcAE+kBEooZEcCPiJ+8M3S7kWFzxb
         O/cA==
X-Forwarded-Encrypted: i=1; AKwUvBzewCXLOdholWaeEmLvHcGM85R70e2okoM6keccWjXLlSCKAI/r+lyiOJ50VHzlmaa8ZS3sGgY=@vger.kernel.org
X-Gm-Message-State: AFuF++klMTgdZ9lL8RDXdgM8N/WtXDFkXzW4azPGlx5O9OSjKtgU086R
	stxYviMSJaGG+YnUcnvMBqN3WNtgxxlckcSVVMskE3LI/f7TUxu5tsLH
X-Gm-Gg: AYBFou22aTJl9VKEyNX0j707OqultVMtOoP4yyCWnWi17T+aU37cSj96dKF/+FRp1zd
	h9dhN5VBdd7HrjCCZlthku5iG4JVTQDjDOB+uG/rXb+/dWP0w6NpwOqcn9kaxfJFughskgjd6pM
	u58AggT1eVg5/xvjGj040dB5sGDW165pX39hjbdOXRtHsPTrIT9iyTjOV3hmy55Q6eXZMFKcbzc
	8bcaLg6Et9gwS4oKlBzJILsZSULP+5peo1z2hZ3c+9Cencpv7OjLeecN89mWCuP4X5yiKjPrQ0i
	ZY74cnst7VjbP1Mhfqwe8P9nNW/Kz0ianQ7VxuZzAL0bW4fpS7gwspF/rsYdfCAc3GSKam7Odwq
	fCzXfF8dtxPD3zgNJSN83jMFqqxSNDxWm+HK6atuJVykfJM2AvYZlxkWl5tr+rQtQQDgMHtq4Gu
	cD3K9fTrEPGFULjHQlyztiRM5FSM+0Ch9gk79SQbrXV3Pkm3Ki7A6Q60nk+pSbTkhYty0hr2CQ0
	2nMZdHAZWi/16CN2Zkf/73CkVV8VbDQjqfZqu/zRMbKE6y4LMztUrw9v0ntVEkdaSROEn5sUF5a
	Vu7f
X-Received: by 2002:a05:600c:8b4c:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-49fe66eb0f0mr29202135e9.19.1790241720298;
        Thu, 24 Sep 2026 02:22:00 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c3731fsm116682435e9.2.2026.09.24.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:21:58 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kprobes: Fix permanent hang when flushing the kprobe optimizer
Date: Thu, 24 Sep 2026 11:21:39 +0200
Message-ID: <20260924092142.199198-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing 0 to /proc/sys/debug/kprobes-optimization while a kprobe is
jump-optimized never returns. The writer sleeps in D state forever with
kprobe_sysctl_mutex held, so any later read or write of that sysctl
hangs as well. For example, with vfs_read+9 as an optimizable address
in this build:

  # cd /sys/kernel/tracing
  # echo 'p:myprobe vfs_read+9' >> kprobe_events
  # echo 1 > events/kprobes/myprobe/enable
  # # wait until /sys/kernel/debug/kprobes/list shows [OPTIMIZED]
  # echo 0 > /proc/sys/debug/kprobes-optimization

  INFO: task sh:246 blocked for more than 10 seconds.
  Call Trace:
   <TASK>
   __schedule+0x1176/0x4f70
   schedule+0xdc/0x2c0
   schedule_timeout+0x17b/0x260
   wait_for_completion+0x173/0x3c0
   wait_for_kprobe_optimizer_locked+0xbc/0x130
   proc_kprobes_optimization_handler+0x156/0x1b0
   proc_sys_call_handler+0x324/0x490
   vfs_write+0x52d/0xfe0
   ksys_write+0xff/0x200
   do_syscall_64+0x106/0x630
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>
  ...
  INFO: task cat:265 is blocked on a mutex likely owned by task sh:246.

wait_for_kprobe_optimizer_locked() reinitializes optimizer_completion,
asks the optimizer thread to flush and sleeps in wait_for_completion().
The thread drains the (un)optimizing lists, but calls complete() only
if completion_done() is true, i.e. if the completion is already done,
which never happens while someone waits. disarm_all_kprobes() and
kprobe_trace_self_tests_init() wait the same way.

Calling complete() unconditionally would not be enough: the waiter
drops kprobe_mutex while it sleeps, and nothing else serializes the
sysctl handler against the debugfs "enabled" file. A second flusher
that still finds the lists non-empty, e.g. because a disabled probe is
queued for unoptimizing, reinitializes the completion under the first:

  sysctl write                      debugfs "enabled" write
  unoptimize_all_kprobes()
    wait_for_kprobe_optimizer_locked()
      init_completion(c)
      mutex_unlock(&kprobe_mutex)
      wait_for_completion(c)
                                    disarm_all_kprobes()
                                      wait_for_kprobe_optimizer_locked()
                                        init_completion(c)
                                          // c->wait is reset, the first
                                          // waiter is off the queue
                                        mutex_unlock(&kprobe_mutex)
                                        wait_for_completion(c)
  kprobe_optimizer()
    complete(c)
      // wakes the debugfs writer only

where c is &optimizer_completion. Lining up the two writes during an
optimizer pass loses the sysctl writer this way.

Replace the completion with a counter of optimizer passes, bumped at the
end of each pass and signalled with wake_up_var_locked(), both under
kprobe_mutex. A flusher samples the count and waits with
wait_var_event_mutex(), which drops kprobe_mutex only while sleeping, so
a new count means a whole pass ran in the meantime. Nothing is
reinitialized, so several flushers can sleep in the wait at once.

Fixes: 73c12f209462 ("kprobes: Use dedicated kthread for kprobe optimizer")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
This overlaps with two patches under discussion in the "rcu-tasks: build
Tasks RCU on Tasks Trace readers in trampolines" thread:

 - Masami's RFC "kprobes: Make optprobe optimizer multi-generational and
   asynchronous" [1] rewrites the same code.  It drops the
   completion_done() check, which fixes the hang reported here, but it
   keeps init_completion() in wait_for_kprobe_optimizer_locked(), so the
   concurrent-flusher case described above remains.  The two patches
   conflict textually.

 - Josef's "kprobes: Expose the optprobe jump window to Tasks RCU" [2]
   changes kprobe_optimizer() around synchronize_rcu_tasks(); its
   kernel/kprobes.c hunks still apply on top of this patch.

[1] https://lore.kernel.org/all/179017148080.466588.9116221556625712980.stgit@devnote2/
[2] https://lore.kernel.org/all/20260922-b4-rcu-tasks-preempt-qs-v5-3-410f57770bad@toxicpanda.com/

 kernel/kprobes.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6337da5cab9e7..4edd8ca5c6578 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -42,6 +42,7 @@
 #include <linux/execmem.h>
 #include <linux/cleanup.h>
 #include <linux/wait.h>
+#include <linux/wait_bit.h>
 
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -526,7 +527,8 @@ enum {
 	OPTIMIZER_ST_FLUSHING = 2,
 };
 
-static DECLARE_COMPLETION(optimizer_completion);
+/* Bumped at the end of each kprobe_optimizer() pass, under 'kprobe_mutex' */
+static unsigned long optimizer_passes;
 
 #define OPTIMIZE_DELAY 5
 
@@ -654,9 +656,9 @@ static void kprobe_optimizer(void)
 		do_free_cleaned_kprobes();
 	}
 
-	/* Step 5: Kick optimizer again if needed. But if there is a flush requested, */
-	if (completion_done(&optimizer_completion))
-		complete(&optimizer_completion);
+	/* Step 5: Wake up flushers, and kick optimizer again if needed. */
+	optimizer_passes++;
+	wake_up_var_locked(&optimizer_passes, &kprobe_mutex);
 
 	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
 		kick_kprobe_optimizer();	/*normal kick*/
@@ -708,7 +710,8 @@ static void wait_for_kprobe_optimizer_locked(void)
 	lockdep_assert_held(&kprobe_mutex);
 
 	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
-		init_completion(&optimizer_completion);
+		unsigned long passes = optimizer_passes;
+
 		/*
 		 * Set state to OPTIMIZER_ST_FLUSHING and wake up the thread if it's
 		 * idle. If it's already kicked, it will see the state change.
@@ -717,9 +720,12 @@ static void wait_for_kprobe_optimizer_locked(void)
 			OPTIMIZER_ST_FLUSHING) != OPTIMIZER_ST_FLUSHING)
 			wake_up(&kprobe_optimizer_wait);
 
-		mutex_unlock(&kprobe_mutex);
-		wait_for_completion(&optimizer_completion);
-		mutex_lock(&kprobe_mutex);
+		/*
+		 * kprobe_optimizer() holds 'kprobe_mutex' for a whole pass, which
+		 * this drops while sleeping, so a new count means a full pass ran.
+		 */
+		wait_var_event_mutex(&optimizer_passes,
+				     optimizer_passes != passes, &kprobe_mutex);
 	}
 }
 
-- 
2.53.0

