Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2D3F8EB7
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816690; cv=none; b=MrtjHLYQdIZZ4WJY65ONsIFANfc59Blu/pbG7OKJHLKfwEznsttIDtIg0r9x7TR2A6LdZbFWLL4aNV4XHCOcG+NxA6qJ6CsCEQLloORoLNb6ob3tUcIXav2cKTtceM2ZUwzS4tzGvpjlBVR4TBI/aG8pvzmKHOcApSWm/vvjKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816690; c=relaxed/simple;
	bh=sABWBCPSix0Ac0AzPgCOi8BFXz2KuAhR+MoVhVTMzps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHhxkMqhmbomEDdI9l7rz1l75/pP9wpxUnGAGUNEeWgWlVGtmORf1FqZe5hPww7xXKcnJ3oReJhPes0Wf4WLUyZF/x4ybe5vQo5+Gv4GxqvjJV7RgnzSP4ExPz3QfdlkBHmeq4DZq91YixpF07jG2GuRuFbVdtnOeI/pTjy51SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQ+mzJRw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ+mzJRw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c9b42be8feso25140905ad.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782816684; x=1783421484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOCmAhk2QZilrROnFdYyZ9E7NHFNJQbLWBKSgKarjZM=;
        b=bQ+mzJRw/1C86mnD7zXv7koQo/fphihKfKRDqtawV+u0xAsDGGvllS9y++8uQFrMu1
         FfKdlCZhQIBHKYk3ddAKHhBgVgDTUAY1H8ok5Fc0d6Qkl0seOdRwDiSiYHpW1qls08n4
         TY2ocytRZJpu77tgFW8TI6h3xursK2HhgZdUhFsmrdVDyIXTWlvqMiVXqjH7Kce88bSR
         duzMHmJRiXjLIIpJcfqEYc36TVA2+jVPO9T0od5quA9VFYLtdLCRbdQ81+W9m3MlD8lh
         odJGxYtZvnjwXr4r4q9iLX8Ta4iVE2OnTdnZEGpWYgWVqgiccpP74nfjUUUKRWnEjA76
         lWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782816684; x=1783421484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOCmAhk2QZilrROnFdYyZ9E7NHFNJQbLWBKSgKarjZM=;
        b=XSL3G0sfWo3D21tLmRbPI5VvEfVuhnSZicZNMAR/mA4V9gSFIllmdb1rc+mdypojLp
         hKS8pyDdA+I6x12Sv+E+EdL4f9WVng384eG7/cm+9DTcIEOYHJ5Mpr6eTnSzLwUbreCE
         zaDo5f7Jb9RrzGiLWUmOFX+kcrYDVMf6yR8NK8XAmQNYQ8qCV2db9I8WMYaZDMj/HJmR
         ZdPLVxRa3b/A0FAVyd0rO+IwEsWWgwOc+otaLFVdgeb7ZTORubC/0HH11dAs53hwCmXj
         i9DACmZRhyuPjh6PZwjuuXcr9ZDOUsWBGPK37hLofWPOA5tJEOnXIDdPuClizJRHTgbw
         sGKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGLAppjSOTCYxQbJr0c1fCu5B9BMGmcBf+OlJLsN1h1C2H3t6A59bMQ1BWv7dlNvZc9qVkBqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9mnmj3sKOuud+oTfSRYYmJanqwLgukdK+OZf0VSom/aP1jZPK
	i6pZr2Ltdh+wRgjRshcN1i/NIrczwPgk9JBqBhkuP/39kA/EiD3k5bO09R5ZbQ==
X-Gm-Gg: AfdE7clxj5RkPtYxW2Q78c3gewHVRZ8+f0t1r2oV9bDAMxVKNMAqaqGFAh8wTs8RPG9
	loDKQyUzlpwyPsdQyV0aiVEeWM/pL5vLmXtssy7m0cNnvuS9DkemyMd1ll8iFNz1fmGiuTlwhgs
	R7ZdNhpy/Px4Cl+peWVOMMYGWG7vB3Xrrq7aO9pzTiL+j/Q0mC4SlrCOSJGRVXJbMaEmU+QNgRh
	ko4Djgg/mxme/ASgJ41VBkUn2nElhq8tZX7R2UZ3Q4HcIxAvtG0h3PgKkjmN2DeSFWlwxnlUVMS
	UNG7yeZjiJV0h0Xutx0/clCDXTRGSvmWOF9hMobm/QEnYQlsjs0uXjFv6sw/cKVuIs1+aLnQlvo
	g78PASSfJQAnTUSmpWysDjJqFuUy3xJGxu+9NylTjWQBCbM8Bn6/RofrwtTe28GuGVXQXooba+h
	u3Vzcc4uPAzVghJZmrpquWYxT+fV5E3wwN
X-Received: by 2002:a17:902:f68e:b0:2c2:bd7f:ccd4 with SMTP id d9443c01a7336-2ca2d56ab0fmr23156785ad.21.1782816683996;
        Tue, 30 Jun 2026 03:51:23 -0700 (PDT)
Received: from [10.125.192.77] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca3828c950sm10687625ad.51.2026.06.30.03.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 03:51:23 -0700 (PDT)
Message-ID: <fe15eb9f-0b6c-dcaa-d0a7-5f08c3f92bfb@gmail.com>
Date: Tue, 30 Jun 2026 18:51:14 +0800
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
To: Nhat Pham <nphamcs@gmail.com>, yosry@kernel.org
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
References: <20260629112032.20423-1-jiahao.kernel@gmail.com>
 <20260629112032.20423-2-jiahao.kernel@gmail.com>
 <CAKEwX=MniM-4-aV17aH3UiDd_Xd2RH743fFZaxEnYX9qvnokeA@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAKEwX=MniM-4-aV17aH3UiDd_Xd2RH743fFZaxEnYX9qvnokeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/6/30 02:37, Nhat Pham wrote:
> On Mon, Jun 29, 2026 at 4:20 AM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
>> Therefore, the global shrinker shrink_worker() always takes the !memcg
>> branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply gives up,
>> so it fails to write back anything.
>>
>> Therefore, when memory cgroup is disabled, fall through with the !memcg
>> branch and shrink the root memcg directly. Stop the loop once
>> shrink_memcg() reports -ENOENT, since the root LRU is the only target and
>> -ENOENT means it has been exhausted.
>>
>> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
>> Cc: stable@vger.kernel.org
>> Reported-by: Yosry Ahmed <yosry@kernel.org>
>> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> 
> Ah good catch.
> 
> 
> 
>> ---
>>   mm/zswap.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 761cd699e0a3..0f8f04f22888 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1356,7 +1356,12 @@ static void shrink_worker(struct work_struct *w)
>>                  } while (memcg && !mem_cgroup_tryget_online(memcg));
>>                  spin_unlock(&zswap_shrink_lock);
>>
>> -               if (!memcg) {
>> +               /*
>> +                * Reaching a NULL memcg means a full hierarchy pass completed.
>> +                * Exclude the memcg-disabled case, where it is always NULL, and
>> +                * fall through to shrink the root LRU directly.
>> +                */
>> +               if (!memcg && !mem_cgroup_disabled()) {
>>                          /*
>>                           * Continue shrinking without incrementing failures if
>>                           * we found candidate memcgs in the last tree walk.
> 
> nit: I wonder if we can just merge this comment with the new comment
> you just added.

Updated. Please see below.

> 
>> @@ -1378,8 +1383,15 @@ static void shrink_worker(struct work_struct *w)
>>                   * with pages in zswap. Skip this without incrementing attempts
>>                   * and failures.
>>                   */
>> -               if (ret == -ENOENT)
>> +               if (ret == -ENOENT) {
>> +                       /*
>> +                        * With memcg disabled the root LRU is the only target, so
>> +                        * we should abort if it has no writeback-candidate pages.
>> +                        */
>> +                       if (mem_cgroup_disabled())
>> +                               break;
> 
> Hmm do we need to do this? Consider a system with cgroup enabled but
> with just one cgroup (root?). The behavior would just be trying that
> cgroup for MAX_RECLAIM_RETRIES failure attempts, correct?
> 
> In that case, we don't need to do this check, and we would get the
> same behavior. The loop would terminate after MAX_RECLAIM_RETRIES :)
> 
> Could you fact-check me? :)

Exactly. When memcg is disabled, shrink_memcg() returns -ENOENT only if 
the root LRU is empty. An empty root LRU implies that the total pages 
have already dropped below the threshold (thr). At this point, the loop 
safely terminates because of the zswap_total_pages() <= thr check. In 
all other cases (where shrink_memcg() returns anything other than 
-ENOENT), the loop will eventually exit either by hitting the 
MAX_RECLAIM_RETRIES limit or when zswap_total_pages() <= thr.

How about something like this? If there are no objections, I'll fold 
this into the next version.

     mm/zswap: Fix global shrinker when memory cgroup is disabled

     When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
     Therefore, the global shrinker shrink_worker() always takes the !memcg
     branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply 
gives up,
     so it fails to write back anything.

     Therefore, when memory cgroup is disabled, fall through with the !memcg
     branch and shrink the root memcg directly.

     With memcg disabled, shrink_memcg() only returns -ENOENT when the root
     LRU is empty, which means the total pages are already below thr. 
The loop
     then safely bails out via the zswap_total_pages() <= thr check. For any
     other return value from shrink_memcg(), the loop is guaranteed to 
terminate,
     either after MAX_RECLAIM_RETRIES failures or once the threshold is met.

     Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
     Cc: stable@vger.kernel.org
     Reported-by: Yosry Ahmed <yosry@kernel.org>
     Closes: 
https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
     Signed-off-by: Hao Jia <jiahao1@lixiang.com>

diff --git a/mm/zswap.c b/mm/zswap.c
index 4b5149173b0e..9d4f19fc440e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1361,11 +1361,12 @@ static void shrink_worker(struct work_struct *w)
                 } while (memcg && !mem_cgroup_tryget_online(memcg));
                 spin_unlock(&zswap_shrink_lock);

-               if (!memcg) {
-                       /*
-                        * Continue shrinking without incrementing 
failures if
-                        * we found candidate memcgs in the last tree walk.
-                        */
+               /*
+                * A NULL memcg ends a full hierarchy pass (except when 
memcg is
+                * disabled, where it is always NULL: fall through to 
the root LRU).
+                * Count a failure only if the pass found no candidates.
+                */
+               if (!memcg && !mem_cgroup_disabled()) {
                         if (!attempts && ++failures == MAX_RECLAIM_RETRIES)
                                 break;

Thanks,
Hao
