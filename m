Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153958;
	b=zKx4Srx+8/ekUD9Mw1BNFFUUqYtsHohivDVXFr/JWSd7eI4IuCocKDGBRaE+hho3YvHS
	 eT0NkuH+kyqs2hAN4adjCaP5Lo0QURf1jxvkFgEKEBVPr0IZsjaTyP5Ctfjc984BbaCRb
	 A99ndLpgS5rmh0knH1/CldmpgasCazTmGSVPSHSZurZIYbD89Va/xykaGzB3XtpYuwFWS
	 NtYGIDoya45YfD/N4tFgdBjoGXOhGpGlYk8agu7W8wRi8W1jT3EduOkv40kae9iJ0mkHp
	 ysXTYKsicB1D0uafsGIJdNCJYY+WolhpHf4/3+1hgoIYQIIAHXnLReIsPIHERUNXxZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153958;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=I4S1rdiwU6IQT/YUtWpzMqdCXUjRwC7w0Jq5xGo329U=;
	b=stxRevQfFgek9LmbjeVpEU/SYRjpU37wVlgc72t4a9yOORN/t1CSZj24imFbk6DPIf0a
	 sSrvtHhvI0bIhvndmlib9lAf9E3QjnOzfc0VgpQKmWL0NHT2uybTBWHJYacpsFrLW+Tl+
	 +w8HbUHYe4rbNgGqGcjV7rYJjqpy2JX1180JRYPh1xgQM8qLx0ElZhBl6Z03097ejt8DT
	 9sGZV+ulkaWMq5ql88VsBtW9pZKn+lyDPc8qUWENDDDHlPL7fiNqSqwjPjiO4UekXV+fL
	 6Rtk3tBY0rYPTrIcgXtZloj/Hl5Tl7njUiplsm8VTv6UINoxayFhZYyQwRaKAUfMH6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dIkTsSKq;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6E606A31A;
	Wed, 28 Oct 2026 02:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0A6E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dIkTsSKq
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793153954; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I4S1rdiwU6IQT/YUtWpzMqdCXUjRwC7w0Jq5xGo329U=;
	b=dIkTsSKqC2hQNPr6Nzy60MZkWiH9GauF+fH3V/xicogtTSDZS4P7Wv4yup2FhlvtChSUS1eghaVuPVMR+z+ZZP6isbd5fk8c2htD7faFJa2sql+80g1jDJAkKFk8uU3A2jjHseWSn8k1NWixbrdpGxBGXWpFo9wrMTb1I6MWfWw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0XDfMfYx_1793153949;
Received: from 30.74.144.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDfMfYx_1793153949 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 10:19:11 +0800
Message-ID: <93624f6f-7f7b-463f-954c-273b7a15ab5c@linux.alibaba.com>
Date: Wed, 28 Oct 2026 10:19:09 +0800
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
Subject: Re: [PATCH v2 14/14] mm/shmem: fix truncation of files containing
 only swapin-error markers
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
 <20261027-fixes_shmem-v2-14-86a00952acb9@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261027-fixes_shmem-v2-14-86a00952acb9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/26 9:03 PM, David Hildenbrand (Arm) wrote:
> It might not be very common, but we can end up with shmem files that are
> composed only of swapin-error/poison markers.
> 
> Such markers are not counted in info->alloced. Consequently,
> shmem_setattr() can skip shmem_truncate_range(), leaving the markers
> behind.
> 
> Truncating the file to zero and growing it again will result in reads
> failing with -EIO instead of returning zeroes.
> 
> Check whether the mapping contains entries, in addition to
> info->alloced, before skipping the truncation. Keep the info->alloced
> check so that shmem_recalc_inode(), called at the end of
> shmem_undo_range(), can fix up accounting after reclaim has emptied the
> mapping.
> 
> Fixes: 6cec2b95dadf ("mm/shmem: fix infinite loop when swap in shmem error at swapoff time")
> Cc: stable@vger.kernel.org
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
