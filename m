Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094282;
	b=Jr8y55qxj/VjaG8oiymM9KYa9n7tusiRrX9SOG9UKGvil/diUNKDGNllqtVbvVl19LOj
	 6JerygU6l3zifbDt7V/ay5qYmU934EAh7+1IACX2DD/tYl2Athr52knEgFsHyF2aEIdHn
	 Si7pBA5o6T0LySOdTykoPp7FDA2aA/DG2YJoa1QRR7lgKpAqNr126g2JbkbPjH5E4BhgJ
	 tycHC2sCrQyLDI+OH/Hqbzsa93wmjnM/kRCnOb/nZH9ZZ2J8o00dyHHTL/upvAvSXacqD
	 SPug9fCcZP0OyNF/1pRbBbVCzK3aKWqcIkUhPYN2GoZaFIjpuXvzbed/hdIHHeFDIBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094282;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=+gg4vR3fmVnG5maxAfXCLUk2K7fJTSLOiXsuwQyP13c=;
	b=JNv2/1kmd+qokGXIrUWLBtoIT5elHRpbQomn2Fu+Tp8NzCwCkFF5yHHmFq0nJqhclqIC
	 cQ/a1pJuwqmW3mhPsRAU0ElNcZusqangIEWVO8obXKLogNQg70EN9Du3uccOfEPu3d4wt
	 CF9l417dsBwaRB3qtbed/CeYuUW6FnIaxDILbKnYnE/XsmSVfrYNR5TwRBQNpESN2SokD
	 zCR8XdJvPuNquLa9kNUc3v+b913ECfoKqxz4Pnu9zzXkS9Wpl7mlH2W6qqtgIVIXrWVyd
	 5KApoj/Tv2ytI3Rs6I3wZpTtTiRlwGt6vsGGrUbVaR79aZlz3VprAEai2knc5vPAaVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gNzLclvd;
	arc=none smtp.remote-ip=91.218.175.122
Received: from mta0.migadu.com (out-122.mta0.migadu.com [91.218.175.122])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C00606A32F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40C00606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gNzLclvd
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+gg4vR3fmVnG5maxAfXCLUk2K7fJTSLOiXsuwQyP13c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793094279; v=1; x=1793699079;
 b=gNzLclvdu9m1gyvv0pSAmIjLpny2p0E4lbCIgdharCug0gruLgksOqUPZHjJjYvzCRrMZEqZ
 BhMKbq2Tt5gWy1KtiCZ7kwh9wWR1Po4osGjY8vUU/f1n8v2J0dH2J2mW12ceWGdmUh6+8ngwqDK
 /m6YU/MKq9hmnUlKgC7g+22I=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id d06deef23f08d73b;
	Tue, 27 Oct 2026 09:44:38 +0000
X-Mizu-Trace-ID: d06deef23f08d73b
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
Subject: Re: [PATCH 22/46] mm/gup: check for overflow when converting nr_pages
 to bytes in GUP-fast
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261027-fixes_core-v1-22-6f74bec9a5bb@kernel.org>
Date: Tue, 27 Oct 2026 17:44:07 +0800
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
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD785D08-2054-4DED-9EC2-A7464BAAAFE0@linux.dev>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-22-6f74bec9a5bb@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 27, 2026, at 07:17, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> The overflow check in gup_fast_fallback() only covers the addition to
> start. The preceding nr_pages << PAGE_SHIFT can already have truncated
> the length on 32bit.
>=20
> Users such as RapidIO's rio_dma_transfer() can derive such page counts
> from a 64-bit userspace length.
>=20
> Let's just check_shl_overflow() to reject any such overflow with
> -EOVERFLOW early.
>=20
> Fixes: c28b1fc70390 ("mm/gup: reorganize =
internal_get_user_pages_fast()")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

