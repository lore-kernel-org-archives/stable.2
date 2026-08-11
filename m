Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A536DA15;
	Tue, 11 Aug 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459776; cv=none; b=VbmkdzagCC04XFlKJH4cg3fB0cT2yy71KDsZRm/x1sad15qn3CmOnZNF8F9OI1/yGLrLLNdL+XiucLWAHXV83Au1Ziq9SjT/UNnwT98gVTaIykkVNPazqXzxGTZF/2au4V7cmqyqCBGKJfSe8EcgrvcTZhU+8MzcqvQNT8NDziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459776; c=relaxed/simple;
	bh=1DI7fat4v8fNcYhIPwMLunPhwYWXyNRJAYsUQy1h8nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbaMTeWkNhPwcZGjtWf3dxULCYIqX5oY8vDSvfXx4yc1QogdXc9exfoh59YT8MMxaBCYhCXAbVIEC8eN92p1U2VBQqkqZySOsuk7W8xgXlUkYgCUGCJSW+1QUhVB/WC9UPHZfnvnGHZt9Zz8W1r/+Jz1U56cexjMmO1HHyOuLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4lvmZmt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4lvmZmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDBF1F000E9;
	Tue, 11 Aug 2026 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786459773;
	bh=jx6Ongc0OibhUt/11tLX9eIUBHVNywDq+e8KzvGNZmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K4lvmZmteat6V8pe2VwS8IQ4lE88hiEiWFuIMF+vda4q0bLT3dyUa19S/sEtmZC9Z
	 IIh2AMcKyvA0ZPMBBSEIKuq3+RuMfYs1vpCjWN26854oqfpl/NLEVKp16MLU61Qq/P
	 BCy5n6nIHNqM8+tGSMfSP7eAOOqf4tNHKIiFRZndjB23wcB9Kvna8K5MqWMP3mfrpY
	 40u9aWIVxQqTL5j/H4zlVyivZwt2BThi09uy3ei9eRZ0Ap92oNxUpafdMQf7Ree6rV
	 3o71PISlpx1QOYYDPuw9KHOertiWTdMt0ULn99P83XLuzwqMoU0wljHv4HFEsKDIPN
	 aBn1b85n+VsJg==
Message-ID: <3882e553-4be3-4b2d-b884-4443032e7853@kernel.org>
Date: Tue, 11 Aug 2026 16:49:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2] mm/madvise: avoid skipping pages after
 splitting large folios
To: yunhui cui <cuiyunhui@bytedance.com>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org,
 jannh@google.com, 00moses.alexander00@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260806055501.56761-1-cuiyunhui@bytedance.com>
 <anQyoZgi5Urnvvjw@lucifer> <919b804b-6f1d-417e-9c0c-d06f50d765d8@kernel.org>
 <anSar_i8UjniSbML@lucifer> <a6a9e0cc-e6cf-4f83-b6be-7d64058b8fa6@kernel.org>
 <anSqbW1w2bDDHpAx@lucifer>
 <CAEEQ3wmJoUF5TDQDfMU_dUHnY+gg7MYG=OmmdB3Ynpdu9gJ7-g@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAEEQ3wmJoUF5TDQDfMU_dUHnY+gg7MYG=OmmdB3Ynpdu9gJ7-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/26 04:31, yunhui cui wrote:
> Hi Andrew, David, Lorenzo,
> 
> On Thu, Aug 6, 2026 at 11:40 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>>
>> On Thu, Aug 06, 2026 at 04:46:10PM +0200, David Hildenbrand (Arm) wrote:
>>>
>>> We GUP'ed a single page and now try to be smart about which other pages we'd GUP
>>> next.
>>>
>>> That's just wrong, and hugetlb special-casing is just ugly.
>>>
>>> The problem here is that, if we GUP'ed a page and poisoned it, the GUP'ing the
>>> next page might fail and we'd return an error.
>>>
>>> But maybe that error can simply be handled? We have FOLL_HWPOISON.
>>>
>>> So maybe we can just use FOLL_HWPOISON and skip over the entries that already
>>> return -EHWPOISON?
>>
>> Yup this is ugly debug code so that works for me.
> 
> Thank you for the review. Based on your feedback, I went back through the
> madvise, GUP, soft-offline, and memory-failure paths and outlined the
> changes I plan to make for the next revision.
> 
> The issue is that using a page obtained for one address to infer how far
> the range walker can advance is the wrong abstraction.
> 
> For an anonymous large folio, soft_offline_page() splits the folio to
> order-0 and handles only the supplied base-page PFN. Advancing by the
> pre-split folio size can therefore skip the remaining base pages while
> madvise() still returns success.
> 
> Lorenzo also raised the semantics of a range that covers only part of a
> hugetlb page. Looking at a range that crosses a hugetlb boundary exposes
> another problem. For example, with two 2 MiB hugepages:
> 
> hugepage A: [0, 2 MiB)
> hugepage B: [2 MiB, 4 MiB)
> requested range: [2 MiB - 4 KiB, 2 MiB + 4 KiB)
> 
> The first GUP resolves the last base page in hugepage A. Adding the full
> 2 MiB hugepage size to that unaligned address produces the next address
> at 4 MiB - 4 KiB. That is already beyond the requested end at
> 2 MiB + 4 KiB, so the loop terminates without ever visiting hugepage B.
> 
> For MADV_SOFT_OFFLINE:
> 
> - ordinary pages and large folios advance by PAGE_SIZE because
>   soft_offline_page() handles the supplied base-page PFN after any split;
> 
> - hugetlb advances to the end of the current hugepage because successful
>   soft-offline migrates the complete hugepage and leaves a healthy
>   replacement mapped. If the walker advanced by PAGE_SIZE, its next GUP
>   would resolve that healthy replacement and soft-offline the same virtual
>   hugepage again;
> 
> - ZONE_DEVICE does not need a stride case because soft_offline_page()
>   rejects it.
> 
> Advancing to the current hugepage boundary, rather than adding the hugepage
> size to the original unaligned address, lets the next iteration start
> exactly at hugepage B.
> 
> For MADV_HWPOISON, I plan to follow David's suggestion and walk at
> PAGE_SIZE using:
> 
> get_user_pages_unlocked(start, 1, &page,
> FOLL_GET | FOLL_HWPOISON)
> 
> get_user_pages_unlocked() is the appropriate interface here because the
> current gup_fast_fallback() flag mask rejects FOLL_HWPOISON, while the
> memory-failure madvise path enters madvise_inject_error() without
> mmap_lock held. get_user_pages_unlocked() acquires and releases mmap_lock
> internally, handles fault retries, and propagates -EHWPOISON from the
> fault path. FOLL_GET makes the page-reference ownership consumed by
> MF_COUNT_INCREASED explicit.
> 
> A successful GUP is followed by memory_failure(). If GUP returns
> -EHWPOISON, the address was already covered by an earlier larger-granularity
> injection, so the walker continues with the next base-page address. Other
> errors are returned. This avoids hugetlb, DAX, and folio-size inference in
> the MADV_HWPOISON caller.
> 
> Device DAX is relevant only to MADV_HWPOISON because
> MADV_SOFT_OFFLINE rejects ZONE_DEVICE pages. Since the proposed
> MADV_HWPOISON walker advances by PAGE_SIZE and uses each GUP result as
> feedback rather than inferring the handled range from folio_size(), it
> should also avoid the same granularity problem for Device DAX. A
> successful GUP is passed to memory_failure(), while -EHWPOISON indicates
> that the address was already covered by an earlier injection. Advancing
> by PAGE_SIZE should therefore also work for Device DAX in principle. I do
> not currently have a suitable Device DAX setup, so this remains untested
> at runtime.
> 
> Because MADV_SOFT_OFFLINE must advance past a hugetlb replacement while
> MADV_HWPOISON can use FOLL_HWPOISON feedback during a PAGE_SIZE walk, I
> plan to use separate walking models for the two operations.
> 
> Before posting another revision, I plan to split the work into:
> 
> 1. the MADV_SOFT_OFFLINE range-walk fix;
> 2. MADV_SOFT_OFFLINE large-folio and hugetlb selftests;
> 3. the PAGE_SIZE + FOLL_HWPOISON MADV_HWPOISON walker;
> 4. MADV_HWPOISON large-folio and hugetlb selftests.
> 
> Does this separation of the SOFT_OFFLINE and HWPOISON walking models look
> reasonable?
As Lorenzo says, this reads AI generated.

I assume what you mean is:

MADV_HWPOISON will actually hwpoison the pages. We can just use FOLL_HWPOISON +
-EHWPOISON and should be good. So far the theory.

MADV_SOFT_OFFLINE will migrate pages instead. So if we don't skip multiple
pages, we could end up migrating multiple times (and setting hwpoison multiple
times).

Well, for large folios (except hugetlb) that's not a problem, because we try
splitting to order-0 either way, and if that fails, we bail out.

So what remains is hugetlb, which is nasty.

I don't really enjoy having any special-casing here, because the moment we e.g.,
change how soft-offlining deals with splitting, we would be in trouble.

Assume we start support splitting to min-order at some point, we'd also want o
skip over min-order. Gah.


Can we just make our life easier and disallow specifying ranges for
MADV_HWPOISON/MADV_SOFT_OFFLINE?

It's a pure testing interface IIRC. tools/testing/selftests/mm/memory-failure.c
seems to always call it with PAGE_SIZE. Similarly
tools/testing/selftests/mm/hugetlb-read-hwpoison.c

There is one catch I think: an existing LTP test case issues MADV_SOFT_OFFLINE
on a larger range. But it respects -EINVAL at least :)

So we could return -EINVAL and fixup the test case to issue multiple madvise().

[1]
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/move_pages/move_pages12.c

-- 
Cheers,

David
