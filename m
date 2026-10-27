Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106545;
	b=IDJEmdfsfRtcaU171asjH8FPbHEJ73wL3Zxtfe3ClFs4Dx3JAzzsdQNqDP54ZpTnSeun
	 deQ2qN3DfFNWswcxX+8vTAhiaHmMQ8zvb+rqrRUYqKuCIsxKx15Hk5wxmpezwww7KpIXj
	 b8ZmK+drfDGvHo2CsY0sdIRALXRk3T9HKxTx/LQko6dlciiog0oJc8ZV2Jwx+4gptT4bN
	 wHi8igryTd4qJrzGr2bWD/HlOXPgCVN20FUI+WdXTt8YV8QB6ISbnq9mIdAC4EFTr3Pdm
	 n1PGUmt5vKVpo/c5mcoZoHzw1wGNrQ5Pbwdtle5Y//oXFFKICUBKFXkHN8mFZxpD5xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106545;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wTlsyB1dR81kewBt8dbwH4wNLuKoV9knz79QDG5bxdk=;
	b=XzIbD8gE1O0ZLSWKg3uTJUr41u4XJK/O/8Qvfc0fV2okANmkv4AQ0VBvVTORYB2AOJ3z
	 JUSEjmYps0UFwmU/AuNEirjNtikVuVOHwwQjb0TwnJJYzdDJDa+AuucXL1CP9UAhzMLil
	 DRl0KrvA4oe+YcZc54AHaaGp0oSX7QG74B6+aQhyVf+oaQNNJ9ZBbizHgr0xpyuPLkp9o
	 S9CXt+l24sGdGpm5/J3Agm7k8Wui6mLy3Wc4x/3QfbGzms/B5fK+K1xAO1E+GDx7jp/El
	 bBsefoZ8+Yre88vC2TBEv6zh7fdAD1UtfAxh6nsnMMuXRaBse1S83ayPHDxkUjIPwCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H+uDd4D+;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE6606A31E;
	Tue, 27 Oct 2026 13:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EE6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H+uDd4D+
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793106540; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wTlsyB1dR81kewBt8dbwH4wNLuKoV9knz79QDG5bxdk=;
	b=H+uDd4D+GjgwDrL3ctMvzN7SsSew19a4EFx0BWDS0i3HQUj+WzrmkfLn5sJ2hEbsgtygufYctZbpI6cwGaR1QWxDUbEWhpHMO+f6loNuuetJXDVrzx9hEAUYH4XsaXuaVkKugMFZRBRpEtVSVOboxE3LWuNBbenVdW/VEKW6biw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0XDdouO6_1793106535;
Received: from 30.74.144.191(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDdouO6_1793106535 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 21:08:56 +0800
Message-ID: <9c562402-6023-428f-b8c9-036fb66d5ea4@linux.alibaba.com>
Date: Tue, 27 Oct 2026 21:08:55 +0800
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
Subject: Re: [PATCH 00/16] mm/shmem: various (urgent?) fixes
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>,
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <a8f01101-7d7d-4982-9cf8-04b754ba132a@linux.alibaba.com>
 <1398e842-db91-4482-949a-e21197a48b9c@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1398e842-db91-4482-949a-e21197a48b9c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/26/26 8:12 PM, David Hildenbrand (Arm) wrote:
> On 10/26/26 12:11, Baolin Wang wrote:
>>
>>
>> On 10/26/26 5:40 PM, David Hildenbrand (Arm) wrote:
>>> Hi,
>>>
>>> the fixing fun continues.
>>>
>>> This is a handful of fixes for shmem/tmpfs. I sneaked in a related
>>> hugetlb fix that stalled upstream.
>>
>> Wow, thanks David!
>>
>>> Some of the stuff is more urgent (patch #1, F_SEAL_EXEC, truncation
>>> hangs), others are less urgent but still rather unpleasant.
>>>
>>> The majority are fixes from Anthropic that I cleaned up or reworked.
>>> While doing that, I found a bunch of other issues and tried to fix them
>>> somewhat cleanly.
>>>
>>> In general, shmem + swap handling is a nightmare. shmem_undo_range() is
>>> such utter garbage it makes me want to cry. I mean, really, WTF did we
>>> end up creating there. Does any expert here have time to clean that up and
>>> make it *actually* maintainable.
>>
>> Agree. :) I'll re-read shmem_undo_range() and take a close look at the issues
>> you raised, and see if I can make shmem_undo_range() more readable.
>>
>>> The following things are still broken in shmem_undo_range():
>>>
>>> (1) Truncate/punch of a single page of a large swap-error marker
>>>
>>> We don't split. Consequently, read access afterwards will still fail
>>> instead of returning 0s.
>>>
>>> I have a fix to try to split (which can fail), but I don't consider it
>>> that urgent, really. So I'm not including it. Might send it later
>>> separately.
>>>
>>> Truncate/punch of a partial page can obviously never do the right thing,
>>> as we cannot poison parts of pages ...
>>>
>>> (2) Truncate/punch whole pages within part of a large swap entry
>>>
>>> We try to read the entry, but if we are out of memory that might fail.
>>> Consequently, we will not free up swap space and a re-read will not give
>>> us 0s but the previous content.
>>>
>>> AI proposed a nasty NOFAIL patch which has too many nasty side effects
>>> IMHO (allowing users to force-read pages and retain them afterwards even
>>> though memory.max would disallow it). This needs a proper thought. Likely,
>>> support for splitting large swap entries (and large folios in the
>>> swapcache, which I recall is under development  by Kairui). But splitting
>>> can fail ...
>>>
>>> (3) Truncate/punch of a part of a base-page swap entry
>>>
>>> We obviously have to read the page in, in order to 0-out the parts to
>>> discard. That might obviously fail.
>>>
>>> Maybe we should install swapin-error markers if swapping during
>>> truncate/punchhole fails, to at least tell user space on later access
>>> that something went wrong? We might affect unrelated data, outside the
>>> requested range, though. Anyhow, these are long standing issues and
>>> I don't consider them urgent.
>>>
>>> They need a proper solution.
>>>
>>> I did my best trying to test these fixes. I was able to reproduce some
>>> of the things (including unkillable truncation hangs), and the fixes seemed
>>> to help.
>>>
>>> But again, shmem_undo_range() is just an absolute mess.
>>>
>>> Please prioritize review of these fixes, I want to get fixes for the
>>> issues in a timely manner upstream.
>>
>> OK. Will review and test this serires this week.
> 
> Thanks!
> 
> If there are better simple fixes, please do suggest them. Any bigger cleanups
> ideally come on top.

Most fixes look good to me. I'll verify the remaining 3 fixes tomorrow.

> BTW, the next time I get a flood of these patches, would you be willing to do
> the early screening+revise? But be careful, some of them are pretty, pretty awful :)

Sure. I'm happy to review and maintain the shmem related patches.
