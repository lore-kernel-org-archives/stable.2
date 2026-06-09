Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A774ADD9B;
	Tue,  9 Jun 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031321; cv=none; b=D6PeP2+i2biy54Q2nbQY+sRvkPCUPW9VZiDx9tX/O28oE8pK33HnnUUIi3r00bjC1RKhNkPWVmHU5+WAQRxRrynBGWzQPrDeC6v4rmd7Jqm4TlGGelb6jj9NcuGrPJwdQdVc+hTooMXPYLK/HZOA8yuqEA8cwpbv4NJxBjIQSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031321; c=relaxed/simple;
	bh=pS/mUwGnNpTUlmx84nLsne2qXX4XMTLqGn7FdeebpvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyTghOvlCrJQDds7l/uBz4AMklhzsmmDI+xDpcrHbOEAijwI4HHzBotW6UIcXiFkSjhjZVshKk63i4igZHkXn+UklOP3lpcwwiSaJqt2hK1rEtXNwGs79Ug70OfjrDr6nXPE1D9poAgLqlhMAh257JnHjtWlOuWr4mF3oGdrPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT6kniMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT6kniMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDAB1F0089E;
	Tue,  9 Jun 2026 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031320;
	bh=Pk28Y4P6W8ymkMldEEHau29x9mHLqn44gGvm2nZ6QGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KT6kniMTQGHrBCAyMcA86osiY3/3khsEsH7ZAzrES7u2jHcLx3PWeiQOsbQ22Hxdp
	 NiZou8MSJJkqRLW0UrprrmimP5hJyP2dY8qbdc3kIj2ETGvvVfgRPpXYzCBfl5H5sK
	 NtnxBwoEjmNf4bbqr3nUaZQa4bhcOa27baRslYZrYKInAaHmFk7ne6WEDOQV+zq/Is
	 YnK1DZVT72EWAFYQWBfESQFwIq1BEYYQJI6m1EMqxLOQS2Utrt3gIkvvumYO5WJs1z
	 FRKh0Iq2oQejMPywGkzMza7MW9tz+RJg3QcU75uZJm3WeKGSHHrGiUaSUxH9OZCH4p
	 r0sAEQ2BqV8QA==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND v2 4/5] KVM: arm64: nv: Inject SEA if guest VNCR isn't normal memory
Date: Tue,  9 Jun 2026 11:55:13 -0700
Message-ID: <20260609185514.746507-5-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609185514.746507-1-oupton@kernel.org>
References: <20260609185514.746507-1-oupton@kernel.org>
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

