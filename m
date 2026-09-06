Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C43B5846;
	Sun,  6 Sep 2026 02:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661885; cv=none; b=iT1VNQyiWTDlAbUygUoXfmgs9wyuum1ZpWN6hTzfxfyZnpiVCUZ8b9WtfMsvjbfKSH7LdPSQWpngXanHzZITcqn6WpTc3U+7xbxuDZrjY+RZTLHYK//sHzvw9GuD/gOdWx66k9COniWW7f21v62ye1lqws0WZ1Fm1HWL+GdgN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661885; c=relaxed/simple;
	bh=TssNGCerD5sl6kSeAJSUfglIZDQEtphJlgkUglr0yd8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kT7hN+ev5k7jmjBoQWFBzGLeQejdYr0aUitpWnB943s78tsMu12NTy9WoG5Om002+whl/cRdXMO1kt10ekp4WZ9hA1ZggnYTWzfwmV+9dlCpa08oSpSWI7mv3LT4jQ9fJgEYvULAbfZwMqoIs4MUuLYDqx3xJmqUVMw64QJAz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JiOzH9hU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JiOzH9hU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D201F00A3A;
	Sun,  6 Sep 2026 02:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788661883;
	bh=dVYnYKeM4V2pRuhTBVBMHS1mPU9NDYVJ/TRJ5gtWSOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JiOzH9hU/p7vG6ADzKrmNQzVawhymrYC534PZ7ensT15Jw8U+wDC7/NSUWdqIBOor
	 FYOBDhcJoDNq5bCQjr7PF82t/1SO3Tpx4W27bfnYyQbGAEuIS8IGogsJwgsae3dwv2
	 uwxAhe72T26Euru4ZB+qahaygusdDhol552FAeyw=
Date: Sat, 5 Sep 2026 19:31:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: mawupeng1@huawei.com, Muchun Song <muchun.song@linux.dev>, Oscar
 Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/hugetlb: fix max-only subpool accounting on
 alloc_hugetlb_folio failure
Message-Id: <20260905193122.76f5d3245cd2e0603e7743b7@linux-foundation.org>
In-Reply-To: <20260428113037.88766-2-enderaoelyther@gmail.com>
References: <20260427145247.84157-2-enderaoelyther@gmail.com>
	<20260428030712.66256-2-enderaoelyther@gmail.com>
	<20260428113037.88766-2-enderaoelyther@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 19:30:38 +0800 Zhao Li <enderaoelyther@gmail.com> wrote:

> alloc_hugetlb_folio() calls hugepage_subpool_get_pages() when map_chg
> is set.  For a subpool with max_hpages != -1, that bumps used_hpages
> regardless of whether it returns gbl_chg = 0 (rsv slot consumed) or
> gbl_chg > 0 (used_hpages slot only).  If the allocation later fails
> before a folio is returned, the unwind must undo the used_hpages
> bump.  The old cleanup only ran for !gbl_chg, leaking used_hpages on
> the gbl_chg > 0 path.
> 
> For gbl_chg > 0 on max-only subpools (max_hpages != -1, min_hpages
> == -1), hugepage_subpool_get_pages() took only a speculative
> used_hpages slot.  Drop that slot directly under spool->lock.  In
> that configuration hugepage_subpool_put_pages() cannot restore
> rsv_hpages, so the direct decrement is the exact inverse and is
> race-free against concurrent puts.  This matches the used_hpages-only
> part of hugetlb_reserve_pages()'s out_put_pages cleanup, but
> restricts it to the max-only case where no rsv_hpages restoration is
> possible.
> 
> Mounts with min_hpages != -1 are left unchanged for now.  v2's
> approach (hugepage_subpool_put_pages() + h->resv_huge_pages++ to
> back a restored rsv_hpages slot) double-counts global backing under
> concurrent free_huge_folio() and creates phantom reservations under
> concurrent hugetlb_unreserve_pages().  Safe cleanup of that quadrant
> needs a coordinated fix across multiple call sites.
> 
> Reproduced on size=20M hugetlbfs with the faulting task in a hugetlb
> cgroup whose limit is exceeded.  Vanilla leaks 6/8 hugepages of
> subpool quota; this patch leaks 0/8.  Verified under QEMU.

Thanks.

I do like to see a clear statement of the user-visible effects of bugs
when we fix them.  "subpool quota leak" sounds bad, but how does this
visibly manifest?

I asked you-know-what and came up with

  Failed hugetlbfs page allocations can permanently consume the
  mount's size= quota without allocating a huge page.  Repeated
  failures can make the filesystem appear full and cause later
  huge-page faults or allocations to fail with SIGBUS/allocation
  failure despite available huge pages and unused real filesystem
  capacity.

Which I'll paste in there.  Because I do like to tell downstream people
why we want a backport, and to help further downstream people to
understand whether this might fix a problem they're having.  Please lmk
if it's inaccurate/incomplete.

I'll queue this as a backportable hotfix and shall await further
reviewer input.
