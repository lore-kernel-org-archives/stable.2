Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635DD2D3739
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784962389; cv=none; b=N1NBIY5YMPJatI0kW5f9cDMJ229sRIlzU7vmHh/rvcG2wiXhi6eaDOtDuK/cqIo87KvyC2kzw2ROW7cCbs+U836R4XWviEu1fqWpxB65R0Cde10CA48GpxDLs1oe+cYLVV4t4fp2EccRGy+aYKna4MkotWdwBDQnf37eLo4Unmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784962389; c=relaxed/simple;
	bh=gqMmL99yJIw6jaDqtaT0B4DMTqtk6mwkCPTB4E6tuPc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I46dVRXhfsxzXxXxMNNZR0dvUDor0phdmKBvWI2+sYdBog34v6UJybRi9UEuBAQJMPghLE/0327dIeIfLu4HdD3ag9Yjerrd5sRI1xaK1VQJ3uulDsKlQuQgyBGigyFvXF3zCpyo5oggVvaopkUJ2bDo/TNffoTALESvHccPxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U8cRjEhQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U8cRjEhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB401F000E9;
	Sat, 25 Jul 2026 06:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784962388;
	bh=FXWL0RdRFG5Ho1tFFvEe1G0Xt+sBUWQgoXNk1HTr/YM=;
	h=Subject:To:Cc:From:Date;
	b=U8cRjEhQE6rbfUhCpwvKctA4sbCbXRsNgIZEakV3mDRYv5feUh4+erGZh70jxjEtw
	 +jTx631Ue8eKy9EXLceU01sYwn+ih/0gvyHzMVAkWFraA9AxIdEtrBt8WJttFOuZhE
	 bWfsW2vYO23wPFHC4HweQiR0t5WI+nW04nrpy84U=
Subject: FAILED: patch "[PATCH] KVM: x86: Check for invalid/obsolete root *after* making MMU" failed to apply to 6.1-stable tree
To: seanjc@google.com,imv4bel@gmail.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 25 Jul 2026 08:52:56 +0200
Message-ID: <2026072556-gem-immunize-5c2f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2abd5287f08319fa35764566b15c6e22cb1068db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072556-gem-immunize-5c2f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2abd5287f08319fa35764566b15c6e22cb1068db Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 13 Jul 2026 08:15:33 -0700
Subject: [PATCH] KVM: x86: Check for invalid/obsolete root *after* making MMU
 pages available

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

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 234d0a95abf5..41f92ed1ca37 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4852,16 +4852,17 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	if (r != RET_PF_CONTINUE)
 		return r;
 
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
index df3ae0c7ec2c..1ba840a73b7a 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -864,15 +864,17 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	}
 #endif
 
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

