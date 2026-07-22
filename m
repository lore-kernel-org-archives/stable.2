Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A77154425;
	Wed, 22 Jul 2026 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761297; cv=none; b=DpIcBui54oFwbeLg7f+60v78B9OQxOkflSQ5taw4iHdfABnqS+rqWXpPq80lRH1Wo0ffJ2ZhwCydj2y7gXmZeffM/J2hrHLECUsUOFkMymOfxnbCdy7gTt4Tz5K2l744RE7mPKiK6Mg6PAl3Y+n18yQUrIvSEc80PGIIEGRkDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761297; c=relaxed/simple;
	bh=E+gDlBX8QG4flfrjXfe61WyTV71wIHEJG6fD/2CCi5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSEiwG7/jwkvgRVHFpjEKM7amuqZ2bfaf5MMPvntf241y+fPmwSWdtd8OSoDx32AmrGszSUAPqdOoimsCFXv+5sZ+MmXL7QVm+UH36T/vi3u7u44JVD6sXrkCWnpFBqHZyMlfTWLnF6uU6xwDFojC0Nwo2WKUYuBdECGHIs/Q0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFBHabne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFBHabne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EA31F000E9;
	Wed, 22 Jul 2026 23:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784761296;
	bh=4GGfBkMNd8itCfy9xGdbp/vCSz2IfMikohDpnl1RDao=;
	h=From:To:Cc:Subject:Date;
	b=MFBHabneyoxWlpxmEzAvs3tyBIWqFkbhjxOYe9I9YIdz9pPB7H8wAkezYsp+652Uk
	 WqpF85N9PMRNVjaXeKVQfsLS84+d0C2l/9hSLAtCIFlszPkclGBk2LYb9QWd11dxyg
	 hjNnM0xoPcQ4HKuAl6yUsFjuL5eRC7ZcJGO6tS2103z64U55XQ4PVxTNhVY6Pomo2J
	 iVzHKw1vRx2mEzs1vHgDZ92bxhnlLLf5G8d1NWtAXqbKfuUsbPdGHh6GI0Oh4YHsig
	 Hv95V943oYJ2KVsizqZdlVpMxUNljIZkw+mUwJAUwjFIXHOWFVA7gOUHxYJLFAucx2
	 LA2F45HMKI3JQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2] KVM: nVMX: Service local TLB flushes on failed nested VM-Enter
Date: Wed, 22 Jul 2026 23:01:28 +0000
Message-ID: <20260722230128.1587363-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM services local TLB flushes on "full" nested VM-Exits (through
__nested_vmx_vmexit()), but not if a nested VM-Enter fails (e.g. due to
failed VMCS checks in nested_vmx_enter_non_root_mode()).

However, it is possible that KVM had queued TLB flushes that need to be
performed, even if the nested VM-Enter was not successful. For example,
if VPID is disabled for L2 (via nested_vmx_transition_tlb_flush(), or if
via the MSR load lists, as the SDM says:

  If any MSR is being loaded in such a way that would architecturally
  require a TLB flush, the TLBs are updated so that, after VM entry, the
  logical processor will not use any translations that were cached before
  the transition.

The SDM is unclear about when the TLB flush should occur, and whether or
not a failed VM entry would flush the TLB, so it is safer to always
do the TLB flush in this case.

More concretely, KVM also updates the last VPID L1 used for L2 in
nested_vmx_transition_tlb_flush() (i.e. last_vpid), even if the VM entry
ultimately fails. With the current code, KVM could miss a TLB flush if
L1 changes L2's VPID, then does a failed VM entry followed by a
successful one, as the failed VM entry would update last_vpid but not
actually flush the TLB. Servicing local TLB flushes on failed VM entries
makes sure that the TLB is always flushed when last_vpid is updated.

Fixes: 5c614b3583e7 ("KVM: nVMX: nested VPID emulation")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org> # Internal review
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---

v1: https://lore.kernel.org/kvm/20260717060505.2971514-1-yosry@kernel.org/

v1 -> v2:
- Service local TLB flushes on failed nested VM entries instead of
  delaying queuing the flushes, as TLB flushes could be queued in other
  ways (e.g. via the MSR load lists).

---
 arch/x86/kvm/vmx/nested.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b5460de4b1a72..7e184a9644869 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3755,6 +3755,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 vmentry_fail_vmexit_guest_mode:
 	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
 		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
+
+	/*
+	 * Handle any TLB flush requests that were queued for L2 if KVM made it
+	 * far enough along to switch to L2 context.  Note, loading host state
+	 * will generate any flushes for L1 required by VM-Exit.
+	 */
+	kvm_service_local_tlb_flush_requests(vcpu);
+
 	leave_guest_mode(vcpu);
 
 vmentry_fail_vmexit:

base-commit: 6bc96b971766fbbbbdd9fb2642cedacaf02da957
-- 
2.55.0.229.g6434b31f56-goog

