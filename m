Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177626AC5;
	Tue, 25 Aug 2026 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637429; cv=none; b=Riz66b95jsSdBdPZkrU2HEVt3Dr8HLcZhSm0sSf1yt6mc9QOFuoNYNt1chnM69za49aK8CfqRyfuj7UZQ2qyC9Po/H+mBsSgHefTl/nyhaUcEgKgfrxQ/Uea984B+mzVvigPIw6VzdDzjCkQxrBy1JgAIQmOJ+Lfoa+8qxl8Fes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637429; c=relaxed/simple;
	bh=s/gF58eXW2pVhZDo4TnO16rPu2xMEXI0qpLRfq1vYsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh78XaS4PAR7mltZdFEWs7sJi7gIzVGWAIgrIxQQSGmQRKi4z87wRRNodfelYZTNOWqdAy7mlUEG5HBzDEAw2JRqpEJfRlBSjwlxdW/OmiCd30zz7HnbT5eeAr0fjuysQyJQc+sHQuzD6vbEzILVZV1v2D+vQLc9awn0hsAFgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4hivPyVH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4hivPyVH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3n8sKxOLY9bY1Jljt7EDfRL2ryQR3dKEADtbegGl4j4=; b=4hivPyVH/E7aqxa198tsBYDhtT
	pheZRlehn97+Pn+qzZaamy4FMBMqTsG+w+pkWof61SjtSa9zehOQ74t1NrJjVEf9r/JJsmeqJyLa9
	fBTbTLLiYWmmi3cTiTHnpobC+AzmGunnKistH6FS80+HKogiTyOLdD1uCZEHaPATXdecv2Y3kzsNb
	/EBYP+I/hoJIhzQU4bobyba03Nfl/g65gyYRW0qqrdo2uJn8rvlut1397NlYgCBj9E6dLPWjKUzJg
	MUKlmO/qw1j5IIU9m55sC1Y4+KFkL4YbVaa1aXZC1jyurhvheXv+3OzXzdThqJMPuoxtd6icvr+DD
	05wedv1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyk9d-00000000Cqf-15be;
	Tue, 25 Aug 2026 05:57:01 +0000
Date: Mon, 24 Aug 2026 22:57:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: pfalcato@suse.de, kas@kernel.org, usama.arif@linux.dev,
	hughd@google.com, akpm@linux-foundation.org, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
	liam@infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ljs@kernel.org, nico.pache@linux.dev,
	ryan.roberts@arm.com, ziy@nvidia.com, nphamcs@gmail.com,
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
Message-ID: <ao0urQFF6IOFAorx@infradead.org>
References: <aoXYh9EPF6QnlvIK@pedro-suse.lan>
 <20260820061337.24669-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820061337.24669-1-lance.yang@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 20, 2026 at 02:13:37PM +0800, Lance Yang wrote:
> XFS installs the huge-fault, regular-fault, and page_mkwrite callbacks
> in the same vm_ops:
> 
> static const struct vm_operations_struct xfs_file_vm_ops = {
> 	.fault		= xfs_filemap_fault,
> 	.huge_fault	= xfs_filemap_huge_fault,
> 	...
> 	.page_mkwrite	= xfs_filemap_page_mkwrite,
> 	...
> };
> 
> On the fallback path, handle_pte_fault() leaves an empty PMD without a
> PTE and calls do_pte_missing():

Just a reminder that it would be extremely helpful if we could refactor
the vm_operations_struct so that file systems could register one single
fault handler to cover all these (plus .pfn_mkwrite) to remove all
the annoying boilerplate code in the file system and the confusing
fallback logic in the VM.
