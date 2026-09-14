Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEB384245;
	Mon, 14 Sep 2026 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409983; cv=none; b=hCZooqgUYK+3w1G2JeZQ8ZsEAlKCNNrwTaHl9TrwcFTI34i4wF6K8Txchcd3bH10gxw3dwmM24bEHqc5C3A3EBgv9q0QzAHwv6eznAv/B+UdzdahX1ZI799jXrTeDSWiLhA7lKk6fC9PBILq3MP4OrOb2QHKgG9e/eh7Q2+AXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409983; c=relaxed/simple;
	bh=G0mIIrJvt2wcv6ID4m2Trh4N74dGIV1/R1kU7vWY/zE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kRWByUkX+IRyOJuDtJPcCQzCLj62rm5RSJwV9O1yMve8rlNqnd0DGUgiuIbNkB9j3haRaiMsP+9PBxiI+S/NBzrVc9hx4/l1u1fK/tzA5xhUCkDTswYMlYiVS2nYdNZ1J0Co3dh4k2+1t64RKh6Tex3qXJ3iLIj8J8LEtc5lHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1AbA6KGu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1AbA6KGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1621F000FF;
	Mon, 14 Sep 2026 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789409980;
	bh=VsN3qekiQiOy09Vr8Cs8x5ZTMlfTLINzP6aEinGBmkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=1AbA6KGuVDMishj6sWpf+J0Yo8lpG41mjxhzMvhE4n/2vzd6pSMPclU1hqG7IBrEj
	 wFwinYN1rKC+IPUWW4zmpuNC75nrU+ShelM6YUViiCar2Mr6EUTbekti8s1lj0Ibz5
	 lf05BQ8f4aek3KJ/cqOmZg1bvjb79gPZha2U3Ouc=
Date: Mon, 14 Sep 2026 11:19:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, liam@infradead.org,
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, usama.arif@linux.dev, ljs@kernel.org, surenb@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/huge_memory: fix pgtable withdrawal for huge
 zero PMDs
Message-Id: <20260914111940.f7e2c72eac4a2df97a646793@linux-foundation.org>
In-Reply-To: <f76beaf8-351a-4b22-b362-a945a5e1af6a@kernel.org>
References: <20260912234635.db50397364858aa15f58f4d7@linux-foundation.org>
	<20260913072312.52111-1-lance.yang@linux.dev>
	<aqfRCPheDYTgTdAk@thinkstation>
	<f76beaf8-351a-4b22-b362-a945a5e1af6a@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 16:29:00 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 9/14/26 12:59, Kiryl Shutsemau wrote:
> > On Sun, Sep 13, 2026 at 03:23:12PM +0800, Lance Yang wrote:
> >>
> >> On Sat, Sep 12, 2026 at 11:46:35PM -0700, Andrew Morton wrote:
> >>>
> >>>
> >>> That's the sort of thing we'd prefer to avoid.
> >>>
> >>>
> >>> How real is this?  Is there a reported-by:?  Do you have a reproducer? 
> >>
> >> Yes, I reproduced it on x86 with a small test module. It sets
> >> VM_MIXEDMAP | VM_HUGEPAGE and calls vmf_insert_pfn_pmd() with
> >> huge_zero_pfn, without touching the page tables directly. A full-PMD
> >> munmap() crashes before the split series[1] as well.
> > 
> > Ah. So there's no real bug upstream, right?
> 
> Matches my understanding.

Thanks.  I'll remove cc:stable, move this into mm-unstable as a
next-merge-window thing.
