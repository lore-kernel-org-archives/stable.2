Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5232E134;
	Thu, 18 Jun 2026 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826134; cv=none; b=iR8fb36vA3m7FjUuhOObbiepP5y9jmhCNeYjZ02wfr1FIqYApN54lcWDb96SOAUzv5rpaTPTDk8UKKuYKlc8hZWfoyem9j+UJ9u3h40zzDJCfyRJYiwq+vyBvZVpTSd43CQDVZDRxedw0ipAN8sIr7N6Kb9Ef/2S+j0i07GiUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826134; c=relaxed/simple;
	bh=dZheFrdPr6VUm/XfAR4W5YK/OHYdUqIYx4Mxp89qVHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xjrxp3qx4izD36FH4YC6gDVqr4naaS5G301/p6V6CSP8w2AWfJLpyawuN8cdtTfiuQSufz2qvGUExoe3Y4chz9oJY3XN+QnIFd6jw1qYHwwKC8k/9Itl7MZXpkfn9EzNsvsfXTT8GRw/uKWKLLUXkDOfJlfra9gSooGHDQthMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ll2p8Lwg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ll2p8Lwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316121F00ADB;
	Thu, 18 Jun 2026 23:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781826133;
	bh=DYVbtXhd4YC3+rcB0IWX47zxBpn+10Hq976wk1oIPF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ll2p8LwgRFFRYEs6IC041RWdCDlAMEskZlxYB9DwWhIid7QzbLujA8bnNEyLgxisZ
	 p0nW7PuBpXVNxQ37zawCFh0YEH6mQge60na1NHfG+B03kt1TPvDtTsam0nXifRycjZ
	 d8Y+KVMuW0+3bTpJGXYcRDQxZusG6hPetD3KFJg6m0ZRiQFnNZVx+xumdQq8xu1INj
	 T7Yl2U4qugEkHueul1WQXhZRl16reRE5agsijKixLPoAhIhLB6gyh8ORkyn9HrIqaD
	 SLfiaHrgi9euaHzrv+T+rQ5UiOW8d+ZXIwVYMUQPe+KaTI99MBJSej3APt89hD+ab9
	 tiRxikz2aHl+g==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/5] KVM: arm64: nv: Inject SEA if guest VNCR isn't normal memory
Date: Thu, 18 Jun 2026 16:42:05 -0700
Message-ID: <20260618234207.1063941-5-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618234207.1063941-1-oupton@kernel.org>
References: <20260618234207.1063941-1-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When constructing an L1 VNCR mapping, KVM unconditionally uses cacheable
memory attributes, even if the underlying PFN isn't memory. This gets
particularly hairy if the endpoint doesn't support cacheable memory
attributes, potentially throwing an SError on writeback...

While KVM does permit cacheable memory attributes on certain PFNMAP
VMAs, kvm_translate_vncr() isn't currently grabbing the VMA. So do the
simpler thing for now and just reject everything that isn't memory.

Cc: stable@vger.kernel.org
Fixes: 2a359e072596 ("KVM: arm64: nv: Handle mapping of VNCR_EL2 at EL2")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/nested.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 7fffd86eee94..d4c9a9b05e3f 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1419,6 +1419,17 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 		writable = !(memslot->flags & KVM_MEM_READONLY);
 	}
 
+	/*
+	 * FIXME: This check is too restrictive as KVM allows cacheable memory
+	 * attributes for PFNMAP VMAs that have cacheable attributes in host
+	 * stage-1.
+	 */
+	if (!pfn_is_map_memory(pfn)) {
+		kvm_release_faultin_page(vcpu->kvm, page, true, false);
+		fail_s1_walk(&vt->wr, ESR_ELx_FSC_EXTABT, false);
+		return -EINVAL;
+	}
+
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
 		if (mmu_invalidate_retry(vcpu->kvm, mmu_seq)) {
 			kvm_release_faultin_page(vcpu->kvm, page, true, false);
-- 
2.47.3

