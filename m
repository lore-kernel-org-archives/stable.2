Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996843;
	b=tdb0NqNX4c6FCfzJ3cWMAVuWAuTubAjGR8BqlmVXOnL72/KBq/xhEsjKcUJwcfdqKw+m
	 WOQREK5LGGCa/hzmPqsad8iEoLPU87ELB088caWMNDA006jvPlDg35TT4L07RV3NKGn0O
	 5+PhtdGesl5xEbl51eXgToQUeiP0lp2VQ0LSfFBOSP9biFgc8jWpuABLMT9P2+SE2sjKR
	 I4CjTjRSgtAz4NehUcB3Iv4FNDvryy3muqByWBXS2rX5nTC65JwTEcuzOce61duH6Y2d0
	 QsybfqW6Rlsnn7wC0Crl95Byl0cLFIr4q/y9WFRcmS/Im1eW92gAS3E1WT4IiriKfmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996843;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gt+mGhyacKtik+zhBd0qIAApd6LUeQdQWtl+tJU7pFQ=;
	b=5IjsblQjmf2vTAMIHO5tZ2MwASVp2Z7QU7ptm5pvZTmS82AckWt2Qf+qvPFKpNnKFF3u
	 D5VAtTxqHgYrl6IFvkPJGh+mNwZnDcr6T921XyT114LiV06v/stELWNtaboZjbPsiiFAs
	 3TYxA5uk8P5bqieAx1CCM4Y4SrM7zh5EMza1xLZSSGM+hqXucTdo3pKQxI6OfnHrGr8XE
	 huobR42+yq6ub3mMo9xcG9pgiMpHHIm/K/5F+zPpVCRu99r9/Izq0A/+pXX0Pr1Pq44ZD
	 feY/RKlvfLmd/BpQcFeL7ncqii2fRX3JktDHOxbwsuD94saZckb+lXbWfpN7CoEHZ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rfZ0hfVU;
	arc=none smtp.remote-ip=115.124.30.100
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A5606A332;
	Wed, 18 Nov 2026 10:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 544A5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rfZ0hfVU
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794996832; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gt+mGhyacKtik+zhBd0qIAApd6LUeQdQWtl+tJU7pFQ=;
	b=rfZ0hfVU4wDJPmcqh7zASCYp2T8O+3h8mhB3LNJ7HHhUkhEe6Cp/iPUfZiVfvkJUifaawSx64Z1pkeCtOJ9rQ9DADNteOiM406F6K9wgh3q+nzC2pOVqVVReS4aZC/mJldwdvjrQyohHzZzbNCw7icdwQK7MZKBrp3Mrwc2MNsE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF0Q23H_1794996831;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XF0Q23H_1794996831 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Nov 2026 18:13:52 +0800
Message-ID: <62b07884-afca-4f81-9b22-b4f890ed68c6@linux.alibaba.com>
Date: Wed, 18 Nov 2026 18:13:51 +0800
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
Subject: Re: [PATCH v2] mm: shmem: limit forced anonymous shmem huge orders to
 MAX_PAGECACHE_ORDER
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Jingyi Sun <1045704958@qq.com>, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Luiz Capitulino <luizcap@redhat.com>
References: <tencent_FCBAE9157D42FFF00E681A2D5EA72CEEDF08@qq.com>
 <29bca989-c3ce-4995-ab1f-1e2c49b93e48@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <29bca989-c3ce-4995-ab1f-1e2c49b93e48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/18/26 5:31 PM, David Hildenbrand (Arm) wrote:
> On 11/18/26 03:45, Jingyi Sun wrote:
>> When the top-level shmem_enabled knob is set to "force",
>> shmem_allowable_huge_orders() returns huge_shmem_orders_inherit for
>> anonymous shmem without masking it with THP_ORDERS_ALL_FILE_DEFAULT,
>> unlike the other return path at the end of the same function.
>>
>> huge_shmem_orders_inherit defaults to BIT(HPAGE_PMD_ORDER). On arm64
>> with 64K base pages HPAGE_PMD_ORDER is 13, while MAX_PAGECACHE_ORDER
>> is 11 because of the xarray split limit. With shmem_enabled=force, an
>> anonymous MAP_SHARED mapping can therefore get a 512M (order-13) folio
>> in the page cache. Splitting it later, e.g. on swap-out from
>> shmem_writeout(), triggers
>>
>>    WARNING: lib/xarray.c:1051 at xas_split_alloc
>>
>> and the split fails, so the folio can never be swapped out.
>>
>> This is the same problem that commit 9fd154ba926b ("mm/shmem: disable
>> PMD-sized page cache if needed") and commit b66b1b71d7ff ("mm: shmem:
>> avoid allocating huge pages larger than MAX_PAGECACHE_ORDER for shmem")
>> fixed for the other paths; the force branch was left out. Mask it with
>> THP_ORDERS_ALL_FILE_DEFAULT as well.
>>
>> Reproduced on v7.3-rc2 in QEMU (arm64, 64K pages, -cpu cortex-a72,
>> 4G RAM, zram swap): with shmem_enabled=force, a PMD-aligned
>> MAP_SHARED|MAP_ANONYMOUS mapping of one PMD size got a single
>> PMD-mapped folio (ShmemPmdMapped: 524288 kB) and MADV_PAGEOUT
>> triggered the warning above in 3/3 runs. With this change: 0/3.
>> shmem_enabled=always and 4K pages did not show the warning. The code is
>> unchanged in v7.4-rc3 and in mm-unstable, but the test has not been
>> re-run on those trees.
>>
>> The issue was found with a research static analyzer for
>> cross-architecture dependency bugs and confirmed with the QEMU
>> reproducer described above.
>>
>> Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
>> Cc: stable@vger.kernel.org
>> Cc: Luiz Capitulino <luizcap@redhat.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: Jingyi Sun <1045704958@qq.com>
>> ---
>> Changes in v2:
>> - Dropped the Assisted-by tag (Baolin).
>> - Collected Reviewed-by from Baolin.
>> - Dropped the note about the overlap with Luiz's mTHP series; Luiz
>>    confirmed his series will land after this patch.
>>
>> v1: https://lore.kernel.org/all/20261117121626.1058-1-1045704958@qq.com/
>>
>>   mm/shmem.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 10cef89b00b0..41bb3f2c6b63 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2114,7 +2114,8 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>   	 * means non-PMD sized THP can not override 'huge' mount option now.
>>   	 */
>>   	if (shmem_huge == SHMEM_HUGE_FORCE)
>> -		return READ_ONCE(huge_shmem_orders_inherit);
>> +		return THP_ORDERS_ALL_FILE_DEFAULT &
>> +		       READ_ONCE(huge_shmem_orders_inherit);
> 
> could we instead set
> 
> 	mask = READ_ONCE(huge_shmem_orders_inherit);
> 
> And sue a goto to the end of the function  where we have
> 
> 	return THP_ORDERS_ALL_FILE_DEFAULT & mask;
> 
> Avoiding the goto means more churn I guess.

Yes. This fix seems more simple, but no strong opinion on this:) .
