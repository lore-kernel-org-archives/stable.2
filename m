Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085989;
	b=xY6kUfbktitLRTMQHHjC92rk43EXiN5V7YM18S6s4Wpvb0aWRPduN4LHOc9SrqiIlL8L
	 itjJs9xyAoEL82zt2AOEPnfw2LnbBxONd1UDH3/fhbksOD3bg9Hg9Gfu0EnYoWDjj/tCV
	 jwxMPlNqUmgmeaJHWJAs5iVE8Y2uCCYQhVwbTpYKV3EL5IT2TxVDQF01sPa5IS5b3HTvg
	 nqTlJuDMNN7eegShqHphnbcR66fGKDVjkUeeZ/5gQXp8V0D6OWxPitLaOYTtPi8+wRz26
	 Ak8XWE+GZZ68GFoj8hEAysQCHnLH3BG0kD5/4EG0tM70eiY8GJ1R8V1spIwn6pvnDJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085989;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Voi00V0tdXCD/BPkPI2PBi2izLO04MVewLq5+Eoz9wA=;
	b=WhoQsD4DvBiXX2X3LqVBs90N+zSEV9wwtbGvU60KABfMsQyj6WYZxKyaT+3hzVs+gWiv
	 UXBni8ZsvH10aE+ptZGbavYxl9+8o+hi8L+u7a5oynnmJBW4F/BqCK/A21eyVtdLQIdGp
	 Wm/+lY/YkLFaZhc5RFvMXA9WeAHj1WQYKBCjW3NeHFXEwpbLazehOc02FRiPAe9O2ETmM
	 M3bQVv5mUmFxdOqDsIBq92pD0viJjSBR5pOWQICFk0c8Nbz4HDMXIIPcHF/IrVDlYAius
	 nqrkx3DK+MNFu8oxpA1w4/q9+uLtCOhG2Si9LqxU3QLPC0TkzjFEswpoD4eLuMnf11g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vmc9eYFo;
	arc=none smtp.remote-ip=115.124.30.132
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BF606A31A;
	Tue, 27 Oct 2026 07:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 433BF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vmc9eYFo
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793085975; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Voi00V0tdXCD/BPkPI2PBi2izLO04MVewLq5+Eoz9wA=;
	b=vmc9eYFo0K0Pvwh6FysRj3i6dhQ3FQuyiKDvSZD3LZzcQpSqQiKKs6Kclhu7acLPWqxZ8UyezwC8KhGTXtXOZmlhU6/wmuvE0wGTw8kgTrDgTPpOEnkMBWBAzfL7VVEf41oAywl5tZv6JTa+sy5P0Voz/PEJMuQxZw4qYTCN+dA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0XDcwS4h_1793085971;
Received: from 30.74.144.191(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDcwS4h_1793085971 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 15:26:12 +0800
Message-ID: <e1aa3fb6-a557-420d-88b5-9864ddfcec2f@linux.alibaba.com>
Date: Tue, 27 Oct 2026 15:26:10 +0800
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
Subject: Re: [PATCH 10/16] mm/shmem: discard whole new large folios on
 fallocate rollback
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
 <20261026-fixes_shmem-v1-10-703206d5fa0c@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261026-fixes_shmem-v1-10-703206d5fa0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/26 5:40 PM, David Hildenbrand (Arm) wrote:
> When undoing a failed fallocate(), shmem_undo_range() must discard each
> newly allocated folio. Its second scan instead passes large
> folios to truncate_inode_partial_folio(), which does not necessarily
> discard the entire large folio, but instead tries splitting it to
> discard only the requested range.
> 
> For example, with huge=always, a failed allocation starting at offset
> 4 KiB can leave page 0 allocated in an otherwise empty file.
> 
> Discard the whole folio when unfalloc is set. Note that we enter this
> path only for folios that are not uptodate, and can consequently be
> dropped without losing any data.
> 
> Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Good catch. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
