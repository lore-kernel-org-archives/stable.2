Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049688;
	b=uW7lwKo8T3JmiCiKUsaggD1VqmD0hHEZoaMGVMSHRPNhlywnA385ZKzl5c/wUxAm1e0c
	 clbLmPU4w5CckrUBm/hLBT5xCLShcwRv94H0Qmguv30CHd6rmDilJRuZymleTPCbpsk0B
	 qGIRzAocfz45HDz4O7m0T1PgEs5qqI2WrM0R9uQMX8qaoxK49kwLck0VrSo3pcGaJYxxD
	 qhrhrMWy3979M2wadhrXcelf1vt8ni6RP6KT2aFRtkSP0Hl0UX7z9VDPmfsCDd2IXAXv3
	 y+fmMqGBVBcuYXS1oS/UWdlJFDjYuVez05fyjHDp88gz+Rkry0E1uY7uTAtca/SG/GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049688;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fSeuE7MbgfSOGBnjrB8wc7ueRGQ/t7wnUN7PdaxAOTs=;
	b=T4mEdIXwkZFXm+i7VZh/SsKTWC4TPvPl3xjeVl90tenIxTbyE3fn/DUPamIUa1384JrE
	 0emkX9SxuSU0BAuCw0GGCXmv4U+pPdODfDqq5tSO19zx5PxLLRNwkVvHXHLw4QKd62dTa
	 v6dD9PoI88NVP14C3OPA2xOnye7TH0oaNFOXRKSbh8DGJiJaeV7D3vbViGNMBD44E3bqK
	 4y8FjE7MD8eJvd6COzHYS2eIcsKsirrOBUbotB+XDECRNK+9+YCfUL1u0Eluo746Qj79K
	 TqJUcnrpCf3R8tncsMg7+FNFduaBEZ3XR4NNB/t/2/4C4SgMPOk5zLPQVSZU5D/o5QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zj6ZVBZc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F3606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zj6ZVBZc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632B71F0089F;
	Sat,  7 Nov 2026 11:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049687;
	bh=fSeuE7MbgfSOGBnjrB8wc7ueRGQ/t7wnUN7PdaxAOTs=;
	h=From:To:Cc:Subject:Date;
	b=Zj6ZVBZcjpL1r7KQierjn6vADE4TTXunACuEKb/t0WMGQIepKmi6HsbVhOZABgnsw
	 hlLlVJ6z837LNqCh+1LhzopXIvdalXlQ9KIboGBdxUkW9l3mOywxcrvnX9joDVW0ex
	 wGmk6bTHLbEAl2f/H26t07oIcCHrX4pZGRsd4Z7gqabO0ec9ppXI35yCU5+G+uDPUC
	 vu6g64kL7njoYhByuEeV5b3G2iZ4JSRy/xcNEaI+sY/Pk/Auz+BMMVf15pMwzP0fy5
	 3Uxk0kaS0ESN2PcORQaPY6q6dUswADWx/2AaPSF8BMgEuTBLmiyXl/W9Q1NdfY5EYV
	 Q4clhOf+3hv1g==
From: Sasha Levin <sashal@kernel.org>
To: linmag7@gmail.com,
	mattst88@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] alpha: load the MMU context when switch_mm() switches the current task" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:08:06 -0500
Message-ID: <20261107060805-failed-5.15-9b8be19d5dc9@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9b8be19d5dc9525a408942e2e8012873199e7455
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060805-failed-5.15-9b8be19d5dc9@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




