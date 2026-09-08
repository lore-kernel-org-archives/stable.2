Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F7036826E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883309; cv=none; b=ExRSSWVi+ihEMHmT91f2WdCa9/rs6ZnP4NOHa39Bu3GhMb/Pn0IC+x4IB9C3JcD25J6/q7YIJcZoXWW8UW7MsdW0HW5b3zQlvfO9kQ4t83E0/zhU6C1u13gJRUcXrgPzoGMOmNIMDNRK9kOAtPjlXu6gn7vEaSJxwE/p9iyNwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883309; c=relaxed/simple;
	bh=XKGNA74QWq5LsaAHxl8Z4sQD29Yu2TnFO5llzzF/oF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+Jk/1wx2twbhq4lIBzDZhFsS0mBM78nDuKO69KgRuKqAzpckQNW0oGoPLZ9sTIGvVJW+tkbOj6log7bUcS7t7xhFLtD3hW8sFIl2AmDcFeKqitgKikjgVQ3c211ZvY31k2ZCM90c7p7lvAN7tP1mIea75XjTH74ouZtTsWBMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Enof9Y04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Enof9Y04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560DB1F00A3E;
	Tue,  8 Sep 2026 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883307;
	bh=tRVnniTJfIa5t3VS3xLzK/LeQljpiofgvBA9/I2cCRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Enof9Y04J/DxIH606mysiF6Ux56HhH129TM2DrQ8Mm4XH1Z8nc4DyL/SnGC3gKh6V
	 N510sQhxSdKS+yjxrGfG4pE7ajEwMpTzVUzVrxUV5KLUp/2AFTfTQ1vhPqoyJOh76w
	 9BpUmYy01Uoy99ehpjP5synRb89v1izXYcIM3l/AOcu3TuzpsRHXdmXM7C4GHVKkts
	 2351V+WfXAlZF5plTOfELsisYPmuxRnrZ0Ac1KcnMlRdxCK9NhfsQNifLJcPNb/ALw
	 MgxW6c1SyRxUTCOPk3zvlv/A9qGGtAidfMablW2wJDNHfOIcuZlHZY+dQTj2TdIimq
	 UYw1NLW534DQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zqiang <qiang1.zhang@intel.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] kasan: fix lockdep report invalid wait context
Date: Tue,  8 Sep 2026 12:01:43 -0400
Message-ID: <20260908160144.2550298-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-uneasily-gauze-359b@gregkh>
References: <2026090357-uneasily-gauze-359b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang1.zhang@intel.com>

[ Upstream commit be41d814c6c7bbf3ffa66faeefa01f6cea8e3c98 ]

For kernels built with the following options and booting

CONFIG_SLUB=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y

[    0.523115] [ BUG: Invalid wait context ]
[    0.523315] 6.3.0-rc1-yocto-standard+ #739 Not tainted
[    0.523649] -----------------------------
[    0.523663] swapper/0/0 is trying to lock:
[    0.523663] ffff888035611360 (&c->lock){....}-{3:3}, at: put_cpu_partial+0x2e/0x1e0
[    0.523663] other info that might help us debug this:
[    0.523663] context-{2:2}
[    0.523663] no locks held by swapper/0/0.
[    0.523663] stack backtrace:
[    0.523663] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-rc1-yocto-standard+ #739
[    0.523663] Call Trace:
[    0.523663]  <IRQ>
[    0.523663]  dump_stack_lvl+0x64/0xb0
[    0.523663]  dump_stack+0x10/0x20
[    0.523663]  __lock_acquire+0x6c4/0x3c10
[    0.523663]  lock_acquire+0x188/0x460
[    0.523663]  put_cpu_partial+0x5a/0x1e0
[    0.523663]  __slab_free+0x39a/0x520
[    0.523663]  ___cache_free+0xa9/0xc0
[    0.523663]  qlist_free_all+0x7a/0x160
[    0.523663]  per_cpu_remove_cache+0x5c/0x70
[    0.523663]  __flush_smp_call_function_queue+0xfc/0x330
[    0.523663]  generic_smp_call_function_single_interrupt+0x13/0x20
[    0.523663]  __sysvec_call_function+0x86/0x2e0
[    0.523663]  sysvec_call_function+0x73/0x90
[    0.523663]  </IRQ>
[    0.523663]  <TASK>
[    0.523663]  asm_sysvec_call_function+0x1b/0x20
[    0.523663] RIP: 0010:default_idle+0x13/0x20
[    0.523663] RSP: 0000:ffffffff83e07dc0 EFLAGS: 00000246
[    0.523663] RAX: 0000000000000000 RBX: ffffffff83e1e200 RCX: ffffffff82a83293
[    0.523663] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8119a6b1
[    0.523663] RBP: ffffffff83e07dc8 R08: 0000000000000001 R09: ffffed1006ac0d66
[    0.523663] R10: ffff888035606b2b R11: ffffed1006ac0d65 R12: 0000000000000000
[    0.523663] R13: ffffffff83e1e200 R14: ffffffff84a7d980 R15: 0000000000000000
[    0.523663]  default_idle_call+0x6c/0xa0
[    0.523663]  do_idle+0x2e1/0x330
[    0.523663]  cpu_startup_entry+0x20/0x30
[    0.523663]  rest_init+0x152/0x240
[    0.523663]  arch_call_rest_init+0x13/0x40
[    0.523663]  start_kernel+0x331/0x470
[    0.523663]  x86_64_start_reservations+0x18/0x40
[    0.523663]  x86_64_start_kernel+0xbb/0x120
[    0.523663]  secondary_startup_64_no_verify+0xe0/0xeb
[    0.523663]  </TASK>

The local_lock_irqsave() is invoked in put_cpu_partial() and happens in
IPI context, due to the CONFIG_PROVE_RAW_LOCK_NESTING=y (the
LD_WAIT_CONFIG not equal to LD_WAIT_SPIN), so acquire local_lock in IPI
context will trigger above calltrace.

This commit therefore moves qlist_free_all() from hard-irq context to task
context.

Link: https://lkml.kernel.org/r/20230327120019.1027640-1-qiang1.zhang@intel.com
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Acked-by: Marco Elver <elver@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 8790303cbaac ("kasan: fix cache shrink race with CPU hotplug")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kasan/quarantine.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 75585077eb6dd..152dca73f3984 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -99,7 +99,6 @@ static unsigned long quarantine_size;
 static DEFINE_RAW_SPINLOCK(quarantine_lock);
 DEFINE_STATIC_SRCU(remove_cache_srcu);
 
-#ifdef CONFIG_PREEMPT_RT
 struct cpu_shrink_qlist {
 	raw_spinlock_t lock;
 	struct qlist_head qlist;
@@ -108,7 +107,6 @@ struct cpu_shrink_qlist {
 static DEFINE_PER_CPU(struct cpu_shrink_qlist, shrink_qlist) = {
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(shrink_qlist.lock),
 };
-#endif
 
 /* Maximum size of the global queue. */
 static unsigned long quarantine_max_size;
@@ -319,16 +317,6 @@ static void qlist_move_cache(struct qlist_head *from,
 	}
 }
 
-#ifndef CONFIG_PREEMPT_RT
-static void __per_cpu_remove_cache(struct qlist_head *q, void *arg)
-{
-	struct kmem_cache *cache = arg;
-	struct qlist_head to_free = QLIST_INIT;
-
-	qlist_move_cache(q, &to_free, cache);
-	qlist_free_all(&to_free, cache);
-}
-#else
 static void __per_cpu_remove_cache(struct qlist_head *q, void *arg)
 {
 	struct kmem_cache *cache = arg;
@@ -340,7 +328,6 @@ static void __per_cpu_remove_cache(struct qlist_head *q, void *arg)
 	qlist_move_cache(q, &sq->qlist, cache);
 	raw_spin_unlock_irqrestore(&sq->lock, flags);
 }
-#endif
 
 static void per_cpu_remove_cache(void *arg)
 {
@@ -362,6 +349,8 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 {
 	unsigned long flags, i;
 	struct qlist_head to_free = QLIST_INIT;
+	int cpu;
+	struct cpu_shrink_qlist *sq;
 
 	/*
 	 * Must be careful to not miss any objects that are being moved from
@@ -372,20 +361,13 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 	 */
 	on_each_cpu(per_cpu_remove_cache, cache, 1);
 
-#ifdef CONFIG_PREEMPT_RT
-	{
-		int cpu;
-		struct cpu_shrink_qlist *sq;
-
-		for_each_online_cpu(cpu) {
-			sq = per_cpu_ptr(&shrink_qlist, cpu);
-			raw_spin_lock_irqsave(&sq->lock, flags);
-			qlist_move_cache(&sq->qlist, &to_free, cache);
-			raw_spin_unlock_irqrestore(&sq->lock, flags);
-		}
-		qlist_free_all(&to_free, cache);
+	for_each_online_cpu(cpu) {
+		sq = per_cpu_ptr(&shrink_qlist, cpu);
+		raw_spin_lock_irqsave(&sq->lock, flags);
+		qlist_move_cache(&sq->qlist, &to_free, cache);
+		raw_spin_unlock_irqrestore(&sq->lock, flags);
 	}
-#endif
+	qlist_free_all(&to_free, cache);
 
 	raw_spin_lock_irqsave(&quarantine_lock, flags);
 	for (i = 0; i < QUARANTINE_BATCHES; i++) {
-- 
2.53.0

