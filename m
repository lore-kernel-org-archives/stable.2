Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265905;
	b=4mex60sTPLda6g2J7823jahaArL4D88secf67lTRN5GV8FN3fS9nuSH+Om9BOzwhgEvE
	 ES/pdXUvT616lZi0giJ1XFgkjiwvsDiK6jHjTIVE5P5YpQhZgis4iO4PsJnyEk7eumhsK
	 tDFUTkyiuclh4Z57L+wqTTuX2QiBv7ZXAdrMSp7d+ZAqvMCx5R8m0X0+tXQ7do+5g7apR
	 mUNVpGkf6o5ijZCJMS70o7NOKFGVWRj7EXFbZLPTJ4huQ3cEyrno89JH+Jb1eKOOv/ISP
	 cjpuhgACI0sRyswDGzOloQtVcstZ/bzUgoYG1zTJckb1qq2xTYAPOGyLLPzZpHkL29g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265905;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=KWZoO9rTi5LeBDLEFn7Prw9ze5tRvH03ea2SqG7ELuA=;
	b=3sPJF2kbHvoaLcjPdodVBLC3xycCGqgiak2CkiXTZrH7NgB8eMt6UQUY+Y0AzDgQHxLz
	 3zRA68ourHoP0SXnnNNd7u3sHLz5IETU6d8s0me4Zz+9ptqO9Bv1wJwi1IAmG2C/l5VhN
	 yzP88ESyVxJQpCenhTULG7ws+9KDA7YuU6uuxyOurQ59Sb+bsPdLZ/LFeuRk0GsjgtNVA
	 1skb/KJVl4d44lDDLeph66cSWSmidQtphjkM3NKhzLERhPpQCRo3SJvjBJxUAGbjuVato
	 dbADRy/a4evq8PxCnZFA4i9j+bQSYz4IQoET7+FA4lrqtIQYX55ro2aFYXPllwhC2DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B/pG3fni";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E05606A320;
	Sat, 21 Nov 2026 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/pG3fni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0A31F000CA;
	Sat, 21 Nov 2026 12:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795265905;
	bh=KWZoO9rTi5LeBDLEFn7Prw9ze5tRvH03ea2SqG7ELuA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B/pG3fniaxxJtIF96UG01f/whnfvZtNlQ7eLkMd6pxK9R+uze+sqQXMGujcXI/95F
	 7fzCutN1ujq6Q2FLlclk44wC/PbAwOSrCVHMriLrDdSQ2dwAq5AQYKeYfVk+tvT3Jx
	 xJAR/s0+lijobTZSfac9mrHItTHUB7aRFzy95hIXqGU9b6d5FFjlo8h/dmKSgVdl+J
	 qCTS2fOd4fM/FVmUk3bncn/B4b0mfYXAkZzjjo6EKOMn+eOkNMLBvdKaOkzKSAhTo/
	 GrpISz7UV3F5zVXHx9a7fnOVhfZre8lx2nUcnBezAWpF46NwiTwWNPORwnm2HyHwSZ
	 R93MGnsWLVwDw==
Message-ID: <60b9b869-e1a0-40fd-a77c-821ac16f6bca@kernel.org>
Date: Sat, 21 Nov 2026 13:58:21 +0100
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
Subject: Re: [PATCH v2 1/3] mm/ksm: do not inherit ksm_zero_pages counter or
 PTE markers on fork
To: "Xu Xin (vivo)" <xu.xin@linux.dev>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
 donettom@linux.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20261120074230.40269-1-xu.xin@linux.dev>
 <20261120074359.41019-1-xu.xin@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261120074359.41019-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 08:43, Xu Xin (vivo) wrote:
> As documented in Documentation/admin-guide/mm/ksm.rst, ksm_zero_pages
> accounts only for zero pages actually placed by KSM.  However, the
> current implementation wrongly accounts for forked zero-page PTEs as
> KSM's contribution, inflating both the child's per-mm counter and the
> global ksm_zero_pages counter.
> 
> Originally, commit e2942062e01d ("ksm: count all zero pages placed by
> KSM") marked KSM-placed zero-page PTEs with the dirty bit for unmap
> accounting, but forgot to clear this marker during fork().  Later, to
> prevent ksm_might_unmap_zero_page() from underflowing the counters on
> child exit[1], commit 4d6fc29f3634 ("mm/ksm: fix incorrect KSM counter
> handling in mm_struct during fork") kept the child's inherited per-mm
> counter and added it to the global counter.
> 
> Instead of inflating the counters, fix the root cause by resetting the
> child's mm->ksm_zero_pages to 0 in ksm_fork() and clearing the KSM
> zero-page marker via might_clear_ksm_zero_pte() when copying present
> PTEs in __copy_present_ptes(). With the marker cleared,
> ksm_might_unmap_zero_page() will not decrement the counters on child
> exit, MADV_UNMERGEABLE in the child will not unnecessarily unshare
> inherited zero pages, and the global counter remains untouched.
> 
> [1] https://lore.kernel.org/all/53a7bf3d-843d-4e19-b0a3-cc6852fe72c1@redhat.com/
> 
> Fixes: 4d6fc29f3634 ("mm/ksm: fix incorrect KSM counter handling in mm_struct during fork")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
> ---
>  Documentation/admin-guide/mm/ksm.rst |  7 ++++++-
>  include/linux/ksm.h                  | 18 +++++++++++++++---
>  mm/memory.c                          |  2 ++
>  3 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index c329ca747b8c..8968ae3f55c0 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -214,7 +214,12 @@ stable_node_dups
>          number of duplicated KSM pages
>  ksm_zero_pages
>          how many zero pages that are still mapped into processes were mapped by
> -        KSM when deduplicating.
> +        KSM when deduplicating. Note: on fork(), the child process does not
> +        inherit the ``ksm_zero_pages`` counter, and any inherited KSM-placed
> +        zero-page mappings are converted into ordinary shared zero-page
> +        mappings. Consequently, these mappings are neither accounted for in
> +        the child's counter nor unshared when ``MADV_UNMERGEABLE`` is called
> +        in the child.
>  
>  When ``use_zero_pages`` is/was enabled, the sum of ``pages_sharing`` +
>  ``ksm_zero_pages`` represents the actual number of pages saved by KSM.
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 596c04ca7326..62fa8ca803ed 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -32,6 +32,15 @@ void __ksm_exit(struct mm_struct *mm);
>   */
>  #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
>  
> +/* Clear KSM's marker on zero-page PTEs (e.g., on fork). */

This function would be better called "ksm_fork_pte"

Drop this comment and instead ...

> +static inline pte_t might_clear_ksm_zero_pte(pte_t pte)
> +{

Explain here *why* we are doing this.

> +	if (is_ksm_zero_pte(pte))
> +		return pte_mkclean(pte);> +

But I'd move the check into the caller and only clear here.

IOW, the following on the caller site:

diff --git a/mm/memory.c b/mm/memory.c
index ad5511b2e949a..ee4545a181598 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1184,8 +1184,11 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct
vm_area_struct *src_vma
        int err, nr;

        page = vm_normal_page(src_vma, addr, pte);
-       if (unlikely(!page))
+       if (unlikely(!page)) {
+               if (unlikely(is_ksm_zero_pte(pte)))
+                       pte = ksm_fork_pte(pte);
                goto copy_pte;
+       }

        folio = page_folio(page);


-- 
Cheers,

David
