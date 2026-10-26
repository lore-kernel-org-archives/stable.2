Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011368;
	b=0FrOAUYzPM+kfOfutLncoyyIM9PldvLvYnrTg1RrPUapZQGkaT213LyEltE3ZkG/n6Rm
	 YyWPSI4WKJ0aR5vs2kATB/DV6QcKCwut3ERGKIq74Kwu2Kc3U10OeOBcqcsMs63aUZhnk
	 qPrqThEb5W3SCTl/B3LYKWUQ8t+UAqsOxXBvwTmVm+wuqSdtuiZQDw6TEDSePbhoHzn1I
	 LiomF40j1T9Puc5owoWlGfmL7NmQ9QvK05HPoLWP2Ho4Zej1Jpo9K/mlSf/hI90LTqT1M
	 M+GqVoqCtAgQKtZXzmcxtQnRtXTsRCvVkFTOtrj/Vn5JfW8lPlrwGT9865li4816Xwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011368;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=V1oXGc/qKdgvlq4aK/p6VII9u7yL3RrtIDfi2SVQ7v0=;
	b=xLiGP30DQ8NTxQB8zUToXRAlb64EXT5s7nKAEGfLMYTK0UH9yn2IG813o3jXChV8SQOG
	 m1aRIYw9uDsnFjZ03NlxtQ0dmcwmm31xi8pH7W9vgSrDm5868h/l+lfPPTZR71kmDbsxP
	 RCFRn48q7US0HFQvGVkUnw7wMvlBc+uc93ELTwPOOCpAeIbrin/STCIzuivHTvutuk92o
	 uXmdD57+3EI/pp6LzL3LrsFrW9dhva6kS2/tiDu7YaZ6zks/8bkRQxdX4k+L7GH2EjQiM
	 0Lk23KqYNyF28Uk9JMoLb/p638j0JIK/YHjOfY2v7JnkPX/tcgax+vKlxHfEUQMvJLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6NMn3g2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1BA606A31A;
	Mon, 26 Oct 2026 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6NMn3g2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A577A1F01825;
	Mon, 26 Oct 2026 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011368;
	bh=V1oXGc/qKdgvlq4aK/p6VII9u7yL3RrtIDfi2SVQ7v0=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=S6NMn3g2oAoGG5I0HTSjAWzwfo5Y4QhnSZOZciinMdMwZgCYiokH7EiuT6kiPatSc
	 rsfDt+cgcO09Qp2uGXCho9OrawV0Qoqlo4bUU9HL2sHKgEacvN8IKU8h9XsNX7KrjU
	 w1p8KUD8ExZ+c82/nVcNxROxnYEKVIQjSKLrQmeMTaatjdGrHplyvbHx+4M+JRwFXc
	 EruRBrpAzJbHIOd89Zxe1vINFSXbOkla974/NhJpM9MxvnAJG2mnJfmagDLm1A0/1Z
	 Qh6R58rgF8bVaGWXrIiZKRKTCgKuKVuD8l3qO6zS+/Sdotz1/m0txf3xsNRxoTRR2i
	 I3ItrLD1buxAw==
Message-ID: <24bb4c36-730c-4f04-9cfa-be096d4da9a2@kernel.org>
Date: Mon, 26 Oct 2026 11:42:40 +0100
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
Subject: Re: [PATCH 2/4] mm/vma: write lock source VMA before duplicating it
 in __split_vma()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, SJ Park <sj@kernel.org>,
 Kees Cook <kees@kernel.org>, Colin Cross <ccross@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
 <20261023-fix-vma-atomic-v1-2-8ff4fae1fc85@kernel.org>
 <20261023192627.yj5ltdj4fjzydblp@offworld>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261023192627.yj5ltdj4fjzydblp@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/23/26 21:26, Davidlohr Bueso wrote:
> On Fri, 23 Oct 2026, Lorenzo Stoakes (ARM) wrote:
> 
>> From: "David Hildenbrand (Arm)" <david@kernel.org>
>>
>> __split_vma() duplicates the source VMA before taking its VMA write lock,
>> and until the VMA is write-locked, a concurrent thread might set
>> VMA_MAYBE_GUARD_BIT, resulting in the duplication missing the flag.
>>
>> If this happens, then fork may fail to duplicate guard markers and, if a
>> file-backed mapping, THP collapse may also discard the markers.
>>
>> Resolve this by taking the VMA write lock before vm_area_dup() and, since
>> all callers of vm_area_dup() now hold the VMA write lock, assert that this
>> is the case there, and add a comment to explain why it's needed.
>>
>> Fixes: 2ab7f1bbafc9 ("mm/madvise: allow guard page install/remove under VMA
>> lock")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> [ ljs - add VMA write assert in vm_area_dup(), commit message touchup ]
>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> 

Thanks.

> ... with one nit below.
> 
>> ---
>> mm/vma.c      | 2 +-
>> mm/vma_init.c | 3 +++
>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vma.c b/mm/vma.c
>> index 1be613044b4a..aa59005e2f42 100644
>> --- a/mm/vma.c
>> +++ b/mm/vma.c
>> @@ -538,6 +538,7 @@ __split_vma(struct vma_iterator *vmi, struct
>> vm_area_struct *vma,
>>             return err;
>>     }
>>
>> +    vma_start_write(vma);
>>     new = vm_area_dup(vma);
>>     if (!new)
>>         return -ENOMEM;
>> @@ -568,7 +569,6 @@ __split_vma(struct vma_iterator *vmi, struct
>> vm_area_struct *vma,
>>     if (new->vm_ops && new->vm_ops->open)
>>         new->vm_ops->open(new);
>>
>> -    vma_start_write(vma);
>>     vma_start_write(new);
>>
>>     init_vma_prep(&vp, vma);
>> diff --git a/mm/vma_init.c b/mm/vma_init.c
>> index baa7e82f47e3..d661f229a734 100644
>> --- a/mm/vma_init.c
>> +++ b/mm/vma_init.c
>> @@ -127,6 +127,9 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct
>> *orig)
>> {
>>     struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
>>
>> +    /* Must hold a write lock to stabilise atomic VMA flags. */
> 
> should just say "stabilize atomic VMA flags".

You mean the s/stabilise/stabilize/ ?

I guess that's just the (uncommon in the kernel) UK english variant Lorenzo
tends do use.

-- 
Cheers,

David
