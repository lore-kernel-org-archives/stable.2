Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604190;
	b=RzT9gmsNiOJBgcLCvbRAYxD1Cu5dOFw+vEStGctsO1VhnbenJdFTb7Dieh4YcswaWRO8
	 ES8HVAq5e5UrT+Gz7y6JI9Hi0rtbA3/4cmDgil+JnmG5LyY1KJqt3Y6x6pd0G0U4UPaGl
	 uXZ8w2qMw477ww805mzNDP+WFZqZrGiqV0jJiFCVYObdIVtHLGjRkCYjvUxLJ7XJ0V1Xg
	 qyWIcBsqa66dfGizA6BGj2KdJuOPb/7RfsuRqezM0IePkqPhRO3sFHO/iw9w1mBJHqit1
	 aqVmGvmlHCQWsPW6xS4lZOzJVLGxo1/EekIZ+hg+F8ujs1AomGcm6FQDx0VBUk+VFKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604190;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Wtd2KDMKHjgdTYZDJFa9BcqH5dMoFb2/KH89jf9oLn0=;
	b=ioiErzlRunAJTdaCSK6FTdWrxdL9PPr2StxZZu1fu9qWreAv84vtQ/1KqDKEl3Xe7aRn
	 Mwp7iYXlfDylIX/W4///igWAJisTKvhrDDi805HUKj2bbjlWizujScSDW5x5O7UJlBgks
	 2z4L3yXAvg76JAih7NPau9Mc2hjIno5dZC0/S29kHfL7tn+L3LUdW+HLAICRrcgKkiX9p
	 YFvAx1tJ6nMvmYSLTbZWNEnb6zpYUQ9e4xJC7+KI16yKN/HiuahFQdl1rykt2NYsJyKfP
	 g+bofQLVcpqXW6LFjb7KJnM0NViaVrvvrlKi4PG6wRAZUgJRyR+7wsWK0OvfAHDgnow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bR7oYPNx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66460A6F6E;
	Fri, 13 Nov 2026 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bR7oYPNx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2591B1F000C4;
	Fri, 13 Nov 2026 21:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604190;
	bh=Wtd2KDMKHjgdTYZDJFa9BcqH5dMoFb2/KH89jf9oLn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bR7oYPNxZlKgNdYEqiHrDBRrMaL2b5ONCmZ8lutbhmVhxtVH6WRk6YYJf42ZC2F7k
	 WgZP5cHcDlKZ1Lfh6e3d946/KzOAXUgEUimc4GmgeO964LUTL48WkUwTYvTDilFhlZ
	 InlQLb0ybNidY57Kk8+TjP/5L8I5ZSSb755JzsRL+9y0XhABWI5FsU2zQTE7bymW0x
	 5oy6xCBnqrV+m4hM7mpNS+2SAnZFo8sdVxbiiO/pI7f+6EXPGHG1zYhF9ckvZuZRtf
	 5q+WOwORKzCiqMk/+15c8Q0VXJ4SjcUCq1b7uGTybOYprX3I/upShUcBc0CiegBCq6
	 rywkHZwxP/kmA==
Date: Fri, 13 Nov 2026 21:09:44 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: disallow guard region installation in
 uffd-armed VMAs
Message-ID: <avd6XEHndh30hyc-@gremlin>
References: <20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org>
 <0e3e876e-c3df-4660-ad89-a5f0fd7dedc8@kernel.org>
 <avcNcL6svEOTg_3r@gremlin>
 <0d6e29f8-54fc-427a-a979-1a8c6f4e3f06@kernel.org>
 <avdjMNNkOXm2khTW@gremlin>
 <f53458fd-c268-4dfe-aa99-b050f63af728@columbia.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53458fd-c268-4dfe-aa99-b050f63af728@columbia.edu>

On Fri, Nov 13, 2026 at 03:55:41PM -0500, Tal Zussman wrote:
> On 11/13/26 2:22 PM, Lorenzo Stoakes (ARM) wrote:
> > On Fri, Nov 13, 2026 at 08:15:34PM +0100, David Hildenbrand (Arm) wrote:
> >> On 11/13/26 14:59, Lorenzo Stoakes (ARM) wrote:
> >> > On Fri, Nov 13, 2026 at 12:59:00AM +0100, David Hildenbrand (Arm) wrote:
> >> >> On 11/12/26 18:38, Lorenzo Stoakes (ARM) wrote:
> >> >>> In order to establish guard regions, guard markers are installed in the
> >> >>> page tables of a mapped VMA.
> >> >>>
> >> >>> However, problems arise when one tries to combine this with registering a
> >> >>> VMA for userfaultfd, as such operations may themselves need to install page
> >> >>> table markers such as uffd-wp.
> >> >>
> >> >> How does this interact with UFFDIO_POISON markers that can outlive even
> >> >> userfaultfd registration?
> >> >
> >> > The zap clears poison markers, as is standard. It's really horrible this logic.
> >> >
> >> > So the code path for zap used by the guard install (via zap_vma_range()) is:
> >> >
> >> > zap_vma_range()
> >> >   -> zap_vma_range_batched() with NULL zap_details
> >> >     -> __zap_vma_range()
> >> >       -> zap_p4d_range()
> >> >         ...
> >> >         -> zap_pte_range()
> >> >           -> do_zap_pte_range()
> >> >             -> zap_nonpresent_ptes()
> >> >
> >> > And zap_details is NULL.
> >> > > In zap_non_present_ptes():
> >> >
> >> > 	...
> >> > 	} else if (softleaf_is_uffd_wp_marker(entry)) {
> >> > 		if (... !zap_drop_markers(details))
> >> > 			return 1;
> >> > 	} else if (softleaf_is_guard_marker(entry)) {
> >> > 		...
> >> > 		if (!zap_drop_markers(details))
> >> > 			return 1;
> >> > 	} else if (softleaf_is_hwpoison(entry) ||
> >> > 		   softleaf_is_poison_marker(entry)) {
> >> > 		if (!should_zap_cows(details))
> >> > 			return 1;
> >> > 	} ...
> >> >
> >> > And zap_drop_markers() checks zap_details && zap_details->flags &
> >> > ZAP_FLAG_DROP_MARKER.
> >>
> >> Right, my intuition tells me to just nuke that thing by setting
> >> ZAP_FLAG_DROP_MARKER.
> >>
> >> MADV_GUARD, is just like munmap() another form of "zap it all and protect it".
> >> >>> This is especially problematic because guard region installation causes the
> >> >>> regions to be zapped first, meaning that the removal of userfaultfd-tracked
> >> >>> ranges will not be logged in this case.
> >> >>
> >> >> Again, similar to trying to uffd-wp-protect'ing a hwpoison marker (which will be
> >> >> ignored), and then zapping that.
> >> >>
> >> >> Isn't guard marker installation/removal just another form of zapping?
> >> >
> >> > I mean users being weird could decide to use it for that rather than
> >> > MADV_DONTNEED, but zapping is a side effect really.
> >> >
> >> > Really the idea is that you might have users who, for whatever reason,
> >> > faulted in some range, and now want to make that a guard range, so for
> >> > convenience we zap it for them :)
> >>
> >> I think not just convenience. There was this problem with faultaround / THP
> >> placement IIRC ...
> >>
> >> I'd just zap everything that's there. That's literally what the user asked for.
> >>
> >> >
> >> >>
> >> >> So to me this all sounds like "if user space does something stupid, it's user
> >> >> space's fault".
> >> >
> >> > Unfortunately, as per Tal's series, there's more to it than that (linked in
> >> > Closes: tags).
> >> >
> >> > You can get an infinite syscall restart (ugh) if you do this on a shmem
> >> > range (Tal's 9/12) so it's a kernel bug that _has_ to be fixed.
> >> >
> >> > The other bits are just about a user losing track of uffd stuff if they
> >> > guard/unguard, as you say.
> >> >
> >> > But every other zap code path does the uffd remove event stuff, so this is
> >> > still an exception.
> >> >
> >> > If you support uffd, you have to add a whole bunch of horrifying, awful,
> >> > terrible open-coded uffd crap, e.g. the userfaultfd_remove() etc. And you
> >> > have to drop the bloody lock and reacquire it too and make sure all that
> >> > works correctly (...!)
> >> >
> >> > Anyway there's basically 3 options here:
> >> >
> >> > 1. do something like what Tal's series does - add a TON of complexity for a
> >> >    use case that nobody uses to get behaviour on something nobody sane
> >> >    should care about (i.e. uffd/guard/unguard/expect uffd correctness).
> >> >
> >> > 2. Zap with ZAP_FLAG_DROP_MARKER, and silently lose uffd-wp state but
> >> >   'support' uffd. It does fix the 9/12 bug but then subtly breaks uffd.
> >>
> >> Right, that's what I would do.
> >>
> >> MADV_GUARD_INSTALL zaps everything.
> >>
> >> It already zaps swap entries, migration entries, hwpoison entries ... so just
> >> zap everything.
> >>
> >> [...]
> >>
> >> >
> >> > If you're really concerned though, we could go with option 2, which will
> >> > just make UFFD behave differently for guard regions.
> >> >
> >>
> >> Not really concerned, it's just the most consistent one for me. Zap everything.
> >> The user asks for it, like he would ask with munmap().
> >>
> >> > (I regret, obviously, ever allowing this for uffd ranges. And we _all_
> >> >  regret that uffd was _ever_ allowed to be merged in this state...)
> >> Yeah ...
> >
> > Ack will send a v2 doing that then :)
> >
> This sounds better to me. My concern in [1] with completely disabling this
> was that it could break a uffd manager that doesn't control the task it
> manages (e.g. CRIU lazy restore registering the memory of a task whose libc
> uses guard regions), but this should avoid that.

But they were completely broken already? So we're 'breaking' an already broken
user? :)

It's moot, but still!

>
> This still leaves guard installation as the one zap path that doesn't send
> a UFFD_EVENT_REMOVE notification, but for CRIU I think that's fine, since
> guards would mostly go on memory that didn't have contents beforehand, so
> there's no stale contents to restore.

For one, CRIU is userland software that relies on kernel implementation details,
so we are not obliged to keep _kernel_ implementation details stable for them :)

For another, relying on uffd state remaining consistent across the
install/remove of the literal 'put a hole in my address space' feature is deeply
dubious.

>
> I could imagine this mattering for something like a userspace far-memory
> library [2] that registers a heap with uffd MISSING mode. If the allocator
> guards a page that the library has paged out, the library is never told
> to drop its copy, and fills the page with the old contents once the guard
> is removed.

Previously: broken
Now: Not permitted.

I think that's fine ;)

>
> I don't think anything does this today, so it's not worth adding the event,
> but I think this limitation should definitely be documented (i.e., that
> MADV_GUARD_INSTALL discards the range and uffd state without notifying uffd)
> for the sake of the poor souls that work with uffd and to prevent any
> spurious LLM reports in the future...

Documenting things doesn't prevent spurious LLM reports,
unfortunately. Nothing stops the schloppers... ignoring is the only answer,
long-term anyway.

But sure, I'll try to update the manpage for the few humans still reading
these things...

>
> [1] https://lore.kernel.org/linux-mm/f76cb2b0-0090-4554-9169-5cfff6a6ca53@columbia.edu/
> [2] https://www.usenix.org/system/files/nsdi25-yelam.pdf

--
Cheers, Lorenzo
