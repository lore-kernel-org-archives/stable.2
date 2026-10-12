Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62C4B2CCE
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823116; cv=none; b=E50UNsT7G0CraqUmsAVoGUKNA7/kBfD99yoFuH4uK7V+1nrgdQIlFKGRGclclKN668Hkk2lBX3rMBLM7qKAyaZeYFYoi60g23R1rIdq4wv5b8aulkjeXVc2kspEcibl2LsPulePDCf/USysRLTdkhvsShTxs8QP7UL2riPdeQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823116; c=relaxed/simple;
	bh=pbhZkYNnar0kPSp+s9GEb5Xa1JRNBT0QcgxDD0heE5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XQn7gEi42dxO7D+36PvRuNMgXp6U/a5aQnq+eSsJrKYd9R7o8T1PNtjI75M4B7dzb+B39UZmzYD4X8xBogXeGCIum0AUqzRtL11pO4lF3YogHj1GYX0xTt0Rzat4ZT0CNEpji0/E9sA7I6jC3KUmRE0fYsiO/1sD3h9Hs3saM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnUIbA6h; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnUIbA6h"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac16335199so541839a91.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791823110; x=1792427910; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B2vzFHQG4XVoWzezMO6TihD0hD+Jfa/iBmx477A16Dw=;
        b=UnUIbA6hnTT04bC0qBxw7H272aoC/MxV3ov1JfPC3B/0L4DC2uUE5OeZ86DPcSef2c
         L/oeOUSiwdQ6nIhPC1VPEMyKkmLdKFerX7IJyCC4tXLINL2En9Hvf90L0Ji9W2wD5nUS
         sVFNMXl16PgWhOnxDr7n1H1Q2JljxuLOMiTm70CFPnotSVAxC41QhKRql9rwVVCkSZl4
         9F0bRVyTfVv9APWTNNyzLj7xl2ZB/v7IqYNQ0qAtqWV6Rr9eRGy5RSWH45oQsSLvliLO
         5PsmsFi5OO+W6EP7A66jTg2VKJvpbxLE/7ukUgeSrFM2obDEX3sK6iCE0fdv0If1/MFr
         XYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823110; x=1792427910;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B2vzFHQG4XVoWzezMO6TihD0hD+Jfa/iBmx477A16Dw=;
        b=DL0yRHlfEcvRiHLXPiEoQ9Wbk3ItTHOacc+VhQxNXUzQel/0jCePjKjUzWzc8wVWJB
         xHbZj+r3np94rJL7fQxjfsFlGultvG9/SFbh4RxyM1S/dlFPfuNCLuvpE5tl65Gb4Eq3
         0URgds3y/cvk7Rpq6IG7Ng8yDKttyHWBgxSOEp5ClyBfTKMUAY5OsDHQ8fwC8rDv3T4M
         rrve8uC/qa9EiokOFOl0TZUxTtLTKE3V2IJ/yIkg2aDefN4k10qnEItXVEuFFgOC2tsB
         0B4GqcTQGHG4b9jbdZnuxG7JAGZ4MZRNoib9nmqat0hgha2iPQ0ZnRwwbU+R4Gz9a6JY
         aC4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwRn5RAQrkWxXYA1aHG7ooUA6IZv9lkzy6781PrNEekJ4mqNjUFyrcfTURcOb3D9lK5BFFppTo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMHyvtXahNuOG+66iRwuQy2UQFksog6HNimlhdHMRcBGQYjZmt
	yzapmAyT8WI4SjBpL870hGu1bSMVSPY9gOJLGNVOMJeLkSHeK2Wqut+oitAQwMnMPNlZr/kSAba
	Gki+V1w==
X-Received: from pjbrs15.prod.google.com ([2002:a17:90b:2b8f:b0:3a8:4386:7c43])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b0e:b0:39e:4c7f:7308
 with SMTP id 98e67ed59e1d1-3ab3aca124cmr8447686a91.31.1791823110020; Mon, 12
 Oct 2026 09:38:30 -0700 (PDT)
Date: Mon, 12 Oct 2026 09:38:29 -0700
In-Reply-To: <20261009130450.361690-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261009130450.361690-1-pbonzini@redhat.com>
Message-ID: <as0NBfuEY-60pgtz@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	SimonP <simonp.git@mailbox.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 09, 2026, Paolo Bonzini wrote:
> When running Hyper-V from Windows 11, KVM is seeing the SS bit set
> in nested page fault error codes produced for shadowed NPT.  The AMD
> manual is unclear about when SS is set, including whether it can be set
> when SupervisorShadowStackEn (bit 6) is not set in the MISC_CTL field
> of the VMCB; in fact, bisection shows that while SHSTK was available
> to guests since Linux 6.18, this started happening with commit
> 687ee95c1b6d ("KVM: nSVM: enable GMET for guests"), which seems unrelated.

It's not unrelated.  As you note below, this is purely because Hyper-V only uses
CET when GMET is available.

> Nevertheless, the unexpected SS bit causes out of bounds accesses in
> permission_fault(), seen as either WARNs or UBSAN reports:
> 
>   kernel: UBSAN: array-index-out-of-bounds in arch/x86/kvm/mmu.h:225:27
>   kernel: index 34 is out of range for type 'u16 [16]'
> 
> (in this case, the page fault error code is 34*2=0x44, i.e. SS|U; the
> report shows SS|U|W happening as well).  Fix the handling of unknown
> error codes by dropping SS and (with a WARN) any bits not among those
> that permission_fault() expects to receive.
> 
> At the same time, given the uncertainty about when hardware sets SS,
> follow the processor's behavior when constructing the fault's error
> code, and preserve the SS bit as passed to FNAME(walk_addr_generic).
> While the behavior is surprising, there's a possibility that Hyper-V
> expects it (Hyper-V does not even enable CET unless it finds MBEC/GMET!),
> so retain the information when reflecting the fault to L1 instead of
> unconditionally discarding it.
> 
> Note that, even though KVM always tries to run L1 with GMET enabled, it
> copies the GMET-enable bit of the VMCB12 to the VMCB02 when L1 requests
> usage of NPT.  Therefore, if the theory suggested by the bisection result
> is correct and GMET enables setting the SS bit as well, this would not
> affect hypervisors that enable NPT but not GMET.
> 
> Reported-by: SimonP <simonp.git@mailbox.org>

Closes: https://lore.kernel.org/all/asUqYEisPp9MJ8mQ@rika.bernkas.tel

> Fixes: 687ee95c1b6d ("KVM: nSVM: enable GMET for guests")
> Cc: stable@vger.kernel.org # 7.2+

This is wrong, I reproduced this with the KUT CET test with gmet=1.  It needs to
be (I would just leave off the kernel version number and let the Fixes take the
backports where it needs to go).

  Fixes: 8db428fd5229 ("KVM: SVM: Enable shadow stack virtualization for SVM")
  Cc: stable@vger.kernel.org

With the above tweaks and the removal of user_fault:

  Reviewed-by: Sean Christopherson <seanjc@google.com>

The only reason the KUT test doesn't hit the WARN is because L0 KVM never takes
a #NPF on the push to the shadow stack.  Thanks to KVM's prefetching and KUT's
handling of free pages (the allocator writes to the page being allocated), it's
all but impossible for the shadow stack push to hita #NPF in L0's domain.

With hacks in KVM and KUT to zap all SPTEs just before running the shadow stack
test:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 81a5b32a4bd0b..2ab55fd910d64 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7683,6 +7683,7 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 {
 	kvm_mmu_zap_all(kvm);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_arch_flush_shadow_all);
 
 static void kvm_mmu_zap_memslot_pages_and_flush(struct kvm *kvm,
 						struct kvm_memory_slot *slot,
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 757c8ea1ee818..a050ebb633b36 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1828,6 +1828,12 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
 		 * of L1.
 		 */
 		return NESTED_EXIT_HOST;
+	case SVM_EXIT_MSR:
+		if (!svm->vmcb->control.exit_info_1)
+			break;
+
+		kvm_arch_flush_shadow_all(vcpu->kvm);
+		break;
 	default:
 		break;
 	}

diff --git a/x86/cet.c b/x86/cet.c
index bb031b80..050cc1c7 100644
--- a/x86/cet.c
+++ b/x86/cet.c
@@ -225,10 +225,14 @@ static void test_shstk(void)
 	wrmsr(MSR_IA32_PL3_SSP, (u64)(shstk_virt + 0x1000));
 
 	printf("Running user mode Shadow Stack tests\n");
+	wrmsr(MSR_IA32_UCODE_REV, 0);
 	run_in_user(cet_shstk_func, CP_VECTOR, 0, 0, 0, 0, &rvc);
 	report(rvc && exception_error_code() == CP_ERR_NEAR_RET,
 	       "NEAR RET shadow-stack protection test");
 
+	if (1)
+		return;
+
 	run_in_user(cet_shstk_far_ret, CP_VECTOR, 0, 0, 0, 0, &rvc);
 	report(rvc && exception_error_code() == CP_ERR_FAR_RET,
 	       "FAR RET shadow-stack protection test");


I can trigger the WARN:

 ------------[ cut here ]------------
 WARNING: ./arch/x86/kvm/mmu.h:305 at paging64_walk_addr_generic+0x493/0x630 [kvm], CPU#475: CPU 27/KVM/453497
 Modules linked in: kvm_amd kvm irqbypass vfat fat dummy bridge stp llc ccp k10temp i2c_piix4 cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd [last unloaded: kvm]
 CPU: 475 UID: 0 PID: 453497 Comm: CPU 27/KVM Tainted: G S   U              7.3.0-smp--dfc8813a3132f-seanjc-sink #71 PREEMPT 
 Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER
 Hardware name: Google Astoria-Turin/astoria, BIOS 0.20260526.0-0 05/26/2026
 RIP: 0010:paging64_walk_addr_generic+0x493/0x630 [kvm]
 Call Trace:
  <TASK>
  paging64_page_fault+0x55/0x2a0 [kvm]
  kvm_mmu_do_page_fault+0x138/0x210 [kvm]
  kvm_mmu_page_fault+0xce/0x400 [kvm]
  npf_interception+0x14b/0x320 [kvm_amd]
  vcpu_run+0x1571/0x1f00 [kvm]
  kvm_arch_vcpu_ioctl_run+0x2c6/0x600 [kvm]
  kvm_vcpu_ioctl+0x580/0x6b0 [kvm]
  __se_sys_ioctl+0x6d/0xb0
  do_syscall_64+0xfe/0x460
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7f9e1677a17b
  </TASK>

Note, the early return in test_shstk() is necessary to reproduce the splat in my
setup.  I assume it's due to a change in the generated test code that causes KVM
to fault-in (prefetch?) the shadow stack page.  I didn't bother digging that deep.
