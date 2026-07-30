Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB4426438
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413743; cv=none; b=KKqdHiNKMeZGBIrw7vTybXO7vQ7lpFSz3cvH6faJkj1PyUMf7hjBqBeyZcsxWUN5BlF8vm/tQkFekPoYc+AfAbkZ+3N3LvrHo7lB2fTDsoG2TQuLeota3Bbs612dZabP3RHFtqtBiQmntLi0Z9vYVUnhaXtqU2Fr3NvWOkE5aeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413743; c=relaxed/simple;
	bh=ZKRHgXeHqO903t/movusfQdY0Ec7CoJTsvys+qucWLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jn7BSCLneJdY1H+g9VYW827srGkFS51kF9RXYS3TjaT+Nprb0FjKbab5q/d8/oOFddiTr7nywH1V2osDw2jHBz79sQm8S2JaYCOwFpXduob0vH4oHBQwfAKy9vZ0WTIudHx/QaN09tyJUwcVkYGYyby51Kx0N+2KmtoAOlPGKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSdl0yr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSdl0yr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F05D1F00A3E;
	Thu, 30 Jul 2026 12:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413738;
	bh=GnR50GSm7ZKbD9PQhK1G3twQvPKOXtlwsjve9JSc5Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iSdl0yr7bipQk9nLL4xj1IOA6Hxn0zS+BLmRXoBgriL+a1AHHAlrnK+HUpmdImhV1
	 QL5TWmX+f6iwwy9C7oLyqzW+hfqcWZPGes3eS+s7JQvIoOER3SyU7ob+WxSABBF9T7
	 ERpTZ17YK/Dqc+LKOLIITiDnFmJwq2RDq5AaDI6N+BJamhVD4NuTuRTAMux8BcLbHc
	 aXnPcGJ8+wnrcKHBzrSHWmcHRFDd2PLrfYRh6ESPuYdc3pNav+iYC14Kv/oAOPr7OU
	 41gb76RcHvtz303dxtMWbSqPERtOhP8jng3rt0UmU7WJwg0uGwUIIYroet0nTsclb4
	 EuEAyON2isWjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] KVM: x86: Check for invalid/obsolete root *after* making MMU pages available
Date: Thu, 30 Jul 2026 08:15:35 -0400
Message-ID: <20260730121535.2208491-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730121535.2208491-1-sashal@kernel.org>
References: <2026072556-gem-immunize-5c2f@gregkh>
 <20260730121535.2208491-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 2abd5287f08319fa35764566b15c6e22cb1068db ]

Check for a "stale" page fault, i.e. for an invalid and/or obsolete root,
after making MMU pages available for the shadow MMU.  If reclaiming shadow
pages zaps an in-use root, i.e. marks it invalid, then KVM will attempt to
map memory into an invalid root.  On its own, populating an invalid root is
"fine", but because child shadow pages inherit their parent's role, any
children created during the map/fetch will be created as invalid pages,
thus violating KVM's invariant that invalid pages are never on the list of
active MMU pages.

Note, the underlying flaw has existed since KVM first started tracking
invalid roots in 2008 (commit 2e53d63acba7, "KVM: MMU: ignore zapped root
pagetables"), but the true badness only came along in 2020 (Linux 5.9)
with the invariant that invalid shadow pages can't be on the list of
active pages.

Note #2, inheriting role.invalid when creating child shadow pages is also
far from ideal; that flaw will be addressed separately.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Fixes: f95eec9bed76 ("KVM: x86/mmu: Don't put invalid SPs back on the list of active pages")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c         |  9 +++++----
 arch/x86/kvm/mmu/paging_tmpl.h | 10 ++++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 945cf6a7562b72..9b7edec880e3cc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4281,16 +4281,17 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		return r;
 	}
 
-	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault))
-		goto out_unlock;
-
 	r = make_mmu_pages_available(vcpu);
 	if (r)
 		goto out_unlock;
 
+	if (is_page_fault_stale(vcpu, fault)) {
+		r = RET_PF_RETRY;
+		goto out_unlock;
+	}
+
 	r = direct_map(vcpu, fault);
 
 out_unlock:
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 8d1ab32ee5f9e0..2ea7bd1a6bb5f4 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -865,15 +865,17 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 	orig_pfn = fault->pfn;
 
-	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault))
-		goto out_unlock;
-
 	r = make_mmu_pages_available(vcpu);
 	if (r)
 		goto out_unlock;
+
+	if (is_page_fault_stale(vcpu, fault)) {
+		r = RET_PF_RETRY;
+		goto out_unlock;
+	}
+
 	r = FNAME(fetch)(vcpu, fault, &walker);
 
 out_unlock:
-- 
2.53.0

