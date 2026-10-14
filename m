Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E7388E72;
	Wed, 14 Oct 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989773; cv=none; b=li3BfCDU6UInjYPv9VrGHSpjaw+l+Dp//uN8MC+htH0e22FafeEKqUughavZELYe8sidnYghSekrBqoTX+65yEBsBmPP8kVl8DdlE8kDmnvhu8WF6vx171Bb9ID/fZGOy9Gp61kSWQAcz44+crENpJLJVgjTqMwJGCtKrOf543A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989773; c=relaxed/simple;
	bh=aeLLoyDZF4JqsvnXzhijNTeIEEUuhP4CFFXzZyfM+rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7MLyeV0+M/BuSPpCd1hPfqOgkHOV8hzkdCWryU10xWW5zifG9sCAzdlfmCZ+iNaGAej1HviryNXalErj0KPpQFQutief80c1WF6h1Ynbt56aFFiHzIqpdY2u0Mm837NNZYpfR3OlN3UACZ0EOWtJeIkud6xbRFBs/fohpB2faw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okqV2nzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okqV2nzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12291F000C4;
	Wed, 14 Oct 2026 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791989768;
	bh=Re8GJbdhl5QjVvoUI2rtJjUCyF0iWbGuReuk1JeK0as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=okqV2nzQ+YeNHZZ4PAdi+2zs9E6BjLN0y3+24X96ykEz4tM8JTnoxD9cqhN0+FQLC
	 wqnCwx+ZncTNSm03hEGxeujWLAcq4wMBvJVboK+94QqAgNjgko+DuXV5YDpFnAsVp4
	 Pd/2v/4/ultfuC9mru+g8VW4vlz9VkgA8Wj6WoENEUCKPCL1QyWv96+GU3rkyDx+4Z
	 +uqmmCqp6hS6zim6u4hISNm52CxsGNis7O9RFq7UvNx+1X9dTKa0f/NySGeGaP08Rv
	 luYLtxDrLyV2CcZgmmEmjXl+cSNyzELMpio5BPuMjF1ZyaHsNKOa5Fy4f1HVXsNmm7
	 GJu7ysP+uLPWA==
Date: Wed, 14 Oct 2026 15:56:02 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Ying Huang <huang.ying.caritas@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix address wraparound when scanning large folio PTEs
Message-ID: <as-XYuUJdeHD3W9p@gremlin>
References: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
 <as4kvHe9IFZH5qrC@gremlin>
 <9add8400-66c1-47e9-b5af-7a4081ebf3c4@kernel.org>
 <as-BZibPscw4cxsD@gremlin>
 <06930044-4bcb-4478-8a6f-2dd3cf6d290e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06930044-4bcb-4478-8a6f-2dd3cf6d290e@kernel.org>

On Wed, Oct 14, 2026 at 03:45:41PM +0200, David Hildenbrand (Arm) wrote:
> It's the following thing that adds confusion:
>
> include/asm-generic/pgtable-nopmd.h:#define pmd_addr_end(addr, end)
>        (end)

Ah ugh :) of course.

> What I am saying is that I don't agree with adding another two const variables
> with names that are less intuitive than just saying the computation. Let me try
> to improve the comment:
>
> /* Avoid address wraparounds by not adding/subtracting beyond limits. */

The variables are a (possibly) neat way of self-documenting that, but then
possibly adds complexity by having yet another variable :)

A comment works for me, though the confusing bit I guess is knowing which bit
exactly might overflow.

So maybe saying 'avoid wraparounds of <variable that can wraparound>' and a
brief bit about how would help?

--
Cheers, Lorenzo
