Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206438;
	b=C5P0gVSHfNsL1iiMbCYbS4H+C8S6y+biskauM3Tdd7PrNR8YTihRqNolGLYp+K4cvQeB
	 5J3TuuR7g34DC3PwMiLHz9OsrB+D3UrapVXEnYlGQ88j3F9rbCTzhrxUNq1M2aYRyFhEg
	 2D9X5v6bKgakOVGTwxAj05w18S3uc2dTAHJKrdFfQzqIthLtai4HsuP8JOFFnZS6dHaGh
	 u0OVgxyiBz9hKtQpzgZOrOXAgagNQwO8gqg6lutD+XDsS/rIJpHv5jeK9l6N04P4DwwBX
	 M8Il52wFNDFKBicvAsPuXZH+qqbSHf/UjbPVwRjONmyRHwDO8t7XzJ+cXAigft+QxHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jQ5eyf1zl1dztY8G8GNDjIbe5i6XtlGMZ8AEehh0sP8=;
	b=MzlkIJlsD4ZFtInfaiOAM8R6QrvuYFs71HpfwJzgg/zSAQoYehruQy6kNdG5lRr72HVr
	 +NrTefupcwV1/mnFG9IXymiiLRrWjf10/cDWTPEqoWOo8J1lnFlxVchh1dll7KmeiFECt
	 1PFPT+l1l5cPJ3QLZ1+NHhqG7V0F0Bu60Oto+BOIRrEgAsesLwZ0/plNmHsL3TMy9r3Z1
	 93xqzjxMht6vUwQh+3DXlQ540I6h+Jx8ZfBRc6LSy5vzgYpLkkt1uTcFBlpzOhX3wW2bM
	 Wwsjz7IJq6gsJ3qZhjM6TxUcKUA51K/ZTUghhmycG4VOeorOu3oNHur3CJepTYHkAlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=XDq4mZkF;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A04606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A04606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=XDq4mZkF
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cb6dc850c7so398655137.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793206436; x=1793811236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jQ5eyf1zl1dztY8G8GNDjIbe5i6XtlGMZ8AEehh0sP8=;
        b=XDq4mZkFFwWiuClm+CVqUYc4wMUeEj61wwTEJ2ZEwdKAAZOVs4mAkia9/oOPQEGvZ7
         0CPllEZOpo+2Vx7NH/qeJyuqrXNeGxLOX9kPYs9EQ9wuoJxqmE3014fXKocl5hQCZSSq
         jYT4HKvnmSRh02d1ht2QsIKl81mDMWNV+vmtqq/q3kRlDKFLvoFwvUwOFm0i3nE1GCkQ
         0TjmSaJ0QDxHwSaQMTz0/I03VsYupX2JpKIJaxwXOjS22DLQQPY2UaMVlL2DtL/m4NnR
         nHVimsjgnDDTHtl7ghN+41KfpsxRYFoCjEcPBdzS03ioSJ55NDDAbq0L5U9RWlFtVa5Q
         rq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206436; x=1793811236;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQ5eyf1zl1dztY8G8GNDjIbe5i6XtlGMZ8AEehh0sP8=;
        b=PBjQrraYrEeS6PVDKrFamPmFbDMGexBoggRxO6UpcyVdf7lSBM9r0yxn3DxDJ178C5
         V/EFyXJas644WLWxeDhcJBqUlRckmvp/hLwqmpxhykVTCYRxWVuhSYOvmaEfxwxmHnjR
         B3KFQB9FKTlF1lCSka++4DFWQsbzvVJyep7pBMr5uj1BOIBdEQvLNOM9orrR44exPPMP
         svZjNN9AbB+reqXnzpow2/fYU8mmyiNWALc2pK5meDR/EOuIHwjrVdT5433OJCPY6o/N
         sqWQWSufEJNtjtk3I7sXjl4l09+tuSm73pDeKLrT7BP8mOJ7mshJumpndf3MzSax2Tic
         N7rQ==
X-Forwarded-Encrypted: i=1; AKwUvByp8f5lAwzIFbu74ZyCy6UhMiZ9nR0SGrtci2f7hAaIVoV9a8kdq8WXkPNkRmnEURwAAsWh5uk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaym184BzGwQ7viVDzqKg6OGBROIBqX1E9eNvgJZE8w8pY6dCj
	152L/TIulYevpP1NjGkPn0nuCHEvZ/iykORKjrwl7HTN3zEzgQIlutJ1DOLHGMvuHTY=
X-Gm-Gg: AYBFou0bm5NGZ2LE7I6tv5mFqQ3N16OSALDBD5+CT0ISHqFmTa24/LzH+lNE+IvhCtP
	W1cHSOPsnBPZngobMwzO5UqulueQ+HhyK0zvvmkmfck36w2onTP60ocw5DDF+o6mrjknbYVtcla
	roege/R/VkR9nybjRgAmKmPqahgMSE2DLd688440R0pqUl0kA4CtTpPltuOXvSSN1rPwpwyMYak
	DDYBfK8f7rs1t6N3kvJuTgX4B7dtfHm/rcriUAEPxxF5XW1K6156751nfei4WWwUF2i7E/xDti5
	IQMI+UEwungoKCHFwMfavKkDPPn82ymQZW2emuXL2rFL7KkEWdn21sFPAqx0YUsEqnlsHpU+HzA
	5JOCUS/RPStT/vS+S7ypW2mpbx5Tu4En2ox9ZE2s1AQug+LCqfpBR0Rh7bXXGQxwRwMy4c+XDbc
	BIRg6lbiqGV9Ngxvsed6BcUSPKcwHqZsZWlDdIH00683ZAWxtMTKMBTqwokbbgD2UcE7+8ZvXZJ
	ufypfmXKgkJrtKU0iLm1hT9Jg/Hy8n3n3wpV79alo4Jz5Fx2uq5ZJ6YXhGciXOsxpuGHanR5tf+
	BCycn/RM3s/oYyXBX/F3vq6DTolEpE9ixjripeOciTwCVbh/gb7tMhTnSUCBcRNZ1EYVIphIkH+
	7bohkdvnTfLeeCBmCf3IkaHUebci+JA==
X-Received: by 2002:a05:6102:3e8d:b0:7cb:bb33:8412 with SMTP id ada2fe7eead31-7d03a5063b4mr1453208137.10.1793206435862;
        Wed, 28 Oct 2026 09:53:55 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259db2d3sm6495987241.6.2026.10.28.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:53:54 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:53:47 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 03/46] mm/memfd: check for real shmem inodes before
 accessing shmem state
Message-ID: <auIoDgHmzpGH6cOl@google.com>
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

On 10-27 00:17, David Hildenbrand (Arm) wrote:
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

Yeah, file_ is not needed, otherwise:
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

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
> 
> -- 
> 2.43.0
> 
