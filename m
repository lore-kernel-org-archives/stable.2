Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5029A42B725;
	Thu,  6 Aug 2026 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007496; cv=none; b=kXnMYn20IanvP8Ey4NGz3KEGw8IKzoLiArSuPgISfmD9NFzXqhnAiwXCzuzwjnTT8Nr7mkuZaLGQvpcMliaHglnJL/2w4ODp1eUB9dTKKxJ212CSfudlkaGbEGNtCcCOXa0SYpiGo0l+hkXYI0MBp7crNW/y0S0SafN8klueaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007496; c=relaxed/simple;
	bh=HyC95j+iC6JRdSkBVf0x1rT0mxmIMJ/SHoyhxy2QTTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMrSJol3DNQ3APFd8/tag3Xcol860Q89eWuBnwwvjlAhi32xzdm4FoRbvaNC32yxLQxAPHrud+dxqwXX0i+HnL2tgS32Va6ZswWLXLET5JZFYkd4+ek7u24EDlwqAUbitoQ4ctIg+OpJyQgMcIXCyEzlBwbv0bpkkEC/+CcE740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyLZ3Zh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyLZ3Zh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB891F000E9;
	Thu,  6 Aug 2026 09:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007494;
	bh=in93mgYbw0F04Zxk1y2Zn0DH94LyJQ4nBw9npqUTqbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DyLZ3Zh31dW5z00axg0BKCzVlVa7D7QuO9L9lSSWy/WGXglK73KJqRoOBLZFyFxZi
	 zmRJwFsNtTbD+WCrIz2DACQ5RloEdH0v6wKvmoGdHmFcBVEK3x1agC+PfXfRYVDDGg
	 6Bwmehy15falLfdD4IzxdAmEbOTOC6LdnDZyNYNyPTq2Iob4nt4rUwO6IJwn3CxYBy
	 eQ7iVcNziIRujMXenBGqPiO+QwBPColW6sNa67PoYU/WtE+OX6XJNSNiOAicQeq2Ca
	 Xn9o1cehGIA+Kb4v7gzBMzQa9jS3CZcCB14KG7y/GP3zTPgjmCwipqVgURhOUU8FGg
	 hSfJLoFIDBntg==
Date: Thu, 6 Aug 2026 10:11:17 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, 
	vbabka@kernel.org, jannh@google.com, 00moses.alexander00@gmail.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/madvise: avoid skipping pages after splitting
 large folios
Message-ID: <anQyoZgi5Urnvvjw@lucifer>
References: <20260806055501.56761-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806055501.56761-1-cuiyunhui@bytedance.com>

As a newer contributor to mm please wait for feedback on a v1 from reviewers
before respinning, thanks :)

On Thu, Aug 06, 2026 at 01:55:01PM +0800, Yunhui Cui wrote:
> madvise_inject_error() advances through the requested range using the
> size of the page returned by get_user_pages_fast(). Saving the size
> before error injection is required for hugetlb pages because successful
> soft offlining can dissolve the source huge page.

But you're also changing the behaviour for MADV_HWPOISON not only
MADV_SOFT_OFFLINE? Explain?

Also mention the specific madvise flags...

>
> That stride is incorrect for non-hugetlb large folios in system memory.
> The memory failure handlers split such a folio and handle only the base
> page for the supplied PFN. Advancing by the pre-split folio size then
> skips the remaining pages in the requested range while madvise() still
> reports success.

As Andrew also asks:

How did you find out about this? Is this a theoretical issue?

Why? What? Who?...

>
> Advance by PAGE_SIZE for non-hugetlb folios in system memory. Retain
> folio_size() for hugetlb and ZONE_DEVICE folios, as compound Device DAX
> folios are handled as a whole.

You get a folio to check to see if it's DAX when you have the VMA that you can
check for DAX?...

>
> Fixes: 19bfbe22f59a ("mm, hugetlb, soft_offline: save compound page order before page migration")

4.14...!

> Cc: stable@vger.kernel.org

Stuff that touches folio and soft offline-adjacent THP is going to be tricky to
backport correctly.

And in madvise(2):

              This feature is intended for testing of memory error-
              handling code; it is available only if the kernel was
              configured with CONFIG_MEMORY_FAILURE.

For both MADV_SOFT_OFFLINE and MADV_HWPOISON.

So I don't see why this should be backported. You might accidentally not quite
offline/poison everything you intended in a test but that isn't a bug?

Given nobody's complained in nearly a decade I don't think this matters.

Also you're suggesting backporting to pre-folio ancient times which is going to
make this horrid and tricky there too.

> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

This could really do with a test to reproduce the issue. Mm selftests already
has memory failure stuff.

Please provide one to demonstrate the issue.

> ---
>  mm/madvise.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 5a09cc24f04a0..e9d4c3bbc5290 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1455,20 +1455,25 @@ static int madvise_inject_error(struct madvise_behavior *madv_behavior)
>
>  	for (; start < end; start += size) {
>  		unsigned long pfn;
> +		struct folio *folio;
>  		struct page *page;
>  		int ret;
>
>  		ret = get_user_pages_fast(start, 1, 0, &page);
>  		if (ret != 1)
>  			return ret;
> +		folio = page_folio(page);
>  		pfn = page_to_pfn(page);
>
>  		/*
> -		 * When soft offlining hugepages, after migrating the page
> -		 * we dissolve it, therefore in the second loop "page" will
> -		 * no longer be a compound page.
> +		 * Non-hugetlb large folios in system memory are split and only

'non-hugetlb large folios' is horrid. Large folios. And 'system memory' is
redundant.

> +		 * the addressed base page is handled. Hugetlb folios may be
> +		 * dissolved and ZONE_DEVICE folios may be handled as a whole,
> +		 * so save their size before error injection.
>  		 */

You're discarding the whole thing of the page no longer being the head. But I
guess with folios we don't need to mention that.

This whole thing can made more succinct like:

		/* DAX and hugetlb are consumed in folio chunks, everything else is split. */

> -		size = page_size(compound_head(page));

Yuck at this existing code.

> +		size = PAGE_SIZE;
> +		if (folio_test_hugetlb(folio) || folio_is_zone_device(folio))
> +			size = folio_size(folio);

It's really disgusting that hugetlb is treated differently with everything else
treated page-at-a-time.

Honestly I'd prefer to see a folio helper so the main loop can just assume
folio size stride.

But you can enter midway through a bloody folio. Ugh. So maybe that doesn't
work.

Let's at least split out the folio check into a helper to make things
clearer:

static bool poison_splits_folio(const struct folio *folio)
{
	/* Hugetlb is, as always, a world unto itself. */
	if (folio_test_hugetlb(folio))
		return false;
	/* Soft-offline errors out, hwpoison traverse DAX intact. */
	if (folio_is_zone_device(folio))
		return false;
	return true;
}

Then for your patch:

-		size = PAGE_SIZE;
-		if (folio_test_hugetlb(folio) || folio_is_zone_device(folio))
-			size = folio_size(folio);
+		size = poison_splits_folio(folio) ? PAGE_SIZE : folio_size(folio);

I tried writing something that was neater and nicer but AI kept pointing
out how it was totally broken and I really really hate this code (not your
fault :).

--
Cheers, Lorenzo
