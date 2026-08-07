Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ADD30B53A;
	Fri,  7 Aug 2026 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786067369; cv=none; b=iu6ceFTGkgb6pycsEiKKpp6j5OxoznxVwTL/Pex7n7A+2mRsMNTfSpI/vgcvNgYmoyYZk4/ludGpn+c5abRzI+/sIhV7koKt5qnrGHS0XkjazitZXjU92jbiQBi2Hi7qbZzJe8TnxieQzotOnhRIGf0birHiGUMn5B1qUd4+bpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786067369; c=relaxed/simple;
	bh=yDgYfMmrz+U12FzZfCQiQFXVCtWBJZrahgKWZmWdfDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5UVcVP6lBoGwYwYq6D/BM6nKE3kfgYA3LmfqHye9Tt5BlqOpxVfW7HYMGxmezu39errzzn4ID5ztNrVUwcNs8PGbTQPGlsFNe/bAcHYlaTtyLe7GuB3fYzFrJwgx9OtozKq+wuGR7SDppzPfhq2D5eWecIgIQoNEjpYw5Xj+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QvPe6nTa; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QvPe6nTa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786067364; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tKmLlK6uJ3edkxIIYSB/SjE+4uEsk26hCxc4VlHPNFE=;
	b=QvPe6nTaZK42kYANUFfbkzS6D4KjCGX1rX+EISzbXoDtMBzWS+/uuGtR4NqCa8GGS2VNP1+MEZcIEnGf2mdfdiNLiE7oaHnOTuh3HjLQjcVUUCVigDs5t/J5+gSUV+L7VS9hVWPOVCXxF3l6OhdwxHdTph00S/DkLJDUVtL1yGo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8V9VcH_1786067361;
Received: from 30.246.177.19(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X8V9VcH_1786067361 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Aug 2026 09:49:22 +0800
Message-ID: <f008965b-bb6f-49b4-9eed-96ef0be30c30@linux.alibaba.com>
Date: Fri, 7 Aug 2026 09:49:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: fix folio refcount leak and
 min_order_for_split() locking
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Li Youhong <liyouhong@kylinos.cn>,
 stable@vger.kernel.org
References: <20260806-try_to_split_thp_page-v1-1-a259e3387e38@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260806-try_to_split_thp_page-v1-1-a259e3387e38@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/6/26 7:14 PM, David Hildenbrand (Arm) wrote:
> hwpoison code can end up calling min_order_for_split() without holding
> the folio lock. There isn't really something that would prevent
> concurrent folio split. Consequently folio->mapping can get set to
> NULL after checking for "!folio->mapping", and if the compiler
> reloads folio->mapping, mapping_min_folio_order() would try to
> dereference NULL.
> 
> While very unlikely to happen in practice, let's just enforce that
> min_order_for_split() is called with the folio lock held. We can
> significantly cleanup the calling hwpoison code, and just get rid
> of try_to_split_thp_page() to hold the folio lock for a bit longer.
> 
> Just work on folios now, which further cleans up the code. We just
> have to be careful about doing the page_folio() after splitting, which
> we have to do already either way. Do not change the way we split for
> now, this needs more thought and should be done separately.
> 
> Cleaning this up we fix another issue: in soft_offline_in_use_page(), we
> would currently have leaked a folio reference.
> 
> In folio_split(), document and assert that we need the folio lock.
> Drop the questionable VM_BUG_ON_PAGE(!page_count(p), p) check entirely.
> 
> The folio->mapping problem was identified by Sashiko, and Li Youhong
> reported it by sending a proposal fix.
> 
> This likely does not really warrant CCing stable, but I expect little
> conflicts when doing the backport, so let's just CC stable because of
> the refcount leak.
> 
> Reported-by: Li Youhong <liyouhong@kylinos.cn>
> Closes: https://lore.kernel.org/r/20260804035828.2684059-1-dayou5941@163.com
> Fixes: 689b8986776c ("mm/memory-failure: improve large block size folio handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
