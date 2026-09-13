Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300F37F75E;
	Sun, 13 Sep 2026 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789288330; cv=none; b=MYYZip0PJX6VwmfnQhWlJkB99qrZDqWt9/eZ0fKm/+RWTzN5nRBWl8OQhZVQ6eZbVGG5/ikOSILBVpvkQ08gkZZ0iM3r9H9ci3OlicJIZvG6VpBe9wgVngMSzRHCcbHNte1q0giBZfGjdga8wL0P1RzCjrGNcGMSUaw58olsbhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789288330; c=relaxed/simple;
	bh=ca2utnnX+Y8ZEYCh36nAYGG+AA5aAxBPEc2YY+527xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4Ro3rUPhL2lDeEXJ/bawZab8hk1ZLhVikaREgVkFI0YHenVIYhTzZ57hVW/X3Yzmw8JmGXnbKTYdGqO7/B5n7MaiktDwK0GAG1ZNeha5GZapHDgTPzK1RnxZIJTyalYTRbK6G2yRnhJMLZpIDQ+ztaGR9lshypF76udBkaIgdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p9dyxLWf; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p9dyxLWf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=EhKP3q7j5/PeKZlGCYhZp7NN0HKYU1247v3yj1hxhpA=;
	b=p9dyxLWfUvGRClUVj7yDZOAvpedDY9/IOVsLUmg2fh78IDMm5yrlcKf/FbUGsE
	ALMTgSCfaAx8FzKrHrEkOVd/RSlkrcv1q3/l2/zzUBU3c2wmzNzqDaEyDqXDFBW3
	4F95OSRYXUlVHFqLjjhncB3uqVXLRu195Gqx9Iuvjvp2E=
Message-ID: <b15c039b-5acd-4be4-88a1-50d4495fdf2d@163.com>
Date: Sun, 13 Sep 2026 16:31:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] ntfs: set the volume dirty bit unconditionally on
 metadata changes
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Baolin Liu <liubaolin@kylinos.cn>,
 stable@vger.kernel.org
References: <20260911020908.2376222-1-zenghongling@kylinos.cn>
 <20260911020908.2376222-3-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260911020908.2376222-3-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC338tiX6ZqhkmmAQ--.27316S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF4fKF4xZw4kGw4fZFyxXwb_yoW3AFyDpr
	saya1ak3ykJry7Wwn2qF4rZryFv34UGr48CrWrK3Wavwn5tr48XFn2g3WS9a4Fyr93Cw4v
	qF45Kr45uw17ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsqXLUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gM0-mqmX2OaQgAA3L



在 2026/9/11 10:09, Hongling Zeng 写道:
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

Hi Hongling,
   The added call removes the unlocked check, but it does not close the 
writer/sync lifecycle race. ntfs_set_volume_flags() protects only the 
read-modify-write of the $Volume record while mrec_lock is held, and 
releases the lock before ntfs_file_write_iter() enters the actual write 
path (ntfs_file_buffered_write() or the direct-I/O path) that modifies 
file data and related MFT metadata.

   For example, the following execution is still possible:

   Writer                                      ntfs_sync_fs()
   ------                                      ------------
   ntfs_set_volume_flags()
       acquire $Volume mrec_lock
       set VOLUME_IS_DIRTY
       update $Volume record
       release $Volume mrec_lock

                                                acquire $Volume mrec_lock
                                            observe NVolErrors() == false
                                                clear VOLUME_IS_DIRTY
                                                release $Volume mrec_lock
                                                commit clean volume flags

   continue ntfs_file_write_iter()
   enter ntfs_file_buffered_write()
   or the direct-I/O write path
   modify file data and related MFT metadata
   commit dirty pages/MFT records

   Thus, the metadata modification can still reach disk after 
ntfs_sync_fs() has persisted a clean on-disk dirty bit. The mrec_lock 
serializes only individual $Volume flag updates; it does not cover the 
subsequent write operation. Therefore, the guarantee described in the 
comment above is incomplete, and the same race applies to the other 
unconditional dirty-bit calls added by this patch.

Thanks,
Baolin.

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

