Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AD33A9F8;
	Thu,  6 Aug 2026 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026888; cv=none; b=CoIzvjDC5Fh0WkWqtw5PNi235VUUl5mAmBzoXhd9zAMcuJZo0dBqSnwjIjcstohu5GfcYdLg8wpu4ZizuUjkDb40dHADql1v73OZfAIctSKMSTrsaXSgEQLbYE+HAwS3SZwPYms10LIbj73/FyDIp2tELFyVuxlb1e7zd+HAfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026888; c=relaxed/simple;
	bh=l//MHz7EF+zcEQd/Z0ATqv2vpbsCQcTZrub+Wpd9eu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuGwzg5hSK2RW8obRtjFPw6gisS/EsynVfIW6GNWDoo0S26NuPhWTPNz2PbLTm5+bOFdf5cIiUln7OnXhBmP710RZfW+yDn8b/XBPmCdAqTShr2Bi24+xP2/M6AGU5IgFDh6BZ4YCt5VQ5P/OcLHHMRFn/of+2nGpu79BcxaN2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f031x4F+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f031x4F+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3371E1F000E9;
	Thu,  6 Aug 2026 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786026887;
	bh=/s88DIFVEBP2T/uZKq+3U5KPJDCNDQTM2bhogMbtZ1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f031x4F+s0KFN5tShrCm3AxXtnTVWfzYoRM3Yo0GEu7luofuotWTcMDKSZFigWelR
	 dq9VyOjfPvxZeyx2B9UuHNyfEsHIhOcxFpGa3CiTQvSjc7k7/LymF+hIBAGCWyZ9ex
	 tEyHnklSzH/ZovMF3wN4p+C7HntVKx/n1gscXtlZUvieb7KjXFXrY9u1YdNiNDAMZH
	 tNx8lloJueRo3K9czmBoR+Yoa30H51g51gKSr8P+DWBf9Ptfj9qSc84sZot4nganO0
	 z14VUcL2SOyVi9Ry+g0qLQIEeAGPyAPeR00lSI1bqJ+j5SbFediA4U8yrgUa+qnPYt
	 fYeFuqJQQpF9A==
Date: Thu, 6 Aug 2026 15:34:30 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	liam@infradead.org, vbabka@kernel.org, jannh@google.com, 
	00moses.alexander00@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/madvise: avoid skipping pages after splitting
 large folios
Message-ID: <anSar_i8UjniSbML@lucifer>
References: <20260806055501.56761-1-cuiyunhui@bytedance.com>
 <anQyoZgi5Urnvvjw@lucifer>
 <919b804b-6f1d-417e-9c0c-d06f50d765d8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <919b804b-6f1d-417e-9c0c-d06f50d765d8@kernel.org>

On Thu, Aug 06, 2026 at 01:35:30PM +0200, David Hildenbrand (Arm) wrote:
> >
> > Let's at least split out the folio check into a helper to make things
> > clearer:
> >
> > static bool poison_splits_folio(const struct folio *folio)
> > {
> > 	/* Hugetlb is, as always, a world unto itself. */
> > 	if (folio_test_hugetlb(folio))
> > 		return false;
> > 	/* Soft-offline errors out, hwpoison traverse DAX intact. */
> > 	if (folio_is_zone_device(folio))
> > 		return false;
> > 	return true;
> > }
> >
> > Then for your patch:
> >
> > -		size = PAGE_SIZE;
> > -		if (folio_test_hugetlb(folio) || folio_is_zone_device(folio))
> > -			size = folio_size(folio);
> > +		size = poison_splits_folio(folio) ? PAGE_SIZE : folio_size(folio);
> >
> > I tried writing something that was neater and nicer but AI kept pointing
> > out how it was totally broken and I really really hate this code (not your
> > fault :).
>
> No, I don't think any such special casing on folios is the right way to handle it.

I mean the issue here is the stride varies depending on whether the thing is
hugetlb or not (and some weird DAX thing), and the poisoning causes a split
otherwise so if you want to poison a range you have to account for that.

But I agree there's something wrong here.

At first I thought 'handle at a folio granularity and assume folio slide' but
stupidly this code allows you to poison partial large folio ranges (I don't
think it should and given it's debug/testing crap I think it's fine to change
that).

But then maybe the answer is to change the interface in general? But at the same
time poisoning happens at a pfn level...

It's kinda weird to allow such an open-ended debug thing. I'd prefer we just
disallowed hugetlb, or did a split right away if THP or something.

Anyway hwpoison is a swamp of neglect and hackery regardless.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
