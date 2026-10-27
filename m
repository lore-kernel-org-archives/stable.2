Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092758;
	b=QjJBxFALFLIufN3XyAMNp5sVsv4/OlL5aCP6ERThDFKRvuNW/4eiaeNoDAAx3tLy1yK8
	 Ofs+UfvVVfBxPHa/iFoo9jNLaObb7I1VtCe2pdkejvmx0jlrh4J+dNcSXEQ2N/sG99LDa
	 bVFnnAiVhD5RG4uDyxRe0GaPzhKlmcvOutr3vz8aQ1Hlb6DZNy6NcZhmUeL8TA3mbnVLZ
	 /0OAuh9WYT5PP0wx8ItmTbxqez2WvYrPptg4GTII3rYUGYzzsvnRxLcBWUXphz1kq6UXI
	 W5p9kp4EAo6LoXH/1IdhlMR6gqjnfRYTKgzT5rB0AMJHyCdwHhoucc++m7S3np1nTPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092758;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wjhWYuYz/Y0YoGs1RYFiIWHiS+9eIIpbtVl1mUgbHKU=;
	b=d27Biuj2Q32y6LSberZaN5HcZdwug7BgNGV29qhkOyAa+8Usqqc1U38J2ekd9K42VOUB
	 Yfv4NChG1NEP/Z2EnVc9pN8rmmUhGQWzydRk1voxt/rdjqGG1CJosId+fjDt6+xU30gqT
	 YAGWB9MVUo+4GVuw8XTbOW7iq1P22lxZKKvC+jw416D7R2254z9NVxjN1jvrTtTMtGSoa
	 tRWtq+/1bb9uQQmVsHUPPJ3NRWhFtTZZyUK8mFJQkePXSk4FoMtHR9XveOVd7+OEoajPZ
	 NMIpmU89exDrK1Ff/6qpn8C2q/yo4EUKHB7WL20oBWTvRviWaMwCzHqqAweY5S1HPCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f2Skfi2+;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FE606A324;
	Tue, 27 Oct 2026 09:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C61FE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f2Skfi2+
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793092744; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wjhWYuYz/Y0YoGs1RYFiIWHiS+9eIIpbtVl1mUgbHKU=;
	b=f2Skfi2+sWMb974fZK0I4Z8zHA1m6i9Hff5DwwMJTnqOQXxfR1N7JFpeiL5wKNxSDpWoRJ/logac4MKSWoHeS3/2uQ803/4ZnRtoqy1jPQRrwG7SDl/DHVad8FTZ4D1Nl3x2Fct2solX0IqP0tpuwOwvBqhkmr6k9mT5elYQM8s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0XDdLjEM_1793092738;
Received: from 30.74.144.191(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDdLjEM_1793092738 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 17:19:00 +0800
Message-ID: <6a2d3eba-d2e0-44ed-939e-001a5709565b@linux.alibaba.com>
Date: Tue, 27 Oct 2026 17:18:58 +0800
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
Subject: Re: [PATCH 13/16] mm/shmem: preserve allocation errors when swapping
 in large entries
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Gregory Price
 <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Lukas Czerner <lczerner@redhat.com>,
 Carlos Maiolino <cmaiolino@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Stevens <stevensd@chromium.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-13-703206d5fa0c@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261026-fixes_shmem-v1-13-703206d5fa0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/26 5:40 PM, David Hildenbrand (Arm) wrote:
> shmem_swapin_folio() adjusts swap to the requested slot within a large
> swap entry before allocating a folio. If allocation or charging fails,
> the error path compares this adjusted value with the original entry
> still stored in the XArray in shmem_confirm_swap().
> 
> Unless the index is at the start of the entry, this turns -ENOMEM into
> -EEXIST even though nothing changed.
> 
> The caller retries -EEXIST, so persistent allocation failures can leave
> the task spinning instead of returning the error.
> 
> Restore swap to index_entry on allocation failure so the existing error
> path checks the original entry. This preserves the allocation error if
> the entry is unchanged and still retries if it changed concurrently.
> 
> Original fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 91ab656ece13 ("mm/shmem, swap: tidy up swap entry splitting")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
