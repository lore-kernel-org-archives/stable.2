Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415131716E;
	Fri, 31 Jul 2026 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528037; cv=none; b=EpO4tQuV1ZQ2Yd/nd25OamKQMgf+LuvHu9zDwtB6NpV38yHdjj+p3DDsVqpDsVMuxwT9vF0EHW/mxNIpxjlW9oCtO/qsARhvmXfm4kmWGp4o9kgVVfeXXH7hia6HvWEgCBvORs4pYEhkO2q1YftX0qDlVY/l+SGIy4Vf/VceCQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528037; c=relaxed/simple;
	bh=rq5n9AFQ7phucOjSWqaeRU9ORII6gUJP5PqjZLN5rwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN38vlWV9GpNRIxEjImiWT8H3B4P5NPeD2ikJzhTjWuL52oIHWfxJS+0ntfUwHpTqOZU34Y4CFtUFpzyhN3kW48o+vgygWhJ9s68e7gQ+cwf741jDUa+lro44SR9vS7qAVDGWxsmKhfTcrbeHui6sxq6ys2srfryfBP1xQHLpxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iHmHFJD0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iHmHFJD0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dZT9+CTn+bjLGUN5P6jZtXT3Oe8XoKKTzXRedmYLMew=; b=iHmHFJD0hadfYVHZHTaZiKqCrV
	G3474FAUSeNF1IIpVToLdSl+pNNnmvlHWG1a6cBEHDqR2MHr5LkIFWUDZpQI3XK0LoQoQbTghA1A/
	Cfysl4y8kc2FaP1Sie1oTSxOmDwc3B9YlTz/MkgLFULhoG28144rFwtgOd3ACZ5N5KOjxdV4MEeSM
	lSu8suzl60A+yZhtJAayk5EFwU0VVYjazK4NoCoyHEL/f6lLfYAmFnGmYErJwI2UuX6to0xAvF6GP
	KzH/+y+lkfZrD2wgtmKiprd12uZWafAwCRR89azmGYC4USF892UCsNHPZfA+nGEl3vhgcPwjc5nbX
	jmOtx0IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wptOv-00000001zPM-4Awv;
	Fri, 31 Jul 2026 20:00:14 +0000
Date: Fri, 31 Jul 2026 21:00:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, stable@vger.kernel.org,
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v7 01/13] memory-failure: Fix hardware poison check in
 unpoison_memory() again
Message-ID: <amz-zad7HM-PEkjb@casper.infradead.org>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-2-willy@infradead.org>
 <amlKHkemYQBxFESG@gourry-fedora-PF4VCD3F>
 <amlav1zfVy-9fLw5@casper.infradead.org>
 <ccce5d73-b5d8-3e23-8e49-bb154af023d4@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccce5d73-b5d8-3e23-8e49-bb154af023d4@huawei.com>

On Thu, Jul 30, 2026 at 04:45:19PM +0800, Miaohe Lin wrote:
> On 2026/7/29 9:43, Matthew Wilcox wrote:
> > The careful reader will observe that injecting two memory failures
> > into the same hugetlb causes ... problems.  That's true before and after
> 
> Could you elaborate on what problems this might cause? IIUC, second memory
> failure on the same hugetlb folio will make try_memory_failure_hugetlb() return
> -EHWPOISON without holding another refcnt. Raw error pages will be added to
> raw_hwp_page list. Then in unpoison_memory(), raw_hwp_page list will be cleaned
> and extra refcnt held by memory_failure will be released and PageHWPoison will be
> cleared. So it looks work to me. Or am I miss something?

Thanks for the explanation of what happens.  What's confusing to me is
that we can poison pfn A and pfn A xor 1, then unpoison pfn A and that
causes pfn A^1 to be unpoisoned too (if they're in a hugetlb folio).
That's an unexpected difference to me; I'd expect to be able to set/clear
their poison individually.

But it has been this way for many years, so I presume people are either
used to it, or don't notice.

> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks, added.
