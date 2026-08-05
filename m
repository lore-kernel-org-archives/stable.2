Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D684772AB;
	Wed,  5 Aug 2026 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948860; cv=none; b=t4VyIo1Ra6cLQ0r0mh4nkPi0oqwjYnKfstAP5OYZdvxPkqHwT9/cWWWztcwu/Bp9hWdiH96o5L786iVYS4FgFRtMkzXiOhvL6CIu6/09xMLnd3D1R6JipW0f9REejfGeWhDdPj5JAh4lObkgyxd2yTA5WUq1U0VYt4mtwqTJjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948860; c=relaxed/simple;
	bh=LomNrTwfUghBLtw8pruEIdjOnzBlW2jy2hvg6IDyNQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/mMeuCjgOlTCki8J0IeoBtBjim4PmyeSRC2zOohSsJPlAFNSJUhl/+UY8q/SnMpVgehYxsedWOM0dX2dkOz2d8T8o8uG/pDy7DxbzXQ9iFuPxdNJIOQxtvBcXuM5T+7Q+0LaniPI3eZmDg6RivOX0G5mop/3J034K/q73nqxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiYXXsf5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiYXXsf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53211F000E9;
	Wed,  5 Aug 2026 16:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948858;
	bh=LomNrTwfUghBLtw8pruEIdjOnzBlW2jy2hvg6IDyNQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hiYXXsf5l4ipSWL+908ZrIFpoqj4OiBmGzprF59jomn0pXAbbV56oHNsxUmOyg/ZX
	 lf2kqn/kxqzB7KjuWPhfApxRkWxGfvFv7KlCrfFqw8YxXg7CR36Q5lDU3g89Rtmrso
	 fvWjixVKzCDpWgc0UPGqCyY7TgpmpnCJRZxsZcFhaSurgnE/OY8+CJdb5I5Mf3wvCl
	 QPOJnObFtBnmK0GnjSLVbDxBcrm4cTCICaHwnoDEb//lUts7+SHamUQWdWvObefjtF
	 DISvPODt1AWo2x4d/07mdpV030QtMItr6BIxX+CYHkmU2FnkNmqPLVudgGVWbVWi11
	 1aYMtS+2AxsnQ==
Date: Wed, 5 Aug 2026 17:54:01 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Zi Yan <ziy@nvidia.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
Message-ID: <anNqcgYx08JXvm94@lucifer>
References: <20260805055544.1568534-1-clg@redhat.com>
 <20260805121524.GM27883@nvidia.com>
 <anNkjl0qNHK47WTD@lucifer>
 <20260805165240.GR27883@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805165240.GR27883@nvidia.com>

On Wed, Aug 05, 2026 at 01:52:40PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 05, 2026 at 05:29:34PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Aug 05, 2026 at 09:15:24AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 05, 2026 at 07:55:40AM +0200, Cédric Le Goater wrote:
> > >
> > > > The result: each 256 GB BAR is mapped at 4 KiB granularity -- 67 million
> > > > page faults per GPU instead of a few thousand PMD/PUD faults. On hosts
> > > > with 8 GPUs (2 TB of BAR space), this causes VM boot times to degrade
> > > > severely, with 99.98% of CPU time spent in the VFIO BAR mapping path.
> > >
> > > Broadly upstream we expect people to use iommufd and dmabuf for these
> > > configurations to avoid all this nonsense overhead. :\
> >
> > Point taken on that :) but I think it's generally reasonable in line with the
> > huge PFN map changes to do something like I suggested.
>
> Yeah, for cases like this working with pure PFNs from some non-folio
> source the size should be entirely delegated to the driver, and driver
> should always have the opportunity to place a maximally sized PTE.
>
> It is definately wrong to intermix it with any THP logic. DAX isn't a
> special case, it was just the first place to partially implement
> something that looks like this.

Might actually be worth getting rid of this dumb DAX special case and putting it
in the new thing too actually so it's actually normalised as 'statically mapped
stuff that doesn't allocate isn't gated on THP tunables' alongside huge PFN.

>
> Jason

--
Cheers, Lorenzo
