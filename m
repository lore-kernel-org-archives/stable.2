Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C08191F98
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 00:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783038937; cv=none; b=dkhhpSbC0XixJGgpWsvPGuKhJ1k7Ntry1pazrwAOsIwQoYA2jE/QMEffQcQA3w/J3kAiLlYgIBK6tVuktiLBpsqA7zbN1h6d3Z9iOXFmXaYWnSh5lWPkQldFreNQg8fOUIXPXXXIOESQ1yZhfL8LgJiSlKSYf+42P7XPb/R0EeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783038937; c=relaxed/simple;
	bh=tjlMg3vbd6bkZXTjP8i7YIy2MVX34BXxO27eFKDACrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIPVanhd3Q06PRQ8MFEX4KZ14SWWVO2LFS6zKgaoaniGnpcWZTLlm320BwS7XkZ1mMR183q3m480AK/XCS3cjtL8wkJhr89b+PvMGTucaRBHf3I3C1PedLuGsXqec2v9lkd7+UgZ66jblhmXNvxdpQNy3IxwO0oQGw3HzLAMtnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xit4BLmP; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xit4BLmP"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e501244f5so1026285a.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 17:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783038935; x=1783643735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhuPZo9By9WeOKbnJZiXCMtpI4vqAR0qLJD+1E3bLpo=;
        b=Xit4BLmPlm8jQc7xlEVEUs8yPN4GZViWCnqS9Fzrg9o2yiwNFFHDTSaaEgGxsuV6fW
         Mnp3wNB9kiW+4XvUlhJi5dRQM1ylbOtCnpl/orSdkB5UqZ+Px+Vkv1r6rMJ0wLjlu+++
         wJ0FBpOnE+/IzOoaKFSUp1Km28NJFGMECZ/bJqBneHw+bRSv9ah1u5pcpNQrNZHrtQE4
         rDLA7Qa1f2DbpidzQs7owkefl1Atv5PRtBfRftTH2SC9yX2Mp+8cryQexUwiskZWFWgn
         QNZId2/B7Zk259Rd7PrPyGOAGNfq6vmXTlcElTtPcEZitILk2sBl1G731t67yZ8Aw1Re
         JNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783038935; x=1783643735;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhuPZo9By9WeOKbnJZiXCMtpI4vqAR0qLJD+1E3bLpo=;
        b=r7XRbx4u4OiRyPo/wMMBQQO3RgntDjb9NB/3Rn/Gk3/1Mg8zgVC4tdutwvLyOzUO4/
         VdCS5oG0VoJpSlZ7ZLTJuBs+Sou9ZDh8z9oOMG0S7MV7w4HGL12NBhUR9LeUZO0SFKOl
         C8lVu151ris/u/sl4o9SeMKIgIxqis2KYOcX8vJG5glg9OD2Eg9P8kmZgV8kWWup6LJk
         jCLS+pirKYNbJ6kRm6b2NLur2dIsMQ3oqsAQ8MSNHemB8JFsyRKSli43qS1wK2grVrW+
         krOnz8t5+VxoTP6kh3RvVFuGfqlFSqWmzDvq+kiPH7K6HgqzB8n5DBERb5g65Kwx+C8V
         b/gg==
X-Forwarded-Encrypted: i=1; AFNElJ+WMPKtjNcLSjPL1mkS6CLd5IAsS4eylStUzMw0vIVbG6Yqb3qugbZK4DKvxqbWtP+af3A/5eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmEm7Olv1qiFNqGDmnMbL112cRNWetsxX7XwXdvEGtRhDz6Qp4
	os2RwpZI7eP6Qw5t7ViU5tSLDKzpYsW7CJSC8cwYIPxYzRzQDPgHT1VH
X-Gm-Gg: AfdE7clnZb16KhvG65DZHNEDkzlt+29amFPxk+hoJX49Ak6/MY2guoA3wermJYS3BY8
	EtriQc23clktVnZ2AtR1k+uUSSJg3he1MvZQ0PJ7/WC3Q7W1KfjAxsh0U5ykmx/JI92QiBDM2jD
	VfUBUg6SLYAqDaRyx9T9FO/7P9FYfAA033cd/W21Qdu0O5sbrTgg4/lcKcgAUqBL9eoRxN8dAPB
	e5Li20u7ErnkAwmuOBDjT1KlPJOd7QWHpBNNzZOnjZycb3nooFVt3Od5yS69pe/4RhV0D8r0kuT
	KGXQhQPCpOHyLveVG9+rMgybStQduHoHHyL81gl6y6GDL5Wh5v81pbikVwAHI2zDwuRSG4zbaDl
	KrowQhd7HHiLXup0m0+YeLp47fdY4Nqw61Cu9nxIeThL+jYjLFu+c1TUIudsM74giusPXg+Pxih
	qkoRNagvPvuDeuJmxVow==
X-Received: by 2002:a05:620a:269b:b0:92e:675e:8ef0 with SMTP id af79cd13be357-92e7b473cfbmr986657085a.68.1783038935434;
        Thu, 02 Jul 2026 17:35:35 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.73.95])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-92e9095e780sm23952485a.0.2026.07.02.17.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 17:35:34 -0700 (PDT)
Message-ID: <edcfd337-2cba-49da-a77e-3a2f8aa67e4c@gmail.com>
Date: Thu, 2 Jul 2026 20:35:33 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu/buddy: bail out of try_harder when alignment
 cannot be honoured
To: Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, stable@vger.kernel.org
References: <20260629074311.68836-1-Arunpravin.PaneerSelvam@amd.com>
 <a4657daa-c58e-4441-ad81-c3e770bc5a94@intel.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <a4657daa-c58e-4441-ad81-c3e770bc5a94@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/2/26 6:48 AM, Matthew Auld wrote:
> On 29/06/2026 08:43, Arunpravin Paneer Selvam wrote:
>> The try_harder contiguous fallback could return a range whose start
>> offset did not match the caller's min_block_size. When a candidate's
>> start is misaligned, realign it: free the misaligned run and reallocate
>> exactly @size at the next lower min_block_size boundary. This keeps the
>> returned size unchanged with no surplus to trim, and rejects the request
>> only when no aligned candidate fits.
>>
>> v2: align misaligned candidates down to min_block_size instead of
>>      bailing out, for both the RHS and LHS paths (Matthew).
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>> Cc: John Olender <john.olender@gmail.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> 
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> 

I haven't hit any issues with this revision during testing.

Thanks,
John

>> ---
>>   drivers/gpu/buddy.c | 63 +++++++++++++++++++++++++++++++--------------
>>   1 file changed, 44 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index dc81fe0301ce..3c73ae87f3c5 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -1118,22 +1118,30 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
>>                    blocks, total_allocated_on_err);
>>   }
>>   +static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
>> +                    u64 unaligned_offset,
>> +                    u64 size,
>> +                    u64 min_block_size,
>> +                    struct list_head *blocks)
>> +{
>> +    u64 aligned_offset = round_down(unaligned_offset, min_block_size);
>> +
>> +    return __gpu_buddy_alloc_range(mm, aligned_offset, size, NULL, blocks);
>> +}
>> +
>>   static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>>                        u64 size,
>>                        u64 min_block_size,
>>                        struct list_head *blocks)
>>   {
>> -    u64 rhs_offset, lhs_offset, lhs_size, filled;
>> +    u64 rhs_offset, lhs_offset, filled;
>>       struct gpu_buddy_block *block;
>>       unsigned int tree, order;
>> -    LIST_HEAD(blocks_lhs);
>> -    unsigned long pages;
>>       u64 modify_size;
>>       int err;
>>         modify_size = rounddown_pow_of_two(size);
>> -    pages = modify_size >> ilog2(mm->chunk_size);
>> -    order = fls(pages) - 1;
>> +    order = ilog2(modify_size) - ilog2(mm->chunk_size);
>>       if (order == 0)
>>           return -ENOSPC;
>>   @@ -1149,31 +1157,48 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>>           while (iter) {
>>               block = rbtree_get_free_block(iter);
>>   -            /* Allocate blocks traversing RHS */
>>               rhs_offset = gpu_buddy_block_offset(block);
>> +
>> +            /* Allocate blocks traversing RHS */
>>               err =  __gpu_buddy_alloc_range(mm, rhs_offset, size,
>>                                  &filled, blocks);
>> -            if (!err || err != -ENOSPC)
>> +            if (err && err != -ENOSPC)
>>                   return err;
>> +            if (!err && IS_ALIGNED(rhs_offset, min_block_size))
>> +                return 0;
>> +            if (!err) {
>> +                /* Allocate the unaligned RHS offset using round_down */
>> +                gpu_buddy_free_list_internal(mm, blocks);
>> +                err = __alloc_contig_aligned_retry(mm, rhs_offset,
>> +                                   size,
>> +                                   min_block_size,
>> +                                   blocks);
>> +                if (!err)
>> +                    return 0;
>> +                if (err != -ENOSPC) {
>> +                    gpu_buddy_free_list_internal(mm, blocks);
>> +                    return err;
>> +                }
>> +                goto next;
>> +            }
>>   -            lhs_size = max((size - filled), min_block_size);
>> -            if (!IS_ALIGNED(lhs_size, min_block_size))
>> -                lhs_size = round_up(lhs_size, min_block_size);
>> +            if (size - filled > rhs_offset)
>> +                goto next;
>>   -            /* Allocate blocks traversing LHS */
>> -            lhs_offset = gpu_buddy_block_offset(block) - lhs_size;
>> -            err =  __gpu_buddy_alloc_range(mm, lhs_offset, lhs_size,
>> -                               NULL, &blocks_lhs);
>> -            if (!err) {
>> -                list_splice(&blocks_lhs, blocks);
>> +            lhs_offset = rhs_offset - (size - filled);
>> +
>> +            /* Allocate the unaligned LHS offset using round_down */
>> +            gpu_buddy_free_list_internal(mm, blocks);
>> +            err = __alloc_contig_aligned_retry(mm, lhs_offset, size,
>> +                               min_block_size, blocks);
>> +            if (!err)
>>                   return 0;
>> -            } else if (err != -ENOSPC) {
>> +            if (err != -ENOSPC) {
>>                   gpu_buddy_free_list_internal(mm, blocks);
>>                   return err;
>>               }
>> -            /* Free blocks for the next iteration */
>> +next:
>>               gpu_buddy_free_list_internal(mm, blocks);
>> -
>>               iter = rb_prev(iter);
>>           }
>>       }
>>
>> base-commit: 6648301c5bb2ef23f0fb15bcb01d21ff66f36799
> 

