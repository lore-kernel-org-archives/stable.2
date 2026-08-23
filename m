Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426C83A4523
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787490537; cv=none; b=CmoVE0a4ap3yPVKcOmk0/g+FDrTolwJcqlVIkkN4QFRyTguOuQD5qMV86w42tzI/Nmy7br8i3ffS1jQY+nZtz1ssZPTu1KDfpKLxxQpzjHdpbn/nlFqcRD+O1k+qboqY2Eomhbil20t7xzUR4DM2iGOYmhB5IVLh+8jGUQ6iCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787490537; c=relaxed/simple;
	bh=sn72dACiFdTKdKQY9n3zZ3wRyYzQ+UCXxmkMWhE5G+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RG9BwOXbIzNted75mQrheXE6+TbFpFEWxXK+gD0NTQim5VJpG141DEb/wVsJbhJWo1qxG3guyR7dnCpBHLuaU1n/WWt9e0/MvVDY57A96f+Pk7tnaa363lA+68Mj98/4FLxJZ/6ur8OCy4/+YjuOjvgm3sQLgE4ETpkXyogcwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=uzJTTZgp; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="uzJTTZgp"
Received: from fedora (p4270056-ipxg00p01tokaisakaetozai.aichi.ocn.ne.jp [153.201.103.56])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67ND8383016116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 23 Aug 2026 22:08:40 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=jpbt8nQC4YQMVOxViaSEGnD2zsh1weHp9fXqI8ciwE4=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1787490520; v=1;
        b=uzJTTZgp/SKwxOYIAAjm9z2N3T6DOZHmCwB0YiaDjN9y7L8B9io7zDvQK0AvZONl
         zxco7lHoF1lL9zwWJKSVwo4u3QIeWRpvDVgR2CDIFAqqQbACqC0ci+lk+WLDZTT7
         KQAEbZ2q6H38vmdC/Ee+pAQ9lM9BnvbEZ0CRwVlYZWyHfFeEycRaJU4+k4eOiF1q
         cOweFb49/V3m1QbBfc5nnG3KoryQHoIdf88Yyu9+Amq9a3RsGT4665QTAhyU5of8
         7v5tZU2CtvOvFmdu068Te1jAgk3N31QaGkZYrgnC7Iw8K4BhtjMkMMROwz/kIrOG
         f8Qk5fX3aoYh4ePUYZQKCg==
From: Kenta Akagi <k@mgml.me>
To: stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Sasha Levin <sashal@kernel.org>,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v2 7/8] KVM: x86/mmu: Rename __direct_map() to direct_map()
Date: Sun, 23 Aug 2026 22:07:50 +0900
Message-ID: <20260823130751.2880-8-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823130751.2880-1-k@mgml.me>
References: <2026072557-gem-defensive-a757@gregkh>
 <20260823130751.2880-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Matlack <dmatlack@google.com>

[ Upstream commit 6c882ef4fc7bd99b67ad152e75428b669281c521 ]

Rename __direct_map() to direct_map() since the leading underscores are
unnecessary. This also makes the page fault handler names more
consistent: kvm_tdp_mmu_page_fault() calls kvm_tdp_mmu_map() and
direct_page_fault() calls direct_map().

Opportunistically make some trivial cleanups to comments that had to be
modified anyway since they mentioned __direct_map(). Specifically, use
"()" when referring to functions, and include kvm_tdp_mmu_map() among
the various callers of disallowed_hugepage_adjust().

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20220921173546.2674386-11-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8c1061b2f12f..019e24a76a96 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2995,11 +2995,11 @@ void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
 	    is_shadow_present_pte(spte) &&
 	    !is_large_pte(spte)) {
 		/*
-		 * A small SPTE exists for this pfn, but FNAME(fetch)
-		 * and __direct_map would like to create a large PTE
-		 * instead: just force them to go down another level,
-		 * patching back for them into pfn the next 9 bits of
-		 * the address.
+		 * A small SPTE exists for this pfn, but FNAME(fetch),
+		 * direct_map(), or kvm_tdp_mmu_map() would like to create a
+		 * large PTE instead: just force them to go down another level,
+		 * patching back for them into pfn the next 9 bits of the
+		 * address.
 		 */
 		u64 page_mask = KVM_PAGES_PER_HPAGE(level) -
 				KVM_PAGES_PER_HPAGE(level - 1);
@@ -3008,9 +3008,9 @@ void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
 	}
 }
 
-static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
-			int map_writable, int max_level, kvm_pfn_t pfn,
-			bool prefault, bool is_tdp)
+static int direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
+		      int map_writable, int max_level, kvm_pfn_t pfn,
+		      bool prefault, bool is_tdp)
 {
 	bool nx_huge_page_workaround_enabled = is_nx_huge_page_enabled();
 	bool write = error_code & PFERR_WRITE_MASK;
@@ -4055,8 +4055,8 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	if (r)
 		goto out_unlock;
 
-	r = __direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
-			 prefault, is_tdp);
+	r = direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
+		       prefault, is_tdp);
 
 out_unlock:
 	write_unlock(&vcpu->kvm->mmu_lock);
-- 
2.51.2

