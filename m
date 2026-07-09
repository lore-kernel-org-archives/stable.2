Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCE426D09
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611255; cv=none; b=Ta7BzncZLJQj4+uinF/w1LCERwZFZejUksOVeckEgtLv4y+SQz7pgO0QR5zFHbl3ZZOUFnX0SADqzo5x0SMnbUHQsGB1q6wh/wpu0ECICdLXBTVyjHFi46EU+A8/BTNQehkx8ioG23Z7aNNe5vcBnyGWP7EDxuUDc+C1bcoRzIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611255; c=relaxed/simple;
	bh=bjqSzoVbjCAxz3GwJk9SF12ou1PtxIHctuFwhL/oV8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYcqXugA6UR6YArruWeP+UFTQivFEONqfYbeQPXlpnl2SpfnpWmeWe33a8k9N7JC4lZ45pYjcmapmlMcssMYEh4s5+iVaAECJUurvUQUoUaDOQIv78OBz8/WK17D/ZaYb2ET2OOTWRxgQ/VWpS9W1qkrTQg9PlGbKMpNwrBRLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSf3Zdyw; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSf3Zdyw"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9f829d75aso25797a34.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 08:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783611252; x=1784216052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgZAKDefd+qsWOygAjWV/OqF2VHOBPEQz/tYDmXsGXA=;
        b=WSf3ZdywglgQF+IuwUCdUrWzgrTNihJBzt0+DeTBpqJG7x8+AsoLug0q5sbObjiyq8
         skEkzAqkejpSkHtqYOQwreT4TYJDS0VjYYk7/0X1HYBT/7lyBT+0YNLxHxIZL62nVEPW
         BaF6vvNx5gmEyV0SXHpkXWo8h5s5o/Mc85GeEQHl7v2SuFVGY9jXQr67aAv+cgSUkjSt
         4Xer17iTbnQHc3MAii+RNmKSc+friWwx9sLdXpPlJpQJir6LK9Diq+8ajkI1g7GEluJ1
         mH6PkKvF6A80oRSO3zvwnWaWrgeEPWLliMIe1ndvSXKWbeHNV6MOZG5eKxubwwYDoN5W
         qGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783611252; x=1784216052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wgZAKDefd+qsWOygAjWV/OqF2VHOBPEQz/tYDmXsGXA=;
        b=sX6TqODQhFW7VEJZWVqSxsdyXO/A0JeYJSGkEu9rv7Casm7/vWPOXFgfNrDYYxVuoF
         NNr1Ljm7sfC2cEYGQA6bHPmSV0myUYiv+Mfe7S0tS4TDogZGPk2TrdViSDwfEJ5a1LPD
         CNhVcj4JxpWax65nqrcMjp/kozMolKW29uA6KQycxZhBE7zwx6U1K7WoTVCaBKS15PcW
         HzOy3TIyW9z6BjMAhRkQDY1LNBgb1UvmC5w7xLViwH1rV5FiW4glwl6H24R5acXuJXWL
         iF+zkN/Q7/D3qMt7IobEL6mrNIWlX/4t6B4XMLgm4KZ1L8MninxDpODEZSCUmEiMT61Q
         Fa3A==
X-Forwarded-Encrypted: i=1; AFNElJ/nbHyix5EDm/hoqMRih+hWOMV/nTXkJWiCiOArWNLElY7Pi3/HY7EFi7nrilNjfZoFqSgGRS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykkkN8BS+DPSDzZ8tqdXWqpmltguLFT3RhPdeDSorPW1qOE3ZX
	qv3GaVd9CVCMgEYnuGI135cbb9QKMJhdmT5rpl/9jlYVMXTHGQVwVqdV
X-Gm-Gg: AfdE7ck0a2htT1yUrAMYVJ5in3eGZmNzOw/g1eMd/khke0XSBKeBHOploKCXZXsbMJS
	I5qr7jcKnyB+SYaHRkAXImv+2S3emjSrR55Pw5PpRyqME7a0slT6PdXPcU9OWt4FY/sFkLkm/9j
	oz1uNAoUsWq/k5De0OTAwXv9OK2Jn26Ta72vXg8+8oIHDs6mQ3P5LxHFI8Z96L1nrvs+b0KX9CM
	Zy0ZKycFfL1XRwkNLsmeZ3hsJfxyITCzP1IpnG5KUJ4S2aoFxbq1LWhrpcOlxnflccN+tUQD+55
	Eim/HFZy4sKQq0AxZ11immwY8hKUTstRgDPwpTKIwcksMa9TczXLDIQ01gDC7qf/bEZzzVp/syE
	qaS945eGQ/6wM+BNdAbn5FPLbm0DvCywnDMD8vLvZS01gQjZxgx2UP1T2530VReRYJd/IBLyuah
	JvlpSc+0v2pADGdBQrLxiXQrXoYVSTs3fM4ZTWfDJBHo8=
X-Received: by 2002:a05:6808:f88:b0:496:7ba:89b9 with SMTP id 5614622812f47-4a204ffb038mr5628776b6e.32.1783611251981;
        Thu, 09 Jul 2026 08:34:11 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:10::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm3948634b6e.2.2026.07.09.08.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:34:11 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Wupeng Ma <mawupeng1@huawei.com>,
	fvdl@google.com,
	rientjes@google.com,
	jthoughton@google.com,
	vannapurve@google.com,
	erdemaktas@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ackerley Tng <ackerleytng@google.com>,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	Zhao Li <enderaoelyther@gmail.com>
Subject: Re: [PATCH v2 2/5] mm: hugetlb: Fix subpool usage leak on allocation failure
Date: Thu,  9 Jul 2026 08:34:09 -0700
Message-ID: <20260709153409.2091070-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708-hugetlb-alloc-failure-fixes-v2-2-c7f27cbb462b@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ackerley,

Thank you for this series. I really wanted to work on hugeTLB accounting
fixes but never got the time to get to it. I'm very grateful that you
are taking a look!!

> From: Ackerley Tng <ackerleytng@google.com>
> 
> When alloc_hugetlb_folio() fails early (e.g. buddy allocation failure or
> hugetlb cgroup charging failure) and gbl_chg == 1 (meaning a reservation
> was not used, but a global page was allocated instead), the subpool page
> acquired via hugepage_subpool_get_pages() must still be returned.
> 
> Currently, the error path out_subpool_put: only calls
> hugepage_subpool_put_pages() if !gbl_chg is true. If gbl_chg is 1, it
> skips it, permanently leaking the subpool's used_hpages counter.
> 
> With the earlier patch to always track used_hpages in the subpool, always
> call hugepage_subpool_put_pages() if map_chg is true to consistently
> restore the page to the subpool. Only call hugetlb_acct_memory() to adjust
> global reservations if gbl_chg == 0 since gbl_chg == 0 indicates a
> subpool (and global) reservation was used.

So I think that I've seen that this part of the accounting specifically
is a bit suspicious. There have been two attempts in the past to fix
this area [1] [2]. I think functionally they are quite similar to this
fix, they just open-code the contents of the put_pages function inside
the condition. I've Cc-ed the authors of those two patches in case
they wanted to chime in.

I reference these fixes because I think they handle the minimum
subpage case a bit differently. To be honest, I recall reading those
fixes a while back and getting a bit confused on what exactly happens
when the page is absorbed to fulfill the minimum size...

It does seem like Sashiko also notes this as a possible concern.
WDYT? Does your reproducer for this issue also work when a minimum
size is set (let's say, to 1?)

Thanks again. I hope you have a great day!!!
Joshua

> Fixes: a833a693a490e ("mm: hugetlb: fix incorrect fallback for subpool")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  mm/hugetlb.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ee5e99c1894b9..4093c1c0a4a1d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2852,7 +2852,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	struct hugepage_subpool *spool = subpool_vma(vma);
>  	struct hstate *h = hstate_vma(vma);
>  	struct folio *folio;
> -	long retval, gbl_chg, gbl_reserve;
> +	long retval, gbl_chg;
>  	map_chg_state map_chg;
>  	int ret, idx;
>  	struct hugetlb_cgroup *h_cg = NULL;
> @@ -3003,13 +3003,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
>  						    h_cg_rsvd);
>  out_subpool_put:
> -	/*
> -	 * put page to subpool iff the quota of subpool's rsv_hpages is used
> -	 * during hugepage_subpool_get_pages.
> -	 */
> -	if (map_chg && !gbl_chg) {
> -		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
> -		hugetlb_acct_memory(h, -gbl_reserve);
> +	if (map_chg) {
> +		long gbl_reserve = hugepage_subpool_put_pages(spool, 1);
> +
> +		if (!gbl_chg)
> +			hugetlb_acct_memory(h, -gbl_reserve);
>  	}

[1] https://lore.kernel.org/linux-mm/20260428113037.88766-2-enderaoelyther@gmail.com/
[2] https://lore.kernel.org/linux-mm/20260515202902.461539-1-devnexen@gmail.com/
