Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58C388890;
	Tue,  2 Jun 2026 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388948; cv=none; b=AyI9tZN4B7T0k+p5p7hgRFuoQlAQEvlPPXgClNKOh9JOYI3vr06jLLSqWuEDUMF6k9Dr3WX94zkEKrQLqi7DQbIVuI/xcFR8plquKL+2/DbttWAv8OETleFeFMqY6bYqMAe0H8DAFz21gRGwRWb6UiXGUscArD6OvPwT1D6yxZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388948; c=relaxed/simple;
	bh=Evgc1f+UtY0pGVimRPIL+9zsQWWXNsVY0kVMbF5rXxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHFLUqciddFBcIoXVitVUFrAo+knc+BzSqLLcl2X4ot+xGxg2HOG/P0rrea3HpVhc7l8x1qMgDzsu8XaS+RZQAqQJdcOLPtpiNLMa42/ag8ymjWy5l/cbSCPqRJsbqoJMpq+nPh45EpJo0vo25Nhs3qITEZNUJPyLUpYUbtNEp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efvuu/ku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efvuu/ku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952941F00893;
	Tue,  2 Jun 2026 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780388946;
	bh=i/QfQjYUvsdWRW1C6T1wChr76vRullJZ7a3tFyzfJVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=efvuu/ku107Ki2MfL5Kx5fIttZLNK2SJMSX78TLzd/OW4/YGwyIgJEnvlW/oOn7QY
	 2B7e2XPp2SNKzAVupuugYkp29T30aAS4ImoDnFqrnX/yjdqExPAjT34UtwKBPIP680
	 7bJqNhU9Zz+1bQ3tZZkY5YD3/0LHudSBgm6rXFEyScE5X2VSaEcCwdEd1uugqdTtNl
	 8iuZF0rcZZDvPDPJvZ+154yflgV5dpSkLYLRT42u3rV/T7RQvE64SVjdmTsDQRMmjs
	 GYZBgbud8G3MUtqZsQNWJ+opT5RpZeEpOZBdU35XvnglE5IHVobXkNf8UOncVqvuVH
	 snkTfR707G4DQ==
Date: Tue, 2 Jun 2026 11:28:59 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 5/6] userfaultfd: gate must_wait writability check on
 pte_present()
Message-ID: <ah6USx2IQ4iy1jUZ@kernel.org>
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-6-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529172331.356655-6-kas@kernel.org>

On Fri, May 29, 2026 at 06:23:29PM +0100, Kiryl Shutsemau (Meta) wrote:
> userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
> without taking the page table lock and then apply pte_write() /
> huge_pte_write() to it. Those accessors decode bits from the present
> encoding only; on a swap or migration entry they read the offset bits
> that happen to share the same position and return an undefined result.
> 
> The intent of the check is "is this fault still WP-blocked?". A
> non-marker swap entry means the page is in transit -- the userfault
> context the original fault delivered against is no longer the same,
> and the swap-in or migration completion path will re-deliver a fresh
> fault if userspace still needs to handle it. Worst case under the
> current code the garbage write bit says "wait", and the thread stays
> asleep until a UFFDIO_WAKE that may never arrive.
> 
> Gate the writability check on pte_present() so the lockless re-check
> only inspects present-PTE bits when the entry is actually present.
> The non-present, non-marker case returns "don't wait" and lets the
> fault path retry.
> 
> Fixes: 369cd2121be4 ("userfaultfd: hugetlbfs: userfaultfd_huge_must_wait for hugepmd ranges")
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/userfaultfd.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

-- 
Sincerely yours,
Mike.
