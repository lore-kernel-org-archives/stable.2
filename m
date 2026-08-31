Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF693E075F;
	Mon, 31 Aug 2026 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164574; cv=none; b=KHeMcEZ08lEF7Drn7J0gXM/ntfI92pNNLNx6Kh6qiyoehapjPYT9J+cKjiafWFNcuBxOJWQ8ARQSdr0CUGq41Fo8jnwNbrJtUTEhLElK6i48qAh7yeTYmlyNypN73L/xZ0/dBrK6fO7TB2Tk8yiDkTdARR48kPzdtBxkjKxM94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164574; c=relaxed/simple;
	bh=bb+Hp2p16kPs9VM+7tdBbBf2++jtIlARQtFqzk/MH0Y=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=pewYraTMwsaJVnXAO0sFwkZFAqVCycXeN1GTpiy0GxNTWHw3VYr9ARfGUVyyheQTxFS888n2krNzSZWrgHp9kBmMHtb5kMgN9guT5IEWINImzWatuncrz/1OrN1qVV2gdzHJfkKXJxtHMGLtAoiR3RFDXzV8Y0VAmGm+5991C2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=UFeurNDM; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="UFeurNDM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=yIS/pOCtenWp42jqOVIMr1Jvngs/EfiHjWSp8tgJxbE=;
	b=UFeurNDMrgblwNA0e6NCeAgNiVmbxQmab13qnDJ8TsYNZuXea4j4Etrdq4lmMs
	xp6ZGKqU3nY2yK+5IENFkwmZd/EqzILXzCIu6vfv8BdfNx6fznN85sZfynUHQpQv
	L07iufR2AiJuNmC+ZE+FWD8VMefKbMjeeSwWDKvZ/4fdg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBnR6O0OZVqfJsXGw--.43721S2;
	Mon, 31 Aug 2026 16:22:12 +0800 (CST)
Message-ID: <6A953998.9050802@126.com>
Date: Mon, 31 Aug 2026 16:21:44 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Namjae Jeon <linkinjeon@kernel.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: hyc.lee@gmail.com, ntfs@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()
References: <20260828061607.240845-1-zenghongling@kylinos.cn> <20260828061607.240845-2-zenghongling@kylinos.cn> <CAKYAXd_v3iw1N9PxDznpGRu4yE2atNG=7WPYM4Z2xNFq2tMx2g@mail.gmail.com>
In-Reply-To: <CAKYAXd_v3iw1N9PxDznpGRu4yE2atNG=7WPYM4Z2xNFq2tMx2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnR6O0OZVqfJsXGw--.43721S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF15ZF43WF1xGr17uFyDJrb_yoW8urWkpr
	Wakr48Xw17X3yUWFn7WF1DZFn5G3s7WrWUuryrW397ZasxAr1xKF1kKrWkXr4kJ3WkAw47
	Xw4vqrWDWFyFq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbiSdUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrhR7TGqVObRrTwAA3b


在 2026年08月31日 15:24, Namjae Jeon 写道:
>>          if (NInoWofCompressed(NTFS_I(inode)))
>> @@ -684,7 +685,14 @@ static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
>>          sb_start_pagefault(inode->i_sb);
>>          file_update_time(vmf->vma->vm_file);
>>
>> +       /*
>> +        * Serialize against truncate/fallocate which hold the lock
>> +        * exclusively while invalidating pagecache and changing extents.
>> +        */
>> +       filemap_invalidate_lock_shared(mapping);
>>          ret = iomap_page_mkwrite(vmf, &ntfs_page_mkwrite_iomap_ops, NULL);
>> +       filemap_invalidate_unlock_shared(mapping);
>> +
> Please move filemap_invalidate_unlock() after truncate_pagecache() and
> pagecache_isize_extended(). Otherwise, ntfs_filemap_page_mkwrite() can
> race with the page-cache cleanup after fallocate extends the file.
>
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 1969e4f444f7..a266105180a9 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -1178,13 +1178,15 @@ static long ntfs_fallocate(struct file *file,
> int mode, loff_t offset, loff_t le
>
>          err = file_modified(file);
>   out:
> +       if (!err && mode == 0 && NInoNonResident(ni) &&
> +           offset > old_size) {
> +               truncate_pagecache(vi, old_size);
> +               pagecache_isize_extended(vi, old_size, offset);
> +       }
> +
>          filemap_invalidate_unlock(vi->i_mapping);
> +
>          if (!err) {
> -               if (mode == 0 && NInoNonResident(ni) &&
> -                   offset > old_size) {
> -                       truncate_pagecache(vi, old_size);
> -                       pagecache_isize_extended(vi, old_size, offset);
> -               }
>                  NInoSetFileNameDirty(ni);
>                  inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
>                  mark_inode_dirty(vi);
>
   Thanks for the review!

   You're right. ntfs_fallocate() dropped invalidate_lock before calling
   truncate_pagecache() and pagecache_isize_extended(), so a write fault
   holding the lock shared could interleave with the page-cache cleanup
   and have its folio discarded by truncate_inode_pages(), losing the
   mmap write. Moving both calls inside the lock hold range fixes it.

   I've posted v2 and addresses your comment.

