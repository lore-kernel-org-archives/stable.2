Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094448;
	b=EL5PebfpDdQoBUuvnU7ZuLS15b3I8bHNLLd9oEuYPEB3L17jYzSmFrQaDKO429qpbp/E
	 wu1ERIMIQlHbRiOMLVUP13nVQ05Foqfd5ejxbZy9f7yUETpeoNRRSqufWoAbZzergHuAj
	 I1ASlNu6tmWri4ka5xg+sohd5MKp4ePWveBMiT+8DfHfv6Y2xeuvQxz5HIE0A6svTX5N8
	 47/su4k7GpgbQyJOlxNMH2/RP1+4p6DLfZ2Vlb45De//DxoHDjZT4bzkvvunzA3TjrVS0
	 NtRpWDRQBTM4cZlUKeHlCKlSddAMLMbXIGWIrEShMkcXjF1+lX9rRUc2EiRqMPC2VTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094448;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=vkRbVEYH/IpHfx5799qbaRy/Rz2dM/B52EsX44m71XA=;
	b=BdBvnq6lyQ3ay2A8GuOoNxoinFasr1cPgHJin5ntqsCxxZQWDRrOArdUsqZ3yVa00H6C
	 pRrK2zDAf/PWr5ZfP67Uu7lLYi5aZ1uawQyFIKtIUdmn7h81qeLovwLq4aUh85O/4CVJQ
	 x+2qJlZT8U9E5zjnIGh+a+F+aVsAgpd7OduBzrKktpVRmbntM417UgUn7YaLL7DDDhrFM
	 e2gKDYGIg8oU37/Lz+90gp6q5Zab4lYe/h2xw4CsG8y5IwFFVeZnjArd4rt15CLZtDGre
	 Iy9saH0M+EUmPb4IT3npJAlh0h2qjyH3MkSPgn782urasV88uv/vDiXn8c/VFoWdh/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="ayiRgza/";
	arc=none smtp.remote-ip=91.218.175.179
Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A2606A320
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 361A2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ayiRgza/
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cPhbwrLxrBeT9JsGny5RJdPlGOD/1Ehjle0H8Uiu/2w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793094445; v=1; x=1793699245;
 b=ayiRgza/GxxmiVI9rgFsykUvChZWAtRADU5um6RBV71Km8e1c4L5jy/cPURegap7ZDCx6IFM
 bX37cSFeF5CycBHA7SWLRaiZAOMH3jO6XedepEVuCZJjsKpGXjjrmoB32a0QwIDJDb6RMbWFhbi
 OUBk4/abpc9TguYGICF4Oc9k=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 4eebca5cdaffa06c;
	Tue, 27 Oct 2026 09:47:24 +0000
X-Mizu-Trace-ID: 4eebca5cdaffa06c
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
Subject: Re: [PATCH 37/46] mm: fix deadlock of mremap() against UFFDIO_MOVE
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261027-fixes_core-v1-37-6f74bec9a5bb@kernel.org>
Date: Tue, 27 Oct 2026 17:46:54 +0800
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
 Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE612F16-A900-4E5C-8F9F-523F1CA690E6@linux.dev>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-37-6f74bec9a5bb@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 27, 2026, at 07:17, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> From: Chris Mason <mason@kernel.org>
>=20
> With per-VMA locks, UFFDIO_MOVE can run concurrently with mremap()
> on different VMAs in the same mm. Those VMAs can share page tables, so
> both operations can acquire the same pair of page-table locks.
>=20
> UFFDIO_MOVE orders the locks by address, while mremap() takes the =
source
> lock first. These conflicting orders can deadlock; mremap() holding
> mmap_lock for writing no longer helps.
>=20
> Move double_pt_lock() and double_pt_unlock() to mm/internal.h and use
> them for all page-table moves in mremap(). Preserve the source entry
> checks after acquiring both locks. Remove the comments claiming that
> exclusive mmap_lock makes lock ordering irrelevant.
>=20
> In move_ptes(), make sure to just recheck source and destination PMD
> after taking the locks and drop the overly-long comment.
>=20
> Fix generated by an LLM and sent by Chris Mason in private.
>=20
> Fixes: 867a43a34ff8 ("userfaultfd: use per-vma locks in userfaultfd =
operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: use new helpers consistently; simplify description and =
comments;
>         move_ptes() fixup ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

