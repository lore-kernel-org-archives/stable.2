Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801809;
	b=UIPaAjdSxdL+94A2ebTXzZJvwzbeVPsidJ3IAQ9kBfrO7CcJIE2cb1HdG9gChuum/hmN
	 7MKruQ/FaMq2/iM9aYTLJjSI5pYgkXZQTjAB8/EzUNde6MH99rQahxvLbHafZu1FvHzvM
	 ZYMWvMT5R8ksYahoX2iuyZe23cadTcv/LR3ccDGaterr8O0tQ1eLGz9mDYkwS8mA/HdAy
	 KCdyqanfcvpb4i0+UZVTo+b+PuN40h8pFCGC3lbhkQ0AWLTIOM1d0VGPZt6FBbDDmiaU6
	 TGiB8NGKKHCxMLQRIu3KT5r+MPQX296Wmm9p4H/4XmVO5wF4l6kvRiX8uEIAcXWfoyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801809;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2VquHf0bESPmOQ2ET6zlv6gF+oOaU6XQ44bDpKf2Mj0=;
	b=3vyIAKVTMDz/qjaC9vCMpOmCspCpfvooQCjmyPykguqZQea5rbqRhpOxMnEGZHCMrcH0
	 dNB/4t4VUhpNwM6kAsY/J/j6DHiZLVKtneL5lCC44MnpfIpaeRe8MIEWgan19zc2fg8Hs
	 zdYQiJbAKJpcoqLZ4GV0xubKzzqhGrWzAUGn4XVYRA/rTJLxljsDLmwYi/eW2F8QJQvXn
	 Xcx3L/wYCtaM8v0Y7eOfCeEc9sNcJqShUobQiEfc5Fu7jNCDt7HDKKL+/xjNohmWljhtl
	 7TmshMycjYB3cT606ZUcQQtPT/T/1uFh3nivR/1METkl/69hw8lRbRvmVPKTpPlox2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dOcH9AqK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B0606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dOcH9AqK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D0C1F000C1;
	Wed,  4 Nov 2026 14:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801808;
	bh=2VquHf0bESPmOQ2ET6zlv6gF+oOaU6XQ44bDpKf2Mj0=;
	h=Subject:To:Cc:From:Date;
	b=dOcH9AqKdKK4zXLpB/EuI7RTVpK2DVdlSTIedWjxMJm1z3XHQSdTnZp8kiHpFRb9A
	 PmmOsiU452C0cjaTG7NKhihYk/y/mA1rW1qN/AQe6h24tj218PH3bcMuq6Zy8LjCgC
	 nQifD2qTk5IbMcpylfWQq0VtC6Qe2G4zgti1f+5c=
Subject: FAILED: patch "[PATCH] KVM: pfncache: use a dedicated invalidation sequence for" failed to apply to 6.18-stable tree
To: dwmw@amazon.co.uk,paul@xen.org,pbonzini@redhat.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:16:45 +0100
Message-ID: <2026110445-lividly-gratified-dd5f@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x da260bcb56feeb6489a83f310308453a0a7de25e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110445-lividly-gratified-dd5f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da260bcb56feeb6489a83f310308453a0a7de25e Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Mon, 31 Aug 2026 22:26:43 +0100
Subject: [PATCH] KVM: pfncache: use a dedicated invalidation sequence for
 cache refresh

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

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..3dd04605f2e5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -855,6 +855,8 @@ struct kvm {
 	gfn_t mmu_invalidate_range_start;
 	gfn_t mmu_invalidate_range_end;
 
+	unsigned long gpc_invalidate_seq;
+
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
 	struct dentry *debugfs_dentry;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..108d42c5c1d6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -813,6 +813,16 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 
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
index 728d2c1b488a..3659686b97c2 100644
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

