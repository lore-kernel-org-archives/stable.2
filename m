Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767622;
	b=2f+ru3wQcHhZkHND8tN/48/4xpLDfWmU27ePk1GZYW2MML54amwKflvsI/Tab5bkYDAd
	 eJFQBvXumwH8ym48Agb3CtKH8Be3/a7lOCrG9EGztL70XWDmmHQ+Ku3Odf1kHsAAjJAIf
	 j3/VZmdIvWMjRqQ8s5maihAGQS21aDdiUmkkf08mpc/yxKVL6YzkdMRjnWGK27XoB16bo
	 uP93CTKwS2xkNb57lii36d8JEZgNwB+G4gMF74/cSxSeThNdtaL15dx1S+XSbu2yx69Ux
	 IGAI7Sp/KK25mPwkl2iRGGjByIoS9X18136Wp+lf8uvI9LaEyTEKukcI5bFd90Zh3aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767622;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=RvQhR480yHCQItaO6gHXWPUeM4v/LpwwcvQ0xdOPdME=;
	b=rDYEM9/OkF69a/pv4ry6Dt5b4A75mbxrF0S2L+i864/hjsAI6olPY5hGRNFQPNeUXXNJ
	 hyxCvGZ7CTKNjFkAAbcnFyvw5+sQ06PGFJfoCy/KB6jmoC+XXrn7OCqbVtZIE7I7aXC5M
	 BoBGDGpnacNoXOFSl6aXZNXKhGaULCvfnw5ggy4f1sVswhPQD1t64rP59SDDirs5UwaD5
	 9hNnkkk7c4pLbtPFL1HMQGxoV10EW3OWchepp47MI3+VJzxcVQ3ZDP6EC4u1UMhsrqCfL
	 xrGPz0yr6FxOmrEpaiG0xfpxCI69cb923kDHcjaVXMNRpoBuTZp79sV/8/uSVmkmBZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WapQgj7V;
	arc=none smtp.remote-ip=95.215.58.250
Received: from mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C47606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17C47606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WapQgj7V
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Q/+mSsFUVeFikAxHDslRcT8lqDJx4o1aUGktqShMmg8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795767620; v=1; x=1796372420;
 b=WapQgj7Vj5MmbQs5ejFbmZ6GUqr4pPxzMlUdrjeW1igbPGR+lP3mI7vRRH6Gt08ff77NXAte
 +TBgYKbfO/LTAWBfo53Cw4RNpZx7j2TFvobOvHg/rwjmHclEswOSEnKSixbZikmSurmz3Fea8cO
 VNTHNXznrlYKCY2iC3Gh1hIE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5405594211a3eae6;
	Fri, 27 Nov 2026 08:20:19 +0000
X-Mizu-Trace-ID: 5405594211a3eae6
X-Migadu-Flow: FLOW_OUT
Message-ID: <320a6162-9063-418c-92fa-62bcd574c399@linux.dev>
Date: Fri, 27 Nov 2026 16:20:08 +0800
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
Subject: Re: [PATCH 6.1.y] khugepaged: fix readahead lock inversion in
 collapse_file()
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org,
 syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
 Pedro Falcato <pfalcato@suse.de>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20261109201858-failed-6.1-eadce52a9ef6@kernel.org>
 <20261111132506.88827-1-lance.yang@linux.dev>
 <2026112627-anagram-unselfish-0719@gregkh>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <2026112627-anagram-unselfish-0719@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/11/26 22:18, Greg KH wrote:
> On Wed, Nov 11, 2026 at 09:25:06PM +0800, Lance Yang wrote:
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
>> Backport to 6.1:
>> - Use find_lock_page(), unlock_page() and put_page() for the existing
>>    page-based collapse code.
>>
>>   mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 32 insertions(+), 11 deletions(-
> 
> Does not apply :(

Okay, just a minor context conflict. I've resent 6.1 [1] and 5.15 [2]
backports as v2.

[1] https://lore.kernel.org/all/20261127081556.31348-1-lance.yang@linux.dev/
[2] https://lore.kernel.org/all/20261127081618.31491-1-lance.yang@linux.dev/
