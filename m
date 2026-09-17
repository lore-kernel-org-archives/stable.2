Received: from mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A24BD363
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639175; cv=none; b=gFgO33pp/HPz5zmqpJ0ohBUrPcS8LbiOyWsdgyzhDow+zZoHDcOYg8v2rvExXshNTPcvEO7DkArxdGu+Y43oGUBuaI50VKw27cYX8Xlnp2PDhGNyIsiM0XvkOHZNB/MMkRi/KTKOBRlCNYgJBl18lKIelfUVGmvX6NRg6E2s9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639175; c=relaxed/simple;
	bh=h3tWfqwp0BXJaEM7B1AfP1A5m7aOhxvWpLcI8mcrCIk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mpdY9QIwOibznxC0ffQyjvs5S8SqAKigvokNejIa/IanPunkeQrnWZoDZdLjYQwznHARvvRMp8WAYZq8ZAG5E1PvhhEqtGGrIE2hrj8qO0UAbVf87zMJg36Oc8TLG6SXRcFcn98lndPcO5/7+hCNOYsDpEWLYKlAPokC5Ip/CpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HCFBAhsC; arc=none smtp.client-ip=91.218.175.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HCFBAhsC"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=h3tWfqwp0BXJaEM7B1AfP1A5m7aOhxvWpLcI8mcrCIk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789639156; v=1; x=1790243956;
 b=HCFBAhsCNruCnF5Mhw0xmB/0cFp2lrFGJOaIHJrGKic0Skdk192ozMWkV8qYwc+BeiSw7i9z
 SxwXNWf+tRHIyNMkQzQta+dwcWGUMQ2CgIbjzIPz2P6m6tGBBB/MaAUHIoKQAvfoKFsTsGs554W
 d+RfkTlrveMM9y7M/uzK5GWo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 292699053d277396;
	Thu, 17 Sep 2026 09:59:16 +0000
X-Mizu-Trace-ID: 292699053d277396
X-Migadu-Flow: FLOW_OUT
Message-ID: <4e59f610-d4ca-4f88-bae8-d60464f1ebe9@linux.dev>
Date: Thu, 17 Sep 2026 17:59:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hongfu.li@linux.dev, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Mina Almasry
 <almasrymina@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hongfu Li <lihongfu@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/hugetlb_cgroup: move per-node usage on cross node
 migration
To: Muchun Song <muchun.song@linux.dev>
References: <20260916-for-hugetlb-charge-v1-0-70fb708b2e4a@kylinos.cn>
 <20260916-for-hugetlb-charge-v1-1-70fb708b2e4a@kylinos.cn>
 <E35A1286-33DF-4B54-8338-888EE28BFD06@linux.dev>
From: Hongfu Li <hongfu.li@linux.dev>
In-Reply-To: <E35A1286-33DF-4B54-8338-888EE28BFD06@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/17/26 1:58 PM, Muchun Song wrote:
>
>> On Sep 16, 2026, at 16:30, Hongfu Li <hongfu.li@linux.dev> wrote:
>>
>> From: Hongfu Li <lihongfu@kylinos.cn>
>>
>> hugetlb.<size>.numa_stat uses folio_nid() to account usage in
>> __hugetlb_cgroup_commit_charge() and __hugetlb_cgroup_uncharge_folio().
>> hugetlb_cgroup_migrate() only moves hugetlb_cgroup pointers, leaving
>> per-node usage behind on the source node during cross-node migration.
>>
>> When the migrated folio gets uncharged, we subtract usage from the
>> destination node counter. This creates stale usage on the source node
>> and unsigned long counter underflow on the destination node.
>> The hugetlb.<size>.numa_stat interface exposes these incorrect per-node
>> usage values to userspace.
>>
>> Add a hugetlb_cgroup_move_usage() helper which moves the usage from the
>> old node to the new node, and call it from hugetlb_cgroup_migrate().
>>
>> Fixes: f47761999052 ("hugetlb: add hugetlb.*.numa_stat file")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
>> ---
>> mm/hugetlb_cgroup.c | 31 +++++++++++++++++++++++++++++++
>> 1 file changed, 31 insertions(+)
>>
>> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
>> index ecb6e0b7819a..1040406e7e1d 100644
>> --- a/mm/hugetlb_cgroup.c
>> +++ b/mm/hugetlb_cgroup.c
>> @@ -179,6 +179,34 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
>> hugetlb_cgroup_free(hugetlb_cgroup_from_css(css));
>> }
>>
>> +static void hugetlb_cgroup_move_usage(struct hugetlb_cgroup *from,
>> + 				     struct hugetlb_cgroup *to,
>> + 				     struct folio *from_folio,
>> +  			             struct folio *to_folio)
>> +{
>> + 	int idx = hstate_index(folio_hstate(from_folio));
>> + 	unsigned long nr_pages = folio_nr_pages(from_folio);
>> + 	int from_nid = folio_nid(from_folio);
>> + 	int to_nid = folio_nid(to_folio);
>> + 	unsigned long usage;
>> +
>> + 	lockdep_assert_held(&hugetlb_lock);
>> +
>> + 	if (!from || !to)
>> + 		return;
>> +
>> + 	if (from == to && from_nid == to_nid)
>> + 		return;
>> +
>> + 	usage = READ_ONCE(from->nodeinfo[from_nid]->usage[idx]);
> READ_ONCE is unnecessary because there is no concurrent writer.

Thanks for the review.

You're right, the READ_ONCE is indeed unnecessary here. I'll drop it in v2.

>> + 	if (WARN_ON_ONCE(usage < nr_pages))
>> + 		return;
>> + 	WRITE_ONCE(from->nodeinfo[from_nid]->usage[idx], usage - nr_pages);
>> +
>> + 	usage = READ_ONCE(to->nodeinfo[to_nid]->usage[idx]);
> Same here.
>
>> + 	WRITE_ONCE(to->nodeinfo[to_nid]->usage[idx], usage + nr_pages);
>> +}
>> +
>> /*
>>   * Should be called with hugetlb_lock held.
>>   * Since we are holding hugetlb_lock, pages cannot get moved from
>> @@ -906,6 +934,9 @@ void hugetlb_cgroup_migrate(struct folio *old_folio, struct folio *new_folio)
>> 	/* move the h_cg details to new cgroup */
>> 	set_hugetlb_cgroup(new_folio, h_cg);
>> 	set_hugetlb_cgroup_rsvd(new_folio, h_cg_rsvd);
>> +
>> + 	hugetlb_cgroup_move_usage(h_cg, h_cg, old_folio, new_folio);
>> +
>> 	list_move(&new_folio->lru, &h->hugepage_activelist);
>> 	spin_unlock_irq(&hugetlb_lock);
>> }
>>
>> -- 
>> 2.54.0
>>
-- 
Best regards,
Hongfu

