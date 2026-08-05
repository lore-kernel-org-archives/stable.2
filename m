Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477903403F4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910896; cv=none; b=U+P+tk4x94dEIzVoY/ioyqlWncYeGFmEReyGgf3//dMC1Zah2nKgv3uL1SBoo1KCpLd6n9Ua5pkxSeOn/yu7OCKO3PF15G4l8llQbMnc9sLx0UO/vl9gIep/VfrSUCk46f4AYJYfaIn56qAkBclNKdukqg9lyiX2EoP4rgE5iX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910896; c=relaxed/simple;
	bh=qSx+Kgiz5nV4+oH8PMKK6Uq7fmr/VKlJXmnhqO/OcaM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l/bbfyoknuyjYFqDPNL7azHd3mV0rnAuNXooyDFsxoJlFjvppiS7mPvvPIrJf7y+n3slRondxOYdZ3KO+UOF9nZUR45V4e8aFrNnfrbRzOwuCdONV2UtA/FyUlbZfFwzWZW7V/LVZbAwZ2wRnctjUPS2Zv8jm+foQXEHMJ5+r7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLBo51ES; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLBo51ES"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84eb992a881so503094b3a.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 23:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785910894; x=1786515694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=90dET2o+stuXHdvr17MtJ609siDKgo9CQdU/QNgsB1k=;
        b=fLBo51ESPFtJSZZokdZDZqfLjwCR/j4/cPeiN1Oj0WzmdXBAuqI7TbzEuyc1XN8mrI
         Bkv2eWgKWBM7yeFzTlm6woIfrg3AvaGRHHyPePsja3pG72r+ZN9Fjm0F7i4VjwONZKGq
         asJDynpFoECNfBCEBelCis/cehVgoa8wDse5D6NWY8ukAZNxwljL0dnwIHpHnQK2YMBB
         dEJDeDi3w+//g6yTFA8/wvnCsLCRc4Ncz0O8c7v9LYiMo909SG7WIxTVECk2NamyyrBb
         FPgOQYgBYPnG2qrMk39gnFmKxtdbvU/2IA4vIqk7jRmX4NcTiNQd6X2ZsnbjoKtDJ0uo
         Vudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785910894; x=1786515694;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90dET2o+stuXHdvr17MtJ609siDKgo9CQdU/QNgsB1k=;
        b=Z8c8I4rqd/NSwvXAt7Lrip1/13Z2Dvc6kpU0u0mDYRWkgn3Tc3c2ikIxUez9och86V
         5ov1yoauOLMthXGgPqb4OGE1cyzETMekyPPcpnCIzHOX00UHVk08vuxo4+5WV5pS8KGj
         EYgklS82ZUtV3bvOFkDiV2zfDHstvtTKrbAZbzF0TndKGyD66V5Kd9DS6G0VHUvu6CiY
         T3IMPTlxgvI9A5R3R05QovEkCEX7myp8RmR6gjYpx5lvf0guW5RfhKbb+T/87w0YOuy7
         XZSTCrWzcVM+ZvA6qdBWSbhobuLtMRgf3cOH/gr2Ojr+LrDkhtIBSHNGQOOslzL5PYU5
         Xl/A==
X-Forwarded-Encrypted: i=1; AHgh+Rq46njD/0tcYPin1KFH9BiOBVTr6BP2RV3aW+1zQIiO1vhz4+7pYeRvQQUZh+Rr8Rgx1v0ryf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWq2EFZZmYyT+ZrCC1Hdq2Oyjc/foXq4h3QrP+f3vZetqhG9s
	Y13fsqXfBS6EoxOMx5yFudFeMxanej5jspOBRSPhrQ8khXjLYS0Xe6PT
X-Gm-Gg: AR+sD10dUL6PptqTKUYJYwvcmZ1CR9yWdL6ZE/gO60r6ninsn+YQCCzkQOda9nKLUPi
	9azb28Nk03GTsayyttcFy5kZpIYhvrc4tznonL0/yZ2VmzLexuznK3OtqL5bL/6fSq2ms7Dub0I
	1yCWtdi6OM2z5skfONxDObjQ0jPSgJdVak7KTo4yPa3W37snEuCFPgmNADaftHDFqQc6gXHBimc
	7ua/V7ajj9KQ7IDTwJPXnAvfsDZ1lonufyLrdW7Kvkv0mJGgnWLdxlVuKH7mp/rqzqWnVVUpDBO
	wTIECoQOJbAzFDN+2nkEp9ht1rQqmWTP+gSUuKdZXup+QxlCqIvHQYl6dcWdMHYu7Vyr4mkOCn4
	A3Tfe7Vu9vUDG82TG2XZuVj8S2Dk+3rzuRLjDc5sseAfmyvhE63StPJwrLMRLyIt4D6TDiSGcgu
	sODqNVHGKIyMm4tN2Dj+l09CTNtIeS5L97yozauIEflcT5QolXDuYOnd44ErSFluhpoxSq8OOap
	Vlvg6/d
X-Received: by 2002:a05:6a00:3a1f:b0:847:8dec:1427 with SMTP id d2e1a72fcca58-84f2dfc340bmr4646658b3a.8.1785910894366;
        Tue, 04 Aug 2026 23:21:34 -0700 (PDT)
Received: from [10.125.192.43] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e5139casm464939b3a.44.2026.08.04.23.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 23:21:33 -0700 (PDT)
Message-ID: <94d74382-2e2c-8f8e-35e6-1ecafdcc445f@gmail.com>
Date: Wed, 5 Aug 2026 14:21:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/2] mm/zswap: Support batch writeback in
 shrink_memcg()
From: Hao Jia <jiahao.kernel@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>, yosry@kernel.org, nphamcs@gmail.com
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, jiahao1@lixiang.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mhocko@kernel.org, mkoutny@suse.com, muchun.song@linux.dev,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, stable@vger.kernel.org,
 tj@kernel.org
References: <amufiuAaZbuDdKkQ@cmpxchg.org>
 <20260731071900.38942-1-jiahao.kernel@gmail.com>
 <amy8gAN33W4QsM5R@cmpxchg.org>
 <6e16a760-d84d-98e1-433e-3233a9dd2236@gmail.com>
In-Reply-To: <6e16a760-d84d-98e1-433e-3233a9dd2236@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/8/1 08:31, Hao Jia wrote:
> 
> 
> On 2026/7/31 23:17, Johannes Weiner wrote:
>> On Fri, Jul 31, 2026 at 03:19:00PM +0800, Hao Jia wrote:
>>> From: Hao Jia <jiahao1@lixiang.com>
>>>
>>> Currently, shrink_memcg() writes back at most one entry per-node during
>>> its traversal. This makes shrink_worker() inefficient, as it must
>>> repeatedly re-enter shrink_memcg() to make any substantial progress.
>>> Under high memory pressure, this can cause the writeback speed to be
>>> too slow to keep up with refaults, leading to zswap store failures and
>>> forcing pages to skip zswap and go directly to disk, which results in
>>> an LRU inversion.
>>>
>>> To address this, extend shrink_memcg() and rewrite its LRU iteration 
>>> logic,
>>> enabling batch writeback for both the shrink_worker() and 
>>> zswap_store() paths.
>>> To prevent shrink unfairness across NUMA nodes caused by a shared 
>>> global scan
>>> quota, limit scanning to up to SWAP_CLUSTER_MAX pages per node and 
>>> write back
>>> any reclaimable entries found.
>>>
>>> Test Setup:
>>> - Total memory: 32 GB, 1 NUMA node.
>>> - zswap settings: accept_threshold_percent=50, shrinker_enabled=N.
>>>
>>> Test Case 1:
>>> Set max_pool_percent=1, allocate 512MB of anonymous pages, and fill them
>>> with random data (to avoid compression). Then, use cgroup memory.reclaim
>>> to force a large amount of anonymous pages into zswap. At an interval of
>>> 2ms, allocate a 4K anonymous page where the first 4 bytes are random 
>>> numbers
>>> and the rest are zeros, and then trigger reclamation of this 4K page 
>>> through
>>> cgroup memory.reclaim. When the pool threshold is reached, 
>>> shrink_memcg()
>>> will be triggered.
>>> The test data after running for 120s is as follows:
>>>                                  Baseline      Patched
>>> shrink_worker wakeups              5,363          169
>>> shrink_memcg calls            11,373,201      350,703
>>> written_back pages                40,212       40,241
>>> zswap_store calls                161,190      163,753
>>>     store succeeded (ret=1)       102,743      117,183
>>>     store rejected (ret=0)         58,447       46,570
>>>     store reject rate                ~36%        ~28%
>>> pool_limit_hit delta              55,826       33,760
>>> pswpout                           98,659       86,811
>>> pswpin                                 2            0
>>>
>>> Test Case 2:
>>> We evaluated the following two sub-configurations using stress-ng inside
>>> a cgroup capped at memory.max=1G for 120 seconds:
>>>    Test Case 2a (max_pool_percent=1): Continuously triggers the global
>>>    zswap pool limit, thereby waking up shrink_worker() to perform 
>>> asynchronous
>>>    shrinking.
>>>    Test Case 2b (zswap.max=320M, max_pool_percent=50): Continuously 
>>> triggers
>>>    the cgroup's zswap.max limit, thereby invoking synchronous shrinking.
>>> Command executed for both setups:
>>>     bash -c 'echo $$ > /sys/fs/cgroup/zswaptest/cgroup.procs ; \
>>>     exec stress-ng --vm 4 --vm-bytes 4G --vm-keep --vm-method 
>>> rand-set -t \
>>> 120s -q'
>>>
>>> Test Case 2a (max_pool_percent=1):
>>>                                  Baseline       Patched
>>> shrink_worker wakeups              5,640         1,308
>>> shrink_memcg calls             8,481,500     3,140,972
>>> written_back pages                   260       468,216
>>> zswap_store calls              2,742,756     2,011,269
>>>     store succeeded (ret=1)       934,640       947,988
>>>     store rejected (ret=0)      1,808,116     1,063,281
>>>     store reject rate                ~66%          ~52%
>>> pool_limit_hit delta           1,181,310       196,882
>>> pswpout                        1,808,376     1,531,497
>>> pswpin                         4,288,497     3,635,365
>>> Test Case 2b (zswap.max=320M, max_pool_percent=50):
>>>                                  Baseline       Patched
>>> shrink_worker wakeups                 0              0
>>> shrink_memcg calls              687,608         54,002
>>> written_back pages              639,176        846,663
>>> zswap_store calls             1,224,222      1,228,548
>>>     store succeeded (ret=1)      992,816      1,208,123
>>>     store rejected (ret=0)       231,431         20,425
>>>     store reject rate               ~19%            ~2%
>>> pool_limit_hit delta                  0              0
>>> pswpout                         870,745        867,360
>>> pswpin                        1,707,823      1,216,814
>>>
>>> Under identical workloads and runtimes, batched zswap shrinking
>>> exhibits a significant reduction in both shrink_worker() wakeups
>>> and shrink_memcg() calls. Furthermore, the sharp drop in both pswpin
>>> and zswap_store() rejections demonstrates that batching zswap shrink
>>> operations effectively mitigates zswap_store() failures caused by
>>> hitting the pool limit. This significantly prevents pages from bypassing
>>> zswap and falling back directly to disk, thereby reducing LRU inversion.
>>>
>>> Suggested-by: Yosry Ahmed <yosry@kernel.org>
>>> Acked-by: Yosry Ahmed <yosry@kernel.org>
>>> Acked-by: Nhat Pham <nphamcs@gmail.com>
>>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
>>> ---
>>>   mm/zswap.c | 30 ++++++++++++++++++++++++++++--
>>>   1 file changed, 28 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>> index 48fc7b575e24..d406c14925d8 100644
>>> --- a/mm/zswap.c
>>> +++ b/mm/zswap.c
>>> @@ -1275,6 +1275,21 @@ static struct shrinker 
>>> *zswap_alloc_shrinker(void)
>>>       return shrinker;
>>>   }
>>> +/*
>>> + * Scan up to SWAP_CLUSTER_MAX pages on each per-node zswap LRU of 
>>> @memcg
>>> + * and write back the reclaimable ones.
>>> + *
>>> + * Since the second-chance algorithm rotates referenced entries to the
>>> + * LRU tail, the per-node scan is capped at the current LRU length so
>>> + * each entry is scanned at most once per call. It is up to the caller
>>> + * to handle retries, deciding whether to scan another memcg to 
>>> complete
>>> + * the full iteration, or to rescan the current memcg to drain its 
>>> zswap
>>> + * entries.
>>> + *
>>> + * Return: 0 if at least one entry was written back, -EAGAIN if entries
>>> + * were scanned but none could be written back, or -ENOENT if @memcg 
>>> has
>>> + * writeback disabled, is a zombie cgroup, or has empty zswap LRUs.
>>> + */
>>>   static int shrink_memcg(struct mem_cgroup *memcg)
>>>   {
>>>       int nid, shrunk = 0, scanned = 0;
>>> @@ -1290,13 +1305,24 @@ static int shrink_memcg(struct mem_cgroup 
>>> *memcg)
>>>           return -ENOENT;
>>>       for_each_node_state(nid, N_NORMAL_MEMORY) {
>>> -        unsigned long nr_to_walk = 1;
>>> +        unsigned long nr_to_walk, node_budget;
>>> +
>>> +        /*
>>> +         * Cap the scan at the per-node LRU length so each entry is
>>> +         * scanned at most once per call.
>>> +         */
>>> +        node_budget = min(SWAP_CLUSTER_MAX,
>>> +                 list_lru_count_one(&zswap_list_lru, nid, memcg));
>>
>> AFAICS you can just do unsigned long nr_to_walk = SWAP_CLUSTER_MAX.
>>
>> __list_lru_walk_one() does a list_for_each_safe() that will exit the
>> same way whether you hit !nr_to_walk or run out of items.
> 
> Wouldn't it be better to ensure that each entry is scanned at most once 
> per call, particularly when list_lru_count_one(nid) < SWAP_CLUSTER_MAX?
> 
> On one hand, this avoids scanning the same entry multiple times within a 
> single pass. Since the second-chance algorithm rotates referenced 
> entries to the tail of the LRU, entries on nodes with a large number of 
> zswap entries require at least two shrink_memcg() calls to be written 
> back, whereas entries on nodes with fewer entries might get written back 
> in a single shrink_memcg() call instead. On the other hand, we also 
> avoid spinning repeatedly on entries that fail writeback.
> 
> Thanks,
> Hao
> 

Johannes, Yosry, Nhats, any thoughts on this?

>>
>>> +        if (!node_budget)
>>> +            continue;
>>> +        nr_to_walk = node_budget;
>>>           shrunk += list_lru_walk_one(&zswap_list_lru, nid, memcg,
>>>                           &shrink_memcg_cb, NULL, &nr_to_walk);
>>> -        scanned += 1 - nr_to_walk;
>>> +        scanned += node_budget - nr_to_walk;
>>
>> scanned += SWAP_CLUSTER_MAX - nr_to_walk;
