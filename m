Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365828;
	b=ScSZcWhrm7bPpqh5LBLUd0zXtpnCWsusawwgJdsCKUeaxxZaRM33cXrTehABSEiZbzKJ
	 hrrSpAYOh0O0wY1JQF3nYKVLCGSD3pSIwwjQEQ6g1E8v4KwxNrl+GLgM8XNZqxK8BRWAz
	 S0XknnLVivU5yaFwlO9uIUXfgwt0wT1O/bflzhjzP5IjD1qQnAlS/p4YZVv/P120wQ24U
	 kXIo3HRKW4k+uaWAPeKx6f/5ECRcgdHthaS+3rb9N2Xk13KWn0xo19QxL3HUZHH6gS+aJ
	 ckeEiglidXvJRNvVXzAJaPzmd25XMbTDIElJYK/OfE7XIv9u00LxlD3Ztxky3Ej5oSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365828;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=BIsmxaqlcIiqqe+DfpItRAhgOJbkWsY0ZSYuASH2dgo=;
	b=mlledLjTA+bkvAn0/d8AaJo5Ih04+uAL5J+dtprMe97wNfKYr/72xZVWIgU+B3AMSkvK
	 SIYd5z9Hsg5e5622RhbndFzEVHtpSnVKDSNqzXtLZwoV+Q0f5+k1dxvnjnwwmmpGmgL11
	 4LHHoJZTTBklYrk2Cpi0mEQL7oPx7IMU9W6b78HrmbqbxidbPGRqLZEn7OChviauEfWa5
	 ZT9oJJlB24CvrWtoC8wqjJdYzKX1T8uI6TLRvWKd9W65oYJDCsQysJeLlaTmZtZ1yBWjC
	 MwIBvbdFOQanuk7eHylJUkIItg5wXLb5mzk7twbij7ZV/Nrl7xZ98JJSKTQ/iEbtb5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE+UcR4O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60F606A31E;
	Fri, 30 Oct 2026 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE+UcR4O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF931F000C1;
	Fri, 30 Oct 2026 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793365827;
	bh=BIsmxaqlcIiqqe+DfpItRAhgOJbkWsY0ZSYuASH2dgo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=aE+UcR4OtmI1gsAuleOjFb68pLXXLXkRQbAWvngo171T2MUUuwjy+lrcz2fa900Oa
	 4jrYfKABe2JsUQNDDMr8LHMydxA2OR4eFUP0n+okjO+fCYNkr2t0oFDX3OZbWNsHkc
	 9FOki2qP8o1578DoVS6j4Ha2l9nKWXo/PwQLeofhbAptMNLznIZcalKf4CfY+TsEU5
	 ko938kjuwV+SzeAc1oCkdQMWrUvfCXsLdHLlXHlbAX4d2Qvq1JA8oZU/MBsn4zu9iH
	 /mYszUAhgaZ3QvOiktJYjo8pq2d+/cDPxcPeXZHq7P6jbizyjM3/JsXTfeJejutH0+
	 QVqpbytwntPyg==
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfauth.stl.internal (Postfix) with ESMTP id B22B6780043;
	Fri, 30 Oct 2026 09:10:26 -0400 (EDT)
Received: from stl-imap-13 ([10.204.2.104])
  by stl-compute-04.internal (MEProxy); Fri, 30 Oct 2026 09:10:26 -0400
X-ME-Sender: <xms:QpfkaudgPlWfhG2nuX5v0oYxnFnd34OSZvAUv1UZVpB12tHv8EreXg>
    <xme:QpfkajCgIdn2T-PjuQzu2w2WrYYDqpLVkhxKQrSCYdBa1aOg3t5bIjhv1fn84uU-X
    gWui-BFJypI5jHtbfxKx9anlVeSzOeMnJ9FBaX8ytr50BFBoJ7ChA>
X-ME-Proxy-Cause: dmFkZTGh/6azztQX4EjOpOWsP9cU87M/GO2aoMRhBpjxyvA9Mgxud2UfYibhs/CNwlNrxR
    OVYhQ00dRta7xjyTz8NtYoTm7ScvixKhrCgmB14JzOz0EI/mP6fEi8NWTuMHhrcDaZeBk1
    YaQTwyUEgXvrrCojrJE/qHFnsqVSnKBrUgjzGmjfEQsz/3lIybZUkOsNLIPE9CqfqBx7Ah
    c24qnXX2j9fLPh5cewjKYtSEE+5zOGLldi7n9WyLyT2lALzgx/t2uBwk6YlpgQtoGaFAlv
    yB2TdRcPZQLT6XQVgCOGmWsKCe+r6lBRqzeLlPt7JfBlWSjnTHhGNl3PrxEWFRylHy3lYf
    kpptfFm+LkbmYdnqv7oT9qRe6teuGi7QOqfk5YudV2k5/qHerwrD5mfpc1QxohxNmdHQ67
    yj8Rz7kBIydzzYNKrzYQKqbQXg0kSF8IHV2N8ZkxHRhLt4+XOPrRrgms7SZ9do1Qu2fOEf
    7gKxf9P9fbZ/DgTar35vJ2bvnTZ317N7Y8UTtBnGUltw+RKrdEC4+6AQZMWYfuqSibj6JM
    96wE3O2w5if218SI9BPq+AC04w4C8BL1PIZ2E3PLHYgJEITmt5yhSABPu0OlnexaD6/LLQ
    jwjzjRs+epVjfmBA0tpujtP4JNG/zdq0IHpXR7m2kfDQlL4Dtjw0AhljJPGg
X-ME-Proxy: <xmx:Qpfkat0lFMgtIn-egodGPRZg50OJO_gN8Ozpuq4JeAFHSOZDyFLdGw>
    <xmx:QpfkakdhY6IUI_POEWnR2AytGl7qggQuuGL6GirIVsyTlrDwSSoTuA>
    <xmx:QpfkavBC5Cv9FH0260FxTRXt_JzcSeG3bnfgZiX914OEIxY2vrWv9g>
    <xmx:Qpfkam3RZTfgcCrKd5Jr7vSiAo8ay2X3TiHRB67g5-Wew0ciZZ1vZA>
    <xmx:QpfkavMdLUJ1qZO3QO5a3wtqeItG9O9oeeqToDsDHFEcmk4CL7Mtt8M3>
Feedback-ID: iccae4b50:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 59AA0F6007F; Fri, 30 Oct 2026 09:10:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: Aey4jMk1dEgs
Date: Fri, 30 Oct 2026 09:10:05 -0400
From: "Chris Mason" <mason@kernel.org>
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>,
 "Qi Zheng" <qi.zheng@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "Kairui Song" <kasong@tencent.com>,
 "Barry Song" <baohua@kernel.org>,
 "Axel Rasmussen" <axelrasmussen@google.com>,
 "Yuanchu Xie" <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>,
 "Baoquan He" <baoquan.he@linux.dev>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Kees Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Jann Horn" <jannh@google.com>, "Pedro Falcato" <pfalcato@suse.de>,
 "Hugh Dickins" <hughd@google.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Pratyush Yadav" <pratyush@kernel.org>,
 "Matthew Wilcox" <willy@infradead.org>, "Jan Kara" <jack@suse.cz>,
 "Zi Yan" <ziy@nvidia.com>, "Lance Yang" <lance.yang@linux.dev>,
 "Rik van Riel" <riel@surriel.com>, "Harry Yoo" <harry@kernel.org>,
 "Alistair Popple" <apopple@nvidia.com>, "Nico Pache" <nico.pache@linux.dev>,
 "Ryan Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>,
 "Usama Arif" <usama.arif@linux.dev>, "Kiryl Shutsemau" <kas@kernel.org>,
 "Matthew Brost" <matthew.brost@intel.com>,
 "John Hubbard" <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>,
 "Will Deacon" <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Nick Piggin" <npiggin@gmail.com>, "Oscar Salvador" <osalvador@suse.de>,
 "Minchan Kim" <minchan@kernel.org>, "Muchun Song" <muchun.song@linux.dev>,
 "Xu Xin" <xu.xin@linux.dev>, "Chengming Zhou" <chengming.zhou@linux.dev>,
 "Chris Li" <chrisl@kernel.org>, "Kemeng Shi" <shikemeng@huaweicloud.com>,
 "Nhat Pham" <nphamcs@gmail.com>, "Youngjun Park" <youngjun.park@lge.com>,
 "Gregory Price" <gourry@gourry.net>, "Joshua Hahn" <joshua.hahnjy@gmail.com>,
 "Rakie Kim" <rakie.kim@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 "Josef Bacik" <josef@toxicpanda.com>, stable@vger.kernel.org,
 "Thadeu Lima de Souza Cascardo" <cascardo@igalia.com>,
 "Mani Tofigh" <mt4022@columbia.edu>,
 "Samiullah Khawaja" <skhawaja@google.com>
Message-Id: <ad0d82f5-c2ad-46d0-986d-94626faac1f9@app.fastmail.com>
In-Reply-To: <bc8c1fc5-4620-4515-8520-22ebcd0d592a@arm.com>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <2f23dafc-43a5-47c9-a819-e696cda6fd44@arm.com>
 <baeda061-e0d0-4be1-9aa5-8886182ca83f@kernel.org>
 <bc8c1fc5-4620-4515-8520-22ebcd0d592a@arm.com>
Subject: Re: [PATCH v2 00/47] mm: various (urgent?) fixes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Oct 30, 2026, at 8:12 AM, Muhammad Usama Anjum wrote:
> On 30/10/2026 11:35 am, David Hildenbrand (Arm) wrote:
>> On 10/30/26 12:19, Muhammad Usama Anjum wrote:
>>> On 29/10/2026 8:32 pm, David Hildenbrand (Arm) wrote:
>>>> See v1 on details. TL;DR various fixes :)
>>>>
>>>> Thanks to everyone for the review! Hoping I can get some more? :)
>>>>
>>>> I am planning on picking these myself, moving them to linux-next fairly
>>>> soon through mm/core.git.
>>>>
>>>> ---
>>>> Changes in v2:
>>>> - "mm/memfd: check for real shmem inodes before accessing shmem state"
>>>>  - Call it inode_is_shmem
>>>> - "mm/truncate: look again if a folio left the mapping"
>>>>  - Different fix for truncate_inode_pages_range
>>>>  - Adjust description
>>>> - "mm/huge_memory: fix zapping migration entries for device-private THPs"
>>>>  - Move handling in zap_deposited_table
>>>> - "mm/mmu_gather: fix flushing ranges with 4 GiB or larger"
>>>>  - Adjust description"
>>>> - "mm/huge_memory: split huge PUDs when adjusting VMA boundaries"
>>>>  - Drop split_pud check
>>>> - Link to v1: https://patch.msgid.link/20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org
>>> I ran Fastpath, a Linux kernel performance benchmarking framework, on
>>> this series against mm-stable on aws-m7g.metal. (I) and (R) indicate
>>> statistically significant improvements and regressions, respectively.
>>> The results show 10 improvements and 1 regression. Other, unmarked
>>> percentage changes can be ignored as statistically insignificant. Hence:
>>>
>>> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> 
>> 
>> Thanks for the results. IIUC it's schbench that shows a possible regression.
>> 
>> I would expect that no changes here really affect performance at all (neither
>> positively nor negatively).
>> 
>> "mm/huge_memory: fix list corruption when deferred_split_scan() races with
>> deferred_split_folio()" fixes locking, but I wouldn't assume that this matters
>> at all for this benchmark.
>> 
>> "fork: take mmap_lock before copying mm_struct" changes locking, but I also fail
>> to see how that would affect the benchmark.
>> 
>> Maybe some code layout changes just affect some benchmark on some machines?
>> Because already seeing 10 improvements makes me wonder how that could possibly be.
>> 
>> So I'll move forward with these fixes for now and see if we get more reports and
>> could identify actual problematic commits.
>
> Yes, these improvements/regression might be because of code movement and how it
> has affected the run time performance. Most importantly, these results show that
> there isn't any drastic affect on performance. These fixes are good to go.

This schbench configuration is going to be really sensitive to process placement, and it
should be doing all of its memory allocations up front.   I haven't done many schbench
runs on this type of hardware, but I'd agree this result shouldn't indicate a bigger lurking
regression anywhere.

-chris
