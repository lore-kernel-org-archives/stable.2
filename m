Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178106;
	b=Du2mnwKw3Z0n5j48ZHbLKlRW3DjQN6AfMVNogpIiiag53C8mMhB5lj6tt6RA1/qbkavV
	 qAc+XbDFIWmpJRCeU+upuIfVhHSvJeXtGy39ZjpReGWzgADWDYcu8m1Gquywc5yxMdItS
	 T/eAWyhjeGwNCz+JfIFy9yT4zMvjI8ZreGItCAzaxYCQAd7gUK491J5UE6i6tGJGWPUzY
	 +bpgwUKpkn7Ii7xKg/zuWkcYOCcrNZxZtLWRXdIRuCw6yROwKiKNsVCEG8znXQ0Fi3m9u
	 boQgo/UeB8DMeIBGOoOjdJ4n0eXHtl/Q6jRxYpexLpAydj9/CRYD9SGws0i/Yq6G/RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178106;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DYnXMvqp3PIi51in2UAAZDRvat3uyQD9A+wkRBDoEh8=;
	b=jO6/I4Itdoh/5FHLO+fGKEua06WjrnN8mQBHHJtEGV+v5/T0OQn+B3U/TAlrFhPxKsdU
	 ShRroRIjU1aDl4OxqqL3shVSpZnzhZ4DrENrMA24aHXHxHm/PDN8e6BCFJm2HAkbAB1qM
	 aWrWdFMhPEYNXs9AoEMfIKek1hbdY4djXB0DHsc8luZglAW/AYw4I3YLWFl0oShc92h49
	 0/YQ0i+vMe+rUYXfI4bnOEX3AGdFPDL/HbVgMxIqCS4Q5P8nKd3gm00/IdKVJHrAp5U6L
	 lKpTt4C/rjBsaRzcScEKIRLtTVp/UTd1KlkpZ0BjrK+ythG2kFAVSayymb3nGbA/dww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="IQf/P4mi";
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9A606A31A;
	Wed, 28 Oct 2026 09:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IQf/P4mi
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793178101; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DYnXMvqp3PIi51in2UAAZDRvat3uyQD9A+wkRBDoEh8=;
	b=IQf/P4mioGqIU5hkK+hXDS0oNcyb8U/UfingVkdIY92NwNgd83rWnOymYiw8a8bYHJkAtV4AK/8KF/Z8sj00GkpDcanW46DvNR5NJpZW3zvhms1inaJo1KBsUyCijzemgOMZ1NWGef3uyOA4fiifBpd2kKcBbjeT7BKlgdQryso=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0XDgFIpV_1793178096;
Received: from 30.74.144.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDgFIpV_1793178096 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 17:01:38 +0800
Message-ID: <7f4155ef-9f5c-4567-a84d-dddf640cb844@linux.alibaba.com>
Date: Wed, 28 Oct 2026 17:01:36 +0800
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
Subject: Re: [PATCH v2 12/14] mm/shmem: fix truncate loop after boundary
 swapin failure
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Gregory Price
 <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Lukas Czerner <lczerner@redhat.com>,
 Carlos Maiolino <cmaiolino@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Stevens <stevensd@chromium.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
 <20261027-fixes_shmem-v2-12-86a00952acb9@kernel.org>
 <2d111275-e7a8-4ac5-8618-f068e87145f2@linux.alibaba.com>
 <10ae2533-cc4b-4c30-95d7-705815ba7830@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <10ae2533-cc4b-4c30-95d7-705815ba7830@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/28/26 4:21 PM, David Hildenbrand (Arm) wrote:
> On 10/28/26 02:30, Baolin Wang wrote:
>>
>>
>> On 10/27/26 9:03 PM, David Hildenbrand (Arm) wrote:
>>> If swapping in a large entry at the new EOF fails, shmem_undo_range()
>>> leaves the entry in place. Its final scan skips the entry, then restarts
>>> from the same start index and finds it again. Truncation can loop forever
>>> while holding i_rwsem.
>>
>> Right. But ...
>>
>>> Advance start past the skipped entry so that a restarted scan can finish,
>>> as we already do for folios that cannot be split.
>>
>> IIRC, we originally avoided advancing start because a concurrent swapin fault
>> could split the boundary large swap entry via shmem_split_large_entry(), leaving
>> small swap entries below the new start.
>>
>> Sigh.
>>
>> There doesn't seem to be a simple fix. We may need to swap in the large entry as
>> shmem_get_partial_folio() does, and then split the large folio. I'll work on
>> this as a follow-up.
> 
> Thanks!
> 
> So you are fine with the patch as is to fix the endless loop?

Yes, let's get this fixed first.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
