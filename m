Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310B2EF64F
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524655; cv=none; b=AkassZftVZZdTyzlni/UxsCsKUDmTM7L2QPfqPj0fbOtUmvosJRuL/oMZc1+8jhb6JKPdF/fvU6FfbGg5yFnKzYhhoIHYmt9kVgpU529rI0cT98A+fFKQ09z+AroIs+qufVnIBwdCzD6SHXuub5NKL81+k48HxbUaYULiNTXvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524655; c=relaxed/simple;
	bh=VlJ90b00Rg0vknYDy6y6/51rSu66HRXtuK12/Y2GQEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8B7cAIjZjugqDiZSX5Lf32E8zpu6z3vvJmNGSAjKYPCpceXlAzrDxFRPXE7+OYp1JEifQXcwf+uDKR4WSm72QXeC0matNuhB1JKTY2uYuksl0a/QWuVVPVQHMq2lhcrUXW2b+okB7AOfucNzVUDX6Tm2cvY9ef0vPwuF6URaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aQ3bxVFf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aQ3bxVFf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yj4jQFmBmUzn/uPgSKizUWw5uE+RcJSk7gPClzg/JRk=; b=aQ3bxVFf02H8TAwNwPUUnSL8gB
	i/H7raG+4edezBZGqI9cTaaYzWob0kRWtfpHKAnG0eQOy2uB54uKUWEOD2LP296hpkv8EZVJ/30dK
	A1tji5ftRquotirkq7NnJkJBXH0uzqYS3qmfRTmIKIWAQY+8ar74aVQ0FxRAYBZRFfhniJhe/0pbA
	mFogNX7cR39xJuF+OaLnTvkqya7Y5W0UFmsh99wlcS9HSzh91CZiGLTzedAqzftunZXg+0iKWamkG
	D0X1uVPKknvzXCV6DhCjj1xFt40rSlkwpA2c8ZyQ36HGLKKemY8GM1ReT3td4Ole8OT25xdv52ECR
	vyJUVxBg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whUEa-00000002x1r-3Pum;
	Wed, 08 Jul 2026 15:30:49 +0000
Date: Wed, 8 Jul 2026 16:30:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Song Liu <song@kernel.org>, Eric Hagberg <ehagberg@janestreet.com>,
	Zi Yan <ziy@nvidia.com>,
	Gregg Leventhal <gleventhal@janestreet.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH stable v2] mm/khugepaged: write all dirty file folios
 when collapsing
Message-ID: <ak5tKPfX99kdkhIG@casper.infradead.org>
References: <20260708151357.353173-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708151357.353173-1-pfalcato@suse.de>

On Wed, Jul 08, 2026 at 04:13:57PM +0100, Pedro Falcato wrote:
> [There is no upstream commit, as this code was removed by upstream
>  commit 044925f9b565 ("mm: fs: remove filemap_nr_thps*() functions and their users")]
> 
> Cc: stable@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Song Liu <song@kernel.org>
> Cc: Eric Hagberg <ehagberg@janestreet.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
> Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
> Tested-by: Zi Yan <ziy@nvidia.com>
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
