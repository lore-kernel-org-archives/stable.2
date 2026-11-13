Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587681;
	b=mdW1dqdQ7JDhmDYAda79f/p1AXPVI1dhFI9GU7/dnE9UkKM7IgZebHZvw2sij42s0nBw
	 aATYZ8dIr6HKoY1uL5IxiXIWERzRfoG8EQrA0VjVHcC5mG89dYMyvVYDNiEgsiKPAHgwV
	 5XQp95os4V6CY9wtdK9OK8D9bvBQktvZBWAqz9jUCMVdKjkbjyCeVncYb0v8QocuHHUrA
	 78Me8Yz057rSB5nuenArOEhpqodp5Y7fdNBTvT74DycQ4v6W1J85mNwEONa7zeOrSp6lr
	 nAcC1Af7nmqKdsMgAchdUHMGggFnRdI2Ip2rZf0D3EzWqcJP5xdail05D+WDM4sWk/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587681;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YwbyJ0NRgQ8wg/X7halZ/zABdx2fVYNGqpqrLvUlKkQ=;
	b=Xq883CzncVcxVqj3zNN0o5Lyler4GRqyxlrAerMC2FIoC1Z90czXZg17Y0uapxa+6jbz
	 uZFLoWzOJCByndBxULWAF2Dfh1VDwyzgo885WgqE689XR75SLoMOVjovuK5R4QaFtYqdn
	 E7/sagtU7TydLsVQW95cZf8VY8v6lx5d40IxjrMFtyRgkwQ0uKZwBQUPhYCIv3a7/SuK5
	 FtONi+Z2EM2n+p9fgP22acN/qPi/JtCKCHv6oShPs0cCHyBIAURJN4R6Bb2mvfkYqVnEc
	 ZIrBnklcOzXOGZ5dUO4qdMMvXydR6UTyLkCHu1VWLms+IutlLbVGRlJLRGJLzKIIp4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RK7kjA6W;
	arc=none smtp.remote-ip=95.215.58.70
Received: from mta1.migadu.com (out-70.mta1.migadu.com [95.215.58.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D6606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 535D6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RK7kjA6W
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gPvYDAm3LgiXHo34VoDJZgkpsFV5DI45x0fwNCeAI8Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794587678; v=1; x=1795192478;
 b=RK7kjA6WQhGstsXxbcyicSyvV0BgTMqPZwVETBJMzvIv1xGlOSPN57zi9LD18JtNWm0YGeNc
 mHKshuo4UDqXMrT6vHaNpE5iRYGRQh62SHRa7cURXfFXlhViFPMhjDd1TFfjYm+0jkUSt5+mm32
 tznRlPT0+HVOgSg0GuhnWxxM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 28008212ac1ae067;
	Fri, 13 Nov 2026 16:34:38 +0000
X-Mizu-Trace-ID: 28008212ac1ae067
X-Migadu-Flow: FLOW_OUT
Message-ID: <a849043e-8421-473f-a7de-8030482bd5b5@linux.dev>
Date: Sat, 14 Nov 2026 00:34:27 +0800
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
Subject: Re: [PATCH 6.12.y] khugepaged: fix readahead lock inversion in
 collapse_file()
To: Zi Yan <ziy@nvidia.com>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
 syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
 Pedro Falcato <pfalcato@suse.de>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20261109200933-failed-6.12-eadce52a9ef6@kernel.org>
 <20261111132605.88959-1-lance.yang@linux.dev>
 <59D0C605-0343-4CA6-8529-C399AE8BBA9F@nvidia.com>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <59D0C605-0343-4CA6-8529-C399AE8BBA9F@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/11/14 00:27, Zi Yan wrote:
> On 11 Nov 2026, at 8:26, Lance Yang wrote:
> 
>> collapse_file() can call page_cache_sync_readahead() while still holding
>> source folios locked. If truncate holds mapping->invalidate_lock
>> exclusively and waits for one of those folios, readahead waits for
>> invalidate_lock and neither side can make progress.
>>
>> We need to release those folio locks before starting readahead. On a page
>> cache miss, roll back first, populate the collapse range, and retry once.
>> Doing readahead after rollback avoids an extra pass when all folios are
>> already present. If another miss occurs on retry, give up rather than keep
>> retrying while truncate or reclaim removes folios.
>>
>> Keep page_cache_sync_readahead() and wait for read I/O with
>> filemap_lock_folio(), releasing each folio before moving to the next. The
>> existing uptodate check during collapse still handles read errors.
>>
>> Shmem uses shmem_get_folio() for swapin and fallocated folios without
>> taking mapping->invalidate_lock, so it is unaffected.
>>
>> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
>> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Link: https://patch.msgid.link/20261026152013.10511-1-lance.yang@linux.dev
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>
>> (cherry picked from commit eadce52a9ef657d561b3e76c9b5f178bd99735f5)
>> ---
>> Backport to 6.12:
>> - 6.12 still takes invalidate_lock in collapse_file() after locking the
>>    source folios. Use filemap_invalidate_trylock_shared() and roll back
>>    on contention, otherwise the same deadlock is possible even after
>>    moving readahead.
>>
>>   mm/khugepaged.c | 49 +++++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 37 insertions(+), 12 deletions(-)
>>
> <snip>
> 
>> @@ -2040,7 +2038,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>>   		 * in do_dentry_open() truncating the page cache. This is
>>   		 * particularly important if there are dirty folios in transit.
>>   		 */
>> -		filemap_invalidate_lock_shared(mapping);
>> +		if (!filemap_invalidate_trylock_shared(mapping)) {
>> +			result = SCAN_FAIL;
>> +			goto rollback;
>> +		}
>>   		filemap_nr_thps_inc(mapping);
>>   		/*
>>   		 * Paired with the fence in do_dentry_open() -> get_write_access()
> 
> This additional change to address the same deadlock makes sense to me.
> 
> Acked-by: Zi Yan <ziy@nvidia.com>

Much appreciated, thanks!
