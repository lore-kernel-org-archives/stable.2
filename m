Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A1346AF03
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034313; cv=none; b=b0bqntvxtDFbb7cGIxMEqN90YOoyiPidk1gg89u7aulrLDiz7h6gsH4QRFlboF3vftG/GM9PQhGsv1grMwp3NWRnY2StBe8jiRvkO/0MJZrfs/oLBt2dW6InFzcOL5LNWm4baJetmX3MsGHWf+U11xOqfwfIpJq7y39O3l0FVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034313; c=relaxed/simple;
	bh=uONPNuPd9OKKjtc0cbFYUNdRBRuTnzo0udv7EwdreEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/nwW6vG5SZF2X6PizfgKMPlZvTTQYlCqBjrRXl5uhbiL+XcurMFhmtTOrl5tbedPNZDBhAw+st3nY8uBK/umOVTjyfefBSGOQEjnLwpA7Rkp92g7x+9QN2CTKs9jE2hU7aCVeH5pjEzkUv/xXJQAZAy/9GIBuw3LcYcql9ceSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ0obx5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ0obx5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3788A1F00ADE;
	Tue, 14 Jul 2026 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034311;
	bh=HhdQiVTu6KA3opOMmKVdmA07qpV4bmi8kt8ZDXJ4P3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PZ0obx5O3QFI6l8EJIJYSOahVEPqlrLTU55V39v8H62drxItp5CWFCFACTgEGkN42
	 49T1SvqP9IH9lO7G6gP/vg7eqKISrhHNtrX990wuyt9AX9hZscHITYKWFAiHoj2+xA
	 1NHzriP7pQqqmQhMlAZtwEXkitGoB+Hin5Zbj3F1CgcYoYc6/w82Ihe8jPrKj+mqwd
	 sdCJ7sih4ypqNkUCrfPATiNhD9bR1YGVXxWz0p/feArcgNfFoRB0GPiBkxee9h3xom
	 PB5bmYyXRxQifynJ9kK0RFC6/uxoOPjzaBcvBf2+UecHRpcOp/uhYqtyzcbiR54gtN
	 kgeNloFpdy1RA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 52E95F40066;
	Tue, 14 Jul 2026 09:05:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 14 Jul 2026 09:05:10 -0400
X-ME-Sender: <xms:BjRWagNi83rL4RE4Qzq_CHX1oez7HKXUjA69k5PADjg3PaIWoPBTHQ>
    <xme:BjRWajuX2JbZOFCP_0cGkfRmZeEosQPaK5cnLePrvffit5u1SFwjcehQfsiruyRXE
    dDiJXl5LhOmh4bO0xBsntVijiISR7BYZm6fv9Y5MWgCZ7stuMOp4Q>
X-ME-Received: <xmr:BjRWam0wnS74KGev3VJ4KM43BoAWCs57Lf4nzrXSFn1nu4B6WYly-DlNqVH81A>
X-ME-Proxy-Cause: dmFkZTG2+qoH7YKbDlyzXcMOV8ogYXK4x4YWWZstIygUmJWSdfFUXxfKJXPuuHTq2il8YC
    4dFtu85gFPcaTqNqU3aftuUiHdYh4lvK7JQllt5w6x97pLVFtkNXm61NuG8tobtjLnb1tD
    1hFuzcLAw4HMnUo2y/t/BIi/qcl7+Or33WV0BjsbndomlgUzbeg806UaEqP2eQgCQmppi6
    fTUKJvXwLMnoXzycderldx42CWnKTyFto9X9gefWfYhFuh4G13cjBY7lCc6dm6nJbOdJEr
    QmVRL1usA7cILcT60xIFIxTl8Q2AKHvsb7RObv7EXRP4L0GTAJPp8h0BJTedLoQrWtQZLG
    hDZtzhI3EB7g433rhNA5IWc34XkTIp9Z2/FSm/ysYplg8uDejU5w11BnOdZAWXsIrPya8C
    YmFZHyyuEOGu7e3AJ+kWdN5NaxqHbt77Yc7+dL24yiuoPL1p1Sg5HXcG/roRy0ISvinkhH
    BOnYaQz3bIkTvFYAWS2QBQu7XrGNlfTCgZeOFQaPYwJ0qYCnXbEbP6IXLibUO4AOsNNSYI
    vPav/2j1e4ojOQVJaooohbHypA0+XXKAZScDO6PzZNp++wkgoGrhTfTpxC3hG4LX44v1l5
    Piuqxud9l7rgnbs8VjBA0zGxCJVy1yYr2nlrM+T8Jpp89uG+0pNGRBegyx4w
X-ME-Proxy: <xmx:BjRWahXnTxBvcc7YhMqs8WKsrcQV186pH-2cmMOJIX2iWLEQYcVkog>
    <xmx:BjRWasukaIAcWGkwb_LYkDWN4F6RrN-Pn-ZTxmuZ6wRkecdntjWaxg>
    <xmx:BjRWaszQmfr2r_k1XmGT_xU59KGomGGlQzC-Lyrbb01VG2y6RSLNbQ>
    <xmx:BjRWajkdtz-OXhToMrbPm3KIpaCHey15lyJaI6zfi0t1kLqmaMz5JA>
    <xmx:BjRWaiZR_BGHImDMXqbUM9CSeon3mOfVtcr_uViC4Qam2j0jLwARoLlY>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 09:05:07 -0400 (EDT)
Date: Tue, 14 Jul 2026 14:05:05 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Hao Zhang <zhanghao1@kylinos.cn>, Hao Zhang <hao_zhang_kdev@163.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/memory-failure: keep the folio, not the
 poisoned subpage, locked across split
Message-ID: <alYzJ9-zsTuQl08J@thinkstation>
References: <20260714122344.351895-1-kirill@shutemov.name>
 <20260714122344.351895-2-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714122344.351895-2-kirill@shutemov.name>

On Tue, Jul 14, 2026 at 01:23:40PM +0100, Kiryl Shutsemau wrote:
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 51508a55c405..68d42cbed458 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1657,11 +1657,18 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>  static int try_to_split_thp_page(struct page *page, unsigned int new_order,
>  		bool release)
>  {
> +	struct folio *folio = page_folio(page);
>  	int ret;
>  
> -	lock_page(page);
> -	ret = split_huge_page_to_order(page, new_order);
> -	unlock_page(page);
> +	/*
> +	 * Lock and split at the head, not the poisoned subpage: __folio_split()
> +	 * keeps the anchor folio locked and needs it to stay in the page cache
> +	 * to pin the inode. A tail beyond EOF would be dropped yet returned
> +	 * locked, losing that pin. The caller re-locks @page afterwards.
> +	 */
> +	folio_lock(folio);
> +	ret = split_folio_to_order(folio, new_order);
> +	folio_unlock(folio);
>  
>  	if (ret && release)
>  		put_page(page);

Ughh.. This patch is broken, sorry.

Please ignore the patchset. Will follow up.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
