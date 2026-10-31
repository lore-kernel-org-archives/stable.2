Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454020;
	b=TZoAMAur5dIaCPhsITYjpN3CMZQZc+9u4AGopDmVPBr0rHarXnDWZElBdjsyhzfmi7QI
	 mMuhW0qElaoSURIreJn0Lmk+vjVeDeCyPYkXkwekYZuusBxxvP5q98/CxUfvC/8p5VN0o
	 Kt1lwnqS+le2bn5uYwnj6zflRbHqc3ysTTXPn7sHBIVEJgI17yq1TJiUXdOZaxSKWv4gE
	 XRdNitKSRjPlVssyxiiCe4p3G0/ywChZTTQOsQEOKVtfa9i2kMX/WwkiBQTC0I7sqfN/u
	 rTm2zcR3JmVSa8gr2aCr0jZ0iWyB2DPs4noLnDzYTMOP3OKQsswUcbq6YAC/DCPl5/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AvdEESxqCoWismxl8U8najQ6zPeCJtfE4dKqVYiQpFs=;
	b=vJtVH6btk3xaI63J9kGJq/4hTVoNlfol8JdfTGLiKWXD7YZf76bJLh6lLiMPQ0WPwxex
	 +Y/wpK9ujm+mJWAKBP+GyBDg014IpvfBgAd9m7Ze940BQfADhmZNW3VFMqWeQ25xNGxGf
	 suaFjIRwbIrTVrX9VpDs8XAgeTnCV5rceNgqTpBhtvLo22AbBPmis8j1d+AAQrp+wjL2t
	 lDkGGxrca8P0U9+AzfX2r1xgSL6uWehUShmAih/GlD7bW3C2lbtD7GiGN9aCOf8hGe/w3
	 50i3RHa6O7ca8N7jTYhrpeU8lLD+iqDq2Lj/LUR2YLl/pyNRN9TvNyhqXzZXt/j7LCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O+63K5Nd;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1C606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95A1C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O+63K5Nd
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a210470b49so12679865e9.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793454018; x=1794058818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AvdEESxqCoWismxl8U8najQ6zPeCJtfE4dKqVYiQpFs=;
        b=O+63K5NdydWplMzH/C9VaKUseEdiFaniLRVS89CUSLTdJaUEt5FkpluCK0Mdo/SbGX
         F53SUcY3/2VT7VZcU5MdGVvuQLwMppgNmKMhVLAvO3ygY2zFnh0+J89VjcoL5W6vqjUH
         0eTZRRZAHr8WQNXmxV73/uW7tnqwkIwn2x475CU3S8oKZwxaQF2WXmp0OOG79L9ub8F/
         tlVB/IMzIzjQhOMec9v52q8e5n4lMSeoshtX5/6kfRdMy3ppPqqavrwEJMGsS0uGWekW
         8+fiAp3wilD58hUhtus6uf6Ybx51EwVg4U0xBcTIhqdvY7Fw+WJunyUoQ0KKW4kA0tDx
         NaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793454018; x=1794058818;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AvdEESxqCoWismxl8U8najQ6zPeCJtfE4dKqVYiQpFs=;
        b=YDnP8Odhl7CHDmjdKkw5+DH3lvTfnMg1mT/JrRgN+lu9ZRfqmw10YYU7YOnRuox3/L
         oqYfbSjoC6SFNF14mCUMKnq+Sy+T056/oqg8BlfvzwvRscJ2PFBESE87Hc6h+OD6J+z+
         VCptQ1i5kAz4DENnYr/EH3Ljb0XF8LIdMzBiU1VaUCy++LZFaD54a0oUD0K46gQIkJhG
         uW5xFSHbTakM54uWD47X4p5V8zXKqBSNqVgyjivdoIeLswKwXDG1WFWfrLzZIkZqspjb
         osUnrPVQMI6pL70L4jyAJFYsS9Y2vItQqI4Kvc4badtlaGmLxemZCE/DQBArYWo7XzWs
         v2iQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMsVfUL0+oYgzPFW0/FQf11NE08MRIRS7XUNXmozIqyHIRCsv9d1LfPCdQdjja0trbCmD6ZvM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHM+uPUv+fhZiVFTHV7VoB5gFmxcnbY87UkPDDpv7lCt913ymb
	pHH4rYc5uaG3txB/x7d9xVJ+FzOXyPQ7AhmNeLa0vWYWKqEFAAu7Ycl+
X-Gm-Gg: AYBFou3fo3hM369mVpi0F3lqneV+4fqY+VYEjXRrne4XvGw7t96jCAjfMX+9tdtWaJ5
	Z/aGvvZWvWw1nZMjsYGriTqf48d5iWz4gn34UkgNOEIU2CNtUn+C7+kIaFJtuUe2DxobGuciXPX
	LS2g4f3HurNgB65+6/mio/OzXQTufzuOko5gZ7506FqGyTLkLuMgxaj1+TBINBapUigejyaLXg0
	8SKrf211hduKfhYdWkMsGQpQekMlMlsPGCr7U+4gbNQe6ZKYPLZZo4ASLsi/NwMTuB9rkkX1UX8
	hVaaKViN5pse7UqbXeQC79aZypOqip0FGEnSEvuPU9EkPwJRuG+o6u599B0mp/t7B7jlU1MzhAH
	zVas5JsX/R+DwgrrQsVNPtS7EXO3yX+JdaqpdgNZ823r+1zgk1Cg42jU5X2ZemVMRb0vrmiE3v6
	PiqdoIljTE1v4Nx/zM16y/F4UpYsV/68W4Uz2wd0I+2yN4K3HaMjJeG4Crw2AdeTIp2TDf4rgbV
	/rcYMFQicj23kjGaM1IXVRrI+tfxIYxZWpqqhyEGmqZMxxp/0EiggDHv4KGFCAVdnHNn9mz5OJU
	rIqDYZLQHL01OzEx8MRe8L6n
X-Received: by 2002:a05:600c:c16d:b0:4a1:e00b:a0ea with SMTP id 5b1f17b1804b1-4ac150b204fmr125293245e9.1.1793454017873;
        Sat, 31 Oct 2026 06:40:17 -0700 (PDT)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm193004545e9.1.2026.10.31.06.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 06:40:17 -0700 (PDT)
Message-ID: <2c132a52-1118-4773-866b-a8c713c4933e@gmail.com>
Date: Sat, 31 Oct 2026 14:40:16 +0100
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
Subject: Re: [PATCH] userfaultfd: clear uffd state in child PTEs if uffd is
 released during fork
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261031-uffd-prot-bits-fork-event-v1-1-3572921c2111@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261031-uffd-prot-bits-fork-event-v1-1-3572921c2111@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/26 1:35 PM, Mike Rapoport (Microsoft) wrote:
> With UFFD_FEATURE_EVENT_FORK the userfaultfd context is duplicated for the
> child process, the child VMAs are registered with the new context, and uffd
> protection state from the parent PTEs is copied into the child.
> 
> If the parent's userfaultfd is released before the fork event is read,
> userfaultfd_release_new() resets the VMA flags but keeps uffd state in the
> child PTEs.
> 
> This leaves the child's VMAs in an inconsistent state: they are not
> registered with userfaultfd but their mappings carry uffd protection state.
> 
> If the child registers the range with userfaultfd again, the stale state
> turns into protection the child never asked for.
> 
> When a write fault makes such a PTE writable without copying the page, the
> uffd bit remains set and page_table_check_pte_flags() warns about it.
> 
> Split resolving of the uffd PTE state out of userfaultfd_clear_vma() and
> call it from userfaultfd_release_new() before resetting the VMA.
> 
> Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/userfaultfd.c | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 3b71712edab4c..2c11ac5dad3d5 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2220,6 +2220,28 @@ static void userfaultfd_reset_ctx(struct vm_area_struct *vma)
>  	userfaultfd_set_ctx(vma, NULL, 0);
>  }
>  
> +/* Clear the uffd bit and/or restore protnone PTEs */
> +static void userfaultfd_clear_ptes(struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end)
> +{
> +	unsigned int mm_cp_flags = 0;
> +	struct mmu_gather tlb;
> +
> +	if (!userfaultfd_protected(vma))
> +		return;
> +
> +	if (userfaultfd_wp(vma))
> +		mm_cp_flags |= MM_CP_UFFD_WP_RESOLVE;
> +	if (userfaultfd_rwp(vma))
> +		mm_cp_flags |= MM_CP_UFFD_RWP_RESOLVE;
> +	if (vma_wants_manual_pte_write_upgrade(vma))
> +		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm);
> +	change_protection(&tlb, vma, start, end, mm_cp_flags);
> +	tlb_finish_mmu(&tlb);
> +}
> +
>  static struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
>  					     struct vm_area_struct *prev,
>  					     struct vm_area_struct *vma,
> @@ -2239,22 +2261,7 @@ static struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
>  	if (start == vma->vm_start && end == vma->vm_end)
>  		give_up_on_oom = true;
>  
> -	/* Clear the uffd bit and/or restore protnone PTEs */
> -	if (userfaultfd_protected(vma)) {
> -		unsigned int mm_cp_flags = 0;
> -		struct mmu_gather tlb;
> -
> -		if (userfaultfd_wp(vma))
> -			mm_cp_flags |= MM_CP_UFFD_WP_RESOLVE;
> -		if (userfaultfd_rwp(vma))
> -			mm_cp_flags |= MM_CP_UFFD_RWP_RESOLVE;
> -		if (vma_wants_manual_pte_write_upgrade(vma))
> -			mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
> -
> -		tlb_gather_mmu(&tlb, vma->vm_mm);
> -		change_protection(&tlb, vma, start, end, mm_cp_flags);
> -		tlb_finish_mmu(&tlb);
> -	}
> +	userfaultfd_clear_ptes(vma, start, end);
>  
>  	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
>  				    &new_vma_flags, NULL_VM_UFFD_CTX,
> @@ -2353,8 +2360,10 @@ static void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
>  	/* the various vma->vm_userfaultfd_ctx still points to it */
>  	mmap_write_lock(mm);
>  	for_each_vma(vmi, vma) {
> -		if (vma->vm_userfaultfd_ctx.ctx == ctx)
> +		if (vma->vm_userfaultfd_ctx.ctx == ctx) {
> +			userfaultfd_clear_ptes(vma, vma->vm_start, vma->vm_end);
>  			userfaultfd_reset_ctx(vma);
> +		}
>  	}
>  	mmap_write_unlock(mm);
>  }
> 

reproduced the leftover bits in the child with wp and rwp on all memory
types, and they're gone with this. tested on x86_64 in qemu. LGTM so:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Tested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
