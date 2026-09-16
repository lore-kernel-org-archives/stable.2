Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917741D647;
	Wed, 16 Sep 2026 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590270; cv=none; b=t04bNfP/Is+GprBWYr2pOcKBzk4eJq6UQE7Ys6IZVvlCg2rFApm+nG5K+qYySC/nLxHkxPOhbTn7UnHDTtm7kOeSS7XKOKmWP4X7p0Efw6X/pT5g31T8B2ABkeP9hnz+uDIgWOO/Mj9qmB4tfrrNdKgc0I6uiArisyXCJp/s6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590270; c=relaxed/simple;
	bh=ZxTg9lGXvchwT2hJXTmPRLILSLkhibgW8Fxc2M5++UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxTk2ClEREWVn+wttWubKnwx4xq0f4HQVKFjLNXewwF5tJmg2xGL4BYze3QNr5dCuxvXx3f29pb9nRTFs+79Ak6EN8WSgIZCSI0aprgLb6D8mt5St42KrQOp2nWlloLN0uUge0Xt+zcI8KkYUOR+ettkhiFDuqCXaeeJZtBxsag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YK9bMqpL; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YK9bMqpL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=atQxFVvGmxNAp2GBjVwAJePvy3VWtH6k/S2SXa6Pf+Y=;
	b=YK9bMqpLuZ+awpFaBnkUaj4ZYpnnuL01u3J1m5cb1PCulDfM5K7S98l/tJVQom
	5xLTtTF+J2ncui8YAGpBjQhhQs6OiE7460Pa+krf1dtrES6E2ZpSQSQUXgGMoCBH
	E3YXBjqhLinI2w7DPqhDiuH+Tmy6lX2qBy9QcCdSlzTCM=
Received: from [IPV6:2409:8900:21a7:a33a:b45d:31d1:c098:7d46] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnT4jE+qpqTSxmBA--.42801S2;
	Thu, 17 Sep 2026 04:23:32 +0800 (CST)
Message-ID: <07b6a57f-cdd6-4baf-89b9-353d61921780@163.com>
Date: Thu, 17 Sep 2026 04:23:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/7] ntfs: set the volume dirty bit unconditionally on
 metadata changes
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Baolin Liu <liubaolin@kylinos.cn>,
 stable@vger.kernel.org
References: <20260915083252.812126-1-zenghongling@kylinos.cn>
 <20260915083252.812126-3-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260915083252.812126-3-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT4jE+qpqTSxmBA--.42801S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF4fKF4xZw4kGw4fZFyxXwb_yoWxWw15pr
	saya1ak3ykJFy7Wwn2qr4rZr9Yv34UGr18CrWrK3Wav3s5tr10qFnagF129a4Fyr93Cw1k
	tF45Kr45Ww17ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uf9N-UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6QU1AGqq+sVYBQAA37



在 2026/9/15 16:32, Hongling Zeng 写道:
> The callers in file.c and namei.c skip ntfs_set_volume_flags() when
> the in-memory vol_flags already show VOLUME_IS_DIRTY, but that check
> runs without any lock: if it observes the bit set and ntfs_sync_fs()
> clears it under the mrec_lock before the caller's metadata update
> completes, the set is skipped and the volume can end up clean on disk
> despite the modification, so chkdsk will not run on the next mount.
> 
> Drop the caller-side checks and call ntfs_set_volume_flags()
> unconditionally: ntfs_write_volume_flags() already skips the write
> under the mrec_lock when the combined value is unchanged.  That
> unconditional call costs one mrec_lock acquisition per metadata
> operation even in the already-dirty steady state; it cannot be
> avoided, because deciding to skip the call without the lock is itself
> what allows a concurrent ntfs_sync_fs() clear to lose the set.
> 
> The IOCB_NOWAIT path in ntfs_file_write_iter() goes through the same
> sleeping call: a RWF_NOWAIT write can block in the marking, as it
> already could before this change whenever the volume appeared clean.
> Giving that path a non-blocking variant is left as follow-up work.
> The callers keep the pre-existing behavior of proceeding when the
> marking fails, so the dirty bit remains best-effort.
> 
> This closes the variant where the set is skipped outright.  A clear
> for a concurrent, error-free sync can still land between the set and
> the end of the metadata operation; that mark-at-start lifecycle is
> pre-existing and is not changed by this patch.
> 
> Reported-by: Baolin Liu <liubaolin@kylinos.cn>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/file.c  | 20 +++++++++++---------
>   fs/ntfs/namei.c | 24 ++++++++----------------
>   2 files changed, 19 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 007d1614b9ac..cfc7b36b7dff 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -325,8 +325,7 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   		goto out;
>   	}
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
> -		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>   
>   	if (ia_valid & ATTR_SIZE) {
>   		err = ntfs_setattr_size(vi, attr);
> @@ -620,8 +619,13 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		goto out_lock;
>   	}
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
> -		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	/*
> +	 * The volume must be marked dirty before the modification is made,
> +	 * without an unlocked check of the in-memory flag: ntfs_sync_fs()
> +	 * can clear the bit concurrently and the modification would then
> +	 * land on a volume that is clean on disk.
> +	 */
> +	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>   
>   	pos = iocb->ki_pos;
>   	count = ret;
> @@ -1153,11 +1157,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
>   			return err;
>   	}
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY)) {
> -		err = ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> -		if (err)
> -			return err;
> -	}
> +	err = ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	if (err)
> +		return err;
>   
>   	old_size = i_size_read(vi);
>   
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index fdf52fac4329..3e0adb9a0ea4 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -757,8 +757,7 @@ static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
>   		return err;
>   	}
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
> -		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>   
>   	ni = __ntfs_create(idmap, dir, uname, uname_len, S_IFREG | mode, 0, NULL, 0);
>   	kmem_cache_free(ntfs_name_cache, uname);
> @@ -1032,8 +1031,7 @@ static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
>   		return err;
>   	}
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
> -		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>   
>   	err = ntfs_delete(ni, NTFS_I(dir), uname, uname_len, true);
>   	if (err)
> @@ -1076,8 +1074,7 @@ static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>   		return ERR_PTR(err);
>   	}
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
> -		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>   
>   	ni = __ntfs_create(idmap, dir, uname, uname_len, mode, 0, NULL, 0);
>   	kmem_cache_free(ntfs_name_cache, uname);
> @@ -1118,8 +1115,7 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
>   		return err;
>   	}
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
> -		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>   
>   	err = ntfs_delete(ni, NTFS_I(dir), uname, uname_len, true);
>   	if (err)
> @@ -1305,8 +1301,7 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>   		new_dir_first = is_subdir(new_dentry->d_parent,
>   					  old_dentry->d_parent);
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
> -		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>   
>   	mutex_lock_nested(&old_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
>   	if (new_ni)
> @@ -1429,8 +1424,7 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>   		goto out;
>   	}
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
> -		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>   
>   	ni = __ntfs_create(idmap, dir, usrc, usrc_len, S_IFLNK | 0777, 0,
>   			   symname, symlen);
> @@ -1474,8 +1468,7 @@ static int ntfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>   		return err;
>   	}
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
> -		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>   
>   	switch (mode & S_IFMT) {
>   	case S_IFCHR:
> @@ -1521,8 +1514,7 @@ static int ntfs_link(struct dentry *old_dentry, struct inode *dir,
>   		return -ENOMEM;
>   	}
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
> -		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>   
>   	ihold(vi);
>   	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

