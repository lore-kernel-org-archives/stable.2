Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473167;
	b=JyzRMps9TohyCifveqKKxGaNXLO0k5uEV/wOujAeQ14I6cH3YPY4EZ8aLMZBFOkOHeLx
	 L1VcQrUunkMPGdyFyIJpjEj8WSGT+RWCynt+C3r6IC3PERFx2ztMKD47J1vDtbVi1Wleq
	 YVt3Xkode0/f7H7W2CCcSzqTCcOIDjbwUttSzX8FI3iTxaQ/E4u+lTGhVMomto/FwuUYs
	 w7GbUpKlo23r5fSF7mE9SpeEr9hnAx2JIg1N6MTVlTkcwRt6JsEykuMF8alOt7UeP6gmS
	 JTof6VduRA5wXllgIjr2ZfSCJIClnC7Q/VM2X2y/EHooiByr8U8qrcqMZZHl0sBdwpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473167;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=41nsNdC3zdMjNaUNJgC+leDUiMtoCdh+/HNf/Dul+ro=;
	b=Q/6JqCXOyC4n7MkHh+A55/nmCJJLBhvBi/7n+3f18hXkf+ZdHwFDCI/CxH+yVSL2ZGxf
	 lG7QlXvcO5GHYzZRsdmcS1c04P9MToiHlgp4Bpqqv5khvo3Nr6osWy2Bnb6CQwECoVA8H
	 Nd7VyKLMtMDh7QAJWV3yuMjEJpVwHkDbLDrTqZPpbv9bdR4kxmiGuolXcjVfLgFieheth
	 lJmail7plRNUd095NYxp+qcdtZmvZ+JMvEsgMV17+xXkJtIg1E12/nEh4SSPUyQEtliMG
	 D+DXabP0N/8WLY1MFv/6TNPPZ2Aka1qFpG6MpvuHf+RlPodfctpKGYkR+L8IgX0wd1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hR47NfAx;
	arc=none smtp.remote-ip=115.124.30.112
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D3606A31C;
	Thu, 12 Nov 2026 08:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 768D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hR47NfAx
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794473162; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=41nsNdC3zdMjNaUNJgC+leDUiMtoCdh+/HNf/Dul+ro=;
	b=hR47NfAxLVnidMYORHx/Bsdl9IZ/c6pc3loFAQmjhtxRq8T+DUTmpwFv6/ayhwAxdAAm4rlkFOZe4oJWkyvAb6zcBllFPZI0x2wr/0Kmg4nSgnyK8isDl9p1Ujd98TXphu6vrmow+RrA/gyMY/0h59ig5fHdGPoqE6R/sKmNm88=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XEbXuRi_1794473160;
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XEbXuRi_1794473160 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 16:46:01 +0800
Message-ID: <6722b853-3a80-439d-aee8-712011965d49@linux.alibaba.com>
Date: Thu, 12 Nov 2026 16:46:00 +0800
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
Subject: Re: [PATCH] mm: mglru: splice all generations when reparenting a
 memcg
To: Kairui Song <ryncsn@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Barry Song <baohua@kernel.org>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Noah Feldt <noah@feldt.systems>,
 stable@vger.kernel.org
References: <20261111000913.22943-1-shakeel.butt@linux.dev>
 <CAMgjq7B+PE-Tw_v3bKYzNOTaT6+0_fn8gW7sNpMwzP1tPGbDug@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7B+PE-Tw_v3bKYzNOTaT6+0_fn8gW7sNpMwzP1tPGbDug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/26 2:13 AM, Kairui Song wrote:
> On Wed, Nov 11, 2026 at 8:10 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> Noah reported list_del corruption on single-node hosts running 7.2.11,
>> which already has commit bf4ade7dbd76 ("memcg: keep folio's objcg same
>> as its node"). The bad pointer is an MGLRU list head in a freed
>> mem_cgroup_per_node:
>>
>>    slab mem_cgroup_per_node start ff31bfa36a3c9e00 pointer offset 528 size 1920
>>    list_del corruption. next->prev should be ffacf881ccc70e08, but was ff31bfa36a3ca010. (next=ff31bfa36a3ca010)
>>
>> When a memcg goes offline, __lru_gen_reparent_memcg() moves its MGLRU
>> lists to the parent. It moves only the generations (gens) from min_seq
>> to max_seq, and it puts each list at the same index in the parent.
>>
>> A folio's gen in folio->flags can be ahead of the list it is on. In the
>> parent, the same index can stand for an older gen, so the folio's gen
>> can end up older than its list. Once the parent's min_seq passes that
>> gen, sort_folio() puts the folio on the list for max_seq + 1, where it
>> stays until the next aging.
>>
>> If the parent goes offline before that aging, the folio is not moved to
>> the grandparent. It stays on the parent's list after the parent is
>> freed, and the next list_del() on it touches freed memory. This needs
>> two cgroups on one branch to go offline one after the other, such as a
>> container and then its pod.
>>
>> The parent always has MAX_NR_GENS gens at this point, so every index is
>> valid in it. Move all MAX_NR_GENS lists, not only the gens from min_seq
>> to max_seq.
>>
>> A reproducer that drives these steps through the lru_gen debugfs file
>> gets a KASAN use-after-free on the freed mem_cgroup_per_node without
>> this patch, and no report with it.
>>
>> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
>> Reported-by: Noah Feldt <noah@feldt.systems>
>> Closes: https://lore.kernel.org/all/20261110132853.71228-1-noah@feldt.systems/
>> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>> Cc: <stable@vger.kernel.org>
>> ---
>>   mm/vmscan.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 6a1af9b92349..902616a3b755 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -4751,19 +4751,25 @@ void max_lru_gen_memcg(struct mem_cgroup *memcg, int nid)
>>    * The same generation has different meanings in the parent and child memcg,
>>    * so this compromise method will cause the LRU inversion problem. But as the
>>    * system runs, this problem will be fixed automatically.
>> + *
>> + * Move all MAX_NR_GENS lists, not only the gens from min_seq to max_seq.
>> + * An earlier reparenting can leave a folio whose gen is older than the list
>> + * it is on. Once min_seq passes that gen, sort_folio() puts the folio on the
>> + * list for max_seq + 1, where it stays until the next aging. If that list
> 
> "sort_folio() puts the folio on the list for max_seq + 1" seems not
> very accurate as MAX_NR_GENS - MIN_NR_GENS == 2, could be any stale
> gen outside [min_seq, max_seq], right?

+1. The comments are not easy to understand. IIUC, the problem is that 
the folio's gen can fall outside lruvec->[min_seq, max_seq], potentially 
causing the folio to be left behind on a memcg that is about to be freed.

But, yes, the fix is correct. So,
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
