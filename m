Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515411;
	b=ld1EbgqRRqHJRBQ54+8izD5c3RumldKdCWXiQ7heON1kcNEapG9jL/daQpgJGsVtsHQu
	 MNefk3nYGEzRJYij6c3UNg2StaOe81wtzTkYXwJC0GdLYykxHVFC1UDsutSxQEwPKLSsr
	 ssPICXVv1WBkQxg2OU/97P7L1N5wh/7/iqOPs+2cFLNiCbAZYSUcAiAT0wtfJDHc1TtKD
	 IbtiN/q5ddTagVYcPlJg4xnZfrGPbKve/JwMT1/BB/e/6OjGkXMZZciBWGYt+FgXPgQKi
	 owkp9C477GSpO7nVgCdWbT7eSWzrwXEDtWQqw2jLDZtBPfwVY6Ve/4TAFQA8cCEstYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515411;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=E5VcegxzmZ/j3G8DjuvGctUHdtXTIRof2+VL5bxBoqA=;
	b=M8U0P9ARCwuJ2ZqeEr7mUfyLmpIbSxd2oaNLtUddqg1f9aS0WqRjYwgx73M/zbzQxr+W
	 qKexCO7DlTVbChheqISFlLrilHD3s3/gmae0WreGiQAOTUO6GMXxtcjGaJ3ummlCNBhws
	 Gm6mRZfHImiAyjejiHHC0gG04cSCQa3Nc+8W4R5Wz/QhoaBxIuHi5ro7lKhn5hhEWr02u
	 9QBUp5dkSXO69fFBKhjyMQHIpbmwk89BDcLNkXfrK56zgFCubrbNPFOXF/Sf5z/X5No0m
	 9RQ3jPWgfJdrMZ8RVoDcfwSt1ZNELCuZ2SL6w3n5l8TQ//oMSJD2hknK5DgBsU8hwdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Lf+l18u/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A975606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A975606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lf+l18u/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794515410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5VcegxzmZ/j3G8DjuvGctUHdtXTIRof2+VL5bxBoqA=;
	b=Lf+l18u/ukNGVgWJ+qeHY1u06+OX0ukgBz8zw6Qt/F+xzFFHKQscoNmY3BD8l5UYI22iDF
	RiPIXBYL+gGp+1ijCQwjHxH7zkjT9aOgEMw466l5Sr9SRB1wLA9wqFvEFisABmPg5JjcXz
	BD+gXJMjdtSMu76be3pV71/n0IpZyzY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-3AWA5Yd9MuyD1p_fiqFvMA-1; Thu, 12 Nov 2026 15:30:08 -0500
X-MC-Unique: 3AWA5Yd9MuyD1p_fiqFvMA-1
X-Mimecast-MFC-AGG-ID: 3AWA5Yd9MuyD1p_fiqFvMA_1794515408
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-54af6c38092so1633231cf.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515408; x=1795120208;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5VcegxzmZ/j3G8DjuvGctUHdtXTIRof2+VL5bxBoqA=;
        b=2teuHCPJHR2ZGmYBF33waJ6JsfU/IvCRcY1M5bjqSwGWPE3mVIUQXuUTp1tcTFdUUa
         HVU7G/AQ7H6DFcQYMAIRUIqE2c3jOSWWslPTEWQA2zaZMuCPElvzQkWLwf4hVCWDBXYk
         BjSY5kZecxcoPZneOEOBSJAjeTMIWMw15cx3G8bVY0kYwHD2GFxZVhinaIKzaxSUHbeH
         k61blOVTXR/KkDso77Ji0jznvfc0kEbUMR2wHbJXDpKvvifqXOizFZnSZSVlnZNgxPKc
         Zz+OtVmAuL21oH6SyAAO7Wrrz2j6eHVeTWcRHi3cv0VjfYIF7Z2VyDqHcCjqikRwCXmA
         QPBw==
X-Forwarded-Encrypted: i=1; AL+hErFCwGuCKm/Am0YwxowDFeGo1Yvpwy1HYkD7wuHkesmGczGwo88oDYnsHAVQujd9nARKdruUYCI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qUMfXDNxU8H0gNjeixsRbanGWkEpdb+xNy+pDZbZ51bzrucW/
	SIfp7W4DKUkmXeBv7w7g94R4L40RYaMBX6yRnJCfuYcEFAzQTU+GT9xBbKLwOGSZqrTmWb5AIVH
	b2vcI3cEh9slwcQ9lYSUxzJ3zQ/0/W4uxtUGdHDDSp0x9uoVX9ECr53EnWA==
X-Gm-Gg: AYBFou0edvXAzK7t4UTr1SgpolMvfzey3EZ728/kFInpJfodLmCZp3d0dbMJU5qazNn
	wFCsn04zLoOT1cpGEi7FPhoj6uyaLsSKXkMnQKIjk8Jf+6tKkKHirwYNOJix8sgaWwRheYdn0N2
	ljXd0Fv+JWqHmQpv2RW3NQORLFzP/vD1NfS7pIK2rjmiqSpnz/u2xCgDw1343uZud9tLOpCBtUh
	qbpbHZfz1l1JGTnleNc4AdygF/O/dSz6ad8rsqkFrptNGE96CmNgF+qeRSzTi/ueehuXYt0Th72
	gD/4bypk6CP2I7ozK0tkCAWzeOxO7zu3pD3mYXau/8ooY6j0MabCHvhb5bvcN4UMOa6Dhe4wtja
	pwhrunqfdK+yBMNASOs9dS1JIPqYYFPMWnbR8t3gTQqJb0NUrMs4oNIiM4GWoRbeT3gb/S0vjZR
	+qZDpywhLk4XjIP7DzzdyxMw2GPdiTs+n9H5NKVxCtNQ==
X-Received: by 2002:ac8:5c85:0:b0:533:42e0:a1ee with SMTP id d75a77b69052e-55ac8280f20mr9223671cf.37.1794515407667;
        Thu, 12 Nov 2026 12:30:07 -0800 (PST)
X-Received: by 2002:ac8:5c85:0:b0:533:42e0:a1ee with SMTP id d75a77b69052e-55ac8280f20mr9222281cf.37.1794515406975;
        Thu, 12 Nov 2026 12:30:06 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0107w-grc-07-174-93-165-160.dsl.bell.ca. [174.93.165.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23c9dbd2sm4281656d6.4.2026.11.12.12.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 12:30:06 -0800 (PST)
Message-ID: <050fed04-ad02-4d63-900e-3cab46a03db8@redhat.com>
Date: Thu, 12 Nov 2026 15:30:05 -0500
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
Subject: Re: [PATCH 7.3.y] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>, "Liam R. Howlett" <liam@infradead.org>,
 Jann Horn <jannh@google.com>, =?UTF-8?Q?Jakub_Mat=C4=9Bna?=
 <matenajakub@gmail.com>
References: <20261109200136-failed-7.3-8146c6478224@kernel.org>
 <20261112031021.1419377-1-sashal@kernel.org>
Content-Language: en-US
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20261112031021.1419377-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/26 10:10 PM, Sasha Levin wrote:
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
> [ sashal: Replaced vma_can_merge() and vma_is_fixed_mapping() with equivalent flag checks and is_vm_hugetlb_page(). ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I tested this against the in-tree reproducer, ran the MM kselftests and
the vma selftest, all is good:

Tested-by: Luiz Capitulino <luizcap@redhat.com>

> ---
>   mm/vma.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index e382fd32f0fff..9863668b9d6bc 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1882,12 +1882,28 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>   					struct vm_area_struct *vma,
>   					unsigned long delta)
>   {
> -	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
> +	const bool can_merge = !vma_test_any(vma, VMA_PFNMAP_BIT,
> +					   VMA_DONTEXPAND_BIT, VMA_MIXEDMAP_BIT) &&
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
> +	VM_WARN_ON_ONCE(vma_test_any(vma, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT));
> +	VM_WARN_ON_ONCE(!vma_test(vma, VMA_MIXEDMAP_BIT));
> +	vma_prev(vmi); /* Reposition to start of VMA. */
> +	vmg.target = vma;
> +	if (vma_expand(&vmg))
> +		return NULL;
> +	return vma;
>   }
>   
>   void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)

