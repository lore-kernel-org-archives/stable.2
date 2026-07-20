Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4325228C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556346; cv=none; b=i8gLyyl7S8bxeihegENJEN/RUWZtlAyJ5gyPCxGjwX4OmMRmTm+ylaygPha23MtpUyraq+XInP4C4q412flWV7+QoPD9ceCM9S4oSDHX0qlmEt4V6FfIYpu4xbv/entZcA9x+fk/KM0gwwMy9d5Ulg7nbmbQLjmcDRkCBVq7jr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556346; c=relaxed/simple;
	bh=ZcFGrtkX0vh1ujvEeDK2D+Y7ZUijzeRV37GPHzSE4Vk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I7njiB8xKCZMkoeDlZIplxuWP+sSqCOsAs1Ei0BDrCC9JlqFcifwc8sPiSteb+vqNftoIOxAKqdbvId2HICMAlCd0oy7SA/e0xGq9pGjoU8/mwoNbLSUWpJCWYYKdm4NP8wEb6jbt4Xo/rFtTGNFSCUd2iI/wTR9ejSz4DvnpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOq6Kd1O; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOq6Kd1O"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso10439710a91.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784556344; x=1785161144; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DiVRINB6TtTw5pZfFfTZi38dW8cdML3pRT51zfVadcU=;
        b=pOq6Kd1OXdH6UZoQOc0XTd0MpRYuL3PLnqKDg78N7XKa2jciBYyBH3myOHBlTybLnb
         NXavCezoKfqVNWSzURCreZYXjlAyLwf3COxmX7X2PIOeVhTbuBpqqwbJahcJNt0n6iOl
         RZeifbhSca3tANxLzgyHD6xStvVGufb6TXbB5zee8u1PV/j+63MPnq9cnstaJFn28Uj2
         iF2YMxxlBTvobW38g9YrcKPhR24OtZOtSFzep0O8A2SVc/7vScGmjP5l+IsoUT3TG3+I
         LJmfTm0Si+jgs+LL4bUppPyvCmq2nqfG5rhozD2en26azR5wBqksAqM+oEVO2tcV8+Pg
         0L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556344; x=1785161144;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DiVRINB6TtTw5pZfFfTZi38dW8cdML3pRT51zfVadcU=;
        b=Ombdi7j154X40dninPzupLl4XrHMaYFEueMAg0pBtmPNkfMDUXO6n+mBX2keRAVsOY
         yN3Ud2E0oUFqrtpRc4h+P6MtPcX2iYjfQXppAP2ERF8ZIaVeZtfOJLl0h2fxncMAq20k
         iWvn4u2/D0YM5orYyRR02SXgrmXObe6b7dDzQH1Ds923z2CTvkEt3lDcclK6nTLk6Xqk
         2FQjWc9qsIyGJs35sXVem55xDNZVVaevujs9OUjp7ZdxylGMUfoi4nxp2O8RVudTz1pf
         Rs6B8a021XPxxCOk2ZScsTn6liKndbJbNQo1//JbcdrtA/Rw8g/r+swO3Nm4YZuw+LMg
         Dm8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrYpKSiHdzYGoDonwv8Q3R/l/HNWfO2aYg81Atwj/svzVUfYfFNVNSuhxJFOghq14E9vKJBDzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCstCRHX2Sp3HS91XWCmxe9zfD+og+9O0jWdBiMt1W24KzJJ58
	ddzPXoLOVwCgbKGvdLxblRibXjto4s7174alQtO/nNNlqHtQi+6CbVwN6Le7vbcEUWTQ00lDRsC
	GPRvcoQ==
X-Received: from pjee4.prod.google.com ([2002:a17:90b:5784:b0:384:e0b1:c3e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dcc:b0:38d:e0c4:c955
 with SMTP id 98e67ed59e1d1-38e4b447015mr14955851a91.15.1784556344165; Mon, 20
 Jul 2026 07:05:44 -0700 (PDT)
Date: Mon, 20 Jul 2026 07:05:43 -0700
In-Reply-To: <20260719-rmap-age-elided-submit-v1-1-cb32f2390765@phil.gs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260719-rmap-age-elided-submit-v1-1-cb32f2390765@phil.gs>
Message-ID: <al4rNzlV2wS0jDw5@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Skip rmap aging when the rmap lock was elided
From: Sean Christopherson <seanjc@google.com>
To: Phil Rosenthal <phil@phil.gs>, t@google.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Jul 19, 2026, Phil Rosenthal wrote:
> __kvm_rmap_lock() deliberately elides the rmap lock when it observes an
> empty rmap.  In that case kvm_rmap_lock_readonly() also re-enables
> preemption and returns zero, so the caller holds neither the rmap lock
> nor a preemption reference.  The elision documents the invariant it
> relies on:
> 
> 	 * Elide the lock if the rmap is empty, as lockless walkers (read-only
> 	 * mode) don't need to (and can't) walk an empty rmap, nor can they add
> 	 * entries to the rmap.  I.e. the only paths that process empty rmaps
> 	 * do so while holding mmu_lock for write, and are mutually exclusive.
> 
> kvm_rmap_age_gfn_range() ignores the returned value and unconditionally
> enters for_each_rmap_spte_lockless().  The iterator starts with
> rmap_get_first(), which re-reads rmap_head->val rather than using the
> value returned by the lock.  If a writer populates the rmap between the
> lock's read and the iterator's re-read, the aging path walks the newly
> installed rmap without holding its lock.

/facepalm

Well that's a blatantly stupid TOCTOU bug in hindsight.

> For a KVM_RMAP_MANY rmap this leaves the walker following a
> pte_list_desc chain that it never locked.  A writer holding mmu_lock for
> write may free that chain (e.g. kvm_zap_all_rmap_sptes() on the recycle
> path, or any rmap zap) via kmem_cache_free() while the walk is in
> progress, giving a slab use-after-free.  Nothing serialises the two: the
> aging path runs without mmu_lock when CONFIG_KVM_MMU_LOCKLESS_AGING=y,
> and the rmap lock that would otherwise exclude the writer was elided.
> Because the empty path re-enables preemption, the interval between the
> two reads can span an arbitrary scheduling delay.
> 
> Skip the walk when locking returned zero, as required by the
> lock-elision invariant.  kvm_rmap_unlock_readonly() already treats zero
> as requiring no unlock, so the early continue does not leak a lock or a
> preemption reference.  Missing an SPTE installed after the empty
> observation is harmless because aging is best-effort.
> 
> Fixes: af3b6a9eba48 ("KVM: x86/mmu: Walk rmaps (shadow MMU) without holding mmu_lock when aging gfns")
> Cc: stable@vger.kernel.org
> Signed-off-by: Phil Rosenthal <phil@phil.gs>
> ---
> This bug was identified and confirmed with AI assistance; per
> Documentation/process/security-bugs.rst it is therefore reported in the
> open rather than via the security list.
> 
> The static analysis and runtime evidence are described separately.
> 
> Static: the invariant quoted above is stated by __kvm_rmap_lock(), and
> kvm_rmap_age_gfn_range() is the one caller that violates it by walking
> after an elided (zero) lock.  This holds regardless of any runtime
> result.
> 
> Runtime: I confirmed the use-after-free is reachable on a KASAN build
> (CONFIG_KASAN_GENERIC=y, CONFIG_KVM_MMU_LOCKLESS_AGING=y, kvm.tdp_mmu=0,
> kvm_intel.ept=0 so shared pages build multi-SPTE pte_list_desc rmaps).
> This is not a natural reproducer: it is a test-only race amplifier.  A
> test hook widens two windows (a delay after the zero-lock observation,
> and a delay after the iterator has cached iter->desc) and schedules the
> real lockless aging function onto recently recycled gfns.  The alloc and
> free are unmodified production paths; only the scheduling of the aging
> walk and the two delays are injected.  The test-only instrumentation is
> available privately on request.  KASAN then reports a
> slab-use-after-free, read in the rmap_get_next() step of
> for_each_rmap_spte_lockless() (the symbol is
> kvm_rmap_age_gfn_range.isra.0 in the instrumented build):
> 
>   BUG: KASAN: slab-use-after-free in kvm_rmap_age_gfn_range.isra.0+0x7e4/0xa60 [kvm]
>   Read of size 8 at addr ffff88814690c6d8 by task kworker/12:2/81966
>   Workqueue: events age_race_workfn [kvm]     <- test hook: lockless aging, no mmu_lock
>    kvm_rmap_age_gfn_range.isra.0+0x7e4/0xa60 [kvm]
>    age_race_workfn+0x14b/0x1a0 [kvm]
>    process_one_work+0x6c8/0x1020
>   Allocated by task 94096:
>    kmem_cache_alloc_noprof+0x179/0x460
>    __kvm_mmu_topup_memory_cache+0x136/0x540 [kvm]
>    paging64_page_fault+0x2b6/0x1e70 [kvm]      <- one vCPU faults, allocs the desc
>   Freed by task 94095:
>    kmem_cache_free+0x11d/0x4a0
>    kvm_zap_all_rmap_sptes+0xe9/0x1a0 [kvm]
>    __rmap_add+0x2c4/0x5e0 [kvm]
>    mmu_set_spte+0x6d6/0x1060 [kvm]
>    paging64_page_fault+0x1385/0x1e70 [kvm]     <- another vCPU, under mmu_lock,
>                                                   recycles and frees the desc
>   The buggy address belongs to the object at ffff88814690c6c0
>    which belongs to the cache pte_list_desc of size 128
> 
> The three tasks are distinct (read 81966 / alloc 94096 / free 94095),
> confirming genuine concurrency rather than a self-inflicted free.  With
> the fix applied under the same injection load, the zero -> populated
> window is still observed but the walk is skipped and no KASAN report is
> produced.
> 
> Alternative fix: this patch fixes the only current caller that ignores
> an empty return.  A class-wide alternative would pass the value returned
> by kvm_rmap_lock_readonly() into the iterator instead of having
> rmap_get_first() re-read the rmap, so no lockless walker could
> reintroduce the bug.  I chose the smaller change for ease of
> backporting, and can send the larger one if preferred.

Larger one please.  The backport only needs to go back to 6.18 kernels, and the
below applies cleanly to 6.18.y.  This is specifically what I'm thinking:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7757f0ad65c6..ecf9e39aed5a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1228,18 +1228,9 @@ struct rmap_iterator {
        int pos;                        /* index of the sptep */
 };
 
-/*
- * Iteration must be started by this function.  This should also be used after
- * removing/dropping sptes from the rmap link because in such cases the
- * information in the iterator may not be valid.
- *
- * Returns sptep if found, NULL otherwise.
- */
-static u64 *rmap_get_first(struct kvm_rmap_head *rmap_head,
-                          struct rmap_iterator *iter)
+static u64 *__rmap_get_first(unsigned long rmap_val,
+                            struct rmap_iterator *iter)
 {
-       unsigned long rmap_val = kvm_rmap_get(rmap_head);
-
        if (!rmap_val)
                return NULL;
 
@@ -1253,6 +1244,19 @@ static u64 *rmap_get_first(struct kvm_rmap_head *rmap_head,
        return iter->desc->sptes[iter->pos];
 }
 
+/*
+ * Iteration must be started by this function.  This should also be used after
+ * removing/dropping sptes from the rmap link because in such cases the
+ * information in the iterator may not be valid.
+ *
+ * Returns sptep if found, NULL otherwise.
+ */
+static u64 *rmap_get_first(struct kvm_rmap_head *rmap_head,
+                          struct rmap_iterator *iter)
+{
+       return __rmap_get_first(kvm_rmap_get(rmap_head), iter);
+}
+
 /*
  * Must be used with a valid iterator: e.g. after rmap_get_first().
  *
@@ -1287,8 +1291,9 @@ static u64 *rmap_get_next(struct rmap_iterator *iter)
        __for_each_rmap_spte(_rmap_head_, _iter_, _sptep_)                      \
                if (!WARN_ON_ONCE(!is_shadow_present_pte(*(_sptep_))))  \
 
-#define for_each_rmap_spte_lockless(_rmap_head_, _iter_, _sptep_, _spte_)      \
-       __for_each_rmap_spte(_rmap_head_, _iter_, _sptep_)                      \
+#define for_each_rmap_spte_lockless(_rmap_val_, _iter_, _sptep_, _spte_)       \
+       for (_sptep_ = __rmap_get_first(_rmap_val_, _iter_);                    \
+            _sptep_; _sptep_ = rmap_get_next(_iter_))                          \
                if (is_shadow_present_pte(_spte_ = mmu_spte_get_lockless(sptep)))
 
 static void drop_spte(struct kvm *kvm, u64 *sptep)
@@ -1726,7 +1731,7 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
                        rmap_head = gfn_to_rmap(gfn, level, range->slot);
                        rmap_val = kvm_rmap_lock_readonly(rmap_head);
 
-                       for_each_rmap_spte_lockless(rmap_head, &iter, sptep, spte) {
+                       for_each_rmap_spte_lockless(rmap_val, &iter, sptep, spte) {
                                if (!is_accessed_spte(spte))
                                        continue;

> ---
>  arch/x86/kvm/mmu/mmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 234d0a95abf534193e8285e61dfb7e0c56ba19ad..e57c4580f58564bbf984364b3563f6b00aee21a9 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1723,6 +1723,9 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
>  			rmap_head = gfn_to_rmap(gfn, level, range->slot);
>  			rmap_val = kvm_rmap_lock_readonly(rmap_head);
>  
> +			if (!rmap_val)
> +				continue;

In addition to preventing future bugs with for_each_rmap_spte_lockless(), I want
to go straight to the (ever so slightly) larger fix is to avoid adding another
path with a lock() but no paired unlock().  kvm_zap_all_rmap_sptes() has such a
case, but that really should be cleaned up.

This is all internal MMU code, so bleeding the rmap locking details into the
callers isn't the end of the world, but it _looks_ wrong.

> +
>  			for_each_rmap_spte_lockless(rmap_head, &iter, sptep, spte) {
>  				if (!is_accessed_spte(spte))
>  					continue;
> 
> ---
> base-commit: 25f744ffa0c8e799e06250ce2e618367b166b0d4
> change-id: 20260719-rmap-age-elided-submit-98dbd451b9ba
> 
> Best regards,
> -- 
> Phil Rosenthal <phil@phil.gs>
> 
