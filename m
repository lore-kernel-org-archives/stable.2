Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295832;
	b=qrkvI3QZ8ETLt3NGfeNV0c+xAC4BFxLfzgUSoPdjR45fllPuKBNxTxVvr7Nm/AHn6z7V
	 FBqQxeo+BNUkXDyVmlAwRZJmFr4jw+PJ8gclG4fJ8T0GiLFvHT2tDVC+bLdTTHkZCmFtO
	 xg+0lR0KteRgydCno/dEDBe9zcdN1AASCe+Ds7Bv/xMtIK6YAnHtznpLorhDWc1ZjM2Xq
	 xhKHwQHt5NCl/O8Y35BUixEFYBT8zDf9dvbnUGnSJLXYDrabM2jFZHWyFLuM+HDO9bOYb
	 pEcl1ziybEzE5K1NAPHNTUjAQ+rL4cY3V59F6g8Mr0xeeo1pX9l7NrigA1qyWl+w1Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=st+o6DSTnmSc2ScYYOueZA9arfVO6ZbosfjY5SQUSdk=;
	b=CvV8AJAQi7VIq8rXhIRLDhi+PeNkQQ9ZLhcFWH2JG49nD0LfKaDn3eT121LCG38th9FO
	 FMAQAi8Iaw7tydglrU5f7jybxTPeLSJ7b674Xkio4HiZXKJNJsKGEuB1nUA7u2T7eeMiX
	 3ACNqEmWtOephm+Rzcx6yIfEHsAD/ZrzlKCusp4ZfspvZlGdGrxu1kJzdc1+PMd3w+edy
	 FezAxyi/igBHqkkv9Q6QBcG4GXu3WZ6typwjjETo4sP3UTrBOKVl5gCA/l86t6WPqR717
	 thHFLXO7TfNddXqA70aIw9F9/QYXOIhWWzVWfDlhrlX1EdxfFA2+wo2KJZ6mFX2LdZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=El+D6Y7L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97CB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=El+D6Y7L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6724F1F0089F;
	Tue, 10 Nov 2026 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794295830;
	bh=st+o6DSTnmSc2ScYYOueZA9arfVO6ZbosfjY5SQUSdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=El+D6Y7Lr/4aIrypSEqXqrlU85r1Vcvvwsco0uHwkCX0RE5/chG4tt3zsko+nuWmq
	 BX+ot5891UVxTuf7p6u/LVpwRlDiSmIEKQ2DGKhXY4zyx0joLq8la18pVy/ZAnjTFx
	 CU3yeTADrrKFRrsxtmFzZuknQuLrKdjGXxwcUsQMNLtpkzUkowcRKFqXnWU0WCaaYy
	 DqwGkgSvHjJVMWdpQYa67xXfxhSUxyuquFD86s89k0E8LBy9IC4SNnbMzvQG2IQuCz
	 KrBMQG3taftp8i9YfwA0fVy+ySvetjyY2pai9uJ4+jdMVCijkw7h3Cg7PfhM2yZ5tn
	 R0br9Vkkzm68A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode without PAE enabled
Date: Tue, 10 Nov 2026 02:30:28 -0500
Message-ID: <20261110072540.551383-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054141-failed-6.1-115f9405a2ed@kernel.org>
References: <20261107054141-failed-6.1-115f9405a2ed@kernel.org>
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

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 72e2fb24a0b0528bcc16a8f6ad2cf336ac361525 ]

Promote the ASSERT(), which is quite dead code in KVM, into a KVM_BUG_ON()
for KVM's sanity check that CR4.PAE=1 if the vCPU is in long mode when
performing a walk of guest page tables.  The sanity is quite cheap since
neither EFER nor CR4.PAE requires a VMREAD, especially relative to the
cost of walking the guest page tables.

More importantly, the sanity check would have prevented the true badness
fixed by commit 112e66017bff ("KVM: nVMX: add missing consistency checks
for CR0 and CR4").  The missed consistency check resulted in some versions
of KVM corrupting the on-stack guest_walker structure due to KVM thinking
there are 4/5 levels of page tables, but wiring up the MMU hooks to point
at the paging32 implementation, which only allocates space for two levels
of page tables in "struct guest_walker32".

Queue a page fault for injection if the assertion fails, as both callers,
FNAME(gva_to_gpa) and FNAME(walk_addr_generic), assume that walker.fault
contains sane info on a walk failure.  E.g. not populating the fault info
could result in KVM consuming and/or exposing uninitialized stack data
before the vCPU is kicked out to userspace, which doesn't happen until
KVM checks for KVM_REQ_VM_DEAD on the next enter.

Move the check below the initialization of "pte_access" so that the
aforementioned to-be-injected page fault doesn't consume uninitialized
stack data.  The information _shouldn't_ reach the guest or userspace,
but there's zero downside to being paranoid in this case.

Link: https://lore.kernel.org/r/20230729004722.1056172-9-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 115f9405a2ed ("KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 952f7e9b64fad..42d459370f781 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -345,7 +345,6 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	}
 #endif
 	walker->max_level = walker->level;
-	ASSERT(!(is_long_mode(vcpu) && !is_pae(vcpu)));
 
 	/*
 	 * FIXME: on Intel processors, loads of the PDPTE registers for PAE paging
@@ -355,6 +354,17 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	nested_access = (have_ad ? PFERR_WRITE_MASK : 0) | PFERR_USER_MASK;
 
 	pte_access = ~0;
+
+	/*
+	 * Queue a page fault for injection if this assertion fails, as callers
+	 * assume that walker.fault contains sane info on a walk failure.  I.e.
+	 * avoid making the situation worse by inducing even worse badness
+	 * between when the assertion fails and when KVM kicks the vCPU out to
+	 * userspace (because the VM is bugged).
+	 */
+	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm))
+		goto error;
+
 	++walker->level;
 
 	do {
-- 
2.53.0

