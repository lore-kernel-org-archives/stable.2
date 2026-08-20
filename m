Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF812B94;
	Thu, 20 Aug 2026 02:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191606; cv=none; b=dFdxjKkgrH5HqYbKv+5vjLX6xZCFdfbyAyAU0Fo1Ag6WRPBe+w0+kSr00YDOpI8ssW3rwr5jj93jzREGy/R7PE/QI3rnZdM1BuzXg37k++RCRfc0NMGPBdKeO00KBt6ZADir4bkOReuaf6zoIg7hmZGaQmiw67nWoNZS9AwjUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191606; c=relaxed/simple;
	bh=UW9MLdMfEBHYhqxyjEOT8LE0ArxnuG0UJSAJjZ7PC38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Puw49CT0mAvhz20KHphEVfzgTCWwL7EYf2MpFy0rT36O41phtkchgRO1YD5sZImtfNHxhjojDJFrcp6WJmuMyLytBSVSqC+U1tnSu9AQQdZI8BiZkznMtv1DxLJqmYBDhxv2Y8OeLd0+iIKaHD2IibqYCHnr/jkaV9hFsnly9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GcAE1X3s; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GcAE1X3s"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787191600; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9cn1/P/B3zAG2kEeQ3u4Y6BjIR36UHwUo2nuNriXzYk=;
	b=GcAE1X3ssimasAo2zTgXZ9zNhVlBCyXo6HhVbvMNrHyQWYknD8FtAO8T+2b7Gzmxc5YvF3Z2SRuj3sUmx00EmPaeR1YgI0wuQZaynIJ+V3yPLRYLcpD8i2/XQRjG/i913/z5fy1pNB1HamiEVTc8l/uG2F8JMsqiFuTYXXVQ3Ec=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9I-64s_1787191597;
Received: from 30.74.144.123(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X9I-64s_1787191597 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 20 Aug 2026 10:06:38 +0800
Message-ID: <955fea9b-7c5a-4646-8116-efd848f71e61@linux.alibaba.com>
Date: Thu, 20 Aug 2026 10:06:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, baohua@kernel.org,
 david@kernel.org, dev.jain@arm.com, lance.yang@linux.dev,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ljs@kernel.org, nico.pache@linux.dev, ryan.roberts@arm.com, ziy@nvidia.com,
 kas@kernel.org, nphamcs@gmail.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com
Cc: stable@vger.kernel.org
References: <20260819101222.3732660-1-usama.arif@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260819101222.3732660-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/26 6:12 PM, Usama Arif wrote:
> zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
> file case, but not the dirty bit.  The pte path does propagate it, in
> zap_present_folio_ptes() and so does the pmd split path, in
> __split_huge_pmd_locked().
> 
> For most file mappings the omission is harmless, because writing to a
> shared file mapping goes through page_mkwrite(), which dirties the
> folio.  tmpfs is different: it has no page_mkwrite(), and
> vma_wants_writenotify() is false for it, so a *read* fault on a
> MAP_SHARED tmpfs mapping installs a writable pmd via do_read_fault().
> do_read_fault() does not call fault_dirty_shared_page(), so subsequent
> stores through that mapping set only the hardware dirty bit in the pmd
> and never call folio_mark_dirty().  A shmem folio allocated by a fault
> is marked uptodate but not dirty (see the clear: block in
> shmem_get_folio_gfp()), so PG_dirty is never set at all.
> 
> Unmapping such a folio - munmap(), or exit_mmap() when the process dies
> - then loses the only record that it was written, because zap_huge_pmd()
> drops the pmd without transferring the dirty bit.  Reclaim afterwards
> sees a clean shmem folio: the whole swap-out block in
> shrink_folio_list() is inside "if (folio_test_dirty(folio))", so
> pageout() is skipped and the folio falls into __remove_mapping().
> There, folio_is_file_lru() is false for a swapbacked folio, so no shadow
> entry is created and __filemap_remove_folio(folio, NULL) simply empties
> the i_pages slot.  The data is freed without ever being written to swap,
> and the next fault on that index returns a freshly zeroed folio.
> 
> This is silent data loss for any process that keeps state in a
> MAP_SHARED tmpfs segment across an unmap - for example a cache handed
> from one process generation to the next through /dev/shm.  It requires
> the folio to be PMD-mapped, so it only shows up once shmem THP is
> enabled (which is what we did in Meta fleet and started noticing crashes);
> with THP off the pte path transfers the dirty bit correctly.
> It also only becomes visible when swap is enabled, because with no swap
> device shmem folios (which are on the anon LRU) are not scanned by
> reclaim at all, so the clean folio is never dropped.
> 
> Reproduced on x86_64 with a tmpfs mounted huge=within_size: read-fault a
> 2MB-backed region, write a known pattern through the resulting mapping,
> munmap, force reclaim of the cgroup, then re-map and read back.  Without
> this patch the region reads back as zeros and vmstat shows zswpout 0 -
> the data was discarded rather than swapped.  With this patch the region
> reads back correctly and the pages are swapped out as expected.  With
> huge=never, or when the first touch is a write, the test passes either
> way.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---

Thanks for the fix. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
