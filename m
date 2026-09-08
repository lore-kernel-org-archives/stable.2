Received: from mta1.migadu.com (out-117.mta1.migadu.com [95.215.58.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC441D131
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865653; cv=none; b=qtEBI6JffQoI64qsM3cXVJaWxwphgQpmFllowID9EB7w7I56Zhz8uKmEaszlKvXcOIQcsWaiTnnhG9Kjb/6vs0iKBzKmwHgz0gCG1v/S+Y4BVfuP4HU5QJEkOo/gkSuXDCinbsxOUCRuFXtNetepWWZ3nwvRtCydaL6Gdp8vAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865653; c=relaxed/simple;
	bh=7bNXYL8yUcqTH70nhL/AuRr3pORuUPvFqJ6xx9nB3rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+wC+raS1fPeKMdSHR5uKiOIJZ+IkoMGZmB5yasRvzw0AW8SfjzHPtI1ExTvOtMpefunBUYghyJwL0kscJyki0NzEg3r34sTtMqAfppx1P2nCV7ivZZBO3NFSMfhQ+XKvv+Bq/6/FqOlvchXiYBElm2v+9jC8YesJeAi1VFwQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LZjw2Nbu; arc=none smtp.client-ip=95.215.58.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LZjw2Nbu"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7bNXYL8yUcqTH70nhL/AuRr3pORuUPvFqJ6xx9nB3rY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788865648; v=1; x=1789470448;
 b=LZjw2NbugqnYGVCacADZeG65gwnpjhnxo6xTX4MLAiDbDtkzcw6shcHmuIQT2//PDYfxh6fP
 Yup2NQHhBKJzo6168eWCWjcYXng/uXtilm8kz3F7QaBc5Pv9e9iUZFNzBZwpkil9CADhrgCxwLP
 L+DHz1bzpTm6yLen09gZdN3U=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 50cb0b689ffa052e;
	Tue, 08 Sep 2026 11:07:27 +0000
X-Mizu-Trace-ID: 50cb0b689ffa052e
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
Subject: [PATCH 2/4] KVM: arm64: Match hyp text by physical address in fix_host_ownership()
Date: Tue,  8 Sep 2026 12:07:11 +0100
Message-Id: <20260908110713.1540304-3-fuad.tabba@linux.dev>
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

On a non-hVHE host, fix_host_ownership_walker()'s test for PAGE_HYP_EXEC
never matches: KVM_PGTABLE_PROT_UX is cleared at map time and only PX is
reported on read-back. Hyp text is therefore donated rather than left
read-only in the host stage-2, and the instruction dump in
nvhe_hyp_panic_handler() reads a page the host has no access to.

Match the text by physical address instead, in a helper a later patch
reuses. A test on the permissions would leave any other executable
mapping host-readable too.

Fixes: 80cbfd7174f31 ("KVM: arm64: Honor UX/PX attributes for EL2 S1 mappings")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 8 ++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c               | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 29935c7da1dec..cab27f7bd423a 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -52,6 +52,7 @@ int __pkvm_host_test_clear_young_guest(u64 gfn, u64 nr_pages, bool mkold, struct
 int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu);
 
 bool addr_is_memory(phys_addr_t phys);
+bool addr_is_hyp_text(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
 int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id);
 int kvm_host_prepare_stage2(void *pgt_pool_base);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 39aa8911f62c1..d026f446bd8ef 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -450,6 +450,14 @@ bool addr_is_memory(phys_addr_t phys)
 	return !!find_mem_range(phys, &range);
 }
 
+bool addr_is_hyp_text(phys_addr_t phys)
+{
+	phys_addr_t start = ALIGN_DOWN(__hyp_pa(__hyp_text_start), PAGE_SIZE);
+	phys_addr_t end = PAGE_ALIGN(__hyp_pa(__hyp_text_end));
+
+	return phys >= start && phys < end;
+}
+
 static bool is_in_mem_range(u64 addr, struct kvm_mem_range *range)
 {
 	return range->start <= addr && addr < range->end;
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 362f2891cb32e..bb667cd7080b4 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -217,7 +217,7 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	case PKVM_PAGE_OWNED:
 		set_hyp_state(page, PKVM_PAGE_OWNED);
 		/* hyp text is RO in the host stage-2 to be inspected on panic. */
-		if (prot == PAGE_HYP_EXEC) {
+		if (addr_is_hyp_text(phys)) {
 			set_host_state(page, PKVM_NOPAGE);
 			return host_stage2_idmap_locked(phys, PAGE_SIZE, KVM_PGTABLE_PROT_R);
 		} else {
-- 
2.39.5

