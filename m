Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC23DA5DC
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202040; cv=none; b=FW7RKqmiG+I0FJntkSUeeJwLYM86CmubZTziZWNiyl3zFCQDwx2jdlj99Qh8h30m6pWYQjSdRI9HKg/s1gjvWIVQBeyI8Jc56wMFqQZkO140Xut5cTR/rGJy0pZaRmn0i0KQaRs/J+BQxT2juTrTB83tSwyAxiHs1r/QRgri/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202040; c=relaxed/simple;
	bh=r9kI567l845hZsxViJ8IwS6LudKpSYwusOgJXgQxoqQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KDBBbpiPgsgJKtfqTWHk75Ha3YV9+mtrWiAptMzZOjBzfIpLaXq2CXw/6exB/xDpE7RfR6jh1PBRHjEEgdH6sKRsbmrEh8sZH/pZKeacMdNCGsqE1uU0O5OCcVBAhfn7FJHTm17UroMsY9hMUlU8xTmFCkiqYs2NgVUBQjMOnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nv3FcQaP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nv3FcQaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFAD1F000E9;
	Thu, 16 Jul 2026 11:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202038;
	bh=J6Hc3X21fsuGOhQm7diiPoe0QFei2YVjmPjQ07k58LQ=;
	h=Subject:To:Cc:From:Date;
	b=Nv3FcQaPtJiw+FjEdOsjax1WgqrPw/naCxgDX/N4TfPISbjn7mMWGhl4tnmM/T9oR
	 uQIkKQbltexIP+i3FtL7+e3OzJ7oHJzjoDDrIxMJqkVKhaEIXEOhu0kW5LmbKoigwc
	 fVaAE89v7Km0dfOEwl3iUfnsznpUg/fHlY/t7j/g=
Subject: FAILED: patch "[PATCH] KVM: VMX: Handle bad values on proxied writes to LBR MSRs" failed to apply to 6.12-stable tree
To: 1356292400@qq.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:40:30 +0200
Message-ID: <2026071630-clustered-naming-dab3@gregkh>
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
git cherry-pick -x ca674df13b195eb6d124ab059799d4e03fa40624
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071630-clustered-naming-dab3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca674df13b195eb6d124ab059799d4e03fa40624 Mon Sep 17 00:00:00 2001
From: Xuanqing Shi <1356292400@qq.com>
Date: Tue, 26 May 2026 19:26:17 -0700
Subject: [PATCH] KVM: VMX: Handle bad values on proxied writes to LBR MSRs

Use the "safe" WRMSR API when writing LBRs on behalf of the guest (or host
userspace), and propagate any errors back to the instigator, as the value
being written is untrusted.  E.g. if the guest (or host userspace) attempts
to set reserved bits in LBR_SELECT, then KVM needs to return an error, and
not WARN on the bad value.

Continue using the "unsafe" version of RDMSR, as it should be impossible to
reach the helper with a completely bogus MSR, i.e. WARNing on RDMSR failure
is very desirable, e.g. to make KVM bugs more visible.

  unchecked MSR access error: WRMSR to 0x1c8 (tried to write 0x0000000000004000)
  Call Trace:
   intel_pmu_set_msr+0x4e0/0x7f0 [kvm_intel]
   kvm_pmu_set_msr+0x17e/0x1c0 [kvm]
   kvm_set_msr_common+0xc76/0x1440 [kvm]
   vmx_set_msr+0x5e6/0x1570 [kvm_intel]
   kvm_emulate_wrmsr+0x54/0x1d0 [kvm]
   vmx_handle_exit+0x7fc/0x970 [kvm_intel]

Fixes: 1b5ac3226a1a ("KVM: vmx/pmu: Pass-through LBR msrs when the guest LBR event is ACTIVE")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqing Shi <1356292400@qq.com>
[sean: rework changelog, only modify WRMSR path, tag for stable@]
Link: https://patch.msgid.link/20260527022617.3973884-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 27eb76e6b6a0..22138c487216 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -308,13 +308,15 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
 	 */
 	local_irq_disable();
 	if (lbr_desc->event->state == PERF_EVENT_STATE_ACTIVE) {
+		int err = 0;
+
 		if (read)
 			rdmsrq(index, msr_info->data);
 		else
-			wrmsrq(index, msr_info->data);
+			err = wrmsrq_safe(index, msr_info->data);
 		__set_bit(INTEL_PMC_IDX_FIXED_VLBR, vcpu_to_pmu(vcpu)->pmc_in_use);
 		local_irq_enable();
-		return true;
+		return !err;
 	}
 	clear_bit(INTEL_PMC_IDX_FIXED_VLBR, vcpu_to_pmu(vcpu)->pmc_in_use);
 	local_irq_enable();

