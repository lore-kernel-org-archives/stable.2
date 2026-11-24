Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795518141;
	b=VxNh13t0na9lZuW3j3FexYygOelWq4eGjX9L4u6QtflC1qHpKehPD/uioT9LOqQbIjyE
	 Xe3Q6+wV34iazjipOybVO2KO1C44Yd1TENNsrCuG99YRRW1ro0j9UN4d+OW8RJvDz+H/Z
	 98VPLIhfJVR3XQXyQmXdLLxHNpcdub7Ongl1EZEIxvgFyajuINAMcoATpn/76eaG+90nN
	 9XJHzMk//ufipmJpbR6a+RVQKDqvzl7mqYjq4FzDuyxWE5dXxxxlCGPksfdrxL62blMcJ
	 5Kp/QlLPraBxFvqtsic9pWsxDrrsFMJimMwjXqeUKYN9WP3JhYcuzoQH0yxxgfuumsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518141;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KAvHK6j0hREgOFUkVu/pGTkn7fy5PDfJjXV7BZ0L4ak=;
	b=xgu8FqaEgQ8clp0ltVRllbq71Z+BVD++djQ+J9p2wsrrOrAPCsERXQjuTjp8Vp0frlBh
	 EJmzLuQ8jmyr75rFLYnbw4/AX1NVt0uzr+Wx7O7P6XTOx3IBmzfZ49NM05Y2RyAtIJQPn
	 crgICmH70kzXmt3QY8+miynce06tPX/3LWAxHo2nqxzflJ6+tZpl49pbZkDHgu1wEY0Ex
	 eM0LfjnAz7IHt48/v1ZLmhpSZCHYbIzIhlkCo4aA/Omm9msrszHMymKVbE6CHVXCgo4lD
	 NS7X0YbTHJz7Bbdera2lU94GscnA8EYXh6/heOZLff+Y9YKKcSjgB6vh/JRW1Mny9ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mHAjw4tY;
	arc=none smtp.remote-ip=91.218.175.242
Received: from mta0.migadu.com (out-242.mta0.migadu.com [91.218.175.242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81148606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81148606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mHAjw4tY
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YQOhx28BDze68y36zy90w+D/2RW09RYxRy95T7kvqVE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795518138; v=1; x=1796122938;
 b=mHAjw4tYzSAbLJMfkcEYcq0YIf63aj6uOu6qCOkBwPC9lFDTox4JZQHX+hqk/29Qy48Ta4AE
 0zsD0hoswVQYR/4upBbAsovAW+PpPOlVCjGJs5pNJR8Mh18Y0wTATB4fnlphyx7P24tdcpzC7BG
 8UvW+9cJhuO/KG1gieRzi5LY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e2ce8471a6143467;
	Tue, 24 Nov 2026 11:02:18 +0000
X-Mizu-Trace-ID: e2ce8471a6143467
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Oliver Upton <oupton@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Steven Price <steven.price@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	Cornelia Huck <cohuck@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: Set PG_mte_tagged before copying MTE tags from userspace
Date: Tue, 24 Nov 2026 11:02:13 +0000
Message-ID: <20261124110213.587871-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM_ARM_MTE_COPY_TAGS takes PG_mte_lock on a page's first tagging, and
sets PG_mte_tagged only after copying the tags in from userspace.
However, that copy faults on the same page if the VMM passes a PROT_MTE
mapping of the page as the tags buffer. The fault then spins forever in
mte_sync_tags(), waiting for PG_mte_tagged to be set.

Call sanitise_mte_tags() before the copy, so that PG_mte_tagged is
already set if the copy faults. The ioctl calls it holding a reference
on the page rather than kvm->mmu_lock, and either keeps the page from
being freed. A racing vCPU fault or __set_ptes() then finds the page
tagged and doesn't touch its tags. The guest and the VMM can read
cleared tags from the page until the copy finishes.

Fixes: d77e59a8fccde ("arm64: mte: Lock a page for MTE tag initialisation")
Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Closes: https://lore.kernel.org/all/auPCV6VdMEz4uZkK@arm.com/
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---

Notes:
    Based on kvmarm/fixes (012e4bc01e339), which has the MTE fixes this
    patch depends on.
    
    I didn't go with Catalin's suggestion of a copy_from_user() into a
    local buffer, since there's no helper that writes tags held in the
    ioctl's one-tag-per-byte format from a kernel buffer to a page.

 arch/arm64/include/asm/kvm_mmu.h |  1 +
 arch/arm64/kvm/guest.c           | 18 ++++--------------
 arch/arm64/kvm/mmu.c             |  7 +++----
 3 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 32392abf2e21c..d0f66426f139f 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -196,6 +196,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 
 int kvm_handle_guest_sea(struct kvm_vcpu *vcpu);
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu);
+void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn, unsigned long size);
 
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index b7d36c2abfdf9..82911d1287611 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -24,6 +24,7 @@
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_mmu.h>
 #include <asm/kvm_nested.h>
 #include <asm/sigcontext.h>
 
@@ -1057,27 +1058,16 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 			kvm_release_page_clean(page);
 		} else {
 			/*
-			 * Only locking to serialise with a concurrent
-			 * __set_ptes() in the VMM but still overriding the
-			 * tags. A hugetlb folio is marked tagged as a whole,
-			 * so its first tagging clears every page.
+			 * The user copy can fault on this page, and that fault
+			 * spins until PG_mte_tagged is set, so set it first.
 			 */
-			if (folio_test_hugetlb(folio)) {
-				if (folio_try_hugetlb_mte_tagging(folio))
-					mte_clear_folio_tags(folio);
-			} else {
-				try_page_mte_tagging(page);
-			}
+			sanitise_mte_tags(kvm, page_to_pfn(page), PAGE_SIZE);
 			num_tags = mte_copy_tags_from_user(maddr, tags,
 							MTE_GRANULES_PER_PAGE);
 
 			/* uaccess failed, don't leave stale tags */
 			if (num_tags != MTE_GRANULES_PER_PAGE)
 				mte_clear_page_tags(maddr);
-			if (folio_test_hugetlb(folio))
-				folio_set_hugetlb_mte_tagged(folio);
-			else
-				set_page_mte_tagged(page);
 
 			kvm_release_page_dirty(page);
 		}
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a0d4981ebb998..9365d83a646d7 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1598,11 +1598,10 @@ static int get_vma_page_shift(struct vm_area_struct *vma)
  * able to see the page's tags and therefore they must be initialised first. If
  * PG_mte_tagged is set, tags have already been initialised.
  *
- * Must be called with kvm->mmu_lock held to ensure the memory remains mapped
- * while the tags are zeroed.
+ * The caller must hold kvm->mmu_lock or a reference on the page, so that the
+ * page isn't freed while the tags are zeroed.
  */
-static void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
-			      unsigned long size)
+void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn, unsigned long size)
 {
 	unsigned long i, nr_pages = size >> PAGE_SHIFT;
 	struct page *page = pfn_to_page(pfn);

base-commit: 012e4bc01e339a65dc7c59181b5efb33b171d12c
-- 
2.47.3

