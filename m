Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6F652ED3D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950740; cv=none; b=CanEi6MwQELOT/wU5Jh9/4kkApjQK3/U5ytrXv0h7aF44b+3h+luUi0WEpffKuy5efzeAss/blM8RI959U2uBTPOMoAhNQAV++3tGiWORIdeZsPj53CuOotDzoTYoco8Kq4cFK71ut+3qzRvLWyHUaOpdXEImtH8VPcXCpOXraI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950740; c=relaxed/simple;
	bh=XGmRvx9RxOwFBRxy3bfDCOT4v86ZfyJXm8Hdtn8dmTg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KXfZGZWLy3geMINr3JxM+L4wnEIwsMQbXcegypV4reReGA5gteIiIU5/mWthGA4oxdpEIUdhKI0JKCn8oOm6xFEevRrxvBFWKWVYv9FmCV2ct3sn304bKRX8fhQyemeXgYF/j7BZWdEOYqnNsNLCYWHM4VDg5aNN/Hdba643O4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g5HQyi2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g5HQyi2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465A01F00A3D;
	Wed,  9 Sep 2026 10:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950738;
	bh=pxT2WsZ9r3Nzukc1D3tdaIVGfN+4qv6E/s9CVHsC8uc=;
	h=Subject:To:Cc:From:Date;
	b=g5HQyi2jGFYui2wbnQgkQRJjUVTh9PpRf6u7mS8fxXwZHV8o8aKd3wKVPTc/IkCi3
	 nZFqrAR80EPDdi13hhxGvP3IzXXWzUsqr7hlp+6i2tRTPI+zwpn9IT/A2050yv6Sez
	 cvgYt/7qqmZyy0EVhOQF2SLtkn4Rxmxo4Iq156b4=
Subject: FAILED: patch "[PATCH] KVM: arm64: Remove VM-wide VNCR mapping counter" failed to apply to 6.18-stable tree
To: maz@kernel.org,ljs@kernel.org,oupton@kernel.org,yaoyuan@linux.alibaba.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:36:50 +0200
Message-ID: <2026090950-contact-impatient-f4fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c55bc773b6e814406658fae7dc5c15f639ed816e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090950-contact-impatient-f4fb@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c55bc773b6e814406658fae7dc5c15f639ed816e Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 6 Aug 2026 10:10:19 +0100
Subject: [PATCH] KVM: arm64: Remove VM-wide VNCR mapping counter

The global VNCR mapping counter is used to decide whether an L1
provided VNCR page is mapped in L0 on any CPU at the point of
dealing with a TLB invalidation. It is incremented when a mapping
is made in the fixmap, and decremented when unmapped.

As it turns out, this tracking has several flaws:

- we are trying to invalidate TLBs, and the mapping is only an
  opportunistic consequence of the TLB. Checking this counter to
  decide whether a TLB needs to be invalidated may result in missed
  invalidations.

- an L1 vcpu invalidating its own TLB (a very likely case) will not
  succeed in invalidating the VNCR pseudo TLB because that page is
  not mapped in L0 at this stage.

Given that this tracking fails at delivering the minimum guarantees
that are required and is only a performance optimisation, remove it
completely.

Fixes: 4ffa72ad8f37e ("KVM: arm64: nv: Add S1 TLB invalidation primitive for VNCR_EL2")
Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Link: https://patch.msgid.link/20260806091026.620700-2-maz@kernel.org
Signed-off-by: Oliver Upton <oupton@kernel.org>

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bae2c4f92ef5..ac16f96c878d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -411,9 +411,6 @@ struct kvm_arch {
 	/* Masks for VNCR-backed and general EL2 sysregs */
 	struct kvm_sysreg_masks	*sysreg_masks;
 
-	/* Count the number of VNCR_EL2 currently mapped */
-	atomic_t vncr_map_count;
-
 	/*
 	 * For an untrusted host VM, 'pkvm.handle' is used to lookup
 	 * the associated pKVM instance in the hypervisor.
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index bbe9cebd3d9d..c09b1d411c58 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -427,8 +427,7 @@ static bool kvm_hyp_handle_tlbi_el2(struct kvm_vcpu *vcpu, u64 *exit_code)
 	 * If we have to check for any VNCR mapping being invalidated,
 	 * go back to the slow path for further processing.
 	 */
-	if (vcpu_el2_e2h_is_set(vcpu) && vcpu_el2_tge_is_set(vcpu) &&
-	    atomic_read(&vcpu->kvm->arch.vncr_map_count))
+	if (vcpu_el2_e2h_is_set(vcpu) && vcpu_el2_tge_is_set(vcpu))
 		return false;
 
 	__kvm_skip_instr(vcpu);
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index dfb96edbdc43..f3c75954cf36 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -48,7 +48,6 @@ void kvm_init_nested(struct kvm *kvm)
 {
 	kvm->arch.nested_mmus = NULL;
 	kvm->arch.nested_mmus_size = 0;
-	atomic_set(&kvm->arch.vncr_map_count, 0);
 }
 
 static int init_nested_s2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
@@ -890,7 +889,6 @@ static void this_cpu_reset_vncr_fixmap(struct kvm_vcpu *vcpu)
 	clear_fixmap(vncr_fixmap(vcpu->arch.vncr_tlb->cpu));
 	vcpu->arch.vncr_tlb->cpu = -1;
 	host_data_clear_flag(L1_VNCR_MAPPED);
-	atomic_dec(&vcpu->kvm->arch.vncr_map_count);
 }
 
 void kvm_vcpu_put_hw_mmu(struct kvm_vcpu *vcpu)
@@ -1592,7 +1590,6 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 	if (pgprot_val(prot) != pgprot_val(PAGE_NONE)) {
 		__set_fixmap(vncr_fixmap(vt->cpu), vt->hpa, prot);
 		host_data_set_flag(L1_VNCR_MAPPED);
-		atomic_inc(&vcpu->kvm->arch.vncr_map_count);
 	}
 }
 

