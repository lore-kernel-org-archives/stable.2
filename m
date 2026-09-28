Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B98C3AAF6B;
	Mon, 28 Sep 2026 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592447; cv=none; b=n4DjNXttPsGx0W+WrVym6mCteGtabRrjM4R4Jri3R46zGw5iF8mt8bsqAg4xPjBHkjgHZ+ZtnXvk7/J8QsXMlsGitplzsJUXaHEybT0f47btCpsTdTVQAnYCpHJ0VusQ/YsBC/bgXSEM1ZUEnoeVl7InWWfpTZxYWRQAm4RkKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592447; c=relaxed/simple;
	bh=v/u8vYf5D5U2dwwBRjUF2CokCyGiN3dRnpgI4GZ1GqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDBN76M2eSiPl+ljyLJmHqSxc40G92SGlizdyOXP8aQ0wakF6q9am1CZzBN3ZxMVjiMJ3xU/DLgogOLhw4Crq/QagDXOyEViMKcpkZhbk3nvNJTV4STHvcmrAQdhtYBfJDiDSy4paljmfRRXOMJUvzOoHqMOu4kODuyZHZJiUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcWfISmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcWfISmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BDE1F000FF;
	Mon, 28 Sep 2026 10:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790592445;
	bh=N+3YGhIQVuikjEH9Od/2nlarFIyWr94t0RF73DpWKTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dcWfISmXrUEC34CHJtUG268tGTaBmUg7RjiPPaT9yNIHownVE9Y8Zc+m8R91JP3wR
	 /+crlSXdh970zzraM+GQ0kgNqkaRu51M0SdYPzcEFONLuut3jAfVTtZVi3d365QBCH
	 d3Uu/tzl9St+6ODsx0yRoswGrHaT4dtPGt7FiCidzPcfH2WxKYf9w8zrF8BIf2Yw4s
	 LvPmL0nNgk9Sb9228wVg+e7qJoiqvHKbGU+m0wx3mSADSObtAamMLFsgA60PIYzhXf
	 I1I5i9PXfQx/6ZyM6879ZhAj3h+H8eGdUDvGezz8yNDRK0GK02zfRDoOM1MwCygZOa
	 SQuIZivFL6Zog==
Date: Mon, 28 Sep 2026 11:47:20 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP
 self-merge
Message-ID: <arpFclevdjhgJGtL@gremlin>
References: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
 <20260920-fix-dontunmap-partial-self-merge-v1-1-6ffb556f8f8b@kernel.org>
 <arpEHIwTy8QxUjI2@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arpEHIwTy8QxUjI2@thinkstation>

On Mon, Sep 28, 2026 at 11:45:21AM +0100, Kiryl Shutsemau wrote:
> On Sun, Sep 20, 2026 at 03:13:10PM +0100, Lorenzo Stoakes (ARM) wrote:
> > The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
> > operations that keep the original VMA in place.
> >
> > Historically this has led to a lot of bugs where non-obvious interactions
> > occur between existing mremap() operations and the original VMA.
> >
> > Fix another of these - self-merge.
> >
> > Self-merge occurs when a VMA is moved in front of or behind itself and the
> > attributes of the VMA permit such a merge.
> >
> > Practically this can only happen for unfaulted anonymous VMAs due to the
> > page offset equality requirement for merge:
> >
> >                            |------------|
> >                            |            |
> >                            |            v
> >         |...........||-----------||...........|
> >         |           || unfaulted ||           |
> >         |...........||-----------||...........|
> >               ^            |
> >               |            |
> >               |------------|
> >
> > This becomes problematic if the VMA is configured by the user to
> > mlock-on-fault, i.e. the VMA_LOCKED_BIT, VMA_LOCKONFAULT_BIT VMA flags are
> > set.
> >
> > MREMAP_DONTUNMAP clears mlock flags for the source VMA and maintains them
> > for the destination VMA.
> >
> > Self-merge makes this impossible (there is only one VMA) and incorrectly
> > clears the destination VMA's mlock flags.
> >
> > This causes a leak in mm->locked_vm as clearing this flag does not
> > decrement the counter and the VMA no longer has VMA_LOCKED_BIT set so it
> > is not decremented on unmap.
> >
> > Resolve this by simply disallowing a self-merge in this case - the source
> > and destination VMAs are kept distinct and then are able to have distinct
> > mlock() flags.
> >
> > Update dontunmap_complete() to make the now-redundant self-merge check a
> > VM_WARN_ON_ONCE() instead to guard against future regressions.
> >
> > Also update the VMA userland tests to reflect the change.
> >
> > Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Thanks!

>
> One thing: mlock semantics of MREMAP_DONTUNMAP are not documented in the
> man pages, only in the commit that added the flag. It can be surprising
> that the source gets munlocked. I am not even sure it is the right thing
> to do.

It's unavoidable as the source no longer has anything mapped (page tables moved)
and it's not correct for it to be marked as mlock()'d in that case.

Ack on man page update, I'll add to my TODO!

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo
