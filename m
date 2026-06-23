Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9913790B
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782181281; cv=none; b=quRlsXrqo0Tqf1xN1UD3WsyoXByjSRgHWWmqCPgLD9Lkr0lnWfQJfSpg/5G8q9Jq7lCVrsmSZiA8wy4mwAzpxU8/i8lv7RyGS7Me30e/jY5Sdma1Q/BTBXU2xhch0sWM51cgJ1COgjZzdKEZ9i7fgjNQC5r+NLWUOKhPI7VQmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782181281; c=relaxed/simple;
	bh=Pqzh3hhRMfiP2uRy2M0e846l/Oe1N6KvLm26cT2E7Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyTlYN7Qv0/M7CLP9lo4p6zrgLPpe2aaS6QbrKTB0FvH46l6H9cVp0j9yKl+1f5krPQ2kko0RFM2FOy6SkfkekgI0pYPKrVrEKjC8piOVbhYq5X5gZFCaBsaHdZlUNB6mJGuU+tPH7n4lt3OWeewhu2Nlhi1Dg8tEt7muqC9Fxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VUCWDlmG; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VUCWDlmG"
Message-ID: <46730710-fa60-4332-820c-0a68acf00dd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782181268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMffO2o77SuR2hBlttDpYw1QPIJxJT/T6T/rBhU7vx4=;
	b=VUCWDlmG7W9buVSD5ve7UbTJnBWCcsS3T/Oq+PfLVKKFkVQmc97akdOQDziHich3ufJFtK
	QaYoQwbOgqjrvYDiTCUImSPEGiC2q3Bc2U2smVp9Z5UCFzARkJS8wC1BapXmpb8mInfnh/
	6Xr+q2+2RYBYhhAh3SxFOtsSz70yPpc=
Date: Tue, 23 Jun 2026 10:20:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, harry@kernel.org,
 muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
 roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
References: <5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn>
 <20260622073703.79258-1-qi.zheng@linux.dev>
 <CAGsJ_4z34ZRu_RKkaZ7EgTWMOxptUjZ90WJyNoJrXGNjzutxnA@mail.gmail.com>
 <19710ee5-8e1c-4b13-812b-4b03ca34260d@linux.dev>
 <CAGsJ_4zC8jMNk0twWQd+oRWCzZTm523K-KgzDQ6TkjbzPq4MTw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <CAGsJ_4zC8jMNk0twWQd+oRWCzZTm523K-KgzDQ6TkjbzPq4MTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/23/26 10:15 AM, Barry Song wrote:
> On Tue, Jun 23, 2026 at 9:58 AM Qi Zheng <qi.zheng@linux.dev> wrote:
>>

[...]

>>>>
>>>> WARNING: mm/vmscan.c:5867 at lru_gen_exit_memcg+0x26f/0x300
>>>> RIP: 0010:lru_gen_exit_memcg+0x26f/0x300 mm/vmscan.c:5867
>>>
>>> I can't find 5867; instead, I can find 5828:
>>>
>>> VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>>>     sizeof(lruvec->lrugen.nr_pages)));
>>>
>>> Is this the warning?
>>
>> Yes, I just copy-pasted the warning log from Peiyang's report.
>>
>> Maybe the description should be changed to:
>>
>> This will trigger the following warning in lru_gen_exit_memcg():
>>
>>          VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>>                                             sizeof(lruvec->lrugen.nr_pages)));
>>
>>>
> 
> Yep. Can we update the v2 changelog accordingly?

Sure, will do in v2.

Thanks,
Qi

> 
> Best Regards
> Barry

