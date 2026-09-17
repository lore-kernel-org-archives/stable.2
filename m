Received: from mta0.migadu.com (out-141.mta0.migadu.com [91.218.175.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4938A71F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640283; cv=none; b=GWfbhtJ5dQEX6KbbrTh8rZAn35TBtaY5n7rwz5tVDsk8r1H/4gtrzZPX2XfmGOSYacfLg+/qh870oSaQ3pGjjAl23Ahu/SS78q9BJJSNczHFhvicRrQyOh9qhNeac59hrKb9QASxqt0fXyHKhe3fSwy7YUwc3ab0lR1MBfoLsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640283; c=relaxed/simple;
	bh=DIFoReXqzCCEdyzOnHZyO/KDl68bNqQoPzIWJqoTfqE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=acgqBAhyWRvgs2DMODdmMzWLjK4b7klGJcay5pMXTVW72J7YMIJl/gqE/XxWtHpnmrBMgvlM/cISsvZTZCLuGpsERoNeH4ofUWYlXQj2CHeujrbbVlxQtyF8IcBwESx9dlErztrHUo5i0nUCSyPjLy1r7xbZylYeBq5dn7kEuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lmbcvlxa; arc=none smtp.client-ip=91.218.175.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lmbcvlxa"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DIFoReXqzCCEdyzOnHZyO/KDl68bNqQoPzIWJqoTfqE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789640279; v=1; x=1790245079;
 b=LmbcvlxaUExQL4VcOJKr+GUiLIlTdT/2R4qkbzkUCRVM0EDI80cHZqHr0brrZyH4Z4oP3n3h
 WiBzCSzR7l+OpFxsq+xU2tFy3I3YxjbClsuGx2Wm56B7XoNE52Owm1HpLY0qH2GUqMx7JblLwT/
 OE2HhM700apRuS4hHy0xm04Y=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8f42acc8c86f58c5;
	Thu, 17 Sep 2026 10:17:59 +0000
X-Mizu-Trace-ID: 8f42acc8c86f58c5
X-Migadu-Flow: FLOW_OUT
Message-ID: <534d67fb-8b5c-455b-ab75-cfc5c73e677a@linux.dev>
Date: Thu, 17 Sep 2026 18:17:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hongfu.li@linux.dev, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Kees Cook <kees@kernel.org>, Colin Ian King <colin.i.king@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Mina Almasry
 <almasrymina@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hongfu Li <lihongfu@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/hugetlb_cgroup: move the per-node usage along with
 the folio
To: Andrew Morton <akpm@linux-foundation.org>
References: <20260916-for-hugetlb-charge-v1-0-70fb708b2e4a@kylinos.cn>
 <20260916175302.be1e68f24b96b7c639cbd7f5@linux-foundation.org>
From: Hongfu Li <hongfu.li@linux.dev>
In-Reply-To: <20260916175302.be1e68f24b96b7c639cbd7f5@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/17/26 8:53 AM, Andrew Morton wrote:
> On Wed, 16 Sep 2026 16:30:26 +0800 Hongfu Li <hongfu.li@linux.dev> wrote:
>
>> The per-node usage reported by hugetlb.<size>.numa_stat is accounted
>> against folio_nid() in __hugetlb_cgroup_commit_charge() and
>> __hugetlb_cgroup_uncharge_folio(), so it is only correct while a folio
>> stays charged on the same node and in the same hugetlb_cgroup.
>>
>> Two paths move a folio which stays charged, and neither moves the usage
>> with it. hugetlb_cgroup_migrate() only moves the hugetlb_cgroup pointers
>> of a folio migrated to another node, and hugetlb_cgroup_move_parent()
>> only moves the page_counter charges and the hugetlb_cgroup pointer of
>> the folios of a dying cgroup. In both cases the node (or cgroup) which
>> was charged keeps a usage which never goes away, while the node
>> (or cgroup) which ends up uncharging the folio underflows as soon as
>> the folio is freed.
>>
>> Patch 1/2 moves the usage along with the folio on cross node migration,
>> patch 2/2 does the same for the folios a dying cgroup reparents.
> As I understand it, this series affects numa_stat output but has no
> actual runtime effects?

Yes, that's right. The per-node usage[] is only read by
hugetlb_cgroup_read_numa_stat(), so this series only fixes the values
reported in hugetlb.<size>.numa_stat. It has no effect on charging or
limit enforcement, which go through page_counter and are already
handled correctly by hugetlb_cgroup_migrate() and
hugetlb_cgroup_move_parent().

>
> Do you (and maintainers) think that we should fix this in earlier
> kernels?
>
> (I do - a lot of userspace infrastructure makes expensive decisions
> based on this sort of info).

I agree with you that this should go to stable.

Patch 1/2 and Patch 2/2 already carry Fixes: and Cc: stable tags.

-- 
Best regards,
Hongfu

