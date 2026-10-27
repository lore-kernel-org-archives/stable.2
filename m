Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094531;
	b=mRb3A0LPiQJnCw/pYtGQjZFcIVc1zq0Q1cE/S5l8kqoQ3jXWn3wLwrBr60epBjD9Dh6S
	 bTF6bCXmEJIDgUDtjthHA8283lRm2x4eW+YAR3DdVTTpmrPkqAJJYkHKZQy4pTD2upRjM
	 MYpVRogVGDqT/VCgt0cGxNqYNZdw8Nduxg903gn+fJCM7RZ7bxMPo7dtrKQajWwTOPAbX
	 5vEIIbRz3NHRWRGClZRNnRFgwa+71s9ltCMEM5gEJOmRNxj0F8lZ4b3zhZO+Lcay4egrN
	 UNiOZiyY6S1oSPv4NMDhHFcvEJ+wHud1/0QiTe4rsXv9TN68G+oRejmj/kgaOFDXFYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094531;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=w+/m5TRiUEroTYi/JhU/ZMYvRJ27fL3IgAeL8IYLhOs=;
	b=xF6acuxfLslUfDqotpZjVtBgcXVC6UiHmJYTALfiZoHyZcYcROL83nRl3yPFiChLQADL
	 uR3HMhvc+rKWjgg7Rdt8p1qXJw0Orq63kpFtCboIehuRiD+oU89YykloDo4CIInowtcVW
	 yPrxqZaMZjIXoeZyWX//TCtIma4wpZrfWXKdH0VsOFVvInKOTvv92j3myhaTOcja4ceJs
	 c86K7uYnbBJLw2gmxMqd49HJuD6nli/8v790o5VhOHlCyOPSQFuDLF1186OsGOAfTJlcr
	 tgc2J0QdM8QLU4yqtoCfLggxezIew1DK8u3KFekcylNWk/tcolUXB0j6uq5VwHCwDaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M5HfFoAj;
	arc=none smtp.remote-ip=95.215.58.137
Received: from mta1.migadu.com (out-137.mta1.migadu.com [95.215.58.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553D606A320
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4553D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M5HfFoAj
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=w+/m5TRiUEroTYi/JhU/ZMYvRJ27fL3IgAeL8IYLhOs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793094529; v=1; x=1793699329;
 b=M5HfFoAjUDnRgQrtlqwxlCzg/yUz3ct1gnJFOAIpEV4mZEEV3dK1BLmaugjdYXhR6Y1192oO
 bvxwaI9qa6LHkm0LAQTLWGbPluusZ6PGzBIq6PiGDoL/kcvoOndbK+wUxRwtkmmdvKO7NuAJ/E3
 CZvZDj4wGfkHNKwOBZvMDrNc=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 74e52af488cb4c06;
	Tue, 27 Oct 2026 09:48:48 +0000
X-Mizu-Trace-ID: 74e52af488cb4c06
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
Subject: Re: [PATCH 44/46] mm/cma: don't release CMA pages still in use
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261027-fixes_core-v1-44-6f74bec9a5bb@kernel.org>
Date: Tue, 27 Oct 2026 17:48:18 +0800
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
Message-Id: <C94DBF32-62A3-4010-808D-DEB2E17DC552@linux.dev>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-44-6f74bec9a5bb@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 27, 2026, at 07:18, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> From: Rik van Riel <riel@surriel.com>
>=20
> When a driver calls dma_free_contiguous() before quiescing DMA, the
> page might still have a reference from the device.
> put_page_testzero() there returns false, WARN fires, but the code =
proceeds
> to free_contig_frozen_range() putting a live page onto buddy and =
clearing
> the bitmap. A subsequent allocation can hand the same PFN to a new
> owner while the original holder still references it.
>=20
> A concurrent put_page() that drops the last reference between the
> testzero loop and free_contig_frozen_range() can double-queue the page
> via page->lru, corrupting buddy lists.
>=20
> Avoid the corruption by not freeing a CMA region if any of the
> pages inside are still in use.
>=20
> Make it explicit in the warning that the driver allowed a leak.
>=20
> While at it, use page_ref_freeze() to make the semantics clearer and
> switch to pr_warn_ratelimited().
>=20
> Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Link: https://patch.msgid.link/20260811132045.5f114772@fangorn
> [ david: use page_ref_freeze() + pr_warn_ratelimited() ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks

