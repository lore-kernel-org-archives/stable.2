Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049106;
	b=qf/kNWZpHVdSbbDf5af0T3w+ARyoW1MvYEjLQSKYfxS/T3aAzVJxcfsbOrF7yNg9XcHW
	 MRaHNVc7p/ARhbk3zSoP8k1HHSMfvELyFE3nAZfCN56XgCOyZDVr0kz22tvEZQc+5PPAU
	 84r9o8jmp0ZqfcDixfj9kcGQPjonBO9YTDUbasuyYvTP6ByCzimj9ZR3iInv6lAQq2/vy
	 Tw7+eY/2KWjYD7m/B27zgQDTeAIApK7lX5zivxqo1HF2tcfmNoZ5y5wb75BQ75jxLmz09
	 7fVxmAN/i5hDTNvidMMlpWkQP3TqySrDIVTLUvnPDl11HZE9RiMFdE0++8iuRpgIxWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R/nIj+unSpb1LcVMiKpA2ESe/xtIpmFJdGL69L9iTTg=;
	b=qIEV/REtGYxdFk/1WXkJjp6L6B5UXpkEky6qfTxN/n/toNP7V9t9vLavGOuE2q3a3vFw
	 l6moakYBJxugWzg/CSh52t7lv/uzAOvWM7EvCzdcThEYInG9v+2h0FU2dqnwBtCbxUjjP
	 cCSxIyfOUAGMClI5N1LkG3gZSyP1WtIHxcG0936uCemzsi99HnJOwA0t0UMW2QiKcFnZ1
	 nhd/raare4QgAk5tPaXal2ttN8e8YIldIb7DiPt1kBYle7pKONasAZs+kkVgfrsbeFEvJ
	 qM/6KNL6ztSMZs9QujKtuC/HsY1lBd99C31BzT7hm94u5LcATErz5Ssg1+CvebYg7tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohXNSBN3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1BB606A33A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohXNSBN3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E81F1F008A1;
	Sat,  7 Nov 2026 10:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049105;
	bh=R/nIj+unSpb1LcVMiKpA2ESe/xtIpmFJdGL69L9iTTg=;
	h=From:To:Cc:Subject:Date;
	b=ohXNSBN3SnPej5g3z+gZXKPUxZX9H82O3c4Z78rU867AyXeAC5Xc5bfXk4g0v9XK4
	 LM55wLX/3OJNqmxQGPx4Iq710xlKF8sUXtrKCj8b/6cLTioyT32k0ug/CM2M2nXutn
	 r7u80kyYr+iH8DT36OcgG21h/IazpUjFMsLz184RlULPxHvEElodgFSUQUBZU9ElIa
	 8IrZCPpwCM+z8iY789I0uTOml8apSahbAj2u+sK/KH+zgZEbGvfzzss1fhBZ3yzlyC
	 i/qokSxclXDOPtbfpFeqjVpPPK/EfmKYrXhVY+qeTpbiJ9CZhy0Qfrl77uVrxi3xtW
	 oKQfGuj3RIK0w==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:58:24 -0500
Message-ID: <20261107055823-failed-5.15-115f9405a2ed@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 115f9405a2ed6d78ee7ad8436bdd638743f6d1d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055823-failed-5.15-115f9405a2ed@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




