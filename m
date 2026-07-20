Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3737022D4D3;
	Mon, 20 Jul 2026 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518507; cv=none; b=cwtVOIG3J1SXZUcmR8GjtXq8olrs+Ht8ml6El8gXgBvwZGGMlGe8CE+t14bat2IFBrYnUXuD2ZiqnQiAiFK5Xdt7/5wdkrYq93v+/k77awvdbs0jN6Km5jU5vfJhBQ6ANi0rWzZHrrqDdvA23UTOETlAw7MVP09D+moHm00tTE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518507; c=relaxed/simple;
	bh=OlNnMEHZxmRfyYt9TI6Nq12FNesELsH1G6h2xyok1XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klWj2hBtB12t8nMArz4ascMniTu546xD/ODNE5/VvjqdYWpRzhfOVYp9Zjv68YKYhHp6qVARd9VNQDIHb+9QOjiBezc4G8SKQ7OvLoi1MimCR54usb8ChFDwoJ/05bzZb46qHu5IKMFh7k8xoR7fMuhLhEOjlZ9aUuwfJkHMoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=agYQBBVl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="agYQBBVl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f2bP+bUhNIo7yhxzRHd509jBvMfe8gZ7euA6b6kD2xg=; b=agYQBBVlNRJnYUiMEWq22PZtYA
	FbrME6UYB/Hh4v6tnwhw26BbMaIN1s0PpetJvnOFa6P81uo/0u6ZiEr9bmu9DB+SGrFkVGGJrNJed
	5N+QDWWHzWnLNwLpkSNyAvA2phocWOspIe5/XQwPcoVhPfyf31U4zQfz5Vzk3e6d9/dVDRTq4ka4n
	GKIsiNSu9pxumiPOjjvbVlYZqc1mL3Ifx26jDC8I/yjfJvVMW28vAN1vts8Q85HJyT4WgHpXsO2yU
	590YLRlm+jl+eEg/5q/+orZ0nJc04VJG19l8zo7zOHKImIwWwMcnd1c0oLBoizU9JDtTJGgPNRS/b
	W7wsVm4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlem5-0000000A4lY-1EOT;
	Mon, 20 Jul 2026 03:34:37 +0000
Date: Mon, 20 Jul 2026 04:34:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Hao Zhang <zhanghao1@kylinos.cn>,
	Hao Zhang <hao_zhang_kdev@163.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, stable@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v3] mm/huge_memory: unlock i_mmap_rwsem before releasing
 after-split folios
Message-ID: <al2XTQLWB12sJQG5@casper.infradead.org>
References: <20260716095424.471052-1-kirill@shutemov.name>
 <20260717195851.609269e143b4b9eb857f2a6a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717195851.609269e143b4b9eb857f2a6a@linux-foundation.org>

On Fri, Jul 17, 2026 at 07:58:51PM -0700, Andrew Morton wrote:
> (why is mapping_set_update() a) a macro and b) undocumented?)

commit 62e72d2cf702

    So make madvise(..., MADV_COLLAPSE) also call xas_set_lru() to pass the
    list_lru which we may want to insert xa_node into later.  And move
    mapping_set_update to mm/internal.h, and turn into a macro to avoid
    including extra headers in mm/internal.h.

Take it up with Kairui.  And whoever it was added that patch to
linux-mm.
