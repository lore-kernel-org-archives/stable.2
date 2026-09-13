Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1537F306;
	Sun, 13 Sep 2026 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789317466; cv=none; b=luyRvyauE8LNWA56fPU9sURhwlSoJckpgKx4vQMlEOFKLLHg0UqQE4LUdm29jh893FL5amW/D02/T+MgeNzgG/KbHPPMxaA+MUH18sEXPrcYw67Wl+s/BhVQk6zzDg9PxHr4zoo/ZAKRNJHJk+we3URFKf6m2KgFcLPBHuPaj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789317466; c=relaxed/simple;
	bh=+qras4rwVzl2jsJaGMk0tKVesW5WPg9MF47fqYbvlVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMfAkdR/ZkDypjAdF9UmsuGaMhUxHiQSyP8kAv6sNOzlcrBepQiCZxUjnQwhW69xw8T1ro4wC5JmMwvsyzcPXPGXp0chF4HUwS3uWdKhewPI2buZGqLdw4uH4y/bnXtesQT3KNmfZFqf3PL25/mOYacXZL0xsY/eTc8jkx3t/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=n3lKEz+3; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="n3lKEz+3"
Received: from fedora (p3233127-ipxg00b01tokaisakaetozai.aichi.ocn.ne.jp [180.17.90.127])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68DFtZEC020593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 14 Sep 2026 00:55:48 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=pVwcP1e/me71DbSJVFHXPWArLsQKJ4GrRhXHd9EJWSk=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1789314948; v=1;
        b=n3lKEz+399metEt7v7wGwPUNuIt+KxpZ3+EMaTuI9e6bvrLE58VuAndtgjzvi+aS
         6ekAy6Wv3ku57Laof+cpXlz8WbU9Swqc1OfHQihIUMnLTWVDAT6qxctvD0J9BBsw
         HVEIHq5zSdaI3I2qLuv50DCoRPrQCqmXdjzwR4hCmbwmwpzid95Uz8dJPhOA8tqv
         uZOl/Eav1dQSAyoY4HopasQm0Y1rmPhNs8aTYKON+YGb3c5ZtcDhac3aNqzGzSy3
         ZZst5oaE4h27MKVGBuvo5/IHn7APFXnliPBfTAx87fUVG7aDCnTVlrcgHArsJyAV
         CTI+HuwGsjk7dbUH8/9yyw==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hyunwoo Kim <imv4bel@gmail.com>,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v3 7/7] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Mon, 14 Sep 2026 00:55:23 +0900
Message-ID: <20260913155523.7423-8-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913155523.7423-1-k@mgml.me>
References: <20260913155523.7423-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 81ccda30b4e83d8f5cc4fd50503c44e3a33abfeb ]

Commit 0cb2af2ea66ad ("KVM: x86: Fix shadow paging use-after-free due
to unexpected GFN") fixed a shadow paging mismatch between stored and
computed GFNs; the bug could be triggered by changing a PDE mapping from
outside the guest, and then deleting a memslot.  The rmap_remove()
call would miss entries created after the PDE change because the GFN
of the leaf SPTE does not match the GFN of the struct kvm_mmu_page.

A similar hole however remains if the modified PDE points to a non-leaf
page.  In this case the gfn can be made to match, but the role does not
match: the original large 2MB page creates a kvm_mmu_page with direct=1,
while the new 4KB needs a kvm_mmu_page with direct=0.  However,
kvm_mmu_get_child_sp() does not compare the role, and therefore reuses
the page.

The next step is installing a leaf (4KB) SPTE on the new path which
records an rmap entry under the gfn resolved by the walk.  But when
that child is zapped its parent kvm_mmu_page has direct=1 and
kvm_mmu_page_get_gfn() computes the gfn for the 4KB page as
sp->gfn + index instead of using sp->shadowed_translation[] (or sp->gfns[]
in older kernels).  It therefore fails to remove the recorded entry.

When the memslot is dropped the shadow page is freed but the rmap
entry survives, as in the scenario that was already fixed.  Code that
later walks that gfn (dirty logging, MMU notifier invalidation, and
so on) dereferences an sptep that lies in the freed page, causing the
use-after-free.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0610198b1f74..cc0dfacab65c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2180,13 +2180,15 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 						 u64 *sptep, gfn_t gfn,
 						 bool direct, unsigned int access)
 {
-	union kvm_mmu_page_role role;
+	union kvm_mmu_page_role role = kvm_mmu_child_role(sptep, direct, access);
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
-	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
+	if (is_shadow_present_pte(*sptep) &&
+	    !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) &&
+	    spte_to_child_sp(*sptep)->gfn == gfn &&
+	    spte_to_child_sp(*sptep)->role.word == role.word)
 		return ERR_PTR(-EEXIST);
 
-	role = kvm_mmu_child_role(sptep, direct, access);
 	return kvm_mmu_get_page(vcpu, gfn, role);
 }
 
-- 
2.53.0

