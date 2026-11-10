Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311200;
	b=wlc2Bwl6bS3VkyEylfwCb9UyalmDHMEcA/ytqZbx6PaBdJgOOmKtTzfq25/eIcztSwWS
	 tjWGjX3YfmAmkT/TyAQAZlhxCjiKVWcNC9nl3tKvUz/fzhEwMJgn5Xcp7Noc53hbVgrtc
	 U/DpRERMNmtsnBBmf53oPj1REcoi07h7R62pHE59cX+b/aqrJgwxK6+rwJ141kakq//k1
	 QhQv/Pu7t603mgwjefBs8aIqcsjsuWAGkm0qrf7LK3bD5+enab+powsiFf4YIxPJ+Rkeo
	 3Wm/HBlS59QBkfAkRfsUil+3/4U9aHKNzhUngu78trfDl53s6uftUkmTSr8804JTF2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311200;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HrYW/0LYIbiNDRkJ8vrZ2THlEadJhaIKaXA1yE9SR08=;
	b=czx7EBhj1d8+P5CEzh2yYS3m89OINpUx7yTeeXgBj/fBJlo42Z/pU1dPX5mpnDH7I9Qr
	 mAW7mEz2J1NIr/4VTSCM6ZlTsPJr4W5vL5spkdmn7yTKdpzc++za8ax0ZUwmUMLUvuq4N
	 aK/61NxumWZ1k22a1BzwxtVEMODiDMV8GhMkUSb6L8+5BJ/w1AJ3E4y1oyT9au2n//3r5
	 ildPsnREyH1WBWPeq3ae4Uop+7irfvgnAdGqSw4qW/ofss1evG/mfNxIYdRZUSmSkSQi/
	 L6RB8Gt08ues+VZWNVaqHXZvzUnPWWMsC7YPUXY3BbzAzXjsm8jtQuti8BZDXi9UZJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEPyD1vr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D927606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEPyD1vr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D441F0089F;
	Tue, 10 Nov 2026 11:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311200;
	bh=HrYW/0LYIbiNDRkJ8vrZ2THlEadJhaIKaXA1yE9SR08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IEPyD1vr4aE7hFQtv5vWVHqgiDmimXPOZAcxC/duqGaqaZa1ZKU9rnSQJL748f8gZ
	 YD7gme/2rr4tX2rCBXEPzReDoBc5VmZUZOCWodD/OZQhJXN6G8uN34RFgW3JA1E/4k
	 1N8f6sL5XJnpeGI6b4rcnuCUzm1MQA8cSv4qHtS0Lp6WMGlp3ZTNicS20e8FvmZ/Tq
	 zHnMqmj9D4Y2LN/7seiYaj/3A8y+rQSfpnSvla3xbZ5ADUD3EuEcXHsfRuA4V4H0wt
	 1loDNu3XWqg8k8idbdf1UPImoTDOPLt6XrMzJDZpwwsFKVUq2lufTjTUFHicz3u8VV
	 RCxbQWqiIUEMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] KVM: arm64: Pass kvm_s2_fault_desc to fault_supports_stage2_huge_mapping()
Date: Tue, 10 Nov 2026 06:46:36 -0500
Message-ID: <20261110114632.607777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050354-failed-7.3-80b0b86dc5e4@kernel.org>
References: <20261107050354-failed-7.3-80b0b86dc5e4@kernel.org>
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

From: Vincent Donnefort <vdonnefort@google.com>

[ Upstream commit 10c5cc50f056a6425305557063ad70c3eb0e686b ]

Pass the fault descriptor to fault_supports_stage2_huge_mapping() instead
of passing memslot and hva separately so it can access other s2fd
members such as vcpu. This implies to pass that same s2fd argument to
transparent_hugepage_adjust().

No functional change intended.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
Link: https://patch.msgid.link/20260928095454.3255918-3-vdonnefort@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Stable-dep-of: 80b0b86dc5e4 ("KVM: arm64: Use kvm_s2_fault_vma_info in gmem_abort()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/mmu.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index bf6d6526639fa..291696dda0741 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1362,12 +1362,21 @@ static void kvm_send_hwpoison_signal(unsigned long address, short lsb)
 	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, current);
 }
 
-static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
-					       unsigned long hva,
+struct kvm_s2_fault_desc {
+	struct kvm_vcpu		*vcpu;
+	phys_addr_t		fault_ipa;
+	struct kvm_s2_trans	*nested;
+	struct kvm_memory_slot	*memslot;
+	unsigned long		hva;
+};
+
+static bool fault_supports_stage2_huge_mapping(const struct kvm_s2_fault_desc *s2fd,
 					       unsigned long map_size)
 {
-	gpa_t gpa_start;
+	struct kvm_memory_slot *memslot = s2fd->memslot;
+	unsigned long hva = s2fd->hva;
 	hva_t uaddr_start, uaddr_end;
+	gpa_t gpa_start;
 	size_t size;
 
 	/* The memslot and the VMA are guaranteed to be aligned to PAGE_SIZE */
@@ -1436,9 +1445,9 @@ static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
  * Returns the size of the mapping.
  */
 static long
-transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
-			    unsigned long hva, kvm_pfn_t *pfnp, gfn_t *gfnp)
+transparent_hugepage_adjust(const struct kvm_s2_fault_desc *s2fd, kvm_pfn_t *pfnp, gfn_t *gfnp)
 {
+	struct kvm *kvm = s2fd->vcpu->kvm;
 	kvm_pfn_t pfn = *pfnp;
 	gfn_t gfn = *gfnp;
 
@@ -1447,8 +1456,8 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	 * sure that the HVA and IPA are sufficiently aligned and that the
 	 * block map is contained within the memslot.
 	 */
-	if (fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
-		int sz = get_user_mapping_size(kvm, hva);
+	if (fault_supports_stage2_huge_mapping(s2fd, PMD_SIZE)) {
+		int sz = get_user_mapping_size(kvm, s2fd->hva);
 
 		if (sz < 0)
 			return sz;
@@ -1585,14 +1594,6 @@ static enum kvm_pgtable_prot adjust_nested_exec_perms(struct kvm *kvm,
 	return prot;
 }
 
-struct kvm_s2_fault_desc {
-	struct kvm_vcpu		*vcpu;
-	phys_addr_t		fault_ipa;
-	struct kvm_s2_trans	*nested;
-	struct kvm_memory_slot	*memslot;
-	unsigned long		hva;
-};
-
 static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 {
 	bool write_fault, exec_fault;
@@ -1779,7 +1780,7 @@ static short kvm_s2_resolve_vma_size(const struct kvm_s2_fault_desc *s2fd,
 	switch (vma_shift) {
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SHIFT:
-		if (fault_supports_stage2_huge_mapping(s2fd->memslot, s2fd->hva, PUD_SIZE))
+		if (fault_supports_stage2_huge_mapping(s2fd, PUD_SIZE))
 			break;
 		fallthrough;
 #endif
@@ -1787,7 +1788,7 @@ static short kvm_s2_resolve_vma_size(const struct kvm_s2_fault_desc *s2fd,
 		vma_shift = PMD_SHIFT;
 		fallthrough;
 	case PMD_SHIFT:
-		if (fault_supports_stage2_huge_mapping(s2fd->memslot, s2fd->hva, PMD_SIZE))
+		if (fault_supports_stage2_huge_mapping(s2fd, PMD_SIZE))
 			break;
 		fallthrough;
 	case CONT_PTE_SHIFT:
@@ -2027,9 +2028,7 @@ static int kvm_s2_fault_map(const struct kvm_s2_fault_desc *s2fd,
 		if (perm_fault_granule > PAGE_SIZE) {
 			mapping_size = perm_fault_granule;
 		} else {
-			mapping_size = transparent_hugepage_adjust(kvm, s2fd->memslot,
-								   s2fd->hva, &pfn,
-								   &gfn);
+			mapping_size = transparent_hugepage_adjust(s2fd, &pfn, &gfn);
 			if (mapping_size < 0) {
 				ret = mapping_size;
 				goto out_unlock;
-- 
2.53.0

