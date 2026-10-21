Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597697;
	b=JPdorTizmTwcz9Jv0BVQRZo0fG7AFtHdqrONIkZdkLfixsFbo7bCAuORWNOiCjSqUWI7
	 6Ednl7BsmGtas7eQwOpy4rNinHV9aVbbn+rRNT2NNK8Y3DgoVXVpc6G3cjNAqX3TINN1I
	 AAdaYx2V74/pIQZAAmWRunt/1d/84JPUe0Q6O/cTb9v8mjKgOH9IzA0XZUHgR+M1iZlLZ
	 LuXBEjBGpjJ/ZfYG4K4zy3E9viEzNdixXsF6cKAPciiRJtDll/20PY1VVD5rXvK0TEmkx
	 w5OUabNnn0V+ONOQnHjsGBYXrThRHOeoHv9KkDecuKtcaQxwunFo8nfd5ZB8cRluDEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dAbNzipTudsCYekYIwRYbAOvVTskMJ/6EC8N8VzmzFU=;
	b=enKpAoswdyk6oyrCMkO+PkFwg2jwFwXMxOPt73rDf/ZmqMY8SyCLtZPQF0jzTtuvX0XH
	 eVn5F9DjG5amFhP0QkE78ljysYdLsJJws0k+zPo25/3IYdMe/TPjFsK0oXITYPSTclBKK
	 eX3WBUlmT3K38EsvO/UPTQ6wOH/EslqrkVB98ehx/TKubwAGik7GyOkLx9NOc1+upKQzF
	 I5BZyS000neuIkWey8dgPm9WEcFZHnLaBsLC4LLIfyIWl1lMC04rvA5hWQ2QM0rsmc0Li
	 tvrxWO26f00isjkRS20HolsUpvPD+Gq1Uq1qmmOhoxeq88BIvTIpfSf2vO7ZeOXZ/LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzsKB0Ru;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66047606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzsKB0Ru
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE451F000C1;
	Wed, 21 Oct 2026 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792597697;
	bh=dAbNzipTudsCYekYIwRYbAOvVTskMJ/6EC8N8VzmzFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XzsKB0RuJq5ZpS7mu5V99oyL0CIIcf+Py2/tn7ZdJJoY8NKsZvjJw5DD3r4nQQWEd
	 b950eiLh+ZLABjUUCvyivkUJm4hIYbUhMqqo/87auc8U7TgYEwCABSXFV+b2sur0dy
	 W2mQ5MEJks6vo8SV+rE/RgP2hbwBU054BfMPN1ZBvRJj7Yq62rsJowKYRfkoTkeoI5
	 OGCjmHQ/KilW7kU1ZwGHxgz8QlO436c2czCJGAL1YbXdcTOsP6TVfjc3Evi5BxkB+L
	 qeMFjZiMqDS0dacIeePWeDuT+Bi/O4OJThivaH0uKLg936g1Fg3MZUUd5od8HCRWdM
	 9RW6BOiWi1txw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	SimonP <simonp.git@mailbox.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
Date: Wed, 21 Oct 2026 11:48:15 -0400
Message-ID: <20261021154742.366022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102100-dominion-poser-834f@gregkh>
References: <2026102100-dominion-poser-834f@gregkh>
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

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit e90ab3669181c6469e3647ef2b30ae408275f496 ]

When running Hyper-V from Windows 11, KVM is seeing the SS bit set
in nested page fault error codes produced for shadowed NPT.  The AMD
manual is unclear about when SS is set, including whether it can be set
when SupervisorShadowStackEn (bit 6) is not set in the MISC_CTL field
of the VMCB.

Nevertheless, the unexpected SS bit causes out of bounds accesses in
permission_fault(), seen as either WARNs or UBSAN reports:

  kernel: UBSAN: array-index-out-of-bounds in arch/x86/kvm/mmu.h:225:27
  kernel: index 34 is out of range for type 'u16 [16]'

(in this case, the page fault error code is 34*2=0x44, i.e. SS|U; the
report shows SS|U|W happening as well).  Fix the handling of unknown
error codes by dropping SS and (with a WARN) any bits not among those
that permission_fault() expects to receive.

At the same time, given the uncertainty about when hardware sets SS,
follow the processor's behavior when constructing the fault's error
code, and preserve the SS bit as passed to FNAME(walk_addr_generic).
While the behavior is surprising, there's a possibility that Hyper-V
expects it (Hyper-V does not even enable CET unless it finds MBEC/GMET!),
so retain the information when reflecting the fault to L1 instead of
unconditionally discarding it.

Bisection shows that this started happening with commit 687ee95c1b6d ("KVM:
nSVM: enable GMET for guests"), even though SHSTK was available to guests
since Linux 6.18.  However, this is not because bit 1 of MISC_CTL (GMET)
somehow enables reporting the SS bit; rather, it's simply that Hyper-V
never uses CET unless GMET is also present.  The WARN is reproducible
even with gmet=0, with some hacking of kvm-unit-tests's cet.c testcase
to ensure that the first access to the shadow stack triggers a page fault.

Reported-by: SimonP <simonp.git@mailbox.org>
Fixes: 8db428fd5229 ("KVM: SVM: Enable shadow stack virtualization for SVM")
Cc: stable@vger.kernel.org
Reviewed-by: Sean Christopherson <seanjc@google.com>
Closes: https://lore.kernel.org/all/asUqYEisPp9MJ8mQ@rika.bernkas.tel
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ sashal: Adapted permission checks to use mmu->permissions and mmu->pkru_mask instead of the newer page-walk structures. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu.h             | 16 ++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index f63074048ec61..64b785ad6fd66 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -186,8 +186,18 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 				  unsigned pte_access, unsigned pte_pkey,
 				  u64 access)
 {
-	/* strip nested paging fault error codes */
-	unsigned int pfec = access;
+	/*
+	 * Of the error codes that do not contribute to the index in
+	 * mmu->permissions, PK and SS are not supported by shadow paging
+	 * and also not provided to EPT violations, but SS *is* included
+	 * in the NPT exit code.  RSVD faults are handled elsewhere.
+	 */
+	unsigned int pfec = access & ~PFERR_SS_MASK;
+	if (WARN_ON_ONCE(pfec & ~(PFERR_PRESENT_MASK | PFERR_WRITE_MASK |
+				  PFERR_USER_MASK | PFERR_FETCH_MASK)))
+		pfec &= (PFERR_PRESENT_MASK | PFERR_WRITE_MASK |
+			 PFERR_USER_MASK | PFERR_FETCH_MASK);
+
 	unsigned long rflags = kvm_x86_call(get_rflags)(vcpu);
 
 	/*
@@ -211,8 +221,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
 
 	fault = (mmu->permissions[index] >> pte_access) & 1;
-
-	WARN_ON_ONCE(pfec & (PFERR_PK_MASK | PFERR_SS_MASK | PFERR_RSVD_MASK));
 	if (unlikely(mmu->pkru_mask)) {
 		u32 pkru_bits, offset;
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 6e2ce54a13b31..07b0ddd15b9de 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -474,7 +474,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	return 1;
 
 error:
-	errcode |= write_fault | user_fault;
+	errcode |= write_fault | user_fault | (access & PFERR_SS_MASK);
 	if (fetch_fault && (is_efer_nx(mmu) || is_cr4_smep(mmu)))
 		errcode |= PFERR_FETCH_MASK;
 
-- 
2.53.0

