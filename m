Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EACC3E2ACA;
	Fri, 28 Aug 2026 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900038; cv=none; b=FMD/YVNmLSd7ZUaeuLkiSJMPuNMUnJpQN/JnH4jRBJmCvJBIBK2UR7jFLNwvdnVU39pTQtoAecqaCo4wHV9IV3313M1E4J+LJYJ+hmm7Km2nz0osEDGpjImUuL38Nz7Uk1/BuLNJ7s9Vefv/ETeOFNSgzk7FoI5CTl0FzxLKyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900038; c=relaxed/simple;
	bh=YrvrACo9SyZZyqcjjSclG078uaZP5aJvElVJeGZ/Rls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjsJKIx3fd3QYeUrb+3u859yhOnKDThRedkpwyaIye3reHYvP5S+z/ywQ4+OR+ZNgjXms4588D4PchCZzPQ4d0yBAqujN7kC3dMWRyAI55DC28fBXnfwv3bFqOik+wYTdGKFNyO9/+VwKBYyxdADKfWJSvWgmfA+wiSOrycEx00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lTAX3EB6; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lTAX3EB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=4mvl3BmMDEFXG2xGXhc4I6B1XD02YIlc25e8ogklSLk=;
	b=lTAX3EB6COSec1t9qg2/MJveTEJnDyi2UxIQiF/bF9mszPQ9thdaqBG0bsOyXZ
	2mUfgEy+C3OLTzFC7YiuctnmFe54r75Qm2djptu7nvfJtepf/kFQ50y82NGPYcBR
	7gw9kvJviAIFkA7+Mr8lvyk4LbYmR/ofX/u/JqD7DzTj0=
Received: from [IPV6:2409:8900:1ef4:8f82:3f8a:6d15:2d07:8d9d] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAHdcpXMJFqKlhPSg--.9952S2;
	Fri, 28 Aug 2026 14:53:12 +0800 (CST)
Message-ID: <0c9e65b3-5dd5-462b-b79e-99013eff7e65@163.com>
Date: Fri, 28 Aug 2026 14:53:11 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ntfs: take invalidate_lock in
 ntfs_filemap_page_mkwrite()
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260828061607.240845-1-zenghongling@kylinos.cn>
 <20260828061607.240845-2-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260828061607.240845-2-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHdcpXMJFqKlhPSg--.9952S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry8trWrAryDtFyfXw4ktFb_yoW5Jw47pr
	yayF1rWwsrXw4qgrn7ua1kZ3WYga4fWrWUur13uw1avwn3tr18KF48tF1kXFs7tr98Jr47
	Wr4UCrW7u34a93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRWCJLUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwRgh62qRMFgLxgAA3N



在 2026/8/28 14:16, Hongling Zeng 写道:
> ntfs_filemap_page_mkwrite() calls iomap_page_mkwrite() without holding
> mapping->invalidate_lock, so a concurrent truncate or fallocate can be
> in the middle of invalidating pagecache and rewriting the runlist while
> the write fault maps blocks and dirties the folio.  This races with
> ntfs_attr_fallocate(), which merges clusters into the in-memory
> runlist, drops the runlist lock, and only afterwards zeroes the newly
> allocated clusters on disk; and with the punch-hole/insert/collapse
> paths that free clusters after truncating the cache.
> 
> Per Documentation/filesystems/locking.rst, ->page_mkwrite() must ensure
> there are no truncate/invalidate races, "usually mapping->invalidate_lock
> is suitable for proper serialization".  xfs takes its mmaplock (= the
> invalidate_lock rwsem) shared in exactly this path.
> 
> Take invalidate_lock shared around iomap_page_mkwrite().  The read-only
> fault path is already covered because filemap_fault() itself grabs
> invalidate_lock shared on instantiation/read paths; only page_mkwrite
> was bypassing it in this driver.
> 
> Fixes: 9c87959601e8 ("ntfs: update file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/file.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 585ab2145797..df5c9d79ed09 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -676,6 +676,7 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
>   {
>   	struct inode *inode = file_inode(vmf->vma->vm_file);
> +	struct address_space *mapping = inode->i_mapping;
>   	vm_fault_t ret;
>   
>   	if (NInoWofCompressed(NTFS_I(inode)))
> @@ -684,7 +685,14 @@ static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
>   	sb_start_pagefault(inode->i_sb);
>   	file_update_time(vmf->vma->vm_file);
>   
> +	/*
> +	 * Serialize against truncate/fallocate which hold the lock
> +	 * exclusively while invalidating pagecache and changing extents.
> +	 */
> +	filemap_invalidate_lock_shared(mapping);
>   	ret = iomap_page_mkwrite(vmf, &ntfs_page_mkwrite_iomap_ops, NULL);
> +	filemap_invalidate_unlock_shared(mapping);
> +
>   	sb_end_pagefault(inode->i_sb);
>   	return ret;
>   }

Looks good to me.
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

