Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36283B71A4;
	Wed, 26 Aug 2026 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731033; cv=none; b=m8UJSJWmTDgxW0PCGT4HWOrfFj+6iKpCE1903VhM+DkvzRljX0hhJEKa9kqwPPnp3aayDGh/8YociMRH+DgFK60Pq/kgSMqAIYr1yLe0Trlc+0R1B6DSuDp1TB9IJC6N4lCiY59amWkI82xJk5F1d1w5+0QfbTy0z6LrmFrl6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731033; c=relaxed/simple;
	bh=tyTC6W1xuyX6MjmkZ31a7cq0HgAHdRsB7Y3erRGg5OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTk2gvwoYfWeCZ5Z5/NEXspSa5UAfcGWjftl3r8rHZYt2bfIlOCtgvOM/UbxhyFVTeoVvn0IVamxYIsE0Gqj7NLi9eT9Mxtu/7RqnSN7CgMMiQEtk9g9bACQAQ0kKG/Kr1OHAqN1PeVXWyGYPU+HNK8yTzJk8a/S3Dpi7IKmHqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn+BsycT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn+BsycT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEECF1F00A3A;
	Wed, 26 Aug 2026 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787731031;
	bh=JoSpfgQVWPrL1xC+VY8JnkH+r+BJbUIhnLuY0YtzjCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kn+BsycT04gQ8Z7v7bg784woMyrj3i89HvLmRjTDXrcv9qjJqmPSbDnGUXZGCzLJ/
	 ie+ALYgFBja7ljDjCXCtXqjGKwBfbhr8XyuW42PRidc7g/D4PI/5yKDesjbZ7RSGdI
	 +7tAytW8JomdXUvRk1Al0ZRYjnre/arA5xMA6W3Z1w9mmHSnMIvOgAW1OhAgasnwGF
	 o9Q6xGSEYUFB3Iv1Hr9ml/HGlawCYbvkrSqCs+vW8Fdh8I27a56Ahin2NnFUm4j2CA
	 smzIOP7F8Kfry1m4/mH4sxuJgHxvnTgd5J5OFdxdUHE18sw971vI52NqMJFNukphKk
	 51PMIoH44i1Ag==
Message-ID: <c8e3bb54-e4f1-45d3-8059-3ee1910a920a@kernel.org>
Date: Wed, 26 Aug 2026 09:57:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, ljs@kernel.org, nico.pache@linux.dev,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, usama.arif@linux.dev, zokeefe@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 Vernon Yang <yanglincheng@kylinos.cn>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-2-vernon2gm@gmail.com>
 <edd7ed8d-0f2c-4de3-89e5-f2b23c2dd1e5@kernel.org>
 <6a9c2369-5589-4f2a-bcfe-c6e3b46a1ccd@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <6a9c2369-5589-4f2a-bcfe-c6e3b46a1ccd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/26 04:44, Vernon Yang wrote:
> On Mon, Aug 24, 2026 at 01:54:18PM +0200, David Hildenbrand (Arm) wrote:
>> On 8/24/26 11:29, Vernon Yang wrote:
>>> From: Vernon Yang <yanglincheng@kylinos.cn>
>>>
>>> When the swap entries found exceed max_ptes_swap, the loop is left via
>>> break with folio still holding the xarray value that encodes the swap
>>> entry, not valid folio pointer.
>>>
>>> That value is passed to trace_mm_khugepaged_scan_file(), which feeds it
>>> to folio_pfn(). On FLATMEM and SPARSEMEM_VMEMMAP, the page_to_pfn() is
>>> plain pointer arithmetic, so the trace event merely prints bogus
>>> scan_pfn. On classic SPARSEMEM, the page_to_pfn() reads page->flags,
>>> dereferencing the tiny encoded integer and oopsing khugepaged whenever
>>> the trace event is enabled.
>>>
>>> So when folio is the swap entry value, simply set pfn to -1, just like
>>> exhausted scan naturally.
>>>
>>> And the folio_put() has maybe dropped the last reference of folio. The
>>> trace_mm_khugepaged_scan_file() is left with a dangling folio pointer.
>>> so using the folio_pfn() before dropping the reference, closing
>>> use-after-free window.
>>>
>>> Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
>>> ---
>>>  include/trace/events/huge_memory.h | 6 +++---
>>>  mm/khugepaged.c                    | 5 ++++-
>>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
>>> index 5a48c5406cce..7b526528f85b 100644
>>> --- a/include/trace/events/huge_memory.h
>>> +++ b/include/trace/events/huge_memory.h
>>> @@ -178,10 +178,10 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
>>>
>>>  TRACE_EVENT(mm_khugepaged_scan_file,
>>>
>>> -	TP_PROTO(struct mm_struct *mm, struct folio *folio, struct file *file,
>>> +	TP_PROTO(struct mm_struct *mm, unsigned long pfn, struct file *file,
>>>  		 int present, int swap, int result),
>>>
>>> -	TP_ARGS(mm, folio, file, present, swap, result),
>>> +	TP_ARGS(mm, pfn, file, present, swap, result),
>>>
>>>  	TP_STRUCT__entry(
>>>  		__field(struct mm_struct *, mm)
>>> @@ -194,7 +194,7 @@ TRACE_EVENT(mm_khugepaged_scan_file,
>>>
>>>  	TP_fast_assign(
>>>  		__entry->mm = mm;
>>> -		__entry->pfn = folio ? folio_pfn(folio) : -1;
>>> +		__entry->pfn = pfn;
>>>  		__assign_str(filename);
>>>  		__entry->present = present;
>>>  		__entry->swap = swap;
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 79effd3f3da4..00337405c0e0 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -2689,6 +2689,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>>>  	int present, swap;
>>>  	int node = NUMA_NO_NODE;
>>>  	enum scan_result result = SCAN_SUCCEED;
>>> +	unsigned long pfn;
>>>
>>>  	present = 0;
>>>  	swap = 0;
>>> @@ -2719,6 +2720,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>>>  			continue;
>>>  		}
>>>
>>> +		pfn = folio_pfn(folio);
>>>  		if (is_pmd_order(folio_order(folio))) {
>>>  			result = SCAN_PTE_MAPPED_HUGEPAGE;
>>>  			/*
>>> @@ -2779,7 +2781,8 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
>>>  		}
>>>  	}
>>>
>>> -	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
>>> +	trace_mm_khugepaged_scan_file(mm, (!folio || xa_is_value(folio)) ? -1 : pfn,
>>> +				      file, present, swap, result);
>>>  	return result;
>>>  }
>>>
>>
>> Shouldn't we just reset PFN to -1 at the beginning of the loop (and set it
>> initially)?
> 
> When the `xas_for_each()` iteration to terminate and the folio operation
> preceding is normal, but pfn will be incorrect.

The PFN is only relevant when a folio participated in the failure. Maybe the
following would be cleanest?

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 75639298efc27..371ee0b16d10c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct
mm_struct *mm,
        int present, swap;
        int node = NUMA_NO_NODE;
        enum scan_result result = SCAN_SUCCEED;
+       unsigned long problematic_pfn = -1;

        present = 0;
        swap = 0;
@@ -2714,6 +2715,7 @@ static enum scan_result collapse_scan_file(struct
mm_struct *mm,
                }

                if (is_pmd_order(folio_order(folio))) {
+                       problematic_pfn = folio_pfn(folio);
                        result = SCAN_PTE_MAPPED_HUGEPAGE;
                        /*
                         * PMD-sized THP implies that we can only try
@@ -2725,6 +2727,7 @@ static enum scan_result collapse_scan_file(struct
mm_struct *mm,

                node = folio_nid(folio);
                if (collapse_scan_abort(node, cc)) {
+                       problematic_pfn = folio_pfn(folio);
                        result = SCAN_SCAN_ABORT;
                        folio_put(folio);
                        break;
@@ -2732,12 +2735,14 @@ static enum scan_result collapse_scan_file(struct
mm_struct *mm,
                cc->node_load[node]++;

                if (!folio_test_lru(folio)) {
+                       problematic_pfn = folio_pfn(folio);
                        result = SCAN_PAGE_LRU;
                        folio_put(folio);
                        break;
                }

                if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
+                       problematic_pfn = folio_pfn(folio);
                        result = SCAN_PAGE_COUNT;
                        folio_put(folio);
                        break;
@@ -2773,7 +2778,7 @@ static enum scan_result collapse_scan_file(struct
mm_struct *mm,
                }
        }

-       trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
+       trace_mm_khugepaged_scan_file(mm, problematic_pfn, file, present, swap,
result);
        return result;
 }



-- 
Cheers,

David
