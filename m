Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597732;
	b=HkKB78wG7LvKoboR1Q6uwW9a3+V3/3PqtmsrRWckFSDFnYf4XBggsLuRJrKs0JIHqd9q
	 Ey48oV9frA0KJcartBID57JHFisDeBRDYdNyhPg9zxw3cchkAZpnLKiElNXAZHHRyaBw+
	 qTaZhCRiH1p+azzsmJk+cPi6Jr8lYunl+RBSNgj074moqkKuiWi6QoLixXwauz1cmD4iQ
	 0OzTCjUvRFDb2nlZhhbtXSUxZNpEaG36vOVwb/CLgQHBMgG12ZoqoU7WK6TCsW7XuBFdk
	 3tupPtMQBmp+2fSSN0EZtzY0jsd1tWp2m4mooTA+qMdljqUXa8cd2wVhdlgAuQ2eAwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597732;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Fdl4VOJT6zViP7jtfnU1Xg3aoOGQL41O0hxbPwDlR+A=;
	b=nIyV2fQezND2RRdbuMaUvbtTZiCj+TlgBR/g877ffslgzdabz5gIbn3Z8J8GBTJ1j8z5
	 Vb8zAzi2cWHYYBdMqdDAVzUkcKo8+ah2Lel83/gCMjDffRxyBKUzWU0i7QKThpC25lwR2
	 AlIVCd5Avi8TWBJxRW0uwv/yPXbpA10YmMNhKJavaGllyxq0zsF4dMcm2nbehHF5G2sEL
	 SRCMHDiRb1rchL13uzr9HwaS/WE3PcyCikjsxzxAFQkh87KlzToxfOJxPh5AAzGq0L9DX
	 vPWcSfBOBmH8qS47EULGndAK9iWV6B76Doa1RPDQl73DYPG5e5ImeFTjsMFjKibolLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NX6l4vlx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF3606A890;
	Fri, 13 Nov 2026 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NX6l4vlx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10861F000C8;
	Fri, 13 Nov 2026 19:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597732;
	bh=Fdl4VOJT6zViP7jtfnU1Xg3aoOGQL41O0hxbPwDlR+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NX6l4vlxAsFOjaj+ZundCIjebkwjdIPIUBB6r6xto4qN1LhAmxdOJZlzrDEKEFlHX
	 HE+RzVuSSPFuI5p/wzPEd1EWoL48luhiQrH5Fuylbug07Ef3zaiXlkH2raN+byKwcx
	 ETtjAefB4pa1W94nXtaIlrAAzMDf7b2jtwqGkoqUv3j2kS3nzrIYUPM0FCJ6ZQ/TUH
	 Pg9l/Ahp2pnUhstVIekqNTSYv5F0iZAVv+3d7lVWPZopB2q+jIlDKPVOg625y+x55w
	 2HbExloMEtf2bl5fPgILQoRc23yrhUKrH3yaVEEApNzX0fSs170YpwQdkw5kr35VOZ
	 TavaBPQLZKR1g==
Date: Fri, 13 Nov 2026 19:22:06 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Tal Zussman <tz2294@columbia.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: disallow guard region installation in
 uffd-armed VMAs
Message-ID: <avdjMNNkOXm2khTW@gremlin>
References: <20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org>
 <0e3e876e-c3df-4660-ad89-a5f0fd7dedc8@kernel.org>
 <avcNcL6svEOTg_3r@gremlin>
 <0d6e29f8-54fc-427a-a979-1a8c6f4e3f06@kernel.org>
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
In-Reply-To: <0d6e29f8-54fc-427a-a979-1a8c6f4e3f06@kernel.org>

On Fri, Nov 13, 2026 at 08:15:34PM +0100, David Hildenbrand (Arm) wrote:
> On 11/13/26 14:59, Lorenzo Stoakes (ARM) wrote:
> > On Fri, Nov 13, 2026 at 12:59:00AM +0100, David Hildenbrand (Arm) wrote:
> >> On 11/12/26 18:38, Lorenzo Stoakes (ARM) wrote:
> >>> In order to establish guard regions, guard markers are installed in the
> >>> page tables of a mapped VMA.
> >>>
> >>> However, problems arise when one tries to combine this with registering a
> >>> VMA for userfaultfd, as such operations may themselves need to install page
> >>> table markers such as uffd-wp.
> >>
> >> How does this interact with UFFDIO_POISON markers that can outlive even
> >> userfaultfd registration?
> >
> > The zap clears poison markers, as is standard. It's really horrible this logic.
> >
> > So the code path for zap used by the guard install (via zap_vma_range()) is:
> >
> > zap_vma_range()
> >   -> zap_vma_range_batched() with NULL zap_details
> >     -> __zap_vma_range()
> >       -> zap_p4d_range()
> >         ...
> >         -> zap_pte_range()
> >           -> do_zap_pte_range()
> >             -> zap_nonpresent_ptes()
> >
> > And zap_details is NULL.
> > > In zap_non_present_ptes():
> >
> > 	...
> > 	} else if (softleaf_is_uffd_wp_marker(entry)) {
> > 		if (... !zap_drop_markers(details))
> > 			return 1;
> > 	} else if (softleaf_is_guard_marker(entry)) {
> > 		...
> > 		if (!zap_drop_markers(details))
> > 			return 1;
> > 	} else if (softleaf_is_hwpoison(entry) ||
> > 		   softleaf_is_poison_marker(entry)) {
> > 		if (!should_zap_cows(details))
> > 			return 1;
> > 	} ...
> >
> > And zap_drop_markers() checks zap_details && zap_details->flags &
> > ZAP_FLAG_DROP_MARKER.
>
> Right, my intuition tells me to just nuke that thing by setting
> ZAP_FLAG_DROP_MARKER.
>
> MADV_GUARD, is just like munmap() another form of "zap it all and protect it".
> >>> This is especially problematic because guard region installation causes the
> >>> regions to be zapped first, meaning that the removal of userfaultfd-tracked
> >>> ranges will not be logged in this case.
> >>
> >> Again, similar to trying to uffd-wp-protect'ing a hwpoison marker (which will be
> >> ignored), and then zapping that.
> >>
> >> Isn't guard marker installation/removal just another form of zapping?
> >
> > I mean users being weird could decide to use it for that rather than
> > MADV_DONTNEED, but zapping is a side effect really.
> >
> > Really the idea is that you might have users who, for whatever reason,
> > faulted in some range, and now want to make that a guard range, so for
> > convenience we zap it for them :)
>
> I think not just convenience. There was this problem with faultaround / THP
> placement IIRC ...
>
> I'd just zap everything that's there. That's literally what the user asked for.
>
> >
> >>
> >> So to me this all sounds like "if user space does something stupid, it's user
> >> space's fault".
> >
> > Unfortunately, as per Tal's series, there's more to it than that (linked in
> > Closes: tags).
> >
> > You can get an infinite syscall restart (ugh) if you do this on a shmem
> > range (Tal's 9/12) so it's a kernel bug that _has_ to be fixed.
> >
> > The other bits are just about a user losing track of uffd stuff if they
> > guard/unguard, as you say.
> >
> > But every other zap code path does the uffd remove event stuff, so this is
> > still an exception.
> >
> > If you support uffd, you have to add a whole bunch of horrifying, awful,
> > terrible open-coded uffd crap, e.g. the userfaultfd_remove() etc. And you
> > have to drop the bloody lock and reacquire it too and make sure all that
> > works correctly (...!)
> >
> > Anyway there's basically 3 options here:
> >
> > 1. do something like what Tal's series does - add a TON of complexity for a
> >    use case that nobody uses to get behaviour on something nobody sane
> >    should care about (i.e. uffd/guard/unguard/expect uffd correctness).
> >
> > 2. Zap with ZAP_FLAG_DROP_MARKER, and silently lose uffd-wp state but
> >   'support' uffd. It does fix the 9/12 bug but then subtly breaks uffd.
>
> Right, that's what I would do.
>
> MADV_GUARD_INSTALL zaps everything.
>
> It already zaps swap entries, migration entries, hwpoison entries ... so just
> zap everything.
>
> [...]
>
> >
> > If you're really concerned though, we could go with option 2, which will
> > just make UFFD behave differently for guard regions.
> >
>
> Not really concerned, it's just the most consistent one for me. Zap everything.
> The user asks for it, like he would ask with munmap().
>
> > (I regret, obviously, ever allowing this for uffd ranges. And we _all_
> >  regret that uffd was _ever_ allowed to be merged in this state...)
> Yeah ...

Ack will send a v2 doing that then :)

Heads up that (naturally) the subject line will differ!

--
Cheers, Lorenzo
