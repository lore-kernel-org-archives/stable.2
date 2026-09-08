Received: from mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDAB5293FA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865658; cv=none; b=Mvu+awHTKKuxtNZFmVFaigYSKa1GwLNttbO0xEPj6DlbKAQljzq1gdhINaRs4SXlOCktH274fZavXFtmRZRsusiPjm5bSZnbGOsP/chHmuYPL5WhGhVcsKDmHHt68sactq1eYxkhwXg1r6JqTAFyhI7ZFucyK1fqON9e/A76pqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865658; c=relaxed/simple;
	bh=7jgjQnlj8gbwTTpqNz7Ycv0TSVqQ6IULxTwgTLGtkyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tafUTC5XoIWCkRduYrJv+CsAEQKRh63kT9IqsLwkt99Cyu9T3jcx8EzocHQTws+u3jp+QoZqsfd3o2cBb2vsa0l1+AO6hVPAbYN/JSNhl/KvBqXkLGJGp53/Aue2ONTZ8wvloY3K0g1BV0JmBABkrIgLMta0QU+Zl/YUFc4PsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Io1fyJVe; arc=none smtp.client-ip=91.218.175.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Io1fyJVe"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7jgjQnlj8gbwTTpqNz7Ycv0TSVqQ6IULxTwgTLGtkyI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788865652; v=1; x=1789470452;
 b=Io1fyJVecRxD50tlrFkV9hcvypBJ12XBJ4Lh8BSC3usi80iMtUbwsgXOHG2WBP3DS3yITN0s
 FRCEA8g9HHIM/ZoHdwbuE5aGS1yzP2liOUeXcBwModRMP9/HaycyHk05eTiRCe/OWzrMpXUg33Z
 DlYeKmbhh2F8kckUlaa4DWpg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2a5986739231b1ca;
	Tue, 08 Sep 2026 11:07:32 +0000
X-Mizu-Trace-ID: 2a5986739231b1ca
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
Subject: [PATCH 3/4] KVM: arm64: Move the private VA allocation cursor to __io_map_next
Date: Tue,  8 Sep 2026 12:07:12 +0100
Message-Id: <20260908110713.1540304-4-fuad.tabba@linux.dev>
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

__io_map_base is the start of the private VA range only until the first
allocation from it, after which it is the allocation cursor. Keep it as
the start and move the cursor to __io_map_next, for the walk of the
range the next patch adds.

No functional change intended.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/mm.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 3b0bee496bffb..422ee57be9560 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -25,6 +25,7 @@ struct memblock_region hyp_memory[HYP_MEMBLOCK_REGIONS];
 unsigned int hyp_memblock_nr;
 
 static u64 __io_map_base;
+static u64 __io_map_next;
 
 struct hyp_fixmap_slot {
 	u64 addr;
@@ -50,7 +51,7 @@ static int __pkvm_alloc_private_va_range(unsigned long start, size_t size)
 
 	hyp_assert_lock_held(&pkvm_pgd_lock);
 
-	if (!start || start < __io_map_base)
+	if (!start || start < __io_map_next)
 		return -EINVAL;
 
 	/* The allocated size is always a multiple of PAGE_SIZE */
@@ -60,7 +61,7 @@ static int __pkvm_alloc_private_va_range(unsigned long start, size_t size)
 	if (cur > __hyp_vmemmap)
 		return -ENOMEM;
 
-	__io_map_base = cur;
+	__io_map_next = cur;
 
 	return 0;
 }
@@ -70,7 +71,7 @@ static int __pkvm_alloc_private_va_range(unsigned long start, size_t size)
  * @size:	The size of the VA range to reserve.
  * @haddr:	The hypervisor virtual start address of the allocation.
  *
- * The private virtual address (VA) range is allocated above __io_map_base
+ * The private virtual address (VA) range is allocated above __io_map_next
  * and aligned based on the order of @size.
  *
  * Return: 0 on success or negative error code on failure.
@@ -81,7 +82,7 @@ int pkvm_alloc_private_va_range(size_t size, unsigned long *haddr)
 	int ret;
 
 	hyp_spin_lock(&pkvm_pgd_lock);
-	addr = __io_map_base;
+	addr = __io_map_next;
 	ret = __pkvm_alloc_private_va_range(addr, size);
 	hyp_spin_unlock(&pkvm_pgd_lock);
 
@@ -341,7 +342,7 @@ static int create_fixblock(void)
 		return -EINVAL;
 
 	hyp_spin_lock(&pkvm_pgd_lock);
-	addr = ALIGN(__io_map_base, PMD_SIZE);
+	addr = ALIGN(__io_map_next, PMD_SIZE);
 	ret = __pkvm_alloc_private_va_range(addr, PMD_SIZE);
 	if (ret)
 		goto unlock;
@@ -426,6 +427,7 @@ int hyp_create_idmap(u32 hyp_va_bits)
 	 */
 	__io_map_base = start & BIT(hyp_va_bits - 2);
 	__io_map_base ^= BIT(hyp_va_bits - 2);
+	__io_map_next = __io_map_base;
 	__hyp_vmemmap = __io_map_base | BIT(hyp_va_bits - 3);
 
 	return __pkvm_create_mappings(start, end - start, start, PAGE_HYP_EXEC);
@@ -433,19 +435,19 @@ int hyp_create_idmap(u32 hyp_va_bits)
 
 int pkvm_create_stack(phys_addr_t phys, unsigned long *haddr)
 {
-	unsigned long addr, prev_base;
+	unsigned long addr, prev_next;
 	size_t size;
 	int ret;
 
 	hyp_spin_lock(&pkvm_pgd_lock);
 
-	prev_base = __io_map_base;
+	prev_next = __io_map_next;
 	/*
 	 * Efficient stack verification using the NVHE_STACK_SHIFT bit implies
 	 * an alignment of our allocation on the order of the size.
 	 */
 	size = NVHE_STACK_SIZE * 2;
-	addr = ALIGN(__io_map_base, size);
+	addr = ALIGN(__io_map_next, size);
 
 	ret = __pkvm_alloc_private_va_range(addr, size);
 	if (!ret) {
@@ -461,7 +463,7 @@ int pkvm_create_stack(phys_addr_t phys, unsigned long *haddr)
 		ret = kvm_pgtable_hyp_map(&pkvm_pgtable, addr + NVHE_STACK_SIZE,
 					  NVHE_STACK_SIZE, phys, PAGE_HYP);
 		if (ret)
-			__io_map_base = prev_base;
+			__io_map_next = prev_next;
 	}
 	hyp_spin_unlock(&pkvm_pgd_lock);
 
-- 
2.39.5

