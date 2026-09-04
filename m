Received: from mta0.migadu.com (out-98.mta0.migadu.com [91.218.175.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8BA370AC0
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788488838; cv=none; b=uG4PXwxfdl6oRbCHUNUk+yBYcggrcGfnSDIP70g3xQPbptZKoIwVWKaL9b1LRWZvxQL0euvB/h+q0gzFlJvRzZJqWqIQGW4hGQE++71J2XqqUJAi2IyzvXFVw8dtPy3NrO4xj1tIFG/zAu5X2+jIADeV6TejbSk6ANXSChYGTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788488838; c=relaxed/simple;
	bh=ReFqBqr6par/UGlKlh7klHni6a0vGR+ynsPeX9dR/mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZniIukjnWmGF5QLII+Kvsd3iC5IDNVtLqb6VyPoCbsra9t5snRmB91Ga+GfBi6rUDD4KF8mersR1QHvcBjTlwq8XjOq8ZbdO8vpR/uEiHOiNE7dGkNu7G6Tjb4eZJmAzw4m+bjYISmEzvhhXX1eFV7E37Uz1NpWi86B6XUCbOYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jU3zEbOz; arc=none smtp.client-ip=91.218.175.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jU3zEbOz"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ReFqBqr6par/UGlKlh7klHni6a0vGR+ynsPeX9dR/mo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788488834; v=1; x=1789093634;
 b=jU3zEbOzpsmCx6wQz6XLHMz86d8KSN9yymBct+A4V8QQuSpsbLjQEjcGoFo5rkoVQbQOXr7M
 0Brj48HDbfH8Tdfx6G+kJhBrBDpQbFnQ0lUmRnEWsmDfCoRh5DOlMUO3dxuvZnh9LvxG8NPOd6O
 5R/8yTJx7gDkkGhZg9m+unSE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b3ab1c27f19562f0;
	Fri, 04 Sep 2026 02:27:13 +0000
X-Mizu-Trace-ID: b3ab1c27f19562f0
X-Migadu-Flow: FLOW_OUT
Message-ID: <bf3f945f-207f-4416-b8c2-8d23ffcb8e62@linux.dev>
Date: Fri, 4 Sep 2026 10:27:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: charge folios to the target mm's memcg
To: Jinmeng Zhou <jinmengzhou22@gmail.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Jinmeng Zhou <zhoujinmeng@bytedance.com>,
 stable@vger.kernel.org, hongfu.li@linux.dev
References: <20260903075048.3316-1-zhoujinmeng@bytedance.com>
From: Hongfu Li <hongfu.li@linux.dev>
In-Reply-To: <20260903075048.3316-1-zhoujinmeng@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/3/26 3:50 PM, Jinmeng Zhou wrote:
> HugeTLB folios are currently charged to the memcg of the allocating
> task.  This gives the wrong result when a userfaultfd handler populates a
> HugeTLB VMA that belongs to another process.  The UFFDIO_COPY ioctl
> operates on the userfaultfd context's mm, but get_mem_cgroup_from_current()
> charges the folio to the handler's memcg instead.
>
> This can be reproduced by placing the faulting process and its userfaultfd
> handler in different memory cgroups.  Have the target process register a
> HugeTLB mapping with userfaultfd, trigger a missing fault, and let the
> handler resolve it with UFFDIO_COPY.  The hugepage usage is then reported
> in the handler's memory.current instead of the target's.
>
> The generic userfaultfd population path avoids this problem by charging
> folios to dst_vma->vm_mm.
>
> Pass the target mm through hugetlb_alloc_folio() and charge the folio by
> using get_mem_cgroup_from_mm().  This preserves the existing charge timing
> and error handling while making HugeTLB userfaultfd population consistent
> with the generic path.
>
> Fixes: 8cba9576df60 ("hugetlb: memcg: account hugetlb-backed memory in memory controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmeng Zhou <zhoujinmeng@bytedance.com>

Reviewed-by: Hongfu Li <lihongfu@kylinos.cn>

-- 
Best regards,
Hongfu

