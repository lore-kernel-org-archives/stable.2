Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712918;
	b=f+wI6hClafTryWYcMphhpMK0BoXZWcqX5efX479P8zdRDNcEPJN0SgsypnCgW4XOEpGN
	 QMUQtrPUag+OxOWDDc+zrZeqUnWwP9Uqn2x/hu4S/aLeiQ0tF+9oMZXKmfPbRfNVUB948
	 fWqIvdXkeH9h/Y1Y9ouLNbu4xbNF7agc7G7VTFpfStNp3L1ertjDtOWAU+NzW2Y9sbDSq
	 pIniawxfrhPFGXpmshWUvcOvjRdP6X4CFnVEPRdZ+mYBz3NnZySDpb+9qL893XBj1h8RB
	 SOwnsT1u60ZbsWiGM5A17tRoi5+PHkJXFoZzFmRnzGAvl3mmdsKFKcCP7AqFDX49BhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LmDDh8/MQLwAvDK9m1ROuVknZA0zJhX+/iYykTE0QGg=;
	b=jLQkr3VGUZfyb9ePwgA9Xu4aQQlgHsJhVNeqFmI2LXf2NqSWplInIeWhqNPfueRrK41V
	 zy+UAI4bF5VF2HgQSoji343S8VYL7PX3MvkHwAt7gqHW5rIfGe64XryYzJ5UGWajkkV3U
	 JTDWxpMDaqp5eQQrQxow++UWiyGvSOsPF7jNmLcJ6UNBRBIUDgFe5ZYRtYTOZ8IQfv/zt
	 mqEq1IsZs0uBC1ifDH8fc49FW5ZSn6cY4M/OfN8rjdeEBcHCeEkAhDajY3phDJ9oHbwk3
	 mrlS2Vs7RQGic0GyRgF+0fR8Xbu9BjY9wFNjM1sTmUKBvKH0xuvD/F8pOe0h1ZmQfyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKjBN4e1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6EC606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKjBN4e1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556821F01829;
	Thu, 22 Oct 2026 23:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792712917;
	bh=LmDDh8/MQLwAvDK9m1ROuVknZA0zJhX+/iYykTE0QGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKjBN4e1Co2BEFuhiElIyZI9/3xAaJ4Mx6yGe9hxVyqBzXTCZUQLwpflKpSTDiBgp
	 dSx08pOqKXKvl9AT42UeJktScGB15mM6aRWireUrr2eUZ1iqnMJ2+pCKi80MHDFaQY
	 xj76vHUH8VZq3EdbvVSWljgH90zb8Wan9OdqcX21EdWs6tscrxdrc1xxFwEjXdvlir
	 ngyuoSUlL1OMPcgsMlV2wnL9Op0O+hy0un75+oMiRixqUZoLMWnFdWpaDd5/5HGAzV
	 B/kqQlBQkvOCx3CnWOSQerG2QLclWgge8p+nbpmvl49tLnM/UPDs2bCXJmaB5myrl6
	 TWMgAFa81lK/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: EJ Campbell <ejc3@meta.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI context
Date: Thu, 22 Oct 2026 19:48:35 -0400
Message-ID: <20261022233056.2182401-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022233056.2182401-1-sashal@kernel.org>
References: <2026102115-flatterer-resolute-532f@gregkh>
 <20261022233056.2182401-1-sashal@kernel.org>
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

From: EJ Campbell <ejc3@meta.com>

[ Upstream commit 81d99abe2bd81379abfb595e403bbbee6fbfc624 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kvm.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 014bfe7fb91cc..e109760eefd86 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -254,11 +254,39 @@ noinstr u32 kvm_read_and_reset_apf_flags(void)
 }
 EXPORT_SYMBOL_GPL(kvm_read_and_reset_apf_flags);
 
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
+
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
 
+	flags = kvm_read_and_reset_apf_flags();
 	if (!flags)
 		return false;
 
@@ -274,8 +302,6 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		panic("Host injected async #PF in interrupt disabled region\n");
 
 	if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
-		if (unlikely(!(user_mode(regs))))
-			panic("Host injected async #PF in kernel mode\n");
 		/* Page is swapped out by the host. */
 		kvm_async_pf_task_wait_schedule(token);
 	} else {
-- 
2.53.0

