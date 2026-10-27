Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793082937;
	b=XeKgUhKZWSn66DeV9yBOhKOTUl7zi7UZf1rVZx8XgeOykXBcRp4Qyyd7/FGNkbs1mr65
	 RAlfCp+8KQZGXLemRxP2p4B0wvusOLiiTtNhGRGzj05jxB+I3+J5TbTEBiDdDmxXOp1SE
	 c1lGgwyPTm36UoKyKjKALJXz1bq5r253tRWuMGA+Nk1/55lzukcOl2eO/CsDzDM3RSVKk
	 ZQSaIqHI99PFiKrwA4EGrezVR+TI9XayKBETNGy7KPLzVelB+WEvplzxNln6wOsT4janC
	 o3YVdC257+eenIeIibAGTerlvuj9r6/dLgZwxeGtN/S3u1G2rkSaSjGJYeBewFLSROw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082937;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Nvhgt93DuTR0pQyjU1IKAJtbPg/dnqsaG4i1gtQPJHg=;
	b=IZ110zhh/SujS60wtF3VdZCTkmGavlTwZZxjQV8N7k3SSlurr6TPketB7d/Z7xB7wY1x
	 6UCnb8rCAdGJW7uBWftSwT9VHlKhipSqAhG7mF4WRloa//A9XG9qm1+b9rt/U46Jn+GIj
	 G9EL39Pp0FaMzlotGN0E5my68/6KpfcZh3IqHrOTEvIpQHxXU7Nz4QoKoFWOyqA+1X6y1
	 1zyiHKLwSzs02RhJ4DvuG7XqvNors6LvDXVnJxRTlg0K3Lk0viu9I+Y5sdJbx8ZMSS3RS
	 T9ybsZhM/PRMsJeOLAenjt/prbTC5g+2AXUTRV5gfFfFA8oqKnGyQOd7A45QrcRr6VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ahe1dIsM;
	arc=none smtp.remote-ip=115.124.30.131
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961D606A31E;
	Tue, 27 Oct 2026 06:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4961D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ahe1dIsM
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793082927; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Nvhgt93DuTR0pQyjU1IKAJtbPg/dnqsaG4i1gtQPJHg=;
	b=ahe1dIsMCvJQ9u8zyfnvyVV/rFHWjmXmnNKCeeDPPYPLBqWU7L6cMd7SKYSeJpdsa5MfblJMjZoKGjGdAT/8E8Hs+uFOcz+GJUYeqWpXLVFrZWgGq05qrT7pDMTmp66/JHWk8RFOYemnbPjE48AcGtjl0fvAqcCbaGOwjs3N8bM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0XDcvoox_1793082923;
Received: from 30.74.144.191(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDcvoox_1793082923 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 14:35:24 +0800
Message-ID: <d1b55973-306c-4a94-88a4-642581bdfdf3@linux.alibaba.com>
Date: Tue, 27 Oct 2026 14:35:22 +0800
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
Subject: Re: [PATCH 09/16] mm/shmem: preserve data in clean folios when
 splitting fails
To: Kiryl Shutsemau <kirill@shutemov.name>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
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
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-9-703206d5fa0c@kernel.org>
 <at-GrQNgF3V_tL3w@thinkstation>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <at-GrQNgF3V_tL3w@thinkstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/27/26 1:12 AM, Kiryl Shutsemau wrote:
> On Mon, Oct 26, 2026 at 10:40:42AM +0100, David Hildenbrand (Arm) wrote:
>> From: Chris Mason <mason@kernel.org>
>>
>> A shared writable mapping can have dirty PTEs while its shmem folio is
>> still clean. A read fault can install a writable PTE, and a later store
>> sets the PTE's dirty bit without marking the folio dirty.
>>
>> After shmem_undo_range() has handled the boundary folios, a concurrent
>> read fault into a hole below the new EOF can allocate a large folio.
>> For example, on a tmpfs mount with huge=always, the fault's offset must
>> be within the file, but the allocated folio can extend beyond i_size.
>> The final scan then finds this folio and calls
>> truncate_inode_partial_folio() without marking it dirty.
> 
> This is hard to follow. I asked LLM for a diagram. I think it would be
> helpful for the commit message:
> 
> CPU0: ftruncate(fd, 3M)                CPU1: MAP_SHARED, tmpfs huge=always
> ─────────────────────────────────────  ──────────────────────────────────
> i_size = 3M
> shmem_undo_range(3M, -1)
>    first pass: hole, nothing to do
>    boundary folio at 3M: hole, none
>                                         read fault at 2M+x (below EOF)
>                                           PMD folio [2M,4M), crosses EOF
>                                           writable PTE, folio clean
>                                         store to 2M+x
>                                           PTE dirty, folio still clean
>                                         vmsplice(2M+x)
>                                           extra folio reference
>    whole_folios: finds [2M,4M) folio
>    truncate_inode_partial_folio()
>      zero [3M,4M)
>      folio_split()
>        unmap_folio(): extra ref
>          → -EAGAIN, PTE dirty bit
>            never reaches the folio
>      folio clean
>        → truncate_inode_folio(whole)
>          [2M,3M) dropped
>                                         read 2M+x → refault → zeroes

Thanks. The diagram is really helpful.

>> Splitting normally collects the PTE dirty bits when unmapping the
>> folio. An extra reference, for example from vmsplice(), can make it
>> fail before that step. The fallback unmapping on split failure excludes
>> shmem, so the helper still sees a clean folio and drops it, losing data
>> outside the range.
>>
>> Mark large folios dirty before partial truncation in the final scan,
>> as the boundary handling already does. Exclude failed-fallocate
>> rollback, which must discard the folios it added.
>>
>> Fix generated by an LLM and sent by Chris Mason in private.
>>
>> Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chris Mason <mason@kernel.org>
>> [ david: simplify descriptions, adjust comments ]
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> The fix itself looks reasonable:
> 
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
