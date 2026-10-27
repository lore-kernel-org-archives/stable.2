Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112106;
	b=vJWuBoq4HtPuLCNZcsUIsDkIwoPsRT4/FRCB1iquB1W5iAvLJE2UZHl6LH8cbAufzfVk
	 inwasKi2Yizy4a23/KDdGuZOZjOi/H3bmtLl89fniNJd0AIow9qEgZtPOnTYuccVKTGv7
	 5CQP4NwmQFu2WG7ZJkOMeThig66hDrQ6B7X6Az5rySDuCXYO97DJKwiNMWk4TDS0p/LeW
	 7A8bDkRIvpQEdIm9buSNRvwMVTipYHgqtu9u3f/VL6XO3OI3rGhgidrf6fU7DND1PiMhJ
	 RYKqHk5p+kYvFkleol5bLl6Q7DtMDqnhQLW+B4MikOYv2OTyLDDLNVD1pRTJPVoRk9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=Cxbcd97TigLbOc2nsbdYTtwGKr7cyQITuDlutqpOwp0=;
	b=aQWoFWncYIly05m2wm8N8TcnU4qli123A04TBWdwMxkibL+tPmzuwdvgz8KkjeYCP2Fh
	 a0/UE05pck6F7gK5k9juD8LUvV7SDMxMDLxx9+K7bYgcDZBXVeL1GEaKKpJRCKKM0A/Je
	 eGRNpE4W2WancAtRCKLZN3YYlKXVMIwKg697vFBRVazVZNBww9QkKrTawNe8GKGNADMDw
	 yUSyfUllzKuX88ljONv1M52IkmfYaJEXDos1JYaSQb6zSD0zU/BuQ+G7l9T0X5M5pdqGv
	 GAMAmTLIj/vlGKVhfQNon/iHn8aPOS2cX613oE+0vcFks8HAxFkqVDEA4iNsfn6e7AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F/aE3Kg9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B82606A31E;
	Tue, 27 Oct 2026 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/aE3Kg9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A8B1F01825;
	Tue, 27 Oct 2026 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793112105;
	bh=Cxbcd97TigLbOc2nsbdYTtwGKr7cyQITuDlutqpOwp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=F/aE3Kg94sj9fXVFeMOGEhnFPh7IPM73CFA/LmgAAZfItP5Nw7PY1j3LmhUrie3RF
	 WWOkZE/CrqgRjQtrY5czn2Xyhnu7Jhr5cpxZIRN6ucwFL7953eyR9cc+xJIfYeqrtx
	 x427FQ040+6sFoWm3ZQYEETyJqIrMT+OQrZXuAnXJaqqyPl1iBQjI9L2UIFGYkQFmj
	 rXT+tzW5xd2XQNYXVDL7CnDknr0SBZMXfP2tLX56GVF5sYE25tWUnjur3LSUQsNAM/
	 e9FZ57Wpnn2LjlHGFOu9V+hCx07zuXfQscJu7g4AtCiXI1sCKypZwCMKvsYpJoK5pk
	 vtVZ2ljYGxZvA==
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
Subject: Re: [PATCH 03/46] mm/memfd: check for real shmem inodes before
 accessing shmem state
In-Reply-To: <20261027-fixes_core-v1-3-6f74bec9a5bb@kernel.org> (David
	Hildenbrand's message of "Tue, 27 Oct 2026 00:17:23 +0100")
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
	<20261027-fixes_core-v1-3-6f74bec9a5bb@kernel.org>
Date: Tue, 27 Oct 2026 15:41:34 +0100
Message-ID: <2vxzh5i7p5nl.fsf@kernel.org>
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

On Tue, Oct 27 2026, David Hildenbrand (Arm) wrote:

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

Why not update shmem_file() to do this check instead? Having a
shmem_file() that might not always return the right result on a file
seems like a landmine.

For example, you missed check_memfd_seals() in udmabuf or
memfd_pin_folios() in gup. Plus, someone later down the line might use
shmem_file() without knowing this subtle problem, and we probably would
miss it in review.

For callers that only care about the mapping should then use
shmem_mapping(). Perhaps that would be collapse_file() but TBH I don't
really understand khugepaged all that much. All other callers of
shmem_file() seem to care about the actual inode.

>
> Fixes: c49fcfcda8b5 ("mm/shmem: update file sealing comments and file checking")
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
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
>  bool shmem_mapping(const struct address_space *mapping);
>  #else
> +static inline bool file_inode_is_shmem(const struct inode *inode)
> +{
> +	return false;
> +}
> +
>  static inline bool shmem_mapping(const struct address_space *mapping)
>  {
>  	return false;
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 0f6fff004f5e4..7d2da23157003 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -211,12 +211,14 @@ static int memfd_wait_for_pins(struct address_space *mapping)
>  
>  static unsigned int *memfd_file_seals_ptr(struct file *file)
>  {
> -	if (shmem_file(file))
> -		return &SHMEM_I(file_inode(file))->seals;
> +	struct inode *inode = file_inode(file);
> +
> +	if (file_inode_is_shmem(inode))
> +		return &SHMEM_I(inode)->seals;
>  
>  #ifdef CONFIG_HUGETLBFS
>  	if (is_file_hugepages(file))
> -		return &HUGETLBFS_I(file_inode(file))->seals;
> +		return &HUGETLBFS_I(inode)->seals;
>  #endif
>  
>  	return NULL;
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 59de210bee5f9..c0811407ce397 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -582,7 +582,7 @@ static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
>  {
>  	struct inode *inode = file_inode(file);
>  
> -	return shmem_file(file) && !inode->i_nlink;
> +	return file_inode_is_shmem(inode) && !inode->i_nlink;
>  }
>  
>  static unsigned long memfd_luo_get_id(struct file *file)
> diff --git a/mm/shmem.c b/mm/shmem.c
> index fadf23f9e21ed..0d41aac125df9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -275,6 +275,11 @@ static const struct vm_operations_struct shmem_vm_ops;
>  static const struct vm_operations_struct shmem_anon_vm_ops;
>  static struct file_system_type shmem_fs_type;
>  
> +bool file_inode_is_shmem(const struct inode *inode)
> +{
> +	return inode->i_fop == &shmem_file_operations;
> +}
> +
>  bool shmem_mapping(const struct address_space *mapping)
>  {
>  	return mapping->a_ops == &shmem_aops;

-- 
Regards,
Pratyush Yadav
