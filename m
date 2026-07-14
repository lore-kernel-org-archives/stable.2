Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4EEAC7;
	Tue, 14 Jul 2026 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783989977; cv=none; b=F1ZzSz/9FoNzEPmLiR2/skzuoNSYaf7W1X6HZ69/ARhCSSesjFTf5jZ5wGiHJdpdJYy+KtuW0s9yfDrZ/ccq/142N56rx8L6A9EsQRogH665YnUkHIyPMJV/bdr811pphkCN/O8UwXGD8G/zfKeKUmcPtF14U/vaP8iV1zqStA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783989977; c=relaxed/simple;
	bh=elo0YrwC25FBVOjMw0Bec1PLyRGqBsA7OyB3tMnQfV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdvit7BZapsojt2PKfmWcUUdS8vds/jd2gPOij7jsfdaRduSFFjjiAzvJl0x2TJ9LERy4kEixOMnLNXDjDspnGMKXLQZZJuFg6tFaF2KYqR7btWuXAKz2SyMuQOsFhZeMe9/bnesdRQYS1vqqlNSPAzNmrDxyMcD3c8p8jDHKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 66763a047f1d11f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b9a02f50-6f9e-4643-9cb9-ced1449825f7,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:b9a02f50-6f9e-4643-9cb9-ced1449825f7,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:f0c52908228f37835a4e6c072af3c148,BulkI
	D:260713224606VYPSDRI6,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|136|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:99|1,F
	ile:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 66763a047f1d11f1aa26b74ffac11d73-20260714
X-User: husong@kylinos.cn
Received: from [192.168.110.173] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 138411820; Tue, 14 Jul 2026 08:46:07 +0800
Message-ID: <45e2e42c-73c0-4d2b-9b4b-bd44730c2378@kylinos.cn>
Date: Tue, 14 Jul 2026 08:45:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: restore failed global reservations to subpool
 in alloc_hugetlb_folio
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Wupeng Ma <mawupeng1@huawei.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ackerley Tng <ackerleytng@google.com>, Zhao Li <enderaoelyther@gmail.com>,
 David Carlier <devnexen@gmail.com>
References: <20260713144557.3845941-1-joshua.hahnjy@gmail.com>
From: Song Hu <husong@kylinos.cn>
In-Reply-To: <20260713144557.3845941-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/7/13 22:45, Joshua Hahn 写道:
> On Mon, 13 Jul 2026 19:50:08 +0800 Song Hu <husong@kylinos.cn> wrote:
>
> Hi Song, thank you for the patch.
>
>> When hugetlb_alloc_folio() fails, alloc_hugetlb_folio() only rolls back
>> spool->used_hpages in the out_subpool_put path when gbl_chg == 0. For
>> gbl_chg > 0 (e.g. a size= hugetlbfs mount), hugepage_subpool_get_pages()
>> has already incremented used_hpages, but the error path skips the
>> rollback, so each failed fault permanently leaks one used_hpage until
>> the subpool is exhausted and hugepage_subpool_get_pages() itself fails.
>>
>> Decrement used_hpages for the gbl_chg > 0 case too, mirroring the
>> hugetlb_reserve_pages() fix.
> So something is clearly wrong with this codepath here; there are now 4
> competing fixes in the mailing list currently being discussed [1] [2] [3]
> including this one and they all do things slightly differently.
> Let's please agree on what the correct solution is, 
> I've CC-ed the authors of those 3 other solutions to discuss here. 
Hi Joshua,

Thanks for the review and for bringing the authors together.

First, apologies for the duplicate submission — when I sent this I was not
aware of the other proposals on the list ([1][2][3]). I ran into this leak
while looking at the subpool accounting and simply wanted to share a fix;
I did not mean to add noise to an ongoing discussion.
>> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
>> Signed-off-by: Song Hu <husong@kylinos.cn>
>> ---
>>  mm/hugetlb.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index d6c812d1857b..8413ec92d836 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3073,6 +3073,19 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>  	if (map_chg && !gbl_chg) {
>>  		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
>>  		hugetlb_acct_memory(h, -gbl_reserve);
>> +	} else if (map_chg && gbl_chg > 0 && spool) {
>> +		/*
>> +		 * Restore used_hpages for the globally-requested page that
>> +		 * hugepage_subpool_get_pages() counted against the subpool's
>> +		 * maximum, but which we failed to back from the global pool.
>> +		 * Mirrors the fix in hugetlb_reserve_pages() (1d3f9bb4c8af).
>> +		 */
>> +		unsigned long flags;
>> +
>> +		spin_lock_irqsave(&spool->lock, flags);
>> +		if (spool->max_hpages != -1)
>> +			spool->used_hpages -= gbl_chg;
>> +		unlock_or_release_subpool(spool, flags);
> Why are we unlocking or releasing the subpool here? 
Good catch — it does not belong here. unlock_or_release_subpool() is meant
for paths that may drop the subpool's last reference (e.g.
hugepage_subpool_put_pages(), after which the subpool can become free). In
this error path we only adjust used_hpages and never touch spool->count, so
the subpool cannot be released here; a plain
spin_unlock_irqrestore(&spool->lock, flags) is sufficient and clearer. I
copied it from the hugetlb_reserve_pages() sibling fix (1d3f9bb4c8af), but
it is not the right helper here either; I will switch to
spin_unlock_irqrestore() in v2.

One thing that may be worth keeping in mind for the discussion:
a833a693a490 is already in 6.x -stable, so the leak is present in those
trees as well, and a backportable fix will be needed there regardless of
which direction is chosen for mainline.

For what it is worth, I verified the behavior with a small reproducer (a
size= hugetlbfs mount with nr_hugepages churned 10 -> 2 -> 10: unpatched,
the subpool only maps 2/10 pages after the leak; patched, 10/10), in case
it is useful to whoever ends up shaping the final fix.

Happy to help with whatever direction people want to take.

Thanks,
Song
>>  	}
>>  
>>  out_end_reservation:
>> -- 
>> 2.43.0
> Thanks again for the patch,
> Joshua
>
> [1] https://lore.kernel.org/all/20260708-hugetlb-alloc-failure-fixes-v2-2-c7f27cbb462b@google.com/
> [2] https://lore.kernel.org/linux-mm/20260428113037.88766-2-enderaoelyther@gmail.com/
> [3] https://lore.kernel.org/linux-mm/20260515202902.461539-1-devnexen@gmail.com/
