Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633603;
	b=j4XLY3LfFXzynFu1mEtbosHLhmJ1YFmx8WxaHLTYEzjL08BHV/HKtLvlGyF1SvW6CqQz
	 J6Oexlg2bM7mmKd8og0zzBFVAbntV5HhjVR392S7d2GAOtYh5m6feAIUljYlja4tOy7pA
	 f2uWdKp6WJUB8kUbdrvyUbjCDAABuL5+bYKC7pU2ySNM77END42DPWabLxHWRHKYWxLE9
	 iW3/gtvf3EJBDTnTcd8gtINX7cBEsHXrcJDMn3P2/Qghb36yXlAjqUt3N1OyNhBnzEu/D
	 IvgrUZWSX2eHaDfJqpbbAIm6ikryPzIcsA+L3iQZUXwXrqM2wYeCB9kxH2t0ux5s0Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633603;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=OWA2XPF4LToFYnO4yT1hL4MsaiF9uOHmMKnDy9Fz0JI=;
	b=gcASnf3TXP2Oc2KoJvlx8Oor7cr+fEPRy0nWEs0WYJU9aPpBKICXzcSMrdW2h+Fa2dht
	 XaM0OzcVS8OEZP6GoplLB7yADFepyMq4xmnc9u8t3zXWXcaQXBYn+b6HaJzVADaCaitNr
	 U6+a8rZDZLI5ZOyBcXNZlX613ROx47EeLPkscaKNCLa0MD/oqQHrlp5zM6nXDGJxy+mpX
	 +4mbqYG5RzyRWEpyzCcBEumQcbmmHfXrNYUf58NezwQz7DX69yE5KIhJxj/HBjyX0Tojg
	 AePLupAVrBdboLN7eAU4zBOshbdA7Ai99G4kZi0MPJrap4XIfBCpiQQ1SsOo0pZybCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=runbox.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=YVqdIVIj;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8522609FAA2;
	Mon,  2 Nov 2026 15:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8522609FAA2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=YVqdIVIj
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <m.v.b@runbox.com>)
	id 1xNu1j-009s2A-HV; Mon, 02 Nov 2026 16:32:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=OWA2XPF4LToFYnO4yT1hL4MsaiF9uOHmMKnDy9Fz0JI=; b=YVqdIVIjvx3mLyxidi6v4t9gMc
	Z8oB/yZeWggp5/Vm+IVTnA1L0Hgp3ZQXarF40oYHbjfIL0yhFPZyEk7lAHIda3o2Ece8Q5Yzm1JYb
	gi2D8lNfKPHPz4KX5In5+waa+NbQo8xqbh2f7wLNZW++DJbUvB6EqnlorPG0XAoStia2xw22Fj+BO
	YaCqoo5ehX/op6UET2f3vWf/bFziVO4cfiwp6vklC10p4QRSE2HITX1eVDGCQ50PnRyxTU/Mu48Tp
	tYaq+Sl+Pu6hNgTtfHicMBx0Xo4MJ4BK3vhOuhjYDPeA8dQo7VCcSkPm0c0sz94oYelvRmIkEBX4t
	8ADz1CLg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <m.v.b@runbox.com>)
	id 1xNu1L-0006cC-C6; Mon, 02 Nov 2026 16:32:27 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (536975)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xNu1I-00CPK3-46;
	Mon, 02 Nov 2026 16:32:24 +0100
From: "M. Vefa Bicakci" <m.v.b@runbox.com>
Date: Mon, 02 Nov 2026 07:31:55 -0800
Subject: [PATCH] x86/xen: Fix lazy MMU pause count wrap-around
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-xen-lazy-mmu-v1-1-d99a3050b76d@runbox.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3YrUPN2cxKpK3dzcUl1zi0RjM4vkxGRjQ1MloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loABmMaTXAAAAA=
X-Change-ID: 20261027-xen-lazy-mmu-78a368cac315
To: Juergen Gross <jgross@suse.com>, 
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "M. Vefa Bicakci" <m.v.b@runbox.com>
X-Mailer: b4 0.16.0

Commit bec6f41a6fe5 ("x86/xen: Get rid of last XEN_LAZY_MMU uses")
unintentionally prevents the activation of lazy MMU mode for most tasks
running on Xen PV VMs (including dom0).

That commit made xen_end_context_switch() call
__task_lazy_mmu_mode_resume() with the task being switched to. However,
the latter function decrements the pause_count field of the task without
checking whether that task's lazy MMU mode was paused or not. A task
being switched to for the first time has never been switched from, so
attempting to resume lazy MMU mode can wrap-around (underflow) the
pause_count from 0 to 255 (U8_MAX).

Furthermore, the non-zero pause_count is copied to child tasks at fork,
so all descendants (including the idle tasks of the non-boot CPUs)
inherit the non-zero pause_count. This prevents enabling lazy MMU mode
for them, because lazy_mmu_mode_enable() does not do anything when
pause_count is non-zero.

Hence, call __task_lazy_mmu_mode_resume() from xen_end_context_switch()
only if lazy MMU mode was paused.

This issue was discovered with CONFIG_DEBUG_VM=y, which enables
pause_count underflow and overflow warnings. In the examples quoted
below, the first warning shows the underflow with PID 1. The second
warning shows the overflow from 255 (U8_MAX) to 0, also for PID 1, as
indicated by the same RDI register value.

Example pause_count underflow warning:

  WARNING: include/linux/pgtable.h:362 at xen_end_context_switch+0x4e/0x60, CPU#0: swapper/0/0
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.4-1 #2 PREEMPT(full)
  RIP: e030:xen_end_context_switch+0x4e/0x60
  ...
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888004930000

Note: The PID is shown as 0 above, because current_task is updated in
__switch_to() after arch_end_context_switch(). arch_end_context_switch()
calls xen_end_context_switch() indirectly.

Example pause_count overflow warning:

  WARNING: include/linux/pgtable.h:319 at xen_start_context_switch+0x64/0x70, CPU#0: swapper/0/1
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W  7.2.4-1 #2 PREEMPT(full)
  ...
  RIP: e030:xen_start_context_switch+0x64/0x70
  ...
  RDX: 0000000000000000 RSI: 0000000013f7894d RDI: ffff888004930000
  ...
  Call Trace:
   <TASK>
   __schedule+0x36a/0x1a90
   schedule+0x27/0xa0
   schedule_timeout+0xbd/0x100
   __wait_for_common+0x97/0x1b0
   wait_for_completion_killable+0x24/0x40
   __kthread_create_on_node+0x13e/0x240
   kthread_create_worker_on_node+0xee/0x1c0
   workqueue_init+0x26/0x420
   kernel_init_freeable+0x101/0x360
   kernel_init+0x1a/0x130
   ret_from_fork+0x2b0/0x340
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Fixes: bec6f41a6fe5 ("x86/xen: Get rid of last XEN_LAZY_MMU uses")
Cc: stable@vger.kernel.org # 7.2.x
Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
---
=== Testing notes ===
This commit was tested with kernel v7.3-16755-gd135ab453a74 and v7.4-rc1
with a domU PV VM, and versions from v7.2.4 to v7.2.14 with dom0 and
domU PV VMs running on Xen v4.19.5. CONFIG_DEBUG_VM=y was set for all
tests, and no warnings were observed.

=== Debugging notes ===
For debugging, I instrumented xen_start_context_switch(),
xen_end_context_switch() and copy_process(), and I confirmed that the
inherited pause_count value is decremented for each level of the process
tree, starting from 255.

=== Credits ===
The patch was hand-written, but the commit message was polished with a
few rounds of LLM review.
---
 arch/x86/xen/enlighten_pv.c | 10 +++++++++-
 include/linux/sched.h       | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c5117a7730d6..68f8a977999b 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -431,7 +431,15 @@ static void xen_end_context_switch(struct task_struct *next)
 
 	xen_mc_flush();
 	this_cpu_write(xen_cpu_lazy_mode, false);
-	__task_lazy_mmu_mode_resume(next);
+
+	/*
+	 * A newly created task can be switched to without ever having been
+	 * switched from, so it will not have a prior lazy MMU pause to undo
+	 * from xen_start_context_switch(). Hence, resume lazy MMU only if it
+	 * was paused.
+	 */
+	if (__task_lazy_mmu_mode_paused(next))
+		__task_lazy_mmu_mode_resume(next);
 }
 
 static unsigned long xen_store_tr(void)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c93da75226e..3f9341f1f827 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1791,6 +1791,25 @@ static inline bool is_lazy_mmu_mode_active(void)
 
 	return __task_lazy_mmu_mode_active(current);
 }
+
+/**
+ * __task_lazy_mmu_mode_paused() - Return a task's lazy MMU mode pause state
+ * @tsk: The task to check.
+ *
+ * Test whether @tsk has its lazy MMU mode state set to paused
+ * (i.e., pause_count > 0).
+ *
+ * This function is intended for architectures that implement the lazy MMU
+ * mode; it must not be called from generic code.
+ *
+ * Return: Whether task @tsk has paused lazy MMU mode.
+ */
+static inline bool __task_lazy_mmu_mode_paused(struct task_struct *tsk)
+{
+	struct lazy_mmu_state *state = &tsk->lazy_mmu_state;
+
+	return state->pause_count > 0;
+}
 #endif
 
 extern struct pid __rcu *cad_pid;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261027-xen-lazy-mmu-78a368cac315

Best regards,
--  
M. Vefa Bicakci <m.v.b@runbox.com>

