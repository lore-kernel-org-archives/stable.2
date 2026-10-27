Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069837;
	b=1KqXjPQrIKDm1jisb39+ewzqBip4xK7nd3q6ivhQfoEJZohoqN7MOWqAG/Apx5baB2yz
	 tWSSxCMyV7JvaqEfAkPKlKuatVOIYq1y8L9m6wnz6omqUdkRksBfWaoBmFz2Z995KKEKE
	 QkGBOhIOwvjvYoDVG3rW6RON1dbVnRMdaJNxPPGntFm7PhNPulZsZlTd85t3NNv+qF5zW
	 Ck1C7thtcgsmCSH3RjGpB6SXDz2WKheTzEuJ0MMW/w5IpQjpDP/v004wmok8HIcwdumLE
	 qYpKfL120/wTPaocjCBAJ7FXq2dKnoD5tIPpDEUPRxzr3mRJiZ/ARIxuiMfxlTrxk1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069837;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jPpFQvIKlQfp6jAqMmu68M10eR0+vq5Ptuld/Xq2ZNY=;
	b=i/cQOVDhzyEyt4VipEIvAKhHr7fKtGigOOhFZxD+zl0N352Uz174VUnZ7IZe97lUpyfv
	 T+6v8jJLq61tG0XKmAGwmVPSJ14phQLzMqPZPd3KZLiazNX795tBuwiZLwZB2B9SZtJoA
	 Eeq5GMNPKZ48QV0KdH7oAC8wH/BpRvUyhs21zR4qGoqILzO/9peLi1juYAqulGFYXobwA
	 LodSRyRSAGZV7vZ8ZvnG585JU7gYKaGcZNEjPRBa58gT++P2V06+J6MUHFtrN4EtPF805
	 dnEBsw4M0IOqO18LUordF1bwc+pyY9s8ohr4iJzhZwRforyGzWTfZ0Q8JBqLDLhUK1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o5MXizE+;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D58606A31D;
	Tue, 27 Oct 2026 02:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D58606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o5MXizE+
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793069826; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jPpFQvIKlQfp6jAqMmu68M10eR0+vq5Ptuld/Xq2ZNY=;
	b=o5MXizE+cxTgnpl/CwPQ1XtHT0Jstn/zIjlxg60WwyCC5TQ8qEN64RqbOG0WJnR31lJ27LKC2jA3wCe09bqViNkn8h22m7Xxfg8YcgjRZNf4Zzv1CtBTgOC52ZJckvmhY2pswyLU36zGXef0RaucMfjRqoutAol2Eiha4Ffm4LU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0XDcPjNv_1793069821;
Received: from 30.74.144.191(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDcPjNv_1793069821 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 10:57:03 +0800
Message-ID: <611de2c8-ed05-4830-a43b-8c2c6bd0ae6e@linux.alibaba.com>
Date: Tue, 27 Oct 2026 10:57:00 +0800
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
Subject: Re: [PATCH 01/16] mm/mempolicy: charge shared policy nodes
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-1-703206d5fa0c@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261026-fixes_shmem-v1-1-703206d5fa0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/26 5:40 PM, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> Any local user can bypass memory.max with mbind() on a tmpfs file, and
> allocate unbounded kernel memory.
> 
> mbind() sets a NUMA memory policy for a range of a mapping. If the
> mapping is of a shmem and friends, the kernel also stores the policy on
> the inode, in a tree with one entry per range of the file.
> 
> Each mbind() on a single page of a mapping can add one shared policy node
> (struct sp_node) and one struct mempolicy to that tree. They outlive the
> mapping and stay around until the inode is destroyed. The tree is not
> bounded by the file size, so the file can be empty.
> 
> Memory that user space can allocate must be charged to a memory cgroup. A
> slab cache does that for all of its objects if it is created with
> SLAB_ACCOUNT. numa_policy_init() creates the slab caches for both
> structs without SLAB_ACCOUNT, so they are not charged to any cgroup.
> 
> Reproduced with mbind() on single pages of an empty tmpfs file, from a
> cgroup with memory.max=8M: the global OOM killer killed tasks owned by
> root, and the machine panicked.
> 
> Fix this by creating both caches with SLAB_ACCOUNT. This change implies
> that mbind() can now fail when running into memcg limits. Further,
> the policy_cache also serves task and VMA policies, so they are
> similarly accounted now.
> 
> Note that per-file limits are not really helpful, as the user could
> simply use many files; having limits per user is tricky as well.
> 
> Fix generated by an LLM and submitted by Chris Mason in private.
> 
> Fixes: 5d097056c9a0 ("kmemcg: account certain kmem allocations to memcg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: smaller description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Make sense to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
