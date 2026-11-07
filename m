Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047786;
	b=fCE+1/rU4kdAEi6SrSxMmUd3XKAxRwlT+XKarm0WxuvPi3OzO91u5LT1M5RxziarrEHS
	 xwQWf7IvsOJDxQb0jMWlTwcIbcJSPi/SRnOXLYrIbcntbGpxkNbtuB2GgNG7jmcucv/op
	 iBZAsmGhPnQWt0IBaPN8aFbpM/5XBYuPsVe31A1FCPfdRkM/tMIBXfDWPPVp0eKaDcdH+
	 9cJkyefFfOvmt+xcj9FOvu3S7WGKeCTf7MGIIlEVsVduqUcMA5VuSiyRX7J/GFqvnhXxU
	 h7IB7yE7D1QUAp79v4LJhEKQTCy7OuohkxV0fMLYU7/wpMq4x9CAjs6dza0avt2Fymg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047786;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aElT8Xlr2NRec+33GryU60rH/VlYWNjrvbNEW+CE1hM=;
	b=0OjTM7bVMslv/KRoqV5WFZCyzTaQwPKgJMc8/QdT4ycf6H5G5qr37B9wRbpQRO59BHha
	 qriPansjN5o2vXd/3yqBtTFKc+Bw9bYJAq/2deACqLX3+hXvNlNb+YhhtBj5o9nzOkGSv
	 p3dY5bz9zmwM1QVq4G5CWV5kU+ELtU/o2t/lqA4Z2mTqezzNcQvtMEZqxQ0ttIKtb6GqV
	 fMRrBe8bdt9iE6kjZMA2CdYA/+o4P7txt2PmmzlQgtAqIZdCDgLblDPJAbsDk+pUpi14r
	 73JSdwi3W38n0FrIs7eokT2r7cLDEhOkiQyd3jhq2NseEIitePPlKvHkRaAn8kLYIuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCFhNVRL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73240606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCFhNVRL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29071F008A1;
	Sat,  7 Nov 2026 10:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047786;
	bh=aElT8Xlr2NRec+33GryU60rH/VlYWNjrvbNEW+CE1hM=;
	h=From:To:Cc:Subject:Date;
	b=RCFhNVRLsBgSUeZ2tqx6Xs3gKoj+DdaOP94pH6aj2UDu8Eg40aZg1cF30aKKAry1j
	 0fquKXmY9OlW7RRBQNMAY5d2hJXP4T6mh8QHp7nv56ShZAYLf65x4JZfrZmOzSGOKP
	 wedr7koTipv+ALrqzdFvzBxz48fHhiH3KookStkW3zlBNmCEmxY2V62GCW38DBRyLX
	 I/OaLE+hB/5d993UAZ60QCTlzpkMdMzavNO+BBKP5ZseqxtQiPBwOBlZTm3q+EctPK
	 fumbNbzdpHt9pzjBqSWleMyp0e50KjEondbwG24dczRQd9mLen+1eOcGtSZsHqjLXV
	 kSrolYGBqnDmw==
From: Sasha Levin <sashal@kernel.org>
To: linmag7@gmail.com,
	mattst88@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] alpha: load the MMU context when switch_mm() switches the current task" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:24 -0500
Message-ID: <20261107053624-failed-6.6-9b8be19d5dc9@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9b8be19d5dc9525a408942e2e8012873199e7455
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053624-failed-6.6-9b8be19d5dc9@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9b8be19d5dc9525a408942e2e8012873199e7455 Mon Sep 17 00:00:00 2001
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 10 Oct 2026 16:24:27 +0200
Subject: [PATCH] alpha: load the MMU context when switch_mm() switches the
 current task

ev5_switch_mm() only prepares the incoming PCB. The context is installed
by PAL_swpctx, which alpha_switch_to() issues against that PCB on the way
out of the scheduler.

Direct callers reach switch_mm() without going through alpha_switch_to():
kthread_use_mm(), which borrows an mm for the current kernel thread,
sched_force_init_mm() on the CPU-hotplug teardown path, and
do_shoot_lazy_tlb(), which switches to init_mm from an IPI. None explicitly
loads the context, so the task can carry on running under whatever was
loaded before. For kthread_use_mm(), current->mm then names the borrowed
mm even though its context has not been loaded. The other two callers
change active_mm while leaving current->mm NULL.

The stale page-table root need not be swapper_pg_dir; it may belong to a
user process that ran on the CPU earlier, and the kthread's user accesses
can then read and write that process's memory wherever the stale mappings
allow. Translations taken that way can also end up tagged with the
borrowed mm's ASN: ev5_switch_mm() writes that ASN into the PCB, which the
next PAL_swpctx installs against the stale ptbr. An address the stale
tables do not map faults instead, and since do_page_fault() resolves
faults against current->mm without reloading the context, the same access
can fault again on return.

sched_force_init_mm() needs CONFIG_HOTPLUG_CPU and do_shoot_lazy_tlb()
needs CONFIG_MMU_LAZY_TLB_SHOOTDOWN. Alpha selects neither, so only
kthread_use_mm() is reachable in practice. Test the caller's identity
rather than special-casing individual callers.

The scheduler passes the incoming task, which is not current until
alpha_switch_to() runs; all three direct callers pass current. Test for
that and load the context the way activate_mm() does. All three run with
interrupts disabled across the switch, so this completes before any
shootdown can be taken and needs no asn_lock handshake.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Tested-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Link: https://lore.kernel.org/r/20261010142533.974797-2-linmag7@gmail.com
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/mmu_context.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index eee8fe836a59e..d366f89fee585 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -130,6 +130,8 @@ __get_new_mm_context(struct mm_struct *mm, long cpu)
 	return next;
 }
 
+extern void __load_new_mm_context(struct mm_struct *);
+
 __EXTERN_INLINE void
 ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	      struct task_struct *next)
@@ -139,6 +141,16 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	unsigned long mmc;
 	long cpu = smp_processor_id();
 
+	/*
+	 * kthread_use_mm(), sched_force_init_mm() and do_shoot_lazy_tlb()
+	 * switch current's mm without alpha_switch_to(), which loads the
+	 * context. The latter two require options Alpha does not select.
+	 */
+	if (next == current) {
+		__load_new_mm_context(next_mm);
+		return;
+	}
+
 #ifdef CONFIG_SMP
 	cpu_data[cpu].asn_lock = 1;
 	barrier();
@@ -160,7 +172,6 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	task_thread_info(next)->pcb.asn = mmc & HARDWARE_ASN_MASK;
 }
 
-extern void __load_new_mm_context(struct mm_struct *);
 asmlinkage void do_page_fault(unsigned long address, unsigned long mmcsr,
 			      long cause, struct pt_regs *regs);
 
-- 
2.53.0




