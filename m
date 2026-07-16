Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF941B8F1
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201979; cv=none; b=hTX0FIj0TP56K1ji3NIcvDZ1W/o9n1f4N2o3uvEqhWnG+qwz+4vv/1FQ0T54qpCXzouKsLoIluAKPmIe7QxeO27638OlABaiK60XAbfA2t8+YP/4gkkg+P6NwKdK+pgU+0SKQRBNPubB/sYqZ+50xCoT1ayCZ1SAVVYZ9KpOKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201979; c=relaxed/simple;
	bh=deCFwUWWu5jHr2HtdqNERVRkRtPJblc6fEiuUJxG8Rw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oiXsC/LWb70LhV3lsks8VRZotwE9ZWWqnjn4Lm822xiY2ktxd0TV3yUrU/zdhAmgUFh2SNeefQp1AGfwGeqjOrNTlD3q+VRrO7s1jZDGpM7va5H0yZhH4DVQcnIfNALsTP6Krae9R8WeYkznIGCqIMH6uklluSaRV56f77DHM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cFzJuupB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cFzJuupB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C601F00A3A;
	Thu, 16 Jul 2026 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201974;
	bh=5iv6wOOEbFKAc0XDXPztrh5zhT9pffNRoxf8REHS4JM=;
	h=Subject:To:Cc:From:Date;
	b=cFzJuupBrbm6HZhstXo6Ysnw+AY/yYv8TOhuRNY/+fzIgqkxxvI/LgbTF8V8oaXEW
	 aXFYue1zdI1DRtdpHHbdIvVniORaFjNr+FgRYBa1tjM6tmwbzbRjgA+dY6/K9xVJrm
	 QNWG+44tuJjxRy7lMwKQPID3ktc7sYGhnVc6iTz4=
Subject: FAILED: patch "[PATCH] KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU" failed to apply to 6.12-stable tree
To: imv4bel@gmail.com,maz@kernel.org,tabba@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:39:16 +0200
Message-ID: <2026071616-oozy-hassle-a3d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8cc8bbbfab14c22c5551d0dd19b208a44b141c76
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071616-oozy-hassle-a3d4@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cc8bbbfab14c22c5551d0dd19b208a44b141c76 Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Sun, 7 Jun 2026 02:56:11 +0900
Subject: [PATCH] KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU

flush_hyp_vcpu() copies the host vGIC state into the hyp's private vCPU
on every run. The vGIC list register save and restore use used_lrs as
their loop bound and expect it to stay within the number of implemented
list registers. While this is generally the case, flush_hyp_vcpu()
copies vgic_v3 verbatim and does not enforce this, so a value provided
by the host is used at EL2 to index vgic_lr[] and access ICH_LR<n>_EL2
(host -> EL2).

Fix by clamping used_lrs to the number of implemented list registers
after the copy, as the trusted path already does in
vgic_flush_lr_state(). The number of implemented list registers is
constant after init, so it is replicated once from
kvm_vgic_global_state.nr_lr into hyp_gicv3_nr_lr rather than read on
every entry.

Cc: stable@vger.kernel.org
Fixes: be66e67f1750 ("KVM: arm64: Use the pKVM hyp vCPU structure in handle___kvm_vcpu_run()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Link: https://patch.msgid.link/20260606175614.83273-3-imv4bel@gmail.com
Signed-off-by: Marc Zyngier <maz@kernel.org>

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 8d06b62e7188..e9b2b0c40ec6 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -157,5 +157,6 @@ extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
 extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
 extern unsigned long kvm_nvhe_sym(hyp_nr_cpus);
+extern unsigned int kvm_nvhe_sym(hyp_gicv3_nr_lr);
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8bb2c7422cc8..74965b358cdf 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2423,6 +2423,8 @@ static int __init init_subsystems(void)
 	switch (err) {
 	case 0:
 		vgic_present = true;
+		if (static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif))
+			kvm_nvhe_sym(hyp_gicv3_nr_lr) = kvm_vgic_global_state.nr_lr;
 		break;
 	case -ENODEV:
 	case -ENXIO:
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 02c5d6e5abcb..a0da08caa6c2 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -24,6 +24,9 @@
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
+/* Number of implemented GICv3 LRs. Used by flush_hyp_vcpu(). */
+unsigned int hyp_gicv3_nr_lr;
+
 void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
 
 static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
@@ -142,6 +145,12 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3 = host_vcpu->arch.vgic_cpu.vgic_v3;
 
+	/* Bound used_lrs by the number of implemented list registers. */
+	hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3.used_lrs =
+		min_t(unsigned int,
+		      hyp_vcpu->vcpu.arch.vgic_cpu.vgic_v3.used_lrs,
+		      hyp_gicv3_nr_lr);
+
 	hyp_vcpu->vcpu.arch.pid = host_vcpu->arch.pid;
 }
 

