Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670148;
	b=nvH7+D1vyGRXEs6KdTSWINdnw4+sq1DLhOkTI5iPhzB48gbj7aav5sPi5AajIzJOJUBt
	 JqE69FZvMAhShQoW8xZQSo0yk2xox1Qxs64dZ3DG1DzBcSvkQ/0xWRfyaZDqJQq0zTGwm
	 HQwK/UsvaEAEfwv2F3vEKLTVJUq2t3EOCgqTrXLJWyAp4gnP+nKd+jcW5+v0aLNZobu+H
	 NYj/a+aEV7+CzDnGrJAEDAqIgHnj6tD1+bpFSebQXn/kTJtC/5K+sNiBCvjmZTEW3rOuG
	 90OG731+VJuFz0LuAXAKuDjCT4QcVHlCvdVFSLGQyQyaLXrlsvZbdnLSQJ1d5NLKmQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670148;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OSTTKYIvVp9Qc5lBkB55RFOapf59rwqCtG4/LQBKEnU=;
	b=xWXo80Ui0wdwhqPO5k60oVwqhw81si9mj/7PxtSD3tAybvIzhyn2S/M2JYdg22px3rIs
	 gkdWrLzV5ziurQQi1wgEP7t7uzskorRyjC12Hfy9LaJ5/hokHJag4dNPPllMnA6l/NuvL
	 m/HF1P0pTeaXFh3yKYqL6no3DOKCZTIOVHm4CR+UwGGm4kqCB7Ov/npAl7wqE3HIe8i9m
	 RmFe8WzwWS1oYSj57Y1SCAO9qaUqAMWzkK/N0/3pVsKLg2A5llF6lFae4C7YAKQBJGjAK
	 zuwS1bHi3oUSa6ddVlJQnloe/u9o3Yrrvi834mQe7R+LEMXvzfcWUNrSxusU4FrctCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIdDzepP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E8606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIdDzepP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE791F000C4;
	Sat, 14 Nov 2026 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794670148;
	bh=OSTTKYIvVp9Qc5lBkB55RFOapf59rwqCtG4/LQBKEnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bIdDzepPprWN/o3YHAGsp56lC1DOie/hb47FOfmYdQYtgbmE21QzdcuKuMd4D2Q69
	 4fg3YyQSHTRaOrXxuEb0dzJhqmdn1pFmyfZJV1znksdMUx0hXDlmeocUGsRN0J2nVQ
	 blCi2k511jzDdMqQOAhNgKYTfhtLIYfDu1PwXcmFd50JzpX2/I0LJD62T5BUZIxAtJ
	 uQc2Gcc+wt37fRZSiEVmKXCvldLwa08rFfM+KJ5oR0bgVLngU7pRjEbWFVnRhRUEVe
	 Bnzx99Xs1+RCDejMoBKWxQ8K2/EWKwpZzNfZLLzNGz3XZguOvoEQHnhVFRcJr+dR7e
	 AcGR0DQzybHdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	James Houghton <jthoughton@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Stefan Teodorescu <fane@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary rmap limit)
Date: Sat, 14 Nov 2026 10:29:05 -0500
Message-ID: <20261114152837.3608553-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202628-failed-5.10-e4558c3d7198@kernel.org>
References: <20261109202628-failed-5.10-e4558c3d7198@kernel.org>
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

[ Upstream commit e4558c3d7198ed9a0adc3304681f561f4e4d80e1 ]

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
[ sashal: adapted the check to kvm_mmu_get_page() using a bounded rmap iterator in place of pte_list_count() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d2428c76d940e..671bc29b97931 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2029,6 +2029,9 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 	struct hlist_head *sp_list;
 	unsigned quadrant;
 	struct kvm_mmu_page *sp;
+	struct rmap_iterator iter;
+	u64 *sptep;
+	unsigned int parent_count;
 	bool need_sync = false;
 	bool flush = false;
 	int collisions = 0;
@@ -2059,6 +2062,21 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 		if (sp->role.word != role.word)
 			continue;
 
+		/*
+		 * Note!  Unlike fully direct MMUs, direct SPs in indirect MMUs
+		 * can have an arbitrary number of parents, e.g if the guest is
+		 * mapping a huge PTE at many points in its page tables.
+		 */
+		parent_count = 0;
+		for_each_rmap_spte(&sp->parent_ptes, &iter, sptep) {
+			if (++parent_count >= RMAP_RECYCLE_THRESHOLD)
+				break;
+		}
+		if (parent_count >= RMAP_RECYCLE_THRESHOLD) {
+			kvm_mmu_prepare_zap_page(vcpu->kvm, sp, &invalid_list);
+			break;
+		}
+
 		if (direct_mmu)
 			goto trace_get_page;
 
-- 
2.53.0

