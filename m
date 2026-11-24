Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549639;
	b=WbfNlMJ6m0L+npn5/qR+42Mymiv1QHac7uy+l0CcITsBduobu9pQHDBHTcXTM40pGsVJ
	 LqHBO65vqZB8cqn9h2aYDvX1/FXQQWrHL6ie3jOBv/5koTtLynW4nrXnwf8bAP+y65CC+
	 CTUfhVXEz4S0UNKYSrXgCsBPImjT1bSjxn5zNLmtmGVv2wrJngovIIvVD5HsnVh0xRZUR
	 YBbp42bVFk9xzrq77oLNhzgfMxXi19JmD2LCCFP45ye/TyLJqt1guD2xNQ1RRsNegdS9Y
	 NUPeEb3Zi3QRk2TY36Fe/odO/oL35FdvRa7sQTwDJ+NpsGppyBAuNVA8PNzLWUvQ2GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549639;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3cFWDXQ8KAU5Elp0nNN8Nv6NxB/OcWYqOm4mw2XxwUk=;
	b=e/Ncp/HhYljnlGjZBAXYzrbrkX1PzRLsc2IrUW2kSuKYhDsQWEgD9QLz0RQwDiGk98qZ
	 sQgnrz3lA+4TJ0cynHIemtSexPsnnhI4PiufyXv8D0qB2mfKS/v9HSZsRKws5QJRBd1OZ
	 6kYnI8dU6B2ZeHOsDMFYtsKGYbEzLwPRNf5koM/4ybQ6LsJDXM4EGMMrpSncrMNqN/39j
	 rR/p6qrpTCBuoMny3vZ4IttRRBg3+6/VAXfZtrn7E/4BRSOca8fEZH1fV7/eTNvjP6spI
	 ll4Bdbffgo2uriAjHalJ9ApWqnZn/LQDeY/uOuUzMO/+MT4OHMc/ypccQdIxA05Sf7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXTGiMP5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B726606A6A5;
	Tue, 24 Nov 2026 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXTGiMP5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6E51F000D4;
	Tue, 24 Nov 2026 19:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795549638;
	bh=3cFWDXQ8KAU5Elp0nNN8Nv6NxB/OcWYqOm4mw2XxwUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CXTGiMP5o1HjrrxbddYHp7Kl3EFPOW3NEUYGxFmuZ6iv5SKNAP+cuEf8gmOBJC2Dg
	 XwwIAKCXou/Er59Dlb+Ljpiirovg4bPxpqxjvBu3bnJxjtGmiW9nb0QIsIuAp2xLpg
	 WVNNyABhF5Fv3nUaAL3ayw/vo0LJRG2aAorBid+KgKHQMrKD+NH0TlDE5LcXwC/UgD
	 0pjxAO2KYScsAxc37DkWGzXb9p6mIjz8gcNtqQ/yRqSaZSuQlZaPzamA0sXSqqu0RO
	 LvqnOiYRtoytQdnBUR/ZX2O7gxMUGyxuHCCgGHMoqJmMENCQaZwbAra3x/iXByxaIh
	 3rTzbRbA2Ee1A==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 33964198003A;
	Tue, 24 Nov 2026 14:47:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Nov 2026 14:47:15 -0500
X-ME-Sender: <xms:wekFa2UMKVClpYZJ8UdpOBVZIz58cAtZ1FgIt2UWtJV_W2QNG8wfJw>
    <xme:wekFaw_vK1kiNNY6j8SFc1kmcrR1P_cV52qaOqpXKcbu_uFbtkSTIhIKgBiG3x1o2
    gzrdaEMaaq1qKQszB97tqX5hQ9_mw7YLSYbpm2AMhxM4Dc4tY0dzI8>
X-ME-Received: <xmr:wekFa2b8u0_nmyom0sB5SKxwXyPOrv30K5gLQmHO98xXzEx_fDYpn6bJ-_A>
X-ME-Proxy-Cause: dmFkZTFIQ4tDLKOBhlA/ENs8WzyAMimFg22DdBTCB4/PNzsw0l7JAKIq/J4+DfcZKkGy55
    cO9k8L7OujezxEtNbSKmlZ39KiNaX6MyE3qmZh9H4FNogjnItVh72OPWWUJY0JdfskwGrb
    yW2faYz7cdZXKaCUPUBDuwpj/hlyYlpQOZduQRtnw0vKtXfyFfWkUuHXLQQUuZhf9IAiyZ
    qs5tnA+Guqr3Qt5eVQb/lDt6YW5+26zBOWQCNlwwrVm+4vln1C+G36qn+8IitS1AQ65hG5
    thEuuZWxJ2BsQ+dvSmXmOt0dNW4lM0lnb3fflFk8hyuNMxBqdzPFbdGZ6nfyQkuUjFfDi8
    zl/hQo+v5/WPhrqpeFHvMRQwbh4SNwnxioCtt+cGKistMycK0RqV8vY79MWJ2CMyAKhDYB
    XJKci2sUoQv811xP5xZGEpGAas23Z0B4nIODKLturESkZz4nAHEVUxB4kKo/CA6ahnn/Pz
    murtjvr4n41cL2mAfaBEPSkUVkHHNs6iQFuojwymAkdekVp49iV5AQZokEKG7wH+7zfaqD
    ns0k3W3+BWSiN8OusUuNNR1i3qVUJJ8PwUVHlHDQYUfpPIyUbPJkBOepZ2J2XcBsPb8Bzf
    bb8dXsVRQ/j0KqoAjQZT/wREmYSuqULEI78Ze3oRDd8f5BVlTsYCj+MHiHjA
X-ME-Proxy: <xmx:wekFaweyMbp4UVcB93yOWNn22e95yuzklEa07mZW0Td6YXtlf4Fp7Q>
    <xmx:wekFa4o4WSdP47Cq7UiMxWiNNx3DhRNodJgypqcRvSmJj0mjYLdkiA>
    <xmx:wekFa_DCD3_Te6L1Jv8Xr8IhGZnrsUf3qmsxaKJrwcoQUlqjU6_gNg>
    <xmx:wekFa-Wt05Zc5zSruvW2PRQ-ofg29OLTURN-tXuD0YZgW0Ix_omYXA>
    <xmx:wekFa755Sul1KRp1_nv4dKXRna6B3CW3a1nTUsOLDnpwY0exdazse5f4>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 14:47:13 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Liao Chang <liaochang1@huawei.com>,
	Ashok Raj <ashok.raj@oss.qualcomm.com>,
	Doug Anderson <dianders@chromium.org>,
	Yin Fengwei <fengwei_yin@linux.alibaba.com>,
	Pengjie Zhang <zhangpengjie2@huawei.com>,
	Cong Wang <cwang@multikernel.io>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] firmware: arm_sdei: Do not signal event 0 to a masked PE
Date: Tue, 24 Nov 2026 19:47:04 +0000
Message-ID: <20261124194707.1030653-2-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124194707.1030653-1-kas@kernel.org>
References: <20261124194707.1030653-1-kas@kernel.org>
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

The SDEI NMI backtrace signals event 0 to every other CPU, idle ones
included. The kernel masks SDEI on a PE around power-down idle states,
on its way offline and when it stops.

TF-A raises event 0 with an SGI. On a masked PE it acknowledges the SGI
and never ends it; the event should stay pending until SDEI_PE_UNMASK.
TF-A v2.13 and later refuse to signal a masked PE, but a target that masks
just after the check still takes the SGI. A fix is under review [1].

The PE keeps running at the SDEI priority and takes no Non-secure
interrupt again, even after SDEI_PE_UNMASK. Other CPUs hang in
csd_lock_wait() on their next cross-call to it. One sysrq-l locked up a
384-CPU machine.

Keep event 0 away from masked PEs. Each PE gets a lock, an unmasked flag
and a count of signals raised at it. sdei_event_signal() signals a PE
only under its lock with the flag set, and returns -EAGAIN otherwise.
Before it masks, a PE clears the flag under the lock and waits for the
signals already raised to arrive, which SDEI delivers whatever the PE's
interrupt masks. The wait is limited to a millisecond: a signal raised
while another is pending merges into it, and the count never drains.

Senders can run from an SDEI event or a pseudo-NMI, so they only try the
lock. A panicking CPU skips it, as a panic from such a context may have
left it held by that CPU.

The cpu_pm notifier also runs on a PE that is masked already: before
sdei_cpuhp_up(), and between sdei_cpuhp_down() and CPU_OFF. Make it
unmask only what it masked itself, or the PE comes back from CPU_OFF
masked while the kernel takes it as unmasked.

sdei_event_signal() now takes a logical CPU number.

[1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/55414

Fixes: 9141eda9eec7 ("firmware: arm_sdei: add SDEI_EVENT_SIGNAL support")
Cc: stable@vger.kernel.org
Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Closes: https://lore.kernel.org/r/17149b32-6b9c-4364-b664-5789f0633e9d@huawei.com
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 drivers/firmware/arm_sdei.c     | 130 ++++++++++++++++++++++++++++++--
 drivers/firmware/arm_sdei_nmi.c |   9 ++-
 include/linux/arm_sdei.h        |   4 +-
 3 files changed, 131 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index e8dd2f0f3919..47f36efdc04e 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -12,6 +12,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/cpu.h>
 #include <linux/cpu_pm.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/hardirq.h>
 #include <linux/kernel.h>
@@ -32,6 +33,8 @@
 #include <linux/smp.h>
 #include <linux/spinlock.h>
 
+#include <asm/smp_plat.h>
+
 /*
  * The call to use to reach the firmware.
  */
@@ -299,10 +302,78 @@ static int sdei_api_get_version(u64 *version)
 	return invoke_sdei_fn(SDEI_1_0_FN_SDEI_VERSION, 0, 0, 0, 0, 0, version);
 }
 
+/*
+ * Event 0 must not reach a PE that has SDEI masked. Firmware may
+ * acknowledge the SGI behind it and never end it, and the PE then takes
+ * no Non-secure interrupt at all.
+ *
+ * A sender signals a PE only with the PE's lock held, and only if the PE
+ * is unmasked. The PE takes its lock to mark itself masked: no sender gets
+ * through after that, and a sender that got through before has counted
+ * its signal in @raised and raised it. The PE lets its signals arrive
+ * before it masks: each event 0 takes one off @raised. @pm_masked records
+ * what the cpu_pm notifier masked.
+ */
+struct sdei_pe {
+	raw_spinlock_t	lock;
+	atomic_t	raised;
+	bool		unmasked;
+	bool		pm_masked;
+};
+
+static DEFINE_PER_CPU(struct sdei_pe, sdei_pe) = {
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(sdei_pe.lock),
+};
+
+/* Wait for event 0 signals in flight to this PE to arrive */
+static void sdei_wait_in_flight(struct sdei_pe *pe)
+{
+	int i;
+
+	/* Bounded: a signal that never arrives must not hold up masking */
+	for (i = 0; i < USEC_PER_MSEC && atomic_read(&pe->raised) > 0; i++)
+		udelay(1);
+
+	if (atomic_read(&pe->raised) > 0) {
+		pr_warn_once("event 0 to CPU[%u] did not arrive within 1ms\n",
+			     smp_processor_id());
+	}
+
+	/*
+	 * A signal raised while an earlier one is still pending merges into
+	 * it, and the count stays high with nothing on its way: drop it. A
+	 * signal that arrives after this finds the count at zero and leaves it.
+	 */
+	atomic_set(&pe->raised, 0);
+}
+
+/* Stop event 0 signals to this PE, waiting for the senders under the lock */
+static void sdei_block_signal(void)
+{
+	struct sdei_pe *pe = this_cpu_ptr(&sdei_pe);
+	unsigned long flags;
+
+	/*
+	 * A panic from an SDEI event or a pseudo-NMI may have left the lock
+	 * held by this CPU. The CPUs that could signal it are stopped by now.
+	 */
+	if (panic_on_this_cpu()) {
+		WRITE_ONCE(pe->unmasked, false);
+	} else {
+		raw_spin_lock_irqsave(&pe->lock, flags);
+		WRITE_ONCE(pe->unmasked, false);
+		raw_spin_unlock_irqrestore(&pe->lock, flags);
+	}
+
+	sdei_wait_in_flight(pe);
+}
+
 int sdei_mask_local_cpu(void)
 {
 	int err;
 
+	sdei_block_signal();
+
 	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PE_MASK, 0, 0, 0, 0, 0, NULL);
 	if (err && err != -EIO) {
 		pr_warn_once("failed to mask CPU[%u]: %d\n",
@@ -330,6 +401,8 @@ int sdei_unmask_local_cpu(void)
 		return err;
 	}
 
+	/* No lock: a sender that misses this only refuses an unmasked PE */
+	WRITE_ONCE(this_cpu_ptr(&sdei_pe)->unmasked, true);
 	return 0;
 }
 
@@ -340,14 +413,34 @@ static void _ipi_unmask_cpu(void *ignored)
 }
 
 /*
- * Signal the software-signalled event (event 0) to @mpidr. Does nothing
- * but the SMC -- no locks, no event lookup -- so it is safe from NMI /
- * crash context (e.g. the cross-CPU NMI service).
+ * Signal the software-signalled event (event 0) to @cpu. It waits for no
+ * lock and looks up no event, so it is safe from NMI / crash context (e.g.
+ * the cross-CPU NMI service).
+ *
+ * Returns -EAGAIN without signalling if @cpu has SDEI masked or is masking.
  */
-int sdei_event_signal(u32 event_num, u64 mpidr)
+int sdei_event_signal(u32 event_num, unsigned int cpu)
 {
-	return invoke_sdei_fn(SDEI_1_0_FN_SDEI_EVENT_SIGNAL, event_num,
-			      mpidr, 0, 0, 0, NULL);
+	struct sdei_pe *pe = per_cpu_ptr(&sdei_pe, cpu);
+	u64 mpidr = cpu_logical_map(cpu);
+	unsigned long flags;
+	int err = -EAGAIN;
+
+	/* IRQs off: the PE may be waiting for the lock to mask */
+	if (!raw_spin_trylock_irqsave(&pe->lock, flags))
+		return -EAGAIN;
+
+	if (READ_ONCE(pe->unmasked)) {
+		atomic_inc(&pe->raised);
+		err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_EVENT_SIGNAL, event_num,
+				     mpidr, 0, 0, 0, NULL);
+		/* A late signal may have taken this count already */
+		if (err)
+			atomic_dec_if_positive(&pe->raised);
+	}
+
+	raw_spin_unlock_irqrestore(&pe->lock, flags);
+	return err;
 }
 NOKPROBE_SYMBOL(sdei_event_signal);
 
@@ -680,6 +773,9 @@ static int sdei_cpuhp_down(unsigned int cpu)
 	struct sdei_event *event;
 	int err;
 
+	/* A signal must arrive while event 0 is still registered here */
+	sdei_block_signal();
+
 	/* un-register private events */
 	spin_lock(&sdei_list_lock);
 	list_for_each_entry(event, &sdei_list, list) {
@@ -733,16 +829,30 @@ static int sdei_cpuhp_up(unsigned int cpu)
 static int sdei_pm_notifier(struct notifier_block *nb, unsigned long action,
 			    void *data)
 {
+	struct sdei_pe *pe = this_cpu_ptr(&sdei_pe);
 	int rv;
 
 	WARN_ON_ONCE(preemptible());
 
 	switch (action) {
 	case CPU_PM_ENTER:
+		/*
+		 * Leave alone a PE that is masked already: before
+		 * sdei_cpuhp_up(), or after sdei_cpuhp_down(), as cpuidle runs
+		 * until CPU_OFF. CPU_PM_EXIT must not unmask it.
+		 */
+		if (!pe->unmasked)
+			return NOTIFY_DONE;
 		rv = sdei_mask_local_cpu();
+		if (!rv)
+			pe->pm_masked = true;
 		break;
 	case CPU_PM_EXIT:
 	case CPU_PM_ENTER_FAILED:
+		/* Unmask only what CPU_PM_ENTER masked */
+		if (!pe->pm_masked)
+			return NOTIFY_DONE;
+		pe->pm_masked = false;
 		rv = sdei_unmask_local_cpu();
 		break;
 	default:
@@ -1114,6 +1224,14 @@ int sdei_event_handler(struct pt_regs *regs,
 	int err;
 	u32 event_num = arg->event_num;
 
+	/*
+	 * One signal raised at this PE has arrived. If the PE gave up waiting
+	 * for it and dropped the count, leave the count at zero: below zero,
+	 * the PE would not wait for the next signal raised here.
+	 */
+	if (!event_num)
+		atomic_dec_if_positive(&this_cpu_ptr(&sdei_pe)->raised);
+
 	err = arg->callback(event_num, regs, arg->callback_arg);
 	if (err)
 		pr_err_ratelimited("event %u on CPU %u failed with error: %d\n",
diff --git a/drivers/firmware/arm_sdei_nmi.c b/drivers/firmware/arm_sdei_nmi.c
index 038eb79e28ac..edea68ef881e 100644
--- a/drivers/firmware/arm_sdei_nmi.c
+++ b/drivers/firmware/arm_sdei_nmi.c
@@ -36,7 +36,7 @@
  *
  * Delivery uses the standard SDEI software-signalled event (event 0) and
  * SDEI_EVENT_SIGNAL. We register a handler for event 0, enable it, and
- * poke a target CPU with sdei_event_signal(0, mpidr): firmware makes
+ * poke a target CPU with sdei_event_signal(0, cpu): firmware makes
  * event 0 pending on that PE and dispatches the handler NMI-like,
  * regardless of the target's DAIF.
  * Availability is simply whether event 0 registers and enables -- if SDEI
@@ -58,7 +58,6 @@
 #include <linux/types.h>
 
 #include <asm/nmi.h>
-#include <asm/smp_plat.h>
 
 static bool sdei_nmi_available;
 
@@ -127,11 +126,13 @@ NOKPROBE_SYMBOL(sdei_nmi_handler);
 
 static void sdei_nmi_fire(unsigned int target_cpu)
 {
-	int err = sdei_event_signal(SDEI_NMI_EVENT, cpu_logical_map(target_cpu));
+	int err = sdei_event_signal(SDEI_NMI_EVENT, target_cpu);
 
-	if (err)
+	/* -EAGAIN: the CPU has SDEI masked and is not signalled */
+	if (err && err != -EAGAIN) {
 		pr_warn("SDEI_EVENT_SIGNAL to CPU %u failed: %d\n",
 			target_cpu, err);
+	}
 }
 
 /*
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index b9dc21c241be..a63ab4774783 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -39,9 +39,9 @@ int sdei_event_disable(u32 event_num);
 
 /*
  * Signal the software-signalled event (event 0) to another PE, NMI-like.
- * @mpidr is the target's MPIDR affinity.
+ * Returns -EAGAIN if @cpu has SDEI masked.
  */
-int sdei_event_signal(u32 event_num, u64 mpidr);
+int sdei_event_signal(u32 event_num, unsigned int cpu);
 
 /* Was SDEI firmware probed and usable? */
 bool sdei_is_present(void);
-- 
2.54.0

