Received: from mta1.migadu.com (out-137.mta1.migadu.com [95.215.58.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640E3101B2
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787892461; cv=none; b=OVakgiGvKdLWCBlLrmsnd/HDU9vXZK3acB8tPRtI3lDBJNb2dWXqsPc61dbllNfiW/jVeJ98bXYLOWh6W07AEjJGMjEH1l47csPKH2/k+mNnJGGyAuYpF+6eC17LmZvGXzPp4O3sGI6wN0Xm38d2ctreSLUtbr3BUGNTEowrfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787892461; c=relaxed/simple;
	bh=mOPeMmcWI99dgCmtPzUV5tpD1eXN6gK8SASB4LmC0O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGdIGdD45kByInb+G5A0r+gM7dn2XbWo1hQm00ISoRMkWfT1mUY1bkTjN8la063GhSH6D+uI8ToVzUAYXw0BE8KX3yWp0YRO0fzoDZ745442ynVo5z7XLjiTHmVWPgzQy0YLCVe7A8Os8ueNIEUVLcgbUwltWbx8kuIYGw9asaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O8l0sqUH; arc=none smtp.client-ip=95.215.58.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O8l0sqUH"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mOPeMmcWI99dgCmtPzUV5tpD1eXN6gK8SASB4LmC0O0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787892457; v=1; x=1788497257;
 b=O8l0sqUHasUayzeZQ0pzSC+4EFkh8Ye9ji62pFuD9I3Ln+EdcoB8xVYXMFmTjUj5mGTng465
 zYp99+ybkZBJVL+no9nZ6qIJnOpqrqX4FpTTkUOLOiSJ1WaiJVwpUQ+5R8lxDFT+V77vzmZ6wnE
 K2xfAxf1CRD23rxUW7SOlUN0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 026258ee24c5dde1;
	Fri, 28 Aug 2026 04:47:26 +0000
X-Mizu-Trace-ID: 026258ee24c5dde1
X-Migadu-Flow: FLOW_OUT
Message-ID: <de3eed17-cb80-4cad-8437-4ad78b5896c7@linux.dev>
Date: Fri, 28 Aug 2026 12:47:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: bypass THP tuneables for huge pfnmap
 mappings
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, Nico Pache <nico.pache@linux.dev>,
 David Hildenbrand <david@kernel.org>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
 Usama Arif <usama.arif@linux.dev>, Dev Jain <dev.jain@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, "Liam R. Howlett" <liam@infradead.org>,
 Cedric Le Goater <clg@redhat.com>, Saravanan D <saravanand@crusoe.ai>,
 stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Zi Yan <ziy@nvidia.com>
References: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/8/28 03:55, Lorenzo Stoakes (ARM) wrote:
> The sysfs THP tuneables at /sys/kernel/mm/transparent_huge_pages/ rather
> confusingly only control the behaviour of THP in some instances.
> 
> They are not applicable to MADV_COLLAPSE operations, nor to DAX mappings.
> 
> Long-term, THP is predicated upon compaction being able to obtain large
> folios to populate THP ranges.
> 
> However, vm_normal_folio() returns NULL for PFN map mappings, thus their
> reference count is maintained by the driver, not core mm.
> 
> As a consequence, the folios are not subject to reclaim nor compaction, so
> are not truly part of the THP mechanism at all.
> 
> However, since commit 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
> introduced the ability to establish huge PFN maps, they have been subject
> to THP tuneables.
> 
> This is incorrect - if a huge PFN map is available (defined by
> vma->vm_ops->huge_fault being non-NULL for a VMA_PFNMAP_BIT VMA), then it
> should be mapped huge upon fault-in.
> 
> Correct this by explicitly checking for this while ensuring that smaps
> continues to accurately report THPeligible statistics.
> 
> While here, abstract the entire file-backed THP check in
> vma_can_map_huge_file(), with sensible separation of logic into helper
> functions.
> 
> Note that drm_gem_shmem_mmap() and panthor_gem_mmap() establish huge PFN
> maps of shmem folios, however they are marked unevictable in
> drm_gem_get_pages(), and in any case would fail the reference check in
> __remove_mapping() even if they weren't.
> 
> Failing to map huge PFN maps has resulted in significant real-world
> performance degradation, see links for details.
> 
> Reported-by: Cedric Le Goater <clg@redhat.com>
> Closes: https://lore.kernel.org/linux-mm/20260805055544.1568534-1-clg@redhat.com/
> Reported-by: Saravanan D <saravanand@crusoe.ai>
> Closes: https://lore.kernel.org/linux-mm/20260821070520.25759-1-saravanand@crusoe.ai/
> Fixes: 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

Cool!

Tested-by: Lance Yang <lance.yang@linux.dev>
