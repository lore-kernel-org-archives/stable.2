Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088853;
	b=qQXsek1vXMCL1znebl8H8a32zFYDS9KXH7sZtQWaReT6vnZ/sjHSPyAdyOPj+TS8pG/k
	 z0qMS+xLxR+o4ls1kdo9XT3JYTGR0hf5oMPp4tjRqXSQDNsXMYSmqcgj84OesgrbrU3tp
	 e+Ry3QnIFu6p3WKuaRoqIxNtEuRBjC+ssy5wJ99E6KIBkgm9qFKM5QZGUNa5wX3Y8p7MF
	 0cvur2SHaX1t2vTBQlyTUVKc6cgEOLvwzqTD+Nrli7C8ZsDht+WRVy2iE+KdCQFe0+9iM
	 9qguLhXEjPzw+AvoGTtT0xyQma4SXaQEQ4nf9NlKjJEBf0pQFNZCqukrvNpeO393WYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088853;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=X817yPMZ1OWa0GxllLA7n65tTL4HKJjURd5YVC5upNo=;
	b=sqGTbU629OqpfCTTqHSK8r3aKYmrb65rl65AE4jUZEeeZ0dONj+wRvh5Ng0zdUGW5nmL
	 gmvpQomjpq1s0np3iJyRUltec04cYTLrhh/VnDv2pWfTSgHsfH53jBzzq9vOs0wlLhfPO
	 SgMxv64iF0q7vbdLMpKsM4byGdrl/7Kleqi1HsC9uegPciCyGcclTk53c3ODeCWTFr+2T
	 MbR6qgBFXiQx78VpCZkjdWl0w2shKvQoNdH1KHMuTZFXFbmdEGCdH5cVHc/T1nJNj52bA
	 OOI3hIrgM+RvOa5TZDB1pEpBGbQnTb65ep7kQMjsjhsXp2uqlI7sTZwDydLAcvywmPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/USOVMi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A150606A31B;
	Tue, 27 Oct 2026 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/USOVMi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252CE1F01825;
	Tue, 27 Oct 2026 08:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793088852;
	bh=X817yPMZ1OWa0GxllLA7n65tTL4HKJjURd5YVC5upNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J/USOVMiZdHACMBPrC+zND6awTBbtGUCKpChcm6jDubxlHzRsgGJJ33u8eAyXrHmm
	 Dhgy64k1zoGSzetJ6uUKZtYgTjriJplQrDD5QgepgCioCGZAn0H/62PsYvRrAHq7MD
	 l6KQxPT3ek/jTP3ay9yQuCHmqyJ6vEXgWsvrHA/OVEIl8w0qY2qNXPJSzKqR527RVT
	 FfER0j6vK3yc1dfQ0wPeN924r3/nVS5+UFCB/hPBBJU9NfLcCTsCBk+HMbQu7cKkEk
	 Dk6dNn7PD/Yz5EgpKrvi4Sup3qa7fOHH3IAb+PJBxHnNh8DjdBkIMjNxtAjcJHzrHd
	 rlwjmVWf2kcCQ==
Date: Tue, 27 Oct 2026 10:13:48 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, stable@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 03/46] mm/memfd: check for real shmem inodes before
 accessing shmem state
Message-ID: <auBdPOKXJpE-lX8d@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-3-6f74bec9a5bb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-3-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:23AM +0100, David Hildenbrand (Arm) wrote:
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
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

With a small nit below

> ---
>  include/linux/shmem_fs.h | 6 ++++++
>  mm/memfd.c               | 8 +++++---
>  mm/memfd_luo.c           | 2 +-
>  mm/shmem.c               | 5 +++++
>  4 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index a7c7a96a7cbf9..2ceca7993e4f5 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -117,8 +117,14 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
>  		unsigned long len, unsigned long pgoff, unsigned long flags);
>  extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
>  #ifdef CONFIG_SHMEM
> +bool file_inode_is_shmem(const struct inode *inode);

Do we really need the file_ prefix in this name?

>  bool shmem_mapping(const struct address_space *mapping);

-- 
Sincerely yours,
Mike.
