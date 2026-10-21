Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594145;
	b=CC07V0ljxxDkhZtoWTsOuBIjZeLDq71/WSmVH7sH8dCKLGY+MoIp43PHIQwaH9xKpb7P
	 Zr71cpkmlR9gAmJ4L6BTL0JJzPNCe9SAziX0ghLeUjW+7upllxx2bITCcLXApdS5POvqJ
	 ZOhRXOsOv0KHg8CoEoucrTy+FevhcLpc21FqO0LC1FEblCuCeSo1Ehn4blWpUIvwNjqTC
	 z+WIJ0estzsQWHPueQTZ2iX5arrYj30X/XUekkDcGLCOF0r3g4meCHdX9WfIFkSl4FQ9C
	 nemrana7PIkynZtnBv9wN2HGghj6U2z78iuuu4R2wiRKFQp6MYG0hCnIk9DGh1MRu+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594145;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LZPi2xDWexqM9ZrMcE6WpyAjnh6bbQVGZUpbeUW/oVo=;
	b=sFnbafP2Vseo8wnifXjJ9r4J3lxo0y28W9bvkqxTZkwuQvgfK3N0bK6/mB5OgKGUpcaA
	 YnnHmCSAj5HEtxYcr2JliflPLM5fccxonsJSr5vtBEQ/+CSpLRn+i6KedHd16vtA/Ve7f
	 8yVzjgpX8QyqrwzswhPoBg134vJwL4H5We7v4Fsgs9NZ67okw3q7Lwchs6Bb7IjkydW6i
	 mZ8InkQKHU3U/68+FQtP7Ct7sSnkcKDmziKdvRCfKhNcvKaSAL2gY7CObH/0OIqBsz3eW
	 M6O/MUD83ay8QUqEUl9UVs149hCZFF25ZhLS/cc+CNzNJSDafe6oRIMLsPU+LTBf/xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=C8mAsMDh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF53606A32C
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=C8mAsMDh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099A91F000C2;
	Wed, 21 Oct 2026 14:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594144;
	bh=LZPi2xDWexqM9ZrMcE6WpyAjnh6bbQVGZUpbeUW/oVo=;
	h=Subject:To:Cc:From:Date;
	b=C8mAsMDhAMkj6NA6WOgUbvq0mzJENM0EOVsQIgQ3QMongulx4LBKm8fenhM2N4zk4
	 LVMsEAEDV8pCpYP2n8uJz1fuxpNOv9Pv4SK38daOafivVnMeEMGyaHZk2bB1xMEzsQ
	 j2GXkCt/73Ba2I/G0DvjAO05rP2v+IzaQufGg32Q=
Subject: FAILED: patch "[PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit" failed to apply to 7.2-stable tree
To: pbonzini@redhat.com,seanjc@google.com,simonp.git@mailbox.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:35:58 +0200
Message-ID: <2026102158-waffle-tactless-d396@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x e90ab3669181c6469e3647ef2b30ae408275f496
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102158-waffle-tactless-d396@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e90ab3669181c6469e3647ef2b30ae408275f496 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Oct 2026 14:37:10 +0200
Subject: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit
 codes

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

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2ae7f9ed4cf8..b2a295a9f084 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -275,8 +275,18 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 				  unsigned pte_access, unsigned pte_pkey,
 				  u64 access)
 {
-	/* strip nested paging fault error codes */
-	unsigned int pfec = access;
+	/*
+	 * Of the error codes that do not contribute to the index in
+	 * fmt->permissions, PK and SS are not supported by shadow paging
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
@@ -301,8 +311,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	kvm_mmu_refresh_passthrough_bits(vcpu, w);
 
 	fault = (fmt->permissions[index] >> pte_access) & 1;
-
-	WARN_ON_ONCE(pfec & (PFERR_PK_MASK | PFERR_SS_MASK | PFERR_RSVD_MASK));
 	if (unlikely(fmt->pkru_mask)) {
 		u32 pkru_bits, offset;
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 27427e7f22fa..e5450faa669e 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -328,7 +328,6 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	int offset;
 	u64 walk_nx_mask = 0;
 	const int write_fault = access & PFERR_WRITE_MASK;
-	const int user_fault  = access & PFERR_USER_MASK;
 	const int fetch_fault = access & PFERR_FETCH_MASK;
 	/*
 	 * Note! Track the error_code that's common to legacy shadow paging
@@ -486,7 +485,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	return 1;
 
 error:
-	errcode |= write_fault | user_fault;
+	errcode |= access & (PFERR_WRITE_MASK | PFERR_USER_MASK | PFERR_SS_MASK);
 	if (fetch_fault && has_pferr_fetch(w))
 		errcode |= PFERR_FETCH_MASK;
 

