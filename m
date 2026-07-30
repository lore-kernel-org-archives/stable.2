Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E5346ADB
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393101; cv=none; b=UUYWreviny6wOmZzQ5jU40PJVQ3DFY7ZuXiTUd9MnOWejM5Wve3tWbxzDTnOFhweWtDaxxnyoA9bb0cNZQdSvJfnM1zXmgytXS7hxE1zE3oekzNTi6F8fO3QPhbi64W1Xwji87EvG+Rc2fAIAT0a0tfdG7oxSaKZispAfWZZXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393101; c=relaxed/simple;
	bh=5t+GoX/aPLaTLKFvhZLJ22G0+ryWXHjxjIuHVP6Qtfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E34wNeNk5m3mbY5JN1j8c0OsGxbk6BRlM+mEdYu1I7l83H8wOwaFgBCL+1BdZGa4ejL1kpw6gxiymcKZTxbnuA026ouXpTx9rx0WuGKY0GyZDVpq0mBRxwiTjpARwrb0vNVhKli8Keht/yXVtkTYQgg2z23Ij7WJHiYOVDGObkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1NAAIfu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1NAAIfu"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2dcede83so2403569b3a.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 23:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785393099; x=1785997899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hOvMF22l5yq9rb3H7AnJyb7Yc8S/1iRInoiHq1DCJyQ=;
        b=r1NAAIfuu6kF5KLbYliv4PFcQcFXqe0sMQEIDXnFjTG2X4Za09sGn+nnxyk6nadmKy
         MMdBjNpCgNUXgD/iyzizOHtaswcTG3vO/uZ+42kQas6VAyWvlG+5nQglvX1+3oEdtnpy
         R2TW5f51P1W9jHw5OOGincLhSWQ43jxDDOJRG58ag0Q+PrKI7FPQxPcuWMMYhWKnfAsx
         EmSdFrhE8pzSPgnttzmL1TZAkoyAt0QJX9oSicfI4sFQwSVH1cjWZ/mLrfvLHkYJLzK3
         BCzB+c9BGNpOYdBsOm3LlpW4iMxR8sPqUnnQol4JNVTuxHKCTxCGQbWJ1a/UJA6QPZOG
         bf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393099; x=1785997899;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hOvMF22l5yq9rb3H7AnJyb7Yc8S/1iRInoiHq1DCJyQ=;
        b=WJMYBUo0M8DZzlOjYLuzmQylRkBDDwAJkVteZ/B+3JSI9wVBxQAJPOtNFKtvcmeixs
         43kR5pWW5spmd1xbBEddEtp2+J+SxFIGdQKrTf2n7pw1zX909qi0gBuVwigu8dxixN8W
         2ACYvpPI6Gch+v7wViGBumCFgHHHOOMRvweJuZLLRy59vpOtJRhdyEcg1WjKv9AFdn7w
         KhsuNGk1E/Nw2CZXa0uPEHxIm/MGOLmMIONsmkxs630B9DyrjLjRGRmDUiclMjm5yoe4
         3oj86CLw7aosRkcJ4xgNak5qIARDGysgmIB7V8bqjCrG7XL/YTNoBIG6bkCsXG1CfN9j
         OLlQ==
X-Forwarded-Encrypted: i=1; AHgh+RrU7jbZVGIClVCcDUe1lDUHZ/vV7KQrD8OPZl0TMPZEuZiyIy6/KZ5Y4V+SYV47tc8PYCITb+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoBr9GlMpZvSTQs9dTenAWzwHLNzGDzKcHLR9z58S544oDnDWX
	8m4kWrzptfP1s8X8eK9AsviLlgEF0qxfaZh1pVoJCWkTJ4cMI5m+PB15TRenXw==
X-Gm-Gg: AR+sD12cGK+Y1Ae0IKzsgbNutcnbINMThL6lOdQyI4ZBKM4yZQA6VzmzGuW5S0JjdFK
	iZwvEM4QiwMmpmBxBoVuxrc0oNUAWfpaCUm84L1zcBWcNQBKxpfrpePUAnH56iyw1F4kFV/hzJY
	lzbIzI08YzPyN5Znq9KcminMD1WPTfU75lTUjkFO1GPnsfxbd5xx3zeAIK46HQpgs4naGutW2Qh
	VfQUbe2J0Lhs3tfRZ4RnmSm3KBxgsZGsMm/09ePLlV7vzdKhTIu3b+uo2AwmxaA9cjmpAYwDHNz
	Xj6dUR6WKhKWqgjoy2lFhwE3BxLcsFFFbi5sH755kACGTlBJbVdi7QUMkAlpxFIMAB3Ce8ly8Db
	3jJBgsmH3QxaDVnmfN6R5NEw1B1KW8867AdmUOJct6id1fXAwMhdbq/jigAr5NM/Blr81N2MnQ3
	iKIFwSwRICgbgyDvavNxGRJ2mt+WR8wreAsTSCtt/ZeuvdzN6LJRgkUYeqi87p0IksJ/3TRj/jG
	c4X5CmX7cjtgkqdmh8U
X-Received: by 2002:a05:6a00:2e95:b0:845:d284:9e14 with SMTP id d2e1a72fcca58-84ebc468c9cmr1404273b3a.59.1785393099312;
        Wed, 29 Jul 2026 23:31:39 -0700 (PDT)
Received: from [10.125.192.117] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0052e04sm2418453b3a.22.2026.07.29.23.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 23:31:38 -0700 (PDT)
Message-ID: <c4c95102-72e2-a44f-f16e-4134ba6bb060@gmail.com>
Date: Thu, 30 Jul 2026 14:31:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/2] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
To: Yosry Ahmed <yosry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@kernel.org, mkoutny@suse.com, nphamcs@gmail.com,
 chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
References: <20260729084206.77793-1-jiahao.kernel@gmail.com>
 <20260729084206.77793-2-jiahao.kernel@gmail.com>
 <20260729155858.c7aabff48166a9bca4d68ac3@linux-foundation.org>
 <CAO9r8zNhBCghP8T_98z2p==Cfs_=kamcRN_3ROxaj3R8PN2Qvw@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAO9r8zNhBCghP8T_98z2p==Cfs_=kamcRN_3ROxaj3R8PN2Qvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/7/30 08:30, Yosry Ahmed wrote:
> On Wed, Jul 29, 2026 at 3:58 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Wed, 29 Jul 2026 16:42:05 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:
>>
>>> Zswap writeback when the global pool limit is hit fails when memory
>>> cgroup is disabled. The pool remains full until it is organically
>>> drained by swapins or memory freeing, leading to zswap store failures
>>> and pages bypassing getting written directly to the backing swap device,
>>> causing LRU inversion (hotter pages with higher fault latency).
>>>
>>> This happens because mem_cgroup_iter() always returns NULL when
>>> memory cgroups are disabled. As a result, the global shrinker
>>> shrink_worker() repeatedly takes empty walks. After MAX_RECLAIM_RETRIES
>>> failed attempts, the worker gives up without writing back any pages.
>>>
>>> Therefore, when memory cgroup is disabled, fall through with the !memcg
>>> branch and shrink the root memcg directly.
>>>
>>> With memcg disabled, shrink_memcg() only returns -ENOENT when the root
>>> LRU is empty, which means the total pages are already below thr. In the
>>> absence of heavy concurrent zswap stores, the loop then safely bails out
>>> via the zswap_total_pages() <= thr check; otherwise, it will resume
>>> shrinking the memcg after processing the reschedule check. For any other
>>> return value from shrink_memcg(), the loop is guaranteed to terminate,
>>> either after MAX_RECLAIM_RETRIES failures or once the threshold is met.
>>>
>>> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
>>> Cc: stable@vger.kernel.org
>>
>> How does this affect users?  What behavior do they observe when it
>> occurs?
> 
> I think the first paragraph sums it up pretty well, especially the
> last sentence "hotter pages with higher fault latency".
> 
>>
>>> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
>>
>> hm, that isn't really a bug report and doesn't answer the above
>> question.
> 
> Yeah, it isn't. Probably we should drop "Closes". I assume Hao added
> it because checkpatch annoyingly complains if you add "Reported-by"
> without "Closes", so Hao just linked to the thread where I pointed out
> the bug.

Yeah, checkpatch will complain if it's missing.

> 
>>
>> AI review asked a couple of questions:
>>          https://sashiko.dev/#/patchset/20260729084206.77793-1-jiahao.kernel@gmail.com
> 
> The review on patch #1 is something theoretical, we discussed it at
> length in previous versions.
> 
> For patch #2:
> 
>> Does this batching logic break NUMA fairness?
>>
>> Because for_each_node_state() always starts from the lowest node
>> ID and breaks when the scan budget is exhausted, subsequent
>> calls to shrink_memcg() will restart at the lowest node ID again.
>>
>> If the lowest node (typically Node 0) consistently has enough
>> items to exhaust the scan budget, wouldn't we exclusively evict
>> pages from it while ignoring older pages on other nodes? Could
>> this cause LRU inversion across nodes, keeping older pages in
>> memory on Node 1 while hot pages on Node 0 are evicted?
> 
> Yes, unfairness is possible.
> 
> For global shrinking, it's probably not an issue. We reclaim until we
> hit the acceptance threshold and it's very unlikely this will happen
> before iterating all nodes (given that the batch size is 32 pages).
> However, with the shrink_memcg() path, we only reclaim one batch, so
> there's a chance we'll always reclaim it from node 0.
> 
> Maybe we should just drop the early bailout and accept potentially
> doing more writeback than needed. Hao, WDYT?
> 
If we scan and attempt to write back SWAP_CLUSTER_MAX zswap entries per 
node, it might lead to excessive writeback on machines with many NUMA 
nodes. Furthermore, I'm concerned about introducing higher latency in 
synchronous shrink paths like zswap_store()—especially on systems with a 
large number of NUMA nodes, where it could end up writing back hundreds 
of pages in a single call.

Maybe we could do something like this instead? That way, in the 
worst-case scenario, it falls back to the baseline behavior without 
introducing any extra latency risks.

  static int shrink_memcg(struct mem_cgroup *memcg)
  {
-       int nid, shrunk = 0, scanned = 0;
+       unsigned long node_batch, scanned = 0;
+       int nid, shrunk = 0;

         if (!mem_cgroup_zswap_writeback_enabled(memcg))
                 return -ENOENT;
@@ -1289,14 +1313,26 @@ static int shrink_memcg(struct mem_cgroup *memcg)
         if (memcg && !mem_cgroup_online(memcg))
                 return -ENOENT;

+       node_batch = max(1UL, SWAP_CLUSTER_MAX / 
num_node_state(N_NORMAL_MEMORY));
         for_each_node_state(nid, N_NORMAL_MEMORY) {
-               unsigned long nr_to_walk = 1;
+               unsigned long nr_to_walk, budget;
+
+               /*
+                * Cap the scan at the per-node LRU length so each entry is
+                * scanned at most once per call.
+                */
+               budget = min(node_batch,
+                            list_lru_count_one(&zswap_list_lru, nid, 
memcg));
+               if (!budget)
+                       continue;

+               nr_to_walk = budget;
                 shrunk += list_lru_walk_one(&zswap_list_lru, nid, memcg,
                                             &shrink_memcg_cb, NULL, 
&nr_to_walk);
-               scanned += 1 - nr_to_walk;
+               scanned += budget - nr_to_walk;
         }

+       /* Nothing was scanned: every LRU under @memcg was empty. */
         if (!scanned)
                 return -ENOENT;

Thanks,
Hao
> If you respin, please also drop the batch size argument to
> shrink_memcg() as it's now always SWAP_CLUSTER_MAX.
