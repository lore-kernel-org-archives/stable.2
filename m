Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7B3403F4;
	Mon, 14 Sep 2026 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355698; cv=none; b=Y9d38fLQV2pwC4v6JlsPutIpkugBUWEUeOxEutanQt9/bd0834d6indUjhIxVmUsTtwd/12CjWpPwcuDzYx7V9oosIFGvjy+RXAbq/2A63xTnrRNPFgR1IgN5vWVUy0U5/g9xK+JayfbrBqP2+ZbknOf6c4BuQRyCFXFtCpiHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355698; c=relaxed/simple;
	bh=NyOIWIhJQqPdHthFyXcdc/V0E4rDzr9zyBpAmjV/99o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aATl1Qovw1Hj484grbh5UNIG73SKJKno5sVabKmm3YqdBr4N901OtwELRUHPzpv5GZjZivxiXDoypaeFHCRu4ne24nlNVGTfZMFFN0EJJmIrqhTGce309gVsaB9h5co/NfOpLHUyQELJkw+NsETiNnG8WAi6cKToXcDX2STfhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bWC7ZaYm; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bWC7ZaYm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789355680; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aVhxsMXkoOh4go6lqUh1XBFzQPqM1DF7VxUa3Bcntmw=;
	b=bWC7ZaYmPOJANY0Fgdw3I+jgafyBJzAMm55SeaxcFpOShYihKnAYjRNyhRvg0mnLXmCgp5cJNQC38byA0zig+FtRjG4Q0NFUxWxSjx9D9dHfmWaz7lKuuQ3s+wy2QbBXmJ1rxBMlyHJph2upXmzNNEZwNeJ6nEG4PcPR74fjeec=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0XAqABCh_1789355678;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XAqABCh_1789355678 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 11:14:39 +0800
Message-ID: <8fbfb29d-ecbb-4561-990d-4e1a1b677d75@linux.alibaba.com>
Date: Mon, 14 Sep 2026 11:14:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] khugepaged: hold invalidate_lock across
 collapse_file() readahead
To: Matthew Wilcox <willy@infradead.org>,
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, "Liam R . Howlett" <liam@infradead.org>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <DLEBZ0GIGNQ8.17U563YYJ37AA@nvidia.com>
 <20260913163644.122133-1-ngocthang2710.1999@gmail.com>
 <aqck8rfGByZhdtqT@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aqck8rfGByZhdtqT@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/14/26 6:34 AM, Matthew Wilcox wrote:
> On Sun, Sep 13, 2026 at 11:36:44PM +0700, Nguyen Ngoc Thang wrote:
>> @@ -2271,6 +2272,15 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>>   	if (result != SCAN_SUCCEED)
>>   		goto out;
>>   
>> +	/*
>> +	 * Take invalidate_lock before any folio lock: the readahead below
>> +	 * needs it, and truncate holds it while waiting on folio locks.
>> +	 */
>> +	if (!is_shmem) {
>> +		filemap_invalidate_lock_shared(mapping);
>> +		need_unlock = true;
>> +	}
> 
> I'm not a fan of all this surplus commentary.  And what happens if e
> simultaeneously truncate a shmem file and collapse it at the same time?
> I know it doesn't use the invalidate lock, but does it go wrong in some
> other way?

IIUC, shmem uses the folio lock to synchronize truncate and collapse. It 
will check whether truncation has occurred after taking the folio lock 
in shmem_get_folio_gfp():
	
	folio_lock(folio);

	/* Has the folio been truncated or swapped out? */
	if (unlikely(folio->mapping != inode->i_mapping)) {
		folio_unlock(folio);
		folio_put(folio);
		goto repeat;
	}

So shmem looks safe here, unless I'm missing something.
