Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121D39A07E
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482754; cv=none; b=p1UR+Ydeph+IimhK9/XK3NqZGO4aKniP5nmn7pGIHTac0F7Tj89ZuQx1fgjXDZ0nSlrqtxA4NNTVQ279pjbT6EnFzM7csXw7VO/4NU6KdCsZiSGS7+AjVo473iLcaZYsM8SpWKAK8aQfeozlMiE9se9qhZzXf7bmCb4MkoBvDHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482754; c=relaxed/simple;
	bh=cBGqzSHgpyf2ylHr8NeGS/tmGuJCS2IoNCewnJbgURQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVyRgvaPrre7xZwIrysxhrmAFXgWtiUtyM+a27KrD2jfR+3oDl/eEtaPBvnwSKS+EZrGZLYeREJE8MOTY4l+jq9JkTie8+ivTruKdPX97moJamqHi5FkhlfKjZFIvXr5C2g+WFWOJbtKDTTVhd4az6qAjPYFwEuebV6YKRbyzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvar3cFu; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvar3cFu"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbb973e6749so738927a12.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785482752; x=1786087552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V1iIJadxoIBnwpT+OgXeZPORL6qjCPJ2u2L6lNdVtGE=;
        b=hvar3cFu1BykuNlFDX0W8gUMXq3OvBXWoApDKilq7D4JPkxcwsB8TsIoW9DeDAHH0I
         ZRGqgcP6p5r38CAwinCfrmeuqrAC25eRwZICJyNscevcyfYCc4ykyPGyssDnJBCdASCu
         z9wTeaLF4WNOBV+Go0t71S1My/WcX3LK4DQzjufihPU5icCE5zHUvgKwPD8WBXu+NQQK
         vZuJQzGRHFJFHaijzdyw1RglVRvTWV8ld7wpM+Im5asTTvS2LGGad6unIdAQt05WHLxd
         G0irfN5/5Xrws60qmA393XFWNlTr9WdhSNoNouSA09DaZgyO0W2YoJu6Gb3rknnOASpn
         vhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785482752; x=1786087552;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V1iIJadxoIBnwpT+OgXeZPORL6qjCPJ2u2L6lNdVtGE=;
        b=bMxbi2XWdJBC5DqN87Y//bhqi35Ja34TJCEqttUgZelxPk4dIEthUUHCENdwEqhJVr
         sCzLZbDdpzBUZRQkS4OWR+TuFKwm36Q/wdtqkh/TB4gX1KUwSEkcTxzrQn72gX9sI1vt
         5/tG16tS7oRu23ANB9Nh8WAlsv+h9sybF9hJRbZ+KNiSBHDBEinjvPci7JWdRdCj7uGM
         Ex4pdGOVD++ACIJnP/yseMlRo6xKcESCvwkrpD7L0ED+9so+NChRX0BPFxaf1n7JzbGH
         8fRsJDonXwh9DaeFEt6N/Hxj0TfCGx6wwB9DaJwoiZZdCGDn53b7SI3vvYr3Q9YSi3hw
         2atw==
X-Forwarded-Encrypted: i=1; AHgh+Ron3nD7Gy8/+iAE0w2Olvz56xCC3js/nfL9aK3fmEv9DAMpD0Cl4rzQvhJbfQ0tmhCpt2vG30M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCrK5w590wSqd6Dk/ISv+j3m+MHOk001VfrCYFKZUIeMiALJ/
	SWucCVF86AJZX2K4D5vcm1+r72EuRXz6A7I8BwNWQe2P4MI0Vuf5pObz
X-Gm-Gg: AR+sD11bXdZT3Wtjm45LUKwWdVPKzGoUkkQiw2PbnBr4nTvOnYxr++iZX8ggRvrDRqU
	nZNVLr+fsczOQOQG3ldCzqEef0qL3x3B6LsYI9uqa4XsOgdxngmokyvAhRD4mSbjCVaoDAxZDJO
	PEXtq+E93EZmOFS7CjwnTEpp1fI/UzGF0qBO45OGRUenYKacXWqV/v+FbIEKssRk2hGzrKTHv6y
	tKszttTFOpdPmpzhAWGNsRUHTzgLS1H8o8c+ZqmXX8FtY7AKGNmkIJkMom6zTY2ngnK69Yos/Cz
	kRd+bRfCFGXPSI/Rf3GR4geLTj/JHFVN04SFvzAn5hQvkuEhNmJchZ1t7aj/8k7MFE0Q1uYbCUR
	Yn3GQMPJDz+hhcps+GOWP+0t2Y0jrdvDFVCD8ou6Z96Is4uBmHA9W33URy+FqNSPh3H/49Nbob+
	jxdHVhrft7LvCaMMLjIzLckO7hF/HVgaw4QPqK6PAaGDcX6/1Nb/Ap+o1S+WExmBHO1vlGVTIPS
	ZJzGTRshw==
X-Received: by 2002:a05:6a21:62c7:b0:3c3:64cb:9b99 with SMTP id adf61e73a8af0-3c91b0de414mr911570637.6.1785482752052;
        Fri, 31 Jul 2026 00:25:52 -0700 (PDT)
Received: from [10.125.192.117] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3963e2aasm225078a12.2.2026.07.31.00.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 00:25:51 -0700 (PDT)
Message-ID: <a2ca877d-52a5-15c5-b70e-2f60284d6bef@gmail.com>
Date: Fri, 31 Jul 2026 15:25:40 +0800
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
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 tj@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
References: <20260729084206.77793-1-jiahao.kernel@gmail.com>
 <20260729084206.77793-2-jiahao.kernel@gmail.com>
 <20260729155858.c7aabff48166a9bca4d68ac3@linux-foundation.org>
 <CAO9r8zNhBCghP8T_98z2p==Cfs_=kamcRN_3ROxaj3R8PN2Qvw@mail.gmail.com>
 <c4c95102-72e2-a44f-f16e-4134ba6bb060@gmail.com>
 <CAO9r8zOSTYC3D_2CxapgvXGaZRUdnGetPGz2XgdUO8OygfuEiw@mail.gmail.com>
 <amufiuAaZbuDdKkQ@cmpxchg.org>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <amufiuAaZbuDdKkQ@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/7/31 03:01, Johannes Weiner wrote:
> On Thu, Jul 30, 2026 at 10:48:38AM -0700, Yosry Ahmed wrote:
>>>> Yeah, it isn't. Probably we should drop "Closes". I assume Hao added
>>>> it because checkpatch annoyingly complains if you add "Reported-by"
>>>> without "Closes", so Hao just linked to the thread where I pointed out
>>>> the bug.
>>>
>>> Yeah, checkpatch will complain if it's missing.
>>
>> We often ignore checkpatch if it's unreasonable.
>>
>>>>> AI review asked a couple of questions:
>>>>>           https://sashiko.dev/#/patchset/20260729084206.77793-1-jiahao.kernel@gmail.com
>>>>
>>>> The review on patch #1 is something theoretical, we discussed it at
>>>> length in previous versions.
>>>>
>>>> For patch #2:
>>>>
>>>>> Does this batching logic break NUMA fairness?
>>>>>
>>>>> Because for_each_node_state() always starts from the lowest node
>>>>> ID and breaks when the scan budget is exhausted, subsequent
>>>>> calls to shrink_memcg() will restart at the lowest node ID again.
>>>>>
>>>>> If the lowest node (typically Node 0) consistently has enough
>>>>> items to exhaust the scan budget, wouldn't we exclusively evict
>>>>> pages from it while ignoring older pages on other nodes? Could
>>>>> this cause LRU inversion across nodes, keeping older pages in
>>>>> memory on Node 1 while hot pages on Node 0 are evicted?
>>>>
>>>> Yes, unfairness is possible.
>>>>
>>>> For global shrinking, it's probably not an issue. We reclaim until we
>>>> hit the acceptance threshold and it's very unlikely this will happen
>>>> before iterating all nodes (given that the batch size is 32 pages).
>>>> However, with the shrink_memcg() path, we only reclaim one batch, so
>>>> there's a chance we'll always reclaim it from node 0.
>>>>
>>>> Maybe we should just drop the early bailout and accept potentially
>>>> doing more writeback than needed. Hao, WDYT?
>>>>
>>> If we scan and attempt to write back SWAP_CLUSTER_MAX zswap entries per
>>> node, it might lead to excessive writeback on machines with many NUMA
>>> nodes. Furthermore, I'm concerned about introducing higher latency in
>>> synchronous shrink paths like zswap_store()—especially on systems with a
>>> large number of NUMA nodes, where it could end up writing back hundreds
>>> of pages in a single call.
>>>
>>> Maybe we could do something like this instead? That way, in the
>>> worst-case scenario, it falls back to the baseline behavior without
>>> introducing any extra latency risks.
>>
>> This basically errs on the side of honouring the batch size
>> (under-reclaim) instead of doing more writeback, right?
>>
>> I think I prefer erring on the side of doing more writeback, as it
>> would ultimately result in less LRU inversion, and we are already
>> doing writeback proactively during reclaim through the shrinker.
> 
> Yes, LRU inversions are worse than reclaiming a few extra pages from
> the cold tail of the LRU. It's not cumulative after all, it just means
> we take a bigger bite and can take more stores before the next shrink.
> 
>> The other option we can explore is keeping the existing logic with the
>> bailout, but start iterating the nodes at the folio's node in the
>> zswap_store() path. Basically pass an nid to shrink_memcg() and always
>> start there. This will avoid always reclaiming from node 0, and the
>> node of the folio being stored is more likely to be under pressure and
>> need the writeback. I am not sure how complex this would be and
>> whether it's worth doing.
>>
>> Johannes, Nhats, any thoughts on this?
> 
> What happens if simply we do a hard SWAP_CLUSTER_MAX on each node?
> 
> With cgroups, we put the zswap entry on the list_lru head of the node
> and memcg where the incoming page was.
> 
> So if you're going after one specific cgroup, it's not like you
> *actually* reclaim 32 entries on each node of the system. You just
> write back from nodes where that cgroup has entries.
> 
> The global shrinker also does one cgroup at a time (zswap_next_shrink)
> before checking the limit again, so that's fairly fine-grained too.
> 
> Without cgroups, you could have zswap entries on all nodes. But if you
> have so many nodes that this would constitute hundreds of pages,
> presumably that's still a drop in the bucket compared to overall
> memory capacity. SWAP_CLUSTER_MAX isn't that big a number.
> 
> So I don't think we need to get fancy. Just do SWAP_CLUSTER_MAX on
> each node. Delete that nr_to_walk carry-over between them.

Thanks for the input! I've posted the new implementation—please take a 
look when you have time.

https://lore.kernel.org/all/20260731071900.38942-1-jiahao.kernel@gmail.com

Thanks,
Hao

