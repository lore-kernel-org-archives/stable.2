Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998736;
	b=RTalkc+kB36E3KwYtx6B/1Ss7NxtV+NN9LDoZvaEXrjRv4WzUQS/coSd815CSF0MHR6V
	 /szZLY/Aj21hCW4ydcislWALAMC5YeX984y74dfobh6TVNFaYPbrOg0I2rxMzDx0wYI1w
	 Ob+zdiThiixOovrEuwyc6dHUT1lvKm0pGVwXkKKBqxFYttwlLqttJJ/pX+Kbpqj6mDVKz
	 Za9UcmUk6jWRYlkesFgdMu32twa5yVM3Fzan1rhYU3Rfz4M409sa0tN+Y7yYs8OG+U0Sk
	 34mlnQkuYP8ajkEfTkCF9BhwIzRT/ceSaR0dQA56ufilRzDADgVAv9lcbx8uRbGEihA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998736;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ts4CDaprMowxWHfO4PT+4syTNjSDN3DCqaoaeja+YDo=;
	b=kNldj0DrfSEszuJ4oG6PbjPQehkCDO5ekAp/Kh0+/F6F0hBNI3S9nTfW9YRWL4oM0IlH
	 p3ZwzZSwr3Td9c3AiXzHliKdqLTZIyP5n6D02YS43Y5Ncr+GZFj1N43yHtfe9geiZqw1Q
	 s7qb5nW8gkD4saSfzHEUL+dBPHfIn2UEsCfzgq6pmtse05CaSPU85OKu42aAeTTFo0PUP
	 IfL7KprQs6TJpCoVV30Fyrilp8XLW+Omq5SPEsVUMEwPkxL8QQEqjMEXHGITWniuVVjGu
	 FyVmQ3O5vkvZllqSzPuFPX+KvnOm9HPdr0VPnBTh4sg8aQq92D24N3/2j8kzLigyWLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ixV/2IIx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A0606A329;
	Fri,  6 Nov 2026 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixV/2IIx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B98F1F0089F;
	Fri,  6 Nov 2026 20:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998735;
	bh=ts4CDaprMowxWHfO4PT+4syTNjSDN3DCqaoaeja+YDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ixV/2IIxtyoMfQ4XY/DicKZo88+pkjPXzsU02Qi9R0BXW9GY1+LyVbI+Y3PTz6PHV
	 OWvf4Jg3HGprZ3yx8gHHu3OUatkGnGjgSx4n0rChHDspyH70WZyHUwr/pQHFs0QYh3
	 zxXIxhqGqN8p7QcujIGzCQ4e0RKFj43VPenPPUvqMNpXvWWTyX9XQChUrudvaxHonT
	 k2S4YTXioJCyF+QuLEVcI7pmC+e3VhXrFqj8/IFcna4/pitkTsupLtJCQziB7/UlLZ
	 9YNUC8h5RCNSAlCKwSWcFftx7GctOKkRQ11A7i/APwnObeXr/EwG8isa2T4+wu4Kvt
	 LPrDkclzmTq6w==
Message-ID: <d4812513-6cfb-4865-8636-b83dd92c23a0@kernel.org>
Date: Fri, 6 Nov 2026 21:58:49 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory_hotplug: don't offline a hwpoisoned page
 still in the page cache
To: mt4022@columbia.edu, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>, Gregory Price <gourry@gourry.net>,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 tz2294@columbia.edu, stable@vger.kernel.org
References: <20261105-memhp-hwpoison-pagecache-v2-1-029d35634d42@columbia.edu>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261105-memhp-hwpoison-pagecache-v2-1-029d35634d42@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 21:50, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 
> Memory offline skips hwpoisoned pages, assuming nobody uses them
> anymore.  memory_failure() however sets PG_hwpoison before it takes the
> page, and taking it waits on pcp_batch_high_lock, which offline_pages()
> holds for the whole offline.  A memory error during the offline thus
> marks the page and then waits while the offline skips it:
> 
>   Task A (offline_pages)               Task B (memory_failure)
>   zone_pcp_disable()
>                                        TestSetPageHWPoison(P)
>                                        get_hwpoison_page()
>                                          /* waits for Task A */
>   do_migrate_range()
>     /* P is poisoned (not migrated) */
>   test_pages_isolated()
>     /* P is poisoned (accepted) */
>   zone_pcp_enable()
>                                        /* P is off the LRU (Ignored) */
> 
> The block goes offline while the file still points to P, and the next
> walk of the file's pages (here drop_caches on ext4) crashes on a struct
> page of offlined memory:
> 
>   [   11.710348] Memory failure: 0x24224: unhandlable page.
>   [   11.710372] Memory failure: 0x24224: recovery action for get hwpoison page: Ignored
>   [   11.765371] page:000000008c304eee is uninitialized and poisoned
>   [   11.765389] page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
>   [   11.765440] kernel BUG at include/linux/mm.h:1990!
>   [   11.765458] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   [   11.772284] CPU: 3 UID: 0 PID: 85 Comm: mfoffline Tainted: G        W            7.3.0-17087-gd865f2677c44 #1 PREEMPT
>   [   11.777970] RIP: 0010:find_lock_entries+0x8ee/0xad0
>   [   11.798761] Call Trace:
>   [   11.799297]  <TASK>
>   [   11.803284]  mapping_try_invalidate+0xfd/0x2c0
>   [   11.810571]  drop_pagecache_sb+0x111/0x330
>   [   11.811572]  __iterate_supers+0x2e2/0x370
>   [   11.815863]  drop_caches_sysctl_handler+0x74/0xb0
>   [   11.816994]  proc_sys_call_handler+0x2ec/0x440
>   [   11.821360]  vfs_write+0x545/0x1250
>   [   11.825220]  ksys_write+0xfa/0x200
>   [   11.830202]  do_syscall_64+0xfb/0x590
>   [   11.832084]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   [   11.848423]  </TASK>
> 
> Once the memory is also removed it's a use-after-free of the memory map.
> tmpfs and the swap cache can end up the same way without the race.
> Since commit a76054266661 ("mm: shmem: don't truncate page if memory
> failure happens"), memory_failure() leaves a poisoned tmpfs folio in the
> page cache on purpose, and it does the same for a dirty folio in the
> swap cache.
> 
> Treat a hwpoisoned page whose folio is still in a page cache or swap
> cache as busy in scan_movable_pages() and
> __test_page_isolated_in_pageblock() so that the offline fails and a
> waiting memory_failure() can go on.  Also have do_migrate_range() leave
> such a folio alone instead of taking it off the LRU, so that
> memory_failure() can still remove it from the cache.  A later offline
> succeeds once the page is out of the cache.  With the fix, the offline
> fails with -EBUSY and the file doesn't point to offlined memory anymore.
> 
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within about 10s.
> 
> Fixes: b023f46813cd ("memory-hotplug: skip HWPoisoned page when offlining pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> Changes in v2:
> - Leave a hwpoisoned folio that is still in a page cache or swap cache
>   alone in do_migrate_range(), so that a waiting memory_failure() can
>   still remove it from the cache (Sashiko)
> - Rebase onto current mm-new
> - Link to v1: https://lore.kernel.org/all/20261101-memhp-hwpoison-pagecache-v1-1-ed8785ca44eb@columbia.edu/
> 
> A pinned hwpoisoned page still isn't covered.  I'll send the refcount
> check David suggested as a follow-up.

I didn't understand why just checking for the refcount is not sufficient. Can
you elaborate once more (and please not send a new revision before the
discussion is over).

Memory poisoning must grab a reference when setting the folio hwpoison. Any
other reference (pin, pagecache, swapcache, mapping) keeps it alive.

Why can't we build on and?


-- 
Cheers,

David
