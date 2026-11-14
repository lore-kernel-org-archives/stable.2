Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669062;
	b=2cLALkXwA/51IZZ1BIhgy5cm6J9rDa+BdQupQf21z58jy9ZgH71oi4csxCJXquP9Lenk
	 M9ixulDSc2bRHagR2SgpalpXgQjVKddzJKRcHTh+HnNQw26la73NtBwYONq1CQiJV1J7M
	 wqS4RUXyGI7lWq1E9vNArdqdBb829LkkvLTjmI2NxkgGFLtqal0VYfQZvGPWPm/JDv2SR
	 NSLOgQBF8B5cyTTK+Mq9+/NQsLJZ93veXhsumCMjVTb2Lab2Yx0S7MlrMeXSUYc7h0kca
	 hf0SP3RONDgnhDs4q5uilHlpfsLwr2NH/RHuLtoVUOsoXgO9PImDPFCPkuWRRS/rSkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669062;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5it/Uvl643VmKkvLyLwpkWuzBJo+xJFYR0Qsi5rFVWM=;
	b=hapW7w774pLjKWi14P2IBUZsbMSzm6od0E12jLvACCUyYfA+Wi/VnxegwD/8FxdU3xEt
	 e99MDyEY991rDNXGHZm6bDS6OmDqDJUzOvpMV4SfwOBIdXB4MyaT4xO5NWGPnSRDiwfwT
	 KoymThVRenmzvoD6YA9ACYH1cOZ5rdSgQQo26kK/YhX2LgV0X6Ex9YoE8csIFIP5fuE6V
	 1Z2M4Nf12Hr7WiYsTFdZkJCKge6m1KSiE/mDJ6GIhxKbxuwYpEhUVQD7vRFFppPe0vNDO
	 uxE8gq/TXmsZcebW5KutEc8YW/FPrpcQ/BLcnRxBd18pFERDzUyg8pkhzGpFjzQ+Zhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzXAL2eU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7361606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzXAL2eU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677B61F000C4;
	Sat, 14 Nov 2026 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669062;
	bh=5it/Uvl643VmKkvLyLwpkWuzBJo+xJFYR0Qsi5rFVWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nzXAL2eUAQ5QoYd3+XQgfm2M6eMg97cpIa7TEnYJEHgqvFS9E37kbGcz8tynfl6+2
	 B3BXSKl2dKGdywSe2DPp5ekFRf7Ow1Pe0RUd1qx6RoBopyH+jGZvqvXe7FU9bqvJGe
	 FTep91ECnUhemQFF6rpcqmWAad9OW70Gxsh6TVPh73RQp0MoEpxpZkx0MmGalFEJas
	 Q5p6NM2GimyW9HVIqCPdpALX0f3TdgCTspS8Yd6opJKkkAXpksGglvAnfrc0VXiksR
	 +kXp+N4QEFKiXFgukL7uNouM1fcccUlE7lr0Tf3w9SP+rt8+Wp0k4YkKjxHWMmybTK
	 SLM1TqM1kzEZA==
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
Subject: [PATCH 5.15.y] KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary rmap limit)
Date: Sat, 14 Nov 2026 10:10:59 -0500
Message-ID: <20261114151029.3453893-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202134-failed-5.15-e4558c3d7198@kernel.org>
References: <20261109202134-failed-5.15-e4558c3d7198@kernel.org>
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
[ sashal: Adapted the guard from kvm_mmu_find_shadow_page() to kvm_mmu_get_page() using vcpu->kvm as the zap argument. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 887a9d4a1e8bb..8237ff8e889b7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2087,6 +2087,16 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 			continue;
 		}
 
+		/*
+		 * Note!  Unlike fully direct MMUs, direct SPs in indirect MMUs
+		 * can have an arbitrary number of parents, e.g if the guest is
+		 * mapping a huge PTE at many points in its page tables.
+		 */
+		if (pte_list_count(&sp->parent_ptes) >= RMAP_RECYCLE_THRESHOLD) {
+			kvm_mmu_prepare_zap_page(vcpu->kvm, sp, &invalid_list);
+			break;
+		}
+
 		if (direct_mmu)
 			goto trace_get_page;
 
-- 
2.53.0

