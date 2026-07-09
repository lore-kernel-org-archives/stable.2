Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED43C9891
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581903; cv=none; b=MutEIHTfdNYsaGY2HfXnkSYMeSyJWsYmeIAyV25Ps6phxojmJj9FFyeIZl7laFopE90TkGVilz8Z3s8yx5DmpN6AHs3efYbnBQHBZHWiYIh7M5av/oxQSmgMoApNJ2CW/aslhB7RzgO0VMt0L5YFidbgyCV/9NukKMvfChWHYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581903; c=relaxed/simple;
	bh=jDaqyNXV9kaMALfwISz6wPI/xD4abBv+7BeOBqe/BOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sz7wLraRolB5G1O6nm2dhtdbQj48efM4S3LfSawtrcCUmyduGfTI1MOxruos6gpKVNo5crEoYlgVfpznRT7KqHW+XtyXC14MJUWfIfTSPdhP1WulMJDRhgw+tCVRbLIFxCWsIEE99+zLPFbcy9V9G4lrlxwgMtdKRgYPE05f24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Oebz7QQk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zorn/MCh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cHZyJAeN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wsBDa5ni; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Oebz7QQk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zorn/MCh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cHZyJAeN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wsBDa5ni"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94E3475EA6;
	Thu,  9 Jul 2026 07:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783581899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeVNNw0gBYQYNiJxGYYYMLg54oa8jgdcenq3Z938QvU=;
	b=Oebz7QQkWOyttiJM84BTmh2An54xWIGQJ0cp3EbDgQSaC93pqaTQ+4+oCdUDMFIoVCHmIF
	0VOHBATGf0TE44HpAfMzT3VNk+bE4f7HOzGtvoriaXCTFEX3LsFMe9zYs9zO5czbgJAEcm
	7ys6BavCQ+QYxgxM5FcEzXmEdCvLX38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783581899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeVNNw0gBYQYNiJxGYYYMLg54oa8jgdcenq3Z938QvU=;
	b=zorn/MChMEymvDECwvvEXt9hr2v4llw2lqxZRx3v7inQ0HkDdG/ixe1fJ8gQnzccyK0bNt
	nLZEyIF6ZYyJQhCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783581898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeVNNw0gBYQYNiJxGYYYMLg54oa8jgdcenq3Z938QvU=;
	b=cHZyJAeNvrzqAaIzI6MJ89YJvKJOpn1zW8ZHNIYcIEI5pPiFRFoEJP2InsWjBx4M3vF3bZ
	EKeRAxjf0K32KYLer0gA6GuUT2pgeCH63wQbkDtwJrC5O6a5nkuX2m/Xy3EZZiaEOKe1p6
	Tvft5SFkvKWYLCeAyyCHZnrPBB3HnaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783581898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeVNNw0gBYQYNiJxGYYYMLg54oa8jgdcenq3Z938QvU=;
	b=wsBDa5niIjg5GYj51CRn+rj14PbIxRTWvzp4k5FU/U0bpI6NuU85rCbhumY0fYXxRvu6oi
	sWYCtweRKCZgctAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF32A779AA;
	Thu,  9 Jul 2026 07:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iJLIK8lMT2rTRQAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 09 Jul 2026 07:24:57 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: stable@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND 6.18.y 1/3] KVM: x86: Move update_cr8_intercept() to lapic.c
Date: Thu,  9 Jul 2026 09:22:45 +0200
Message-ID: <20260709072247.3305784-3-clopez@suse.de>
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
X-Spamd-Result: default: False [-7.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtm3bmjtwwfkzb5ddzerbmdsq)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,msgid.link:url,suse.de:email,suse.de:mid,intel.com:email]
X-Spam-Level: 
X-Spam-Score: -7.30

From: Sean Christopherson <seanjc@google.com>

[ Upstream Commit c7722e5e1daeeabbd9f969554d52bb7158120b27 ]

Move update_cr8_intercept() to lapic.c so that it's globally visible
in anticipation of extracting most of the register-specific code out of
x86.c and into a new compilation unit.  Opportunistically prefix the
helper kvm_lapic_ to make its role/scope more obvious.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260529222223.870923-14-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/lapic.c | 26 ++++++++++++++++++++++++++
 arch/x86/kvm/lapic.h |  1 +
 arch/x86/kvm/x86.c   | 34 +++-------------------------------
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0e842dad4194..4a6a8d8c7626 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2754,6 +2754,32 @@ u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu)
 	return (tpr & 0xf0) >> 4;
 }
 
+void kvm_lapic_update_cr8_intercept(struct kvm_vcpu *vcpu)
+{
+	int max_irr, tpr;
+
+	if (!kvm_x86_ops.update_cr8_intercept)
+		return;
+
+	if (!lapic_in_kernel(vcpu))
+		return;
+
+	if (vcpu->arch.apic->apicv_active)
+		return;
+
+	if (!vcpu->arch.apic->vapic_addr)
+		max_irr = kvm_lapic_find_highest_irr(vcpu);
+	else
+		max_irr = -1;
+
+	if (max_irr != -1)
+		max_irr >>= 4;
+
+	tpr = kvm_lapic_get_cr8(vcpu);
+
+	kvm_x86_call(update_cr8_intercept)(vcpu, tpr, max_irr);
+}
+
 static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
 {
 	u64 old_value = vcpu->arch.apic_base;
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index e5f5a222eced..959380b4c067 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -100,6 +100,7 @@ int kvm_apic_accept_events(struct kvm_vcpu *vcpu);
 void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event);
 u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lapic_set_tpr(struct kvm_vcpu *vcpu, unsigned long cr8);
+void kvm_lapic_update_cr8_intercept(struct kvm_vcpu *vcpu);
 void kvm_lapic_set_eoi(struct kvm_vcpu *vcpu);
 void kvm_apic_set_version(struct kvm_vcpu *vcpu);
 void kvm_apic_after_set_mcg_cap(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a21ebe04aa23..28771be285a1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -126,7 +126,6 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 				    KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST	| \
 				    KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu);
 static void process_nmi(struct kvm_vcpu *vcpu);
 static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 static void store_regs(struct kvm_vcpu *vcpu);
@@ -5357,7 +5356,7 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
 	r = kvm_apic_set_state(vcpu, s);
 	if (r)
 		return r;
-	update_cr8_intercept(vcpu);
+	kvm_lapic_update_cr8_intercept(vcpu);
 
 	return 0;
 }
@@ -10565,33 +10564,6 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 		kvm_run->flags |= KVM_RUN_X86_GUEST_MODE;
 }
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu)
-{
-	int max_irr, tpr;
-
-	if (!kvm_x86_ops.update_cr8_intercept)
-		return;
-
-	if (!lapic_in_kernel(vcpu))
-		return;
-
-	if (vcpu->arch.apic->apicv_active)
-		return;
-
-	if (!vcpu->arch.apic->vapic_addr)
-		max_irr = kvm_lapic_find_highest_irr(vcpu);
-	else
-		max_irr = -1;
-
-	if (max_irr != -1)
-		max_irr >>= 4;
-
-	tpr = kvm_lapic_get_cr8(vcpu);
-
-	kvm_x86_call(update_cr8_intercept)(vcpu, tpr, max_irr);
-}
-
-
 int kvm_check_nested_events(struct kvm_vcpu *vcpu)
 {
 	if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
@@ -11298,7 +11270,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			kvm_x86_call(enable_irq_window)(vcpu);
 
 		if (kvm_lapic_enabled(vcpu)) {
-			update_cr8_intercept(vcpu);
+			kvm_lapic_update_cr8_intercept(vcpu);
 			kvm_lapic_sync_to_vapic(vcpu);
 		}
 	}
@@ -12424,7 +12396,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	kvm_set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	kvm_set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
-	update_cr8_intercept(vcpu);
+	kvm_lapic_update_cr8_intercept(vcpu);
 
 	/* Older userspace won't unhalt the vcpu on reset. */
 	if (kvm_vcpu_is_bsp(vcpu) && kvm_rip_read(vcpu) == 0xfff0 &&
-- 
2.51.0

