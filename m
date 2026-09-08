Received: from mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89152941A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865659; cv=none; b=H574LhIp/eX0xpU2KLOW6syE1DIGNzxyx+cfwR9kVSqmM11hKtt8tX4XXqeXs43T1olI/8wf8FX22/QFNcCVkBbdgVkX60NbQt5y6J/rD+hmoNu70nan6gtnm3t0D8mjvCu+MZWIX48KUJmyZMWYP390HkxFT8fHLB5GtICLB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865659; c=relaxed/simple;
	bh=n+vTJUIvsDxI7yNE//7ETqP96fI8JsmTAhqvehLBjCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/5URdzdjMz2GqwcoOo0A5iFDrzMSRNwZIXgOgjGlDQCQSkVWlCa0Z4DDe/u1xACHV3JDhbuyLZJiH7XzRHn+VU7NqhEy3dKcpDnKuHwFZRCXPnEgtaEu9nMhkSZqKd2DM3GkV9iSAjV4Bc1MMyRLBnXh0MmeGpd7lnfuIqICYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fw9nXrdr; arc=none smtp.client-ip=91.218.175.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fw9nXrdr"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n+vTJUIvsDxI7yNE//7ETqP96fI8JsmTAhqvehLBjCw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788865654; v=1; x=1789470454;
 b=Fw9nXrdrrkkKWAhzydgvKtfzedI2UdLMt6vCEmBAHhH9Z4/NCbrhcVPjLyNIkqJj2r5nGM+0
 491VgUcPWtwtCkSNTxhBJ2ofBbWhVaTiRj95lOsSH9VXguZpBtkdTo/qCnL7PrI/qLsQDRTgljq
 LwI6xy4ImfumwNednqaCJXSg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5f1e715ccda4b9bd;
	Tue, 08 Sep 2026 11:07:34 +0000
X-Mizu-Trace-ID: 5f1e715ccda4b9bd
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Keir Fraser <keirf@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Quentin Perret <qperret@google.com>,
	Hiroyuki Katsura <hk590@cam.ac.uk>,
	Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] KVM: arm64: Check every private mapping is hyp-owned at pKVM init
Date: Tue,  8 Sep 2026 12:07:13 +0100
Message-Id: <20260908110713.1540304-5-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260908110713.1540304-1-fuad.tabba@linux.dev>
References: <20260908110713.1540304-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix_host_ownership() transfers only what it walks, so a hyp mapping
outside the linear map is not manipulated by the walk.

Walk the quarter of the VA space holding the private range and the
vmemmap once the transfer is done, and fail init unless every valid
leaf is hyp-owned: in the vmemmap when the page is memory, and in the
host stage-2, where hyp text may instead be mapped without write
access. A leaf that is not memory has no vmemmap entry and is checked
against the host stage-2 alone. Hyp text is matched by physical
address, since the only executable mapping in the range is the
Spectre-v3a vectors, whose VA is a private allocation, and an
executable mapping of anything else must not be host-readable. The
vmemmap can be block-mapped, so the walker checks each page of a leaf.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 12 ++++
 arch/arm64/kvm/hyp/nvhe/mm.c                  | 59 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c               |  4 ++
 5 files changed, 77 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index cab27f7bd423a..ec85a95471207 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -55,6 +55,7 @@ bool addr_is_memory(phys_addr_t phys);
 bool addr_is_hyp_text(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
 int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id);
+bool host_stage2_pte_is_hyp_owned(kvm_pte_t pte);
 int kvm_host_prepare_stage2(void *pgt_pool_base);
 int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd);
 void kvm_guest_destroy_stage2(struct pkvm_hyp_vm *vm);
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 6e83ce35c2f2e..31cae95ddb716 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -29,6 +29,7 @@ int __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
 				  enum kvm_pgtable_prot prot,
 				  unsigned long *haddr);
 int pkvm_create_stack(phys_addr_t phys, unsigned long *haddr);
+int pkvm_check_host_ownership(void);
 int pkvm_alloc_private_va_range(size_t size, unsigned long *haddr);
 
 #endif /* __KVM_HYP_MM_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d026f446bd8ef..a6a47c1e058b3 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -641,6 +641,18 @@ int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id)
 	return ret;
 }
 
+bool host_stage2_pte_is_hyp_owned(kvm_pte_t pte)
+{
+	if (kvm_pte_valid(pte))
+		return false;
+
+	if (FIELD_GET(KVM_INVALID_PTE_TYPE_MASK, pte) !=
+	    KVM_HOST_INVALID_PTE_TYPE_DONATION)
+		return false;
+
+	return FIELD_GET(KVM_HOST_DONATION_PTE_OWNER_MASK, pte) == PKVM_ID_HYP;
+}
+
 #define KVM_HOST_PTE_OWNER_GUEST_HANDLE_MASK	GENMASK(15, 0)
 /* We need 40 bits for the GFN to cover a 52-bit IPA with 4k pages and LPA2 */
 #define KVM_HOST_PTE_OWNER_GUEST_GFN_MASK	GENMASK(55, 16)
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 422ee57be9560..29ab5ee9d57fc 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -472,6 +472,65 @@ int pkvm_create_stack(phys_addr_t phys, unsigned long *haddr)
 	return ret;
 }
 
+static int check_page_ownership(phys_addr_t phys)
+{
+	kvm_pte_t pte;
+	bool host_ok;
+	int ret;
+
+	if (addr_is_memory(phys)) {
+		struct hyp_page *page = hyp_phys_to_page(phys);
+
+		if (get_hyp_state(page) != PKVM_PAGE_OWNED ||
+		    get_host_state(page) != PKVM_NOPAGE)
+			return -EPERM;
+	}
+
+	ret = kvm_pgtable_get_leaf(&host_mmu.pgt, phys, &pte, NULL);
+	if (ret)
+		return ret;
+
+	/* Hyp text may stay host-readable, see fix_host_ownership_walker(). */
+	if (kvm_pte_valid(pte) && addr_is_hyp_text(phys))
+		host_ok = !(kvm_pgtable_stage2_pte_prot(pte) & KVM_PGTABLE_PROT_W);
+	else
+		host_ok = host_stage2_pte_is_hyp_owned(pte);
+
+	return host_ok ? 0 : -EPERM;
+}
+
+static int check_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
+				       enum kvm_pgtable_walk_flags visit)
+{
+	phys_addr_t phys, end;
+	int ret;
+
+	if (!kvm_pte_valid(ctx->old))
+		return 0;
+
+	phys = kvm_pte_to_phys(ctx->old);
+	end = phys + kvm_granule_size(ctx->level);
+	for (; phys < end; phys += PAGE_SIZE) {
+		ret = check_page_ownership(phys);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int pkvm_check_host_ownership(void)
+{
+	struct kvm_pgtable_walker walker = {
+		.cb	= check_host_ownership_walker,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	/* The private range and the vmemmap share one quarter of the VA space. */
+	return kvm_pgtable_walk(&pkvm_pgtable, __io_map_base,
+				BIT(pkvm_pgtable.ia_bits - 2), &walker);
+}
+
 static void *admit_host_page(void *arg)
 {
 	struct kvm_hyp_memcache *host_mc = arg;
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index bb667cd7080b4..45ac5f2ba4f7a 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -334,6 +334,10 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
+	ret = pkvm_check_host_ownership();
+	if (ret)
+		goto out;
+
 	ret = hyp_ffa_init(ffa_proxy_pages);
 	if (ret)
 		goto out;
-- 
2.39.5

