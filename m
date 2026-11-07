Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048658;
	b=PnnMLr0u/EN97ouoPH/dCXP4vyc2Luh0cV7bw/yrNcY7PMajih+lMa9qHZRQC2V8s08s
	 0Wnx9ghdaBA0v/e2kAeSBLdj/EjW/2dWCBa9MDiyZMSpyj5Yc1t2tt4vWIXKi3bS6+pZQ
	 BC2bjHgdKgK02n6p1blc7eDjQOIV5kp46zPc+WnX6lZ+xWKuB0vYZ2TSpgoyky9FutTpr
	 ir0T+0nXtAKaFKFtxL2iX9h4Ys7QKNMxf6XsViJAiKUDTqUENKEa/ESvKL1A86DLgB6BE
	 1D0rf7zeYekxpBiAPw1rPh/ZCqvYJUGyMtGn2ydjueeLTdGu236FgmYEQAec11iYbXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048658;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+qm4xAeZMrEXi1A9523kapQLAS7QgSk5VMfjwjkF53Y=;
	b=NOVpx5Tj85LBw1vqeSWmRTpwmrTcGT8CwSFL2+rpJBk2JnajyFZ9rapId6rRCkXoWm/L
	 UZjFhFx1bB4n5rolGjw5GJtX2UcqCbCVvW5jsJoO0LozwGRpsefkulpCsu70pICBSfzjI
	 Pa1p9KbFErEgc265g1Q+fyxXCybdpFUsg71B0zPR4RG8cuNdEJIQR9DqqXorKs9yKxEg4
	 lG5eAzr141yUIaZWcFldoueXgn2NaE5GbzB8VlPaQ23X0SfPfLp/VEZu15itt/toYrRQF
	 c1xGBYVD2PPVtblDheOtfhjCHLcAy62We+qiHso802eIt97wpxPs+dOyXYMQFCSHebg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AFzh0/Lv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF10606A33F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFzh0/Lv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD521F0089F;
	Sat,  7 Nov 2026 10:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048658;
	bh=+qm4xAeZMrEXi1A9523kapQLAS7QgSk5VMfjwjkF53Y=;
	h=From:To:Cc:Subject:Date;
	b=AFzh0/LvojxvKA8O1Sy+0fTTE4G+CPIdgsk2dPSDImh2q3tVyDtaAw6ZEcTX8DQwv
	 UIiqdHv+VYnBaP8XrGyLboJcKNmCoSv6iJLetxRllHE+53kWkGu8dEV6Jgr5uE4Zhs
	 1UsjTYTTXe22mG8G5uZXXGDJI0eAU7TiufkDMeQ5hgc086tPPt6tyi7Z+VRPcwO/V7
	 QL3Ed81DRnjDdjpAF5NRNEX4r300hNCuMz8zL4Lfh12tAe/6od73VqyrK/r/LKHzQa
	 b3zIcglzBY9kt8FO4zbLWaXcZPNMVfhEK2yVIz0E9YDvBzJPozm/vks527CQTAW1+p
	 MIVw74oGwIbOw==
From: Sasha Levin <sashal@kernel.org>
To: linmag7@gmail.com,
	mattst88@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] alpha: load the MMU context when switch_mm() switches the current task" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:50:56 -0500
Message-ID: <20261107055056-failed-6.1-9b8be19d5dc9@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9b8be19d5dc9525a408942e2e8012873199e7455
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055056-failed-6.1-9b8be19d5dc9@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




