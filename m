Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1443B0AE2
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093864; cv=none; b=QoR/WKJ2BvwzfBpdsji5qMyJfhvPvkJ+N6fVvmu7FpaZIkgISk1UN3bCGS1l1hmJAz8hF7izEx+Jj7jamZ0u41m0RyU+7FIV/tgdjQ/x5DimEP1/cscfPJZHkpTNowVAVU9D7Tr+rwf7e5G2nW+8zHVggVqFf8IMS+RHsrnXqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093864; c=relaxed/simple;
	bh=FtEl1jjAkg4MwJl20ZOiq7vTcDJ1IOpmcmbwvJoAN2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNfJap1omKe3xCSWljRDBBVRc9i7CqL0li990pPkYDMAEmiEgPASlpxrJUdePZl3YBtTzyIjQOXZsme9/WN28477fVA6LWTe8S7pEY4Gtqwf2u94RAuqZarBJqWTWBluflnwtQ991hginYzJndlvFuesHr2dYs1zDIGmWXLr4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzfzAykm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzfzAykm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B081F000FF;
	Fri, 11 Sep 2026 02:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093862;
	bh=mOWxZZQY+WiMZkl6fr9lFURyHt4uZpXGCNijQ0boxa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AzfzAykmTaW6DjzRS/Ey9Ag2jx6mppamKrGilq30A3vAQ3UXanCyxON4oY+2/m1OY
	 qdqlKPNxvauaNged565ETt2X/ouj7bCzvAD2rTcHYjqXT54tbQImSgIdp8TIDA/+X3
	 5i4Y1edoo9Goy+55C0dh5q54rbYkS/JyPM1X/wrDBsV0NCabKRB7n2Dx6NaDVucAj/
	 t0e0fHovqB33PuqVDT8eKGGl/hkAvivvkYNnl3SKK7zopwWIGy2UO+uFV11rIyUpHR
	 H0zTM436rWI+WXqoQA8OAOEat0PBwfQIaZash2PlUjV6ke8GwKG8jl4+uv2JcQiKET
	 /ScAz2qTjC5fQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Vipin Sharma <vipinsh@google.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] KVM: x86/mmu: Dynamically allocate shadow MMU's hashed page list
Date: Thu, 10 Sep 2026 22:30:59 -0400
Message-ID: <20260911023100.75724-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090911-eats-threefold-66cf@gregkh>
References: <2026090911-eats-threefold-66cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 039ef33e2f9346258fe2bd344f212c645942575e ]

Dynamically allocate the (massive) array of hashed lists used to track
shadow pages, as the array itself is 32KiB, i.e. is an order-3 allocation
all on its own, and is *exactly* an order-3 allocation.  Dynamically
allocating the array will allow allocating "struct kvm" using kvmalloc(),
and will also allow deferring allocation of the array until it's actually
needed, i.e. until the first shadow root is allocated.

Opportunistically use kvmalloc() for the hashed lists, as an order-3
allocation is (stating the obvious) less likely to fail than an order-4
allocation, and the overhead of vmalloc() is undesirable given that the
size of the allocation is fixed.

Cc: Vipin Sharma <vipinsh@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250523001138.3182794-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: b27622c4eeb1 ("KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back" halves")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/kvm/mmu/mmu.c          | 23 ++++++++++++++++++++++-
 arch/x86/kvm/x86.c              |  5 ++++-
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index bb04de781b69d..565582cd96392 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1307,7 +1307,7 @@ struct kvm_arch {
 	bool has_private_mem;
 	bool has_protected_state;
 	bool pre_fault_allowed;
-	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
+	struct hlist_head *mmu_page_hash;
 	struct list_head active_mmu_pages;
 	struct list_head zapped_obsolete_pages;
 	/*
@@ -1954,7 +1954,7 @@ void kvm_mmu_vendor_module_exit(void);
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_mmu_create(struct kvm_vcpu *vcpu);
-void kvm_mmu_init_vm(struct kvm *kvm);
+int kvm_mmu_init_vm(struct kvm *kvm);
 void kvm_mmu_uninit_vm(struct kvm *kvm);
 
 void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b5a5e5c3cc5a5..8d46a307a2a3b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3772,6 +3772,18 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 	return r;
 }
 
+static int kvm_mmu_alloc_page_hash(struct kvm *kvm)
+{
+	struct hlist_head *h;
+
+	h = kvcalloc(KVM_NUM_MMU_PAGES, sizeof(*h), GFP_KERNEL_ACCOUNT);
+	if (!h)
+		return -ENOMEM;
+
+	kvm->arch.mmu_page_hash = h;
+	return 0;
+}
+
 static int mmu_first_shadow_root_alloc(struct kvm *kvm)
 {
 	struct kvm_memslots *slots;
@@ -6542,14 +6554,20 @@ static bool kvm_has_zapped_obsolete_pages(struct kvm *kvm)
 	return unlikely(!list_empty_careful(&kvm->arch.zapped_obsolete_pages));
 }
 
-void kvm_mmu_init_vm(struct kvm *kvm)
+int kvm_mmu_init_vm(struct kvm *kvm)
 {
+	int r;
+
 	kvm->arch.shadow_mmio_value = shadow_mmio_value;
 	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
 	INIT_LIST_HEAD(&kvm->arch.zapped_obsolete_pages);
 	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
 	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
 
+	r = kvm_mmu_alloc_page_hash(kvm);
+	if (r)
+		return r;
+
 	if (tdp_mmu_enabled)
 		kvm_mmu_init_tdp_mmu(kvm);
 
@@ -6560,6 +6578,7 @@ void kvm_mmu_init_vm(struct kvm *kvm)
 
 	kvm->arch.split_desc_cache.kmem_cache = pte_list_desc_cache;
 	kvm->arch.split_desc_cache.gfp_zero = __GFP_ZERO;
+	return 0;
 }
 
 static void mmu_free_vm_memory_caches(struct kvm *kvm)
@@ -6571,6 +6590,8 @@ static void mmu_free_vm_memory_caches(struct kvm *kvm)
 
 void kvm_mmu_uninit_vm(struct kvm *kvm)
 {
+	kvfree(kvm->arch.mmu_page_hash);
+
 	if (tdp_mmu_enabled)
 		kvm_mmu_uninit_tdp_mmu(kvm);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9e7c9e3edb5b4..a9c3063ce7841 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12824,7 +12824,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (ret)
 		goto out;
 
-	kvm_mmu_init_vm(kvm);
+	ret = kvm_mmu_init_vm(kvm);
+	if (ret)
+		goto out_cleanup_page_track;
 
 	ret = kvm_x86_call(vm_init)(kvm);
 	if (ret)
@@ -12869,6 +12871,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 out_uninit_mmu:
 	kvm_mmu_uninit_vm(kvm);
+out_cleanup_page_track:
 	kvm_page_track_cleanup(kvm);
 out:
 	return ret;
-- 
2.53.0

