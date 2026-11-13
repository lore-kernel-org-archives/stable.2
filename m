Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578400;
	b=Tb6p9MubvSzbxJcnrkcNsjF4Q6JmQv71nDL2Gl3jjN+BLMAziSnap0vMgrzGIFUmQI17
	 eqgmT4xOAxO6mXBB1vA70I4UDqOJVwzWABf6ZWGDGEz8NghHm8Yq7msttcvY4eU9QNalg
	 Xh2+wFWSZlvLYMJphWIp/PCR3083e63GfizKMeY9YGfyG3nZRam9WxAX6ETLR66W1cJc8
	 wg0sSwpb7vYhqhzkkfOxrmlpzwn5ZecPF7QoPmMdPbR9eKtB6OSNQLOIQQoza+hASRcyI
	 nj/mVcVx9XJweK27zH7eBIiQtAfGAZYY5481xhBTZ5PXCW8v2Pimy6TmKhoCoiJMCBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578400;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=etnvj+JpgQdzFYHD+qJZ07knY/Y3hXQM/Aj2QDnzPPA=;
	b=3Ovkn0Jx8yu6neHG9exQNixkK+ambLRlqPUYhhL9x+V1qoZNIzr0DjQRO3KxEYR223n8
	 bpsHkHs3j0QNA2KTn079VMSIkZ1bZdZ2kDawF86IBO8w7NoOi/mj+HTkZa8ovWV/qDibO
	 dTlLAx9I3uE9/vv5HqAlhF8Rrs1tshiKw9L6QIDJdcD1Gy67KGEarEiGBk07gnC/luVfs
	 t3KO+Vv3I3eFx66764tm0VTf1I/A2RbTxVUSKpQXI9kpC4eA3DTt/Mtg8OpGkKTlXS4hF
	 HehE+w4iF2SnhQipRtyOWpbtq4QxD6LEsuGEv7il64EoaqHM9S8lOFfrtFrGYtSzgKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nkcpuIX/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628F606A887;
	Fri, 13 Nov 2026 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkcpuIX/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B711F000C4;
	Fri, 13 Nov 2026 13:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578400;
	bh=etnvj+JpgQdzFYHD+qJZ07knY/Y3hXQM/Aj2QDnzPPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nkcpuIX/hkjOJiARgEwaRBrnD0nUe+XNzRzHsWN2UnVLWwMWj+pw+6ethAkRONvx9
	 axQgvhJKZMaDkI4WgZjMjC7qbTWAZ/0PbWTT+AIJuRsaA5+S2t1gSpgukGd1mjtBKu
	 pPuwar1JLlxyUmfxwaDJCN171SuztT1SAURIbeZNEXds7GTJUpGrYqJUDgt7Vo4rTs
	 mQjmE9zbcYr4jvL3+89weq9Kx0R/AVUoXVtTa/kb+S5IBu53cAAUx6/kCdqzsi4ZOw
	 2POlwbzlsB8tGQg8xYz6MDFovOoQPmuenp6of0f+M27wjXYcpIBR71Qf7j5lU1AMdA
	 ADOc8KC+feT0g==
Date: Fri, 13 Nov 2026 13:59:53 +0000
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
Message-ID: <avcNcL6svEOTg_3r@gremlin>
References: <20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org>
 <0e3e876e-c3df-4660-ad89-a5f0fd7dedc8@kernel.org>
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
In-Reply-To: <0e3e876e-c3df-4660-ad89-a5f0fd7dedc8@kernel.org>

On Fri, Nov 13, 2026 at 12:59:00AM +0100, David Hildenbrand (Arm) wrote:
> On 11/12/26 18:38, Lorenzo Stoakes (ARM) wrote:
> > In order to establish guard regions, guard markers are installed in the
> > page tables of a mapped VMA.
> >
> > However, problems arise when one tries to combine this with registering a
> > VMA for userfaultfd, as such operations may themselves need to install page
> > table markers such as uffd-wp.
>
> How does this interact with UFFDIO_POISON markers that can outlive even
> userfaultfd registration?

The zap clears poison markers, as is standard. It's really horrible this logic.

So the code path for zap used by the guard install (via zap_vma_range()) is:

zap_vma_range()
  -> zap_vma_range_batched() with NULL zap_details
    -> __zap_vma_range()
      -> zap_p4d_range()
        ...
        -> zap_pte_range()
          -> do_zap_pte_range()
            -> zap_nonpresent_ptes()

And zap_details is NULL.

In zap_non_present_ptes():

	...
	} else if (softleaf_is_uffd_wp_marker(entry)) {
		if (... !zap_drop_markers(details))
			return 1;
	} else if (softleaf_is_guard_marker(entry)) {
		...
		if (!zap_drop_markers(details))
			return 1;
	} else if (softleaf_is_hwpoison(entry) ||
		   softleaf_is_poison_marker(entry)) {
		if (!should_zap_cows(details))
			return 1;
	} ...

And zap_drop_markers() checks zap_details && zap_details->flags &
ZAP_FLAG_DROP_MARKER.

However the poison markers only guards against !should_zap_cows(), which
returns true if NULL details.

What a mess...!

But obviously this patch doesn't change any of that.

>
> I'd assume it's just the same thing, just like having proper hwpoison marker in
> anon mappings, so it just works (uffd-wp will skip, guard installation will zap).

For poison markers yes, as per above.

>
> >
> > When this installation is attempted the guard marker prevents these markers
> > being applied, which can lead to unexpected results (especially if the
> > guard regions are later removed.)
> >
> > This is especially problematic because guard region installation causes the
> > regions to be zapped first, meaning that the removal of userfaultfd-tracked
> > ranges will not be logged in this case.
>
> Again, similar to trying to uffd-wp-protect'ing a hwpoison marker (which will be
> ignored), and then zapping that.
>
> Isn't guard marker installation/removal just another form of zapping?

I mean users being weird could decide to use it for that rather than
MADV_DONTNEED, but zapping is a side effect really.

Really the idea is that you might have users who, for whatever reason,
faulted in some range, and now want to make that a guard range, so for
convenience we zap it for them :)

>
> So to me this all sounds like "if user space does something stupid, it's user
> space's fault".

Unfortunately, as per Tal's series, there's more to it than that (linked in
Closes: tags).

You can get an infinite syscall restart (ugh) if you do this on a shmem
range (Tal's 9/12) so it's a kernel bug that _has_ to be fixed.

The other bits are just about a user losing track of uffd stuff if they
guard/unguard, as you say.

But every other zap code path does the uffd remove event stuff, so this is
still an exception.

If you support uffd, you have to add a whole bunch of horrifying, awful,
terrible open-coded uffd crap, e.g. the userfaultfd_remove() etc. And you
have to drop the bloody lock and reacquire it too and make sure all that
works correctly (...!)

Anyway there's basically 3 options here:

1. do something like what Tal's series does - add a TON of complexity for a
   use case that nobody uses to get behaviour on something nobody sane
   should care about (i.e. uffd/guard/unguard/expect uffd correctness).

2. Zap with ZAP_FLAG_DROP_MARKER, and silently lose uffd-wp state but
  'support' uffd. It does fix the 9/12 bug but then subtly breaks uffd.

3. Disallow uffd.

1 is totally unacceptable + will likely expose us to new bugs (dropping the
lock is just... yeah no thanks), 2 just seems broken, so 3 (which is what
this does) seems the right way to do things.

Basically, right now, anybody using uffd + guard regions in this way is
experiencing silent bugs.

So option 3 is by far the best course of action. And no action isn't an
option.

>
> >
> > Therefore, disallow this.
> >
> > This makes sense as conceptually, guard regions mark a part of a VMA as
> > effectively unmapped at the page table level, and removing the markers is
> > like mapping the VMA again, over which operation uffd markers would in any
> > case be lost.
>
> Right, but that to me just says "on the parts of the VMA where you mess with
> guard markers, your uffd-wp protection is similarly ignored".

As per above on unfortunate need to do something here.

>
> So disallowing it entirely for a VMA, I am not sure. I could see use cases for
> that, although you might argue that user space should then register uffd-wp on
> the separate pieces. But then you get multiple VMAs again.

I did a survey of open source software out there - glibc, android,
tcmalloc, CRIU - and none of them rely on this.

So in general there's no signs that anybody actually does this, and if they
do, it's literally currently broken. And we've had no bug reports for some
time now.

So I think it's fine (IOW this patch is fine :P)

If you're really concerned though, we could go with option 2, which will
just make UFFD behave differently for guard regions.

(I regret, obviously, ever allowing this for uffd ranges. And we _all_
 regret that uffd was _ever_ allowed to be merged in this state...)

--
Cheers, Lorenzo
