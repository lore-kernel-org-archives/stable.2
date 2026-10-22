Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682952;
	b=jwgPLKQQ7rslYuQ/21RwlaoWuaobYDlQENJAu1avNhk3wgoKiO2nqMjaqJ9AszHjRdDZ
	 mS72aF2ON0Ed8svouH3FhgXj8IPDIYyVYZ8So092kO408lfTnXdqKE2tQgy2ywp3TGgpV
	 x4ELA2rlRb8rDKSeriWqqRO4dwLKBGL14N+4XjQZ1gmdbVWVXaEGAHO2OLg1SqJg0PShd
	 kzX4jwmT141HZSYAGG9ZRXj3DagMvrYya83p+XDuMNETf+a0kU/QlTft4kmKrxKL0NbXP
	 q7POpqxPz3M7M3hgAZq+xn0bABQuPKSeW06dn9y2uWQCtJpPty5bOjJjw4U66YlvG5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682952;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-Virus-Scanned:X-Spam-Level;
	bh=D3AAs+Z1bIzoxEDML9W2VI7nbazqxQldCJY+X6eiE80=;
	b=V6eYTEFlr/M0oQCreTdXWJ4A66d/RqZ3oP/pYD7PyFkEADjtjOwyE/6aKherEoA74uX3
	 lEFFrTwubvrwyMvwy5MvcWpY/EwZeZt2z9KbPH2W7Uwhx6cqHdLWgI/X5pdnd0MoE5A8F
	 SHo24uIzy5aV97Wdtp5wN3eL1tNoGwXrxx5wdUCV0vgkyvbfjod94jjuN+HDvoA9+fBMg
	 s4IZsKsCIOUt86oBJ+7qbWZ06hfNIOobL0vTj4sfJ6l27FKGmT1v0Q3wGl3Rl8mTZrwA0
	 nGc/Vv6v9VFVidTM364lo4mJQGeL4JtliPtc6V22M2KhD7WhaTJ5h8Vhp/5REYeCtZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=eqFKGvFv;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4E606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE4E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=eqFKGvFv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:CC:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D3AAs+Z1bIzoxEDML9W2VI7nbazqxQldCJY+X6eiE80=; b=eqFKGvFvM7XG7fE+Xkwega5UnD
	reQ2SGTA0XwCLOciWQBsSTfRlDrFh8wJMA8dqFq2OKf6Vp4TfLvbWTDD6CGt4y+wzvZjnWHW8dsCD
	l4sa5lX8dmUVzK1vx3qOv0bpGVMcJUJtzrHQF+nPcC2mN6tvbOOF4BGT9f9wZ0w3rACcoIegQn4b2
	sRXI21NzFQYfg1j2B+rTTF8O5xX4k4PxPtVWNVtJKyY2DsIhY0lWKRo0kpUpREZkl4CNONi/R2DFw
	4yUCPWK05u9xb+phF8tdS+nWukXYo2d0k4OyYbfQ9WxrW///QS5DoxKoFmDWLlgRjR1Og+ase5Cif
	stxIAVNA==;
Received: from mailer.gwdg.de ([134.76.10.26]:39681)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xJuir-00E3LW-0m;
	Thu, 22 Oct 2026 17:28:52 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xJuiq-000Vw7-2e;
	Thu, 22 Oct 2026 17:28:52 +0200
Received: from [10.17.212.44] (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 22 Oct
 2026 17:28:52 +0200
Message-ID: <1f069122-c856-406a-a30d-244770563206@cispa.de>
Date: Thu, 22 Oct 2026 17:28:51 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] KVM: x86/xen: gfn_to_pfn_cache left active after
 mmu_notifier release leads to a host use-after-free write
To: Sean Christopherson <seanjc@google.com>
CC: <w@1wt.eu>, <security@kernel.org>, <dwmw2@infradead.org>, <paul@xen.org>,
	<pbonzini@redhat.com>, <stable@vger.kernel.org>
References: <20261017193911.40182-1-amirmohammad.eftekhar@cispa.de>
 <atolq8545YGo4iKx@google.com>
Content-Language: en-US
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
In-Reply-To: <atolq8545YGo4iKx@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MBX19-GWD-04.um.gwdg.de (10.108.142.57) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

No objection to on-list.

The Xen timer is the only writer that can actually hit it today, but the
dangling cache isnt Xen-specific. kvm_mmu_notifier_release() leaves every
gpc on kvm->gpc_list valid, pv_time (pvclock) included, which doesnt depend
on CONFIG_KVM_XEN. pv_time just never gets written from an async, non-vCPU
context, so its a latent dangle rather than a live UAF - which is another
reason to fix it in the generic path like youre suggesting rather than in
Xen.

Agreed on moving it into kvm_flush_shadow_all() and doing the invalidate
before kvm_arch_guest_memory_reclaimed(), and the range-pointer + 
"invalidate
all" wrapper is nicer than the ULONG_MAX. Happy to respin it that way, or
leave it to you - whichever is less work.

Thanks,
Amir

On 10/22/26 17:03, Sean Christopherson wrote:
> On Sat, Oct 17, 2026, Amirmohammad Eftekhar wrote:
>> ---
>>   virt/kvm/kvm_main.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 479b7f5bf..6ac6a71fe 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -891,6 +891,18 @@ static void kvm_mmu_notifier_release(struct mmu_notifier *mn,
>>
>>   	idx = srcu_read_lock(&kvm->srcu);
>>   	kvm_flush_shadow_all(kvm);
>> +
>> +	/*
>> +	 * Invalidate all gfn_to_pfn_caches before KVM is unhooked from the
>> +	 * mmu_notifier.  Release is the last callback KVM will receive for this
>> +	 * mm, so the invalidate_range events that exit_mmap() raises when it
>> +	 * frees the pages can no longer reach the caches; without this the
>> +	 * caches are left valid, pointing at pages that are about to be freed,
>> +	 * and an async writer (e.g. the Xen event-channel timer) can perform a
>> +	 * use-after-free write through the stale kernel mapping.
>> +	 */
> 
> Eh, I would omit the comment, IMO this falls into the "obviously necessary"
> category once the code exists.
> 
>> +	gfn_to_pfn_cache_invalidate_start(kvm, 0, ULONG_MAX);
> 
> I'm pretty sure this should go inside kvm_flush_shadow_all(), both because this
> isn't unique to mmu_notifiers, even though that's the only remaining user of
> kvm_flush_shadow_all().  E.g. in a hypothetical world where kvm_flush_shadow_all()
> was used to ensure there were no outstanding mappings anywhere in KVM, hooking
> only kvm_mmu_notifier_release() would do the wrong thing.
> 
> The other wrinkle is that super strictly speaking the invalidation needs to happen
> before kvm_arch_guest_memory_reclaimed().  In practice, there are no interactions
> between SEV's cache maintenance and GPCs, but conceptually the GPC invalidation
> should occur first.  That would also match the ordering in
> kvm_mmu_notifier_invalidate_range_start().
> 
> Another stupid nit: ULONG_MAX is somewhat misleading because
> gfn_to_pfn_cache_invalidate_start() takes an exclusive @end.  It's not a bug
> because GPCs only ever deal with user addresses, i.e. it should be impossible to
> have a cache at ULONG_MAX-PAGE_SIZE.  Ugh, except for maybe s390, which selects
> ALTERNATE_USER_ADDRESS_SPACE?  CONFIG_HAVE_KVM_PFNCACHE is only selected by x86,
> but it still seems like we should do this "right" the first time.
> 
> Rather than pass literal numbers, what if (over a few patches) we massage
> gfn_to_pfn_cache_invalidate_start() to take a range pointer, and then add an
> "invalidate all" wrapper that passes a NULL range?
> 
> Anyone object to taking this on-list?  Unless I'm missing something, this only
> affects the Xen timer, and there are preciously few end users of KVM Xen emulation.
> 
> E.g. (completely untested)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f140..c2e16370f5b8 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -350,6 +350,7 @@ void kvm_flush_remote_tlbs_memslot(struct kvm *kvm,
>   static void kvm_flush_shadow_all(struct kvm *kvm)
>   {
>   	kvm_arch_flush_shadow_all(kvm);
> +	gfn_to_pfn_cache_invalidate_all(kvm);
>   	kvm_arch_guest_memory_reclaimed(kvm);
>   }
>   
> @@ -764,7 +765,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   	 * mn_active_invalidate_count (see above) instead of
>   	 * mmu_invalidate_in_progress.
>   	 */
> -	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end);
> +	gfn_to_pfn_cache_invalidate_start(kvm, range);
>   
>   	/*
>   	 * If one or more memslots were found and thus zapped, notify arch code
> diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
> index c65cfdb14f1c..f46d999d056a 100644
> --- a/virt/kvm/kvm_mm.h
> +++ b/virt/kvm/kvm_mm.h
> @@ -6,6 +6,8 @@
>   #include <linux/kvm.h>
>   #include <linux/kvm_types.h>
>   
> +struct mmu_notifier_range;
> +
>   /*
>    * Architectures can choose whether to use an rwlock or spinlock
>    * for the mmu_lock.  These macros, for use in common code
> @@ -60,14 +62,19 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp);
>   
>   #ifdef CONFIG_HAVE_KVM_PFNCACHE
>   void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
> -				       unsigned long start,
> -				       unsigned long end);
> +				       const struct mmu_notifier_range *range);
> +
> +static inline void gfn_to_pfn_cache_invalidate_all(struct kvm *kvm)
> +{
> +	gfn_to_pfn_cache_invalidate_start(kvm, NULL);
> +}
> +
>   #else
>   static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
> -						     unsigned long start,
> -						     unsigned long end)
> +						     const struct mmu_notifier_range *range)
>   {
>   }
> +static inline void gfn_to_pfn_cache_invalidate_all(struct kvm *kvm) { }
>   #endif /* HAVE_KVM_PFNCACHE */
>   
>   #endif /* __KVM_MM_H__ */
> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index 3659686b97c2..3f0edb46ec57 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -19,11 +19,18 @@
>   
>   #include "kvm_mm.h"
>   
> +static bool gfn_to_pfn_cache_needs_invalidation(struct gfn_to_pfn_cache *gpc,
> +						const struct mmu_notifier_range *range)
> +{
> +	return gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
> +	       (!range || (gpc->uhva >= range->start && gpc->uhva < range->end));
> +}
> +
>   /*
>    * MMU notifier 'invalidate_range_start' hook.
>    */
> -void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
> -				       unsigned long end)
> +void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
> +				       const struct mmu_notifier_range *range)
>   {
>   	struct gfn_to_pfn_cache *gpc;
>   
> @@ -32,8 +39,7 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
>   		read_lock_irq(&gpc->lock);
>   
>   		/* Only a single page so no need to care about length */
> -		if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
> -		    gpc->uhva >= start && gpc->uhva < end) {
> +		if (gfn_to_pfn_cache_needs_invalidation(gpc, range)) {
>   			read_unlock_irq(&gpc->lock);
>   
>   			/*
> @@ -45,8 +51,8 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
>   			 */
>   
>   			write_lock_irq(&gpc->lock);
> -			if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
> -			    gpc->uhva >= start && gpc->uhva < end)
> +			
> +			if (gfn_to_pfn_cache_needs_invalidation(gpc, range))
>   				gpc->valid = false;
>   			write_unlock_irq(&gpc->lock);
>   			continue;
> 
> 

