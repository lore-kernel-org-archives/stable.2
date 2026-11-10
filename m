Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273991;
	b=0YJFRfCWepumNsei3KMaiZBHdIZoTHDSd86o4EZ4k/LMNdyYSMU7UYl1MCuPV4pniJiy
	 SaO8HnjdcYJvSLCnGA1rL6ItgRm1UiRpWL5gJoA7ALjRstEpmTAik/xsg07wAt52NnE5J
	 NZCfsxm+QjTlvt4kpOmKEvT/qaVXr2SsptwEKIdsZO6mSMN+xeHrJnRSr71Tx4D7be8UD
	 ZU3FkPgz5OGLcut9KjtfAPhGrFqDUMUOZ40O/GulKOmL4OPonGdCa+n+/YWkE3oXpzpxm
	 uU3+6Czt9JgE+oTvwZt3D0zaAmMZykDUeuwvysWdHZ7Ou2Uzv0AwzXmw2Y81wo0YdsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273991;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xU77V69LDAevSN1cAdOQuC3L8z2UPI/hL1FKQog7efY=;
	b=VIg/UV0m3DJCX4XmN0ArAvDUPFcLaB2XAiCtYZn51HDv+8XsAVS5LNSjuCq+ypbH12VS
	 d23QPi/9Ts4N2IrSeIlc9gs4L7S2NzbTlxR4+dn/fQoh5aTSQNDrmhQ1oTGC96PCo1q81
	 2tcxRPuGElspDQOJiDJb707XELvXbcxIj6TJtCga/42VzGTGCBBm1YDJrKkhOl7YAdCen
	 eydq54lvtUC+QS5hZntCxVjQpUhr82oRqXemMz7ZB+puLofLNH92beF0PeeA+WOtLvLqD
	 hyuKvSJec/e2BNVB2AjTry4tA0TCjMQQqdQV8yh+kRj/hOVdMgFjyyPM8xH51Dag0Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGlNnGdK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DEA606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGlNnGdK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79261F0089F;
	Tue, 10 Nov 2026 01:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273990;
	bh=xU77V69LDAevSN1cAdOQuC3L8z2UPI/hL1FKQog7efY=;
	h=From:To:Cc:Subject:Date;
	b=fGlNnGdK1Ub4vzRnLLmNln6tOwelbh9R+REuq4zXAAvVLE35/CP9auJecpwp05wwG
	 VcslFwADg58Aaimoe+JSjJeBb77GuwQrDdG39fgAnvMk/YvHC9t9n/C2rFG270a41z
	 w5cGjl8zuWI3uSO6QgzqksG/oST9Y7IMDo8NaqnIUYcFgyx8/Bl0JHvx88ODUJ6P3W
	 6O+vL7oCkOY6YuHjDlEa/EZ2kwrJsGEbEEQoWrfKBB04AF28IRWKhOdpP7b2+80uNR
	 rk3vJBxx4fegHquX3JWsJnh/Ed9ESSgkvBn/37seaffLlRC4pvEWsrDuEsOPGBC+vN
	 2P0w2IVrLIUVg==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	jmattson@google.com,
	jthoughton@google.com,
	yosry@kernel.org,
	dwmw2@infradead.org,
	fane@google.com,
	pbonzini@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary rmap limit)" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:28 -0500
Message-ID: <20261109202628-failed-5.10-e4558c3d7198@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e4558c3d7198ed9a0adc3304681f561f4e4d80e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202628-failed-5.10-e4558c3d7198@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e4558c3d7198ed9a0adc3304681f561f4e4d80e1 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 10:15:18 -0700
Subject: [PATCH] KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the
 arbitrary rmap limit)

When potentially reusing a shadow page, zap the shadow page if its number
of parent PTEs exceeds KVM's (mostly) arbitrary rmap recycling threshold.
Letting the guest create a (mostly) unbounded number of parent PTEs allows
the guest to coerce KVM into creating lists containing millions of PTEs,
effectively bounded only by the maximum number of shadow pages.

Because PTE lists are simple singly linked lists, removal is O(n).  Even
worse, if a list is constructed just so, teardown can be O(n^2), e.g. if
SPTEs are built such that zapping child SPTEs always zaps the last entry
in the list.  To cap things off, all paths that walk PTE lists do so
while holding mmu_lock, without conditionally rescheduling.

Using a doubly linked list would not address the issue, as removal would
remain O(n) since KVM still wouldn't know where in the list to remove from.
Removal could be made O(1) by storing a per-SPTE pointer, but that would
largely defeat the purpose of reusing SPs, and would penalize well-behaved
guests, especially for nested TDP where aliasing page tables is uncommon.

So, cap the maximum number of parent PTEs at the rmap limit.  In practice,
well-behaved guests will likely never run afoul of the limit.  E.g. when
running Linux as L1 with TDP, the number of parent PTEs for a single SP
tops out at under 200 (though undoubtedly obscure workloads can push it
higher).  Deliberately use a "greater than or equal" as opposed to rmap's
strictly "greater than", as the rmap code checks the threshold immediately
*after* inserting into the list, i.e. the limit is 1000 for rmaps, KVM just
very briefly blows past it.

Apply the check to both indirect and direct SPs, because while a fully
direct MMU naturally limits the number of parent PTEs to '1', direct SPs in
indirect MMUs have no such constraint.  E.g. if the guest maps a huge PTE
into many locations in its page tables, and KVM is backing the hugepage
with a direct SP, i.e. with a series of smaller pages, then KVM could end
up with a direct SP with many parents.

Note, shadow_mmu_try_split_huge_pages() always restarts the rmap walk or
bails entirely if it gets to the point where it tries to grab a SP, i.e.
there is *no* pre-existing bug that would be tripped by zapping a SP and
thus rmaps when getting a SP.

Cc: Jim Mattson <jmattson@google.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20261027171518.1432557-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5a2cc6a17a9b3..f4b12d6aef559 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2355,6 +2355,16 @@ static struct kvm_mmu_page *kvm_mmu_find_shadow_page(struct kvm *kvm,
 			continue;
 		}
 
+		/*
+		 * Note!  Unlike fully direct MMUs, direct SPs in indirect MMUs
+		 * can have an arbitrary number of parents, e.g if the guest is
+		 * mapping a huge PTE at many points in its page tables.
+		 */
+		if (pte_list_count(&sp->parent_ptes) >= RMAP_RECYCLE_THRESHOLD) {
+			kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
+			break;
+		}
+
 		/* unsync and write-flooding only apply to indirect SPs. */
 		if (sp->role.direct)
 			goto out;
-- 
2.53.0




