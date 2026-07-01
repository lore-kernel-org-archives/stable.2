Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109883A1A3F
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898775; cv=none; b=N6H6eCbyrsd1Q6mnOYpNrVDGQCNg7eTauhTcovVYYOIIvYx0Rjx4CP7LkbeBy5vUskmsfLjisc5KVDYdCf/UakGIlsf7V06jsx40J4CTmgZvvO6Ax+o6yRywX01OyMiNZsqYqcoZQSHVbVZ/3roYn4f+lH7yjvK2CDJwBS/Rkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898775; c=relaxed/simple;
	bh=1E+cYhGlSjW1xiBWX7Lf4NQ3+nhN+zb1AQgSa0kzBzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ly/NMqCvsgbLnAmLYTIig7FtvVSjflu/hjt69MsuDckmy7lQJJyg9Mjvs0ZUaoutSPWKqr0P6sFFwiYnZQ64AFwwBXtHvGNrKrldJMUDvEzMVfXhJ4inJvmhGw7eTmINVY+T9fuv4e93XakBLWJ5jSd4286T3GxRJ10O5FRAhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gW/DFc23; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW/DFc23"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c9c1779fc8so1904795ad.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782898773; x=1783503573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oqs6VzWQewb1OvRu2nCVMyJUKa4LqJKmS9q20XGY1/U=;
        b=gW/DFc23F9TYT9Do92R/WcdUNB6zbEhcBEW0jNEn4qrK8ID4r3F5H3ExVN5s+8zy13
         pf2uL1VmetRAeCAlhmZ8w7tqPR0Am8DwLNiZPuGACXU59f0vR03ftDVSizgG9lDApWrM
         ARC4lnVLtu86yG6tCkUNmKr9uzEVrzERA7RK2Np8fdrZVKv9J3KnOXn90E6rXEMhbsvE
         eJ6yutBTCkWw6g5TjmqOSFQpwkzNDQYR7TBQbeAW2CGxrs7xEhPVJnsETIYvmv6RdQXt
         ISa7gY3cfUxi0Y5eGWH6tKvBFNzvawf0n0kbiuD/2+r+n2zayMV0252DdQWN4IgRKLMq
         sRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782898773; x=1783503573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oqs6VzWQewb1OvRu2nCVMyJUKa4LqJKmS9q20XGY1/U=;
        b=SbJ+bQiJxMbOVeE3aKMTueCIIlpsxTbfsgTYEq6AlEVooziKu5YSVVfdaXyeY44LAZ
         kSTsCGoNSb9V7ngDeHK5V4RpPTrZ5FSLOOp+AQOnuDdJRmaEaMcFKJNWp3kAy+r0DOHq
         fjpRfwqLU3e7+5ruScT92lSbMZNqbx6WuZ8b7CV30Tl9f1g6X/Vvk5BdD2vtTgQ+0uYM
         aUfjOBu7Lr4ZG0SxMO2IjulpdpIQ1yVU3VsK5j0jwIfKRj9xP9P38mvbOuhyqVzUuxPN
         /rLos8ny6mTE+qeSTPgfGHxcMwe0g2W0LwOAgnc+BINUUnaNmyvV9c4lkqekE7XxMig6
         /9Xg==
X-Forwarded-Encrypted: i=1; AHgh+RrBc1DiijVegPv4s9iMe1pqwzFt8bJmbW5StY0PnT52Xw3LeHvc0XUZKjN0H45gGrxCkFbjazI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0a9L7gkWbzr905/RdwDxxVfo4ZpaulG9pvTdWvFl4v9Ld+go
	Fx++0WyF4M8AteAJERutPPj+lW5eu4DHAEPio4iWO1SVEqUhvOXUJ4F3
X-Gm-Gg: AfdE7cmb1j57AUH7nNEmDfbuCQxbraklJf8tHlIIFawWZy8d9Oi7qBzLk+rP6M9VOta
	urCarGpPH+iuJ9xkf33m+iKfKnAHMBhj82S47yaawyzGHkS6XU+rKZEn/WGLrTpPQwQNpUFyYUG
	5n+HqUMXIvbos8wpbjuceSBYUN0i2pi4TLK7yrr7oKwEgLmt1ZeuEflRlm62/Svdfnnib4xBwLq
	KklhmyqsVk6vHWjY+5kkjZu9dbRNkiHMwYvsLL4+NPP/HnbNCT99KgP7ODDEpslWjISCrerW2oh
	WgMGFzr1aVYytcF+JzYfVtOcuMn6IO9zRBTGobANFtTjOfa0q6yr4H82CIIY1o2pzMQSHqutBut
	OqP6kS/b6iu+LtLNyZhoaoNnl83zBPcbIjX8N89DLgQH2rIN25Sl5LcHsuc6EuYzJyEaG+iOf+h
	DvrYkhMBGpldckB4qOGYUqlpaw6TLKC1U4
X-Received: by 2002:a17:902:da8b:b0:2c9:9a2e:dab0 with SMTP id d9443c01a7336-2ca7e71509cmr10989425ad.3.1782898773219;
        Wed, 01 Jul 2026 02:39:33 -0700 (PDT)
Received: from [10.125.192.77] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382acd0csm29148225ad.62.2026.07.01.02.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 02:39:32 -0700 (PDT)
Message-ID: <e2ec0924-52b3-25f3-8432-4b8e33a101dd@gmail.com>
Date: Wed, 1 Jul 2026 17:39:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v5 1/6] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, tj@kernel.org,
 hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>,
 stable@vger.kernel.org
References: <20260629112032.20423-1-jiahao.kernel@gmail.com>
 <20260629112032.20423-2-jiahao.kernel@gmail.com>
 <CAKEwX=MniM-4-aV17aH3UiDd_Xd2RH743fFZaxEnYX9qvnokeA@mail.gmail.com>
 <fe15eb9f-0b6c-dcaa-d0a7-5f08c3f92bfb@gmail.com>
 <CAO9r8zPBe9BPwP8NXz7pdH7T+8HLNsRAckL2Vfcnz0c23TH=iw@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAO9r8zPBe9BPwP8NXz7pdH7T+8HLNsRAckL2Vfcnz0c23TH=iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/7/1 00:02, Yosry Ahmed wrote:
>> How about something like this? If there are no objections, I'll fold
>> this into the next version.
>>
>>       mm/zswap: Fix global shrinker when memory cgroup is disabled
>>
>>       When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
>>       Therefore, the global shrinker shrink_worker() always takes the !memcg
>>       branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply
>> gives up,
>>       so it fails to write back anything.
>>
>>       Therefore, when memory cgroup is disabled, fall through with the !memcg
>>       branch and shrink the root memcg directly.
>>
>>       With memcg disabled, shrink_memcg() only returns -ENOENT when the root
>>       LRU is empty, which means the total pages are already below thr.
>> The loop
>>       then safely bails out via the zswap_total_pages() <= thr check. For any
>>       other return value from shrink_memcg(), the loop is guaranteed to
>> terminate,
>>       either after MAX_RECLAIM_RETRIES failures or once the threshold is met.
>>
>>       Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
>>       Cc: stable@vger.kernel.org
>>       Reported-by: Yosry Ahmed <yosry@kernel.org>
>>       Closes:
>> https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
>>       Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> 
> Feel free to add:
> 
> Acked-by: Yosry Ahmed <yosry@kernel.org>

Thank you for taking the time to review this.
> 
> A small nit below.
> 
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 4b5149173b0e..9d4f19fc440e 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1361,11 +1361,12 @@ static void shrink_worker(struct work_struct *w)
>>                   } while (memcg && !mem_cgroup_tryget_online(memcg));
>>                   spin_unlock(&zswap_shrink_lock);
>>
>> -               if (!memcg) {
>> -                       /*
>> -                        * Continue shrinking without incrementing
>> failures if
>> -                        * we found candidate memcgs in the last tree walk.
>> -                        */
>> +               /*
>> +                * A NULL memcg ends a full hierarchy pass (except when
>> memcg is
>> +                * disabled, where it is always NULL: fall through to
>> the root LRU).
>> +                * Count a failure only if the pass found no candidates.
> 
> I think "last pass" is clearer than just "pass" here?


Will do.

Thanks,
Hao

