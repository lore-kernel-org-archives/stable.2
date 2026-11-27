Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795752346;
	b=gpvis/d+Qef8fjzXwk1sZJKgnUBpdXM4BYp0m/U4Orkq8HAbPZe55gJopnf1Vomw50J0
	 sUOC/d3dY0sQu/FO5TdjaR/3m+ueHi4mhgacR/nyxvvjq8gxLB0UDcRqUFs9yvz12GNn2
	 GsWa3ih9QN62bmfttOOH52Rtb/vyRg1Bw0D4AH9pRPBDTP2Q7+ABzXsYYhVOHoqqfXFyU
	 ZMm7hSr8EIQkhVxmFCjJLpSDIEjK4lYQTS7tiWjRGb2POGKdMW+qPunX2VkaNQX9ybUmD
	 SyfToWFroeMChuXAIs/uJXPXn2LAXefqtsioFdYe/NpKnq2ayaclykrJ1ujBAfhQ7fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795752346;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=Ma+f5p80haJszFPPAIIEC1l3WLdFdBqpV7MIoNSrF48=;
	b=YNxnj9mVSoZOHp2szQzNGUxYK5QlsbGOKBP6MNHw2La7sxopmRqV6l257NuvbC7aEJmP
	 Egq4TnKkgug6vQkdyp70nITRAFyUBmRjJBBQUgky6vRyGG9/Fnmq+pJQG5IhKftCMI+KF
	 Eu5VqUk/3KZym38pANVcvuoLeekUOvUYCXQ3mqo6E9nuWc4xgT9nVl11f3UwbEG7qrlZu
	 /VAI+ccXa8osjKh581uEq5byU71q03tkYEpPG00KpMYm5hgrTXVBuW+FQlb1qPMs0PN4z
	 UhvTPU+QBzVpiYnkRQL+c3nq7+9RYAfPqYij+SuMi2KluumMwiQ0uRkqz4lxPJBk57Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=omijfA5C;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555EE606A31C;
	Fri, 27 Nov 2026 04:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 555EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=omijfA5C
Received: from [192.168.1.70] (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id B8EB620B7166;
	Thu, 26 Nov 2026 20:05:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8EB620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795752334;
	bh=Ma+f5p80haJszFPPAIIEC1l3WLdFdBqpV7MIoNSrF48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=omijfA5Cc+HumzTDcN5RSmmeizr3nKcpgIVYDhAvwS//fyO3Q0ZVB9vJcRC2PgeEF
	 wHmv+J2D80WDkMAfjOng7PYGhhK8l6++MR12DNtgPLS4XD/KyuXdoc345KtLyBkKrL
	 aqpWukiJnUHIJRehA/GrQzwhk3naYp9gHsqHHn9Y=
Message-ID: <74edd490-26bd-41a4-81ee-cd18b9f28154@linux.microsoft.com>
Date: Fri, 27 Nov 2026 09:35:34 +0530
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
Subject: Re: [PATCH] iov_iter: Fix direct I/O across compatible device pgmaps
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Oscar Salvador <osalvador@suse.de>, Logan Gunthorpe
 <logang@deltatee.com>, Leon Romanovsky <leon@kernel.org>,
 Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20261126053433.88531-1-namjain@linux.microsoft.com>
 <5cc60faa-002c-4c96-97e3-46d3002718c9@kernel.org>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <5cc60faa-002c-4c96-97e3-46d3002718c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/26/2026 6:42 PM, David Hildenbrand (Arm) wrote:
> On 11/26/26 06:34, Naman Jain wrote:
>> Commit 38446014648c ("block: don't merge different kinds of P2P transfers
>> in a single bio") made bio_add_page() reject pages from different
>> dev_pagemaps. This was needed for PCI P2PDMA, but also rejected pages
>> with compatible DMA mapping requirements.
>>
>> Commit 41c665aae2b5 ("block: relax pgmap check in bio_add_page for
>> compatible zone device pages") allows these pages in separate bvecs.
>> Commit 13920e4b7b784 ("block: add pgmap check to biovec_phys_mergeable")
>> prevents physically contiguous bvecs from different pgmaps from being
>> merged into one segment.
>>
>> But direct I/O now fills a bio using iov_iter_extract_bvecs(), which
>> retained the original restriction and bypasses bio_add_page().
>> For a non-atomic request handled by a single bio, only the data before
>> the pgmap boundary is submitted. The rest is not transferred, and the
>> request completes with fewer bytes than requested.
>>
>> Fix this by moving zone_device_pages_compatible() from blk.h to
>> memremap.h and using it in iov_iter_extract_bvecs(). This allows
>> compatible pages to be added as separate bvecs without relaxing the
>> same-pgmap requirement for PCI P2PDMA.
>>
>> Fixes: 38446014648c ("block: don't merge different kinds of P2P transfers in a single bio")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   block/blk.h              | 19 -------------------
>>   include/linux/memremap.h | 19 +++++++++++++++++++
>>   lib/iov_iter.c           |  3 ++-
>>   3 files changed, 21 insertions(+), 20 deletions(-)
>>
>> diff --git a/block/blk.h b/block/blk.h
>> index 50abfd9328861..460c064f1d1b0 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -142,25 +142,6 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
>>   	return true;
>>   }
>>   
>> -/*
>> - * Check if two pages from potentially different zone device pgmaps can
>> - * coexist as separate bvec entries in the same bio.
>> - *
>> - * The block DMA iterator (blk_dma_map_iter_start) caches the P2PDMA mapping
>> - * state from the first segment and applies it to all subsequent segments, so
>> - * P2PDMA pages from different pgmaps must not be mixed in the same bio.
>> - *
>> - * Other zone device types (FS_DAX, GENERIC) use the same dma_map_phys() path
>> - * as normal RAM.  PRIVATE and COHERENT pages never appear in bios.
>> - */
>> -static inline bool zone_device_pages_compatible(const struct page *a,
>> -						const struct page *b)
>> -{
>> -	if (is_pci_p2pdma_page(a) || is_pci_p2pdma_page(b))
>> -		return zone_device_pages_have_same_pgmap(a, b);
>> -	return true;
>> -}
>> -
>>   static inline bool __bvec_gap_to_prev(const struct queue_limits *lim,
>>   		struct bio_vec *bprv, unsigned int offset)
>>   {
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index c8a4979d4c780..a1d447a847990 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -202,6 +202,25 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
>>   		folio_is_pci_p2pdma(page_folio(page));
>>   }
>>   
>> +/*
>> + * Check if two pages from potentially different zone device pgmaps can
>> + * coexist as separate bvec entries in the same bio.
>> + *
>> + * The block DMA iterator (blk_dma_map_iter_start) caches the P2PDMA mapping
>> + * state from the first segment and applies it to all subsequent segments, so
>> + * P2PDMA pages from different pgmaps must not be mixed in the same bio.
>> + *
>> + * Other zone device types (FS_DAX, GENERIC) use the same dma_map_phys() path
>> + * as normal RAM.  PRIVATE and COHERENT pages never appear in bios.
>> + */
>>
> 
> Can you convert this to proper kernel doc while at it?
> 
> Also this should all be working on folios instead of pages. But that will need a
> zone_device_folios_have_same_pgmap() so we can defer it, not suitable for this fix.
> 

IIUC, you want me to change this comment to kernel doc, something like this.

/**
  * zone_device_pages_compatible() - Check if pages can share a bio
  * @a: First page
  * @b: Second page
  *
  * Check if two pages from potentially different zone device pgmaps can
  * coexist as separate bvec entries in the same bio.
  *
  * The block DMA iterator (blk_dma_map_iter_start()) caches the P2PDMA
  * mapping state from the first segment and applies it to all subsequent
  * segments, so P2PDMA pages from different pgmaps must not be mixed in
  * the same bio.
  *
  * Other zone device types (FS_DAX, GENERIC) use the same dma_map_phys()
  * path as normal RAM.  PRIVATE and COHERENT pages never appear in bios.
  *
  * Return: %true if the pages can coexist as separate bvec entries in the
  * same bio, otherwise %false.
  */

I can do that in next version. Thanks.

Regards,
Naman

