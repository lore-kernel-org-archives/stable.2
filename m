Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349887;
	b=ZD4XE4xKc/6cy4FBmLTnLQC6CQMsyHnCAp1oQDbyfLgb+PKDmIPY7WYI6F8dNxMIwD66
	 JyB7gYu8O9GAqefIGIs3mPWsU9grrVpnMJjloHO0IBVIv4v1rUUuirJkWhSeCGs+YVGmd
	 hR0hFx2udhZ14AtJJkP4IlenwO6knhHW4FOtUES2SBpAtctTpreQo1MfhfMn96Fgy87Jd
	 l5nWKoKM93LLSe+TL4Jgyzx9NOmBQZ/UD5yBBLifexjMtfncOZoD3eZI0J466TROixW8Q
	 Aq2r9/RbHFYfqS7mngOSOFVE3FpttMeaC2iXB5/qFPnsSx6kCbLFMc4t+9FBuMad6pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349887;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FYu/kW3DhjeE7f36QmiPGs1R7yxjR+I5Ium8lq5S9Jc=;
	b=ymQQ4lS8sgC/uNdV7QOhGpV3nLflA6MSuSlcxVV81yYZr8u+jRD7AhJokrcBdlvShGpM
	 DqEdfoX1lmvkY47cmbPamaY4tWt6BHN1DK8TU2CtP7kA8WCCYFbXTdI0aq7A2unRfANJb
	 eK9RuYKp2i2PosPiV2cdptuaYJjymfkOx46klMKYnu9VIug9oCSPJtbp8CHxpaNNmXGD9
	 G5NmhiofsiOTkp+bMWfCx9YUtcFwTBQP9t8mfRu9y8umisP/mZUqJ86CGoF+R8POsKkhH
	 ubZuCJUoph/yDFV9oD97RFO5QiwIbifu3Gf4gL5vXybGxXgXlG+Sizy3JB3pmP5zl1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W9G715Mv;
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767E606A31D;
	Fri, 30 Oct 2026 08:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3767E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W9G715Mv
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793349883; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FYu/kW3DhjeE7f36QmiPGs1R7yxjR+I5Ium8lq5S9Jc=;
	b=W9G715MvBpAFhQFtxunztd5ZGyM++QavC8YKB/aIpU/oEUDQcllofOAimHnAw73UiteZjBny5Zfq11FqeYan8ecZQxvNdYBPn9ivvmzZk7r30EI/5nKTcuYSgZfe1nRJwu/NlKlj3jQTpgzogSdevF3yx9pZzFPHvYEz1z20gYQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0XDlh9st_1793349880;
Received: from 30.74.144.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDlh9st_1793349880 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Oct 2026 16:44:41 +0800
Message-ID: <7b8ef469-d593-4d38-89b4-ba397bc3fea0@linux.alibaba.com>
Date: Fri, 30 Oct 2026 16:44:40 +0800
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
Subject: Re: [PATCH] mm/shmem: fix swapin livelock on a mismatched large swap
 cache folio
To: mt4022@columbia.edu, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
References: <20261027-shmem-swapin-mismatch-v1-1-84e30aa3b9e5@columbia.edu>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261027-shmem-swapin-mismatch-v1-1-84e30aa3b9e5@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/28/26 4:33 AM, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 
> On a SWP_SYNCHRONOUS_IO swap device, a large shmem folio can be left in
> the swap cache over swap slots that another file now uses.  Reading
> that other file then loops forever in shmem_get_folio_gfp():
> shmem_swapin_folio() finds the large folio, rounds the index and the
> swap entry down to the folio's size, finds no matching entry in the
> file and returns -EEXIST, and the retry finds the same folio again.
> Since the task keeps the mapping locked, a munmap() of the same mapping
> waits forever.
> 
> The folio is left behind when the slots are freed and reused while the
> swapin is still allocating it:
> 
>    Task A (reads X)                      Task B
>    ----------------                      ------
>    shmem_swapin_folio()
>      allocate a large folio
>      for X's slots
>                                          punch a hole in X
>                                          /* X's slots freed */
>                                          swap out file Y
>                                          /* Y reuses those slots */
>      add the folio to the swap
>      cache over those slots
>      shmem_confirm_swap() fails
>      /* -EEXIST, the folio stays
>         in the swap cache */
> 
>    Task C (reads Y)
>    ----------------
>    shmem_swapin_folio()
>      finds the large folio
>      rounds down to its start,
>      where Y has no entry
>      /* -EEXIST, retried forever */
> 
> Before commit c246d236b18b ("mm/shmem: never bypass the swap cache for
> SWP_SYNCHRONOUS_IO"), a direct swapin that failed this way freed its
> folio instead of leaving it in the swap cache.
> 
> do_swap_page() already drops a large swap cache folio that does not
> fit for anonymous memory.  Do the same in shmem_swapin_folio() and on
> a -EEXIST, remove a large folio that is not
> anonymous/dirty/under-writeback from the swap cache so that the retry
> swaps in a folio that fits.
> 
> The reproducer below fills a small brd swap device so that a 64K shmem
> folio and the 4K pages of another file land in the same slots, and races
> a read of the first file with a hole punch and a swapout of the second.
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development, but the non-deterministic C
> reproducer can typically trigger it in the 2-4s time range.  With the
> fix, nothing is triggered after 600 seconds.
> 
> Fixes: c246d236b18b ("mm/shmem: never bypass the swap cache for SWP_SYNCHRONOUS_IO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> Two patches in David Hildenbrand's v2 shmem fixes series are related
> to this one.  "mm/shmem: fix truncate hang in large swap entry" [1]
> makes truncation retry -EEXIST directly, so it can also loop on such a
> folio.  "mm/shmem: preserve allocation errors when swapping in large
> entries" [2] fixes a different -EEXIST loop, where a failed allocation
> is reported as -EEXIST.
> 
> [1] https://lore.kernel.org/all/20261027-fixes_shmem-v2-10-86a00952acb9@kernel.org/
> [2] https://lore.kernel.org/all/20261027-fixes_shmem-v2-11-86a00952acb9@kernel.org/
> 
> Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/shmemloop.c
> ---

Thanks for the fix. It's a really complicated race and I spent some time 
understanding it:) . I tried several different ways to fix it, but your 
patch looks like the simplest one. So,

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
