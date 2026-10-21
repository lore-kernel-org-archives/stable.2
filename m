Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608821;
	b=XDXtoyQkZvT/MO/t80UOScxeiHudZAn0rwKOB0eA0t36u5H6EbVVwwe0tECYGmQOl50I
	 CzYeLmIywMMz7GUsDx6bYC21yDB5THVmi9IWH3I6xyjZMnOJ0N5T+fqoPs8enLP0K2zAB
	 Enwaab5SmEBc37UvuRASYxQfBzij4hDaG5QIONQVl4MqJrCbcxeWRknc1UmF8Y8BiggQU
	 8nuVbWSKvTBvqWgoCDkjcxZtPR5tPNLkX0i0p01U4YznUhs9yiJHc0/LELpuSMZtdfdLA
	 nOLjGGHu+bHz03O5kqWn8lfLyCAbP/NMwmm+fxSAGKiUPCbrUfXgQULj2OFcBGYhnKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608821;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LNBtaaADrjuie4hs9LMEj8wsMQkpS1JPr6xfz8m980Q=;
	b=1mTE67+7E5McX9LO+odE2UmjwubEPrPFMiknColoBZpfgiXZRN9vSoGx6itulRNMgp9M
	 M2WC/o1L+f0O3Qqk2HwXM0fxbw9S2GSsaCWgqYAk6EJzjshLp0gqwojgsN2fgHTKpU4p7
	 /tJf1gmyNoGAa381LDts8N0usfYjnU599MPR8IrEGyHNNZen8brsJFsrUq6UB7JWCer5B
	 31WavafDwG+Nb+HkCxJtjDdGQSFKrCIEJdpJDBZLv5AMgrKTo1yhY+FS09TlaJy7kXNiN
	 70m6/G8OGMN/bHPS8eP80FCHFpL8g8jrHEzs8+yf4D281HuIm07aPLbHjGrYu58CwCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QZVnHdjr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA3606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QZVnHdjr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D001E1F000C1;
	Wed, 21 Oct 2026 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792608820;
	bh=LNBtaaADrjuie4hs9LMEj8wsMQkpS1JPr6xfz8m980Q=;
	h=Subject:To:Cc:From:Date;
	b=QZVnHdjrS4Chp1mcOzEs9UYoje2AZaZU2MTEaylLeRi3WUNTXo/l3t3D/p5H+rIGZ
	 nAe3JIqrWunY1tWfwpjtYU4WXGVbk1j9sNmAMgdH9DqdQwAumtouKmMfbDWt2kIjwV
	 NI9z7ZNzBVtorbP1172lB/e+xk9Ik/qjg9fwFVQs=
Subject: FAILED: patch "[PATCH] x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI" failed to apply to 5.15-stable tree
To: ejc3@meta.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 20:50:16 +0200
Message-ID: <2026102116-motion-upchuck-3417@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 81d99abe2bd81379abfb595e403bbbee6fbfc624
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102116-motion-upchuck-3417@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81d99abe2bd81379abfb595e403bbbee6fbfc624 Mon Sep 17 00:00:00 2001
From: EJ Campbell <ejc3@meta.com>
Date: Tue, 29 Sep 2026 11:12:32 -0700
Subject: [PATCH] x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI
 context

An async #PF "page not present" event arrives through the #PF vector,
and its reason sits in the per-CPU apf_reason.flags until
__kvm_handle_async_pf() reads and clears it. If an NMI arrives after
the event is injected and before the #PF handler reads the flags, and
the NMI handler itself takes a #PF, that fault reads and clears the
flags belonging to the #PF it interrupted. It then finds interrupts
disabled in the NMI context it interrupted, and panics:

  Kernel panic - not syncing: Host injected async #PF in interrupt
disabled region
  Call Trace:
   <NMI>
   panic+0x52/0x60
   __kvm_handle_async_pf+0xb0/0xb0
   exc_page_fault+0x71/0xb0
   asm_exc_page_fault+0x27/0x30
  RIP: 0010:__get_user_nocheck_8+0x6/0x20
   perf_callchain_user+0x147/0x1a0
   get_perf_callchain+0x12d/0x1c0
   ...
   perf_event_nmi_handler+0x26/0x50
   exc_nmi+0xe8/0x110
  RIP: 0010:asm_exc_page_fault+0x0/0x30
   </NMI>

The last RIP line shows the NMI landing on the first instruction of
the #PF entry. perf with user call chains takes such a fault: the
sampling NMI walks the user stack with __get_user(), which faults when
a saved frame pointer is not a valid user address or the walk runs off
the top of the stack. The same window exists when KVM, running as an
L1 hypervisor with DELIVERY_AS_PF_VMEXIT, reads the flags itself after
a #PF VM-exit.

The NMI entry code saves and restores CR2 for this nesting, but not the
async #PF reason. Andy Lutomirski described the race, with perf as the
example, when async #PF delivery was reworked in 2020 [1]. Saving and
clearing the flags across the NMI, next to CR2, was discussed there but
not merged.

Since that rework, Linux has stopped setting KVM_ASYNC_PF_SEND_ALWAYS,
so the host delivers "page not present" only for user mode faults and
a kernel-mode fault in NMI context (including kernel-mode #MC and #DB)
cannot be an async page fault.  In that case, return without touching
the flags so that the interrupted handler finds them intact.

Tested on v7.3-rc5 in a 4-vCPU, 2 GiB guest restored from a snapshot
whose memory is served on demand through userfaultfd, so that reading
it back takes async #PFs, while every thread samples hardware cycles
with user call chains and points its frame pointer at an unmapped page.
Without this patch the guest panicked as above in 3 of 3 runs. With it,
the guest survived 3 of 3 runs of 60 seconds, and the host counted
148,441 to 153,334 kvm_async_pf_not_present events in the first 20
seconds of each. On 6.18.50 the results were the same: the guest
panicked without the patch and survived with it.

Link: https://lore.kernel.org/all/ed71d0967113a35f670a9625a058b8e6e0b2f104.1583547991.git.luto@kernel.org/ [1]
Link: https://lore.kernel.org/all/20211126123145.2772-1-jiangshanlai@gmail.com/ [2]
Cc: stable@vger.kernel.org # v5.9+
Signed-off-by: EJ Campbell <ejc3@meta.com>
Link: https://patch.msgid.link/CADkxfh-uQTca_6jB1JPDq1MsKffF_UKGQR339oQSJNcoV75GNQ@mail.gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 6b0a5861ccb8..d8dd2cadcbf7 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -265,11 +265,39 @@ noinstr u32 kvm_read_and_reset_apf_flags(void)
 }
 EXPORT_SYMBOL_FOR_KVM(kvm_read_and_reset_apf_flags);
 
+static __always_inline bool kvm_apf_reason_pending(void)
+{
+	return __this_cpu_read(async_pf_enabled) &&
+	       __this_cpu_read(apf_reason.flags);
+}
+
 noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
-	u32 flags = kvm_read_and_reset_apf_flags();
 	irqentry_state_t state;
+	u32 flags;
 
+	if (!kvm_apf_reason_pending())
+		return false;
+
+	/*
+	 * The guest does not enable KVM_ASYNC_PF_SEND_ALWAYS, so the host
+	 * delivers async #PF only to user mode (or as a #PF VM-exit, which KVM
+	 * reads itself). A #PF from kernel mode can still arrive between that
+	 * delivery and the read of the reason flags, inside an NMI that
+	 * interrupted it, for instance perf reading user memory for a call
+	 * chain. Such a fault is not async, so leave the async PF flags
+	 * untouched for the outer handler.  Outside NMI context, on the other
+	 * hand, async PF flags on a kernel-mode fault mean the host is broken.
+	 */
+	if (!user_mode(regs)) {
+		if (likely(in_nmi()))
+			return false;
+		state = irqentry_enter(regs);
+		instrumentation_begin();
+		panic("Host injected async #PF in kernel mode\n");
+	}
+
+	flags = kvm_read_and_reset_apf_flags();
 	if (!flags)
 		return false;
 
@@ -285,8 +313,6 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		panic("Host injected async #PF in interrupt disabled region\n");
 
 	if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
-		if (unlikely(!(user_mode(regs))))
-			panic("Host injected async #PF in kernel mode\n");
 		/* Page is swapped out by the host. */
 		kvm_async_pf_task_wait_schedule(token);
 	} else {

