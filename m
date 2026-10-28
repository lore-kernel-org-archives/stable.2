Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153235;
	b=I/eRfxOejXYBdU3MO9iS2PkKh3N9yEGD3ThtUOPS3GwJj1fr4BdaxgInyHTD99mfui09
	 zR34lSGTcw1Mggp3QRFfGecNoMhNzE43pYhTJZOwDX0kPvDhp1Or2ahH4BAQsqlRM4Zno
	 /N4ACAC9pWsViSsCmTIsottkbKNyxhCQ0oSrBhntQZsn8868NARlPMVu7WJDv96qxUzoS
	 VS3QRJmyIA0R1KNlut91w+F3ujWEUBw2eC5pLYLXtOtaTqccO5yXgQHbuvy/MA8wMMm0k
	 7wiF37I9+kOPqY2Xf5icZRufYTRcfzBfugH74TOCBP+XcD8iz8x7bdNvEKzsKMPD6tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153235;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Y20JnGk++kh3G1ZhtF9SMWZyhV7r1s5SsFeCJ6a8Zww=;
	b=p8vcIcp54LaayQC4UPCac6J+JntHLnJlpNjaFVnScKQfKcsE/xVG318PeyZxBW9cJlT/
	 pnrhEz9h3gqA+s+ev3zXWh7KOhtkRq3YWqTA4ieQNCf++J/SeA7pvkI31tntsaTPKa3x+
	 btgppxyrP+K99Hw5e/jGhscFYKL4emFonbbk+dyMgO9p7CH5zvI5SWn+A7e5cHx0vQb+N
	 7WSZB62tG0CGHee0+ZTBuWjEO2dIKLlE6UH/DgdpSHMVPqhwB2yuAcyaKC8kNcAgS2s2R
	 rQeYze2yeoVMVPWuLCldKcq7eabejsNvb6HyQnFZjk+xP7YvJEKSl2Hpp3zWDL7MCtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JW9yIf4x;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BED606A31A;
	Wed, 28 Oct 2026 02:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02BED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JW9yIf4x
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793153231; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Y20JnGk++kh3G1ZhtF9SMWZyhV7r1s5SsFeCJ6a8Zww=;
	b=JW9yIf4xaM9EMGaaiA6sHEmQPrIAY8D+z9c6r8Lw6m+wkldBXUBvM9641J5ACXQGV359UI0ozSzAZZVWIpWXj5ivp3mEh7T0ZIYyV/1c/e1Rspg8C+lykkZRxsHsxPYRV4uYH7jJ0/TD36pOPZS4c4YlbqjvYqVYLK3ZFHdmQmI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0XDfCXNz_1793153227;
Received: from 30.74.144.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDfCXNz_1793153227 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 10:07:08 +0800
Message-ID: <cd23161d-939d-4da7-9da1-1a555c485924@linux.alibaba.com>
Date: Wed, 28 Oct 2026 10:07:07 +0800
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
Subject: Re: [PATCH v2 13/14] mm/shmem: fix accounting of swapin-error markers
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
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
 <20261027-fixes_shmem-v2-13-86a00952acb9@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261027-fixes_shmem-v2-13-86a00952acb9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/26 9:03 PM, David Hildenbrand (Arm) wrote:
> A failed swap read replaces the swap entry with a swapin-error marker in
> the page-cache and subtracts its pages from "alloced" and "swapped";
> however, it leaves their block charge in place.
> 
> Removing the marker during truncate then subtracts from "swapped" again.
> This can underflow the counters or make swapped reach zero while other
> pages remain swapped out, causing swapoff to loop without finding them.
> 
> When installing the marker, subtract only from "swapped" and let
> shmem_recalc_inode() reduce "alloced" and release the block charge.
> 
> Make shmem_free_swap() report successful removal separately from the
> number of swap pages freed, so removing a swapin-error marker does not
> subtract from "swapped" again.
> 
> It's a bit confusing, but replacing a swapped out page by a swapin-error
> marker in shmem_set_folio_swapin_error() behaves as follows:
> 
> Initially:
> 	alloced=1, swapped=1, nrpages=0
> Calling shmem_recalc_inode(inode, 0, -1)
> 	-> swapped = 0
> 	-> freed =  1 - 0 - 0 = 1
> 	-> alloced -= freed
> 	-> alloced=0, swapped=0, block charge released
> 
> Fixes: 6cec2b95dadf ("mm/shmem: fix infinite loop when swap in shmem error at swapoff time")
> Cc: stable@vger.kernel.org
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Good catch. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
