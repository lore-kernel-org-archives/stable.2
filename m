Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651280;
	b=1UZbtcfbRuifCvig+wV3j+sRKkd9fYawRWJtqIenodTI5XNqp68XVP8x2Lx7+oQPODsM
	 ryN6E/qdLMH1BmixLi1ALS7VJlpUQUQbw/Z1tZiCbNBAVINv20ysw1ro3/Co9DgbYW6j7
	 biXjqJO+yGt/UVqK1JJX74g67TErZUFQ2uNUIH7dNDKfe3E9vC2C//PhD3k3LaY6A3l7V
	 D2iDCphXlSiy1LQLNrxNreC9ZNWAbDx2rwqC56NRRB9iwRtJL4O3EP/2USWOPoxfGP//y
	 /J9lyNExne3XP0ekslFzDTU+GSs8pWmczRo9YwDkkemAOWdYt5P6qJbkcif61vhzUyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651280;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=x5cC4bmi1LKVIll0p6WalymoOj1ixHoJ2jljfs60WTc=;
	b=S+rrpF7LejOSScqXw34wmr3d/eFwRcYGqsBy5jG3I3vwiXo9aa51/S6vIq4WPcZA9gpZ
	 e640OmHpUVVYB1beVq63T8z81voidshJsjgeAhQHTqQG+lrExrvIdjSXNP5e5YvmzWSBJ
	 yOEJhFy+JWTRRZn2FAbmpgTFUBdAOKwn+temHLKrKkcA3fw+e4RLrVSRQm6/HjlDR06pi
	 fHPNdMzbdWKDDTytO58k8RxBj1qEaqVsd4S0FrbGUcuE74LYYhv7urFgg6+heb6ailCHZ
	 bPLDObZjyjRG96HhIrxmtribnT0RDzV1h/ksXwFBQYYJ96vsxmcq6WjHreX9qTQZsFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N+oJ76um;
	arc=none smtp.remote-ip=95.215.58.65
Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCAF606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 06:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BCAF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N+oJ76um
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OLTnmAJnENmvYIgzwFrHsxjbV8AYtnhE58dfnwOrMs4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792651276; v=1; x=1793256076;
 b=N+oJ76umw01HY4hVxuGj1mZP4UQuEfqcgCQ5LNfQ3ikegYkjGJCLLrSFJCqHqeVCmUWxNijQ
 dnFWUcJox1qL9q9U1kDmrcqA4BCZain42Zu2WOjhpl329CKz7B5UFGoToArwsyNA/IMy+pVY8MO
 B4GmjBbHaiBySkjj8mzPvrQA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 86280eea6ba8db01;
	Thu, 22 Oct 2026 06:41:16 +0000
X-Mizu-Trace-ID: 86280eea6ba8db01
X-Migadu-Flow: FLOW_OUT
Message-ID: <8cac0284-a43d-4c3c-b59a-dccdadf7b75b@linux.dev>
Date: Thu, 22 Oct 2026 14:41:03 +0800
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
Cc: hongfu.li@linux.dev, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hongfu Li <lihongfu@kylinos.cn>,
 stable@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>
Subject: Re: [PATCH] mm/hugetlb: charge hugetlb cgroup and memcg in
 alloc_hugetlb_folio_reserve()
To: Andrew Morton <akpm@linux-foundation.org>
References: <20261020-for-alloc_hugetlb-1020-v1-1-e6eac82dd754@kylinos.cn>
 <20261021165918.da553bb0879c110847c232f5@linux-foundation.org>
From: Hongfu Li <hongfu.li@linux.dev>
In-Reply-To: <20261021165918.da553bb0879c110847c232f5@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/22/26 7:59 AM, Andrew Morton wrote:
> On Tue, 20 Oct 2026 16:46:30 +0800 Hongfu Li <hongfu.li@linux.dev> wrote:
>
>> From: Hongfu Li <lihongfu@kylinos.cn>
>>
>> alloc_hugetlb_folio_reserve() hands out a folio from the hugetlb pool and
>> consumes a global reservation, but unlike the fault path it never charged
>> the folio to the hugetlb cgroup or to the memcg.  Folios allocated for
>> memfd_pin_folios() through memfd_alloc_folio() were therefore silently
>> bypassing the accounting: they are never charged to the hugetlb cgroup
>> usage counter (hugetlb.<size>.current) nor to the memcg (memory.current),
>> so both limits (hugetlb.<size>.max, memory.max) are bypassed.
>>
>> Charge the folios to both the hugetlb cgroup and the memcg, just like
>> hugetlb_alloc_folio() does.
>>
>> Test with a process that creates a hugetlb memfd and pins pages through
>> UDMABUF_CREATE. The counters were read while the folio was still pinned:
>>
>> Before this patch:
>> $ echo $$ > /sys/fs/cgroup/test/cgroup.procs
>> $ ./memfd-alloc-folio 1 &
>> $ cat /sys/fs/cgroup/test/hugetlb.2MB.current
>> 0
>> $ cat /sys/fs/cgroup/test/memory.current
>> 1351680
>> $
>>
>> After this patch:
>> $ echo $$ > /sys/fs/cgroup/test/cgroup.procs
>> $ ./memfd-alloc-folio 1 &
>> $ cat /sys/fs/cgroup/test/hugetlb.2MB.current
>> 2097152
>> $ cat /sys/fs/cgroup/test/memory.current
>> 3313664
>> $
> Thanks.  The before-and-after output is useful.
>
> However there are potential interactions with Daehyeon Ko's
> "mm/hugetlb_cgroup: prevent use-after-free during cgroup offlining".
> https://lore.kernel.org/20261020100345.1677643-1-4ncienth@gmail.com
>
> Your patch adds another caller of hugetlb_cgroup_charge_cgroup(), which
> has the cgroup-offlining CSS lifetime race addressed by Daehyeon Ko's
> fix.
>
> An existing memfd reservation can belong to cgroup A while the task
> pinning the folio belongs to cgroup B. A's reservation CSS reference
> does not protect B's usage CSS across charge and commit.
>
> Also, the accounting bypass predates 26a8ea80929c.  The original
> memfd_pin_folios() implementation already used an uncharged allocator,
> so the Fixes tag should reference 89c1905d9c14 instead.

Agreed, the bypass has been there since memfd_pin_folios() was
introduced. I'll update the Fixes tag.

> The memory.max claim should be qualified: HugeTLB accounting in memcg
> is conditional on the cgroup v2 hierarchy's accounting configuration.

Right, I'll qualify that in the commit message.

> Daehyeon's fix is in the pipeline at present, awaiting a minor fixup
> and maintainer review.  Everything is rather swamped at present.
>
> So please assume that Daehyeon's fix is present and rethink your fix on
> top of that?

Sure, I'll rework the patch on top of his fix and resend as v2 after his
series has been reviewed.  I'll re-run the test with both applied before
sending.

-- 
Best regards,
Hongfu

