Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184719;
	b=RaXf21aoyRv7CrHXQY7m/w6e3b5HTMgBaNyBY2lG7y4MAXnLGiNs9QvHKDGzGysHQsO5
	 wqa4bMdVCm00dAZDlzbqQoi9Qp7XBG63Vqmg26YyETwpM8iI3bfT3C3+iMN4hr5pOdZZ5
	 wUXxoBKZDja6lJIFi3nV6Sgf8d88qUW+CWkmx9x2TZDHc9iiBaJAeOjbGVG/jKP5GxCkA
	 6RbMef9OSYq7+iXH8grxXkdGwzQk47/fmf5c0f7BJhyWAkjNAgPa5y7FhtjQidYwE69f3
	 85TfpM7c/SA5tgDR/M6BZ/kovgwQzuOXJMQDDdvJVjmMi/59Ka0cs5grRVdrXJJNzQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184719;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7VuPLf/Bn8Nq23p16kdsfk/y2q2DGA/iZ/5CkjspwaQ=;
	b=xOU5YS6JHc8Wt88iXtTLZ+gbOHWxyfU/ry9gOUinSl1gTNwi3WdMqH20fK/8w7Fu+0H6
	 F5zx2s0Stdm6lOVDtnAEVacrRaWhdcoX1pKGePLWvISLtuIFTLwrYBt/4IFBhRi7kMMN3
	 +pLlqOhVE0R4+1JN7kkhfEnfhHob9OAlncvlT2KXc5pnlgr7Wl9a8+9nIlmp0e9/JrirH
	 STajmIzvlkt/yPhi87OJ3VQHbQgzbsveFRBv/WMI25Wo2hnySMxinrT9/06foWBMd2WCL
	 ZVU5HKtUpfkItrpMq5XKJDDz9wN8dRUxMhhb/rmeHQthXB26x1NT2zithJLahuBkXEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBRAr6GD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246CB606A31A;
	Wed, 28 Oct 2026 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBRAr6GD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B691F01825;
	Wed, 28 Oct 2026 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793184718;
	bh=7VuPLf/Bn8Nq23p16kdsfk/y2q2DGA/iZ/5CkjspwaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eBRAr6GDX4kET2Ek9hYjPmzPxEQW5sR6uvgI4atic8jFUwlYMWDd8wXV59vQEJmDv
	 AlVsHhjlRbPVmM+JsGl8xrOaYMa/vGAAwVCuT88dBN9QT0ocy0iENimUTCUqFwHUzd
	 ZJ/bOQ9MzSg0GY8P6RrZp/Tk7FT655/GKkGHxWGmC8FVsr3NEkAZxuLIuhYNKXJq7s
	 gtsGCJwJ0TMNg9xCqSlNtCcEP8zMBLGU0NmNcNK5ipdk004Tl8X/UpJrcNXB+ouHLi
	 z6snhbni4tuYid2Q8J+rBnNdQbMoCFWI3RPJyEfBuFFC6QvzlP9EPVA54/9BYhrquW
	 L6exRasHRYQtA==
Date: Wed, 28 Oct 2026 11:51:48 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vladimir Davydov <vdavydov.dev@gmail.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lukas Czerner <lczerner@redhat.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Stevens <stevensd@chromium.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	William Kucharski <william.kucharski@oracle.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	stable@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH v3 05/15] hugetlbfs: enforce F_SEAL_EXEC in setattr
Message-ID: <auHTxApiSnnlY1xt@localhost.localdomain>
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
 <20261028-fixes_shmem-v3-5-4ce3baf2db4b@kernel.org>
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
In-Reply-To: <20261028-fixes_shmem-v3-5-4ce3baf2db4b@kernel.org>

On Wed, Oct 28, 2026 at 10:55:03AM +0100, David Hildenbrand (Arm) wrote:
> From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> 
> F_SEAL_EXEC is enforced by shmem_setattr(), but hugetlbfs_setattr() does
> not check it. As a result, fchmod() can change the execute bits of a
> sealed hugetlbfs memfd.
> 
> Use memfd_check_seals_mode() in hugetlbfs_setattr() to reject changes
> to execute bits when F_SEAL_EXEC is set.
> 
> This also fixes the memfd_test hugetlbfs SEAL-EXEC subtest, where
> fchmod() incorrectly succeeded after applying F_SEAL_EXEC.
> 
> Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> Link: https://patch.msgid.link/20260629180247.2343229-1-eva.kurchatova@virtuozzo.com
> Acked-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> [ david: use common helper; fixup Fixes:; check only regular files ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

> ---
>  fs/hugetlbfs/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 01c4d6f44ebe..02e0a65d596d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -28,6 +28,7 @@
>  #include <linux/folio_batch.h>
>  #include <linux/fs_parser.h>
>  #include <linux/mman.h>
> +#include <linux/memfd.h>
>  #include <linux/slab.h>
>  #include <linux/dnotify.h>
>  #include <linux/statfs.h>
> @@ -840,6 +841,13 @@ static int hugetlbfs_setattr(const struct mnt_idmap *idmap,
>  	if (error)
>  		return error;
>  
> +	if (S_ISREG(inode->i_mode) && (ia_valid & ATTR_MODE)) {
> +		error = memfd_check_seals_mode(info->seals, inode->i_mode,
> +					       attr->ia_mode);
> +		if (error)
> +			return error;
> +	}
> +
>  	trace_hugetlbfs_setattr(inode, dentry, attr);
>  
>  	if (ia_valid & ATTR_SIZE) {
> 
> -- 
> 2.43.0
> 

-- 
Oscar Salvador
SUSE Labs
