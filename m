Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6D23395D;
	Thu, 10 Sep 2026 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029832; cv=none; b=i+W/PPiupeQ5GxQ1Q2zySiFYsOX/R1doyEG2cPiXXdn8z7nkQkbkE/c1G7yBzDltO1Kk9VZEdWWpRyOH0HMZBWjB92J1TsMGcgu29BFjgBv/uHFqH0YEZfolv5VjLsqrbPOPLYZRr3/bbri+kRiWhpCw73YAxhxLt7DUYr6LEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029832; c=relaxed/simple;
	bh=GwscfBrlwlJ4OfLnuhq6+VRNnnQ2CC3GGxRnzmZy45c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8bOaf3GUMtSKi5xvsPQAQHdGRIbQOsD7gjMDAAudSjlNzpfHNSayfNd83CkXsQ48CTsPeGk/EXss8F2nGkJ9dmrQ5IRj/nM6WxWaUs/IUssea4w5iIgrvrfHy0Ok7KQJSH/K3Fb3yIsOnm7UUMrlE1MUj7UZX6eEYp0npohh5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2HP7y+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2HP7y+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4006D1F000FF;
	Thu, 10 Sep 2026 08:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789029831;
	bh=ErRlIXkdJ4/rRpN+QKa7XDjPMLHUV1wufabVSUtAsQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P2HP7y+vQFK2rr4JQhfnWLQMcAoRUjYl4ShV0NJRFVhOU01TwpojXqi5Jbf1VLxtt
	 5H9xKB2rEUeMkwUkTm5zk539OYXH0eiWTbsiy9jycZVsGQzCIayr6NiL0YWH1JR3l1
	 buZNmfJ+GpiTDrFMdLrNywunrZUioJ75icRB1IFBoL2ji1IPNU3+4jgJinv8TZG+TW
	 L439PYO2ICtBackUaHH4CaeZWo0b/I8QDxYt6BXfeZdBBeVop2JbHKCVChZvjoYU5Q
	 Xb1w6rKuHpgTSCZnAML1njltCXVnefNYTP1iYvbYePrxP4gp1ZbjAGRaM5XdClNwnT
	 yVPzcZRhjUumw==
Message-ID: <fb373298-717e-4047-bf47-770bc39d1b81@kernel.org>
Date: Thu, 10 Sep 2026 10:43:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: guest_memfd: take the invalidate lock when
 unbinding a dying file
To: Shivank Garg <shivankg@amd.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20260901-gmem-unbind-fix-v2-1-12febe1d2216@amd.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260901-gmem-unbind-fix-v2-1-12febe1d2216@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/26 09:20, Shivank Garg wrote:
> kvm_gmem_unbind() takes mapping->invalidate_lock only if the
> get_file_active() succeeds. When the guest_memfd file is dying, its
> reference count is already zero so get_file_active fails and the binding
> is removed without holding the invalidate lock.
> 
> kvm_gmem_invalidate_{start,end}() checks f->bindings independently to
> decide whether to begin or end KVM MMU invalidation. So, the bindings
> must therefore remain stable between the two calls. Otherwise, unbind
> can remove a binding after start increments mmu_invalidate_in_progress,
> but before end finds the binding and decrements it.
> Example, unbind race with memory failure:
> 
>   CPU 0: memory failure               CPU 1: memslot delete
>   ----------------------------------  ---------------------------
>                                       (guest_memfd file is dying)
>   kvm_gmem_error_folio()
>     kvm_gmem_invalidate_start()
>       finds binding
>       mmu_invalidate_in_progress++
>                                       kvm_gmem_unbind()
>                                         get_file_active() fails
>                                         removes binding
>     kvm_gmem_invalidate_end()
>       no binding found
>       counter stays elevated
> 
> mmu_invalidate_retry() then returns 1 forever, so guest page faults
> retry without ever installing a mapping and the guest hangs.
> 
> Remove the distinction between live and dying files in the unbind path.
> Always use slot->gmem.file and take the invalidate lock when it's non-NULL.
> Normal unbind callers hold slots_lock, which prevents release from clearing
> the pointer or freeing the file state until unbind completes. Final VM
> teardown can only see a NULL pointer because guest_memfd pins the KVM until
> release has cleared all bindings.
> 
> Fixes: ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when gmem is dying")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260728092027.225CF1F000E9@smtp.kernel.org
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
> Tested on a 7.3-rc1, AMD EPYC 7713.
> 
> Changes in V2:
> - Treat a dying file as the normal case: always use slot->gmem.file and
>   take invalidate lock, drop use of gmem_get_file for unbind and fold
>   __kvm_gmem_unbind() into caller. (Sean) 
> - Drop NUMA selftests changes from this series, and will be sent separately. (Sean)
> - Link to V1: https://lore.kernel.org/kvm/20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com
> ---
>  virt/kvm/guest_memfd.c | 44 ++++++++++++++++++--------------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 625e62e1a031..21bb3710edfe 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -668,48 +668,40 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	return r;
>  }
>  
> -static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct gmem_file *f)
> +void kvm_gmem_unbind(struct kvm_memory_slot *slot)
>  {
> +	struct file *file = slot->gmem.file;
>  	unsigned long start = slot->gmem.pgoff;
>  	unsigned long end = start + slot->npages;
> +	struct gmem_file *f;
>  
> -	xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
> -
> -	/*
> -	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
> -	 * cannot see this memslot.
> -	 */
> -	WRITE_ONCE(slot->gmem.file, NULL);
> -}
> -
> -void kvm_gmem_unbind(struct kvm_memory_slot *slot)
> -{
>  	/*
>  	 * Nothing to do if the underlying file was _already_ closed, as
>  	 * kvm_gmem_release() invalidates and nullifies all bindings.
>  	 */
> -	if (!slot->gmem.file)
> +	if (!file)
>  		return;
>  
> -	CLASS(gmem_get_file, file)(slot);
> -
>  	/*
>  	 * However, if the file is _being_ closed, then the bindings need to be
>  	 * removed as kvm_gmem_release() might not run until after the memslot
> -	 * is freed.  Note, modifying the bindings is safe even though the file
> -	 * is dying as kvm_gmem_release() nullifies slot->gmem.file under
> -	 * slots_lock, and only puts its reference to KVM after destroying all
> -	 * bindings.  I.e. reaching this point means kvm_gmem_release() hasn't
> -	 * yet destroyed the bindings or freed the gmem_file, and can't do so
> -	 * until the caller drops slots_lock.
> +	 * is freed.  Modifying the bindings is safe even if the file is dying
> +	 * as kvm_gmem_release() nullifies slot->gmem.file under slots_lock,
> +	 * and only puts its reference to KVM after destroying all bindings.
> +	 * I.e. reaching this point means kvm_gmem_release() hasn't destroyed
> +	 * the bindings or freed the gmem_file and can't do so until the caller
> +	 * drops slots_lock, so there's no need to verify the file is live.
>  	 */
> -	if (!file) {
> -		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
> -		return;
> -	}
> +	f = file->private_data;
>  
>  	filemap_invalidate_lock(file->f_mapping);
> -	__kvm_gmem_unbind(slot, file->private_data);
> +	xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
> +
> +	/*
> +	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
> +	 * cannot see this memslot.
> +	 */
> +	WRITE_ONCE(slot->gmem.file, NULL);
>  	filemap_invalidate_unlock(file->f_mapping);
>  }

Besides fixing something, this does make the code simpler :)

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
