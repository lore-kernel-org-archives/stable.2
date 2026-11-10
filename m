Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296669;
	b=hHIaLDfHSwxRyg0W+GbYBS51GvDvPm4eR8boMv1XfsIvWKECwyShE6qQ7iTKVc5kfiOC
	 Tzi8rBCvKJELU0ik4IXehlanAHugkmFf+KbKEmQGar0kA9Gf845LLX5iMKWCr0XQadS5p
	 e3qINH6wGJn7RpRHaRiWSs9Sri8NPsDS1xFgToAov1Nox8K7Fk/CZvp+hVphK1n12fds2
	 dr0bnUJKpFYfRFYIEpUljrQkzmBtm5pCmWF1QAYbLPOVIKZDS5ZR+4089FL7stQXQ+p2y
	 CQj32RKYV3U81s/gGwq8gu15d3Q/AGCC426x9uRWagTsq9h9LQdSGbI1g3q0JvZHK1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xFdE8yf6cblcOWjvx3EruOisINuPezb/B7MTHToCHSM=;
	b=G+zY64ayyWbxeJ50mPVtlsRmt2amGEdtmAtZhgD0bWT9uhDUwYla1WcF8yymcOZvoNOF
	 WXWnRPkzv7VAaRe7R+mH03qzjM/Pii82fAXoWm4dHc8AHmZ1e+nnl+xyNFqql+kkhhmz+
	 Dqbhhtplz+xxZZIsZfPeeuKR13fRzlcF6Qv8QCCfiEwpe2pBxepGLnR71V6rfRomBG3sP
	 WN+/uRzITO/EuJdvL7FKSOc4LloDBEjZH8/r+5wjY80Ni29KaDObal3is0WMSEr824iXA
	 0tfCloXjrfxi5IoL5zMqVgGPrE7KMyuqR1RkKaMjD4BueoHCg7LyU9G84wXExNp/pMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkkBLpO5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9A606A33E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkkBLpO5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D37B1F00902;
	Tue, 10 Nov 2026 07:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296669;
	bh=xFdE8yf6cblcOWjvx3EruOisINuPezb/B7MTHToCHSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AkkBLpO5yXsXXXeQwnB3FLyZtViKIRpQxJ3r3aQ9oMFJ6sjrgOVIODA1DcrDVCcXs
	 eho5zCY+qof3QjDWEfHQ7Pi1DISNVZJPfeE3quSM7eOmzPdjywhIj/cQh41PZ2AAiz
	 UafCg5nVNQYBXaJRWjPmrsUyrzws1Dxh55MNaEYQQZytVLNmk1Y3UMdzA85mznr57y
	 F0QBfBiRuu3S3T7oOXBUFTz5x+BOdbWwpIHGhZRlhlw8mDgdXNrUGCh3AMAaf1pZWt
	 NCTHzojE0VCpY8A9jOQ/5RptWBHg/ZFe/yh0H+5N92eIH2uC3I5IfPFIUYkpPNFzq0
	 Yd5hk1lgHZvbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode without PAE enabled
Date: Tue, 10 Nov 2026 02:44:26 -0500
Message-ID: <20261110074259.559852-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061520-failed-5.10-115f9405a2ed@kernel.org>
References: <20261107061520-failed-5.10-115f9405a2ed@kernel.org>
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
index 3778070381a8b..0db6414300d2d 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -351,7 +351,6 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	}
 #endif
 	walker->max_level = walker->level;
-	ASSERT(!(is_long_mode(vcpu) && !is_pae(vcpu)));
 
 	/*
 	 * FIXME: on Intel processors, loads of the PDPTE registers for PAE paging
@@ -361,6 +360,17 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
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

