Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9F314B73;
	Fri,  3 Jul 2026 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783050615; cv=none; b=lnr8S3bvDMzApCDZgg2JL1G5johc0ZS6O5VVvRhHeRFgVt6ICUcFH9Hc5vrFeEaMmI2ax5gf1qPREZNFPdSe2xTxkgMBRKKQu3hamPDBRGcQ417EnGKYPVoCPLfeYVMTrS4cvkUp8nvRK44wKe/le3mKPfynNr7BFmVyYxyHwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783050615; c=relaxed/simple;
	bh=C1Dk6PWrUq2lHI+FnCZhVqWbxD0AEvUeWEEaklxKxC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ug8g4Gp/unsOw2YZqixa2z6eNJzJMM/pdWzlUnk/uHnOM2vJpAn5Oq96wjRFT9TDANQjiStdbQ+X91YXrBrtkn5WLDAWG/tT8EtDuFqgrea1KoV4PNnWiFhTbTcylhzQEXb7bs58nniKAtZQJA/g6v+uStCOAWkg3GazrZT/zTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IudMrMT9; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IudMrMT9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783050596; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XG2onznUxb2a1bjAl7eu7EX+0tUl3lnnp+uaCTwK2zc=;
	b=IudMrMT9+lPk1sjRVPyycDCCyf5DE6rFfCYTLCCHBEhqu4HBFQRp3hZpI+loW/JaeuHt2TARZBBjgm/m+aejPG6mpROYxCORikNgIFDBsQdeSILWGIVmNuetTBL3Y/v6wedKyB6XteJlkOhYRzbBcwGVwujQOvc0/b1ghi0QQkQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X6Hnc.J_1783050593;
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6Hnc.J_1783050593 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jul 2026 11:49:54 +0800
Message-ID: <110e92b2-f7a6-487a-94a2-25ef1242afb7@linux.alibaba.com>
Date: Fri, 3 Jul 2026 11:49:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
To: Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Song Liu <song@kernel.org>,
 Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>,
 Gregg Leventhal <gleventhal@janestreet.com>
References: <20260702165409.164568-1-pfalcato@suse.de>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260702165409.164568-1-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/3/26 12:54 AM, Pedro Falcato wrote:
> As-is, khugepaged and writable-file opening exclude each other. A file
> cannot be open writeable and have THPs (because the filesystem is not aware
> of them). khugepaged will never collapse file pages for files that are
> opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
> particular file is dropped. This is fine because nothing could've been
> dirtied.
> 
> However, there is an edge-case: collapse_file() might not be able to
> coexist with concurrent writers, but it can coexist with dirty folios
> (from previous writers). Therefore, the following can happen:
> 
> open(file, O_RDWR)
> write(file)
> close(file)
> madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
> open(file, O_RDWR)
>   nr_thps > 0
>    truncate_inode_pages()
>      /* THPs are cleared out, but so are the dirty folios */
> 
> When this edge-case happens, there is data loss, as the dirty folios are
> fully discarded.
> 
> Fix it by fully writing back the page cache (and waiting) when collapsing
> file THPs. Doing so provides the guarantee that no dirty folio will be
> observed while there are active THPs. To fully ensure this is safe, the
> invalidate_lock needs to be held while doing the writeout, so that
> do_dentry_open()'s page cache truncation excludes this write-and-wait.

Thanks for explaining the race, and it looks reasonable to me. One nit 
below.

> Cc: stable@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Song Liu <song@kernel.org>
> Cc: Eric Hagberg <ehagberg@janestreet.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
> Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
> Tested-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
> This patch is written against 7.1.0 (because the code no longer exists in mainline).
> 
> Zi, I kept your Tested-by, but I had to move some things around and
> use the invalidate lock. Please re-test if you can.
> 
>   mm/khugepaged.c | 39 +++++++++++++++++++++++++--------------
>   1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b8452dbdb043..0707d719a270 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2094,32 +2094,43 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>   		goto xa_unlocked;
>   	}
>   
> -	if (!is_shmem) {
> +xa_locked:
> +	xas_unlock_irq(&xas);
> +xa_unlocked:
> +
> +	/*
> +	 * If collapse is successful, flush must be done now before copying.
> +	 * If collapse is unsuccessful, does flush actually need to be done?
> +	 * Do it anyway, to clear the state.
> +	 */
> +	try_to_unmap_flush();
> +
> +	if (result == SCAN_SUCCEED && !is_shmem) {

Actually, the operations below only for those mappings that do not 
support large folios. For mappings with large folio support, 
filemap_nr_thps() always returns 0, so the race described in the commit 
message won't happen. We can add mapping_large_folio_support() here to 
filter them out.

if (result == SCAN_SUCCEED && !is_shmem && 
!mapping_large_folio_support(mapping)) {

Otherwise LGTM.
