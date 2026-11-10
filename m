Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311703;
	b=xtdOWjftZErVyO5VFpJoxq+wj8BoH7Ao3IFPy+gSdAJCN6K9MQLGVOwlUMoxqDIoAhHr
	 DhmElRXet2k37NeC6jnDpt1j/LDYx3B2EiUa6MlEOP0wUgafknNvaTnqvt+Wg8Nlx3OtT
	 0UcSVuur7Bwt1n7LiyFGVsB7w1ddFLVc40Yq2bWEplugYOFGDghBV0lLNBrYTRpNuobpN
	 rvawS3PwbxzzFplGYASuGKYCzRSu61ZUK5ffzF4yNF3LVvnq18TGO2K0uVZ08RP5/2H6V
	 mqXaXrpeJuk5waM1H2gaWA3GutswiBB6gl0DPt5gx+BDNz1yKGtAh3I5L2ZIatdCeSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O2AAMo+odWtGD8zgdP7oQVxh9f4upC1p8c94zDd79JA=;
	b=YRD05FjyoHYtYbLjZ4lwNL6J/dcJF+Q0e+fZhM90Btwj7KSyFboLEFEhME1gTZ5/psVn
	 VCZjCHKTWvEO1WeIuD5gzuvv9TAXUeYaotoNpQh1c0GBwbeSk7fXGfq6rHUjV+gG6C2oT
	 kX+VAggdEKHIcA4TbutzeLj64XzHTZHRwKnY45gWf41RntSiqZq9puPq3LG8OrvYomdUi
	 hRUA3uLJNO7Zc3V8AZ0BQb4d3BwAm+n1LNXfTTJH2a3VY5tgrqSbEhC4MPKfwEborPI2G
	 KBvJrTONhkmk7IodEy/t6mVUuxgYDVTfQi5bHyAnOf2PrxACIeQtv3GajU3vZ6p9Pew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7ZykfXg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F81606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7ZykfXg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497401F0089F;
	Tue, 10 Nov 2026 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311703;
	bh=O2AAMo+odWtGD8zgdP7oQVxh9f4upC1p8c94zDd79JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n7ZykfXgMD1rI1SvmvwuHgJe7+Rp8dGPja+U+QnK/tikoqr8n9WcJZrixxy6KGxgo
	 c5pz7HzNxhq4D4Hzc6DJjrRPqW38U9zeuGLEl1349wDBUgASLXi8draqFj5W+4h0Th
	 KTdCHEgFJqenggl6OWu1y7sXvygMHG9By8X/mqFW4t9EgYY7G0lj5ZQzrIjtwPV+G4
	 B6H94gVpkOnL3kxK6SK//31rzaW1moGFp/NG+zmEwX+sakU0YoYlwksQcAXs83O30r
	 oPRZMrA4YWPio8WOqLILlbW3hkFFHoG12H+aCG/nRGPFjJ2xkDxoTP6W5d7Hmb/Mja
	 Rcnt9TRakARkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: arm64: Use kvm_s2_fault_vma_info in gmem_abort()
Date: Tue, 10 Nov 2026 06:55:01 -0500
Message-ID: <20261110115443.861330-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050759-failed-6.18-80b0b86dc5e4@kernel.org>
References: <20261107050759-failed-6.18-80b0b86dc5e4@kernel.org>
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

From: Fuad Tabba <fuad.tabba@linux.dev>

[ Upstream commit 80b0b86dc5e4344e62a2fd3ee43d0ef816fe9122 ]

gmem_abort() maps at s2fd->fault_ipa, which HPFAR_EL2 holds at 4K
granularity whatever the page size. The generic page-table code aligns
it, but pkvm_pgtable_stage2_map() looks up existing mappings over
[addr, addr + size), so on a pKVM host with pages larger than 4K a
guest_memfd-backed guest that faults past the first 4K of a page can
find its neighbour's mapping, get -EAGAIN and take the same fault
forever.

The memory fault exit reports s2fd->fault_ipa too, which for a nested
guest's fault is the nested IPA rather than the canonical one
kvm_gmem_get_pfn() failed on.

Take the addresses from kvm_s2_fault_vma_info instead, as
user_mem_abort() does, and report the canonical gfn in the memory fault
exit. kvm_s2_fault_get_vma_info() itself isn't called: a guest_memfd
memslot's userspace_addr doesn't need to be backed by a VMA.

Fixes: a7b57e0995927 ("KVM: arm64: Handle guest_memfd-backed guest page faults")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260913175105.A57AC1F000FF@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Link: https://patch.msgid.link/20260928095454.3255918-4-vdonnefort@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ sashal: Adapted upstream kvm_s2_fault_desc and kvm_s2_fault_vma_info usage to existing gmem_abort() arguments and local variables. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index af50fed5b5975..e8029ac82da74 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1536,6 +1536,8 @@ static int gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (ret)
 		return ret;
 
+	fault_ipa = ALIGN_DOWN(fault_ipa, PAGE_SIZE);
+
 	if (nested)
 		gfn = kvm_s2_trans_output(nested) >> PAGE_SHIFT;
 	else
@@ -1552,7 +1554,7 @@ static int gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 	ret = kvm_gmem_get_pfn(kvm, memslot, gfn, &pfn, &page, NULL);
 	if (ret) {
-		kvm_prepare_memory_fault_exit(vcpu, fault_ipa, PAGE_SIZE,
+		kvm_prepare_memory_fault_exit(vcpu, gfn_to_gpa(gfn), PAGE_SIZE,
 					      write_fault, exec_fault, false);
 		return ret;
 	}
-- 
2.53.0

