Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606064;
	b=an+EhJ6AQmp+rOuZw1uz40m9aG9CI0+AnvS7zTLfGDv6o8Lbtw0tAkgsbM+ywEqBJXZT
	 8gRWo/IOd7rAVU13fOKAgZAyc9K7A6A1TqmKITDMBa6MTs06Edenl4n/EeA4ntt0Bl7Ij
	 KXykbFT59CNkA6LR0E9MlOYTbSeZrtJn6oBJfCrIHIzqsPURnmgWjwc07SUfps3aBtan2
	 cuDfv/no0mHAf7oHV41eD48yi+jGXAADpWgN+q6ttzt1MV2gFlweuQnHFo1R2dhnYjrCJ
	 5QnCsDQkgi22+TVVPT0cWpDyVwTPRzw7aWz4v4CNJ3dGhkhTOV3HsQaDmQWQQBxa43w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606064;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Azpyo6qZejVSjZbhSbkw8eKwL/GvzZIoGcaHlgWwzCw=;
	b=P0axh4LPrHZ9giWvDZhUIkYxgq8INiLb8NskXMkYFRxeB1wVv6kKLto2oie3fvsDkmph
	 hvIkkRomLyFea57PQQ9MxlKSG6xhnOhvX/vjZJVSTJebzZR3rEGEdoltuc9Ze2dRyRyum
	 cYULtPcwdBDinBIHGa5MfAtnEhO6OQJ1108D8jEmH8cBBI9pBrCDc9lqDhh3P2PBiFMnf
	 mFGsVRKrAq8VKMK1bJvl6I9kbahSJktCyBaUPL6aKLAqSNMUtRUBW9R5BTkmlB6+rQlCf
	 LABYlVsw0h8TUTMfIqhn3faNMp9cdHFPd/tL2iVA+WRauDSWojZ5nVilomv2J5zwLtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUJiUfci;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6656606A336;
	Fri, 13 Nov 2026 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUJiUfci
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8331F000C4;
	Fri, 13 Nov 2026 21:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606064;
	bh=Azpyo6qZejVSjZbhSbkw8eKwL/GvzZIoGcaHlgWwzCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JUJiUfciR+27rcMr+AH9/thxOkwvAeqQfsQoj+e42JxNdgaK7n9gYhC9QMpqCjV7p
	 c/YVvkJdWHU9uAjGEAmKi/kWG67S/0uHIhKFMXtzw1hFYInLwf55qdedjEqz2tsX99
	 +Mf8XvRfkiT+Z8BLMegvwmHrXcCLCdXsknS4olBohbvk4hcpS/Z1C5ybpiX5ySgqdr
	 byQEA/rBEDCSoeOyZqK0wUu2LuYm/TDUHyCZ0gzidNIjUf9YoFmd4ITHcmI7B8WZSr
	 Gol5aSvcXkd4LzUrJSC+9pOWter0IrQj/gA0Exfg3+rc3GUFO6Qn6yoK+6+R5FJR5z
	 pohy6BedXa/MA==
Date: Fri, 13 Nov 2026 21:40:57 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Tal Zussman <tz2294@columbia.edu>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/madvise: zap markers from guard regions
Message-ID: <aveD0GCxbs0Zuq_0@gremlin>
References: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>
 <f8b0f20d-90dd-496d-97e9-9a232124e3e0@kernel.org>
 <avd8-uVPf6BSqwEQ@gremlin>
 <a502f84a-b349-487d-94d9-aff7d9b95102@kernel.org>
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
In-Reply-To: <a502f84a-b349-487d-94d9-aff7d9b95102@kernel.org>

On Fri, Nov 13, 2026 at 10:39:30PM +0100, David Hildenbrand (Arm) wrote:
> >>>  mm/madvise.c | 28 +++++++++++++++++++---------
> >>>  1 file changed, 19 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/mm/madvise.c b/mm/madvise.c
> >>> index 0214efd2a014..4f7728583207 100644
> >>> --- a/mm/madvise.c
> >>> +++ b/mm/madvise.c
> >>> @@ -850,6 +850,19 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
> >>>  	return 0;
> >>>  }
> >>>
> >>> +static void zap_range(struct madvise_behavior *madv_behavior,
> >>> +		      zap_flags_t flags)
> >>
> >> Two ... ;) But maybe it's consistent like that in the file, didn't check.
> >
> > I'm a bit exhausted, can you or Andrew just fix up whitespace like this on
> > application?
> >
> > It'll be easier when I have the VMA tree.
>
> Yeah, absolutely. I'll let Andrew pick this one.

Thanks! :)

> >>>  	/*
> >>> @@ -1845,6 +1854,7 @@ static bool madvise_batch_tlb_flush(int behavior)
> >>>  	case MADV_DONTNEED:
> >>>  	case MADV_DONTNEED_LOCKED:
> >>>  	case MADV_FREE:
> >>> +	case MADV_GUARD_INSTALL:
> >>
> >> Huh why that change? Not spelled out above.
> >
> > It's just the established way madvise interacts with TLB maintenance.
> >
> > Anything that uses madv_behaviour->tlb has to return true here so
> > madvise_init_tlb() and madvise_finish_tlb() do the right thing.
>
> Ohhh, I see now.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks :)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
