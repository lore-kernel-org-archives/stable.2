Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA0439320
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513554; cv=none; b=GZJuyKlNoecS69QVsIZEDG2mNoHPhgxZpz6N9mJotEJtivWrXx2tIaTnoo7kNFd0LLgDWPQ5fnKHY4mitam4UF3vS+p6UNApbomBuHN5N0XsbAC1nuY28yhovcuZNC3jy63MAWFL1pksyy6RxLuWBA2AOffAFdOf8fK5TT8NPXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513554; c=relaxed/simple;
	bh=xZGgCIZfkbiaZ3mKB+pXGPhrIQ8GmBXoZfqIC1gKRfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hw5xVHzuznULww1uQoGWa2hEQpbjIFpsLx5OmbJi7Oo9nbWM71Du3OgF7HlOKxZKKFJc/8BMaQFnAk77nQwgnOLic4ZzCwHoCJh7LxZ/cAtIzhRrEFDlr0V8WyrQNtZ683NLcT/8EUW46UZE98nxFlPH2RH1Gyz2QtbQV/VA7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh0UUP4Y; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh0UUP4Y"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b4ba7fe26so168075e9.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788513550; x=1789118350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IKsY3e6buag+9infDZhzGxiVVp9SkZe5m1Iw//x/1Xg=;
        b=Uh0UUP4Y/d1uK8d8RLh5Tbjvi90ZDXZftuuZHOGJUZkXUmOV6FaqchNHMTLQtiE4FC
         XlmDWOxbETHPZu7V73wgFRBuD08KSShytGylgHssWQiiKyOqDP2vat2q6JvcmHcXKLt0
         Md8s1UhDezIDRcyz8rYba4tRRwBq/PIjsoGah/aiqvzon+RsefR2gFMLqbFPc3h587qO
         +KbAIfLOnarr8LlOQwfTqzEMIJe1TQt1KrJ/X9Cm20K/imKxc4paftc/a1Do4uj0DDQz
         rfwZmsrHGJiy+au0kqDiCczQWZHvmGQiqR4xtiAHSGE5X/fC2FZd9bYAi7hMhfTgimEu
         i6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513550; x=1789118350;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKsY3e6buag+9infDZhzGxiVVp9SkZe5m1Iw//x/1Xg=;
        b=tOYDdtgWbe1s6S7Xy/1LHn0+muJoBboGuINUWr/dFnMwcxKEjNtrnjoXtU7fBeD+av
         roBNGbh4jy0gkywlwd9fHuGxWDeYBqU/oEYlqyO3HxIkB3HFAr4yMwre5zvpgaR35H5x
         BMzzIHkn1uxZWV8tJDwFsktEamZwMBQs9k7mUqjakbgVQBuhCR3TS35c/X6fErM9DnoF
         r93Rg5urRBqtIZdbqy4PI2qAeS+UYc5iB02xdYozcMUlvbAKRIj47c7Fcy2QdkRzlKrd
         +jg3NhQfasStivBDWdeWIddP9eh1hnLIVxt4cAl730yG/dfqnrPlkWgqBZuJZgmHQGEU
         qXKg==
X-Forwarded-Encrypted: i=1; AKwUvBzY91x+EHUCeDLN7MYPo2JpvFvM9eZu76Ro93m1dVYYlEiyqiTpASiwm1XTijr5Su4ztL+AOxI=@vger.kernel.org
X-Gm-Message-State: AFuF++klVzCOBnzigMx4QBKth4CwbOWx6ICp+TywWVnOBjmzMgl+9ETC
	oJ+ef8gvIXmSiox4GBSTpTU4ITVhoM852VeGZIqpl6xVDpSeKYpv8K3sDduijjOj0p0=
X-Gm-Gg: AYBFou21Nt8s3yAzvI0+RWDUK5Htx8GRMAv/SVcin+waK0D/ReyuxYbndi1ByFZd5Ow
	RKbIcgpfV0GlO7jxlS3e5Etp1Eho9xOSIUZjHYnxU6Ta+x9xAaT03xmvBDv+06hyU3NMkF5F7y1
	tBgfYEcHdikjxGHeMKCbPR8G7UzSphPHt/9YNcdKiKPxWJ7zd1wVS9Hni6vbYYxv7LrNXMmReoB
	tKYmvse1hYMFXN2io4+FJlSsT/NXZ+jjYw8utt9Wbbu4JpNdkg2ZrYQFIGvJR0EC2xUhvqF0D65
	PRMTrBGj1CgIBWP1bgGixq5LIwdw3lqzsLHQEApCJRZRzM4g8H0nWY3hIsxf7I6oUfPn3w2jaEM
	1avSfIhxyE5N5j7V2U/w/A+gn92UPKUfowFdiCOsKuwiubFXqjAZ73pseq378pIJPATKTHyB6HU
	drFmgwfoL215f4n9Yz+fmeI+zJ5SmK6f3Cxqm64E5bCPgw8m3Gpx1yTJMbmdObqeQiBYgklCQip
	PG0REt01Fot7GJ/VP8PfjQJntvEOGmOUOzYitYfi5YTyONjCSgTiVPv0Rk8vo1AXMbtiqg1Y80t
	/EACnhOutKvR425qyiXpfz0uChV/nxakP7c4R5ab5KxUN6q2+j77N5G5r77yWm1s2pUnuxY3UT/
	P5EmKlaxXyYDI5Q76Dp5O5Ie48eHSKlMfFJ+NCbTNHYBdZclGrfMDYhngeZ7uiRrYpIxG8Cgp
X-Received: by 2002:a05:600c:8b2f:b0:49c:ee21:dd7e with SMTP id 5b1f17b1804b1-49cf7f47fd9mr33364305e9.0.1788513549497;
        Fri, 04 Sep 2026 02:19:09 -0700 (PDT)
Received: from ?IPV6:2a02:1813:4880:5700:96bb:43ff:fe97:79c3? (2a02-1813-4880-5700-96bb-43ff-fe97-79c3.ip6.access.telenet.be. [2a02:1813:4880:5700:96bb:43ff:fe97:79c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbe5b252sm27176135e9.3.2026.09.04.02.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:19:08 -0700 (PDT)
Message-ID: <d61b56b5-d874-4e50-a83f-8714da4641e9@gmail.com>
Date: Fri, 4 Sep 2026 11:19:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 038/552] mm/page_vma_mapped: use huge_ptep_get() for
 hugetlb
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20260904045747.813364717@linuxfoundation.org>
 <20260904045748.693901462@linuxfoundation.org>
Content-Language: fr-FR
From: =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
In-Reply-To: <20260904045748.693901462@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 4/09/26 à 06:53, Greg Kroah-Hartman a écrit :
> 6.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Dev Jain <dev.jain@arm.com>
> 
> commit e87df0d5d6962bde50f55f6d02b779daa394f894 upstream.
> 
> check_pte() is the final validation step in page_vma_mapped_walk().  It
> reads pvmw->pte with ptep_get() to decide whether the entry maps the PFN
> range being walked.  For hugetlb VMAs, that pointer refers to a hugetlb
> entry.
> 
> On arches which provide their own huge_ptep_get() to dereference a huge
> pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
> etc to misbehave.
> 
> It is not clear whether this has a trivially visible effect to userspace.
> 
> Use huge_ptep_get() to dereference a huge pte pointer.
> 
> Link: https://lore.kernel.org/20260703114202.365553-6-dev.jain@arm.com
> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Harry Yoo <harry@kernel.org>
> Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Jun'ichi "Nick" Nomura <j-nomura@ce.jp.nec.com>
> Cc: Kiryl Shutsemau <kas@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Mel Gorman <mel@csn.ul.ie>
> Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   mm/page_vma_mapped.c |    8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -104,7 +104,13 @@ again:
>   static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>   {
>   	unsigned long pfn;
> -	pte_t ptent = ptep_get(pvmw->pte);
> +	pte_t ptent;
> +
> +	if (is_vm_hugetlb_page(pvmw->vma))
> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
> +				      pvmw->pte);
> +	else
> +		ptent = ptep_get(pvmw->pte);
>   
>   	if (pvmw->flags & PVMW_MIGRATION) {
>   		swp_entry_t entry;

This patch causes this build error:
mm/page_vma_mapped.o
mm/page_vma_mapped.c: In function 'check_pte':
mm/page_vma_mapped.c:110:25: error: implicit declaration of function 
'huge_ptep_get' [-Wimplicit-function-declaration]
   110 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm, 
pvmw->address,
       |                         ^~~~~~~~~~~~~
mm/page_vma_mapped.c:110:25: error: incompatible types when assigning to 
type 'pte_t' from type 'int'
make[3]: *** [scripts/Makefile.build:287: mm/page_vma_mapped.o] Error 1
make[2]: *** [scripts/Makefile.build:544: mm] Error 2
make[1]: *** [/usr/src/linux-6.18/Makefile:2051: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

commit 70010ab9a9eb7aee65f42ddc20835806759b4336 ("mm/migrate: use 
huge_ptep_get() in remove_migration_pte()") gives the same kind error.

If I revert those 2 commits, compilation work fine.

Best regards,

François Valenduc
