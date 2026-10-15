Received: from mta0.migadu.com (out-246.mta0.migadu.com [91.218.175.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61742125A
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070247; cv=none; b=iVVmH0yVnznzVYwnIHYSA1R1goP45hMR988j5wq/Z4IeF91AnsNcr/TiXb5YI6RQl7lbejLkiAe0jVVk1TQ2QXIroRgfBB7Cl2lghvmKqNf7PXytstAZGiFTwKhelGjrV+IfGTz0FT+qJ8f7zsF9a6jzkFtdNOjqypIe04hIO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070247; c=relaxed/simple;
	bh=hqinzRPIxuUU4bOrqaFfByb0krG+U3rhEL4mgvlQiR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4FiJHJVGDSUE0mHTsSO/DbIybTK+qbk50QkYhgMWLjJD1jZRuCw/b4fIFlVzEu0/rjCvgYFIvnZu5ic6A1qcakGsUW8tizGLEoa2Q17IjycsoUWLkSq+FpEXet8ZAdO8rkpJBJn3Rlsa7IbMC24mJy6tQ5f2BQwlVssLZJqSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NmKIkLDn; arc=none smtp.client-ip=91.218.175.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NmKIkLDn"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hqinzRPIxuUU4bOrqaFfByb0krG+U3rhEL4mgvlQiR4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792070243; v=1; x=1792675043;
 b=NmKIkLDnZDG2y73ti8vR3cwK5ietiaVKNZrQ9S4T2DlcrrhmpqONXF4JHNPiCWBVEev94Xyd
 CQDgP4w/0Qb8ueVlt+VqJeszL7cXupOShs5XJ5f1C54peQlYjKf6XD0+9LjJ8GGbcp5lA9gqMRo
 HqHhlwYf7Rr6oNhM09S47f6c=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f603c4a714d74cfa;
	Thu, 15 Oct 2026 13:17:23 +0000
X-Mizu-Trace-ID: f603c4a714d74cfa
X-Migadu-Flow: FLOW_OUT
Message-ID: <a36e9e99-f7c8-4aac-bc05-8a042cd9f438@linux.dev>
Date: Thu, 15 Oct 2026 21:17:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] khugepaged: hold invalidate_lock across
 collapse_file() readahead
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>, Zi Yan
 <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jan Kara
 <jack@suse.cz>, Hugh Dickins <hughd@google.com>
References: <DLEBZ0GIGNQ8.17U563YYJ37AA@nvidia.com>
 <20260913163644.122133-1-ngocthang2710.1999@gmail.com>
 <20260913111700.6de78b5834842f7dd3f12d07@linux-foundation.org>
 <aqbvFtlXd3Jdnfbm@gremlin> <1fe4027a-6ad8-42a1-9943-cb3b8aad3fb6@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <1fe4027a-6ad8-42a1-9943-cb3b8aad3fb6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/15 20:26, David Hildenbrand (Arm) wrote:
> On 9/13/26 20:48, Lorenzo Stoakes (ARM) wrote:
>> (Nguyen - do not send v2 in reply to v1, look across mm and see how things are
>> done here).
>>
>> somebody who has a
>>
>> On Sun, Sep 13, 2026 at 11:17:00AM -0700, Andrew Morton wrote:
>>> On Sun, 13 Sep 2026 23:36:44 +0700 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com> wrote:
>>>
>>>> collapse_file() calls page_cache_sync_readahead() to fault in missing
>>>> pages before collapsing them into a THP. That helper takes
>>>> mapping->invalidate_lock itself for the duration of the call, then
>>>> drops it -- but truncate (e.g. ext4_setattr() -> truncate_pagecache())
>>>> takes invalidate_lock and then waits on each page's folio lock while
>>>> holding it. If collapse_file() has already locked one of those folios
>>>> by the time truncate reaches it, and then tries to acquire
>>>> invalidate_lock again (e.g. on the first readahead call, since
>>>> invalidate_lock is not yet held at that point), the two paths can
>>>> deadlock/hang on each other's lock: truncate blocked on the folio lock
>>>> collapse holds, and collapse blocked waiting for invalidate_lock that
>>>> truncate holds.
>>>>
>>>> Reproducing this over ~150,000 collapse iterations with truncate
>>>> racing concurrently reliably hits hung_task: blocked tasks within
>>>> about 20 seconds on an unpatched kernel.
>>>>
>>>> Fix it by taking invalidate_lock_shared once for the whole scan, after
>>>> alloc_charge_folio() succeeds and before locking any folio, and using
>>>> page_cache_ra_unbounded() directly in the readahead call site instead
>>>> of page_cache_sync_readahead(), since the latter would try to retake
>>>> the lock we already hold. page_cache_ra_unbounded() does not clamp to
>>>> EOF like the helper it replaces, so clamp the requested range
>>>> explicitly.
>>>>
>>>> 730633f0b7f9 added invalidate_lock acquisition around readahead but
>>>> missed collapse_file(), which already locks pages while calling
>>>> readahead; later filesystem conversions made the deadlock reachable by
>>>> taking invalidate_lock before waiting on page locks during truncate.
>>>>
>>>> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
>>>> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
>>>
>>> (You forgot to cc the original author)
>>
>> Also a change log, and that mm doesn't like sending a respin in-reply-to a
>> previous version. Which is all consistent with somebody using e.g. openclaw to
>> pepper generated patches across the kernel...
>>
>>>
>>> Five years.
>>>
>>> I wonder why this hasn't been discovered by lockdep, AI, syzbot or any
>>> other of the tools we've been using for so long.
>>>
>>> Thanks for doing all this.
>>
>> See https://lore.kernel.org/linux-mm/aqbtfms0_2ULBIT7@gremlin/
>>
>> I am not really entirely happy with somebody who has sent a flurry of patches
>> across disparate subsystems with no previous track record being in charge of a
>> potentially backported fix.
>>
>> It's David's decision but I think this fix should be taken over by somebody
>> else.
> 
> So what's the status of this? Any volunteers? Otherwise I'll polish this up.

I can take this over if no one else volunteers :D

