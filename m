Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DD391E4E;
	Thu,  6 Aug 2026 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033172; cv=none; b=P0yTxLYqntU2GV0UoMFohMNunr7T2+g+1k7DR6HMYaCOKAckB+D10QBx6DAWsnQ2TKb3VAcpSWCzPNYPeu2ycCMCHIr7mZEk4V29M8AGbjlCEmV6pwMKEbBlUGiyWpIrrrJMR8GTYvhWsfnqQWxcEhenE56eO2j4kRe4A2M12vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033172; c=relaxed/simple;
	bh=vrZyDYEM1OcMEibhu6RE+3IJgS857AmWUKRmjA7ctMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5cq8IcsKMH5pbK5hsDhs0+T/MXyYoQJNNAkxN1eQYOncKvjJldRFGCcH8m64PTou+aSbGrptvgplUmJLg6WndqK7shENOIbsmOKsHEY6HZiRye0Qmv8oL0H32sjLj7eSu1osam6G4bILWA2q/UhSt/gUVjrrKqTie5lY8lrMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVMqoUR7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVMqoUR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBAD1F000E9;
	Thu,  6 Aug 2026 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033170;
	bh=0QPBNhSSVOZyz+OIXJH4NAAN8xAfuyeE6tVMmrlOwqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HVMqoUR7jyI1x5GfJqW6ghPpKJBZUnJkWRTqjmafA81stRol0LfIpVqXZQCSUO1nx
	 lnUSE4m8vB8xg83HDUO8ji0CLXBY0BeefD+wYHjoP1o8MaL6zk9tleDmSpV9N4+0Wr
	 +4ApPrT5JR/1Sw2EUM8PP0SsVr0y7+CcPjx2WuvqmcJ0LsJC2rPBLEtnuRUlRx5fd5
	 Bcb4G08Aysueg4NJLOHWJXnOeR8PBEvZHTqAPCMGafO+h2XqqdCGKR9d533JJefeVT
	 GMO/EZv041ylqOCF0X7SWXK+dj3ebQB+iihJu4Yy/Tk4wKpu0Qa29oBaKSqWbBUlKf
	 7GSAPRr8vTdIg==
Message-ID: <0bd6d355-e6d9-4f5a-b101-9a041c2a2436@kernel.org>
Date: Thu, 6 Aug 2026 18:19:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805055544.1568534-1-clg@redhat.com>
 <anL-NZkNMSSxN0YN@lucifer>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <anL-NZkNMSSxN0YN@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> From d6537260722c8741586e6295c8eea68d06087efa Mon Sep 17 00:00:00 2001
> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> Date: Wed, 5 Aug 2026 11:35:13 +0100
> Subject: [PATCH] ideas
> 
> ---
>  mm/huge_memory.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index abc65d608c23..5fa01364f089 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -111,6 +111,34 @@ static bool vma_is_special_huge(const struct vm_area_struct *vma)
>  	return vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT);
>  }
> 
> +static bool should_obey_thp_file_tunables(const struct vm_area_struct *vma,
> +					  bool forced_collapse)
> +{> +	if (forced_collapse)
> +		return false;
> +	VM_WARN_ON_ONCE(vma_is_anonymous(vma));
> +	/* Huge PFN mappings allocate no folios so the policy doesn't apply. */
> +	if (vma_test(vma, VMA_PFNMAP_BIT) && vma->vm_ops->huge_fault)
> +		return false;
> +	return true;
> +}

If that's sufficient, then this is is the better direction.

> +> +static bool can_thp_collapse_file(const struct vm_area_struct *vma,
> +		vm_flags_t vm_flags, bool forced_collapse)
> +{
> +	/* Override THP tunables? */
> +	if (!should_obey_thp_file_tunables(vma, forced_collapse))
> +		return true;
> +	/* THP=always? */
> +	if (hugepage_global_always())
> +		return true;
> +	/* THP=madvise? */
> +	if (!hugepage_global_enabled())
> +		return false;
> +	/* Has VMA had madvise(..., MADV_HUGEPAGE) applied to it? */
> +	return vm_flags & VM_HUGEPAGE;
> +}
> +
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					 vm_flags_t vm_flags,
>  					 enum tva_type type,
> @@ -188,9 +216,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  		 * Enforce THP collapse requirements as necessary. Anonymous vmas
>  		 * were already handled in thp_vma_allowable_orders().
>  		 */
> -		if (!forced_collapse &&
> -		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
> -						    !hugepage_global_always())))
> +		if (!can_thp_collapse_file(vma, vm_flags, forced_collapse))
>  			return 0;

I played a bit with that and came up with the following. Not quite happy about
it, just for your inspiration on naming and what to split out.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a00df56a68b57..8ba77608959d4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -111,6 +111,54 @@ static bool vma_is_special_huge(const struct vm_area_struct
*vma)
 	return vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT);
 }

+static bool file_vma_honors_thp_toggles(struct vm_area_struct *vma,
+		enum tva_type type)
+{
+	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
+
+	if (forced_collapse)
+		return false;
+	/* Huge PFN mappings allocate no folios so the policy doesn't apply. */
+	return !(vma_test(vma, VMA_PFNMAP_BIT) && vma->vm_ops->huge_fault);
+}
+
+static bool vma_thp_toggles_enabled(struct vm_area_struct *vma,
+		vm_flags_t vm_flags)
+{
+	/* THP=always? */
+	if (hugepage_global_always())
+		return true;
+	/* THP=madvise and actually advised? */
+	return hugepage_global_enabled() && vm_flags & VM_HUGEPAGE;
+}
+
+static bool file_vma_forces_order_0(struct vm_area_struct *vma,
+		vm_flags_t vm_flags, enum tva_type type)
+{
+	const bool in_pf = type == TVA_PAGEFAULT;
+	const bool smaps = type == TVA_SMAPS;
+
+	/*
+	 * Enforce THP collapse requirements as necessary. Anonymous vmas
+	 * were already handled in thp_vma_allowable_orders().
+	 */
+
+	if (file_vma_honors_thp_toggles(vma, type) &&
+	    !vma_thp_toggles_enabled(vma, vm_flags))
+		return true;
+
+	/*
+	 * Trust that ->huge_fault() handlers know what they are doing
+	 * in fault path.
+	 */
+	if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
+		return false;
+	/* Only regular file is valid in collapse path */
+	if (((!in_pf || smaps)) && file_thp_enabled(vma))
+		return false;
+	return true;
+}
+
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 vm_flags_t vm_flags,
 					 enum tva_type type,
@@ -183,27 +231,8 @@ unsigned long __thp_vma_allowable_orders(struct
vm_area_struct *vma,
 						   vma, vma_start_pgoff(vma), 0,
 						   forced_collapse);

-	if (!vma_is_anonymous(vma)) {
-		/*
-		 * Enforce THP collapse requirements as necessary. Anonymous vmas
-		 * were already handled in thp_vma_allowable_orders().
-		 */
-		if (!forced_collapse &&
-		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
-						    !hugepage_global_always())))
-			return 0;
-
-		/*
-		 * Trust that ->huge_fault() handlers know what they are doing
-		 * in fault path.
-		 */
-		if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
-			return orders;
-		/* Only regular file is valid in collapse path */
-		if (((!in_pf || smaps)) && file_thp_enabled(vma))
-			return orders;
-		return 0;
-	}
+	if (!vma_is_anonymous(vma))
+		return __file_vma_forces_order_0(vma, vm_flags, type) ? 0 : orders;

 	if (vma_is_temporary_stack(vma))
 		return 0;

-- 
Cheers,

David
