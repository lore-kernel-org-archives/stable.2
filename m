Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6529C33F;
	Wed,  8 Jul 2026 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542727; cv=none; b=Ep+1w5zyUXTLbvr62SU+/txxKUqKdw0kfGmOA0x+MO4SE30cm2j6sVI44CTpAj74gatq3rZWS/6wQuGPlG75ZEXYuXWrDinwkR7PKu+TVE0V/ysfMUOrRMzK+i9fEnAUOIAu2W5rQGSIONDzj9D2Sa5Gp/KuOpDLf2vLHWUrirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542727; c=relaxed/simple;
	bh=VYGq50RaqCMNJm8sXgbCnPB/yrSr6z1ns9Nw5iAVOFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzlaoV16IU11312G9wgjx39FWcCU0tp4taS30TQq7eI88oMK9g98MRq1oKzyrfsbwE4kOWlFZUOIsR5qWwZ5KEhQI4i594uFEZDmqDoR7O8PkXSIRjB98TccdEBKx5CEyTP1qgELVSOVAmPc7D/X0WT9NnK1FNANB1OyVJU0/lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LiWDR19f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LiWDR19f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E4BLWSX3Vyc8lOAOY+GGo9U//3Ro2nywmJm3Vhy72n0=; b=LiWDR19fAijsMT3WBjoeg9Zq69
	Nc2aIbkflyUMpXatmwy+fWPYKlaS3HozBAB9Jw42/sWUigzxN8lF1l7Dpyn6fVHZ837uRcECeMVlb
	gIksgkjmrowgediYGSSl3jzBIqy7eHHOko9S1NFnLrWJtMZQI/0ORmhRMPrI6NSh4e/i+YddNlnf8
	aw+fMlrzR5T0boM+zT8KLqfEcuCUnXPC22J1uZeoXmtYvcQ3wiShcVwDVbJx0efkMXTBKmIXe3wKg
	/Do69tz/xjkLMS+hgPHDdWXrpXPgpVd5ngf+UUMmRrcC+RZMCWF826WBsHtK5jv8WDA2BCXyzfbQc
	WCjLFdoA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whYvr-00000003NyN-1ohE;
	Wed, 08 Jul 2026 20:31:48 +0000
Date: Wed, 8 Jul 2026 21:31:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Luiz Capitulino <luizcap@redhat.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/util: don't read __page_2 for order-1 folios in
 snapshot_page()
Message-ID: <ak6zsw5R4Ub8FnmQ@casper.infradead.org>
References: <20260708201954.686111-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708201954.686111-1-aboorvad@linux.ibm.com>

On Thu, Jul 09, 2026 at 01:49:54AM +0530, Aboorva Devarajan wrote:
> snapshot_page() currently reads __page_2 after checking nr_pages > 1,
> but it should only do so when nr_pages > 2.
> 
> During DLPAR memory remove on a 22 TB ppc64le LPAR, snapshot_page()
> oopsed on the page isolation path while reading an order-1 folio's
> __page_2 from an adjacent absent section (unmapped vmemmap).
> 
> Fix this to avoid reading memmap that doesn't exist (e.g., a vmemmap
> hole).

I appreciate you're absolutely swimming in it, but there's absolutely
no need to inflict IBM terminology on the rest of us ;-)
That second paragraph could simply be:

If an order-1 folio is allocated at the end of a vmemmap section,
__page_2 will not exist and reading it will cause a fault.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Fixes: 31a31da8a618 ("mm: move _pincount in folio to page[2] on 32bit")
> Cc: stable@vger.kernel.org # v6.15+
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
> v1 -> v2:
>  - Condense the commit message.
>  - Drop the code comment.
> 
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index af2c2103f0d95..34cb43b3eaa4c 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1353,7 +1353,7 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
>  	if (ps->idx < MAX_FOLIO_NR_PAGES) {
>  		memcpy(&ps->folio_snapshot, foliop, 2 * sizeof(struct page));
>  		nr_pages = folio_nr_pages(&ps->folio_snapshot);
> -		if (nr_pages > 1)
> +		if (nr_pages > 2)
>  			memcpy(&ps->folio_snapshot.__page_2, &foliop->__page_2,
>  			       sizeof(struct page));
>  		set_ps_flags(ps, foliop, page);
> -- 
> 2.54.0
> 
> 
