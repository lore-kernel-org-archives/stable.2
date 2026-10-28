Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146461;
	b=xblJ6DcjLTBK1dl7av5Eatk3EKdvq29gEePU+lm7Fh49dXXEVjf8Rugy2egSwzHDHVyi
	 Gb4r9e+qVdVY4tY0LJ8CBT1sCCUNkbZcxcM0w7YysfkkfmG0A6ZdTpMeVzPrAM9q/W3iV
	 5RvR206NBBRp4sFI99m1b6vC9ozoQge/xSbM/k663/mFAjBhdzdXGra0+azcOmphonKgM
	 VGnX+ZMcnscQkiHU4ROekc1hMNSJkzW1YL6S3q6TGK/PvyNb68fTueSaF5n/MNpC4+65y
	 LCeSInK7J2j590KjYg3+ICwBUCbfnCaIQQA7tHWnI37LVB/U2B8l/zFcUXIqfTdKUTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146461;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=;
	b=EMO+xatj9q1RqmKztg+eS2FCt3EYtNK7JjygJhvqCc3ASjuMgivTeuMndrEqY44zmsfA
	 G6g6vCyYsSpg7XRNZ0kCOhucIXG8BjIXDMmdHuj3qB0hV+PcYpDhrSpUbMzgAKY4k67Ol
	 /vvZ56jTyWvO4lexpvT8zra5mEBzRAXXWqS+vdXip3LpDKfM5IXrsoMFghqXF9D8JR3n8
	 F48jG5+vQO9Z38aWwhyBy0CtZyKTVbS+hK1x1hxKVGJVI/EyS5l9Ua8skZ+8A1w8XKXIi
	 HKVpl37i9lbV1YQ0SfQo0r4P4Cz1WuQs0qCvzfvNQ11U3ZLzV5k+4Vu6PneO2bNumHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=lsovCs6I;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Q4NLyjW1;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AA606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 00:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 818AA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=lsovCs6I;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Q4NLyjW1
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RNsQHo2298975
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 20:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7p1u
	cq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=; b=lsovCs6IxaWMyufeHyab
	UGnNVfqeJNBrnilLDH1hmBBzIDO1Xw2PYSUP6AO5lBNUxpxEQbs+32FmrWqXgs2U
	tOPH30t80MNHG2qpSiuiuflnpzM+Fl8MrVaIQ/TzOQwsV3+8EA9G3C0UHn/qCG3Q
	PQj237pzIWWLwXlIO/8itmTx5LzX4mvdorMSSEhTUlDiVt+iAvZg3DPutnck/E72
	SD4t4EgnBW4hfXCWuhw5rDgUQrr386PNS4Nzie4yCvvMNEyT2eeHSzgksDyKzRBz
	69BiiAg+4Y9BSAZh6oP9aUSXMEnXOkAGEduwN+78Gc0cdd8YkiEvb2dw4F4cmelV
	dQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hk144jsds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 20:14:12 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91c7d79203cso4149336d6.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 17:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793146451; x=1793751251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=;
        b=Q4NLyjW19/i3ait1GGvuGUivPbsqagcGPGP+qWcDf7njdgRSJuYGwHwfXBRn6+WApZ
         u2dU/OtMje0X9b8UevuOY8/zp+xcTBSlA+AQPyXfpQIFvqXQkrx7HvxUuLeKu1xIjmOz
         kiBinAtDG9/rbdMBTxkVC2eZ+5y6Lcu8Hj86h5xFKIuiV8Oo+uj+Ulbj4qOr85BrMbkh
         EyxD2Q8Thz/bitPJU4cocw8Ol6X7hbw2JlkPyQ66x5sGjM+qvJmR/qMkUXyApTT34u/s
         sZcQJdUwxGiWQoZpZVBv/TUZjOGT3aT0Y0GxHW03AK0xQsXqWosKF43hPhwNOMY3TfSO
         p3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793146451; x=1793751251;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7p1ucq/Ny8UBz6ghlqYuLhKrCHyG8ylaL7otql1jOZ8=;
        b=i+ZOvtzLC/L2tJww8uk2ZI2p+WotAO3T5FCdS+EqNjmgvNNovad9XrsLDcfGYq1v1f
         zhgfLhGCDgB/fMWotBODXeOqV+fp4hN6PuvwDh0uhrwB+YKJaR11mmG++mDInmdrpyra
         oKon263NiH92cNVtBV5ctCUymv1nm4csh4C4b9AucYcyf/Lr+JIqUrtCqj2YGeGGkYOQ
         yhVF7tSxhDAUBl86lLkYkekCOGuI6yMs4SnvdD3hKPK9gIZ7zYOhSjwLERTAXdgdQqk/
         xgq3rP9hO2e4/okBhXLGbspIaT9tSlnBgJ5BhyXN3gtVj6z8ZRpFNXLnuIAn4ByPg5H8
         mtKQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+eGrQZcSk0NVTEHANfBGnRjUsqdV6Zi3w4I7TnU0oEUHIuCzdpcHkxclFfcXKgrr5GHlQ8xA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBKf/NE0kF1vlaKDEB9i6kwLA6oGGqcWbm+eiRDSJYjC+k+IRB
	wde2KoOQSMPp3Uo7t0HNDZHLgsuwCI51KDn5fS/owg0VNoXx+jN0UwcRe0Y01lvGlGRkBVYK8rq
	4Y4QweASFa8VOetTnajqI8Ji97WOOdUyou1hE1ZSRUdHqKV3Z6Bg0ZA==
X-Gm-Gg: AYBFou0wLo5hbcll4FR/fxZpU1p8Ne2k9pPjT95ZEZJMpHsD3qGEeXRMpkdpzV72bZ2
	TxCyUvuYa0uvmIJOTFIE650vZPTeMpRnD3atnPJGvXzqLRHKtLhtL9iyHiA+32BWlu8aMYgoMi4
	69fYh4yrayIKcy3IewjFEkvZpeIWCL6CknSEBvZDETiUYDDIP9iXZDy0tdIEHjJORcTnjzCpLDG
	BS7KrKrTUMBqAZcZeT1U3Lz0rsAsUGFYbDUHdEiFg/Md8ffmp/wtOLUZGW+XcaPpf8QzbuFi9dD
	A4PlsJHwatufx/45H2eoVMehUAG6ALLRK/4apreXT1JhGdOtKYpez88rzdQ9t4Bv3LyVv38oMU1
	AN2plpELivNkHLvXXM0P3HErWJK/XyjprhlYZUDIU7AiKQGlcqtoGdWfSNqwRsh07yEN2ChB5Z+
	SMS18ok5v3Sz5f7ewfDkTIWsgVoB3w/vInDih/EvdxLyUp8TonGWhhDgkjgHlfWLW1kf1RcDLZy
	SsULs7qHxas1ggmen9ySAvpOLd096bDiu9dFZdglLDb2kaZ6XoluLhwUVHk1abh
X-Received: by 2002:a05:6214:21e7:b0:91c:76aa:2c67 with SMTP id 6a1803df08f44-91c7d1aaecbmr12070786d6.39.1793146451424;
        Tue, 27 Oct 2026 17:14:11 -0700 (PDT)
X-Received: by 2002:a05:6214:21e7:b0:91c:76aa:2c67 with SMTP id 6a1803df08f44-91c7d1aaecbmr12069876d6.39.1793146450883;
        Tue, 27 Oct 2026 17:14:10 -0700 (PDT)
Received: from [10.206.51.58] ([129.236.225.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6d8103b1sm40645156d6.44.2026.10.27.17.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 17:14:09 -0700 (PDT)
Message-ID: <3c754c36-86de-44a6-ab3f-5c86e4bf83a6@columbia.edu>
Date: Tue, 27 Oct 2026 20:14:07 -0400
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
        Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
        Barry Song <baohua@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Baoquan He <baoquan.he@linux.dev>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>,
        Matthew Brost <matthew.brost@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
        Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
        Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
        Gregory Price <gourry@gourry.net>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yNyPZnFfS1eSqa_l0cT6n0fQtxANxpuA
X-Proofpoint-ORIG-GUID: yNyPZnFfS1eSqa_l0cT6n0fQtxANxpuA
X-Authority-Analysis: v=2.4 cv=DdaCOftW c=1 sm=1 tr=0 ts=6ae13e54 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=TdXXog4ttPu8yHJGq4T0ug==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=maIFttP_AAAA:8 a=_zromwrzjHPDTWxWFBQA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAwMCBTYWx0ZWRfX4HMF9GBAE2lQ
 wrueofDxHUboO1GCf7q4ehUX2ynfZEus3axn+wG5p+8LAYnkifMKll9AoAcc4obZoXc55H21Bt3
 Ar9w8OPasqyxRTmHcMC1/VhNI8jGG25i0Jm57lgRn9Uf+YVw1Wuh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAwMCBTYWx0ZWRfX65QX/ht1TZAh
 8dX75WANXfj5Nc30MTB7TgJkmAp1SRlCCXAhYGiTQIhe+R/6udy0k+K57wAR1bN4TDOD5l/xuaY
 73FNn1FoxCZAajPzaQZmueZ8NaNHoIuB+ZPti7cy2Bb/XSPgNOaUeokkNwVEuPkkfOVtOlHUsUj
 lgiWowyTFE2yq9YKm5gwjsjyq06FSNIWKVdsznUCnRFEXnSgyDf5iND4w6U9Ol0MM53BI8Nm4GE
 Hi3kKEdYxo0IwNCgW6egLMIHVqHwhJ1i56PvVpEf5/sroN9q68FLM2luSr5KGq5xv4kNzz7la03
 IYsMgYLXwjzq8PoH/jJPhKAatBk0837EYdu3kKxJi8nAeq2r3YSK7Ls0rRgbVAbHBGq//25T8Zg
 bcpJ39i+OfskN5vZhYJCaWiAxdTftLYRv98jCLY9F8QwIG2RveCbJMr0qEr0JTO5FlWzXQwRZ/3
 oMT+R5z79cpFepETbTQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11948
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=10 lowpriorityscore=10 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280000



On 10/26/26 7:17 PM, David Hildenbrand (Arm) wrote:
> Since the deferred split queue became a list_lru, the isolate callback
> moves the folios it took a reference on to an on-stack list, linked
> through folio->_deferred_list, and deferred_split_scan() takes them off
> that list with list_del_init() without holding the list_lru lock.
> 
> deferred_split_folio() does not know about the on-stack list. It only
> holds the list_lru lock when it looks at the same list_head, and it can
> run for such a folio: a THP is queued when it is mapped, as a candidate
> for the underused check, and is queued "again" when a part of it gets
> unmapped:
> 
>    CPU0 deferred_split_scan()          CPU1 deferred_split_folio()
>    list_del_init(&folio->_deferred_list)
>      next->prev = prev
>      prev->next = next
>      entry->next = entry
>                                        list_lru_lock_irqsave()
>                                        folio_set_partially_mapped()
>                                        __list_lru_add()
>                                          list_empty(item)  -> true
>                                          list_add_tail(item, &l->list)
>                                            item->next = &l->list
>                                            item->prev = tail
>      entry->prev = entry
> 
> The folio now sits on the list_lru with ->prev pointing to itself. The
> next removal leaves the neighbours pointing to it, and they still do so
> after the folio has been freed. With CONFIG_DEBUG_LIST:
> 
>    list_del corruption. prev->next should be ffd4000000270090, but was
>    ffd4000000278090. (prev=ffd4000000270090)
> 
> Fix it by grabbing the lock around list_del_init() so
> deferred_split_folio() cannot race with it.
> 
> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Mani Tofigh <mt4022@columbia.edu>
Tested-by: Mani Tofigh <mt4022@columbia.edu>
