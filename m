Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097838;
	b=CMOgyimDHz86cFCFI3F8Dq5Y7l2ieqm6yYEoWdlW0LQOpA89IVZsYcJW5fbdbS2taQM4
	 EaPtHaxdia1x+NM/4We2+RSNyzyB9g7rkQfG5OTiGWXxvgAX+w5FyS1dTLtk5iA7J62oM
	 iFkMFJd1tYwKp6H18ktmb0B3vWMvW2q0xK3Ez7NrYjwzvVtn5vwVA1BTai6Dmm4SsritQ
	 4Pv4Wu4qmNkuqYEa6mDY9qE1qbcPc61on5/WcU36A2vDAu5RYbNUwWdFz71J5Y6U3rpGZ
	 v/z4B5VYH4/3RnJJkkGpiCL0H5I2Zt5IuSm/Fl/H48sA/dsgtV1pMO5R60YWy1fEz8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097838;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=RUGcoGJ3mRnt/Z7GBxa2RJO4TTMxywHgVzZ1aSTOpqE=;
	b=zonSAmFxQmJXBy5fNM5HbyO09kH8AqzR1OkSmLTuM0mOwIjRcjK6eNSOmr3kEAesBYiU
	 vTUNFEMJNESqySarj3WCltAL706WnGVrfoNPcdgD0oLA9eqHmahCLVDuDWICY8I35fSaT
	 qJgaJMYd/bFjRYAjn5jlbNSxzh0C974lQoTZPzjcUBM9kxWvtfikuTPZAaLSzyf87UKoC
	 KRWr9IQoWAMP3h9iLktp9UY4+f70XCfui5KsR3PGyHecxMyI/CabZZJ90Xpd2tszNmVkF
	 qJ0/4ZEIfx+RvgWoWDcFt+BVbF7Iu254sPpyRGj4PtaqJEhYupCvYb4R3rvXzutAvPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5uSrUhY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C94606A31F;
	Tue, 27 Oct 2026 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5uSrUhY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1C11F031E0;
	Tue, 27 Oct 2026 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097837;
	bh=RUGcoGJ3mRnt/Z7GBxa2RJO4TTMxywHgVzZ1aSTOpqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c5uSrUhYlCsGKMO8Vp8lcJXtrvW1Yd9wQv6SBFXz1V0+3wtAnO8fPiQP0N44b5Caw
	 JEfPDn2OgjccvQPVnX9M/V4VDQdTor9tUu92/PRDa9si9aYVzDcMuUTkZ63f/xl+MY
	 wZIC3SiiuburrWWPpelVf2/XqjSKfYfDyW5QyoJ6TzsM0fdTaa/1gMoPCO+kaODY6M
	 gteuPkd5rNdSnaN5sCYooq12TpUeft37PUUaXuIyhur4BrRBlfcjiRhAucIDo0OU2g
	 F4JJK0ITfJexW69BQBa2a8huNvhSK4zOzUugogaUwEtLU2KWCRkeE52k0Z4b/7BDQX
	 yLto4UgWV6vUQ==
Message-ID: <1748ab4b-c219-4eb2-9f0b-cc540c7986f4@kernel.org>
Date: Tue, 27 Oct 2026 11:14:09 +0100
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
Subject: Re: [PATCH 12/16] mm/shmem: fix truncate hang in large swap entry
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
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
 <20261026-fixes_shmem-v1-12-703206d5fa0c@kernel.org>
 <152d698f-d7bd-4e1a-9736-412d52e2370c@linux.alibaba.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <152d698f-d7bd-4e1a-9736-412d52e2370c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/26 09:59, Baolin Wang wrote:
> 
> 
> On 10/26/26 5:40 PM, David Hildenbrand (Arm) wrote:
>> Truncating a tmpfs file or memfd to a page-aligned size inside a large
>> swap entry can loop indefinitely in shmem_undo_range(). The task holds
>> the inode lock and cannot be killed.
>>
>> A large swap entry represents a whole swapped-out folio. For example,
>> truncate a file whose pages 0-7 share one swap entry to four pages:
>>
>>      [ 0  1  2  3 | 4  5  6  7 ]
>>           keep    |   discard
>>                   ^
>>              new EOF, start = 4
>>
>> i_size has already been updated when boundary handling asks
>> shmem_get_partial_folio() for page 4. Since it is swapped out, the helper
>> calls shmem_get_folio() with SGP_READ. That rejects page 4 with -EINVAL
>> because its starting offset equals i_size. Nothing is read back.
>>
>> The final scan cannot free the entry without losing pages 0-3. It skips
>> it, restarts from start = 4, and finds it again indefinitely. An unaligned
>> truncate avoids this particular failure because the requested page starts
>> below i_size. Folios already in the page-cache cannot trigger it as the
>> direct lookup will return them beyond EOF.
>>
>> Fix it by letting shmem_get_partial_folio() call shmem_swapin_folio()
>> directly for swap entries. This bypasses the read path's i_size check,
>> allowing the existing boundary handling to zero and split the folio. If
>> swap-in returns a smaller folio, it also splits the swap entry so the final
>> scan can free the entries beyond EOF. Retry the lookup if the entry
>> changes during swap-in.
> 
> Make sense to me.
> 
>> Handling swap-in allocation failures remains broken and is unchanged by
>> this commit. Even when shmem_swapin_folio() correctly returns -ENOMEM
>> instead of -EEXIST, shmem_get_partial_folio() returns NULL and
>> shmem_undo_range() skips boundary handling. If the large swap entry
>> remains intact, truncation can still loop in the final scan, while hole
>> punching can return without zeroing the boundary.
>>
>> This may read an entire large folio back from swap while holding
>> i_rwsem, only to discard part of it. Avoiding that I/O would require
>> splitting both the swap entry and any large folio still in the swap
>> cache. That, however, is much bigger work.
> 
> But I think this case is extremely rare, where every attempt to call
> shmem_split_large_entry() to split the large swap entry in the loop fails. At
> that point, the system is already in serious trouble, where even OOM kill cannot
> free up memory for the xarray allocation. Hard to believe this can actually
> happen in practice:).

So, it's fairly easy to reproduce with memcgs. But yeah, I assume this is a
corner case. (hopefully :D )

-- 
Cheers,

David
