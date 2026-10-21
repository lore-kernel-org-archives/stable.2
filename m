Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596607;
	b=cFGLn1PHHg+TuYcTw1J1Kejh5gT4jEBdGF+k1kcuOjY5HjANsMOOqJ9+bRatmgbFyQrB
	 MG70DA3IJ8wOoyX9mQPw83QsZpS1to18ySsMoKxwU/0Vp4ean7vdw7z0pO/kRMWcypaBH
	 KJws+9NwgfO0+yfr2JkEAXqgLo379P/aX0akpexa9zBx2LF/tDnWLGe5PPiYWKEPvPY0B
	 0mp7iZLfqPDuDTAG3rqNTff6OFsgjCh3ZLDefWsYfFxN1FB4hpt9MGO4ssP44ygmIlmUO
	 UKFTWQpQmJejFoHONTqhO7lMyF0vXGyjJ/R/nmpdbLZhJsiltnY149NvrzthEbkRJxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CTGAYgo0PIPxrhULx8V0vUzRak3L6VsgNLDXBFqgR6E=;
	b=HWltvjGg8/w1DBiJ4LWppbsAitdpetsfNsnqbdXWhWRDRCxzk457rYRJ1mbwfepiViRd
	 vuowjI7U3Z6JUK+PzRCJwLkv4J1WVezIcaZ8VwBm3IaZlBaVocFOoPJ7Bp3p3fmsckyu5
	 0SBZThlc0RaFTlBL/swDdf4m6CdCqpJ6ibpEn2uucN6P+cz5wLCIEzbQPqY4jKI+aVJ0S
	 gLb5GOPGtXfprMMtGn+stq3OesIrRArmo4EXIULkr0opHQjXlMNxF+VXag/vrQUV3vEd7
	 3sEKcHjsuS1bmcfQvVbA5pJ2BwirIDa8FlM35U7YklDxcZT9pzy8UDdHBefZhCXwmrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJ+lOkXK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94536606A320
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJ+lOkXK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C37F1F000C1;
	Wed, 21 Oct 2026 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596607;
	bh=CTGAYgo0PIPxrhULx8V0vUzRak3L6VsgNLDXBFqgR6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJ+lOkXK0I+px/ulGk9IIXEo0J8Unn5zdW7zqnliBZyA1t7vTBZRGdlHPPMwkXaBf
	 KWo3ZmhAtt48nE0kngjRLfaV8e7IvBTPYTxHHn07yQxoLlhLOLechqAV4a5EeX3nrM
	 JL5++/Gyt97oIEWdl+dpcHsdmtVB3DR+jPeRR4/Q3NDbpWUO/slkK9JjIPF1ksV7Xo
	 V00qfykL7dvOJCq48ntJ+gFXb3JQzTIZeQ+gAzNimnKgFuKempfK2tFLFdocPhB6GM
	 PqCh0G/ZJaf7FnE1+nrybgOdwfqlW6zrP9ApuVRGWnaJ67gL8mWT6xMAAI5N4dCF/P
	 6x+LwGqD6MjxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	SimonP <simonp.git@mailbox.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
Date: Wed, 21 Oct 2026 11:30:05 -0400
Message-ID: <20261021152923.290681-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102158-waffle-tactless-d396@gregkh>
References: <2026102158-waffle-tactless-d396@gregkh>
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
[ sashal: Adapted upstream w and fmt references to the existing mmu structure. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu.h             | 16 ++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h |  3 +--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index bb6e018928527..522033d453558 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -198,8 +198,18 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
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
@@ -223,8 +233,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
 
 	fault = (mmu->permissions[index] >> pte_access) & 1;
-
-	WARN_ON_ONCE(pfec & (PFERR_PK_MASK | PFERR_SS_MASK | PFERR_RSVD_MASK));
 	if (unlikely(mmu->pkru_mask)) {
 		u32 pkru_bits, offset;
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 8d2c46bc6c0fb..c4732dd5ad541 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -326,7 +326,6 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	int offset;
 	u64 walk_nx_mask = 0;
 	const int write_fault = access & PFERR_WRITE_MASK;
-	const int user_fault  = access & PFERR_USER_MASK;
 	const int fetch_fault = access & PFERR_FETCH_MASK;
 	/*
 	 * Note! Track the error_code that's common to legacy shadow paging
@@ -484,7 +483,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	return 1;
 
 error:
-	errcode |= write_fault | user_fault;
+	errcode |= access & (PFERR_WRITE_MASK | PFERR_USER_MASK | PFERR_SS_MASK);
 	if (fetch_fault && has_pferr_fetch(mmu))
 		errcode |= PFERR_FETCH_MASK;
 
-- 
2.53.0

