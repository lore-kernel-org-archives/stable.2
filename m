Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DDF36A376;
	Wed, 14 Oct 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989490; cv=none; b=HJgPcZxNSo+ZYfy05IU3NBYD0+kz9JvtGuOe9vrl+OTQyscE3muImx25FdiEnFaWSkd3MvwKVeRFLktb0GQMGwh1cmttrmuHCY6+62wu4OE5Zw70qQcybheXUD03a2DqlF7rUHCp7FscScyJ9CFlh6Rmwn0WFwhGK4LKhvE+e7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989490; c=relaxed/simple;
	bh=Sbwm0kYIICcSUmwlborhldmup0bfDzLGUcDOPU7O94I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5KYBohvD4tEcjw1/fT0mTlnYtw8vRQHNJDhhH6+X85efJdxBkHzy6LjvomlZf/zvtL7hjOvrvgJq/TBuLuTm6z80xFoCTYles/e4p7XgmWRvchxgk3uw3M34IHRaC4vYntGVYfXzY3VOpuUNVZavDZzsbfsY3ZVQeY41M3dyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXhY6GQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXhY6GQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B66B1F000C4;
	Wed, 14 Oct 2026 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791989488;
	bh=Sbwm0kYIICcSUmwlborhldmup0bfDzLGUcDOPU7O94I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SXhY6GQmLweh7DjlvPMxA2dTktV5lkYnXiUk3tMnz8oSC987FLw4a0aDlv8ibbI+O
	 LmKs/zZJ0VLMz5v2QwPJZ6nsrtDLkcaa1VRnPLCw9VqY8XwbPAe419chlY6LwJzV+w
	 X8VkiclUEYqMiUKu/9gvrUuYqnhzKQzy1Bxf7cyL1I0PzA4CPooT1Lc3T7RRLnPJah
	 VnnOYE8uQwe7shBI2ztZRizfWah0o8mz2o999ScqgnkciSfyjlLEe06WZJ23v8WmjD
	 EPvpL/ik+KgpdOZ3uPm7GFOnsej2jA7xLYtCx29gDZNlfO0RzoO//6ruH2jdbyyaPK
	 kxoeAqOLA7pYQ==
Date: Wed, 14 Oct 2026 15:51:22 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: only allocate anon_vma in CoW mappings
Message-ID: <as99gyi-NUprRK6e@gremlin>
References: <20261014-copy_hugetlb_page_range-v1-1-5b68e03fe7fe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-copy_hugetlb_page_range-v1-1-5b68e03fe7fe@kernel.org>

On Wed, Oct 14, 2026 at 01:53:11PM +0200, David Hildenbrand (Arm) wrote:
> As uffd_lock_vma() is part of the same lookup machinery and
> also contains a misleading VM_SHARED check, change that one as well
> directly for consistency.

OK, I think that one isn't _strictly necessary_, but while we're there,
worth doing too, clearly.

We should also go through and convert the remaining !VM_SHARED checks ->
vma_is_cow_mapping() too if possible, but that's a follow up, obviously!

>
> A follow-up cleanup will stop taking the hugetlb_vma_lock_read(src_vma)
> lock in copy_hugetlb_page_range() entirely. Further, the usage of

Hmm really? Is it possible to do that without the hugetlb lock?

It'd be good in general if we could get rid of that lock as a whole :) but maybe
dreaming.

> VM_SHARED in userfaultfd code should be cleaned up later to focus on
> CoW vs. non-CoW mappings.

I think also anywhere else in the kernel where this is done. An audit on that in
general would be useful!

>
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Fixes: 867a43a34ff8a ("userfaultfd: use per-vma locks in userfaultfd operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

This LGTM, thanks for handling this!

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

--
Cheers, Lorenzo
