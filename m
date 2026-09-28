Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DDD4E36E2
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613899; cv=none; b=p4Zw//jruZA7jScGVdLFrbD7B4hA8Ef3o6w0QEq+yapD3bMNEzUPEWOCPE+qCIIjROGVuCa2MwhjDESyxgg7iAqIvQxq2IGOil7PD9IGBhxPtaE0i0AT3Xe+broIraErUMW3WAx74dQVsn5XwIlolQJ96/uM95IFYzraZRt7J80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613899; c=relaxed/simple;
	bh=1iSs/vrWHDlC2vp1ysdAiuMR483Lav+FKygNYu6jyBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeTiL7FNVjSHiCtRAk0OS8pmNM62iP/LjPozM9Af7JRvdPDMGzJ821iy4slCuAOXpZoaYk26+FEX34P/o1Y/KDqoZ95b+B4Kc8uBWRoZNvTwavfNid/35EcL1tniyYFxmnDRekXVpmM5+E5xUX1Rfe0/O6ri6k/qqqKrsMYnqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=WEGH5ozs; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="WEGH5ozs"
Received: from fedora ([104.28.225.80])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68SGijNm080644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 01:44:50 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=qljtLoYmPRL1jB9MR4rFR4VrJjKYSmEFjcRWwNcZwss=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1790613890; v=1;
        b=WEGH5ozsysmIp1e7azQv8ThlYNVXLQivA5pUqHAnb1A40yCjFurBJ+zuwG3jJ1lG
         fWk/cqXTfpkM3s3WGcYYcYRunHPq2ZlWB8YWoF33YQiGeFaqg+23T1QoIeHW8WzZ
         hDIK+YTATmFTyUEKkTe7dShazqvetefZYYnod4/Ysm94UrF1PgvdyPqnRNB9eDX7
         mn3BT3YAm9jpBUJPKFL5IKSQgpR85nCF1wOrhjG95Nqb3JSUgTnFXKXaPFEnmVZq
         KHMWoWyoV08u2r1jC+0vVpBA4GwMmjeYyOE9Rz2acDgJ9jOMCg0OzC5zQpdgtt+H
         mLPk1xItqL0KcWFYm8tczw==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sean Christopherson <seanjc@google.com>, Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v4 01/11] KVM: x86/mmu: Use a bool for direct
Date: Tue, 29 Sep 2026 01:44:17 +0900
Message-ID: <20260928164427.4699-2-k@mgml.me>
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

From: David Matlack <dmatlack@google.com>

commit 27a59d57f073f21f029df1517c2c0a1abea5b0ce upstream.

The parameter "direct" can either be true or false, and all of the
callers pass in a bool variable or true/false literal, so just use the
type bool.

No functional change intended.

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-3-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c0257bbb25c3..f5cfbf973e85 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1738,7 +1738,7 @@ static void drop_parent_pte(struct kvm_mmu_page *sp,
 	mmu_spte_clear_no_track(parent_pte);
 }
 
-static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, int direct)
+static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, bool direct)
 {
 	struct kvm_mmu_page *sp;
 
@@ -2079,7 +2079,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 					     gfn_t gfn,
 					     gva_t gaddr,
 					     unsigned level,
-					     int direct,
+					     bool direct,
 					     unsigned int access)
 {
 	bool direct_mmu = vcpu->arch.mmu->direct_map;
-- 
2.53.0

