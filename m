Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758061;
	b=s0PgPajVEvxwiCUzLQIZCSq5AXr+HTDWCNYZeyTjRz0bkheAaVg3g2e5CUesuJEgXzVz
	 +GBirObtNQH6U+EQ3HBii98GJCaEh6IOtS30cp1rBwCNsA6US5RlfFtnCayPxgy41qpOk
	 fHsKq8bqa2euDegM9NfnVlgz/DJ1pHnHwPA2lnOn6B1NFnhJuekcQzfO8cAok0jVr9uCV
	 3es8Oqg7WLmZK7bVVre7SCA7y/1HNBO6D0qJPa4wfhcMhzj2cWslfoGekizLg865ZU2s9
	 GxCBQK7e418sCTOfd/zVTjB7JqrvgKALjSTBIpB3SHX+wH2LPWt/NSJuEEWCblk+n+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758061;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5PSCS4KfkNR+foAg2exE+GWPI9yhDgyVs19jUVF0aVY=;
	b=M+02P2pOHPUUeiJu9O5rsnqpaVrxghmS7KOvcGKwOBlGX/zq376r0jCeD69suz/R0ghz
	 eKhOrE200bUEQYZChBEcI4xGziH2SnFSxD8ECU2bjAUYlFM+gqYzR/OOgGC0QTor26+xv
	 AD5HUa8dwRnwi/OABEiH1sp6umI1NYsdnbhnT+kmIqiuOljGb/wbKnLBU/o7yExSxWO44
	 jdCfBhJAl5EsdCs299/ky4ZzWBq4bD4PzLEl46a7erPwE/YEbTFHTBp9pSlQZQ/ylpWZh
	 khiG7a+7TnFlb+J3Suscl2k4qxIu7eS/rJC1APh/SvNnGCiONjm/FIEUYJSf+JnAFhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0oeNmap;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525D606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0oeNmap
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACED1F01825;
	Fri, 23 Oct 2026 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792758060;
	bh=5PSCS4KfkNR+foAg2exE+GWPI9yhDgyVs19jUVF0aVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0oeNmapJh953kkWP5pb6Kv7K5Gi/mu2dfjvX+eNBuGutgl3+N4HQaJeXyT2++D48
	 u8mTczIh65xrs5Pz7fUU94qotcpm41xXeLaoE+JclctVfNGcOGlQEjm7Ume1xOqYdy
	 V+ZkgP8RFhFJTJTQ39BBia2MP0O4x/Uw1TzA0gqzOWmcfMO20YYr0ZsVMwNpSgc8u2
	 8toZm5G/j/FNzubVnLMWiw5bXhAZ7LU5a0ovXMMAg6wBkh/oiN0cyoJGoD9ugixTRs
	 LXVO7m9c+2WrEtOvi8tibp7rEJkhEaT4WY3M8ylNYU7CAneUpNSF0BBOycLwEaXk1t
	 Mz82PIlyrytcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: EJ Campbell <ejc3@meta.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI context
Date: Fri, 23 Oct 2026 08:20:58 -0400
Message-ID: <20261023120705.2303010-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102116-champion-appliance-bfe2@gregkh>
References: <2026102116-champion-appliance-bfe2@gregkh>
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
[ sashal: Inlined the pending-reason check using apf_reason.enabled instead of async_pf_enabled. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kvm.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index d7d2eb79120d6..41e685ba9fa1c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -253,9 +253,32 @@ EXPORT_SYMBOL_GPL(kvm_read_and_reset_apf_flags);
 
 noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
-	u32 flags = kvm_read_and_reset_apf_flags();
 	irqentry_state_t state;
+	u32 flags;
 
+	if (!__this_cpu_read(apf_reason.enabled) ||
+	    !__this_cpu_read(apf_reason.flags))
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
 
@@ -271,8 +294,6 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		panic("Host injected async #PF in interrupt disabled region\n");
 
 	if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
-		if (unlikely(!(user_mode(regs))))
-			panic("Host injected async #PF in kernel mode\n");
 		/* Page is swapped out by the host. */
 		kvm_async_pf_task_wait_schedule(token);
 	} else {
-- 
2.53.0

