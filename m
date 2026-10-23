Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779115;
	b=VRISH1ztxMKQzl9vuzuMyQ63bjl0qvbPjxw34/GnMJReFVOQJ/TfxUV4fytAkLdRm7oo
	 t48lHbuqrC00xpeF8HdfRoEQahmK4qTt31VxVWD61SS/yPyABsFIUNLM9CLDGfBhNh6lz
	 XffRm+O0N9TQuBHafq5maQlpR2LfULMWb/jBz597775My7uu4NNAT8fYZ0ugygMkxduTx
	 QUY3RXpehoSscmlz/o+4a2MBL2Nr2joJIkD+WjIzm5qX877O0GHfA6unOGiq+m/B8HYHg
	 oguWjNi8Yu7TLMQv0NU5lGp3624cuADYGqe1h+Rb3bfvaR/mfMtf5F2kKCUhlCfC0AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779115;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OER7OiM3baakXk7yT31L3dFSCqe76IjxgAS+7zkqevo=;
	b=ikYxBilYcq6HY2GFyo/71QhcHtUTzNvsUtgIQCyGvB2if0ePsfA+CqOl247ASIklL4V+
	 1NfTFhKn7Kso1fQCq1hWsu3mpASLOPkn5PcqG4MWLbG6mHb6L2Tu9a9qeyaIKTFUJ0T7X
	 Mq2GVljSAF4jnUnXnNT/HZxZH2+Sq5nt+BiI/sZE5W/1SPF9He3DidseBKnpMhMVpE0CD
	 cTJQQsNm2NCJ6SfG7CND+wVVcW/3h8C5x0DrajnMgp99vUV502S0AoW/RTxCQ58JZ7WQf
	 v+9nIPClatH2HPw5mQuDCipxuo7B64DqpJbuEH7kB4EDm83EPOSDEhJ8jEhmI9je1Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gsIGjhEJ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539C606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8539C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gsIGjhEJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792779110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OER7OiM3baakXk7yT31L3dFSCqe76IjxgAS+7zkqevo=;
	b=gsIGjhEJ0NCpv59Fnn5zcqROdV+z6IrIxDGefu8Jkgl5LGzrPORbx0LYTRwTD7L+VqCH2z
	JiUevaxvvymP1k8tF/ravbT/MEkgYjjAStkHXJNhcorEXa7iTEFecRoaRdqo4qdgJhkfT/
	MZbEd+ggFqvmm+MO4vjkZCbkF+5rVIU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-jRJaW2BUPOOtVulH3eZLtg-1; Fri, 23 Oct 2026 14:11:44 -0400
X-MC-Unique: jRJaW2BUPOOtVulH3eZLtg-1
X-Mimecast-MFC-AGG-ID: jRJaW2BUPOOtVulH3eZLtg_1792779101
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-537548b8342so7326801cf.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779101; x=1793383901;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OER7OiM3baakXk7yT31L3dFSCqe76IjxgAS+7zkqevo=;
        b=Dvm8ZnPpF6eUxKgphcHR3VGgIeFH3b2S08UyfNNbSu/rrE8xVS9CoOmUU9TY3gX2JK
         iNeTTH0Ma2WSLFB0L65Q6baqPHqKRimFFAMt/tCSMlpqZKKqcHL+qwvH/bPTSTEwC6kx
         7LImkqfeUg1A+j4Tco6Z5Uk+adF1mFKYTqxmIzLt8AormfWMA9FP+081iC9ZI9TipxaC
         9MHvmNzKmVUGowkOxV81aevkfd015DPDIzOvt6UtEnKbUdm6b50nZdTebEzTRTmvFVTu
         cGNnH7Nuofvb8CdxIK9Fx1iVapiibqUUo2v8Q5PVYHPqk36o5jNUlPOdyJq/MFNOku00
         2u1A==
X-Forwarded-Encrypted: i=1; AKwUvBwy7XsmvOVQvz8RzYx9jKNARzsCPsKYLMvJ05SbPgPvV4u1yWMF4XO+t5+k583y2t8kzK9gNvM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLk6bDExlgURY7Vmrhcy60vg3gYmvWP4+iufN5OOfn8L2cuNmuC
	MEzUKjQbPbklM4K4CYFUGfaXiJ1x4cEQOM9d0uFNUSM90b//vLdHbEZQTEQi3E2fHe0jx36k+yK
	JeSYPdSo6j1YatkY17EJVFBbUg/ylhasN0QlfNkQgJ3Sn7Se/jw7Q2ho/Rg==
X-Gm-Gg: AYBFou0K1ELBx0iv9fTjpMu9paqELGEXDUodjtqbIkTwywn3ARe9QOEEoxwsRW2TZNY
	yQCO/VwR3W9N0eg2eqiUMsVWGv8uphiCj29sSBrseFCghNXBhQYVWeJJ/RA9ifjebrk5nDQWpwa
	fU35ZcfkrZ4CyXoShn6+SamOgvDnSO1Lkyo03F+aCsC5qNnrowwuxjYwz55YGK4FuvY8aYR1Z7P
	8nE2QCZ1uGSb6I0VC4HqYMHQpjmtmLHAG23nT04xMM9oEkDbI4UEeq8D1GsELEKOmdyE1NcKN6d
	Gpr9emuHRryqrZ2/fBd+Sr4Niu37FpBObe0PeKLL2IuRjwux2x1lBpjnh15ulVSkC8CmxQ3BRaK
	2EQQ=
X-Received: by 2002:a05:622a:1394:b0:536:cda:d3b0 with SMTP id d75a77b69052e-536c2923e1fmr44456881cf.75.1792779101127;
        Fri, 23 Oct 2026 11:11:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1394:b0:536:cda:d3b0 with SMTP id d75a77b69052e-536c2923e1fmr44456341cf.75.1792779100422;
        Fri, 23 Oct 2026 11:11:40 -0700 (PDT)
Received: from [192.168.2.110] ([142.172.30.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c5273sm448581cf.9.2026.10.23.11.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 11:11:40 -0700 (PDT)
Message-ID: <44a9f234-aeed-4986-8660-608b8a23ecdc@redhat.com>
Date: Fri, 23 Oct 2026 14:11:39 -0400
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
Subject: Re: [PATCH] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 =?UTF-8?Q?Jakub_Mat=C4=9Bna?= <matenajakub@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org>
Content-Language: en-US
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/23/26 11:17 AM, Lorenzo Stoakes (ARM) wrote:
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
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20261023023106.515365-1-luizcap@redhat.com/
> Fixes: ca3d76b0aa80 ("mm: add merging after mremap resize")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
> Confirmed that this fixes the repro and passes mm selftests and the VMA
> userland tests.

Thanks a lot for the ultra fast fix and for the attention you gave to
this issue.

I tested it the same you did and (of course) it worked. I'll work on
testing it on the environment that reproduced the issue originally, but
this may take a bit. I'll report back if there's anything unexpected.

Another detail is that I see that you CC'ed stable (which is of course
correct, since this reproduces since v6.1) but I guess this fix won't
apply since the VMA code has been changing a lot.


> ---
>   mm/vma.c                        | 19 ++++++++++++++++---
>   tools/testing/vma/include/dup.h |  5 +++++
>   2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 1be613044b4a..88ef92ab24ec 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1851,12 +1851,25 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>   					struct vm_area_struct *vma,
>   					unsigned long delta)
>   {
> -	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
> +	const unsigned long start =
> +		vma_can_merge(vma) ? vma->vm_end : vma->vm_start;
> +	VMG_VMA_STATE(vmg, vmi, vma, vma, start, vma->vm_end + delta);
>   
> -	vmg.next = vma_iter_next_rewind(vmi, NULL);
>   	vmg.middle = NULL; /* We use the VMA to populate VMG fields only. */
>   
> -	return vma_merge_new_range(&vmg);
> +	if (vma_can_merge(vma)) {
> +		vmg.next = vma_iter_next_rewind(vmi, NULL);
> +		return vma_merge_new_range(&vmg);
> +	}
> +
> +	/* Mixed mappings are permitted to be expanded, not merged. */
> +	VM_WARN_ON_ONCE(vma_is_fixed_mapping(vma));
> +	VM_WARN_ON_ONCE(!vma_test(vma, VMA_MIXEDMAP_BIT));
> +	vma_prev(vmi); /* Reposition to start of VMA. */
> +	vmg.target = vma;
> +	if (vma_expand(&vmg))
> +		return NULL;
> +	return vma;
>   }
>   
>   void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
> index f449129ea97a..e0eab4eca998 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1727,3 +1727,8 @@ static inline bool vma_flags_can_merge(const vma_flags_t *flags)
>   	 */
>   	return !vma_flags_is_hugetlb(flags);
>   }
> +
> +static inline bool vma_can_merge(const struct vm_area_struct *vma)
> +{
> +	return vma_flags_can_merge(&vma->flags);
> +}
> 
> ---
> base-commit: 2bba28e98578de622ef307d00875aa8f8bca3d10
> change-id: 20261023-vma-expansion-fix-6843391177c4
> 
> Cheers,

