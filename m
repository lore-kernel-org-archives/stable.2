Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793410937;
	b=2xdj9nYO1Q2pbEux7mByW546Sv/x/w+SAOAgaiv62oFARH0lri43iEvYAMQieqrA9p5w
	 O0pR7pHdb3NRy5MlwIAg594CUXjnSjG49RCLbuhdf7pQJsPG5B6X3CzTVvcnEmdo7qNFc
	 XpYQXz5h1VVkFfm01mWWiMCyQY9CgCgHfGnLaz24Sxr3bTnoqcstpQkyIWFvoCFnHPhqQ
	 CIc+qjxEKlsfqxMjXUbx/kk8ymhOxHzng9zXcC8vWJKWziAE9/s2WjsO7+1tFPKyCKSdZ
	 DnqDt/EQbbczNZzVm2thhUXUHHRg1bLRwT341f42LjKdEfaMJfNHXotCDcDa9i845jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793410937;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=i5beK/wqta6fa7ekid99EnBANYB7xsLLW6wDEnyFugQ=;
	b=Xy6WJclyLo984l6a96gVIoBc1Vh+JS44B5UWlarWbL6UpLaYehEN+u48OY275r593ECA
	 uJvPQK+jU+Ja0+OvGSVr2PD8xSoIacK69TUPgnvo5datSt8lwFqotCQwN4VFC1iUlUZ1P
	 8LwQn1kcntk5YO+Tm4nSwqDZqIM3UXNXHRiuod5sJ2gpRlULPSutTJ5ue1IvZ2VvNNxdR
	 0ZBSwTP0K3T+hxHHymYp+7gWoUvPN2JQ6LGQ+P064jpTqsi8cVx+anQ6zL08drvfznc/j
	 LyexXOT2CsBC40xhYZ3FhLHEAfLXDey42klHa8QailxwOt4IRZMRdDGuK9I5VicqKBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i4RxBCx4;
	arc=none smtp.remote-ip=95.215.58.18
Received: from mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90C606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 01:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB90C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i4RxBCx4
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MpJ2KknoxvhydMM0mBu6hlDwlGwxhQOvcnm75Ft8d4M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793410933; v=1; x=1794015733;
 b=i4RxBCx4+vXFIwhiP6CNwflbt3rAtoBok+EdOFAGJXqPkgnid6trH1RYGNUsz+s0B79enYr8
 c7kWo/qZ/bkJtum4X3dvnr5XpPJDNhEMkqmtbV5EHWkoKh7AlaPIljgPOcsVoG9ZsLRhFMyZGU8
 PtnFVSvFeTCx34K90DjAn8LY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bee3307f5ff8da89;
	Sat, 31 Oct 2026 01:42:12 +0000
X-Mizu-Trace-ID: bee3307f5ff8da89
X-Migadu-Flow: FLOW_OUT
Message-ID: <febf6aeb-82dd-4a98-9a33-0ef321792285@linux.dev>
Date: Sat, 31 Oct 2026 09:41:50 +0800
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
Subject: Re: [PATCH v2 01/47] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>, SJ Park <sj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@arm.com>
References: <20261030002004.154595-1-sj@kernel.org>
 <6d679adb-a866-4a76-b9ea-3b8c64171fae@kernel.org>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <6d679adb-a866-4a76-b9ea-3b8c64171fae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/30/2026 6:21 PM, David Hildenbrand (Arm) wrote:
> On 10/30/26 01:20, SJ Park wrote:
>> 'get_maintainer.pl --nogit --nogit-fallback' suggests adding below recipients.
>> But I can show there are already quite a number of recipients, so I'm just
>> noting here.
>>
>> - Brian Geffon <bgeffon@google.com>
>> - Oleksandr Natalenko <oleksandr@natalenko.name>
>> - Steven Barrett <steven@liquorix.net>
>> - Yu Zhao <yuzhao@google.com>
> 
> The CC list was so long that I limited it to people that area either a reviewer
> or a maintainer of code.
> 
> MGLRU not having any real maintainer is a big problem; because that maintainer
> would know whom to CC.
> 
Agreed. FWIW, I think Barry Song and Kairui Song would be good candidates
for the maintainer role.

Both of them have been contributing to MGLRU consistently and
substantially. Barry is currently working on improving aging and fixing
the swappiness-related issues, and Kairui is driving the MGLRU-FG
optimization work.

They have also been active in reviewing MGLRU patches, and their review
comments are usually to the point and helpful. They have been looking
after this code well, so I think they would be a good fit as
maintainers.

-- 
Best regards
Ridong

