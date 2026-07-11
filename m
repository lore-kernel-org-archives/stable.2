Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0B2D3220;
	Sat, 11 Jul 2026 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783756471; cv=none; b=FZ2lzcLyE1UzPEFhw+Az3CgWhYDHEK5NTeHXat0YsmRo7MkRrgBAX9RUnJDNcsYRaGD2ZXxXdca7faWrmPOzqdLgCV0E9V0iuXE000s1PLZQ/Wl4O5nsLNcgEMHxSoxlW2imCeXd6s15FtC+rcV06YJEbEnCptGH9tsESJU2iNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783756471; c=relaxed/simple;
	bh=WceHf0KcBKDAKTMGbFC9pzGd61aLnZfb7YwmzpCbEp4=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=p9O/vifI8WF8jd/4gca0A4nhr5KystJdbjsxg2igvLCwneuJfxMjZH2cWQqJ5Nw6PbNncei6Ys6BYagR0JAyQLo9ZGe+0wxy7Jr8XjVI6kG5zCU08xcRo4WR9pO0ANBvIXo8jTenYdq3cqwpOdKAIrFgDWErD5mqjBMStIF0gT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=iLrS1o52; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="iLrS1o52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=Og51IuOMC4sUgh7fHR2b6CD95EpwXnuhBRb4AGzlVns=;
	b=iLrS1o52zhz1omy5BiOwM+PF7EyU1ALML7GEsKGeoAjdlotGRCVnQHhDho99W7
	o6o0et3Bk5bLwmyvqsxJ60LVaAtkpOdqB6pVOb2ZXbdX/vWSp3TFaZqbQQfE3Pcr
	zuKDqh+0GgXI+EZ+ZRVKmrXqCLga2McspF/tOQURWtF6g=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3b0CA9lFqJAzODA--.38605S2;
	Sat, 11 Jul 2026 15:53:36 +0800 (CST)
Message-ID: <6A51F670.9020104@126.com>
Date: Sat, 11 Jul 2026 15:53:20 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Qi Zheng <qi.zheng@linux.dev>, 
 Hongling Zeng <zenghongling@kylinos.cn>,
 akpm@linux-foundation.org, david@fromorbit.com, 
 roman.gushchin@linux.dev, muchun.song@linux.dev
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Subject: Re: [PATCH] mm: shrinker: Fix double-free in alloc_shrinker_info
 error path
References: <20260711041954.95749-1-zenghongling@kylinos.cn> <ab1bdfa0-7382-4d26-a65d-68eb172eb84a@linux.dev>
In-Reply-To: <ab1bdfa0-7382-4d26-a65d-68eb172eb84a@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b0CA9lFqJAzODA--.38605S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1fWFWrWFy7CF43Cw1fCrg_yoW5ZrW7pF
	Z2gayDKFW5A3409r1av3W7XrySqw1Fkr4rGwnaqw1jyr1fuF1aqr47Ar4a9ryDu3WxGF4D
	tFWDXr1jgw1YyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjyIUUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrwDMnWpR9oCLegAA3C


在 2026年07月11日 13:31, Qi Zheng 写道:
> Hi Hongling,
>
> On 7/11/26 12:19 PM, Hongling Zeng wrote:
>> In alloc_shrinker_info(), when shrinker_unit_alloc() fails for a node,
>> the error handler calls free_shrinker_info() which iterates over ALL
>> nodes and tries to free their shrinker_info. For the failed node,
>> rcu_assign_pointer() was skipped, so its shrinker_info still points
>> to old data. This causes double-free of valid shrinker_info structures.
>
> No, it will be NULL, not old data. Therefore, the double-free you
> mentioned doesn't exist. Before sending the fix, please verify the
> problem exists and your fix actually works.
>
  Sorry, You're absolutely right. After carefully re-examining the code, 
I now see that:
   1. alloc_mem_cgroup_per_node_info() allocates with __GFP_ZERO, so 
shrinker_info is initialized to NULL, not old data
   2. The error handler in alloc_shrinker_info() correctly bounds 
cleanup with if (nid >= failed_nid) break;, so it only frees 
successfully allocated structures
   My analysis was incorrect - there is no double-free issue in this 
code path, I apologize for submitting this patch without proper 
verification.
> And as a reminder, please don't repeatedly send identical patches:
>
> 1. 
> https://lore.kernel.org/all/20260711041509.92926-1-zenghongling@kylinos.cn/
> 2. 
> https://lore.kernel.org/all/20260711041823.95135-1-zenghongling@kylinos.cn/
> 3. 
> https://lore.kernel.org/all/20260711041954.95749-1-zenghongling@kylinos.cn/
>
> One last thing, please make sure to base your changes on the latest
> tree.
>
> Thanks,
> Qi
I also apologize for the multiple identical submissions ，my email 
client was reporting errors when sending, so I retried thinking the 
emails weren't going through。
>
>>
>> Fix by tracking which node failed and only freeing shrinker_info
>> structures that were successfully assigned via rcu_assign_pointer()
>> in this call. Failed/unhandled nodes are left untouched.
>>
>> Fixes: 15e8156713cc ("mm: shrinker: avoid memleak in 
>> alloc_shrinker_info")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> ---
>>   mm/shrinker.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index 7082d01c8c9d..92c6cb455fc9 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -78,6 +78,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>   {
>>       int nid, ret = 0;
>>       int array_size = 0;
>> +    int failed_nid;
>>         mutex_lock(&shrinker_mutex);
>>       array_size = shrinker_unit_size(shrinker_nr_max);
>> @@ -98,8 +99,18 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>       return ret;
>>     err:
>> +    failed_nid = nid;
>> +    for_each_node(nid) {
>> +        struct shrinker_info *info;
>> +
>> +        if (nid >= failed_nid)
>> +            break;
>> +        info = shrinker_info_protected(memcg, nid);
>> + rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, NULL);
>> +        shrinker_unit_free(info, 0);
>> +        kvfree(info);
>> +    }
>>       mutex_unlock(&shrinker_mutex);
>> -    free_shrinker_info(memcg);
>>       return -ENOMEM;
>>   }

