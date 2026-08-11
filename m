Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF0A46D0B0;
	Tue, 11 Aug 2026 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786475547; cv=none; b=DHR0pUU1qXtOv/A5CHnVS15ylZBN8Vc0sz2GvkxBI0S9y+lo0IM1/4IOZlkACw6LpZUkR8s3nAHCq3af2j4w/XJka+KQGtYeWsTabJV8PU1u+gWNASk6k+H5mVAAM8ypaENQk8M5mVTrN25QsLQSlHMS50840CrgU/eufWitaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786475547; c=relaxed/simple;
	bh=t3QcuqjuB95Z1IYAfG/pbC2Pr5hdnD4h837MCWHTTeg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NkglKHNRvmlo84hLTJ5LmhRKBAYkVQ9xVPmT1uqvUqMRIsIU3k2sK9LlFgM45O4jtESQiG90y510A8GEmlmR/DCSHNiNmc+kyLJIgygWA/kQVkSCmEZjQ3N/zky/AgHRWCRWSXe1K7KUKqWu1WqNfrLrDsBKKaiicj/7QOeka9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I69u3zkO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I69u3zkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976B71F000E9;
	Tue, 11 Aug 2026 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786475546;
	bh=+i5G5eQtKFOjTqpeKl14Jk+BOvdz+qV6fk5uL70Mp/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I69u3zkOHUBjUDeB0DWHA0jCm2xjNPzE7+QZF55ijRPURIVRy+1o3KcJtn2E9csd8
	 hDwI6dEoJioia6AIvlSyCDXVLScUtTIPm2zGiT7j6e12dtF6tERmywhYwFrj7lV0EB
	 HMWu/jeWefrEldBAlwg9vxNfnx3+5LR1PP0cmMt4=
Date: Tue, 11 Aug 2026 12:12:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: david@kernel.org, ljs@kernel.org, nico.pache@linux.dev,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, usama.arif@linux.dev, zokeefe@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Vernon Yang
 <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: don't pass swap entry value to
 trace_mm_khugepaged_scan_file()
Message-Id: <20260811121225.fe45676262404b82270843a1@linux-foundation.org>
In-Reply-To: <20260811133655.267739-1-vernon2gm@gmail.com>
References: <20260811133655.267739-1-vernon2gm@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 21:36:55 +0800 Vernon Yang <vernon2gm@gmail.com> wrote:

> When the swap entries found exceed max_ptes_swap, the loop is left via
> break with folio still holding the xarray value that encodes the swap
> entry, not valid folio pointer.
> 
> That value is passed to trace_mm_khugepaged_scan_file(), which feeds it
> to folio_pfn(). On FLATMEM and SPARSEMEM_VMEMMAP, the page_to_pfn() is
> plain pointer arithmetic, so the trace event merely prints bogus
> scan_pfn. On classic SPARSEMEM, the page_to_pfn() reads page->flags,
> dereferencing the tiny encoded integer and oopsing khugepaged whenever
> the trace event is enabled.
> 
> So set folio to NULL before breaking out, the tracepoint maps NULL to
> scan_pfn of -1, just like exhausted scan naturally.
> 
> Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")

Added in 2022.  Why so long - do people not use tracing?

Sashiko might have a found a couple of other tracing bugs in this code,
which I suggest are on-topic for your patch:

	https://sashiko.dev/#/patchset/20260811133655.267739-1-vernon2gm@gmail.com


Also a possible bug mapping large folios which straddle i_size, which
is a separate thing.

