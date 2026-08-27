Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164CB282F14;
	Thu, 27 Aug 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812222; cv=none; b=KLys8u0HdbvdHQWP0F1rVC2gJrTEnFTvKB4ZX3j/mXXntZwydTM5iW4Z6TPEkYxzXK6GNtyJPHjYgsrnrQ6SBaxAFhhALHWtwRzsOznSBeNaMyFIAbQpyDAI3W/7dyAb8mhH7MApIExHpHDMQ1jzH3uF5lGMzjYKzseorO+8rbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812222; c=relaxed/simple;
	bh=m3WbQIPrdWCziVJvSWC8Vq44YHswCCx/eumheToekzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQzX0vWUt9GLAwYnsl+50PB6xVKm7c8ifBgfg3iBA5fwkISUJGHApUkzXC/PDjcHQZIEtuCq+YV1FV0wt9AKHdDX5yMCy6Lv1J6uNvtngEkswvg8TLAIMmqjY7dfuhi9Y46VpeDk3uJxSvmRZBh0ZEYETEAEYB9/89nXcd/KoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kcejMatJ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kcejMatJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=scfv/9oh5mIQ0pvEmXn4Y3vBAXtwHdPlSlSWi9xNwsk=;
	b=kcejMatJtyNWfUFxTJlXucWFo7xw1v44XFK3Vq4KuH6GULyDGy4OWVH98wKb8R
	8U/JCZACMAtRVwrdjJlqhiDkcg/eP9hqhSUf/4UjSVTOGJ+85qN6OSrpww0Jawke
	PO+rbAzwR3FfH25jDfJK29kmPfyhN5WrcJUlyhf4cZQn4=
Received: from [IPV6:2409:8900:1ef4:8f82:6a1b:f1a6:cbdd:11fe] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgB3T6Vb2Y9qEhKRMQ--.46745S2;
	Thu, 27 Aug 2026 14:29:49 +0800 (CST)
Message-ID: <5f458df2-3467-4c50-866b-4dea72836229@163.com>
Date: Thu, 27 Aug 2026 14:29:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ntfs: fix race between fallocate and mmap reads
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org,
 Baolin Liu <liubaolin@kylinos.cn>
References: <20260827055844.1673890-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260827055844.1673890-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgB3T6Vb2Y9qEhKRMQ--.46745S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWxXw4Dtw1rurW7Gw4UJwb_yoW5Ar47pr
	ZIgF45K34fZryUWFn5Kw409F15Wwn7W3y5urWfX3W8AF98KFnrKw1jkr4kuFyftF95Aws5
	XF1UtrZrWa4av3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaJPiUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwR4M1mqP2V4yOgAA3v



在 2026/8/27 13:58, Hongling Zeng 写道:
> The fallocate implementation only takes invalidate_lock for punch hole,
> collapse range, and insert range operations. For standard allocation modes
> (mode == 0, FALLOC_FL_KEEP_SIZE), the lock is not held.
> 
> During ntfs_attr_fallocate(), new clusters are mapped to the runlist via
> ntfs_attr_map_cluster() before being zeroed by ntfs_dio_zero_range(). This
> creates a window where concurrent mmap page faults can read uninitialized
> disk data.
> 
> Since mmap uses filemap_fault() which takes invalidate_lock in shared mode,
> it can fault in pages during this window and expose old disk contents to
> userspace. This is an information leak and data integrity issue.
> 
> Fix by taking invalidate_lock for all fallocate operations, not just for
> punch/collapse/insert modes. This prevents concurrent page faults from
> accessing unzeroed clusters during the allocation window.
> 
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
> Change in v3:
>   -Remove map_locked after fixing the pre-lock early exit.
> ---
>   fs/ntfs/file.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 88747217ba61..1969e4f444f7 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -1116,7 +1116,6 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
>   	struct ntfs_volume *vol = ni->vol;
>   	int err = 0;
>   	loff_t old_size;
> -	bool map_locked = false;
>   
>   	if (mode & ~(NTFS_FALLOC_FL_SUPPORTED))
>   		return -EOPNOTSUPP;
> @@ -1148,16 +1147,13 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
>   
>   	inode_lock(vi);
>   	if (NInoCompressed(ni) || NInoEncrypted(ni) || NInoWofCompressed(ni)) {
> -		err = -EOPNOTSUPP;
> -		goto out;
> +		inode_unlock(vi);
> +		return -EOPNOTSUPP;
>   	}
>   
>   	inode_dio_wait(vi);
> -	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
> -		    FALLOC_FL_INSERT_RANGE)) {
> -		filemap_invalidate_lock(vi->i_mapping);
> -		map_locked = true;
> -	}
> +	/* Take invalidate_lock for all fallocate operations to prevent races */
> +	filemap_invalidate_lock(vi->i_mapping);
>   
>   	switch (mode & FALLOC_FL_MODE_MASK) {
>   	case FALLOC_FL_ALLOCATE_RANGE:
> @@ -1182,8 +1178,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
>   
>   	err = file_modified(file);
>   out:
> -	if (map_locked)
> -		filemap_invalidate_unlock(vi->i_mapping);
> +	filemap_invalidate_unlock(vi->i_mapping);
>   	if (!err) {
>   		if (mode == 0 && NInoNonResident(ni) &&
>   		    offset > old_size) {


Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

