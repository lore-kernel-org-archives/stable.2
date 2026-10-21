Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792563369;
	b=FZq43BqI/HmOW8ZqgXGk4KFljVxksZrxw53BoTRvVjphqmew40taPtvyN7xd9wZRjhGY
	 vzDOjWK2rY1Hxq/iPl/ztR/pc2yT09UAcpNMLYWHrQ40dT9bS0VHi1uMN+cwC8NbGCe35
	 LstBfMakno2tZkuYXgHniQQGsQVZ3mNIt5qthmH3+OWCkgqEX78euReNEGpEKF1LeefXU
	 GLpQmtwwkY2vu8+VJ/xniqbr9i62jtA4d9gRqpCChNpLmeJBJFLx+pos5jbk/+9FydEiu
	 RnyQ/U3QhkwKw55FomuIvA6ausqcReueIlbH1avVWrlEMH9AcRh/kbnF1f+uMz1oXcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563369;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=NwxXxk3IG/0jN67Jp1dQn6a0zeAIazOAnBJBfQ5pj78=;
	b=VRXsMrz2OyC8K7fB0T/R/bUBvfSZJZvtxnbR0qXf0Vr83CrEzLdvdnKC6FzVt4RTiR9q
	 pBzMMcneGOA+o14loEK/uz7K1BSBb7WITdSvF0Jx+RATeB5VGc1HUyO/LkcjFwTLZJKi2
	 Iug+loFzZpOjDwaAHHCpYZuCs85qwu15GBCT75gfYO0+iey6WutCeiF3odujeBoQtO70k
	 1ndmIh7FiFdC7G52Bg6iAbeOs5J7NKBvn6MEQbZCtJIzVE+IkHYamDccTXZLvys4+Gue9
	 6Ck2ytmFTHBzz4p05jtWht1LwoGUmyNSilTj9tf8fhijxJ7C2QnT3szL8xjlB3P+6Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U0pFtW0S;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAE606A326;
	Wed, 21 Oct 2026 06:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0BAE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U0pFtW0S
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792563358; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NwxXxk3IG/0jN67Jp1dQn6a0zeAIazOAnBJBfQ5pj78=;
	b=U0pFtW0Sui7thy/yL1k4jld9obWiQV8yq9WmIOr0c7wpIYrKNDSRLNFBO+lekbvaaJWu7xq/gfpwb/e63M4AHod7OecW5+8SeVcfnJkFqAlj4iwUXEdTs/q2UH8g7WyxpjFOrVa8rq/AAOzvaFUdSLd40elDYUWJxr/mWCcuHQU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XDFS7Kq_1792563356;
Received: from 30.74.144.135(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDFS7Kq_1792563356 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 Oct 2026 14:15:57 +0800
Message-ID: <214aa9dd-33c2-4877-8a2d-18bf677d1426@linux.alibaba.com>
Date: Wed, 21 Oct 2026 14:15:55 +0800
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
Subject: Re: [PATCH v2 1/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref
 with memcg disabled on cmdline
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
 akpm@linux-foundation.org, hannes@cmpxchg.org
Cc: david@kernel.org, mhocko@kernel.org, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, ljs@kernel.org, kasong@tencent.com,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, baoquan.he@linux.dev, yuzhao@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, apais@microsoft.com,
 rlmenge@gmail.com, stable@vger.kernel.org,
 Hardik Garg <hargar@linux.microsoft.com>
References: <20261017050928.128582-1-sidchintamaneni@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261017050928.128582-1-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/17/26 1:09 PM, Siddharth Chintamaneni wrote:
> When CONFIG_MEMCG=y, lruvec_pgdat() returns lruvec->pgdat, which for the
> per-node pgdat->__lruvec is left NULL by lruvec_init() and only filled in
> lazily by mem_cgroup_lruvec(). Normally that happens early, e.g. on the
> first folio_add_lru().
> 
> With cgroup_disable=memory, lru_gen_shrink_node() passes &pgdat->__lruvec
> directly to shrink_one(). If direct reclaim runs before anything has
> called mem_cgroup_lruvec() for the node, which can happen during early
> boot under memory pressure (e.g. a kdump kernel), get_swappiness() ends
> up dereferencing a NULL pgdat:
> 
>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000005040
>    pc : get_swappiness+0x68/0xb0
>    lr : try_to_shrink_lruvec+0x54/0x2c0
>    Call trace:
>     get_swappiness+0x68/0xb0 (P)
>     try_to_shrink_lruvec+0x54/0x2c0
>     shrink_one+0x8c/0x240
>     shrink_node+0xc6c/0xe08
>     do_try_to_free_pages+0xdc/0x570
>     try_to_free_pages+0x124/0x278
>     __alloc_frozen_pages_noprof+0x6e8/0xf78
>     alloc_pages_mpol+0xc4/0x1c0
>     alloc_frozen_pages_noprof+0x54/0xe8
>     alloc_pages_noprof+0x1c/0x40
>     atomic_pool_expand+0x98/0x300
>     __dma_atomic_pool_init+0x58/0xd8
>     dma_atomic_pool_init+0x154/0x170
>     do_one_initcall+0x64/0x350
>     kernel_init_freeable+0x214/0x430
>     kernel_init+0x2c/0x208
>     ret_from_fork+0x10/0x20
> 
> The classic LRU path and MGLRU before per-node lru_gen_folio lists
> obtained the lruvec through mem_cgroup_lruvec(), which sets
> lruvec->pgdat.
> 
> The above was hit on an arm64 kdump kernel (6.18-based) booted with
> cgroup_disable=memory nr_cpus=4. It also reproduces on mainline on an
> arm64 VM with CONFIG_ARM64_64K_PAGES=y, CONFIG_MEMCG=y,
> CONFIG_LRU_GEN_ENABLED=y and:
> 
>    mem=160M nr_cpus=4 coherent_pool=512M cgroup_disable=memory
> 
> These options only serve to force direct reclaim early in boot; with
> 160M the boot eventually ends in OOM regardless. On mainline the first
> LRU reclaim happens while unpacking the initramfs, and faults the same
> way:
> 
>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000005040
>    pc : get_swappiness+0xd4/0x150
>    Call trace:
>     get_swappiness+0xd4/0x150 (P)
>     try_to_shrink_lruvec+0x44/0x2b8
>     shrink_one+0x80/0x1a0
>     shrink_node+0xd98/0xea8
>     do_try_to_free_pages+0xf4/0x4b0
>     try_to_free_pages+0x110/0x360
>     __alloc_frozen_pages_noprof+0x8b0/0x1718
>     ...
>     __filemap_get_folio_mpol+0x2ac/0x548
>     simple_write_begin+0x44/0xf8
>     page_symlink+0x178/0x198
>     ...
>     do_populate_rootfs+0x13c/0x200
> 
> Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> Cc: stable@vger.kernel.org # 6.3+
> Assisted-by: LLM
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---

Good catch. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
