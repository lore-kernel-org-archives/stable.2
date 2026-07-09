Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0133C9ED8
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581915; cv=none; b=bsiOASP8F+wbjMWV0A8/aognK56xUnEzZIKRI+BicfMp9zPQI7ixTKdsT+NpVoCBxQ1YwcqpX1S27tkTxrQ7ol8m6tbKE1djBzYsdz7ncOjAtfwKYSBH+9LYb8cLGTda7ifwG1c4f3gCfh36seMw0lBaDgn5svXDFTJrjLuNH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581915; c=relaxed/simple;
	bh=KOD7UqK/Gsr1GMCwAWBoxxhsx3YxU1A3/+K+YYfTR78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMsZndpp1LoGBQ2RjVv64tQVyA9fAa3Q/DvAGLGzImg86Wph7ThB35Asj54q5DDQqNC2ce+mqCLB7ogTimZvA5Bh3BnOB7qHhQQOV6GlMWeCWE+9msC0SbdFSdPkbkgixVFXBGvNz2K4bOTmZd0wsm+aj0PRNTUG1Wvca/zFh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AIu4eMbk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bblYPBg4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AIu4eMbk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bblYPBg4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AIu4eMbk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bblYPBg4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AIu4eMbk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bblYPBg4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4AF975EDB;
	Thu,  9 Jul 2026 07:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783581900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fOZKDGk+S46/+SCiwB50GnE9K+E/ngWl9K/xtzn9FQ=;
	b=AIu4eMbkyrgyrrMltON14KJyw345nscJVkUAdeQy3ZfltSoJsOIBdwYvzt1pELC/er+dDt
	8Iks/bhE/5K/NRRQeGM8wc5JYNj5qy7NL4EMwMoPjUHUZbxyB20DSLACkCZbGcTuvpjYIE
	wWZzaiVVEbljC9Lcsn9SHeABiu+Kxrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783581900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fOZKDGk+S46/+SCiwB50GnE9K+E/ngWl9K/xtzn9FQ=;
	b=bblYPBg4fupOtI5orqLiRLRx9pm8VUahqpe13HzGPpJA+hW6nVuIZm+eyD1rG2AZF1FqMy
	Qeyb4lBZ817vlaDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783581900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fOZKDGk+S46/+SCiwB50GnE9K+E/ngWl9K/xtzn9FQ=;
	b=AIu4eMbkyrgyrrMltON14KJyw345nscJVkUAdeQy3ZfltSoJsOIBdwYvzt1pELC/er+dDt
	8Iks/bhE/5K/NRRQeGM8wc5JYNj5qy7NL4EMwMoPjUHUZbxyB20DSLACkCZbGcTuvpjYIE
	wWZzaiVVEbljC9Lcsn9SHeABiu+Kxrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783581900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fOZKDGk+S46/+SCiwB50GnE9K+E/ngWl9K/xtzn9FQ=;
	b=bblYPBg4fupOtI5orqLiRLRx9pm8VUahqpe13HzGPpJA+hW6nVuIZm+eyD1rG2AZF1FqMy
	Qeyb4lBZ817vlaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDED1779AA;
	Thu,  9 Jul 2026 07:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gLVGM8tMT2rTRQAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 09 Jul 2026 07:24:59 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: stable@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH RESEND 6.18.y 3/3] KVM: x86: Unconditionally recompute CR8 intercept on PPR update
Date: Thu,  9 Jul 2026 09:22:47 +0200
Message-ID: <20260709072247.3305784-5-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260709072247.3305784-2-clopez@suse.de>
References: <20260709072247.3305784-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -7.30
X-Spamd-Result: default: False [-7.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtm3bmjtwwfkzb5ddzerbmdsq)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

[ Upstream commit bb365a506b1e6fb050c0fceaad354fe395385ef0 ]

The TPR_THRESHOLD field in the VMCS is used by VMX to induce VM exits
when the guest's virtual TPR falls under the specified threshold,
allowing KVM to inject previously masked interrupts.

KVM handles these VM exits in handle_tpr_below_threshold().
Commit eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
optimized this function by calling apic_update_ppr() instead of raising
KVM_REQ_EVENT. apic_update_ppr() then raises KVM_REQ_EVENT if there is
a pending, deliverable interrupt.

However, if there are no new interrupts pending, apic_update_ppr() does
not issue the request. Thus, kvm_lapic_update_cr8_intercept() and
vmx_update_cr8_intercept() are not called before VM entry, which results
in a high, stale TPR_THRESHOLD. This is problematic due to the following
sentence in 28.2.1.1 "VM-Execution Control Fields" in the SDM:

  The following check is performed if the “use TPR shadow” VM-execution
  control is 1 and the “virtualize APIC accesses” and “virtual-interrupt
  delivery” VM-execution controls are both 0: the value of bits 3:0 of
  the TPR threshold VM-execution control field should not be greater
  than the value of bits 7:4 of VTPR.

This error condition is typically not observed when KVM runs on a bare
metal system because modern processors support APICv, which enables
virtual-interrupt delivery, and which KVM uses when possible. This
causes the processor to no longer generate TPR-below-threshold exits
and to no longer check TPR_THRESHOLD on entry. However, when running
on older platforms, or under nested virtualization on a hypervisor that
does not support virtual-interrupt delivery and enforces this check
(like Hyper-V) this can cause a VM entry failure with hardware error
0x7, as seen in [1].

Call kvm_lapic_update_cr8_intercept() if apic_update_ppr() does not
find a deliverable interrupt (and thus does not raise KVM_REQ_EVENT).
Remove calls to kvm_lapic_update_cr8_intercept() on paths that end up in
apic_update_ppr(), as they now become redundant. This ensures that any
path that updates the guest's PPR also figures out if KVM needs to wait
for a TPR change (using TPR_THRESHOLD on VMX or CR8 intercepts on SVM).

Link: https://github.com/coconut-svsm/svsm/issues/1081 [1]
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Cc: stable@vger.kernel.org
Fixes: eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
Signed-off-by: Carlos López <clopez@suse.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260618174347.1981064-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/lapic.c | 2 ++
 arch/x86/kvm/x86.c   | 5 +----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4a6a8d8c7626..fe2806348c94 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1001,6 +1001,8 @@ static void apic_update_ppr(struct kvm_lapic *apic)
 	if (__apic_update_ppr(apic, &ppr) &&
 	    apic_has_interrupt_for_ppr(apic, ppr) != -1)
 		kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
+	else
+		kvm_lapic_update_cr8_intercept(apic->vcpu);
 }
 
 void kvm_apic_update_ppr(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 28771be285a1..7be3ed9e2c7d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5356,7 +5356,6 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
 	r = kvm_apic_set_state(vcpu, s);
 	if (r)
 		return r;
-	kvm_lapic_update_cr8_intercept(vcpu);
 
 	return 0;
 }
@@ -12366,8 +12365,6 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
 	kvm_x86_call(post_set_cr3)(vcpu, sregs->cr3);
 
-	kvm_set_cr8(vcpu, sregs->cr8);
-
 	*mmu_reset_needed |= vcpu->arch.efer != sregs->efer;
 	kvm_x86_call(set_efer)(vcpu, sregs->efer);
 
@@ -12396,7 +12393,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	kvm_set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	kvm_set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
-	kvm_lapic_update_cr8_intercept(vcpu);
+	kvm_set_cr8(vcpu, sregs->cr8);
 
 	/* Older userspace won't unhalt the vcpu on reset. */
 	if (kvm_vcpu_is_bsp(vcpu) && kvm_rip_read(vcpu) == 0xfff0 &&
-- 
2.51.0

