Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4740F8F8
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375654; cv=none; b=Vi/h5SgmnN9qnWaLNFApuObnDDAE9NtkFQmiuQvS7es78nXPUbVuemAggwwwOL1pHp+F31rGlG3nfcRRYzhfB8C77J9ZnjOHv+ZznhLYznZr/yo2B+UfgTr01mSijlM9cjUoZ/7UHK7qCcWIOOuBS7jxa2YjVnP1FOWtUotvpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375654; c=relaxed/simple;
	bh=/+GXtYNIQEoanbyO74E2Z/1ZvUJU9TFAq2W8M3Yf/NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXZ317nQSpnWWxAQWm96u+TebJb+84hfuSFxkVqDJgvbF/Ex04CEyvFvF5VpF2beDNCmxHDEbAFfHfmkQM8lknqyS0vcWVbqxWURcGqBaUYsu58Os3wEzhTudSrm8v93PcNcNomadTnZufsid3uLKOd7WO1yHqObKASr7lkBv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Hx5o9khX; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Hx5o9khX"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9349ad9c857so168844385a.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786375651; x=1786980451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JeSEH2kZC7O/8qyc+dhZdHeAalMWmSlfY9/FgFd5LWI=;
        b=Hx5o9khXTSdMRo8B6NjbuZIghCjC/jKrSGbmooI/KZgmZkK5lXF2wHEUut9Pn6Nw9r
         KE9M0V8jnXdUDjFEQLO9HxqCLBQmCXv4ugykJct8oN/bJli5F9DHRKIUa5mYP6aPOuyx
         EMpCOBpnV5CJ568/e+pMkwWzRPPjCcg11Gif+XmDebRsL40CC/UEzbi+4vDKGlFZYWSC
         rdXWI4La+97l8cA//krwLYGcQjW19SekV9LZsw/pXW6zDoTnwz90U8Q1VD+8dWU4+tPa
         me+7ZMm5PwiGqwBIJ13jOst20JXcvVGy1yRo93ySY/RDVMTa8q0q277jPReM12S6H7ra
         5R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786375651; x=1786980451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JeSEH2kZC7O/8qyc+dhZdHeAalMWmSlfY9/FgFd5LWI=;
        b=Y9TgRbmExg3vnv0YIkEwx1bztZoSkCYYdEnh044V1KMshrncMmG5VSrI3cftIqDzbj
         PmaBU0PWpRsZaQ6+d1p5ab0lbrdsKX3qYq8BIxlNVNhHIwe7flF5NrUp074K2fhxAcVn
         fWVE7qKA9TZ9Men4zbliAnaHVOsPe5gP3mDKebhHxHh9j2rsOHgWKm8JY8xVJqgls3nr
         oQvNomTFvMPwa4zUtnCGtiLII2X7777RKwplS0uKVh6jAhHijvky4aVbPCx4qAEvXSSn
         wpbJV3qw3UNKP4Irbgna+lggtv3fqd6PMBTjBNWuhlBrWB/E5Fvvn9Hi/Aoxj0WK43tL
         AMSA==
X-Forwarded-Encrypted: i=1; AHgh+RpFJL2ivxfxpIow6Og0w61PfxFdDh8sq7XFhT1Hej4Bj1RiiT//zG/+Lc9oRohm3rGLrHiNntE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDWvWYFwZQB2HgmfF7kSOFRQGfs69ZSgE7h4np21IAM2BiFJx
	3wbh5GkO5Q9OJpcwQYMHt7sbt7y7LbFb4JXaH3HKZ2IR+fd6BF0nLLDSccgBeS5RIjD/od/DxfV
	zLhHN
X-Gm-Gg: AR+sD138bH3QQ3jiLY5AjGKS4dcptav1AEikVJpZe1m5XErJSka+5EP5XKuCJSpUiwG
	v4kJQJQpZlcKEJEtG8r1vzXu/0H9eDAgW0cR8pO/11rUAtKqu6WifoPh2vHbz94I4KBqTZJ0wqw
	8XH6/bX4g9eLG4kTkn/j6qY7tN5iNgJv5AquJ9X3RqIbD9HkKwS8H8vHjkvHJYqnMGYl1T+cN9Q
	swYCY9PpcmDlgHc1ZVeW6hDAvj5JhHv6QvpT3cMT6p0sAVLEowEwh2zibVk7/qPMtfPUpLA2QTB
	VKFBSq/uQCCZNNxuEyqX2rKBySzXqi3iPCNRRT5KEeJEDULkjAPhdJq4uaQdC0MifnONSHNf6nD
	b1Iggfm84/jT4lHFbZ/Z2kNzVCgfOvRBnUUriTtZGDVowpRS2yHD1HLh3dEDU+gAfE5I/zIPe0S
	/7hpCbfMyeTOIm1HzFcnyOSZW5MKitzZv97/r7an6VcpTz7nrlnuqSFsH4o92EhoA2Mg==
X-Received: by 2002:a05:620a:2b85:b0:916:10f6:780f with SMTP id af79cd13be357-9366655a73bmr3212596685a.27.1786375651355;
        Mon, 10 Aug 2026 08:27:31 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9366dc51b43sm808858685a.0.2026.08.10.08.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 08:27:31 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: pbonzini@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH] KVM: pfncache: track all MMU notifier invalidations
Date: Mon, 10 Aug 2026 15:27:29 +0000
Message-ID: <20260810152730.841260-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

There is a race condition in KVM's gfn-to-pfn cache refresh and MMU
notifier handling. An HVA-backed cache can publish a stale PFN and
kernel virtual address after the corresponding userspace mapping has
been invalidated. The Xen shared-info HVA interface immediately reads
and writes through that stale address, resulting in a host-kernel
use-after-free.

The cache refresh path in virt/kvm/pfncache.c drops gpc->lock while
resolving and mapping an HVA. It uses mn_active_invalidate_count and
mmu_invalidate_seq to detect an MMU notifier interval that overlaps
this unlocked window. However, mmu_invalidate_seq is advanced only
when the invalidated HVA overlaps a KVM memslot. HVA-backed caches are
explicitly allowed to refer to memory outside all memslots. If such an
invalidation starts and finishes while gpc->valid is false, the active
count returns to zero without a sequence change and the refresh accepts
a stale PFN.

An unprivileged process with access to /dev/kvm can reach this path with
KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA. KASAN-detected use-after-free in
kvm_xen_shared_info_init(). The affected function reads and writes Xen
wall-clock fields through the stale mapping, so the issue can cause a
host-kernel crash and memory corruption.

The attached KASAN output confirms:

  BUG: KASAN: use-after-free in kvm_xen_shared_info_init+0x344/0x3d0 [kvm]
  Read of size 4 at addr ffff888046000900 by task poc/1266

Add a notifier-specific sequence that advances for every completed
invalidate interval before mn_active_invalidate_count is decremented,
and use that sequence for pfncache retry. The existing barrier pairing
then guarantees refresh observes either an active invalidation or a
sequence change.

Fixes: 721f5b0dda78 ("KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA")
Cc: stable@vger.kernel.org # 6.9+
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      |  9 ++++++++-
 virt/kvm/pfncache.c      | 18 +++++++++---------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec8..0ac382cd9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -800,6 +800,7 @@ struct kvm {
 	/* Used to wait for completion of MMU notifiers.  */
 	spinlock_t mn_invalidate_lock;
 	unsigned long mn_active_invalidate_count;
+	unsigned long mn_invalidate_seq;
 	struct rcuwait mn_memslots_update_rcuwait;
 
 	/* For management / invalidation of gfn_to_pfn_caches */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462..5e43dd63c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -812,8 +812,15 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 
 	/* Pairs with the increment in range_start(). */
 	spin_lock(&kvm->mn_invalidate_lock);
-	if (!WARN_ON_ONCE(!kvm->mn_active_invalidate_count))
+	if (!WARN_ON_ONCE(!kvm->mn_active_invalidate_count)) {
+		kvm->mn_invalidate_seq++;
+		/*
+		 * Publish the sequence update before dropping the active count
+		 * so that pfncache refreshes observe one or the other.
+		 */
+		smp_wmb();
 		--kvm->mn_active_invalidate_count;
+	}
 	wake = !kvm->mn_active_invalidate_count;
 	spin_unlock(&kvm->mn_invalidate_lock);
 
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b4..d360f1eda 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -124,7 +124,7 @@ static void gpc_unmap(kvm_pfn_t pfn, void *khva)
 #endif
 }
 
-static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_seq)
+static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mn_seq)
 {
 	/*
 	 * mn_active_invalidate_count acts for all intents and purposes
@@ -136,20 +136,20 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_s
 	 * Note, it does not matter that mn_active_invalidate_count
 	 * is not protected by gpc->lock.  It is guaranteed to
 	 * be elevated before the mmu_notifier acquires gpc->lock, and
-	 * isn't dropped until after mmu_invalidate_seq is updated.
+	 * isn't dropped until after mn_invalidate_seq is updated.
 	 */
-	if (kvm->mn_active_invalidate_count)
+	if (READ_ONCE(kvm->mn_active_invalidate_count))
 		return true;
 
 	/*
 	 * Ensure mn_active_invalidate_count is read before
-	 * mmu_invalidate_seq.  This pairs with the smp_wmb() in
+	 * mn_invalidate_seq.  This pairs with the smp_wmb() in
 	 * mmu_notifier_invalidate_range_end() to guarantee either the
 	 * old (non-zero) value of mn_active_invalidate_count or the
-	 * new (incremented) value of mmu_invalidate_seq is observed.
+	 * new (incremented) value of mn_invalidate_seq is observed.
 	 */
 	smp_rmb();
-	return kvm->mmu_invalidate_seq != mmu_seq;
+	return READ_ONCE(kvm->mn_invalidate_seq) != mn_seq;
 }
 
 static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
@@ -158,7 +158,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	void *old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
 	kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
 	void *new_khva = NULL;
-	unsigned long mmu_seq;
+	unsigned long mn_seq;
 	struct page *page;
 
 	struct kvm_follow_pfn kfp = {
@@ -181,7 +181,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	gpc->valid = false;
 
 	do {
-		mmu_seq = gpc->kvm->mmu_invalidate_seq;
+		mn_seq = READ_ONCE(gpc->kvm->mn_invalidate_seq);
 		smp_rmb();
 
 		write_unlock_irq(&gpc->lock);
@@ -232,7 +232,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 		 * attempting to refresh.
 		 */
 		WARN_ON_ONCE(gpc->valid);
-	} while (mmu_notifier_retry_cache(gpc->kvm, mmu_seq));
+	} while (mmu_notifier_retry_cache(gpc->kvm, mn_seq));
 
 	gpc->valid = true;
 	gpc->pfn = new_pfn;
-- 
2.53.0
