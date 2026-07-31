Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE783B7769;
	Fri, 31 Jul 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505163; cv=none; b=nKFpFIx6g5BsM6iCpyXO14SEKITyuRVyILMr+i4vQynlYF+ctX0KvlEH5RglYnLn86sEPyenR2/hfrhC2PoE+4JVFXphzFa39zZPmV0oHhzq7cxC1sCx6XHZvZPZZ9RPKBO6kbLgvo8rtOaQKjeyswTytQ6i90Bhd0JyGzz8Pkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505163; c=relaxed/simple;
	bh=i6heaGQLXXeIq1FowZO+BivzaQ73eG5yAk3pGfDncKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndzQg9suaM8WvMVAZlmjYFVNn5E+V+5dbr3upK3thH0IX+srECBBRG1MMz36xGZgJx6bd73MHR+zkOKH0Hv1zFQVuMRdpNiZGMfZepw6JcLDsP5srdOZdr/9zZKOILZDJWTdmHiljEjavxJB9Zyi5q7H9s8QWqZQyTPaOAZLXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=igU8xHOZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="igU8xHOZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PMsSa8DpHjoOi6gmcOGcxYP4gI70dVR+DdX0H08nrsA=; b=igU8xHOZNj8+WBM8T2IIVwmwCe
	gtJ75h//s9qV2OGqD9o4sG187F6HHQeHnWSNY7M3PO1AVW3dZnWPL1FKD2cihapIWAdEFRCCEg8eb
	OVqiw/9BCu/zYeEhQLGl3VqkTF+yhYHdiW1WieoRhngC6Jao6ypH7+6XZHaf4T7EbP8gn1+FfhSGI
	x/kiUQ4Vl6KI4m3dK8iL1f7KQPVWo81uaXr+qfxLtnZu4mWT7aZWURHvBIpc7HW8nGWFqCq3eZm/l
	cJiguOAdO9Lal5tdBWQwRyoo7xfSphC199vM9u0kenu/ARmzPGF4Rptfdpyr5Z5pPmJjtxs0Sz30e
	iMmbv/jA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpnS2-00000005zwQ-0oaM;
	Fri, 31 Jul 2026 13:39:02 +0000
Date: Fri, 31 Jul 2026 14:39:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: jane.chu@oracle.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v7 01/13] memory-failure: Fix hardware poison check in
 unpoison_memory() again
Message-ID: <amyldelTLZNeGaNQ@casper.infradead.org>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-2-willy@infradead.org>
 <c5b01c38-9c35-468b-9fce-ff7e1e11b03f@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b01c38-9c35-468b-9fce-ff7e1e11b03f@oracle.com>

On Thu, Jul 30, 2026 at 10:39:57PM -0700, jane.chu@oracle.com wrote:
> I think I spot another pre-existing issue in unpoison_memory():
> the XXX line doesn't work for non-hugetlb free large folio because it'll
> just try to clear PG_hwpoison in the folio->page, not the precise 'pfn'
> page.  Something like below could do.
> 
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 51508a55c405..14915718ace5 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2730,8 +2730,10 @@ int unpoison_memory(unsigned long pfn)
>                         count = folio_free_raw_hwp(folio, false);
>                         if (count == 0)
>                                 goto unlock_mutex;
> +                       else
> +                               ret = folio_test_clear_hwpoison(folio) ? 0 :
> -EBUSY;
>                 }
> -               ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY; <---
> XXX
> +               ret = TestClearPageHWPoison(p) ? 0 : -EBUSY;
>         } else if (ghp < 0) {
>                 if (ghp == -EHWPOISON) {
>                         ret = put_page_back_buddy(p) ? 0 : -EBUSY;

I think you're right, but this isn't a bug.  That is, we're calling the
wrong function, but in this particular branch, we're guaranteed that
'folio' and 'p' have the same value so the same bit is cleared.

This is the case where !ghp is true.  Here's the code we're looking at:

        ghp = get_hwpoison_page(p, MF_UNPOISON);
        if (!ghp) {
                if (folio_test_hugetlb(folio)) {
                        huge = true;
                        count = folio_free_raw_hwp(folio, false);
                        if (count == 0)
                                goto unlock_mutex;
                }
                ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;

It is my understanding that we take this path for hugetlb memory and
pages which are in the buddy allocator.  Buddy pages aren't compound
pages, so calling page_folio() on them returns the same pointer, just
cast to a folio.

Now, I do fix this in "hugetlb: Use the has_hwpoisoned flag" (because
nobody gets to use folio_test_clear_hwpoison() any more):

@@ -2733,8 +2756,10 @@ int unpoison_memory(unsigned long pfn)
                                hugetlb_unlock_irq();
                                goto unlock_mutex;
                        }
+                       ret = hugetlb_clear_poison(folio);
+               } else {
+                       ret = TestClearPageHWPoison(p) ? 0 : -EBUSY;
                }
-               ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
                hugetlb_unlock_irq();
        } else if (ghp < 0) {
                if (ghp == -EHWPOISON) {

so I agree with you this should be fixed.  But I don't think it fixes
an actual bug.  If it did, then we should do that first for easier
backporting.  So if I've got anything wrong here, it's worth saying.
