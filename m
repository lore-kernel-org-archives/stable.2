Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833989;
	b=r7FMm98oraTTrk1OFf84mMeWDJb+6g/LBFrK1yX9jkxbGIOgGIV2R93+2GfiPNuUOX0C
	 oQSFZBHBTn4epibavgnO0mWt8ucqh29wHOdDMDIyOLthlcFA/kCSbPUjw6yw+b3HZkmqA
	 HIiCkMGiqi+eDIbFqtGw0k4SkU26wnyUFL+EJiqJ2YhLnMbVXMJZqbF9xU0vYrsMes3FJ
	 HHYd5jZHvEAnmX2YBNWv4lE3553VqSpl9KqoZ2VjJr/raBa4/a1bDkYjgWestmK16BGZ1
	 47FDpk02JoA/dyiUG+KzGGFcZpXRWeYu0dkdlB361gw23MUwqmF1Wj/oEBqZu0S6TQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=G5Mj8dqJSTXRooTqgvNaCTqADpcAYbxq/XLJNHoPL44=;
	b=xy6Zhu/GhWUquspynxWhnJMMSwS2DkMnRsLvY2yaMQcX3tH/OrrEnYWhrPJt5Op2P4HA
	 HkwKdU0vHllEIcBTjWj8RY742KPvDzCQ7CEUueeQNgbZ3QFkHiG3WgTb/JeyODutYcF9Z
	 wiQSNRRmLlJiJ4ZsGc7WjIQ/Okj+SmAqwOdw73OKSq0R7hBSPV0ZlX1GVF+tpsjhW66Zd
	 ytiSIwJ5zOlYZ8F0DIS+XqAh5WG4PzLpxYnREBjlaC1zoU0bcZ00iUEbNRMVAYrmIU/Gq
	 g/vCdIMBSB4KVtXL71ah4XKqeYbqEpisCWY7A6I2jwJGCiNU4Hg28tObcl9BBUH2XmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFpenx6f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C467606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFpenx6f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F941F0093A;
	Wed,  4 Nov 2026 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833989;
	bh=G5Mj8dqJSTXRooTqgvNaCTqADpcAYbxq/XLJNHoPL44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hFpenx6fwvdHAHwtFi3ktBWMKk6d/aeZYm4VFGNUKAZ5glq+X6wVArwmon55tUUAR
	 v/2y3mPCFonh7/6AzJkiCIc2YHkXFhcVei18fCt0UO3uINc8ZVlzgpu5zlRLWw+3du
	 8qg2FKknU+Zjyek1RrGiopZQs05M1qgdIPpfxBtgvHRnw4gkqMKfbkKzgtcZDLb4nh
	 Qj/VDQ0ReInPeKwk3MvkTd+1EV/qavqPZTqi1nHYKMp6fLMSf3J0meHEsGuLAzuQtK
	 7WQ5r7mKcineAhrOLhVeg5teHoRrUfeDmEXzIIohVOl7TX5MmY+Q6V2j9X3lotIIfz
	 0LtylPsvz41jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com,
	syzbot+fb7c2dd166d3ea63df2a@syzkaller.appspotmail.com,
	Paul Durrant <paul@xen.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] KVM: pfncache: use a dedicated invalidation sequence for cache refresh
Date: Wed,  4 Nov 2026 18:13:04 -0500
Message-ID: <20261104231214.887398-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104231214.887398-1-sashal@kernel.org>
References: <2026110445-lividly-gratified-dd5f@gregkh>
 <20261104231214.887398-1-sashal@kernel.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

[ Upstream commit da260bcb56feeb6489a83f310308453a0a7de25e ]

The gfn_to_pfn_cache refresh path guards against mmu notifier
invalidations which complete while it has dropped gpc->lock for the
HVA->PFN lookup: hva_to_pfn_retry() samples kvm->mmu_invalidate_seq
and retries if it changed, or if mn_active_invalidate_count is still
elevated.

That is insufficient for HVA-based caches. mmu_invalidate_seq is only
advanced by kvm_mmu_invalidate_end() when the invalidated range
overlaps a memslot, and an HVA-based cache (e.g. the Xen shared_info
page mapped with KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA) need not be backed
by any memslot at all. An invalidation of the cached HVA which starts
and ends entirely within the lookup window is thus invisible to the
retry check: mn_active_invalidate_count is back to zero and the
sequence never moved. The refresh then publishes a mapping of a page
which has already been freed, and the next reader dereferences it:

  BUG: KASAN: use-after-free in kvm_xen_shared_info_init+0x3c6/0x440
  Read of size 4 at addr ffff8880599c2900 by task syz.2.383/7257

Since gfn_to_pfn_cache_invalidate_start() deliberately skips caches
which are not currently valid (including one whose refresh is in
progress, as the refresh clears the valid flag before dropping the
lock), the retry check is the only line of defence, and it must fire
for *any* invalidation, not just those hitting a memslot.

Add a dedicated kvm->gpc_invalidate_seq, incremented by every
kvm_mmu_notifier_invalidate_range_end() under mn_invalidate_lock
before mn_active_invalidate_count is decremented, and check it in
hva_to_pfn_retry() instead of mmu_invalidate_seq. Incrementing in
range_end() in the same critical section as the in-progress count
also closes the variant where the cache is activated with the
contested HVA only after invalidate_range_start() has run.

The same bug is also reachable through the per-vCPU vcpu_info cache
(KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA), where the stale mapping is
then dereferenced by kvm_setup_guest_pvclock() on the next KVM_RUN:

  BUG: KASAN: use-after-free in kvm_setup_guest_pvclock+0x5bf/0x660

This intentionally makes refresh retry on *unrelated* mmu notifier
events; restoring precision (and reworking the GPC locking more
generally) is left for a subsequent series.

Reproducers: https://david.woodhou.se/xen_shinfo_race.c
             https://david.woodhou.se/vcpu_info_race.c

Suggested-by: Sean Christopherson <seanjc@google.com>
Reported-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a0c5f2c.a00a0220.2c7954.0000.GAE@google.com/
Tested-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
Reported-by: syzbot+fb7c2dd166d3ea63df2a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a426dd2.854d4ab9.360e1d.0008.GAE@google.com/
Fixes: b9220d32799a ("KVM: x86/xen: allow shared_info to be mapped by fixed HVA")
Cc: stable@vger.kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
Reviewed-by: Paul Durrant <paul@xen.org>
Link: https://patch.msgid.link/20260831213632.81023-13-dwmw2@infradead.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 10 ++++++++++
 virt/kvm/pfncache.c      | 18 +++++++++---------
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9faa434765546..f051f6875c730 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -852,6 +852,8 @@ struct kvm {
 	gfn_t mmu_invalidate_range_start;
 	gfn_t mmu_invalidate_range_end;
 
+	unsigned long gpc_invalidate_seq;
+
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
 	struct dentry *debugfs_dentry;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8c14fa9b0d89d..59328352b0eee 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -816,6 +816,16 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 
 	/* Pairs with the increment in range_start(). */
 	spin_lock(&kvm->mn_invalidate_lock);
+	kvm->gpc_invalidate_seq++;
+
+	/*
+	 * As with the MMU sequence counter and mmu_invalidate_in_progress, the
+	 * GPC sequence increase must be visible before the invalidate count
+	 * goes to zero.  Pairs with the smp_rmb() in
+	 * mmu_notifier_retry_cache().
+	 */
+	smp_wmb();
+
 	if (!WARN_ON_ONCE(!kvm->mn_active_invalidate_count))
 		--kvm->mn_active_invalidate_count;
 	wake = !kvm->mn_active_invalidate_count;
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a8..3659686b97c24 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -124,7 +124,7 @@ static void gpc_unmap(kvm_pfn_t pfn, void *khva)
 #endif
 }
 
-static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_seq)
+static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long gpc_seq)
 {
 	/*
 	 * mn_active_invalidate_count acts for all intents and purposes
@@ -136,20 +136,20 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_s
 	 * Note, it does not matter that mn_active_invalidate_count
 	 * is not protected by gpc->lock.  It is guaranteed to
 	 * be elevated before the mmu_notifier acquires gpc->lock, and
-	 * isn't dropped until after mmu_invalidate_seq is updated.
+	 * isn't dropped until after gpc_invalidate_seq is updated.
 	 */
 	if (kvm->mn_active_invalidate_count)
 		return true;
 
 	/*
 	 * Ensure mn_active_invalidate_count is read before
-	 * mmu_invalidate_seq.  This pairs with the smp_wmb() in
-	 * mmu_notifier_invalidate_range_end() to guarantee either the
+	 * gpc_invalidate_seq.  This pairs with the smp_wmb() in
+	 * kvm_mmu_notifier_invalidate_range_end() to guarantee either the
 	 * old (non-zero) value of mn_active_invalidate_count or the
-	 * new (incremented) value of mmu_invalidate_seq is observed.
+	 * new (incremented) value of gpc_invalidate_seq is observed.
 	 */
 	smp_rmb();
-	return kvm->mmu_invalidate_seq != mmu_seq;
+	return kvm->gpc_invalidate_seq != gpc_seq;
 }
 
 static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
@@ -158,7 +158,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	void *old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
 	kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
 	void *new_khva = NULL;
-	unsigned long mmu_seq;
+	unsigned long gpc_seq;
 	struct page *page;
 
 	struct kvm_follow_pfn kfp = {
@@ -181,7 +181,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	gpc->valid = false;
 
 	do {
-		mmu_seq = gpc->kvm->mmu_invalidate_seq;
+		gpc_seq = gpc->kvm->gpc_invalidate_seq;
 		smp_rmb();
 
 		write_unlock_irq(&gpc->lock);
@@ -232,7 +232,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 		 * attempting to refresh.
 		 */
 		WARN_ON_ONCE(gpc->valid);
-	} while (mmu_notifier_retry_cache(gpc->kvm, mmu_seq));
+	} while (mmu_notifier_retry_cache(gpc->kvm, gpc_seq));
 
 	gpc->valid = true;
 	gpc->pfn = new_pfn;
-- 
2.53.0

