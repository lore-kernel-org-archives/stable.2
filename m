Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847136F8E1
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789317476; cv=none; b=ZjWhLtlNgwayhmybZa0BIZkGza9hqBRJldZmhIQLd99BbQUfHeR08Z+aWR3l/T1O0HnEIjVZ5fBWX4KirCA/8mwZSeS6EQYmitAXZ+0tVe7Q74spDO4SEcHYwu65wcXb8J2bWcR8bPk4o2ldddLY/dhgg1HLWRYkNOF5rvOvXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789317476; c=relaxed/simple;
	bh=1iSs/vrWHDlC2vp1ysdAiuMR483Lav+FKygNYu6jyBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiMGUmU3oRBps/ehzzc3862LJijQDLaNYvkhZUghNMiZkM/uXrCN0nXcc5qdXtB0nyoMHWa6UJXAFC3oo4QPGkeS+EBOYtVKKzJWSE/V5plWpzlt/fvAi9xvPVGC4gph3yFSRmEtJ4VPNw/mAUbNV2QZk1SbWHbfHOJJg6OtjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=byjqTuJW; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="byjqTuJW"
Received: from fedora (p3233127-ipxg00b01tokaisakaetozai.aichi.ocn.ne.jp [180.17.90.127])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68DFtZE6020593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 14 Sep 2026 00:55:47 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=qljtLoYmPRL1jB9MR4rFR4VrJjKYSmEFjcRWwNcZwss=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1789314948; v=1;
        b=byjqTuJWOuLY43AbZVSjKW18D9GZPOEMK9zk4Qjb3qPfUJhBbm+bEE0DVSxTVoZd
         VK8IKqPWJvvbHg7bOMy5/zywxD4jE/+TLWVyYNFDNidcqgg/xcyqyi+Iv7hwuDqt
         LmfqMfqb+t5OG1jFkTf6tE5Lj4jCXOxSjD30dx0LLSwvIapQ9sAy56RmW927kI1x
         DCcTOfMseLwXbMVOexNwQh2f2oM/o+MXSjSdIXYxQNREE0umThbAHbVoiW/BTvTV
         R535VIYO8AzgXQHn5JsO0SoYtbkqyz7ll5P+5YdcztoRvEaQAetOlV7uHiECzn2o
         rS8fgz93pRZNLycPA7nOPQ==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sean Christopherson <seanjc@google.com>, Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v3 1/7] KVM: x86/mmu: Use a bool for direct
Date: Mon, 14 Sep 2026 00:55:17 +0900
Message-ID: <20260913155523.7423-2-k@mgml.me>
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

