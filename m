Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D719841B8D7
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202010; cv=none; b=G8mtorE427zQ9AaP584a9yRDAQF77Czq9hNA5loD4WTJnxR5KSBp8hoKZsAIZSL0/z9oyjY9PFkHC9qPJHx5LJozPg5D39iqfhiSTvNeHC/5J2I2cclmGPsNc4Z1sxdldXY0m8V0+CVHN6J1r3q3Fo8O23ouOs55maQjrkzZWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202010; c=relaxed/simple;
	bh=LEnA1toYVZ4QAGWKwe+MvsWODVmnbdgfKS++9UVcmmo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fNIete5GRHPlB+sA6jitHtKJOmGTctY1QU4hXC9IkWlpU6OFy+lAW+pXvBzMbSPMzcIMwSraLveHOqJviD+Ij+lADkAolLUVC7rdsRlfRy4B33eRrvsqgC0it9bTDA+MYEltMv7yVORUB2vsV4Lc+75e9svMs0+9KSh5kmGHwlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GEoe3rqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GEoe3rqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA89C1F00A3A;
	Thu, 16 Jul 2026 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202006;
	bh=feGnk688PKAFFdMKDwHGGZl1930JQaIm2cJ+cbG7Ik8=;
	h=Subject:To:Cc:From:Date;
	b=GEoe3rqHLzjV4lV1IPhLEU/h0fK1plZEgJafnl/o7mKD+rQ8HxDFBKB3q+S+FMAq1
	 kK9qkBJ3aGer+hzerLo/yHbXxHDhzQilLXGRSLvfVbsKOf0BO+7Nu6PYdrZRQOKyE9
	 bwONmeQkgj3S0Edhw1mgIuHYSgL1KX6PPELtQY1k=
Subject: FAILED: patch "[PATCH] KVM: SVM: Disable x2AVIC RDMSR interception for MSRs KVM" failed to apply to 6.1-stable tree
To: seanjc@google.com,naveen@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:39:49 +0200
Message-ID: <2026071649-untimely-gift-1497@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7f4b7092d9a173a4271e28c0ed1fc235994e309b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071649-untimely-gift-1497@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f4b7092d9a173a4271e28c0ed1fc235994e309b Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:31:14 -0700
Subject: [PATCH] KVM: SVM: Disable x2AVIC RDMSR interception for MSRs KVM
 actually supports

When toggling x2AVIC on/off, use KVM's curated mask of x2APIC MSRs that
can/should be passed through to the guest (or not) when 2AVIC is enabled.
Using the effective list provided by the local APIC emulation fixes
multiple (classes of) bugs, as the existing hand-coded list of MSRs is
wrong on multiple fronts:

 - ARBPRI isn't supported by KVM, isn't accelerated by AVIC (for read or
   write), and its #VMEXIT is fault-like, i.e. requires decoding the
   instruction.  Disabling interception is nonsensical and suboptimal.

 - DFR and ICR2 aren't supported by x2APIC and so don't need their
   intercepts disabled for performance reasons.  While the #GP due to
   x2APIC being abled has higher priority than the trap-like #VMEXIT,
   disabling interception of unsupported MSRs is confusing and unnecessary.

 - RRR is completely unsupported.

 - AVIC currently fails to pass through the "range of vectors" registers,
   IRR, ISR, and TMR, as e.g. X2APIC_MSR(APIC_IRR) only affects IRR0, and
   thus only disables intercept for vectors 31:0 (which are the *least*
   interesting registers).

 - TMCCT (the current APIC timer count) isn't accelerated by hardware, and
   generates a fault-like AVIC_UNACCELERATED_ACCESS #VMEXIT, i.e. requires
   KVM to decode the instruction to figure out what the guest was trying to
   access.  Note, the only reason this isn't a fatal bug is that the AVIC
   architecture had the foresight to guard against buggy hypervisors.  E.g.
   if hardware simply read from the virtual APIC page, the guest would get
   garbage (because the timer is emulated in software).

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://patch.msgid.link/20260514213115.1637082-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index adf211860949..8e4926c7b8dc 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -122,6 +122,9 @@ static u32 x2avic_max_physical_id;
 static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 					     bool intercept)
 {
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	u64 rd_regs;
+
 	static const u32 x2avic_passthrough_msrs[] = {
 		X2APIC_MSR(APIC_ID),
 		X2APIC_MSR(APIC_LVR),
@@ -162,9 +165,15 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 	if (!x2avic_enabled)
 		return;
 
+	rd_regs = kvm_x2apic_disable_read_intercept_reg_mask(vcpu);
+
+	for_each_set_bit(i, (unsigned long *)&rd_regs, BITS_PER_TYPE(rd_regs))
+		svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
+					  MSR_TYPE_R, intercept);
+
 	for (i = 0; i < ARRAY_SIZE(x2avic_passthrough_msrs); i++)
-		svm_set_intercept_for_msr(&svm->vcpu, x2avic_passthrough_msrs[i],
-					  MSR_TYPE_RW, intercept);
+		svm_set_intercept_for_msr(vcpu, x2avic_passthrough_msrs[i],
+					  MSR_TYPE_W, intercept);
 
 	svm->x2avic_msrs_intercepted = intercept;
 }

