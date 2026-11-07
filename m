Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048103;
	b=Am7DF3GJKanFRyt0PuvKVLlPkuKTqqRsLKnTvdvEvqionE1iac1R0N7MJ2DBHXkfNh5e
	 EZRu9A6WaNG+ag02nOeGaLv0RSfGFXYoeDEiYX1LVIge6dA0xXXIIlh7xkccmM4u0j7/v
	 yIgkRXAr7XGLxtyxj4/xzH+wieicE0aGaQhhP+B4L6dw+k2eXoI1FRByq2YxlboQzbkAx
	 Z9NwQJb9Msqz+OTHCQWNuMMQSM25UN/jPAQIMp+8sualrgg9z7xr37Vh+nyxIDhcJXpyC
	 jIwfjKyC37SKpSRfwsAkbdIh/QT9kjoR5JtpdnACE6R2L+XUyXyxaFz1XdZaQUeGn3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=l9F8CV0sRjeEbMap0zHqKSlbKDB5v/IkjtlBWPqEyIQ=;
	b=2PHde4o1B5IIeb5leNTL6zRALox8d/CAVXld3ks4ej7dC+Yk4UGAFpZ7pbiEBSYtqPC1
	 eZuPqI5sowVjpkjzDu3bfIFjRPAWlFb5FxHoaCFkrJW/yO2RvVH+LrdGsfBei9ghgGXm8
	 An2U/QoAapAAscHjWanQ07oFLQj4j3sk6/97FFOY1kuk56OyZroCH6kp20VnwtI063C/o
	 +L1G3N/uv7T/FXSFgCwFcJpZoYvieqWhD91CD0c1u/RslnCQI2gH5QQLK+8nZSkcb9iC3
	 NVvQnOs1e3Ix0z4snduRAbgDJRUVNIQXIv1+iTCRP3cqJoq363MHyduHZEZvUTCfPVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lqlimqqo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630C606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lqlimqqo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A251F0089F;
	Sat,  7 Nov 2026 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048103;
	bh=l9F8CV0sRjeEbMap0zHqKSlbKDB5v/IkjtlBWPqEyIQ=;
	h=From:To:Cc:Subject:Date;
	b=LqlimqqoYQD7xSJEwahr+rAWm1A7wM8MimzSQDxwWD+XCwzkBzV6pWa44f/zt6wRX
	 8Yd9np3jrKJYfGDoep7mMxNiKIlMHyAbbhcY7bCrXx+B14b9yM+xCJa06LW/xNLdmP
	 XtQ1yI0rbWUhUFEPkuEiFnkhgzHUamji7cJyuJTPPo2mdeJoATlMIBsBg2hEQ0RkOB
	 jzWZ5dQejuxjEub6QiWdqbTPYc00oXWLLn1mc6/k+3sQPELxdhFs+nE3pOXBTYWg8B
	 lbvUO6hvD0Uhq/KEBtnKeflfkcdXj67hQioQxKwChF2mSQaTymiUioEKs4wD6yXUZz
	 6mRgUFo+jAy4w==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:41 -0500
Message-ID: <20261107054141-failed-6.1-115f9405a2ed@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 115f9405a2ed6d78ee7ad8436bdd638743f6d1d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054141-failed-6.1-115f9405a2ed@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 115f9405a2ed6d78ee7ad8436bdd638743f6d1d4 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 2 Sep 2026 16:20:26 -0700
Subject: [PATCH] KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels
 than the MMU has

Extend the "EFER.LMA && !CR4.PAE" check, which exists largely to guard
against KVM configuring a paging32 MMU with more than 2 levels of paging,
with a very explicit check for exactly that: that KVM isn't trying to walk
more levels of paging than the MMU template provides.  I.e. harden KVM
against all bugs that would cause KVM to generates accesses beyond the
bounds of guest_walker's arrays, regardless of how KVM ended up with the
misconfigured MMU.

Note, don't use w->cpu_role.base.level directly as the paging64 template
only provides two levels of page tables for PAE paging on 32-bit hosts, and
handles the third level by manually emulating the PDPTR access.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260902232028.2767071-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 27427e7f22fa0..f925b11d76ddb 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -368,13 +368,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	pte_access = ~0;
 
 	/*
-	 * Queue a page fault for injection if this assertion fails, as callers
-	 * assume that walker.fault contains sane info on a walk failure.  I.e.
-	 * avoid making the situation worse by inducing even worse badness
-	 * between when the assertion fails and when KVM kicks the vCPU out to
-	 * userspace (because the VM is bugged).
+	 * Queue a page fault for injection if any of the below assertions fail,
+	 * as callers assume that walker.fault contains sane info on a walk
+	 * failure.  I.e. avoid making the situation worse by inducing even
+	 * worse badness between when the assertion fails and when KVM kicks
+	 * the vCPU out to userspace (because the VM is bugged).
 	 */
-	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm))
+	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm) ||
+	    KVM_BUG_ON(walker->max_level > PT_MAX_FULL_LEVELS, vcpu->kvm))
 		goto error;
 
 	++walker->level;
-- 
2.53.0




