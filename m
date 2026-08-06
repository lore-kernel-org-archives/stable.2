Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A71E5B68;
	Thu,  6 Aug 2026 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030827; cv=none; b=SDUM5IN/C48k2wGg/3JtOrRvHNVnyeuvGRMDSHA+EdVkjc73fMSV5mG1ULhhfrwNbWMmA01bM2FUrNyYMsrYjsxKDqjqegQk8NVeR/JxaDeOVOtYeQ1TynsWyh4XhvoerwihPMaRUrdZ0bQq1QWjfmA6RngNWxwQy/DUOweaqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030827; c=relaxed/simple;
	bh=mc3baeWVpQ25unAsWO4QN5TZhYUmQGaM/ejTmYXoGXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6n/uk7QRRIzTT6wcvBWcyGBVSFWyFHSnF/8BWvR0zPxW6z23O5qG4N4X/Zi8uscYXQZVWdLXa8NGSE71AxRDCDalnQNZ0AlSXIbVHz/2gFeODagB/V2VZmv7pKAKEh1vabOGx09tAeoV56I0+MvLGSEQQ+IPAJaF/Ka/+PRRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDQG44jv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDQG44jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5641F000E9;
	Thu,  6 Aug 2026 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786030825;
	bh=X4y0kRDos7SUupJbhbbGh+ICURL3cdgyP3aRACH2kFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QDQG44jv+J00sxZv6RdnsCugx8JDFPTDhXTeuI64TQoF/ZieSGG4mUm3vzsSHRYh7
	 VDF4qitSAmwAmXy1nMqSXjy64PTc3iipClx03crZnHSHDEioRY7XZkaaMeM4P+Kdsh
	 E9J5l7BqgspPvIpcsEH25RYx0dEx3cZ22+/uAPT1qZBiHcO4fql5Rtyha2uEj+EdJ1
	 5JyNvEL/Fwfp4QRa3bwQEyivfGE8nyz+ScWIikKRjpY92ZFw7mIn/ZWtCMq6n39UI9
	 aztkkLopa+X3dqoQ0V8hXqy5RtpDMtxtiiCYk6H+naUlMyQjG7IsaIOLpwDSGhv6nH
	 zz8c6oqqzk4WQ==
Date: Thu, 6 Aug 2026 16:40:08 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, jannh@google.com, 
	00moses.alexander00@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/madvise: avoid skipping pages after splitting
 large folios
Message-ID: <anSqbW1w2bDDHpAx@lucifer>
References: <20260806055501.56761-1-cuiyunhui@bytedance.com>
 <anQyoZgi5Urnvvjw@lucifer>
 <919b804b-6f1d-417e-9c0c-d06f50d765d8@kernel.org>
 <anSar_i8UjniSbML@lucifer>
 <a6a9e0cc-e6cf-4f83-b6be-7d64058b8fa6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6a9e0cc-e6cf-4f83-b6be-7d64058b8fa6@kernel.org>

On Thu, Aug 06, 2026 at 04:46:10PM +0200, David Hildenbrand (Arm) wrote:
> On 8/6/26 16:34, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Aug 06, 2026 at 01:35:30PM +0200, David Hildenbrand (Arm) wrote:
> >>>
> >>> Let's at least split out the folio check into a helper to make things
> >>> clearer:
> >>>
> >>> static bool poison_splits_folio(const struct folio *folio)
> >>> {
> >>> 	/* Hugetlb is, as always, a world unto itself. */
> >>> 	if (folio_test_hugetlb(folio))
> >>> 		return false;
> >>> 	/* Soft-offline errors out, hwpoison traverse DAX intact. */
> >>> 	if (folio_is_zone_device(folio))
> >>> 		return false;
> >>> 	return true;
> >>> }
> >>>
> >>> Then for your patch:
> >>>
> >>> -		size = PAGE_SIZE;
> >>> -		if (folio_test_hugetlb(folio) || folio_is_zone_device(folio))
> >>> -			size = folio_size(folio);
> >>> +		size = poison_splits_folio(folio) ? PAGE_SIZE : folio_size(folio);
> >>>
> >>> I tried writing something that was neater and nicer but AI kept pointing
> >>> out how it was totally broken and I really really hate this code (not your
> >>> fault :).
> >>
> >> No, I don't think any such special casing on folios is the right way to handle it.
> >
> > I mean the issue here is the stride varies depending on whether the thing is
> > hugetlb or not (and some weird DAX thing), and the poisoning causes a split
> > otherwise so if you want to poison a range you have to account for that.
>
> We GUP'ed a single page and now try to be smart about which other pages we'd GUP
> next.
>
> That's just wrong, and hugetlb special-casing is just ugly.
>
> The problem here is that, if we GUP'ed a page and poisoned it, the GUP'ing the
> next page might fail and we'd return an error.
>
> But maybe that error can simply be handled? We have FOLL_HWPOISON.
>
> So maybe we can just use FOLL_HWPOISON and skip over the entries that already
> return -EHWPOISON?

Yup this is ugly debug code so that works for me.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
