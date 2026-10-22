Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681389;
	b=3WP4qBiQzH0qAhhOeberOH3IcWpUALzt0lN9SmEqb1nTd5LmqudF9gTkJ+sqzJ3uKxWb
	 tRdx+iWXjMXFSWzVBdKeetNbMPMhmPdOwRFCQIAHKhiB8CNu9kZBn7L/g/JvY8kyj4yGp
	 VgsLjKP1qww0TwBpIRkRAnh5xcbdd4VXPaWkn/n7z3RTQjntMay2B7YylQJ2dVKdvcNcb
	 YAilxPNJ9m5pdCjuVnkz4MJg6dFPmdDTicX3s0Yq8AIY8yBHpQIpxMPmxZiWbedJULs8Z
	 2+VA5JxwuPvi8cmm3J0S760ZnYbdc/+vpLpKGHPRqVjWb2xOa2QpGLtdMQwAnU/U9Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=RS+w97Z7+gAprFJv+vqfHSnrNycJNQGbw0RdFqhpDtQ=;
	b=pp1D0gQG9uBH5DilIvVNxonw8sF+AZ7rTHGtcXHMY1PX92Il5bIv6K56BAxl5I2W5YfS
	 f8p28XzoKq4y+uxOH2/5GUBigaJHeh3bnhmEXu8spgnh9FB5r+lDhoxkdV5yX/28ORSlj
	 Cjlm5kA4588X1/JQJwTcDBTg+vEYbciKZOqBjWgC7REMeRD5ADs+LTLAht/3TpUriDiJH
	 PO086CDK9CsTyXiYs730tbeBA2y6JJYZLpGcAcCtiOBEsuukmesgMNoGDOoFC2YczgCpS
	 5m3quRczDwwlCwj0hH35qgMenlUqdyMjNGVP/hoZfSo3GhgtoP+luhIpwIKmlAM0sYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nU7Tf7wI;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A8606A323
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E5A8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nU7Tf7wI
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e60770381cso19809955ad.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792681388; x=1793286188; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RS+w97Z7+gAprFJv+vqfHSnrNycJNQGbw0RdFqhpDtQ=;
        b=nU7Tf7wIhsEVGz8mS2x/cvBdPaTJnFOFld64n02hF/Br36xXEJ7LWcunqvpTxAL6I9
         47pOz8NpVDxUg14iOHsBOCPgW+zI8Hg4azY0278LQI6xmDcegCgy3cZir9BoNCDnudU6
         M1eT92a1weJJoeB7F0IBahUFY0yQyGLSGrWM1WSZWcLY3naewDfDhFyvTsQ9zm+nLN8+
         OMsSPCZ3Cq4WCiomGiqFJl6Qn+BKCtkZP5ZKEH+2ympj3Sb9bjfjGQ0IpDXdqOWVJ9rE
         3Us25R3+VgDAD8On0aGZjMUo3fhFf5DMH1QedO1mX2ftRY405F5McSGPChwUNFH3/oj2
         ShIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681388; x=1793286188;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RS+w97Z7+gAprFJv+vqfHSnrNycJNQGbw0RdFqhpDtQ=;
        b=wLVOiqSzjBmk98t/O+Z9YEi8+w0EITdROm7oZclmlMIW/kausCalbgIson+RX7f1aW
         iLOTY3sEEOFxyz0z6LMxV7MBohqjcDhwkT1mcV8Jjxkd8GjjKLLm4HrDTKEa8hI3Dkjz
         SlV5C4N9pl2Ho2J9l5Uuz0C0Ksuet6WBMo8jke6tW7g+PKwstAVtTKiI830SXRs8lnhJ
         A6i1nmlhpD0bSUzTpx+Dq9xr7Yhbqvocdcxc2Qh2VQuZAuSluSkqo2B5/cB+/MbqsNDs
         YRTus+GCmtBlLfl6KEdOpqAkRdpw9L0ktiS3pmlj6Osl5zpeCn9QYP15sTDd48vK4RyS
         6uEQ==
X-Forwarded-Encrypted: i=1; AKwUvBz49L4Tq2ZvWUkFeh+22iNMRnmHALoiQyrCL7IGJQb66Y+J0pqfWOTvsZhrgc3rL/h2j9/JM+A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHYnyzFLIk6kKCcXj1fYXnh65wuIinhIanCiHiSnpGD0Te3Wjz
	u0LpJeXK0Rjrq7DUFZcqTzR6T61O8sngx0RfLbB9/RDLvNRChpP9MXurxMFmh2P8txdHJjiK+zd
	0DM3GXw==
X-Received: from plsr17.prod.google.com ([2002:a17:902:be11:b0:2e9:4f49:1132])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a0c:b0:2e9:460e:ca49
 with SMTP id d9443c01a7336-2ea439f467amr49266545ad.18.1792681388121; Thu, 22
 Oct 2026 08:03:08 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:03:07 +0000
In-Reply-To: <20261017193911.40182-1-amirmohammad.eftekhar@cispa.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261017193911.40182-1-amirmohammad.eftekhar@cispa.de>
Message-ID: <atolq8545YGo4iKx@google.com>
Subject: Re: [BUG] KVM: x86/xen: gfn_to_pfn_cache left active after
 mmu_notifier release leads to a host use-after-free write
From: Sean Christopherson <seanjc@google.com>
To: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: w@1wt.eu, security@kernel.org, dwmw2@infradead.org, paul@xen.org, 
	pbonzini@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Oct 17, 2026, Amirmohammad Eftekhar wrote:
> ---
>  virt/kvm/kvm_main.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 479b7f5bf..6ac6a71fe 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -891,6 +891,18 @@ static void kvm_mmu_notifier_release(struct mmu_notifier *mn,
> 
>  	idx = srcu_read_lock(&kvm->srcu);
>  	kvm_flush_shadow_all(kvm);
> +
> +	/*
> +	 * Invalidate all gfn_to_pfn_caches before KVM is unhooked from the
> +	 * mmu_notifier.  Release is the last callback KVM will receive for this
> +	 * mm, so the invalidate_range events that exit_mmap() raises when it
> +	 * frees the pages can no longer reach the caches; without this the
> +	 * caches are left valid, pointing at pages that are about to be freed,
> +	 * and an async writer (e.g. the Xen event-channel timer) can perform a
> +	 * use-after-free write through the stale kernel mapping.
> +	 */

Eh, I would omit the comment, IMO this falls into the "obviously necessary"
category once the code exists.

> +	gfn_to_pfn_cache_invalidate_start(kvm, 0, ULONG_MAX);

I'm pretty sure this should go inside kvm_flush_shadow_all(), both because this
isn't unique to mmu_notifiers, even though that's the only remaining user of
kvm_flush_shadow_all().  E.g. in a hypothetical world where kvm_flush_shadow_all()
was used to ensure there were no outstanding mappings anywhere in KVM, hooking
only kvm_mmu_notifier_release() would do the wrong thing.

The other wrinkle is that super strictly speaking the invalidation needs to happen
before kvm_arch_guest_memory_reclaimed().  In practice, there are no interactions
between SEV's cache maintenance and GPCs, but conceptually the GPC invalidation
should occur first.  That would also match the ordering in 
kvm_mmu_notifier_invalidate_range_start().

Another stupid nit: ULONG_MAX is somewhat misleading because
gfn_to_pfn_cache_invalidate_start() takes an exclusive @end.  It's not a bug
because GPCs only ever deal with user addresses, i.e. it should be impossible to
have a cache at ULONG_MAX-PAGE_SIZE.  Ugh, except for maybe s390, which selects
ALTERNATE_USER_ADDRESS_SPACE?  CONFIG_HAVE_KVM_PFNCACHE is only selected by x86,
but it still seems like we should do this "right" the first time.

Rather than pass literal numbers, what if (over a few patches) we massage
gfn_to_pfn_cache_invalidate_start() to take a range pointer, and then add an
"invalidate all" wrapper that passes a NULL range?

Anyone object to taking this on-list?  Unless I'm missing something, this only
affects the Xen timer, and there are preciously few end users of KVM Xen emulation.

E.g. (completely untested)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..c2e16370f5b8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -350,6 +350,7 @@ void kvm_flush_remote_tlbs_memslot(struct kvm *kvm,
 static void kvm_flush_shadow_all(struct kvm *kvm)
 {
 	kvm_arch_flush_shadow_all(kvm);
+	gfn_to_pfn_cache_invalidate_all(kvm);
 	kvm_arch_guest_memory_reclaimed(kvm);
 }
 
@@ -764,7 +765,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	 * mn_active_invalidate_count (see above) instead of
 	 * mmu_invalidate_in_progress.
 	 */
-	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end);
+	gfn_to_pfn_cache_invalidate_start(kvm, range);
 
 	/*
 	 * If one or more memslots were found and thus zapped, notify arch code
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index c65cfdb14f1c..f46d999d056a 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -6,6 +6,8 @@
 #include <linux/kvm.h>
 #include <linux/kvm_types.h>
 
+struct mmu_notifier_range;
+
 /*
  * Architectures can choose whether to use an rwlock or spinlock
  * for the mmu_lock.  These macros, for use in common code
@@ -60,14 +62,19 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp);
 
 #ifdef CONFIG_HAVE_KVM_PFNCACHE
 void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
-				       unsigned long start,
-				       unsigned long end);
+				       const struct mmu_notifier_range *range);
+
+static inline void gfn_to_pfn_cache_invalidate_all(struct kvm *kvm)
+{
+	gfn_to_pfn_cache_invalidate_start(kvm, NULL);
+}
+
 #else
 static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
-						     unsigned long start,
-						     unsigned long end)
+						     const struct mmu_notifier_range *range)
 {
 }
+static inline void gfn_to_pfn_cache_invalidate_all(struct kvm *kvm) { }
 #endif /* HAVE_KVM_PFNCACHE */
 
 #endif /* __KVM_MM_H__ */
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 3659686b97c2..3f0edb46ec57 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -19,11 +19,18 @@
 
 #include "kvm_mm.h"
 
+static bool gfn_to_pfn_cache_needs_invalidation(struct gfn_to_pfn_cache *gpc,
+						const struct mmu_notifier_range *range)
+{
+	return gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
+	       (!range || (gpc->uhva >= range->start && gpc->uhva < range->end));
+}
+
 /*
  * MMU notifier 'invalidate_range_start' hook.
  */
-void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
-				       unsigned long end)
+void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
+				       const struct mmu_notifier_range *range)
 {
 	struct gfn_to_pfn_cache *gpc;
 
@@ -32,8 +39,7 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 		read_lock_irq(&gpc->lock);
 
 		/* Only a single page so no need to care about length */
-		if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
-		    gpc->uhva >= start && gpc->uhva < end) {
+		if (gfn_to_pfn_cache_needs_invalidation(gpc, range)) {
 			read_unlock_irq(&gpc->lock);
 
 			/*
@@ -45,8 +51,8 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 			 */
 
 			write_lock_irq(&gpc->lock);
-			if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
-			    gpc->uhva >= start && gpc->uhva < end)
+			
+			if (gfn_to_pfn_cache_needs_invalidation(gpc, range))
 				gpc->valid = false;
 			write_unlock_irq(&gpc->lock);
 			continue;


