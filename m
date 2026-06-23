Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA537BE7F;
	Tue, 23 Jun 2026 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179698; cv=none; b=B9oMeQgjKZ7Ggj/mVfk+Y716Gl9Jnr7Bq/63uFe6r+DmZ9cUwWolCMVlY6Et3TMwcL49ffItfKO1F/9hWLtHie8wNmctaIFFojy0wKdMJPsOaTT3i9astnBgCnM4GolyqL+qgWF7t82SJ3QszRv/WK/YKFPNnHgc4h6D5ozwz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179698; c=relaxed/simple;
	bh=UZJAF8LyNC3rD8qLCrP6ED6WjSBQXYTur3kxNZDjJDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sb3P3CkvBodNPx0+5sFE9P5PKB012SKgqFt56srI9B8bKGirt17+8SiQVTR4/fOg+H9nuxxxYvLvv5cpKuHaU3cA/cruLNnaNwBZetdyQA8Y7N+AItRGvjLZtwrJadoHQs64tM1gBYhn2N4SoSLd+Vye3nQjY1ttHHXEcm66Esk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=anfj0X0i; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="anfj0X0i"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782179686; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zMSrrHEC6r/uacCJ2Y96I9hM+DH0T+xP4vq/+KGOBGM=;
	b=anfj0X0io8w5D+DFCuW/QWyhJtPY5CmstzPOh+uWwwX1PDvJlzDC8dMi2WRHT1VCo+efRTH8ZDLuRt7fnv22IzfMHUQKxSOQD1228nHKpIF8a52i4EJUL5XZFlMJa4R+Vsp/wfvvolbvU32grWPXwiraDx7a50EDWAMbt7x8aIM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X5SEl-R_1782179684;
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X5SEl-R_1782179684 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 09:54:45 +0800
Message-ID: <84e0ac89-1f08-4f12-8d67-207e37bd8804@linux.alibaba.com>
Date: Tue, 23 Jun 2026 09:54:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix] mm/compaction: handle free_pages_prepare()
 properly in compaction_free()
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260622-handle_free_pages_prepare_in_compaction_free-v1-1-fcf3b14abcf7@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260622-handle_free_pages_prepare_in_compaction_free-v1-1-fcf3b14abcf7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/22/26 11:30 PM, Zi Yan wrote:
> free_pages_prepare() can fail but compaction_free() does not handle the
> failure case. Failed pages should not be added back to cc->freepages for
> future use, since they can be either PageHWPoison or free_page_is_bad()
> and might cause data corruption.
> 
> Fixes: 733aea0b3a7bb ("mm/compaction: add support for >0 order folio memory compaction.")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: stable@vger.kernel.org
> ---
> free_pages_prepare() can fail if a page is PageHWPoison or
> free_page_is_bad(). compaction_free() needs to handle these cases to
> prevent failed pages being reused in cc->freepages.
> ---

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
