Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82A563298
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874213; cv=none; b=Ow8ZN0J1vfBFXO0ijd58n2PP8c1kH/cHDW3Mmj48VfDllbjbnS3QUrB6tyt+JXzy2r/GJzzYxmuaZiQk+SlyM86NJihO+PZpBdoLgd0AbTFflB9KTgvOr8ez6Y6VR7VK+cGSGcyVLmCMh82AQfBeF9bBNJVwzq7JGIlnRwfCMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874213; c=relaxed/simple;
	bh=C6bqZNyT4o8d35HJtUsvvTHx7ibxT1AKZ/PErfJGUzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCPw+4Cn/bilax40GYxnOkZG3QHV5XCC4mfyFKzjHHgEnV0EFHheow/c4M+ii9+9o/9WSSpl9+fZP6xEQ4OPcEcHkpDUCZ0iZwNJOkhybIGW39XcTrD0VTUS+OHWgnAHwLGs6JaLqpyVCpRq5woVIWHkltQoF0nb1uZCo4PJqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1851F00AC4;
	Tue,  8 Sep 2026 13:30:01 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Uladzislau Rezki <uladzislau.rezki@sony.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Yu Liao <liaoyu15@huawei.com>,
	Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Alex Belits <abelits@marvell.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] context_tracking: Add a note about noinstr VS unsafe context tracking functions
Date: Tue,  8 Sep 2026 09:29:52 -0400
Message-ID: <20260908132958.2312212-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090326-curtsy-rocket-6c6d@gregkh>
References: <2026090326-curtsy-rocket-6c6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit f67671baadf6dbae8eca46cb95e85b762e462b2b ]

Some context tracking functions enter or exit into/from RCU idle mode
while using trace-able and lockdep-aware IRQs (un-)masking. As a result
those functions can't get tagged as noinstr. This is unlikely to be
fixed since these are obsolete APIs. Drop a note about this matter.

[ paulmck: Apply Peter Zijlstra feedback. ]

Reported-by: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Stable-dep-of: 7e8ee82e69fd ("ARM: 9477/1: Disable broken eBPF JIT on the Risc PC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/context_tracking.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 36a98c48aedc7..3082332f64765 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -103,6 +103,15 @@ void noinstr __context_tracking_enter(enum ctx_state state)
 }
 EXPORT_SYMBOL_GPL(__context_tracking_enter);
 
+/*
+ * OBSOLETE:
+ * This function should be noinstr but the below local_irq_restore() is
+ * unsafe because it involves illegal RCU uses through tracing and lockdep.
+ * This is unlikely to be fixed as this function is obsolete. The preferred
+ * way is to call __context_tracking_enter() through user_enter_irqoff()
+ * or context_tracking_guest_enter(). It should be the arch entry code
+ * responsibility to call into context tracking with IRQs disabled.
+ */
 void context_tracking_enter(enum ctx_state state)
 {
 	unsigned long flags;
@@ -125,6 +134,14 @@ void context_tracking_enter(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_enter);
 EXPORT_SYMBOL_GPL(context_tracking_enter);
 
+/*
+ * OBSOLETE:
+ * This function should be noinstr but it unsafely calls local_irq_restore(),
+ * involving illegal RCU uses through tracing and lockdep.
+ * This is unlikely to be fixed as this function is obsolete. The preferred
+ * way is to call user_enter_irqoff(). It should be the arch entry code
+ * responsibility to call into context tracking with IRQs disabled.
+ */
 void context_tracking_user_enter(void)
 {
 	user_enter();
@@ -168,6 +185,15 @@ void noinstr __context_tracking_exit(enum ctx_state state)
 }
 EXPORT_SYMBOL_GPL(__context_tracking_exit);
 
+/*
+ * OBSOLETE:
+ * This function should be noinstr but the below local_irq_save() is
+ * unsafe because it involves illegal RCU uses through tracing and lockdep.
+ * This is unlikely to be fixed as this function is obsolete. The preferred
+ * way is to call __context_tracking_exit() through user_exit_irqoff()
+ * or context_tracking_guest_exit(). It should be the arch entry code
+ * responsibility to call into context tracking with IRQs disabled.
+ */
 void context_tracking_exit(enum ctx_state state)
 {
 	unsigned long flags;
@@ -182,6 +208,14 @@ void context_tracking_exit(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_exit);
 EXPORT_SYMBOL_GPL(context_tracking_exit);
 
+/*
+ * OBSOLETE:
+ * This function should be noinstr but it unsafely calls local_irq_save(),
+ * involving illegal RCU uses through tracing and lockdep. This is unlikely
+ * to be fixed as this function is obsolete. The preferred way is to call
+ * user_exit_irqoff(). It should be the arch entry code responsibility to
+ * call into context tracking with IRQs disabled.
+ */
 void context_tracking_user_exit(void)
 {
 	user_exit();
-- 
2.53.0

