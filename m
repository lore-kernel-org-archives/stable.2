Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4422D949F;
	Wed, 26 Aug 2026 04:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787719365; cv=none; b=BPN0GdHT2hHLT/apXp5EmcBQbxK/IGoB/tELurykWT17EhlzPYf/UOdPgOEtN25dDfa+7WOc6NqDHA1HdJ29c6eSa4OHsS3q8kz8otcbovWRmxnoHTNjEjdTKe2j6aUt7lSbldJBYj5kjDedcu6/0ZEG3aMm5v+WBUpvrYVkLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787719365; c=relaxed/simple;
	bh=WRywdTgvMYNYVhXMZH6U9+V1LxlG++o9sVaVO0JcfYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3+mtbY1ep45eZzoEh3CX4J5ya+L1eHvyY7CDK3Egly659gfYiXkvlj8UOp0wH+10H1hXXHIHbd1ULTb97Zes0zMFvgF+vQrR/1qtPPRxJtu8zyIoQvQ3a8vSqF+wcE5zxt6GIB6TmtgPS2ZcKNtyWLrEGgrj44stromy+MsbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eVVT9JXB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eVVT9JXB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CTnPcAwpdtslp34DtESY4j72LmM8BtuutB92mivhMWo=; b=eVVT9JXBdSRKUp6qQxUQLXchhT
	qj8QBK9B962lxL046rXbK1vBJPd+a43Rup6i70SvKU3jCe2CzFYFhbzOrfMU/YOlnVn6D9Ae7XShT
	g5yr7AArmwxZZwFjE8s8Tc8fEj2sZ1F0L7Iek2JSPqKm+TwP5tRnp40I7Ebr7tI7fwNKRGp+UXt3M
	/WVg711wrSU82epSp+572hJp9MEqgvSi5YH+Lg4ryDlY79Vg7ODaspwAP5qnaiNEofm+bphChbVZ5
	UPzj586ray+f9d9JeEDLkS0syJNRvWpuh/khp2uCKGy+s+EQlpG3jVRdCRBWyKxo4vRbXNbtXvY+p
	xtlSodyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz5T7-00000001tSg-2zds;
	Wed, 26 Aug 2026 04:42:33 +0000
Date: Tue, 25 Aug 2026 21:42:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	usama.arif@linux.dev, hughd@google.com, akpm@linux-foundation.org,
	baohua@kernel.org, baolin.wang@linux.alibaba.com, dev.jain@arm.com,
	liam@infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ljs@kernel.org, nico.pache@linux.dev,
	ryan.roberts@arm.com, ziy@nvidia.com, nphamcs@gmail.com,
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
	kernel-team@meta.com, stable@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
Message-ID: <ao5uudXQVj8JVoG-@infradead.org>
References: <aoXYh9EPF6QnlvIK@pedro-suse.lan>
 <20260820061337.24669-1-lance.yang@linux.dev>
 <aobp2CtWZBlw4w7E@pedro-suse.lan>
 <aob9PF_H6CCJMdkk@thinkstation>
 <aocFPRgqieScf_yo@pedro-suse.lan>
 <ao0vSde26_Qar0IZ@infradead.org>
 <2614286d-19ed-4848-8ce6-59ebecf19d1d@kernel.org>
 <ao1R1Dh-42ALMq7o@pedro-suse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao1R1Dh-42ALMq7o@pedro-suse>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 25, 2026 at 09:40:31AM +0100, Pedro Falcato wrote:
> That is true. However, I don't think that should stop us from providing
> reasonable semantics for those that use mmap.
> 
> Fundamentally:
>  - For the common, PTE-level case: we get the granularity for free, the
> filesystem only needs to be notified accordingly.

Where "for free" means that the mapping granularity has to be reduced.

>  - For the less common, PMD-level case: we already aggressively break these
> down on mkwrite faults; I think doing this is the right tradeoff. Screw the TLB
> in that case :)

Puh.

> And, frankly, half of the problem (and related to the GUP thread) is that
> page_mkwrite is a crap interface... Something like ->write_begin() being
> generalised to more than read(2)/write(2) could possibly solve most of these
> issues (or a ranged dirty_folio).

I agree that everything around page fault notifications is a mess.
But ->write_begin is worse, it's not even a proper method but a layering
violation that needs to go away (or rather moved out of address_space
directly into the user of generic_perform_write).

