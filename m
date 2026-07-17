Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84464331222
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278019; cv=none; b=RhO5LIsBmKNUq5gapW9O1NgpmIZHhRnElqRcbzfk9CjpMH8r5rfyZyaN+I3+zNoKbFbER6S5PM2FUZnd0Ek14+8w1t5YVMTbPN46QrcZDCfOn52rz76g7z0TM6rkl+7NpJvXJ/v/8JVvC8WBgigDKx1YGEaiVAQdiSOJUcpKOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278019; c=relaxed/simple;
	bh=A8xpebSaaQSXV4EPEpqxExKI2SAxI2OAwhCC9qjihIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQdtt8rAik6Jfmno3Wp3pgAP9fG2/IcP+0sHXbihm3BymWooc42NwGSGMTcu48EEzlG6VWYTF8fdSQEID6TCi91emTSBKc0rbuYwDvNiMfwSGLJh6/p97zGWbNaHlCkGpUtF4+ou73V+gEwLKhBxS1qchOp0eGPTjcF43wKse2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/iMfK5h; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/iMfK5h"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cee9b74ee1so40929955ad.3
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784278018; x=1784882818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wHC4U75uHN7griHlGyDVa7HlPfycllJJT0cM4ZMBj1k=;
        b=G/iMfK5hz9oetWCOcjQTItT13TEPeLr7ZQjjPu6gdgoMvxIN5ozzPvAl08/ZyvYI1b
         dmUnWgrVsSG67PMfPgVOyr6EX5RnqXNf52G3jDmhHwJvVlFubinE121QtVewg4V/HIOR
         Wig8In657iCC71m5M1a2nRwPrqLMMOp/9BnciXGu9uKUlybzmsjw10aHzp9VKrq1cwQN
         2npZZcF+kNffMcF8XQZpEEUppRsIVrcx9bpxK3X7Zj+0u3EQG4oTo1aNYEl79OL3k8Z0
         vVdtjlpJHe9rghfZHBaRk1aASi+vkfKIOYYShXfGxYw3z+599cJLmw2PqHLRhhBbJupc
         Fovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784278018; x=1784882818;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHC4U75uHN7griHlGyDVa7HlPfycllJJT0cM4ZMBj1k=;
        b=K8Zm55IXPhZM2JWOT7Yf9683yDoXGjWmvwhOtUtraBkQwY3/ettyhZFxoLlS/r0zQs
         nqLv3u5MqJAwigAc7KRI0ZKKsAtTu2SSH8L821BsgLJDOi/2YDRG567mP4ZfC0rMQjPG
         S8q0UGMX2vNLW0XnyGFHdzQb7egxRUZyinjng7ndhqCgXd5KGWL+ZIXbLZkCCQpjBkD7
         Kw181q5Kph+rBLYlrPlNzh9iV7j9aa8nStyjqLRecDJjC/A5s98OvWNx8vAlhegwUihl
         kOKUHJyntIfjT6onvmjIL5wFdI9p8zFOTExbLjpFNtm8vcYcQ5zrbTGFDTgiWT0bPsd4
         lUZg==
X-Forwarded-Encrypted: i=1; AHgh+RpEUxXz7Hg8aTLvaTIexYgR9ZyiHRmzaKpIhDmb4fA1G9u7fPrNkrSJFzyyHSTqQ610BEwxhbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+wpUKG67s9RFOsZe0QRG3/ccNIIhnbRlb4GrOj2Qu/bSqYF3
	xrLKZduTVREdINh2M4VgrrwxSTmbw0ofsHtAhqCl/p4+H9YcDJ9yXlZX
X-Gm-Gg: AfdE7cnGvL9XOgrFOoT7JpDB0mSeFwFkmo6GcHWgSRieYtYjvPsVNniSNLLZ4DsImYv
	xRb2TbIMBYE3hZiPxSdy4f2F5GhZE/YuzKEUq3fJ/ZJNFMgL5Uq5j7hmCkqHQNqUNcXAMItzpfw
	MLo1SsA5q6b5gIPVj/N0IvdM1S3gOacMOgvMsZf8zpITCpqHl3tAoA8onafqY22hr1JAK/YdCp6
	9lgg+saLnm6vXsPNwz4HNtjcq1B83+l14zjZsDt0ft/eUIVfr7FBFSdvFc1A6u5/UTj0AS+rJWz
	VW/XJpNNfLyKRpBkJeluYmeOMyZmSPl8+nhaI7QvXCYNBKsAVhYpV4BGfm0HY3/q3Ro7LRTijX7
	dnMjvdqVRrI8KKdIdKmIfLvUwQu+MqnbSB3DgTzNEZOo8POfFQcCkmx6vv0b8uI/y3nWZ6H7U14
	dmgEHV9zXvLZSqdlqERfOa3g4=
X-Received: by 2002:a17:903:230f:b0:2c9:9a19:df with SMTP id d9443c01a7336-2cf348aae13mr17638315ad.18.1784278017632;
        Fri, 17 Jul 2026 01:46:57 -0700 (PDT)
Received: from [10.125.192.114] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347a7c9fsm6699325ad.84.2026.07.17.01.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 01:46:56 -0700 (PDT)
Message-ID: <9c63fae9-0608-5192-665c-2811205a64c6@gmail.com>
Date: Fri, 17 Jul 2026 16:46:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] mm/zswap: Fix global shrinker when memory cgroup is
 disabled
To: Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
 hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>,
 stable@vger.kernel.org
References: <20260714081510.16895-1-jiahao.kernel@gmail.com>
 <20260714081510.16895-2-jiahao.kernel@gmail.com>
 <CAO9r8zM5nzDqNcx5UoDgGexvR6jf8MmJV9SomM4AS7n-rZ2o5Q@mail.gmail.com>
 <20260714193129.f81711f516504b659d544741@linux-foundation.org>
 <7a1fe347-7ca6-4768-9308-420bf1251f54@gmail.com>
 <CAO9r8zMDndmoxi_XvQv3rkkhCfb+aW3=8JdE3gAv2YOKiyiFSA@mail.gmail.com>
 <7b35fd4e-7662-10ae-159b-303350e4e59c@gmail.com>
 <CAKEwX=Ob9shetuJK4y=NZods3KkT=U_3W4S_ALzxX3EDLomWEA@mail.gmail.com>
 <CAO9r8zMy3C=tTLsyv_WkAS8Fd_Z3uSCmX4cekPLo8KkNb9bkCA@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAO9r8zMy3C=tTLsyv_WkAS8Fd_Z3uSCmX4cekPLo8KkNb9bkCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/7/17 08:08, Yosry Ahmed wrote:
> On Thu, Jul 16, 2026 at 11:19 AM Nhat Pham <nphamcs@gmail.com> wrote:
>>
>> On Wed, Jul 15, 2026 at 7:21 PM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>>
>>>
>>>
>>> On 2026/7/16 00:13, Yosry Ahmed wrote:
>>>> On Wed, Jul 15, 2026 at 5:31 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2026/7/15 10:31, Andrew Morton wrote:
>>>>>> On Tue, 14 Jul 2026 09:52:59 -0700 Yosry Ahmed <yosry@kernel.org> wrote:
>>>>>>
>>>>>>>> When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
>>>>>>>> Therefore, the global shrinker shrink_worker() always takes the !memcg
>>>>>>>> branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply gives up,
>>>>>>>> so it fails to write back anything.
>>>>>>>>
>>>>>>>> Therefore, when memory cgroup is disabled, fall through with the !memcg
>>>>>>>> branch and shrink the root memcg directly.
>>>>>>>>
>>>>>>>> With memcg disabled, shrink_memcg() only returns -ENOENT when the root
>>>>>>>> LRU is empty, which means the total pages are already below thr. The
>>>>>>>> loop then safely bails out via the zswap_total_pages() <= thr check.
>>>>>>>> For any other return value from shrink_memcg(), the loop is guaranteed
>>>>>>>> to terminate, either after MAX_RECLAIM_RETRIES failures or once the
>>>>>>>> threshold is met.
>>>>>>>>
>>>>>>>> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>> Suggested-by: Nhat Pham <nphamcs@gmail.com>
>>>>>>>> Acked-by: Nhat Pham <nphamcs@gmail.com>
>>>>>>>> Acked-by: Yosry Ahmed <yosry@kernel.org>
>>>>>>>> Reported-by: Yosry Ahmed <yosry@kernel.org>
>>>>>>>> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
>>>>>>>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
>>>>>>>
>>>>>>> Patch 2 doesn't really depend on this one, right?
>>>>>>>
>>>>>>> If that's the case I think this can (and should be) picked up
>>>>>>> separately as a hotfix. Andrew, WDYT?
>>>>>>
>>>>>> Please update the changelog to clearly describe the userspace-visible
>>>>>> effects of the bug, thanks.
>>>>>
>>>>> I am not entirely sure if my understanding is correct here, but maybe I
>>>>> should add something like this to the commit message?
>>>>>
>>>>> When cgroup_disable=memory is used (or with CONFIG_MEMCG=n), the global
>>>>> shrinker fails to write back any pages. Consequently, the zswap pool
>>>>> fills up to its limit and rejects further storage, preventing memory
>>>>> pressure from being offloaded to the backing swap device.
>>>>
>>>> I think you can simply write that zswap writeback when the limit is
>>>> hit is broken when memcg is disabled.
>>> Will do. Thanks!
>>>
>>>>
>>>>>
>>>>>> Also, AI review has flagged several possible issues, all appear to be
>>>>>> serious:
>>>>>>         https://sashiko.dev/#/patchset/20260714081510.16895-1-jiahao.kernel@gmail.com
>>>>>
>>>>> For AI review comments on this patch:
>>>>> I suspect this scenario might only exist in theory. For zswap LRU to be
>>>>> empty while zswap_total_pages() > thr holds true, it would require a
>>>>> prolonged state where there are always more than thr zswap entries on
>>>>> the zswap LRU whenever zswap_total_pages() > thr is evaluated, yet the
>>>>> zswap LRU happens to be empty during shrink_memcg(root_memcg).
>>>>>
>>>>> If we want to fix this, perhaps we could do something like this?
>>>>>
>>>>> Yosry, Nhat, what are your thoughts on this?
>>>>
>>>> Do we need to do this? The last paragraph in your changelog explains
>>>> why this can't happen because zswap_total_pages() should be 0 in this
>>>> case. Did I miss something?
>>>
>>> The loop would require the following sequence to repeat indefinitely:
>>>
>>> 1、zswap_total_pages() > thr evaluates to true.
>>> 2、During shrink_memcg(root_memcg), the zswap LRU is concurrently drained
>>> to empty.
>>> 3、Before zswap_total_pages() > thr is evaluated again, the zswap LRU is
>>> heavily refilled such that zswap_total_pages() > thr holds true once more.
>>>
>>> For our case to manifest, it would require zswap_total_pages() and the
>>> zswap LRU state to repeatedly hit this exact window with perfect
>>> alignment over a **prolonged period**. Therefore, I suspect this
>>> scenario might only exist in theory.
>>
>> Yeah seems very artificial indeed.
>>
>> If we want to be extra careful here, maybe we can put a cond_resched()
>> there or replace the continue with goto resched or sth?
> 
> I think it's also possible with the current code with memcg enabled.
> It's still possible that the shrinker puts usage under the acceptance
> threshold and then a new zswap stores puts it back above the
> threshold, and so on.
> 
> Perhaps as Nhat said, just goto resched instead of continue if we're
> really worried, but I think even that is not really necessary.
> 

Yes, but to be strictly rigorous, let's add a goto resched; anyway.

Thanks,
Hao

> I think we generally want to clean up and simplify the shrinking loop
> in zswap_shrinker(), but I don't have any great ideas.
