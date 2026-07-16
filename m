Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367CC369D68
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202048; cv=none; b=r7Na7Lq0O5gXXUWCIX3f+BVhpT9gwHxihS8zn2yNrpyNyXQb7bOr5Z9z6yfNhzOkZUiN0B1NalABLmkQDvuw/FUynK1gOi3ZgTaIDOGAUqy/0LaS1a0ET2Wx7K/eYHdoHkAYk8lM6JSl8pWxaziYOWT1VnUgrxryh22fHF5+hAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202048; c=relaxed/simple;
	bh=Gl56kc1AIW6Kv/sFvEv35dsUxwQW9yZR9NyfZ4HEZys=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mJtf2iQctxu5wMlkMPDAmdlOJZ6VSmjtF91yAhHw1PR5TuKG6YnwOryVtEkRPT8ajN6KPvzpl4hzCtddsV7RrwvbsRnbYNYT8dbKwX68bZfEDSPo2W9t5vgC9mGV30T/u7aHJrBfaY8hqVTcdItmtEZ0cKW24tkI46CU34UtfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CJD3Izmv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CJD3Izmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519BC1F000E9;
	Thu, 16 Jul 2026 11:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202046;
	bh=wE8EYl5nVVB3+h4o+d5f5xStfz+faPHG6EaBD0eLlQs=;
	h=Subject:To:Cc:From:Date;
	b=CJD3Izmvf8APvmqyL1AvyH95jdOGdg/FYKAPzy3FD16/4Orp7FtXYuRTQlpTkqY31
	 ZDHkpiQCRhnLdZOoeL73YvP4WoBy5geTvow4suNWkV9bSf0vZfaSbpTlCy2L58Lw0X
	 WSCXKqhadayiJM5Nb6XjRzd/poiDG8ZWFFas2wOw=
Subject: FAILED: patch "[PATCH] KVM: VMX: Handle bad values on proxied writes to LBR MSRs" failed to apply to 6.6-stable tree
To: 1356292400@qq.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:40:31 +0200
Message-ID: <2026071631-fancied-qualify-505f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ca674df13b195eb6d124ab059799d4e03fa40624
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071631-fancied-qualify-505f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

