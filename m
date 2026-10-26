Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016755;
	b=ghHbgaIINk+RPwxgmE8yNg0HKTa/02ZU3YvmQH/dxNyUnNavI0q37eLCF2QjJqXCCm1H
	 tZbm3sPTqdwlWzkNCUV9wcj7jaWtZYaXLzY/fZu2w0HD/fDzW/EeSxsw+YWfiAIwXylb/
	 5upz7+4RkSEqpw76YThXjBODLcgfvTa9VLMm1Ue6ZNbXiGMeiRyBHqKGIrkWFmVKOkfKM
	 PGk+Y453qJ/B2wzlKFBkzXj/b4xy8rA7S9nEsdkTLVQNr64naB5v4keDA87H/FCGTP8L0
	 5nn880fp3gw1+ZN0vjE6eNNvpdyQqHEeqORrDGxn8uPoMmaKj48dBx2kiVVvLmRqHCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016755;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sCtZvtAR22Ami4S2eIk3HMfDGlAC6il3qa+TGty4veQ=;
	b=tjWUyn3UIo9OdS0wPetbRDFRqzuGTJzcBA7yGDaueVzmrTdN9neQb2thoajQrVICaNzi
	 xJADSOnPYNYtWMjfJpbUo8Dt13NcfqhUQ/hXEul0+5l50Pn4IKZmxRPINzT8cfOZ6gxQp
	 IVQod9MJB/g9P8Mj6FqfcVBSww4MlYhXhgCJ2jBZTe1tKMCcKyp7NJEGE6jtFKreUTRMm
	 oGnwKCyYeWd7UzrZbkXBq1hS/cRQ1ibVSvEx9NdokjZ+igzqH/tYV0TEKzXru0MEgL8yk
	 /zlL9oh8zz535taT5/zIKfplNphWCXwIfI0qSa2nDLbWMq567P3zF/0nkXrTpCALvgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5hXer1y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522D4606A333;
	Mon, 26 Oct 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5hXer1y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF3B1F01825;
	Mon, 26 Oct 2026 12:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016754;
	bh=sCtZvtAR22Ami4S2eIk3HMfDGlAC6il3qa+TGty4veQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J5hXer1yoooeUjppZ6vg8NVJpK4TPTZVdh9mBwO8PTZfOuoo4QYTexYN5v+PEzfkn
	 +TkbN4+MdUGit7k3nxjDNTPx8XlLTmXCOWgk0q2jT0c6clk4Y+U204lwBOg4QpKeTb
	 2GrghX99FnCH1TA4q2dZ42c0kJQsGRxKR+N71jDq5SPhPn2abEnXgHtfFFbV3dCGpJ
	 ZQby89YbBNK/CL7OkyiRCB9dXnyaZV7aCgMFQmE7ikIFxWmT3ZBZCV6pY1hl3k8x4B
	 +VChZ6FM7OBEfqPxPtdnRfDXLcbT3EA2eUVGeSOVcQT4WGvNP89jipV5fpMMyTiwEe
	 6vW1Y4+W21ACA==
Message-ID: <1398e842-db91-4482-949a-e21197a48b9c@kernel.org>
Date: Mon, 26 Oct 2026 13:12:02 +0100
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
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
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
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <a8f01101-7d7d-4982-9cf8-04b754ba132a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/26/26 12:11, Baolin Wang wrote:
> 
> 
> On 10/26/26 5:40 PM, David Hildenbrand (Arm) wrote:
>> Hi,
>>
>> the fixing fun continues.
>>
>> This is a handful of fixes for shmem/tmpfs. I sneaked in a related
>> hugetlb fix that stalled upstream.
> 
> Wow, thanks David!
> 
>> Some of the stuff is more urgent (patch #1, F_SEAL_EXEC, truncation
>> hangs), others are less urgent but still rather unpleasant.
>>
>> The majority are fixes from Anthropic that I cleaned up or reworked.
>> While doing that, I found a bunch of other issues and tried to fix them
>> somewhat cleanly.
>>
>> In general, shmem + swap handling is a nightmare. shmem_undo_range() is
>> such utter garbage it makes me want to cry. I mean, really, WTF did we
>> end up creating there. Does any expert here have time to clean that up and
>> make it *actually* maintainable.
> 
> Agree. :) I'll re-read shmem_undo_range() and take a close look at the issues
> you raised, and see if I can make shmem_undo_range() more readable.
> 
>> The following things are still broken in shmem_undo_range():
>>
>> (1) Truncate/punch of a single page of a large swap-error marker
>>
>> We don't split. Consequently, read access afterwards will still fail
>> instead of returning 0s.
>>
>> I have a fix to try to split (which can fail), but I don't consider it
>> that urgent, really. So I'm not including it. Might send it later
>> separately.
>>
>> Truncate/punch of a partial page can obviously never do the right thing,
>> as we cannot poison parts of pages ...
>>
>> (2) Truncate/punch whole pages within part of a large swap entry
>>
>> We try to read the entry, but if we are out of memory that might fail.
>> Consequently, we will not free up swap space and a re-read will not give
>> us 0s but the previous content.
>>
>> AI proposed a nasty NOFAIL patch which has too many nasty side effects
>> IMHO (allowing users to force-read pages and retain them afterwards even
>> though memory.max would disallow it). This needs a proper thought. Likely,
>> support for splitting large swap entries (and large folios in the
>> swapcache, which I recall is under development  by Kairui). But splitting
>> can fail ...
>>
>> (3) Truncate/punch of a part of a base-page swap entry
>>
>> We obviously have to read the page in, in order to 0-out the parts to
>> discard. That might obviously fail.
>>
>> Maybe we should install swapin-error markers if swapping during
>> truncate/punchhole fails, to at least tell user space on later access
>> that something went wrong? We might affect unrelated data, outside the
>> requested range, though. Anyhow, these are long standing issues and
>> I don't consider them urgent.
>>
>> They need a proper solution.
>>
>> I did my best trying to test these fixes. I was able to reproduce some
>> of the things (including unkillable truncation hangs), and the fixes seemed
>> to help.
>>
>> But again, shmem_undo_range() is just an absolute mess.
>>
>> Please prioritize review of these fixes, I want to get fixes for the
>> issues in a timely manner upstream.
> 
> OK. Will review and test this serires this week.

Thanks!

If there are better simple fixes, please do suggest them. Any bigger cleanups
ideally come on top.

BTW, the next time I get a flood of these patches, would you be willing to do
the early screening+revise? But be careful, some of them are pretty, pretty awful :)

-- 
Cheers,

David
