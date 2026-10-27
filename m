Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094664;
	b=a+ph9Osv+TusQQGwQ4GUAu2sLSbj+jcbqJVblbL7+fOHE8BO57YLo6tDHkYOoX+6Ek60
	 C/lV0OX96wwbiSjgOCipRH8VdpFgj3mi1+Z25wdn28ZHkaCSeN4zpVVzZjBEk3+ANn4g9
	 6EXCIhTS390BRdo4UzmgKeJm8XkdhwiRCPm829p+tDb56WCHgHIj98mmcgMg7gVd3xXLu
	 4LcpBeaAF/GyYaWB8rugwhqLIB6qasLxPeYiVQna/KbZh4fMqv4VuJXChzOFqCfdkO/p8
	 nx61X/UKnf4JuwgkQe7IPOIpQwxH3ZS0ugZy/OcTJJMUbd5EGPcAKLNJ0J8LQzX3mWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094664;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=YikRuHrgcQQEQeNLoopicKeEponOUqqAXOCmGgP7bMc=;
	b=DeIuivzm7WdmlATtkv9D6mGQxZprXpp47kch8n5dtlJxkCuB5Cs214sKqk1vKExHRSN6
	 qMKdH/9XP3GpvF9Y7HiaPgAYjLBWA/u/Zu/ach5umS9+SJ4/tHcvAVIrl4xs0OXEzWoXg
	 +wBqAk94/GSOlmtoufyIKtlsZwNdYwYRevsD/uSGEKNZyR52VJrDBRMzkwyWBI4hi2neW
	 VA5J5fn8HOlBFUqrOWdJUvdCnDi0dmzPHGqTaN4r5U5C+5nrS8CCmyT90wT+O5LhKfdAN
	 73hHe5APjwiinwz2CTwW5ixu0KZGWx4M+JOKqvqZ+sk3L3IJJoOlVpgohJ13PEmMHuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IK7uwDYg;
	arc=none smtp.remote-ip=95.215.58.25
Received: from mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87607606A321
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87607606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IK7uwDYg
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YikRuHrgcQQEQeNLoopicKeEponOUqqAXOCmGgP7bMc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793094661; v=1; x=1793699461;
 b=IK7uwDYgWnddzMvKWJw3ya6jd1O95pxiSUka2B+d5LCvMVJF0eAMpUph7VCpo576csv7uSk+
 RkWa1+WT24INtT8JnumhbrIqAEhPNriR3IJ5BOtfXhCFSYVDbHBk/S3Oe6w++M3F5lyKhOZXvxs
 0YEaxOC7g+vVBRZSfwe0o1YE=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 7697935976e69603;
	Tue, 27 Oct 2026 09:50:59 +0000
X-Mizu-Trace-ID: 7697935976e69603
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 26/46] mm/mmu_gather: fix flushing ranges with 4 GiB or
 larger
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
Date: Tue, 27 Oct 2026 17:50:32 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>,
 Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>,
 Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>,
 Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>,
 Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>,
 Xu Xin <xu.xin@linux.dev>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>,
 Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <377FB184-1E61-4BF8-AC3E-33A79EC56658@linux.dev>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 27, 2026, at 07:17, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> From: Josef Bacik <josef@toxicpanda.com>
>=20
> __tlb_adjust_range() takes the size of the range which has to be =
flushed
> as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), =
get
> and pass an unsigned long. Consequently, a range that is 4 GiB or =
larger
> gets truncated, possibly to 0.
>=20
> On arm64 with hugetlb, a 64k kernel can flush 16 GiB hugetlb PMDs, and =
a
> 16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
> at least these two scenarios are affected.
>=20
> Fix it by flushing the proper range instead of the truncated one.
>=20
> Fix generated by an LLM and sent by Josef Bacik in private.
>=20
> Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for =
handling hugetlb pages")
> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when =
unsharing PMD tables using mmu_gather")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: use two-tab indent, simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.

