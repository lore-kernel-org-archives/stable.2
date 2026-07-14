Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28889223707;
	Tue, 14 Jul 2026 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990307; cv=none; b=UFz5BtgCATJj6uGoa/yXPTqkt7Q+grgUnQVSskdVr/fGn36ofL5zJGEN5e15h0MeO9KSxIksRosLtPc5PPhM8Iz5YhxPgAgCCIvTXPIwzcyKn5Iy3+qxpXCZQcgCwxjCi6xd7akwLBHnGCWN/2jYaFR/l60LwUaz8z2m066Imwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990307; c=relaxed/simple;
	bh=HFgIeTPJyhK2U9HYUwQWRmSvo7+/kB9uMu0N67t2/mc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uTJVLlOZ4cUB9ga0wBmrTGWI7+4IwIWdVSO6HFiFqVJLb8o5VGKy/KKpNHwRUJcrkTn8vMpPIMODJUrHlUuakRm2/zeQ0NUKSgbVAQ6FFpcOwAKHvpAp6mdZv0Mw+v4h2beCCPQMsPcFlHoAMgToF/mmCA1mh4KOCBLRVvMIcOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2b27ce767f1e11f1aa26b74ffac11d73-20260714
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_MAILER_MTBG, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_COMM, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f2b77259-a3d1-4e87-aa3f-b6b6caac5e42,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:f2b77259-a3d1-4e87-aa3f-b6b6caac5e42,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:da258d8c0d687a3c02eccc0ff0f78cbf,BulkI
	D:260713224606VYPSDRI6,BulkQuantity:3,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|136|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:99|
	1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2b27ce767f1e11f1aa26b74ffac11d73-20260714
X-User: husong@kylinos.cn
Received: from [192.168.110.173] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1114977333; Tue, 14 Jul 2026 08:51:37 +0800
Message-ID: <515454fa-9be7-4537-87b3-1fd6ee364ccc@kylinos.cn>
Date: Tue, 14 Jul 2026 08:51:34 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: husong@kylinos.cn, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Wupeng Ma <mawupeng1@huawei.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Zhao Li <enderaoelyther@gmail.com>, David Carlier <devnexen@gmail.com>
Subject: Re: [PATCH] mm/hugetlb: restore failed global reservations to subpool
 in alloc_hugetlb_folio
To: Ackerley Tng <ackerleytng@google.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20260713144557.3845941-1-joshua.hahnjy@gmail.com>
 <CAEvNRgHMsva75JcJBEw2UdmNwAvKOZb44w0-Z_dq14D8QT2LAQ@mail.gmail.com>
From: Song Hu <husong@kylinos.cn>
In-Reply-To: <CAEvNRgHMsva75JcJBEw2UdmNwAvKOZb44w0-Z_dq14D8QT2LAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/7/13 23:49, Ackerley Tng 写道:
> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>
>> On Mon, 13 Jul 2026 19:50:08 +0800 Song Hu <husong@kylinos.cn> wrote:
>>
>> Hi Song, thank you for the patch.
>>
>>> When hugetlb_alloc_folio() fails, alloc_hugetlb_folio() only rolls back
>>> spool->used_hpages in the out_subpool_put path when gbl_chg == 0. For
>>> gbl_chg > 0 (e.g. a size= hugetlbfs mount), hugepage_subpool_get_pages()
>>> has already incremented used_hpages, but the error path skips the
>>> rollback, so each failed fault permanently leaks one used_hpage until
>>> the subpool is exhausted and hugepage_subpool_get_pages() itself fails.
>>>
>>> Decrement used_hpages for the gbl_chg > 0 case too, mirroring the
>>> hugetlb_reserve_pages() fix.
>> So something is clearly wrong with this codepath here; there are now 4
>> competing fixes in the mailing list currently being discussed [1] [2] [3]
>> including this one and they all do things slightly differently.
>> Let's please agree on what the correct solution is,
>> I've CC-ed the authors of those 3 other solutions to discuss here.
>>
> Thanks for connecting us!
>
> I'd like to make a pitch for centralizing the fix into the subpool [1]
> :) I think it will also let us clean up the existing codepaths where
> each path does its own open-coding and reaching into the subpool. Also,
> if that cleanup is centralized into the subpool, we might be able to
> track availability instead of reservations [4], which I think simplifies
> HugeTLB reservations and removes some possible races (for keeping
> rsv_hpages and resv_huge_pages in sync) completely.
>
> [4] https://lore.kernel.org/all/CAEvNRgGN0HSJ2iLSDD2haSKOxifa-uhkO9Hwossh0+Q_d9fzOw@mail.gmail.com/
>
> I understand the above solution is a deeper change, does anyone have any
> thoughts on the approach, or existing tests other than libhugetlbfs and
> tools/testing/selftests/mm/ksft_hugetlb.sh (which pass) that I could use
> to prove this works?
Hi Ackerley,

Thanks for the write-up. The centralization reads cleanly, and tracking
availability instead of reservations does look like it would remove a real
class of the rsv_hpages / resv_huge_pages sync races, so I don't have an
objection to that direction for mainline.

On tests — I put together a small reproducer while debugging this, which
might be useful regardless of which fix lands: a size= hugetlbfs mount (so
the subpool has a max_hpages), with nr_hugepages churned 10 -> 2 -> 10
around a MAP_NORESERVE fault loop. Without a fix the subpool permanently
loses capacity (it maps 2/10 pages even with 10 global pages free); with a
fix it recovers to 10/10.

One thing worth flagging for -stable: a833a693a490 is already in 6.x
-stable, so the leak is live there too, and a larger refactor probably is
not backportable — so a minimal fix may still be wanted on the stable
branches even if centralization goes in for mainline.

Thanks,
Song
>>> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
>>> Signed-off-by: Song Hu <husong@kylinos.cn>
>>> ---
>>>  mm/hugetlb.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index d6c812d1857b..8413ec92d836 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -3073,6 +3073,19 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>>  	if (map_chg && !gbl_chg) {
>>>  		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
>>>  		hugetlb_acct_memory(h, -gbl_reserve);
>>> +	} else if (map_chg && gbl_chg > 0 && spool) {
>>> +		/*
>>> +		 * Restore used_hpages for the globally-requested page that
>>> +		 * hugepage_subpool_get_pages() counted against the subpool's
>>> +		 * maximum, but which we failed to back from the global pool.
>>> +		 * Mirrors the fix in hugetlb_reserve_pages() (1d3f9bb4c8af).
>>> +		 */
>>> +		unsigned long flags;
>>> +
>>> +		spin_lock_irqsave(&spool->lock, flags);
>>> +		if (spool->max_hpages != -1)
>>> +			spool->used_hpages -= gbl_chg;
>>> +		unlock_or_release_subpool(spool, flags);
>> Why are we unlocking or releasing the subpool here?
>>
>>>  	}
>>>
>>>  out_end_reservation:
>>> --
>>> 2.43.0
>> Thanks again for the patch,
>> Joshua
>>
>> [1] https://lore.kernel.org/all/20260708-hugetlb-alloc-failure-fixes-v2-2-c7f27cbb462b@google.com/
>> [2] https://lore.kernel.org/linux-mm/20260428113037.88766-2-enderaoelyther@gmail.com/
>> [3] https://lore.kernel.org/linux-mm/20260515202902.461539-1-devnexen@gmail.com/
