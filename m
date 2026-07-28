Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4CD21ADC7;
	Tue, 28 Jul 2026 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199429; cv=none; b=XD3NV+1Nr3yGrvbn0MMyQC3yUuMEjXVcQTa57umHTSNmlmzRDkjOXjP8xQST7ZVzrYUAdZtsWEPmxylONdrU45xPrl2VSCg1Pntt2ZZ3Szs8qYgNyhhE+cVVeg+vkzOfJj2HSt/CwbQMckqShHV6q/gFrnqar2nkSorIcw+MfqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199429; c=relaxed/simple;
	bh=hwzHgxwHOKRimsefqt8Th5Qzv2LGBq5WYE7oggDB7nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djgW54hylUAsoBR18pnD4vJ4y/3jyJDuARmV+UIzQ389lWSU/6UJH8mxkILhEguSlU4puLQZu7BMxjgCr8lN2+DrVQh+VVx+bhBoki6gmV/Y5hpwGtgQkuGQaTz+2xGN4ZRcpewj86kjTkGAJlvmZ4OjgRtQKRIUkRm3qMXsv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+57+ED0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+57+ED0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420731F000E9;
	Tue, 28 Jul 2026 00:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785199428;
	bh=Uk7OmKiMhC1mx5A3/dYJfnmOAT1p2fQOyeGU7qPTNhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g+57+ED0QgmFjx3KpkVTOuIyLCRmQu4TpDzax+1f0HjW69RScubVRYqO1t01Msg+i
	 sIUyFkTdYvTmECre0s/Di9Z4cLe8Ni7YJwMUFbQ1szK8cbv568d81Iak3qoUXhOvP7
	 0RiN1g1/FmRf3K6tmklZa5uZnZxQG78zujxdWiMnDUL+Vaj72YVLs0vaDS3Bji2sm5
	 j8K+N/1csWbXdww61WXz9QFmtpydAF+9Kk6/TZ1LYCgal+RYQARfzUe9I74JwcaVin
	 OFZ6j14Lje00ZOeO6f35bRFSle4IGa1jDCA2F4+2sw0uLA1njJVScTBAT24zxNqM+K
	 6dS5H5j4SZfEg==
Date: Tue, 28 Jul 2026 00:43:46 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] KVM: nVMX: Service local TLB flushes on failed nested
 VM-Enter
Message-ID: <amf7CA4q33qoIx25@google.com>
References: <20260722230128.1587363-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722230128.1587363-1-yosry@kernel.org>

On Wed, Jul 22, 2026 at 11:01:28PM +0000, Yosry Ahmed wrote:
> KVM services local TLB flushes on "full" nested VM-Exits (through
> __nested_vmx_vmexit()), but not if a nested VM-Enter fails (e.g. due to
> failed VMCS checks in nested_vmx_enter_non_root_mode()).
> 
> However, it is possible that KVM had queued TLB flushes that need to be
> performed, even if the nested VM-Enter was not successful. For example,
> if VPID is disabled for L2 (via nested_vmx_transition_tlb_flush(), or if
> via the MSR load lists, as the SDM says:
> 
>   If any MSR is being loaded in such a way that would architecturally
>   require a TLB flush, the TLBs are updated so that, after VM entry, the
>   logical processor will not use any translations that were cached before
>   the transition.
> 
> The SDM is unclear about when the TLB flush should occur, and whether or
> not a failed VM entry would flush the TLB, so it is safer to always
> do the TLB flush in this case.
> 
> More concretely, KVM also updates the last VPID L1 used for L2 in
> nested_vmx_transition_tlb_flush() (i.e. last_vpid), even if the VM entry
> ultimately fails. With the current code, KVM could miss a TLB flush if
> L1 changes L2's VPID, then does a failed VM entry followed by a
> successful one, as the failed VM entry would update last_vpid but not
> actually flush the TLB. Servicing local TLB flushes on failed VM entries
> makes sure that the TLB is always flushed when last_vpid is updated.
> 
> Fixes: 5c614b3583e7 ("KVM: nVMX: nested VPID emulation")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org> # Internal review
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---

For the record, my reproducer was basically the nested TLB flushes
selftest introduced here:
https://lore.kernel.org/kvm/20260728003557.1136583-29-yosry@kernel.org/

With this diff on top:

diff --git a/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c b/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c
index 55c9909bb085f..1659dd9c0044a 100644
--- a/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c
@@ -123,8 +123,26 @@ static void run_l2(void *nested_state, bool launch)
                vmx_tlb_flush(nested_state);
                if (launch)
                        GUEST_ASSERT(!vmlaunch());
-               else
-                       GUEST_ASSERT(!vmresume());
+               else {
+                       struct vmx_pages *vmx = nested_state;
+                       struct vmx_msr_entry *entry = vmx->msr;
+
+                       /* Inject VM-Entry failure via invalid MSR load */
+                       entry->index = 0xc0000100; /* MSR_FS_BASE, disallowed for loading */
+                       entry->reserved = 0;
+                       entry->value = 0;
+                       vmwrite(VM_ENTRY_MSR_LOAD_ADDR, vmx->msr_gpa);
+                       vmwrite(VM_ENTRY_MSR_LOAD_COUNT, 1);
+
+                       GUEST_ASSERT_EQ(vmresume(), 0);
+                       GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), (EXIT_REASON_FAILED_VMENTRY | EXIT_REASON_MSR_LOAD_FAIL));
+
+                       /* Fix failure and retry */
+                       vmwrite(VM_ENTRY_MSR_LOAD_COUNT, 0);
+                       memset(vmx->msr, 0, 4096);
+
+                       GUEST_ASSERT_EQ(vmresume(), 0);
+               }
                GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
                vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) + 3); /* skip over VMCALL */
        } else {
