Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515591;
	b=Y0LXgYJ4zXlM+QZ6veudzGX3M6BZzb5Ns1B22ZqhGqUmv8jnet2yIlGTnmli0tyJzXnK
	 3L6YEBaGujG//gwYh/u42hT9NHwaf1N62aZH0qYnZSWjk3fkPb4VMdo18JRBG4xBbpzHu
	 toQGn1RvW7Y31m8jMf1yVAvTdf5WnWJRk9WPN4k20BIPIzUfT5AAS/J8BkYvWCvS+U+SY
	 InYP6wm5HodxDBaayaCqqSwPt/JV40gw4s1aZk5mVPTdMXNOlqx8oVWvM87dUScnaftAw
	 Yu7LPW6jHTASYExW7c+R/CpLHeWLpsQBWX1vFrWddLyQHpF1uUi4p2TXo5h1/mMDG9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515591;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=q4ghQXKCFa04yWu48UZsh8QOtDBcMvdZhqrLqdjmBi4=;
	b=zeczLdMOD2cBGBgJ/RNaTIDABFFo8QI1UMXbB7rM/O7jZBHiuPtBDt4RBV2foYKRlpy3
	 9A0cuu2JkcAytoCgDeW8jeuzW0NuNuEzd+3/7xpphtBX1+dOyHnMu1rULjjdwWaRPVq5Y
	 cIigKRWr7qysajo6l8rVdVmlSZ7+uvMjGd+JOgGMT6Rdz31Sa7knml8tSxGGk0EXZyVq8
	 kQVXuPsLvMhfpkoaKewuzjz+yZNqIpFH0bQ9Qlmt1efMI7JBMAWwNYHf58by1CvMB2hhL
	 TcpALb4iC1fhYNj2VpzTsGjNdGu5zclWAlBgYihRZHNRKyEp3iHcDKzUFtrMBV/5GSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jGgOw51+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AA606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B59AA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jGgOw51+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794515589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4ghQXKCFa04yWu48UZsh8QOtDBcMvdZhqrLqdjmBi4=;
	b=jGgOw51+2RdRdGL02PDo6LEt+xAxx0EhuFnB161V7dndXuuqDJYF9auS6X7zIvciEyiO50
	3DwcvLdAppmtC36h4HkP2efc89rlq3/r0m53IiUjmNQ0D2D5v6weJQVaHfHs3pCDMavGsT
	nsfZXCYO+cPMvSoDu3fpQvt66y3ftOE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-qLkyBV5-ONCNMBe0QM6y9w-1; Thu, 12 Nov 2026 15:33:08 -0500
X-MC-Unique: qLkyBV5-ONCNMBe0QM6y9w-1
X-Mimecast-MFC-AGG-ID: qLkyBV5-ONCNMBe0QM6y9w_1794515588
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c8a517107so6218326d6.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515588; x=1795120388;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4ghQXKCFa04yWu48UZsh8QOtDBcMvdZhqrLqdjmBi4=;
        b=PLDhncBewqSQ+X8dwYvk6E+e/e8dLqtwUYeuJMh+FciumVzIepk29ZB9zbSdKUIdEl
         HHuhrN7WiK5Yk7D6lUEFhgXFjbhPLtJqmdjT+1oHLMn9Yn7VwLyali4TljV7xWcrKE8K
         v0HXYhie+PQ6H85w6gkF/WSg+N0kRZ/mIBkcDPzRPvPaqZDrgooBY/xOYyxkLngrAbr3
         wHZrOn6y/AdDMswfCyN2H6pn5TFRDjaI3wlcpHcKiCqx28Q8Xmnw2AP9ulw7x5dBwqry
         VfJRdwSACFODveqLWv+7p03dFFmMJx7srlv7r1omgoD+LalFB9/XqQOhA0/N9uqZFrad
         Y4tQ==
X-Forwarded-Encrypted: i=1; AL+hErGVSLw9payzeTbAdhTcB/FnhaVZCiGHsw/izMmO6I4VjGISw5Sr79yBMOGv2QMprfbWqsdw64g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QcH6+eTX84sO17Rozkr6qWesD5u5SlIAI8on/iWpJ3oqKalh3
	vfxtVVl3aUzSJJxm6hthicTNRACMhYjlngu/hF6eQEKlyovKvMtADSyIjRYgS06KHzPyUH3chQb
	TJeOFN4C8jSWRjeV8azSKmri/stmt/7g5mfqtoNN+T+1lzQH0iNN94Ez0fg==
X-Gm-Gg: AYBFou2EycTi6yztBIQgzOZYFb96vBCSJtQtVtcbwFrPVkMuVsA6rrvTF6+dDX1Ne5P
	eeClHoEeqpJTTWrn3Z4l6vuno2SE0olUpwL0IhXaeZMVZDRIHIsw2GLrXfWMLL2JBpFWxo4ltu8
	c0Nq+hz1xUELlchEQ6se2MpcI0RROIh1t/fqpy7z2OiWGRRZ9HoT3gT/1WFze5bL/zYbNCR0XMI
	8pU0JPKeDN/X09efufg6dSke9z2gjHmtev/IPQcxCVg2Z16vgOXQA1Ix9DcA3Mh39gH2qVOlf/Q
	b9aM7j/PrtexJ1f/v70Bx4uEX9aCa4tCthwkJV2HRGyVAQ4CYBHappWyM3GvfEIpp1d85ITxwLm
	iHwGIA5OWZF+a9Z6bPwo1Ujp71bCmf8uaxMfuP1A1klKd76hv8088TqoWLAdng31Ce1/hybPJSP
	RK7SXMHb10WfWPYtAejQzlLVDZmugjMLg1lYSCf0ZfIg==
X-Received: by 2002:ad4:5ca6:0:b0:91e:bbea:d1ac with SMTP id 6a1803df08f44-91f2400c646mr9368096d6.8.1794515587668;
        Thu, 12 Nov 2026 12:33:07 -0800 (PST)
X-Received: by 2002:ad4:5ca6:0:b0:91e:bbea:d1ac with SMTP id 6a1803df08f44-91f2400c646mr9367506d6.8.1794515587001;
        Thu, 12 Nov 2026 12:33:07 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0107w-grc-07-174-93-165-160.dsl.bell.ca. [174.93.165.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d70489sm4165136d6.21.2026.11.12.12.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 12:33:06 -0800 (PST)
Message-ID: <8920e675-8c85-4dbf-bcc4-0fba866faf6b@redhat.com>
Date: Thu, 12 Nov 2026 15:33:06 -0500
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
Subject: Re: [PATCH 6.12.y] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>, "Liam R. Howlett" <liam@infradead.org>,
 Jann Horn <jannh@google.com>, =?UTF-8?Q?Jakub_Mat=C4=9Bna?=
 <matenajakub@gmail.com>
References: <20261109200751-failed-6.12-8146c6478224@kernel.org>
 <20261112033709.1560178-1-sashal@kernel.org>
Content-Language: en-US
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20261112033709.1560178-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/26 10:37 PM, Sasha Levin wrote:
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
> [ sashal: Adapted VMA handling to use direct vm_flags checks and the existing vmg.vma merge-state field. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I tested this against the in-tree reproducer and ran the MM kselftests
(which I had to hack to build). I couldn't build the vma selftest:

Tested-by: Luiz Capitulino <luizcap@redhat.com>

> ---
>   mm/vma.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 66b0472b7d8a6..41cdf4199e715 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1544,12 +1544,28 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
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
>   	vmg.vma = NULL; /* We use the VMA to populate VMG fields only. */
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
> +	vmg.vma = vma;
> +	if (vma_expand(&vmg))
> +		return NULL;
> +	return vma;
>   }
>   
>   void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)

