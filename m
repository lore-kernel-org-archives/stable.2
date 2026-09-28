Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4D4F0539;
	Mon, 28 Sep 2026 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613903; cv=none; b=lCZyWggg+rBE/v5UHaLK5Otr9bVrLdRp4WnTzUB4+xNT77e8C40mwCp1OVaufQVOFIwxrMkBYXxtyIj1XzSWbKEpX0/6HfVpvKBInnSB9nLn1tiSPRbGR9JD5DxG1VO6PETbtU/EmKaju1uxEyxDdE4nZ186KV05+LT28gKSEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613903; c=relaxed/simple;
	bh=AmfazACOY2Lfn9Upgjuoc8xhPYD9/Pd+I0NCiz54tcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEGC2xpE+LjoQ/8qAqo5jKZPHB+a9TPZswQuFxoh7/uz2QNl8dk7o+1apoKRMtZZecM/7963/zaGA1SmkCmuyeF4EbLZh7GrOqN1M5qqGAzvApavUqL3DVoGDEsuzi7nwPhgAqvGiTNaMMl27AwI2/W+ZX4vqra/1bvtp82q8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=V37QtXH7; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="V37QtXH7"
Received: from fedora ([104.28.225.80])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68SGijNt080644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 01:44:51 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=jJquaZ7/L3FLzY/EfvtLrHaMkMas/3MvH4waoUzC1Ks=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1790613891; v=1;
        b=V37QtXH7YLmrL7btkQvn8P5YlpuAhwcpV1Zc5i+Ike07B/g/p0qt/ByRZ4TEmOWK
         VSMQwQ7CBoJxLdddms1wIZeqpajkg5zuYpsNsM97BjIv2tV+JRCCmsSmB12Q8d2I
         /duthRTEam6JkVyENfom950u17GrKwF7kGDIg2FeWS2UMaU0e9VKP6dwHzGL2KXi
         Fl6spd/aY7bbGgSOmhll603BT1iV640jVq080oNr7uLRqnjCgusjrvMiqYAsuayY
         AdB+yxIPoz6HPztfnk87FJxMUMwGJYEdHZSUNliJ4SziLTEDQ/u/8GP/G1wdqMFU
         hwEGqW1RN7o1AYbndKRLVw==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v4 08/11] KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
Date: Tue, 29 Sep 2026 01:44:24 +0900
Message-ID: <20260928164427.4699-9-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928164427.4699-1-k@mgml.me>
References: <20260928164427.4699-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Bonzini <pbonzini@redhat.com>

commit 7f49777550e55a7d6832cbb0873f48f91c175b9c upstream.

The quadrant is only used when gptes are 4 bytes, but
mmu_alloc_{direct,shadow}_roots() pass in a non-zero quadrant for PAE
page directories regardless. Make this less confusing by only passing in
a non-zero quadrant when it is actually necessary.

Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-6-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 48015f96b1dc..d4468b53c46f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3474,9 +3474,10 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 	struct kvm_mmu_page *sp;
 
 	role.level = level;
+	role.quadrant = quadrant;
 
-	if (role.has_4_byte_gpte)
-		role.quadrant = quadrant;
+	WARN_ON_ONCE(quadrant && !role.has_4_byte_gpte);
+	WARN_ON_ONCE(role.direct && role.has_4_byte_gpte);
 
 	sp = kvm_mmu_get_page(vcpu, gfn, role);
 	++sp->root_count;
@@ -3512,7 +3513,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		for (i = 0; i < 4; ++i) {
 			WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
-			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), i,
+			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), 0,
 					      PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK |
 					   shadow_me_mask;
@@ -3536,9 +3537,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	u64 pdptrs[4], pm_mask;
 	gfn_t root_gfn, root_pgd;
+	int quadrant, i, r;
 	hpa_t root;
-	unsigned i;
-	int r;
 
 	root_pgd = mmu->get_guest_pgd(vcpu);
 	root_gfn = root_pgd >> PAGE_SHIFT;
@@ -3621,7 +3621,15 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 			root_gfn = pdptrs[i] >> PAGE_SHIFT;
 		}
 
-		root = mmu_alloc_root(vcpu, root_gfn, i, PT32_ROOT_LEVEL);
+		/*
+		 * If shadowing 32-bit non-PAE page tables, each PAE page
+		 * directory maps one quarter of the guest's non-PAE page
+		 * directory. Othwerise each PAE page direct shadows one guest
+		 * PAE page directory so that quadrant should be 0.
+		 */
+		quadrant = mmu->mmu_role.base.has_4_byte_gpte ? i : 0;
+
+		root = mmu_alloc_root(vcpu, root_gfn, quadrant, PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
-- 
2.53.0

