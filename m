Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C7414401;
	Wed, 23 Sep 2026 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162317; cv=none; b=VKxxsLMS16veBK8wcRtd4v2D6P4Ymd0cY6rZvytWimSEX8fVmmErmrFgcvoSpA9KXEr7i7DZOTjpzi2SFc7ggHjTWJqNFz3rA7ZSXDYronQkDWUCEK+5Lk674t1rVnQcmuSWj5pVGuyWu2rU4iEWuy2HJ5UP4P4PG1Ta4m132JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162317; c=relaxed/simple;
	bh=jUiKI0Vg/7LhxatFOwiiZ204UI2zZBJ8FadYQSjnlV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKu22RArG2JWft7+KgY1EE3xgxPHNIaIe1I/ffJyqPSZxJaGdtbhm75SZvPhhUEMQbFlAV1cXYUhel5U1dherYIpxo/PCHdY1Gw3KcTu8jebN1lRS5QHbwsirtuBtGiy7z2x7ZMethu9LJAh2yBapuvmZQZFwZuRcscFygClt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=uQqOQiua; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sbuif8TS; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="uQqOQiua";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sbuif8TS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 9E111130005B;
	Wed, 23 Sep 2026 07:18:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 23 Sep 2026 07:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790162312; x=
	1790169512; bh=2TVk13RFsYk7kVKBgSgsEJ+IW3CwoBAD5ZEy8mb48co=; b=u
	QqOQiuan6X14oG0K9bAZNIJK1JX0JPnMYFIgsLyPvkQcKKqjsak+u5xm+wcs343M
	wZH0lEYUZeS5RQ3MMp2LKg7KuIvwRHjaKgwe97TooBuux5HHoWlYf25LZJi8QFpE
	PGStslxjBOMLgy4xE6u9rSIAU2pF4iYDeqwiHNwrFIbiVoGKmSimm8HYqT6jRq92
	Fm1qzjOMr+3pLU5FSgVBAWI++pawxncO7+Uih1ywpd+mzLDlc8EsHf/d9ytY3Jw3
	vvVURpMg/+n28VjTrqZErNGAJlifrzBNXGf+KARFzITaFFtufkurwQ1cPHh2rW4E
	oahOuD9hCkqWZKLQN77ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790162312; x=1790169512; bh=2TVk13RFsYk7kVKBgSgsEJ+IW3CwoBAD5ZE
	y8mb48co=; b=Sbuif8TSacYvzoBXbPPaXxvsaY5e7rMu8WyIUJnA7lS7WkvwBFI
	SbnkKDyg6Kaj0PRYDXW+Ei0VU89jZwB/xMTkAm+md3U8dnaSfS2iWl4uip1fYOwZ
	uDVS8yL5RKAFSM9ByzsIt9pGIkFvKuN7D6h+cbJXtMl2EiFzB328y6+t3RDNE4pJ
	dVCSwJ3SeuYH2w/n/BYdXGa5mejL6/BlZr/uWFfKdWvh6WLXRKsNcH0pp/hO8OZg
	N3WfvLwHysofOcl6M+sV1GMjJuL1EzdWxeL8JE8m18I5c4jvGoN+kfNx6UYSUwXY
	DdyOge4i4NhnavHjgVYdj4Gn4MlJNGpLR4g==
X-ME-Sender: <xms:h7Wzakb_3o55Xn6lyLTlrPU0-CbWt9-JZbtsnsRXoqcToveN92-f_g>
    <xme:h7Wzahs5zdPB0w7Dl7SpASRA7R3nOie9cTKqNLLEhHIydVVtJRj5yWOjKT8xqd1EK
    86SOF_qPDGX8kXnT7FqbXFtj1XkEjb0W5c-NFFI1sGdkORLiJewG9MK>
X-ME-Received: <xmr:h7WzatrvZrt4u6F9JigArINPx7w0e214T9M69-POGsKy7JJrH2iU6eG6oag>
X-ME-Proxy-Cause: dmFkZTGrlYvgvymMlhdgBOFd/qZDFaK+/zbJqw+thyqpFtRPCbxylKFqB+guDx9uBmH3h3
    wOFmUeaBKxJI8nk9s/jGIA8pkgEjRXt/k3BcLcHTM8DNitwJ3QM2Y0eZ6Y0cwa1QDp1A+x
    Kny294COC+wa6Nc+18V7TJFMBbUiwUU8u2I5NAG44/gt32UISWJHPvzsRDN8BN4k38Ht1l
    f/9q8O1OnEZ4T90ecAJXcK27u1T/OCMeX0wxDR0+4S0wo6iGuCpDW9Z9a7z2S8OtYC47O3
    e02aO1UwjyY2Fmt1RtlDcPHs2OEgn6+Enrsus7l2oxbMzyBRhOEy3Lw/58kUmQWOGU8jHg
    PSPajb7ED1lwrG1x+59K2CpzJxf/qBCMvvBl71+ffmggf+5bfwEyi/JQFyUk5rXiQ7HV6F
    dZqRFW0k5qhV+DTApCpcL+Pnz2S9gKTp66LPdTGFphsLtXPvDGXKsaxUA6d77j1ZIJ36VB
    cSYS7hb9fNBI1GhN8qsoNT1kDNXOFM2vPcMpN27gQctQsZFWy2DICI8igEyshuclxYimvP
    mFGfuRfSHEGaEuJHUVhpeNdENvjK7APRZ2t0M40yq6dODlLLWC2FfwF3ShEeNYsqTLlxoc
    ceTQe3J7T9zfDzoeXHMwP9Rh6hoHsVZpnFA5D0Sca5vvQGbxpXux0VUAXESw
X-ME-Proxy: <xmx:iLWzarkRd-jq5gxep_jLfaXf6Er340-rzDTSClOVSY6zGqAPZlG1Aw>
    <xmx:iLWzatTeu1aHB3pDOeGlxmQyYpdcsZQCUUsjvDR7B_1JF7tiaNAPSg>
    <xmx:iLWzakQIcCuP-qSVN0LXT4ByOyxw7rgDk0fC10DKfdjyphqzRxyMoA>
    <xmx:iLWzau6yRcdrz7st2pfnBAA0owYrkSrBa4qZg_mkKDcLyNxwimp-Sg>
    <xmx:iLWzajyeB-aqABIfAf82B7ZHRmTsSrLrxK6frniZ1yu18WCzF4YlR7Qk>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 07:18:31 -0400 (EDT)
Date: Wed, 23 Sep 2026 12:18:30 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	surenb@google.com, aarcange@redhat.com, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, mhocko@suse.com, shuah@kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] userfaultfd: clear the inherited uffd bit in
 move_swap_pte()
Message-ID: <arO0a3CU_idyVsqQ@thinkstation>
References: <20260919004630.1159895-1-donggeunyoo.kernel@gmail.com>
 <20260919004630.1159895-2-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919004630.1159895-2-donggeunyoo.kernel@gmail.com>

On Sat, Sep 19, 2026 at 09:46:29AM +0900, Donggeun Yoo wrote:
> UFFDIO_MOVE on a swapped-out page installs the source PTE at the
> destination unchanged, so a uffd bit set on the source lands in a
> destination VMA that was never registered for write protection.  It is
> then permanent: the bit is dropped only by change_protection() under
> MM_CP_UFFD_{WP,RWP}_RESOLVE, which uffd_wp_range(), mrwprotect_range()
> and userfaultfd_clear_vma() issue only for a VMA registered in that
> mode.  pagemap reports the page as uffd-tracked, and MADV_COLLAPSE
> refuses the range while the bit is set, because collapse_scan_pmd() is
> strict about uffd on swap entries.
> 
> move_present_ptes() and move_zeropage_pte() build the destination PTE
> from dst_vma->vm_page_prot and arm RWP only when dst_vma asks for it, so
> the destination's own registration decides the result.  move_swap_pte()
> copies the source PTE instead and only ever sets the bit, never clears
> it, so one UFFDIO_MOVE behaves differently depending on whether the page
> happened to be resident.
> 
> Clear the uffd bit on the moved swap entry unless the destination is
> RWP-registered, as copy_nonpresent_pte() does where it installs a PTE
> into a destination that may not be armed.  A WP-registered destination
> stops inheriting the bit as well, which is already what it gets when the
> moved page is resident.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
>  mm/userfaultfd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 74f04c323c50..6495666c596b 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1452,6 +1452,8 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
>  	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
>  	if (userfaultfd_rwp(dst_vma))
>  		orig_src_pte = pte_swp_mkuffd(orig_src_pte);
> +	else
> +		orig_src_pte = pte_swp_clear_uffd(orig_src_pte);

Putting it in the 'else' is wrong. Clear uffd on the source
unconditionally and re-arm based on the target VMA:

	orig_src_pte = pte_swp_clear_uffd(orig_src_pte);
	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
	if (userfaultfd_rwp(dst_vma))
		orig_src_pte = pte_swp_mkuffd(orig_src_pte);

That is what move_pages_huge_pmd() does with clear_uffd_wp_pmd() before
its own re-arm, and it is the logically correct way to do this: the
source's state is gone, the destination decides.

>  	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
>  	double_pt_unlock(dst_ptl, src_ptl);
>  
> -- 
> 2.53.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
