Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A69360EF9
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785544282; cv=none; b=gHoRukIPAQtZJ9RJ4wHhGmtwCN9D1aGHdD81w07+plbYZB3ILWDwuTyAOwo9iRQlRnXGZNJjVYosvoB7wk8WU5tYPtV/tVEDYVYj1hY2cukijVuRqVrauf9BTKn9mMxGo4eeEIMFVb3K1npQVvyxS15kln2yU472qgLTP4JY7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785544282; c=relaxed/simple;
	bh=8VI5d999L3cluB+QPSwmwFSWejSw56txXuUbAwSlNA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L309Qxes5MOCtE6S4+yFWAuabZ/1CMaTF/EGF33CKVLUCILlJFZp5gl902bZAJsaLg3m8Stjf8hcSY/Z2p6JNy1NFbTiKch4vTeD8vDAaeVy3tx0MgyoVGyxfiXBw1uIfeC0r6RzTz2XiRA0809hbsM3I0gL30dDRaLu7cvbg9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW48if2q; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW48if2q"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e507b079dso1179401b3a.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 17:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785544279; x=1786149079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=huQxdldpqRYaZEjHQZL7Ohp7YA7LATCZJOhI6k3svOo=;
        b=RW48if2qbDQLvdaqBZNVw1rXq6qOOFoc1Dnx99ZLrlAdK2dcJEzsem02EsRN65JUck
         IDiKN53RRJ4F7BVoBpU5M4/RvUITupe0gcDKQLl4fmc9HDlkOwfr9aRU1Ab7zXaXo6LB
         DqaH6YPWOxwqpWbT5ZmvB9FxBCz/5w98FXJnKfCWzJgOH4qkUk/3Lwt8EAp9jquoJaIH
         JjpSXiTXvMzN/+eNdFs6t+qCKZJv1ABPvo7WzEhPVAE/DIDfbBxOh4xHfOOxajLzvBHr
         y1YE4w7CtsJqtlIhktdILZsZ/l91RrrShg8pMpfeJwUUpyFYyUBi9aWJCUbOoBl2Mm+P
         PQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785544279; x=1786149079;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=huQxdldpqRYaZEjHQZL7Ohp7YA7LATCZJOhI6k3svOo=;
        b=EXuX7qk5AGmVHjycDxJSniA06DCK5Np9vhlqX7OlFnnp7YCRF3pEjGAEPr1zcuf+9z
         SB/FVdJ47BO/AXmIFXDB2zATKqxeOytxTPhb+5ET5+6w2Os0OjMbwYwc2P8PcS3+ouak
         u5mltcM9IbdcrV/b88DiLwbEYgQOxxbfLUG1rA1y5ZFwElbJ2L2KFMiRJppBJfLpXuMp
         5tYCmw4cyVVjtXAlDZMtudqE1kttyTdL2i/dBbpUKdLn0OvOj0OWxr7LYxQeh/QjPi+V
         Q4/tZ3TDSF512TTMJjtsNs76s8aTdA4zCTa74ut8jazR4W8np4jf7/vSe5Rm7Fg90Uek
         gErg==
X-Forwarded-Encrypted: i=1; AHgh+RpNeds2EZKgINZm7sq+vSjxi9eodBGoeHvnOIK6NL6lf5umLjJ7bJPUCrYW7D+aeo4lcSWhigI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTi+YkwdFmV848mcjOBntN4v3ULlneuHX63WJGmZhUJYaXNpT
	DGJOS207hVzemebTwseKU92Xq2gzyWaIIA24BzFO2c8sMe7DG4y/b6tF
X-Gm-Gg: AR+sD120DJZ8frM+rjmLchhAsvcZrvl8jNo5lid539j8bVtOZ71gkp4BhXWnWfTDPpo
	K77/L3sxpgct/iuqAS2DBymTXQp42MmfsPfEFot0THaA7O2mBAexTPdU2uis0N8P/3XI2gtLSI8
	KyUy9pKDhJoJnFbtv5rBcjutpVSaIlqSIcC6tnps3GNYokwesyvh7naDCzQxnWx5QmmDxbgKiCy
	+rWqmbPvTzMMyfax23cbmG+I8xl97UHcfLIT8I4ypsXWrz16cMRvEI2zDb8ITqjqijzUqfkKhRx
	fQ+9wxryQTmZ0eQlCXBB7kgJF8chSLJI2KfwKbCFEcuWGAyXkRbP2jr17qJENdDUHl2OXyOQ8kb
	obljvl+GSKa3Gq8ToRlSGmaEbmkcsKFESh8j1xa7oJyNUiNF28ASoMbSB9BUr0+XIHSc9jhUib3
	ektQkO/C2dMzRL3+SicMcshtQANcSqo9E2nudxFHMa51WkOqkeO/i0q3+/ue3G3B/e8P4mM5fG6
	zb9DgjZ+PXlr4onI1LCpAs/riqHNJQtbBBM90t86t8T8VNA5J1lcqvMw/w=
X-Received: by 2002:a05:6a00:4392:b0:84e:216d:7e4e with SMTP id d2e1a72fcca58-84ee479b03amr1357914b3a.1.1785544279161;
        Fri, 31 Jul 2026 17:31:19 -0700 (PDT)
Received: from ?IPV6:2409:8a28:62b:7644:8009:eff3:7a31:a025? ([2409:8a28:62b:7644:8009:eff3:7a31:a025])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc4237e5sm1030113b3a.59.2026.07.31.17.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 17:31:18 -0700 (PDT)
Message-ID: <6e16a760-d84d-98e1-433e-3233a9dd2236@gmail.com>
Date: Sat, 1 Aug 2026 08:31:09 +0800
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
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, jiahao1@lixiang.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mhocko@kernel.org, mkoutny@suse.com, muchun.song@linux.dev,
 nphamcs@gmail.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 stable@vger.kernel.org, tj@kernel.org, yosry@kernel.org
References: <amufiuAaZbuDdKkQ@cmpxchg.org>
 <20260731071900.38942-1-jiahao.kernel@gmail.com>
 <amy8gAN33W4QsM5R@cmpxchg.org>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <amy8gAN33W4QsM5R@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/7/31 23:17, Johannes Weiner wrote:
> On Fri, Jul 31, 2026 at 03:19:00PM +0800, Hao Jia wrote:
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> Currently, shrink_memcg() writes back at most one entry per-node during
>> its traversal. This makes shrink_worker() inefficient, as it must
>> repeatedly re-enter shrink_memcg() to make any substantial progress.
>> Under high memory pressure, this can cause the writeback speed to be
>> too slow to keep up with refaults, leading to zswap store failures and
>> forcing pages to skip zswap and go directly to disk, which results in
>> an LRU inversion.
>>
>> To address this, extend shrink_memcg() and rewrite its LRU iteration logic,
>> enabling batch writeback for both the shrink_worker() and zswap_store() paths.
>> To prevent shrink unfairness across NUMA nodes caused by a shared global scan
>> quota, limit scanning to up to SWAP_CLUSTER_MAX pages per node and write back
>> any reclaimable entries found.
>>
>> Test Setup:
>> - Total memory: 32 GB, 1 NUMA node.
>> - zswap settings: accept_threshold_percent=50, shrinker_enabled=N.
>>
>> Test Case 1:
>> Set max_pool_percent=1, allocate 512MB of anonymous pages, and fill them
>> with random data (to avoid compression). Then, use cgroup memory.reclaim
>> to force a large amount of anonymous pages into zswap. At an interval of
>> 2ms, allocate a 4K anonymous page where the first 4 bytes are random numbers
>> and the rest are zeros, and then trigger reclamation of this 4K page through
>> cgroup memory.reclaim. When the pool threshold is reached, shrink_memcg()
>> will be triggered.
>> The test data after running for 120s is as follows:
>>                                  Baseline      Patched
>> shrink_worker wakeups              5,363          169
>> shrink_memcg calls            11,373,201      350,703
>> written_back pages                40,212       40,241
>> zswap_store calls                161,190      163,753
>>     store succeeded (ret=1)       102,743      117,183
>>     store rejected (ret=0)         58,447       46,570
>>     store reject rate                ~36%        ~28%
>> pool_limit_hit delta              55,826       33,760
>> pswpout                           98,659       86,811
>> pswpin                                 2            0
>>
>> Test Case 2:
>> We evaluated the following two sub-configurations using stress-ng inside
>> a cgroup capped at memory.max=1G for 120 seconds:
>>    Test Case 2a (max_pool_percent=1): Continuously triggers the global
>>    zswap pool limit, thereby waking up shrink_worker() to perform asynchronous
>>    shrinking.
>>    Test Case 2b (zswap.max=320M, max_pool_percent=50): Continuously triggers
>>    the cgroup's zswap.max limit, thereby invoking synchronous shrinking.
>> Command executed for both setups:
>>     bash -c 'echo $$ > /sys/fs/cgroup/zswaptest/cgroup.procs ; \
>>     exec stress-ng --vm 4 --vm-bytes 4G --vm-keep --vm-method rand-set -t \
>> 120s -q'
>>
>> Test Case 2a (max_pool_percent=1):
>>                                  Baseline       Patched
>> shrink_worker wakeups              5,640         1,308
>> shrink_memcg calls             8,481,500     3,140,972
>> written_back pages                   260       468,216
>> zswap_store calls              2,742,756     2,011,269
>>     store succeeded (ret=1)       934,640       947,988
>>     store rejected (ret=0)      1,808,116     1,063,281
>>     store reject rate                ~66%          ~52%
>> pool_limit_hit delta           1,181,310       196,882
>> pswpout                        1,808,376     1,531,497
>> pswpin                         4,288,497     3,635,365
>> Test Case 2b (zswap.max=320M, max_pool_percent=50):
>>                                  Baseline       Patched
>> shrink_worker wakeups                 0              0
>> shrink_memcg calls              687,608         54,002
>> written_back pages              639,176        846,663
>> zswap_store calls             1,224,222      1,228,548
>>     store succeeded (ret=1)      992,816      1,208,123
>>     store rejected (ret=0)       231,431         20,425
>>     store reject rate               ~19%            ~2%
>> pool_limit_hit delta                  0              0
>> pswpout                         870,745        867,360
>> pswpin                        1,707,823      1,216,814
>>
>> Under identical workloads and runtimes, batched zswap shrinking
>> exhibits a significant reduction in both shrink_worker() wakeups
>> and shrink_memcg() calls. Furthermore, the sharp drop in both pswpin
>> and zswap_store() rejections demonstrates that batching zswap shrink
>> operations effectively mitigates zswap_store() failures caused by
>> hitting the pool limit. This significantly prevents pages from bypassing
>> zswap and falling back directly to disk, thereby reducing LRU inversion.
>>
>> Suggested-by: Yosry Ahmed <yosry@kernel.org>
>> Acked-by: Yosry Ahmed <yosry@kernel.org>
>> Acked-by: Nhat Pham <nphamcs@gmail.com>
>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
>> ---
>>   mm/zswap.c | 30 ++++++++++++++++++++++++++++--
>>   1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 48fc7b575e24..d406c14925d8 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1275,6 +1275,21 @@ static struct shrinker *zswap_alloc_shrinker(void)
>>   	return shrinker;
>>   }
>>   
>> +/*
>> + * Scan up to SWAP_CLUSTER_MAX pages on each per-node zswap LRU of @memcg
>> + * and write back the reclaimable ones.
>> + *
>> + * Since the second-chance algorithm rotates referenced entries to the
>> + * LRU tail, the per-node scan is capped at the current LRU length so
>> + * each entry is scanned at most once per call. It is up to the caller
>> + * to handle retries, deciding whether to scan another memcg to complete
>> + * the full iteration, or to rescan the current memcg to drain its zswap
>> + * entries.
>> + *
>> + * Return: 0 if at least one entry was written back, -EAGAIN if entries
>> + * were scanned but none could be written back, or -ENOENT if @memcg has
>> + * writeback disabled, is a zombie cgroup, or has empty zswap LRUs.
>> + */
>>   static int shrink_memcg(struct mem_cgroup *memcg)
>>   {
>>   	int nid, shrunk = 0, scanned = 0;
>> @@ -1290,13 +1305,24 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>>   		return -ENOENT;
>>   
>>   	for_each_node_state(nid, N_NORMAL_MEMORY) {
>> -		unsigned long nr_to_walk = 1;
>> +		unsigned long nr_to_walk, node_budget;
>> +
>> +		/*
>> +		 * Cap the scan at the per-node LRU length so each entry is
>> +		 * scanned at most once per call.
>> +		 */
>> +		node_budget = min(SWAP_CLUSTER_MAX,
>> +			     list_lru_count_one(&zswap_list_lru, nid, memcg));
> 
> AFAICS you can just do unsigned long nr_to_walk = SWAP_CLUSTER_MAX.
> 
> __list_lru_walk_one() does a list_for_each_safe() that will exit the
> same way whether you hit !nr_to_walk or run out of items.

Wouldn't it be better to ensure that each entry is scanned at most once 
per call, particularly when list_lru_count_one(nid) < SWAP_CLUSTER_MAX?

On one hand, this avoids scanning the same entry multiple times within a 
single pass. Since the second-chance algorithm rotates referenced 
entries to the tail of the LRU, entries on nodes with a large number of 
zswap entries require at least two shrink_memcg() calls to be written 
back, whereas entries on nodes with fewer entries might get written back 
in a single shrink_memcg() call instead. On the other hand, we also 
avoid spinning repeatedly on entries that fail writeback.

Thanks,
Hao

> 
>> +		if (!node_budget)
>> +			continue;
>>   
>> +		nr_to_walk = node_budget;
>>   		shrunk += list_lru_walk_one(&zswap_list_lru, nid, memcg,
>>   					    &shrink_memcg_cb, NULL, &nr_to_walk);
>> -		scanned += 1 - nr_to_walk;
>> +		scanned += node_budget - nr_to_walk;
> 
> scanned += SWAP_CLUSTER_MAX - nr_to_walk;
