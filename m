Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516D39936D
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581636; cv=none; b=WHJdPpvNBsFtxDtUm7YIdAb9MI7SpSfue/9793kY76Mji44TP8nI0xV5rQ+h//uMCAhq6hUkXojmEBluaMyscUYigLZe8b5LvZAX14aIbUhgZKVmW+DZMeNzQl0xkQlTG7KVIIN69mmxWQsu/k8lN0wspWCb6osde1pKw9uhJ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581636; c=relaxed/simple;
	bh=Wewc9F+TZhQca7VGqF4Bz8kD6FkRhXsK/I3UHga2A4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2cT33gL7MK6DboL3UKxyYYs5ONjhdCTeT+fHrKXtrBbmFedBjnj5uPi7z3KwR46W/d2L2OPYuatgu6DMsJkaVr6qR2sNrUPtbK5T3ujodMizVAE7+u8Xb8GQn3MA0ZwkgMijNwiUiS36Bkw+0dxSymRcpYu/F29XW40N0V3LDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GUHDEJfV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rkD0d4yK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GUHDEJfV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rkD0d4yK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GUHDEJfV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rkD0d4yK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GUHDEJfV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rkD0d4yK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86E7875E91;
	Thu,  9 Jul 2026 07:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783581632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q496vngXILPwWfqdHJ5BKXlz9dCsLWw1IFEOGWhRnG0=;
	b=GUHDEJfVJ1ix9oQXqzXoumvBSZ+4nqYvdY1b/kLVDd4NRNGbL7TpSUwRyOHcaHUravfOqR
	5+ROk1YJme4jHE+gpNXkH2zip89gYBFbVzk+IaR/gFtY4PavpH8HYZIjnNGzNXyRDEjt5p
	LPvmdE5tSBvJfk342/aqGv3cqY60ct4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783581632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q496vngXILPwWfqdHJ5BKXlz9dCsLWw1IFEOGWhRnG0=;
	b=rkD0d4yK0UD916tMZ1fEXPjpl8vd191ZcSi5UKqVoSXCZlWJ4iMuPAcXebTV83MU3wGwtx
	vljlVWJWAHCa9YBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783581632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q496vngXILPwWfqdHJ5BKXlz9dCsLWw1IFEOGWhRnG0=;
	b=GUHDEJfVJ1ix9oQXqzXoumvBSZ+4nqYvdY1b/kLVDd4NRNGbL7TpSUwRyOHcaHUravfOqR
	5+ROk1YJme4jHE+gpNXkH2zip89gYBFbVzk+IaR/gFtY4PavpH8HYZIjnNGzNXyRDEjt5p
	LPvmdE5tSBvJfk342/aqGv3cqY60ct4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783581632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q496vngXILPwWfqdHJ5BKXlz9dCsLWw1IFEOGWhRnG0=;
	b=rkD0d4yK0UD916tMZ1fEXPjpl8vd191ZcSi5UKqVoSXCZlWJ4iMuPAcXebTV83MU3wGwtx
	vljlVWJWAHCa9YBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D8F4779AA;
	Thu,  9 Jul 2026 07:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WMkwCMBLT2r6QAAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 09 Jul 2026 07:20:32 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: clopez@suse.de
Cc: Sean Christopherson <seanjc@google.com>,
	syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.18.y 2/3] KVM: VMX: Grab vmcs12 on CR8 interception update iff vCPU is in guest mode
Date: Thu,  9 Jul 2026 09:17:02 +0200
Message-ID: <20260709071702.3305247-4-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260709071702.3305247-2-clopez@suse.de>
References: <20260709071702.3305247-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.80
X-Spamd-Result: default: False [-5.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[ci493c6d734b63e050];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email]
X-Spam-Level: 

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 7ef78d71ca713d8c00f7c34ddcf276c808143f77 ]

When updating CR8 intercepts, get vmcs12 if and only if the vCPU is in
guest mode so that a future change can have update CR8 intercepts during
vCPU creation, without running afoul of get_vmcs12()'s lockdep assertion.

  ------------[ cut here ]------------
  debug_locks && !(lock_is_held(&(&vcpu->mutex)->dep_map) || !refcount_read(&vcpu->kvm->users_count))
  WARNING: arch/x86/kvm/vmx/nested.h:61 at get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline], CPU#0: syz.2.19/5879
  WARNING: arch/x86/kvm/vmx/nested.h:61 at vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879, CPU#0: syz.2.19/5879
  Modules linked in:
  CPU: 0 UID: 0 PID: 5879 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
  RIP: 0010:get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline]
  RIP: 0010:vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879
  Call Trace:
   <TASK>
   apic_update_ppr arch/x86/kvm/lapic.c:984 [inline]
   kvm_lapic_reset+0x1c24/0x2980 arch/x86/kvm/lapic.c:3023
   kvm_vcpu_reset+0x44c/0x1bf0 arch/x86/kvm/x86.c:12986
   kvm_arch_vcpu_create+0x746/0x8b0 arch/x86/kvm/x86.c:12847
   kvm_vm_ioctl_create_vcpu+0x428/0x930 virt/kvm/kvm_main.c:4201
   kvm_vm_ioctl+0x893/0xd50 virt/kvm/kvm_main.c:5159
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:597 [inline]
   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

No functional change intended.

Reported-by: syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>
Closes: https://lore.kernel.org/all/6a2adf3b.3b0a2d4e.8c8d1.0012.GAE@google.com
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260618174347.1981064-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/vmx/vmx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b7798ced7b50..d7a2b75b6c91 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6734,11 +6734,10 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 
 void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
-	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	int tpr_threshold;
 
 	if (is_guest_mode(vcpu) &&
-		nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
+	    nested_cpu_has(get_vmcs12(vcpu), CPU_BASED_TPR_SHADOW))
 		return;
 
 	tpr_threshold = (irr == -1 || tpr < irr) ? 0 : irr;
-- 
2.51.0

