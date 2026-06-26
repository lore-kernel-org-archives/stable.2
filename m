Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41183E9287
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472912; cv=none; b=Q+kCk1s/B8nQHrDgOzo7Q6eUIi3XSaKu1g1napYB2VDfx5sVw2f67llnfVuyAfzi7zf0jyEbN/GTTfhIIyTEZIxmVlMXrWGW8dmV9KN2iAXvhK7rVXwQqY9jnoEg7lwj8mUGzeoYeYxWvXj/RaEQLBNCpnaS8naHDyIfysHKRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472912; c=relaxed/simple;
	bh=9spW60n7KVcrvhkMswN0/3I2GFHz+mOsLIJkdth7eHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTOB56rsaxygvYuPAoqbRZzTVtAG7+It9xppblGsLhTO1g/hcqnRR9mJy7q9hsOJl9VDELjj/RtwWFK0ApWUXhko+Rcz4QN5REBslU6fgSLUOKQMQXzyqG3flPHfz12D8mtgKUKMFZHXxrPLR/NUCxv39Lf58TOhhY2yoFFNKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ShybaEdE; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ShybaEdE"
Message-ID: <57c18afd-e2a3-4b37-90b6-f2a4c758e8aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782472907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXnGSQ/f8kthQgxhjN/qMHFlHYZPXPOXt+bobY0m7Ck=;
	b=ShybaEdEuvjaq13R1piH2Z+U9a0wSOAEKFD90/s1i7ZE77Vs1RndU1kW6KQ7qUbtW79HcD
	vreqzNqtQaQeE+7AcQ8JQkv+EBQd3thYj97SSBWGmSD22qqs/z7PobV/u8tB2breJGoknE
	My76uAFXDSZY5f+J75MBfMNtqFjnir8=
Date: Fri, 26 Jun 2026 19:21:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev
Cc: Harry Yoo <harry@kernel.org>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, baohua@kernel.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
 roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
 <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
 <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
 <afdaff7c-fe6b-40da-8f54-aeeab8fe8867@kernel.org>
 <90fd5300-1016-42e7-abad-08ad85fb62b4@linux.dev>
 <5a0c6597-6b96-4781-a71b-fd1298b2b7bb@kernel.org>
 <c0e366ec-ee5d-42d9-ba33-7c630660e8af@linux.dev>
 <aj5I7JAXWlTHRyEW@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aj5I7JAXWlTHRyEW@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/26/26 5:39 PM, Johannes Weiner wrote:
> On Fri, Jun 26, 2026 at 03:04:17PM +0800, Qi Zheng wrote:
>> On 6/26/26 2:48 PM, Harry Yoo wrote:
>>> On 6/26/26 3:24 PM, Qi Zheng wrote:
>>>> On 6/26/26 12:59 PM, Harry Yoo wrote:
>>>>> Observing a dying cgroup should be rare anyway, it's worth focusing
>>>>> more on readability?
>>>>
>>>> While it's rare to encounter consecutive dying memcgs, it can still
>>>> happen, right?
>>>
>>> But is worth saving a few instruction in a basic block that is
>>> unlikely() to be executed?
>>
>> I don't have a strong opinion here. Hi Johannes, I'll leave the decision
>> up to you. If necessary, I can send out the v4.
> 
> Yes, I was thinking what Harry actually bothered to spell out ;)
> 
> The race is rare, multiple levels even rarer, and even *then*
> mem_cgroup_lruvec() is a quick inline.
> 
> This way you have one block to handle that one rare race
> condition. One place to put the comment. No labels, no goto.
> 
> Simplicity wins :)

Okay, I will update it as you suggested and send out the v4.

Hi Shakeel, do we really need to move lock_batch_lruvec() to
memcontrol.h? It's currently only used by reset_batch_size().

Thanks,
Qi

