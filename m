Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061DE35C689
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973455; cv=pass; b=KyVBtz8QgAGiZ6GdgUcncVkpXi+xWgtAxZXI0DkFmvXVKmcDpgAbSoiVktfAI9z26QB76k1QyYIuOli9zrjp0OhDpY+tc9yHS8qIypkewrrMANvcwK/sZNsoEIJ+/iWQZVcYIPhMMfLfC6JKzYlBiZz+aec7cMuLeF1RgXxLKHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973455; c=relaxed/simple;
	bh=h69Ep7x9kW9YEWONODwlFjRxgb84inWblBh92cqQIJA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNMJevdAuL5EGvMlyikJfyY92BX6zohH+DY3JucrEJs2w+kmc7vScRp8SlNAqiZXIVunqNgh9NG7c0OOVx9/jyMpQD5yez1VG1TK9me2x1mS0ov3g/V7xA/1TEi7h3/hXoBGxEI6sgYbLPj6skoGv2cvYWjHUOvr9LmHtN0vcEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKbVAd7i; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKbVAd7i"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6bd209cf210so1085552eaf.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 10:04:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788973453; cv=none;
        d=google.com; s=arc-20260327;
        b=Ix3vB1M0qxPyz+UcCOwkXDcwSuUCRMB1a+dnqPDIW3hobPzScuua7Y9vgWZZyNo37m
         Z4cm/OYRHbAU4Ch/Pn1GstPiulXKT4RUTMtjTw75I8A/3T65vXo6HcGFXs63ZSGASqiz
         vwwSw1pDwaO9XZgyA4+mNDu4d1PmAfUjJESqvH+YdstQMYuJ8z0BsOOHie2E0iMKvuU1
         5MXPANweZUcvNwlAuTyI3g54VQfygWeLIZnfanHXEekTusKkwN2a31bfCJq0kHiKrf9K
         mH0m6WFkuD50tagJuaBSjw0Z1KBMkJAAw0QqZ8yqm9xBlmV/jjJU7n1KXHweUO8U3AdR
         jBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=A/3n7+l6Hk+FAEPnBkeK4yLp6nphYfaKQMZLPlsMb2I=;
        fh=b83t1VAQ32pVE0shWX2sbvSmGwJkgY4XJjKR/p1pWpI=;
        b=DohqVXzmb7qmjJmiYbsuaLoNCUVc+4wZvw0U5e/fvzPRH8ABBy/rp/lrSdhQmJC+YB
         xAhyOvmRm6zlbxwBbMgrSTjmtYVz2VNXO/gMRGxN34gPfQpu0HxhsRIz+bwyhrstcY8n
         oiuMLBKAZlRcM9hNyXZQ3J0nVOaG+OhZ6tdMzjT7+Gaemo3xdrdKc4lM0pZStmjReRa3
         /2JQL2sgDbCSe+1Uo2r9YVH98k0BasgA89MUk9GL2zg7GmMS21wvCLeQYPXYRfFj8owq
         4fM9Gqa0xApbCwx1EGFvDO13VtRiHnCLnf7WaKLSNraigVyhKy/it5QUMkx1TgRwyMHr
         /H2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788973453; x=1789578253; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/3n7+l6Hk+FAEPnBkeK4yLp6nphYfaKQMZLPlsMb2I=;
        b=pKbVAd7imBHA/x9dCs5p/r92xsxgd3r9nxslzOEyMlr7f7Cj9hHPQiK/ZmGxB1oTVU
         rxFJbGf3FpjlmHUh+dlyXL8ORQPFbad7WS96PH/awpUHKXF6U9FpBjetvs4pd3OvCO2M
         Dcgf+wttL4/Z82aScR0ES4CbTWw0B9+6hE6zXS/j8UOSS+J4hutNGPOuBsudsEzGHEIK
         GpXd/tBk0AgVBM5h7SMZDzaTob2Kg2CmAab/steu9i4z1aJIWjJLDj6FkPNoShcJ0eZx
         7tq9KVTjDr8Z/wjLcCzrgifur6qW8L3ghsnwgnAJ2kDiSTOeQNmQ4zDQlcDEi069lS/f
         LGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788973453; x=1789578253;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/3n7+l6Hk+FAEPnBkeK4yLp6nphYfaKQMZLPlsMb2I=;
        b=REsWnh/XahVxeu92gvNeRqunqK4iA+9XiwdZzNPnv2rebMQTP0JdP9gZAjJM4kT6lJ
         pQnpepTDijUMdZ92xf67Gl6hWpK1XuJf4JaMMDcVKS8v5dKwowyFkLpL4wQCD7U26l6S
         62IRgumE4ylXfoKGzmW9/rR/BmXnQN9G7k7knVUVr2+GU5vHYChEqvwzqyq3bRH7beGK
         /XWMKndwDAryArBATp8uXqoHjygJpOMInEao7dli5E3EDNDHUVI1avkcalpAw0PtWOWq
         Wwce7OcBRDdbjmJbYWDo2mrN4w8k57jB11mnfnk8ZEpZ/HOQdjAOhP5GnjyvRx5yFbBY
         lHOA==
X-Forwarded-Encrypted: i=1; AKwUvBz/d4hAKRLqhkSILabdNvuqlT3txFZV6yZouOtBUG3LkjHO7Bfq3FG1Mnv/SJZ11+8JmKo+4IM=@vger.kernel.org
X-Gm-Message-State: AFuF++m/1otOfqEQThnVk0Z2/+tkizmI+JbqDW3CkMuOna41xeTT5d4C
	m04qqaK2X+7FyNCHsAmtCq5SMaXpA6RmOGHUfhwPbvuIoWo2uNPxDAYQ2jjq9km/cqGtrUynk1X
	to5NUMwUKTmvx2gf9r4uVYxv/UmXpaMpvAFBjvNu8
X-Gm-Gg: AYBFou2AFvW7/VcHz4BUWlTrBl3tXWMeVTSxSj7QxTBQNXE1oKlCDz810Nl09RbaHbk
	ydj+rR+ElSq9yhNZE3Ahl2xhvLpA1WSbLIuVh7uTwBEMqyAOCSfSXVyBUw3uvS2USW+9ASqDLT8
	VnK56lzGbccCB148Ohhmag3Bv4ylnFclHe8rqkoWYjGkUj5bfRtk1M20qNBXudEM52tu3vxUDIh
	/Ixqp2N6/Jyz3q7V4vUwNxRkeQsEdkbIUbso2u9YFTEfstlRKKdR3jEmG6bQxwA4T3e0mw793xu
	y+CBia3NawcY+LbOg7uuJ2R02+XrL6bqjntklUJ7N3cw37PWWhxgXXaddAJOpi8ItQi/GO3zUS1
	uUcBZD/HjpaI=
X-Received: by 2002:a05:6820:1c82:b0:6b1:6c44:d3b1 with SMTP id
 006d021491bc7-6b6fa8dca94mr19436135eaf.2.1788973451595; Wed, 09 Sep 2026
 10:04:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 10:04:09 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 10:04:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260904171412.191180-1-joshua.hahnjy@gmail.com>
References: <20260904171412.191180-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2026 10:04:09 -0700
X-Gm-Features: AcwNN1V_OL5b4rKvClN1gT5AOJG1MUC1dn0rdqBCDNzmXm8Bb2nF-U4o4S_9uzM
Message-ID: <CAEvNRgFfSJzvhrO7gEs1DVYV9ES0xjBtGJgqruFo-hSKUSnNZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: hugetlb: Return -ENOSPC on memcg charge failure
To: Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hongxiang Lou <louhongxiang@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, jthoughton@google.com, fvdl@google.com, 
	rientjes@google.com, vannapurve@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
	Yanteng Si <si.yanteng@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Wed, 02 Sep 2026 01:22:56 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:
>
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> When mem_cgroup_charge_hugetlb() fails with -ENOMEM, alloc_hugetlb_folio()
>> currently propagates this error. This results in the page fault handler
>> returning VM_FAULT_OOM.
>>
>> Because HugeTLB allocations are high-order and use __GFP_RETRY_MAYFAIL,
>> they bypass the OOM killer. Returning VM_FAULT_OOM to the #PF handler
>> without triggering the OOM killer (or having it make progress) leads to
>> an infinite loop of retrying the fault.
>>
>> Avoid this loop by returning -ENOSPC when charging fails, which maps to
>> VM_FAULT_SIGBUS, terminating the process cleanly.
>>
>> Make mem_cgroup_charge_hugetlb() fault handling use a common error handling
>> path, the same handling used for hugetlb_cgroup_uncharge_cgroup{,_rsvd}(),
>> which also don't trigger the OOM killer and hence opt to terminate the
>> process with a SIGBUS.
>
> Hi Ackerley,
>
> I hope you are doing well! IIRC, this is the same fix as the one in
> [1] (in spirit) right?
>

Yes, it's the same fix as [1] in spirit.

> I prefer this change since it is more obvious that we return
> -ENOSPC right there and then. Since this is a fix please feel free to
> add:
>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>
>> Fixes: 991135774c0e0 ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  mm/hugetlb.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 7857728457952..01b57f6d3b804 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2823,7 +2823,6 @@ void wait_for_freed_hugetlb_folios(void)
>>   *
>>   * Return: A pointer to the allocated folio, or an ERR_PTR on failure.
>>   *         -ENOSPC if cgroup charging fails or no folio is available.
>> - *         -ENOMEM if mem cgroup charging fails.
>>   */
>>  struct folio *hugetlb_alloc_folio(struct hstate *h,
>>  		struct mempolicy_interpreted *mpoli, u8 alloc_flags)
>> @@ -2896,7 +2895,18 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
>>  		 * were committed to the folio and freeing the folio
>>  		 * would have cleared those up.
>>  		 */
>> -		return ERR_PTR(ret);
>> +		/*
>> +		 * Return -ENOSPC when this function fails to allocate
>> +		 * or charge a huge page. If a standard (PAGE_SIZE)
>> +		 * page allocation fails, the OOM killer is given a
>> +		 * chance to run, which may resolve the failure on
>> +		 * retry. However, for HugeTLB allocations, the OOM
>> +		 * killer is not triggered.  Returning -ENOMEM (or
>> +		 * anything resulting in VM_FAULT_OOM) would leak to
>> +		 * the #PF handler, causing it to loop indefinitely
>> +		 * retrying the fault.
>> +		 */
>
> NIT: I do feel like this comment block is a bit verbose, though. We just
> want to explain why we return -ENOSPC rather than -ENOMEM, maybe we can
> just explain that OOM killer not triggered --> retrying is futile?
>
> The change itself looks good though : -) and I don't want to block the
> fix. We can change the comment later.
>

Got it, please see v2!

>> +		return ERR_PTR(-ENOSPC);
>>  	}
>>
>>  	return folio;
>>
>> --
>> 2.55.0.970.g62bdec98f9-goog
>
> [1] https://lore.kernel.org/linux-mm/20260720-hugetlb-alloc-failure-fixes-v3-2-7d2a169aa9ee@google.com/
