Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359998;
	b=31IhI1HtwzqIVw3fk1F+RjtOxysOc0J8vTId+uBV9Z26nGZuUliC4Z2obN4W25RuCt/e
	 qnkfq0mdpJUXP81HipxSCUIcr9LaRQJYJH7GzeDyUEcbo4ozopL4vgcPNCogKBPT4pu3x
	 NTZB/LhznoIlB3zs7NW21lk3myEsuEAl7NW61bODBDEOetTpxCCd+WonglfY40k8RHY4p
	 UGSzoG7AgT8kDcwY8SE5x80aqJS4ilWXc1RyTChKKqAadCDRdjJ4N8/FrzDSGENaJr2e9
	 FlxojTlIry3ad0p9tR8iFSJRCUZje4PCTNd4VVBUG1YOuii4u7log8YhaWrhyzLe67g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359998;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=kc1nYy3NbBrATEnmu304kSXCIcQUyPU78cqEyUeTLQk=;
	b=g5mXRGGMT1A8Mkpuc6FJH+C91G2yTSt67HcdafLwHZwCRNQ99ES04gthdla0oIpSrTdf
	 bbI1+aCCMkSZ4Ms9/UUPrhJIzOY+bn9WZ01gSYmlH9Y0nDjUk1hix5401xUR79S2T5fhp
	 w5KYcH+5mVo50g98hqSjm5h9CsU1jxyTTcyRs1YZmIYJjI3DV3AqQUVWDorbZm6PchFD2
	 4d8CPK6vA8aIU9CMYv2Zyz3kYoOKykjhcYva11Y2/4J+FOnoOdvvWYsUU5zDWXHTbcr6w
	 LcwH5d/XvzFQMbfdaJTnrm5l1d5z0jxEeBXBTPnNMc42Jx67vjCAHfGAXqO7KAnkmSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHb4rT89;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7363A606A31D;
	Fri, 30 Oct 2026 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHb4rT89
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A5A1F000C1;
	Fri, 30 Oct 2026 11:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793359998;
	bh=kc1nYy3NbBrATEnmu304kSXCIcQUyPU78cqEyUeTLQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BHb4rT89dXjX/iZaObEefV3p90/w7FDU1AnmrNDjsWGet3bMCVuHxPhhh8maCSV/h
	 zHFPhZNhQ+icw2cAAzLgVil3nTxqrp8v/shvpU7wgx9O2HOr6scmGto/DwnEx43YLR
	 U8QuxRoob6poB0ebRlGoVLdYs4EXRG/OEIcmFg9nLjCoFcmkfPK+kLiNtyRR5jFfK/
	 kPdRH7C4xmDmfWvUUGNc6QJpyNgV5aZiZ4d9NVAt97UVbCogRFpjqWS63JZdadrQNq
	 Et9wov2jU3Uf8UCr6K6rvisW1XibSsetO8Dm61vUCe5/c67aIiNMH6e+Dl8WkmU+fi
	 vUl1VbxFRwh2Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Qi Zheng
 <qi.zheng@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Kairui Song <kasong@tencent.com>,  Barry Song
 <baohua@kernel.org>,  Axel Rasmussen <axelrasmussen@google.com>,  Yuanchu
 Xie <yuanchu@google.com>,  Wei Xu <weixugc@google.com>,  Baoquan He
 <baoquan.he@linux.dev>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  "Liam R. Howlett" <liam@infradead.org>,  Vlastimil Babka
 <vbabka@kernel.org>,  Mike Rapoport <rppt@kernel.org>,  Suren Baghdasaryan
 <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,  Kees Cook
 <kees@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,  Jann Horn
 <jannh@google.com>,  Pedro Falcato <pfalcato@suse.de>,  Hugh Dickins
 <hughd@google.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Jan Kara <jack@suse.cz>,  Zi Yan <ziy@nvidia.com>,
  Lance Yang <lance.yang@linux.dev>,  Rik van Riel <riel@surriel.com>,
  Harry Yoo <harry@kernel.org>,  Alistair Popple <apopple@nvidia.com>,
  Nico Pache <nico.pache@linux.dev>,  Ryan Roberts <ryan.roberts@arm.com>,
  Dev Jain <dev.jain@arm.com>,  Usama Arif <usama.arif@linux.dev>,  Kiryl
 Shutsemau <kas@kernel.org>,  Matthew Brost <matthew.brost@intel.com>,
  John Hubbard <jhubbard@nvidia.com>,  Peter Xu <peterx@redhat.com>,  Will
 Deacon <will@kernel.org>,  "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
  Nick Piggin <npiggin@gmail.com>,  Oscar Salvador <osalvador@suse.de>,
  Minchan Kim <minchan@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
  Xu Xin <xu.xin@linux.dev>,  Chengming Zhou <chengming.zhou@linux.dev>,
  Chris Li <chrisl@kernel.org>,  Kemeng Shi <shikemeng@huaweicloud.com>,
  Nhat Pham <nphamcs@gmail.com>,  Youngjun Park <youngjun.park@lge.com>,
  Gregory Price <gourry@gourry.net>,  Joshua Hahn
 <joshua.hahnjy@gmail.com>,  Rakie Kim <rakie.kim@sk.com>,  Ying Huang
 <ying.huang@linux.alibaba.com>,  Jason Gunthorpe <jgg@ziepe.ca>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-fsdevel@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-cxl@vger.kernel.org,
  stable@vger.kernel.org,  Chris Mason <mason@kernel.org>
Subject: Re: [PATCH v2 03/47] mm/memfd: check for real shmem inodes before
 accessing shmem state
In-Reply-To: <20261029-fixes_core-v2-3-a64ce7f83abb@kernel.org> (David
	Hildenbrand's message of "Thu, 29 Oct 2026 21:32:58 +0100")
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
	<20261029-fixes_core-v2-3-a64ce7f83abb@kernel.org>
Date: Fri, 30 Oct 2026 12:33:06 +0100
Message-ID: <2vxzmrrvmnil.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hi David,

On Thu, Oct 29 2026, David Hildenbrand (Arm) wrote:

> shmem_file() only checks a file's backing mapping. That mapping can belong
> to another file, as with a Coda file backed by a tmpfs container after
> mmap(). It does not establish that file_inode(file) is a shmem inode.
>
> Seal handling and memfd preservation use this check before accessing
> shmem inode state, so they can access an inode of the wrong type.
>
> Add file_inode_is_shmem() to check the inode's file operations in both
> paths. This identifies regular shmem inodes, including those used by
> memfds and ordinary tmpfs files, independently of wrapper file operations.
>
> Fixes: c49fcfcda8b5 ("mm/shmem: update file sealing comments and file checking")
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Maybe you missed my email on v1 [0], so here's another try:

Why not update shmem_file() to do this check instead? Having a
shmem_file() that might not always return the right result on a file
seems like a landmine.

For example, you missed check_memfd_seals() in udmabuf or
memfd_pin_folios() in gup. Both want to only look at "proper" shmem
files, and should not do any work on a Coda file with a shmem mapping.
Plus, someone later down the line might use shmem_file() without knowing
this subtle problem, and we probably would miss it in review.

For callers that only care about the mapping should then use
shmem_mapping(). I am not sure if there are any. Perhaps that would be
collapse_file()? But TBH I don't really understand khugepaged all that
much. All other callers of shmem_file() seem to care about the actual
inode.

[0] https://lore.kernel.org/all/2vxzh5i7p5nl.fsf@kernel.org/

> ---
>  include/linux/shmem_fs.h | 6 ++++++
>  mm/memfd.c               | 8 +++++---
>  mm/memfd_luo.c           | 2 +-
>  mm/shmem.c               | 5 +++++
>  4 files changed, 17 insertions(+), 4 deletions(-)
[...]

-- 
Regards,
Pratyush Yadav
