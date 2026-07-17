Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE535F197;
	Fri, 17 Jul 2026 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268319; cv=none; b=oX0MHDwQQx8dOGkDZCrGRDA/5kZkVLqployPUI7NX/DJmx25+Nfxy92fJgipWkM/zFQNJo2t2zaN/KqoxWljT8LmcjnZwIM2y0e/EyzEs+93fEGYHkiYwWbjsw7v/r5OaI1Sub6n+Ym3ZXWpEflsNPRt0ei/6R+iNw1BdDrG6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268319; c=relaxed/simple;
	bh=V1Q4EMu3lJba2xLWe3oGaTK9Orw4/y751pkvYP3lgxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9oIY9+C+vVGdWAWA9+e8org1UH2bmr4Puem+DwckRDQV20pV2tHeF9oUdBlPVKxO2ZCoOu1K2nPBGUKkj2mL36/j3HeP8JihuLQdFqEv1+I19uH1nKP6lSqc+pk7D2YtsPR5GL/7dF1R5mSQ+Pwiorex5CeAvAjHOZweAd0Oec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUg/wRpt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUg/wRpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F1F1F000E9;
	Fri, 17 Jul 2026 06:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784268317;
	bh=n6rPNEaRD4D6z/NhA1U9CP6kuZA/fSGwL6X/tTDDGGk=;
	h=From:To:Cc:Subject:Date;
	b=fUg/wRptf39pyVxbRLJp/6U/n+Qfms9XmD1a8NTGI5eKhpOmZvrrz8kjzluFj5/mr
	 iUN//5wN9LWV6C6TA9gVQabCd+eKdolf+9m/xRx2Fwfof3TbpUz/ebGMs0ZRD88wX9
	 4l5Y4nTvlf7pGE93oaw8NxXsWeUE7596hbzrh5zeBX6QlO9tJyM0c6nWnl1jtUzGVG
	 iYBIksNHI/24BiknnLX2TPhopNqS1s9zXMib+vULqU20LTVO82uwxTdwi443OTgt8t
	 7DBrNZsP0QOLQ5+jlKfJqmHkzrGYrSXD6P2q9l4XpHakDQJahfsiEkVTbA6hgIBFK5
	 Elrnrh9TT77/g==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] KVM: nVMX: Only update last_vpid on a successful nested VM-Enter
Date: Fri, 17 Jul 2026 06:05:05 +0000
Message-ID: <20260717060505.2971514-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delay calling nested_vmx_transition_tlb_flush() in the nested VM-Enter
path until all the checks are completed, and performing any requested
TLB flushes for L2 is guaranteed (i.e.
kvm_service_local_tlb_flush_requests() is called in L2's context),
either before L2 is run in vcpu_enter_guest() or as part of a "full"
nested VM-Exit (i.e.  through __nested_vmx_vmexit()).

nested_vmx_transition_tlb_flush() checks if L1 changed L2's VPID in
vmcs12 (among other things), updates last_vpid accordingly, and requests
a TLB flush (through KVM_REQ_TLB_FLUSH_GUEST). With the current code
path, it is possible for the nested VM-Enter to fail after
nested_vmx_transition_tlb_flush() already updates last_vpid, but in this
case KVM will *not* call kvm_service_local_tlb_flush_requests() in L2's
context, and flushing L2's VPID will missed. If L1 later runs L2 with
the same VPID, nested_vmx_transition_tlb_flush() won't detect a change
in VPID, and L2's VPID will not be flushed.

Fixes: 5c614b3583e7 ("KVM: nVMX: nested VPID emulation")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org> # Internal review
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---

Note: I was able to reproduce the bug by hacking a nested TLB flushes
selftest I am working on as part of nSVM TLB optimizations. I haven't
sent out a new version that includes the selftest yet, but basically the
test includes one test case where L1 updates a mapping and changes L2's
VPID to effectively flush the TLB. Inserting a failed VM-Enter before
the correct VM-Enter makes that test case fail. This patch fixes it.

This is probably too vague, so I will reply to this patch when I send
out the selftest with exact diff needed to repro. This is me just
pointing out that a repro exists, and that I will add a pointer to it
later.


---
 arch/x86/kvm/vmx/nested.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b5460de4b1a72..0a4ea410b0483 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2818,8 +2818,6 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	if (kvm_caps.has_tsc_control)
 		vmcs_write64(TSC_MULTIPLIER, vcpu->arch.tsc_scaling_ratio);
 
-	nested_vmx_transition_tlb_flush(vcpu, vmcs12, true);
-
 	if (nested_cpu_has_ept(vmcs12))
 		nested_ept_init_mmu_context(vcpu);
 
@@ -3739,6 +3737,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		vmx_start_preemption_timer(vcpu, timer_value);
 	}
 
+	nested_vmx_transition_tlb_flush(vcpu, vmcs12, true);
+
 	/*
 	 * Note no nested_vmx_succeed or nested_vmx_fail here. At this point
 	 * we are no longer running L1, and VMLAUNCH/VMRESUME has not yet

base-commit: 6bc96b971766fbbbbdd9fb2642cedacaf02da957
-- 
2.55.0.229.g6434b31f56-goog

