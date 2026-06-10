Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82B35F609
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118721; cv=none; b=k65gvJJTogKJ/+73vgtCwibukUhE5Dg/fopfumM1XHMeG28M5ccDVhAcISKufojnXznWmfD3dpog6e71d+KVYxFN+KrCIlsTGhXzlM/e7APo8AJFS2jf9qxJ686wSmlNonWPnT0B1xDYIU1YOk4RxGL2thcfR74l7HFUAtZI6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118721; c=relaxed/simple;
	bh=6qPeeETsH8DfHzoaCXPyZV/P/25z5Erm5s91u41VSZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kElLJluX+zIBLII5C72PsPLFUeCeDA4zFDNeZ/+/WAqqa6YCQB3DFLDx3n5wN6qM+l8VtJ1flyMBfPBgwDtiDy9qM28i88UMJb4ex2rNzev7Uu7lbSjZSbtb9tsZYqCQYL+VjRbX/dfgJ745JGAQ/FfXL9WB6tVa5Kqst31tv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKFRx5eL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKFRx5eL"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b828c8so9584738a91.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781118719; x=1781723519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MylOMmA1pK0Mdv0TuXqGz6CpqHZasbjFvUmh+v6hUKQ=;
        b=pKFRx5eL30rfv4woWxNOzL2wIAFNze+vf0HiHAN1fFup+DnLVj7ZVN5Vtv5Lu9V204
         ZQLsBmEGaHMKUnMMcYeyGGdsPLEkS9ouH6n91ooBLCbisRp03jflJdCDfK47GkvuGpDD
         v8ol3YyIBPQFYjf0cYE0y/wCf8o97dhsuwJdenhCCl2p1lx9FHUWMoEthwwacniXjUoR
         mRLvfNXKIl+ftP9Pqy3APY/UUHDF4pgAAY3zGAMQt50MbdQBsOZOsSkzLIHMvwGfpznm
         DNQpRRedBgJnBhwQTaM32gIK4/jl57gw+TMwiIlAZerGHNKXdAGA0fpuJ+mUnpwl9l0w
         xdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781118719; x=1781723519;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MylOMmA1pK0Mdv0TuXqGz6CpqHZasbjFvUmh+v6hUKQ=;
        b=o5o8oWKuVQIfwG6IhcbuBRcM2NiBfCi1bp9mT87Mu2MXXSZUi73m5FCynekHTlaMF7
         ZdiM+blHCTRF9WTh+nbrVPjngjFu6odcPPaKctCIqGbPl+RTDpmvkLkVsGvqo+ZXEC33
         EYvuBpQddHB1gL0ksHtlCxB1vYGRIumapCXzoJcB8f//6I5gJg2nxafHbOmU61tsba6f
         Za67sLFVY4Q7FCt5VBCbinqWedolw1z8uaEOlgTvyJ56AsR1UtzAnnsFHm/hyLkHjhIt
         f3X7g0hRZlTUa302mYbRWiAjSsEIliZIYPeBUm6AlVJ7jZU69riA2wSJCij+BGz4Bajj
         a6bQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Zj6hGZ3X528xMRNRNNe7OvipwbXyZa0FGTUVO/PZCCD4tADsU+yiAwq/LmMx1lZSd9jGndb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZoUmaNumhd1DEiMdza9aHCOGmIZ+ZqhkRXZbFJ+DfABTWTGF
	JDu86yfXhm87iyUZO4Ej10gyP3uSSDtBmC9jClqiw0W9S32J6OWCxsYnliTyi5JbVo4LFGqn03k
	RhulHUw==
X-Received: from pjez16.prod.google.com ([2002:a17:90a:150:b0:36b:be09:e0f7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5145:b0:36a:ee1:fc24
 with SMTP id 98e67ed59e1d1-370eedfff82mr28908614a91.8.1781118719080; Wed, 10
 Jun 2026 12:11:59 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:11:58 -0700
In-Reply-To: <20260610185042.2810880-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610185042.2810880-2-clopez@suse.de>
Message-ID: <aim2_s0loBcb3fav@google.com>
Subject: Re: [PATCH] KVM: VMX: Raise KVM_REQ_EVENT on TPR below threshold exit
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, osteffen@redhat.com, 
	Stefano Garzarella <sgarzare@redhat.com>, stable@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Roman Kagan <rkagan@virtuozzo.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026, Carlos L=C3=B3pez wrote:
> The TPR_THRESHOLD field in the VMCS is used by VMX to induce VM exits
> when the guest's virtual TPR falls under the specified threshold,
> allowing KVM to inject previously masked interrupts.
>=20
> KVM handles these VM exits in handle_tpr_below_threshold().
> Commit eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
> optimized this function by calling apic_update_ppr() instead of raising
> KVM_REQ_EVENT. apic_update_ppr() then raises KVM_REQ_EVENT if there is
> a pending, deliverable interrupt.
>=20
> However, if there are no new interrupts pending, apic_update_ppr()
> does not issue the request. This skips calling update_cr8_intercept(),
> and thus vmx_update_cr8_intercept() before VM entry, which results in
> a high, stale TPR_THRESHOLD. This is problematic due to the following
> sentence in 28.2.1.1 "VM-Execution Control Fields" in the SDM:
>=20
>   The following check is performed if the =E2=80=9Cuse TPR shadow=E2=80=
=9D VM-execution
>   control is 1 and the =E2=80=9Cvirtualize APIC accesses=E2=80=9D and =E2=
=80=9Cvirtual-interrupt
>   delivery=E2=80=9D VM-execution controls are both 0: the value of bits 3=
:0 of
>   the TPR threshold VM-execution control field should not be greater
>   than the value of bits 7:4 of VTPR.
>=20
> This error condition is typically not observed when KVM runs on a bare
> metal system because modern processors support APICv, which enables
> virtual-interrupt delivery, and which KVM uses when possible. This
> causes the processor to no longer generate TPR-below threshold exits
> and to no longer check TPR_THRESHOLD on entry. However, when running
> on older platforms, or under nested virtualization on a hypervisor that
> does not support virtual-interrupt delivery and enforces this check
> (like Hyper-V) this can cause a VM entry failure with hardware error
> 0x7, as seen in [1].
>=20
> Fix this by re-introducing an unconditional KVM_REQ_EVENT when reacting
> to a TPR-below-threshold exit, ensuring that vmx_update_cr8_intercept()
> is called to re-evaluate TPR_THRESHOLD before entering the guest.
>=20
> Link: https://github.com/coconut-svsm/svsm/issues/1081 [1]
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> ---
>  arch/x86/kvm/vmx/vmx.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index c548f22375ad..21a469d3ba21 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5824,6 +5824,7 @@ void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned lo=
ng val)
>  static int handle_tpr_below_threshold(struct kvm_vcpu *vcpu)
>  {
>  	kvm_apic_update_ppr(vcpu);
> +	kvm_make_request(KVM_REQ_EVENT, vcpu);
>  	return 1;
>  }

Don't all the other flows that update PPR have the same bug, at least in th=
eory?
Forcing KVM_REQ_EVENT is a bit of a hack, it seems like we should instead b=
e able
to do something like this (probably not this aggressively for stable@):

---
 arch/x86/kvm/lapic.c | 31 +++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c   | 37 ++-----------------------------------
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4078e624ca66..1b66c878bb67 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -939,6 +939,32 @@ static bool pv_eoi_test_and_clr_pending(struct kvm_vcp=
u *vcpu)
 	return val;
 }
=20
+static void update_cr8_intercept(struct kvm_vcpu *vcpu)
+{
+	int max_irr, tpr;
+
+	if (!kvm_x86_ops.update_cr8_intercept)
+		return;
+
+	if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)))
+		return;
+
+	if (vcpu->arch.apic->apicv_active)
+		return;
+
+	if (!vcpu->arch.apic->vapic_addr)
+		max_irr =3D kvm_lapic_find_highest_irr(vcpu);
+	else
+		max_irr =3D -1;
+
+	if (max_irr !=3D -1)
+		max_irr >>=3D 4;
+
+	tpr =3D kvm_lapic_get_cr8(vcpu);
+
+	kvm_x86_call(update_cr8_intercept)(vcpu, tpr, max_irr);
+}
+
 static int apic_has_interrupt_for_ppr(struct kvm_lapic *apic, u32 ppr)
 {
 	int highest_irr;
@@ -980,6 +1006,8 @@ static void apic_update_ppr(struct kvm_lapic *apic)
 	if (__apic_update_ppr(apic, &ppr) &&
 	    apic_has_interrupt_for_ppr(apic, ppr) !=3D -1)
 		kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
+	else
+		update_cr8_intercept(apic->vcpu);
 }
=20
 void kvm_apic_update_ppr(struct kvm_vcpu *vcpu)
@@ -3290,6 +3318,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct =
kvm_lapic_state *s)
 	kvm_apic_update_apicv(vcpu);
 	if (apic->apicv_active)
 		kvm_x86_call(apicv_post_state_restore)(vcpu);
+
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
=20
 #ifdef CONFIG_KVM_IOAPIC
@@ -3394,6 +3423,8 @@ void kvm_lapic_sync_to_vapic(struct kvm_vcpu *vcpu)
 	int max_irr, max_isr;
 	struct kvm_lapic *apic =3D vcpu->arch.apic;
=20
+	update_cr8_intercept(vcpu);
+
 	apic_sync_pv_eoi_to_guest(vcpu, apic);
=20
 	if (!test_bit(KVM_APIC_CHECK_VAPIC, &vcpu->arch.apic_attention))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0550359ed798..116ce6209c67 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -128,7 +128,6 @@ static u64 __read_mostly efer_reserved_bits =3D ~((u64)=
EFER_SCE);
 				    KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST	| \
 				    KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
=20
-static void update_cr8_intercept(struct kvm_vcpu *vcpu);
 static void process_nmi(struct kvm_vcpu *vcpu);
 static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 static void store_regs(struct kvm_vcpu *vcpu);
@@ -5340,7 +5339,6 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *=
vcpu,
 	r =3D kvm_apic_set_state(vcpu, s);
 	if (r)
 		return r;
-	update_cr8_intercept(vcpu);
=20
 	return 0;
 }
@@ -10595,33 +10593,6 @@ static void post_kvm_run_save(struct kvm_vcpu *vcp=
u)
 		kvm_run->flags |=3D KVM_RUN_X86_GUEST_MODE;
 }
=20
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
-		max_irr =3D kvm_lapic_find_highest_irr(vcpu);
-	else
-		max_irr =3D -1;
-
-	if (max_irr !=3D -1)
-		max_irr >>=3D 4;
-
-	tpr =3D kvm_lapic_get_cr8(vcpu);
-
-	kvm_x86_call(update_cr8_intercept)(vcpu, tpr, max_irr);
-}
-
-
 int kvm_check_nested_events(struct kvm_vcpu *vcpu)
 {
 	if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
@@ -11361,10 +11332,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (req_int_win)
 			kvm_x86_call(enable_irq_window)(vcpu);
=20
-		if (kvm_lapic_enabled(vcpu)) {
-			update_cr8_intercept(vcpu);
+		if (kvm_lapic_enabled(vcpu))
 			kvm_lapic_sync_to_vapic(vcpu);
-		}
 	}
=20
 	r =3D kvm_mmu_reload(vcpu);
@@ -12481,8 +12450,6 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu=
, struct kvm_sregs *sregs,
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
 	kvm_x86_call(post_set_cr3)(vcpu, sregs->cr3);
=20
-	kvm_set_cr8(vcpu, sregs->cr8);
-
 	*mmu_reset_needed |=3D vcpu->arch.efer !=3D sregs->efer;
 	kvm_x86_call(set_efer)(vcpu, sregs->efer);
=20
@@ -12511,7 +12478,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu=
, struct kvm_sregs *sregs,
 	kvm_set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	kvm_set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
=20
-	update_cr8_intercept(vcpu);
+	kvm_set_cr8(vcpu, sregs->cr8);
=20
 	/* Older userspace won't unhalt the vcpu on reset. */
 	if (kvm_vcpu_is_bsp(vcpu) && kvm_rip_read(vcpu) =3D=3D 0xfff0 &&

base-commit: fd408f8da71c91d589cf05674c2e114fc2267b31
--=20

