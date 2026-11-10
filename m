Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292685;
	b=Wsq+y/0CMuQX9gKKZvk0FPSZ06a/N6GW06xhRI2PNwrvNq3EmOuZbUCXTHmWpgesEP7J
	 YTtYJiJoGJCWKhVU3Mg5VNOZ7R399tjpP1k5ofJpRr3fLbU2ivvTH4Z7CKbxRY+9a2/v2
	 rJBjLoqwAZtxm9BL8zrkuzzHI2HTEwct5Kzj5EWFLbIYKzw1GHxVbS/qYDFgiGC/7CN8t
	 Z+LdyUvyF3j/dT0pYBL6RRzVCka1yUfriu5e/qMODHtRvp994fj5ItXa9mUQ/1gUKvUY1
	 5IGwHVzxbcBQf/M6+IIzX1shC6WV8Q13XUpHkVJdlhyNMA12nh6D5EzKTSFZ9rRcoaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292685;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=788eD6EYFiPFkFjsWwu7gXMD/5pQr2HRYw9Oa5iyE+c=;
	b=NVPxuc+Acdrc/ajOtv0Xy3FIZxHrPcs3XBEY/Y7k9d9bscqqXxRVdTn+MWELZAJv7oO7
	 10gD0OHpvVwF7962nP5r8cv+1P7x23CLYztj4oaUdntj1MGZR8g8bLaM00ZSdFCT877sA
	 /i/d+HHRvEy5q5EMajokZ+x3n8MSCc752BOkUvwdXhVRleXIraxW0jse6IBeTmOFbiTWY
	 u7NYeEgyMceslraWviA2j+CeSI2Y7ZulYjZDEmikKZ29aWtZQsdqJ8De8AFBEin+bX02K
	 dPue6uX3GoFMy8PgnmnCTKB/bWs70Wazb3gD3CQB4TYYrilMxINfM9nNuv/TrnueP/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fdMM5zPn;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB42606A31C;
	Tue, 10 Nov 2026 06:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB42606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fdMM5zPn
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794292681; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=788eD6EYFiPFkFjsWwu7gXMD/5pQr2HRYw9Oa5iyE+c=;
	b=fdMM5zPnLkC66yxP9Oz6oBKyzALrZKMlKpF10HZlg6pyVrVAiRf5jEx25KkQVvEQTPYi6k0/b+9bBG6G13BO/plE/f5dlQ6ZCDx7fT9woTVfEZdKSCIrAsI4R5Z4PJC1NKUzjOoQySScn7nKhiXzkq0dEIZbvtRo1lFqgX6sjuc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0XEUOs81_1794292679;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEUOs81_1794292679 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 14:38:00 +0800
Message-ID: <f0ff3284-53a6-4555-9e8b-fc6198be84eb@linux.alibaba.com>
Date: Tue, 10 Nov 2026 14:37:58 +0800
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
Subject: Re: [PATCH v2 1/2] mm: free unused page table allocated by
 do_set_pmd()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261106-khugepaged_set_pmd-v2-0-d2457b5e377a@kernel.org>
 <20261106-khugepaged_set_pmd-v2-1-d2457b5e377a@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261106-khugepaged_set_pmd-v2-1-d2457b5e377a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/26 8:36 PM, David Hildenbrand (Arm) wrote:
> do_set_pmd() can allocate vmf->prealloc_pte on architectures that need a
> deposited page table, such as PowerPC with the hash MMU. If the PMD is
> no longer empty when it takes the PMD lock, it returns VM_FAULT_FALLBACK
> without consuming that table.
> 
> Since collapse_pte_mapped_thp() uses mmap_read_lock(), a concurrent
> userfaultfd operation can install a PTE table before taking the folio
> lock. If that races with set_huge_pmd(), the unused preallocated table
> is lost when its local vm_fault goes out of scope.
> 
> Track whether do_set_pmd() allocated the table and free it after dropping
> the PMD lock if it was not consumed. Preserve any preallocated table
> supplied by the caller for PTE fallback. Successful PMD installation
> consumes the table and clears the pointer.
> 
> Returning without a preallocated table matches the existing behavior on
> architectures that do not need a deposited table. All callers
> already handle that case.
> 
> Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
