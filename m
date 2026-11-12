Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515487;
	b=cETWim5FApH+kOdfa3ZGNfxFhg5D/wzn2Z7G2bAWxS2++ETxwJV7ukvyNe57O8eePb2A
	 YswdgRod8r3OxgHn9ePB5oZsDwLfQ87SS0ZiijGLS9FUHBWoFX/pBW4gNd6GodDUX//1k
	 kkF0vIPUlAH3ucJc8PRRfqq4ALuQgzfVM0kas8iO5mRXXqU4X9HiG5d7nDDi/H2Q3QaMo
	 atqknvOWeozQgvxR8q9TMnrrvbsd2rJWRf6n452tPeNptS4Xj8o7vi6i8QALXe/fi5Wob
	 vWeP+xZUrfO4Pyo9rqwhBP2crS+BsLlzXiUV4/EN+AQk80eUpZXPU/e1h5BLi7sREsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515487;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EEYnyqtfBaZClIC1U4m99W9a2JEMKmddVi2EW2W9bqU=;
	b=i8xqzIFWfFiLrHqQ7Y8G/MvXOZ1oxTfKCjslrzdVylxy5wfkXetWv8R7UPQijXUHDQm5
	 pEL200PdsCzbwIjTe4aoX/rRdXQtdlTjLS/QQT9qjfuh6R6/catG8pI+3gSD5pJ1UQTB+
	 4J01JPj2QvKG8M8yF2q4Cg0LTXhHuPHWIpBcIULzTpUy6JbYsSJJzzRL3vqUux6RwHgWG
	 PbwJR7VwYfc+QZPx6mWW4n2LRM35zrhVUMvIh94/1ATNJh0t3mL68y2qMFfbztP00nT2m
	 GbRQphtMjIkNCQ7j460C1hTa80J+27aucfyiu1A/BfWiNQJlb6i0qpUJdbN+LjOBsmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cyjyY2OS;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E206606A333
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E206606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cyjyY2OS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794515486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEYnyqtfBaZClIC1U4m99W9a2JEMKmddVi2EW2W9bqU=;
	b=cyjyY2OSde4zKO80Vvi3MaC5UFXKjQpF5mddN0eBVoK7GpIPkXs0B8OHvq6b5KQp9g2E3e
	I3HEPexy7OtT99XlBcC2bRsfyCzivIbkNCVH8eJifmUJNjmR41RVpXY+ELQcWf0iKprzOh
	W2oJwnETgOClbXDB3X76qLvHIcIcj9Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-YrIaCe9jNnSANuyUe8Apnw-1; Thu, 12 Nov 2026 15:31:24 -0500
X-MC-Unique: YrIaCe9jNnSANuyUe8Apnw-1
X-Mimecast-MFC-AGG-ID: YrIaCe9jNnSANuyUe8Apnw_1794515484
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f33438950so32255885a.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515484; x=1795120284;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EEYnyqtfBaZClIC1U4m99W9a2JEMKmddVi2EW2W9bqU=;
        b=NKlE6O29R0+yNAN3BLMlto2jNjXCkE2iJAghR7bHqApY60XxzPsTKmsypIzkFylj78
         CjXlv0eiD049Onc/A4ymCZEvTRV3Y5iWn3aVd0q9y1GjO+cYNcylbPJgcxSj8Cb6SAxH
         aDrxo2luSM8LtapzH3sAfkitjSZe9dj0ogov7hOYGJ4Tlptk+bw+pJfS3/sZydCTw4sB
         OnfhgXmwQJ6q0VJMOzzGwV46dLRYNa1kxdt27SAjYoPYW6LHbdkjrHl23a0FPD0LXvtu
         EUXZX6F//SMthnz5Yy5cUPXsvSPxWn01tHmpGye7WRUAqXwexFSVAPQ1xSLXuH223zjd
         +8KQ==
X-Forwarded-Encrypted: i=1; AL+hErGluCHPfTVUP7NBgc5d6174m0cvC9R2aRp3tvZ28PSCo/qiSDL6xvwpgweIRZlSATyCSBk85pM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tl60p4TwP6TdM5YSyGsIBwCTRrFeQD9GPz+/Gon9ppPfN5313
	HisFwK/LiMDWDZ+lNWs7Bt0Vk7qWW+xcuMiMArp7u/OAwvbvQswYOVMYP7DOVe1nivlX69GjMUx
	zYMiZwlxv7IqKlRdHsD0i+drNFHLayvtoTAVeLHpGi5TgdclospqH7h0g1w==
X-Gm-Gg: AYBFou0MSN6juihg65yPu/LIdOuDc8aC463nKc4h5KyHwfl/8SUag0zYay6kAGxn6oI
	37jQ/UIXl/AxeLLYEOUpfFqRe70iBb6vo+4VB8i9mrvxcCQba3og+cNNRnTy5yaC2cqUpjFb06C
	Mu+ljNwAALqfQq3cmRgZyOfD4PQULKqsJz7tXDmkY5ex8McA/6eLQvXFZDEWc6IYjrSIYrXVbsJ
	9LL31hXzAwXk/bDqpJUhFxe3OGUtPNedTZTDn5AFy/HFTLncYVBtlvVFP/wPofdQiFM7UjFLu0g
	Q1OPZNOokP6k8kiNe0a6ieHTmRskDQAAJDi5NHnZ7GJ9if4762UbehL6Fn1d8VmQ79HDwhbDJC/
	8UxxLKla3ucfoFet4N2xoOTxcw8gLp8M4I3s3IOhWISO9tIjR+pKHra9Mli/4mOG3WsTWhX2aEf
	lrMlTsQvjAdIZL567VcgY2WwyCvrJxMSU6lKjmeMonOg==
X-Received: by 2002:a05:620a:298c:b0:939:4a44:5f99 with SMTP id af79cd13be357-9494b9432aemr102532485a.10.1794515484227;
        Thu, 12 Nov 2026 12:31:24 -0800 (PST)
X-Received: by 2002:a05:620a:298c:b0:939:4a44:5f99 with SMTP id af79cd13be357-9494b9432aemr102526285a.10.1794515483278;
        Thu, 12 Nov 2026 12:31:23 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0107w-grc-07-174-93-165-160.dsl.bell.ca. [174.93.165.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad14f1ecasm3009981cf.24.2026.11.12.12.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 12:31:22 -0800 (PST)
Message-ID: <60d486de-6205-4d5f-8a28-0ea9f4a43fb0@redhat.com>
Date: Thu, 12 Nov 2026 15:31:22 -0500
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
Subject: Re: [PATCH 6.18.y] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>, "Liam R. Howlett" <liam@infradead.org>,
 Jann Horn <jannh@google.com>, =?UTF-8?Q?Jakub_Mat=C4=9Bna?=
 <matenajakub@gmail.com>
References: <20261109200401-failed-6.18-8146c6478224@kernel.org>
 <20261112032559.1526093-1-sashal@kernel.org>
Content-Language: en-US
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20261112032559.1526093-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/26 10:26 PM, Sasha Levin wrote:
> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> 
> [ Upstream commit 8146c6478224d8f6395c6b08a19c344a56d79867 ]
> 
> Commit ca3d76b0aa80 ("mm: add merging after mremap resize") combined
> merging with expansion of mremap()'d VMAs, however it also unintentionally
> disallowed the expansion of unmergeable VMAs.
> 
> Previously it was possible to expand a mixed mapping which mremap() had
> already ensured was a legal expansion.
> 
> This is clearly seen in the mremap() logic, as it checks
> vma_is_fixed_mapping() to determine legality of an expansion rather than
> vma_can_merge().
> 
> Additionally, copy_vma() allows for a failed merge to result in a new VMA
> being instantiated if MREMAP_MAYMOVE is specified.
> 
> However, this is not attempted, as a failure in vma_merge_extend() is
> assumed to be an -ENOMEM failure.
> 
> Since vma_merge_extend() is used exclusively by mremap() to perform a merge
> and/or expansion, resolve the issue by invoking vma_expand() for
> unmergeable VMAs there.
> 
> Explicitly assert that the VMA is both non-fixed and a mixed mapping.
> This provides double insurance against broken changes in future.
> 
> Note that khugepaged_enter_vma() (which vma_merge_new_range() runs) is
> redundant in this case, as a mixed mapping is not subject to khugepaged.
> 
> Also update the VMA userland tests to add a required predicate.
> 
> Link: https://lore.kernel.org/20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org
> Fixes: ca3d76b0aa80 ("mm: add merging after mremap resize")
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20261023023106.515365-1-luizcap@redhat.com/
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jakub Matěna <matenajakub@gmail.com>
> Cc: <stable@vger.kernel.org>
> [ sashal: replaced newer VMA helpers with equivalent vm_flags checks using the existing is_vm_hugetlb_page() helper ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I tested this against the in-tree reproducer, ran the MM kselftests and
the vma selftest, all is good:

Tested-by: Luiz Capitulino <luizcap@redhat.com>

> ---
>   mm/vma.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 8669da66edc5c..6f9e3d0c2681c 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1770,12 +1770,28 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>   					struct vm_area_struct *vma,
>   					unsigned long delta)
>   {
> -	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
> +	const bool can_merge = !(vma->vm_flags & (VM_PFNMAP | VM_DONTEXPAND |
> +						  VM_MIXEDMAP)) &&
> +			      !is_vm_hugetlb_page(vma);
> +	const unsigned long start =
> +		can_merge ? vma->vm_end : vma->vm_start;
> +	VMG_VMA_STATE(vmg, vmi, vma, vma, start, vma->vm_end + delta);
>   
> -	vmg.next = vma_iter_next_rewind(vmi, NULL);
>   	vmg.middle = NULL; /* We use the VMA to populate VMG fields only. */
>   
> -	return vma_merge_new_range(&vmg);
> +	if (can_merge) {
> +		vmg.next = vma_iter_next_rewind(vmi, NULL);
> +		return vma_merge_new_range(&vmg);
> +	}
> +
> +	/* Mixed mappings are permitted to be expanded, not merged. */
> +	VM_WARN_ON_ONCE(vma->vm_flags & (VM_PFNMAP | VM_DONTEXPAND));
> +	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MIXEDMAP));
> +	vma_prev(vmi); /* Reposition to start of VMA. */
> +	vmg.target = vma;
> +	if (vma_expand(&vmg))
> +		return NULL;
> +	return vma;
>   }
>   
>   void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)

