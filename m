Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D1526A89
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950647; cv=none; b=DPQWxXUey8qB6cFa5awjxA3iGwGine+JGXZMH53a9zQvrFIODtXSwEgtjU9VKHtNueOV/bImJMhLorB1pL70wG6OwxNIEAzxSzcc1/4zimJPuWN2WyIcDrjLbm5HIa350G/jPM9R8am6WpQR/4lorlktv+0of6327ZEaUZUP8aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950647; c=relaxed/simple;
	bh=1Dpw6CWc9t3y1aL+EQtiXI/OfT88fmRT2nvK15fDac8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=og3Wzqdr62uk0e4B+pR6YLcT0u/JyGeJGDMbJOaFdBTNcPd45xMq/xUE4F9ccQh03++tWPytalyAF4ZazpyJgLSChyfzG6aeyC6MhL0G9txi5ojw6x3ObYxsxN+Cw+1KNJD1qo/aWGi8aOx0IcTZu32PkIpuLqgskOsXN+A6SVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PM/8LLHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PM/8LLHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C501F00A3D;
	Wed,  9 Sep 2026 10:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950645;
	bh=w9WdZlrGzIWHZtZVT/fa9iGL4pXEjjGvuzezjlHiWPY=;
	h=Subject:To:Cc:From:Date;
	b=PM/8LLHL2/NPQlnFBCkhfHSEpiAjjU8AsDYvMZ32f0J3Cv5DA1+KCjK7UmyU5bnzf
	 5+gtA+ou3f2ma6k84e7cjXWNGkSVSsY7wAEpAdOCiVv3b+nD5dEc9myWfZcpwpP+r1
	 ZIUPzfMrz+riP4L/dJ4uZycJnUs9SJvO7Yki2QUk=
Subject: FAILED: patch "[PATCH] KVM: x86/mmu: Use split "zap all fast" helpers when" failed to apply to 6.12-stable tree
To: seanjc@google.com,michael.roth@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:33:23 +0200
Message-ID: <2026090923-sleep-shore-e015@gregkh>
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
git cherry-pick -x db095727ff5739f4f46ee641ee6ef450032886db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090923-sleep-shore-e015@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db095727ff5739f4f46ee641ee6ef450032886db Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 9 Jul 2026 13:49:39 -0700
Subject: [PATCH] KVM: x86/mmu: Use split "zap all fast" helpers when
 invalidating memslot

Manually invoke the front half and back half of the "zap all fast" flow
when invalidating a memslot so that mmu_lock is acquired at function scope
in kvm_arch_flush_shadow_memslot().   This will allow putting more code
inside the critical section without having to take mmu_lock twice in quick
succession.

Opportunistically open code checking whether or not to do the fast zap, to
discourage removing the local "zap_all" in a future cleanup, i.e. to ensure
the SLOT_ZAP_ALL quirk is queried exactly once.  Processing the front half
but not the back half of the fast zap (if SLOT_ZAP_ALL were disabled
concurrently) would result in KVM unnecessarily keeping invalid TDP MMU
roots until the VM is destroyed.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Michael Roth <michael.roth@amd.com>
Link: https://patch.msgid.link/20260709204948.1988414-10-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a5c2a560a88a..3eb1f86593b1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7573,12 +7573,6 @@ static void kvm_mmu_zap_memslot_pages_and_flush(struct kvm *kvm,
 	kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
 }
 
-static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
-{
-	return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
-	       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
-}
-
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
@@ -7589,16 +7583,23 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 		.may_block = true,
 		.attr_filter = KVM_FILTER_PRIVATE | KVM_FILTER_SHARED,
 	};
+	bool zap_all = kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
+		       kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
 	bool flush;
 
-	if (kvm_memslot_flush_zap_all(kvm)) {
-		kvm_mmu_zap_all_fast(kvm);
+	write_lock(&kvm->mmu_lock);
+
+	if (zap_all) {
+		__kvm_mmu_zap_all_fast_front_half(kvm);
 	} else {
-		write_lock(&kvm->mmu_lock);
 		flush = kvm_unmap_gfn_range(kvm, &range);
 		kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
-		write_unlock(&kvm->mmu_lock);
 	}
+
+	write_unlock(&kvm->mmu_lock);
+
+	if (zap_all)
+		__kvm_mmu_zap_all_fast_back_half(kvm);
 }
 
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)

