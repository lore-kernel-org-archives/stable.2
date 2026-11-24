Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488002;
	b=jHrNG5SytM9aIvGDqh6QDZGo1KfHLp6uWx2gRuOUKO4gpYL33Y8+C4rbLrk8xKODJ6P+
	 UV2hfoQvCWkK9FssNwGlKPx0N52y6B+0UeWgSfl/M6gwMBvnvKbKs4kCEyU0OQVSQbyZh
	 87QkzLys9baiGyDx/wPrx6IBFTJze4Z058FN68f80iwXk8avTyHK8ptt5x0Mkj3rwLy+w
	 kBZxiPZLFMWIOR0uVz97or57gAlswMUWqojLy1ZTh7o0sfSPcJSUl0N3IA6P38XzSVMmb
	 nH04hgIk0EW3R3SZjMb0jlIhEQb493jrvTEYlzwcxSmHFJChyw+YUVgW/9CmYXPbrmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488002;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sJ4gUX0/F5wdw93Yu4EtXJV9s8BHoRQzpleUP4DagLI=;
	b=OzkZbEJUuFc/nBsaXiD2w3+TQullFjP3RzzTe22RTXDkt1nOOaK2EH05FIm4KDRw3Xmi
	 QDYKm6DaWIja/kchohssR9O6GEIq9b9w5VvsROPjTw38oy+g4v47i/L/7S76Qq0ZNWiC9
	 cx+auO6iH1Rfbxj6naqRcBtjoAmasjL744mgk1VK9HmeD1GPXA6Rc7ENUgtFrXjW6TSJf
	 gVgHWPlS4uPigrw2fB/yKhDvU3Nn+44HXjz5sKlJSxYAlihjMe5TL/WCKBOHJd6HBWZZg
	 SNvIL91hz7YCmKkAQQAB9V0jw1rnMCSTw0g7okGd4z0irP4H/ByJXfcsKgwyzDd5b+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="sjQNW5/d";
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806F606A31E;
	Tue, 24 Nov 2026 02:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5806F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sjQNW5/d
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795487987; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sJ4gUX0/F5wdw93Yu4EtXJV9s8BHoRQzpleUP4DagLI=;
	b=sjQNW5/dukfYtqnaSLmz9ATouyQ9pnp7gbwnqE5Scjp6lLhd1/CxfOlSsIjJwlZp7L6s57qKyQzZ+ookI/YCeemT8KMAtcMoQDHPHKvbHZEzAs+uTpig/dbuQyIuAblDInTpGOKeiNq4UTabUsGqO1jOXD0sky1qk8PNS+bD4p0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0XFMwctk_1795487984;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XFMwctk_1795487984 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 10:39:45 +0800
Message-ID: <6d88dfe8-3f6c-4a86-9829-107195a318a7@linux.alibaba.com>
Date: Tue, 24 Nov 2026 10:39:44 +0800
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
Subject: Re: [PATCH] mm/shmem: don't drop a folio whose swap write failed
To: mt4022@columbia.edu, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@kernel.org>,
 Kairui Song <kasong@tencent.com>
Cc: Chris Mason <mason@kernel.org>, Chris Li <chrisl@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, Tal Zussman <tz2294@columbia.edu>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261123-shmem-swap-write-failed-v1-1-41a0115dfbf1@columbia.edu>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261123-shmem-swap-write-failed-v1-1-41a0115dfbf1@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/24/26 1:21 AM, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 
> shmem_swapin_folio() drops a large folio that does not fit the mapping
> from the swap cache if the folio is neither dirty nor under writeback.
> The folio can belong to another file and be under swap writeback, when
> the swap entry was freed and reused before the swap cache lookup.
> 
> Swap write completion does not take the folio lock.  On a failed write,
> swap_write_end() marks the folio dirty and then ends writeback.  Since
> dirty is tested first, the folio can look clean and written:
> 
>    CPU0 (swapin of file Y)             CPU1 (swapout of file X)
>    -----------------------             ------------------------
>    shmem_swapin_folio()
>      folio_test_dirty() == false
>                                        swap_write_end(), failed write
>                                          folio_mark_dirty()
>                                          folio_end_writeback()
>      folio_test_writeback() == false
>      swap_cache_del_folio()
>      /* X's data is lost */
> 
> The next swapin of X reads the slot whose write failed.
> 
> Test writeback first.  Both flags are in folio->flags.  If the
> writeback test sees the write ended, the dirty test then sees the dirty
> bit set before it.
> 
> With the fix, a folio whose swap write failed stays in the swap cache.
> 
> Fixes: fc2c19648d68 ("mm/shmem: fix swapin livelock on a mismatched large swap cache folio")
> Suggested-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
