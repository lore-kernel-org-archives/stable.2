Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182017;
	b=t3fgGiOg72RwQ5x75wmjzp/XMzjyHSgrbpS1Wln24ccbXu4ThkpVewyb6eBoDaAYExR5
	 8XY4XDWiu3NmQt3bEsrpWlG0qwqx5/QFrDklVovperdmI7iHCh5Pv0/GXoff32FesgCQP
	 6/DetOb5BE9TtlXX9L3a6QbLnCEVGmottwNrTMVzYfnJmtjSt3gB0+IkmQxfhE9zdNR/z
	 JcywGqarLJcTQI4wTuEjWqQLcmhW1ReJkVmSaePq1jZHJeVZYgFX5oyGilBNUbEAhQW77
	 v3LPL0vJUfdkX1KEkL6+kh0rL14WDNqocmcy6KCPjMaZS94lMxgJppCFYqOHrSkO/4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182017;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=aMKBLsxYHUnbIfVjoYx3Vq17ZceYoUGDZhH0VX3zlo4=;
	b=3N+CCJX3Babbo2LbkE7QmWOGdzWc8WbTPouiQ0XZMkG6pf/DFbGrvOvJWVXqrNyDTZB8
	 C18C8F2cnm2H2wvAz/4kG4YmbwBjtj4oR/JP0e/tegTg2BOLdo6A9B/UAicBJ/rrDzirb
	 Y7T4CbPz/t5PgWrEVyNPFh0cMzAGjsMfgjKB+NIemUs/xtSwmCLqNddvu8KSbolJ/MrDM
	 xT7WafEvO3xhY1HAKY1ecQcpLlSKcvTMcixWJXbXMz9JNrvY4ZFxwQpHcVcLup9dDEse5
	 B877cPz3HrbVND8TB5J+jUZ7VpMSNxHF+CVLNjcyOkwjPegRjUyOcfcvJ6y9eF9eWtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c/cVKUWw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3D606A31A;
	Wed, 28 Oct 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/cVKUWw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674FE1F01825;
	Wed, 28 Oct 2026 10:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182017;
	bh=aMKBLsxYHUnbIfVjoYx3Vq17ZceYoUGDZhH0VX3zlo4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c/cVKUWwvHQlXN8u4cB6G6LD5VOsTXkW1mYttiSFtfYQOC8o6gttQiR/PM29yMxre
	 retigVXoKJ0F5JJV4gU29i4c5I8lxwG24QQOku1iOAaPHnINtOyviaNmPdB3cihQ+r
	 wplgUCifRTKChtG7AS25gs2Cc31HDdxs+utyIqtN6UWTL+Su+Hg4DWIuUuz3tdvk37
	 S6dAoU+2qxiJBWwT3CkJPokw3/yMy5yTf2Bo4s9TqXC3MNAGSmNypMdYE/dcdJxfMW
	 rUzy71vmkFD+RmCUeyTTEUPa/4Y/3gNmOAilwn8aH0wiVczPw0scLV+4C3gMLftYC2
	 F7YXslqJKpYGg==
Message-ID: <11c6fd13-d2a2-4497-8417-d2176f1b5ecf@kernel.org>
Date: Wed, 28 Oct 2026 11:06:46 +0100
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
Subject: Re: [PATCH v3 01/15] mm/mempolicy: charge shared policy nodes
To: Balbir Singh <balbirs@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Lukas Czerner <lczerner@redhat.com>,
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
 stable@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
 <20261028-fixes_shmem-v3-1-4ce3baf2db4b@kernel.org> <auHINbCObZYzpNqC@parvat>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <auHINbCObZYzpNqC@parvat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 11:02, Balbir Singh wrote:
> On Wed, Oct 28, 2026 at 10:54:59AM +0100, David Hildenbrand (Arm) wrote:
>> From: Chris Mason <mason@kernel.org>
>>
>> Any local user can bypass memory.max with mbind() on a tmpfs file, and
>> allocate unbounded kernel memory.
>>
>> mbind() sets a NUMA memory policy for a range of a mapping. If the
>> mapping is of a shmem and friends, the kernel also stores the policy on
>> the inode, in a tree with one entry per range of the file.
>>
>> Each mbind() on a single page of a mapping can add one shared policy node
>> (struct sp_node) and one struct mempolicy to that tree. They outlive the
>> mapping and stay around until the inode is destroyed. The tree is not
>> bounded by the file size, so the file can be empty.
>>
>> Memory that user space can allocate must be charged to a memory cgroup. A
>> slab cache does that for all of its objects if it is created with
>> SLAB_ACCOUNT. numa_policy_init() creates the slab caches for both
>> structs without SLAB_ACCOUNT, so they are not charged to any cgroup.
>>
>> Reproduced with mbind() on single pages of an empty tmpfs file, from a
>> cgroup with memory.max=8M: the global OOM killer killed tasks owned by
>> root, and the machine panicked.
>>
>> Fix this by creating both caches with SLAB_ACCOUNT. This change implies
>> that mbind() can now fail when running into memcg limits. Further,
>> the policy_cache also serves task and VMA policies, so they are
>> similarly accounted now.
>>
>> Note that per-file limits are not really helpful, as the user could
>> simply use many files; having limits per user is tricky as well.
>>
>> Fix generated by an LLM and submitted by Chris Mason in private.
>>
>> Fixes: 5d097056c9a0 ("kmemcg: account certain kmem allocations to memcg")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chris Mason <mason@kernel.org>
>> Acked-by: Pedro Falcato <pfalcato@suse.de>
>> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>> [ david: smaller description tweaks ]
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/mempolicy.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 0884c629670d..4da1cb8777f6 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -3372,11 +3372,11 @@ void __init numa_policy_init(void)
>>  
>>  	policy_cache = kmem_cache_create("numa_policy",
>>  					 sizeof(struct mempolicy),
>> -					 0, SLAB_PANIC, NULL);
>> +					 0, SLAB_PANIC | SLAB_ACCOUNT, NULL);
>>  
>>  	sn_cache = kmem_cache_create("shared_policy_node",
>>  				     sizeof(struct sp_node),
>> -				     0, SLAB_PANIC, NULL);
>> +				     0, SLAB_PANIC | SLAB_ACCOUNT, NULL);
>>  
>>  	for_each_node(nid) {
>>  		preferred_node_policy[nid] = (struct mempolicy) {
>>
> 
> You have many of them already, but anyway
> 
> Reviewed-by: Balbir Singh <balbirs@nvidia.com>

I love it, thanks to all of you :)

-- 
Cheers,

David
