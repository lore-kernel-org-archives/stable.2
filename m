Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363402;
	b=XJ+w6G9Dqs8/I90nXm7xcwlPR5CLpMI5xJibYRGYr+mn0rEmKAb1MTKurv/ZRloKm/9u
	 P8s5qSoqRiPNQ+gwq5Mvyn2+fEjcfgnKMO2/0r3Y2qB4uGR7DEmR525H7f03rRyz7uCM7
	 dobyJZVt9P5Pr/8vHjzL8IhX9C6hy3BCk7kMG/a1lXqZUHYnxH+QsB7U/AUEoZzTqURKe
	 dN95UzmIORcRaHu7oh4TKDct7CQYB3+8tTaV0tHoy13nCCQJizSqag+XobjI32i928bwH
	 ywmr/fMIqkxb8doJCyczzE/X3e6bGFzB1VEmcfWW19h0DAKvL+j2zDRbM+UISdL3VCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363402;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=hu2ezbFXEyhvzPYipLaNmuX98BEqOJW5J/R/m8RSLb0=;
	b=47rKihWUu8Xo2fZ6kMkqi+A/geAhKqyxmoUmPv30yY3dLQw1EE1S3bGwClXPPlnHs86R
	 ekirFzguyONmeXDO95sBrT/hTKJ9vVTPvLns1l5Wh35pTPCltmtPUSQBLIF0yWRoLF4dJ
	 LAhfntWnhCpyYQiy+FyqteosqYyd9oewmN4v041yvmwsm1m31mRaKrtX3zgo9uObTR2P/
	 6Jhe3iIxnV4899dU+lWxPIRTJSygfnBA2ou4sjiqJJ3s6qXTJyQvBWGbayWhSLkMc7ioZ
	 d4jzekmqkWsz/hIF0yfOF9jvZzSeUbVDsgpVJwccwZSniVR7PJtmx8N3ceUjMODMWdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fg02mM+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC1606A320;
	Fri, 30 Oct 2026 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fg02mM+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAFB1F0093A;
	Fri, 30 Oct 2026 12:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363401;
	bh=hu2ezbFXEyhvzPYipLaNmuX98BEqOJW5J/R/m8RSLb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Fg02mM+PuPWrmf4vwct0jXlFZMeQuDiAYwpOteG7E7NWa+rawXxJHLQ+rxU4Iu/5z
	 dHaD/qCLNflG2BY/40J/PeIywGZto9P+aeKoiWOq/eodjFYgtozCCQFl3rLGILjOiV
	 3HHfhk/RO/H/KYZNcFXeCCK+EfX/j9cvHdm/z+qHK5mDR1L5VK045z+oAJrsEXFCaP
	 KeX4rkPy3RyQL3Si1NZqQBPwfcJQWAokQKDGDXyXdbxJOr6KUgY3agb0Xxb8NCVo0B
	 P0j1yAnu8mVQI+43vEWX38ucFx0bgxYGgKKtDx2aBrcL4oT+myqJLRltwHCl+UthTe
	 L8U/RBFarIVow==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Qi Zheng <qi.zheng@linux.dev>,
  Shakeel Butt <shakeel.butt@linux.dev>,  Lorenzo Stoakes <ljs@kernel.org>,
  Kairui Song <kasong@tencent.com>,  Barry Song <baohua@kernel.org>,  Axel
 Rasmussen <axelrasmussen@google.com>,  Yuanchu Xie <yuanchu@google.com>,
  Wei Xu <weixugc@google.com>,  Baoquan He <baoquan.he@linux.dev>,  Baolin
 Wang <baolin.wang@linux.alibaba.com>,  "Liam R. Howlett"
 <liam@infradead.org>,  Vlastimil Babka <vbabka@kernel.org>,  Mike Rapoport
 <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Kees Cook <kees@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Jann Horn <jannh@google.com>,  Pedro Falcato
 <pfalcato@suse.de>,  Hugh Dickins <hughd@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  "Matthew Wilcox (Oracle)"
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
In-Reply-To: <297adf4c-1792-4dff-a7c8-2694dc2b1446@kernel.org> (David
	Hildenbrand's message of "Fri, 30 Oct 2026 13:06:45 +0100")
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
	<20261029-fixes_core-v2-3-a64ce7f83abb@kernel.org>
	<2vxzmrrvmnil.fsf@kernel.org>
	<297adf4c-1792-4dff-a7c8-2694dc2b1446@kernel.org>
Date: Fri, 30 Oct 2026 13:29:50 +0100
Message-ID: <2vxzik2jmkw1.fsf@kernel.org>
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

On Fri, Oct 30 2026, David Hildenbrand (Arm) wrote:

> On 10/30/26 12:33, Pratyush Yadav wrote:
>> Hi David,
>> 
>> On Thu, Oct 29 2026, David Hildenbrand (Arm) wrote:
[...]
>> Both want to only look at "proper" shmem
>> files, and should not do any work on a Coda file with a shmem mapping.
>> Plus, someone later down the line might use shmem_file() without knowing
>> this subtle problem, and we probably would miss it in review.
>> 
>> For callers that only care about the mapping should then use
>> shmem_mapping(). I am not sure if there are any. Perhaps that would be
>> collapse_file()? But TBH I don't really understand khugepaged all that
>> much. All other callers of shmem_file() seem to care about the actual
>> inode.
>
> Looks like collapse_file() would then use shmem_mapping() for the time
> being. God this is confusing.

Yes...

>
> What about the following replacement:
>
>
> From 6e3c4f92a651e36ed1ae8d7659d2ca08543fa430 Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> Date: Sat, 24 Oct 2026 21:08:33 +0200
> Subject: [PATCH] mm/shmem: make shmem_file() check the file's inode
>
> shmem_file() only checks if file->f_mapping is a shmem mapping. This
> mapping can belong to another file, however, as with a Coda file backed
> by a tmpfs container after mmap().
>
> So it does not guarantee that the file inode is an actual shmem inode.
>
> Seal handling and memfd preservation use this check before accessing
> shmem inode state, so they can access an inode of the wrong type.
>
> Let's make shmem_file() check the inode's file operations instead, to
> identify shmem inodes reliably. This will identify regular shmem inodes,
> including memfds and ordinary tmpfs files, independently of wrapper file
> operations.
>
> Use shmem_mapping() in collapse_file() instead to not change the behavior
> of collapse_file(): it operates on the page cache and uses mapping->host
> for shmem inode operations. Focusing on the file does not seem relevant.
>
> Fixes: c49fcfcda8b5 ("mm/shmem: update file sealing comments and file checking")
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Looks great, thanks!

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav
