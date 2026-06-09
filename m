Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D7331EC9;
	Tue,  9 Jun 2026 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031129; cv=none; b=vAggpVXpJ4UtBST4aM1kWUbgKZYUW2JtPNX6eWzkFEF2TzJggfehRxpXjpgu6QcB4aYeygeKCDRgFmu68bK8CtHjpr4A6BkvtphQJWumnMB1Yt98cZu3LxbOxUybJdkQvCnVIdOrat1/jWvDk9ok2bUQ3/OT2ux4qlGbSVryenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031129; c=relaxed/simple;
	bh=pS/mUwGnNpTUlmx84nLsne2qXX4XMTLqGn7FdeebpvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4XkyHIJp2JTPg0VRQxuprD2gSvOg0pBWvbMCORfyCP6Ebzfj9zO59jQgqJXN5AT9mF3rdgl2sWuTjdnf8pIZO5bXKnnQGbJcOB6NcSoJMRplfob1/QiGUoOSRr1ka87fHQTX4iOMsumgDexBowXpndLYCLd2eqhA4Zq51XjrsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbNOo5Ha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbNOo5Ha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB8F1F0089A;
	Tue,  9 Jun 2026 18:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031128;
	bh=Pk28Y4P6W8ymkMldEEHau29x9mHLqn44gGvm2nZ6QGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dbNOo5Haj5iVEBXor1/Fx1HnTEe3HJq8+3ZzCWLgYyF7oJLQFNtLiIy1BWNZGayXx
	 JdFXklouJb4ApafOen8EMys2JuioHuvidt1VqJzEGNyqkEtk/g+Fm135nibN2sNTTI
	 Dqf5lk1Rrq+KZUKyyEwgIrXmmMSCIDXEssE9EnkCoW6URHCgd1vgWMWvJ1JmU1Gvw4
	 Y2L60WLZDdxpfikvAHMXIB9u48k6vzXRUM0T+QlR1nav3pa+saYqITJ7b505Fsjy/j
	 ezCG3Vu3XCATBRWIG8wUlNJiZTh4v2wrwj0qxMc7vQj6eoVWSvYc51iG8XdFywYHNa
	 19jwJbR+TKYpQ==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/5] KVM: arm64: nv: Inject SEA if guest VNCR isn't normal memory
Date: Tue,  9 Jun 2026 11:52:03 -0700
Message-ID: <20260609185204.745929-8-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609185204.745929-1-oupton@kernel.org>
References: <20260609185204.745929-1-oupton@kernel.org>
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
index d5c4b57123a9..a6bd60856fc3 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1413,6 +1413,17 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
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
+		return -EFAULT;
+	}
+
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
 		if (mmu_invalidate_retry(vcpu->kvm, mmu_seq)) {
 			kvm_release_faultin_page(vcpu->kvm, page, true, false);
-- 
2.47.3

