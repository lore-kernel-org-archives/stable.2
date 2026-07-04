Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182E13E41A;
	Sat,  4 Jul 2026 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126213; cv=none; b=EQRPGmKp8PC80zcNiy+PdxY/KJHNnp5gB9qmYN2jC3XVY8mY5yPYn+Z3GpZ3cJ3cdv9EWcslYpIEErbOqrQjD469urKHXIUDjv5l/3wx/nfMGQvdu0CnMsPl7w3ujmcZllE91R6uNjeMLUjf0K1mg2y45pQ/oTVxV1pfcKxMvHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126213; c=relaxed/simple;
	bh=Bp1TCXM/+amIa0ZpSHHhqYe6t3xEeY45y5USXliQbeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDAjliSolmq/ahsZHhRnzxzZwLguRAKujo64adyNJvgwAzEDZ+KaHlbeNulgOT6U+IiVovE5NuRMbAV9YwDGJ3FJSA2vc8pLSk6Tn6eMjDIMeafPeKuMSDniBBo0WLzyjivIu/KzDziYXABmovxY2mWSyVz/05YP0g1/XTX/bWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RyrEOlgs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RyrEOlgs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XnVJsju8SOFKOP9LIze7WlE4ehpoJpNKlAeeOaTjpUA=; b=RyrEOlgsLoALPcxG8DSTjDNX2j
	ob7fZ0Md7ST0kEweAT5XcAuruL8WQqVzhnxXj4y3I2PQtxOWpfIVXZTcvFkFDtQBWt3qXfz56Kqw0
	dtoVoy5+4SPsCWawmiIhDtJtqjhv0CA9lSGw/MTURELC+Mt897OVUIUNusa/sB6lJXs07cb3Wcj4p
	dozyOH38ldyDA1AHv6rzVBpHfIRf8tNMK3PzGnyNjXZUDUhoHejMudChiVigVM0196O6EL2YoWiAR
	RtFFag7Rk3gWYVa7Uzrfxlka/Nte7kagPh9qGcvSVAjvFB+8Sad70vTrxiSPq9kIS/eeFkq3ruh1h
	gKvV6eMA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfoa3-0000000B5w9-3YmK;
	Sat, 04 Jul 2026 00:50:03 +0000
Date: Sat, 4 Jul 2026 01:50:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Song Liu <song@kernel.org>, Eric Hagberg <ehagberg@janestreet.com>,
	Zi Yan <ziy@nvidia.com>,
	Gregg Leventhal <gleventhal@janestreet.com>
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
Message-ID: <akhYu66GmjyM8l6a@casper.infradead.org>
References: <20260702165409.164568-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702165409.164568-1-pfalcato@suse.de>

On Thu, Jul 02, 2026 at 05:54:09PM +0100, Pedro Falcato wrote:
> +++ b/mm/khugepaged.c
> @@ -2094,32 +2094,43 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  		goto xa_unlocked;
>  	}
>  
> -	if (!is_shmem) {
> +xa_locked:
> +	xas_unlock_irq(&xas);
> +xa_unlocked:

Hmm.  Before this patch, we increment nr_thps while holding the i_pages
lock.  Now we aren't holding it, but we are holding the invalidate lock.
Can you put something in the commit message that notes this change and
argues that it's totally fine actually?

You were good enough to not point out that my suggestion of calling
write_and_wait in the existing !is_shmem condition would result in
sleeping with a spinlock held.  Silly me ;-)

