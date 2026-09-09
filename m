Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BBA313293;
	Wed,  9 Sep 2026 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966555; cv=none; b=P1IBc4I1DJYEE7xrxleZqDhwk74Ao8HFS9/3uMpM6RZOuxBXYzM5LWnpFfkdu1S0VB7G9qKqGAhu54fRQldcCFRBfyq7W4V1BnJYVF3gXBGqeLSMVAGvy7cQ7OZS8x9k47/wubUoDAjd9G4AkWjRrQI1ZFelChq7N8h6O2ghxQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966555; c=relaxed/simple;
	bh=bpDVWqm4+VVzatSkBSi14m9f1ihulJCAA1Sa60EcEt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jt1J8MFcHDZYr9mBRJL0TtalXq0vm1y+4D1up3DTFeLXSrkLxpIrmxQqcx4uiFOwoJXL7f2h9DBiXg+DvA439C/d3n5S9HaK+xSv6tXKC0YQ7j+YmNv2GXoPUrFwKYMNN1gzytIYAONsNWZgw6C0kgTjrrfgHwwrWDsnH0We4v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SVFDo0o4; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SVFDo0o4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=08pCYz9qeWuPC8LYrEp70FO3fJ/vlEE6PlOEv50UwTU=;
	b=SVFDo0o4Io7csTxr3TeJVeei+vDuf8iHfqkLNt1cOceXZ6Dw3GMrOd8HqRdD0J
	94qlGbbRiJADEYpnOeNDy8dcHcdQGSs61M+tQoRZg6SznN0HOFAZDu02iL5IiVrf
	en9RKBHX+9vQp2IFHSV94jQM0Dc8WJzNuPuPHSZVZTO/Y=
Message-ID: <5061b516-9804-4972-9e48-b854ac9696a0@163.com>
Date: Wed, 9 Sep 2026 23:08:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5 2/4] ntfs: set the volume dirty bit unconditionally on
 metadata changes
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Baolin Liu <liubaolin@kylinos.cn>,
 stable@vger.kernel.org
References: <20260909091052.1217728-1-zenghongling@kylinos.cn>
 <20260909091052.1217728-3-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260909091052.1217728-3-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3ZkR7dqFqATCmBg--.34576S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3trW5Wr48AF48ur1Uuw4fAFb_yoW8WFW5Go
	WFk3ZIvanYkr15Aryvk3y8Jasxua98GrW8JFW5ur1DZasYgw1qkry29wsrWa43W3WrKF4D
	K34xJ34rZrZ8AFyUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0mhwUUUUU
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6hy-imqhdnwlbQAA3K



在 2026/9/9 17:10, Hongling Zeng 写道:
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
> The IOCB_NOWAIT path in ntfs_file_write_iter() must not sleep (it
> takes the inode lock with inode_trylock() for exactly that reason),
> so it uses ntfs_set_volume_flags_nowait(): the mrec_lock is acquired
> with mutex_trylock(), the search context is allocated with GFP_ATOMIC,
> and a $Volume inode carrying an attribute list, whose extent mapping
> could block, is rejected; each of those failures returns -EAGAIN.
> Any failure of the marking fails the NOWAIT request itself, so the
> write can no longer proceed on a volume whose dirty bit could not be
> set.
> 
> The sleeping callers keep the pre-existing behavior of proceeding
> when the marking fails, so the dirty bit remains best-effort there;
> the NOWAIT write path is the exception in that it fails the request.
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
>   fs/ntfs/attrib.c | 30 +++++++++++++++++-----
>   fs/ntfs/attrib.h |  2 ++
>   fs/ntfs/file.c   | 29 +++++++++++++++------
>   fs/ntfs/namei.c  | 24 ++++++------------
>   fs/ntfs/ntfs.h   |  1 +
>   fs/ntfs/super.c  | 66 ++++++++++++++++++++++++++++++++++++++++++------
>   6 files changed, 114 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index c7c09a751c6a..b51f8abeaacf 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -1678,20 +1678,24 @@ void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
>   }
>   
>   /*
> - * ntfs_attr_get_search_ctx - allocate/initialize a new attribute search context
> + * ntfs_attr_get_search_ctx_gfp - allocate/initialize a new attribute search
> + * context using the given allocation flags
>    * @ni:		ntfs inode with which to initialize the search context
>    * @mrec:	mft record with which to initialize the search context
> + * @gfp:	allocation flags for the search context
>    *
> - * Allocate a new attribute search context, initialize it with @ni and @mrec,
> - * and return it. Return NULL if allocation failed.
> + * Allocate a new attribute search context with kmem_cache_alloc(@gfp),
> + * initialize it with @ni and @mrec, and return it. Return NULL if allocation
> + * failed.  Callers that must not sleep, e.g. those servicing an IOCB_NOWAIT
> + * request, pass GFP_ATOMIC so the allocation cannot enter direct reclaim.
>    */
> -struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
> -		struct mft_record *mrec)
> +struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx_gfp(
> +		struct ntfs_inode *ni, struct mft_record *mrec, gfp_t gfp)
>   {
>   	struct ntfs_attr_search_ctx *ctx;
>   	bool init;
>   
> -	ctx = kmem_cache_alloc(ntfs_attr_ctx_cache, GFP_NOFS);
> +	ctx = kmem_cache_alloc(ntfs_attr_ctx_cache, gfp);
>   	if (ctx) {
>   		init = ntfs_attr_init_search_ctx(ctx, ni, mrec);
>   		if (init == false) {
> @@ -1703,6 +1707,20 @@ struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
>   	return ctx;
>   }
>   
> +/*
> + * ntfs_attr_get_search_ctx - allocate/initialize a new attribute search context
> + * @ni:		ntfs inode with which to initialize the search context
> + * @mrec:	mft record with which to initialize the search context
> + *
> + * Allocate a new attribute search context, initialize it with @ni and @mrec,
> + * and return it. Return NULL if allocation failed.
> + */
> +struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(
> +		struct ntfs_inode *ni, struct mft_record *mrec)
> +{
> +	return ntfs_attr_get_search_ctx_gfp(ni, mrec, GFP_NOFS);
> +}
> +
>   /*
>    * ntfs_attr_put_search_ctx - release an attribute search context
>    * @ctx:	attribute search context to free
> diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
> index 6b4fa9f57640..dd3c39668eff 100644
> --- a/fs/ntfs/attrib.h
> +++ b/fs/ntfs/attrib.h
> @@ -88,6 +88,8 @@ static inline s64 ntfs_attr_size(const struct attr_record *a)
>   void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx);
>   struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
>   		struct mft_record *mrec);
> +struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx_gfp(
> +		struct ntfs_inode *ni, struct mft_record *mrec, gfp_t gfp);
>   void ntfs_attr_put_search_ctx(struct ntfs_attr_search_ctx *ctx);
>   int ntfs_attr_size_bounds_check(const struct ntfs_volume *vol,
>   		const __le32 type, const s64 size);
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 007d1614b9ac..32a644ff21b6 100644
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
> @@ -620,8 +619,24 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		goto out_lock;
>   	}
>   
> -	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
> +	/*
> +	 * The volume must be marked dirty before the modification is made,
> +	 * without an unlocked check of the in-memory flag: ntfs_sync_fs()
> +	 * can clear the bit concurrently and the modification would then
> +	 * land on a volume that is clean on disk.  In the IOCB_NOWAIT case
> +	 * the marking must not sleep, so it uses the nowait variant, and
> +	 * any failure of the marking fails the request instead of letting
> +	 * the write proceed on a volume that may be clean on disk.
> +	 */
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		err = ntfs_set_volume_flags_nowait(vol, VOLUME_IS_DIRTY);
> +		if (err) {
> +			ret = err;
> +			goto out_lock;
> +		}
> +	} else {
>   		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +	}
>   
>   	pos = iocb->ki_pos;
>   	count = ret;
> @@ -1153,11 +1168,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
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
> diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
> index 45f77848a9cf..b76501a91143 100644
> --- a/fs/ntfs/ntfs.h
> +++ b/fs/ntfs/ntfs.h
> @@ -219,6 +219,7 @@ struct option_t {
>   };
>   extern const struct option_t on_errors_arr[];
>   int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags);
> +int ntfs_set_volume_flags_nowait(struct ntfs_volume *vol, __le16 flags);
>   int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags);
>   int ntfs_write_volume_label(struct ntfs_volume *vol, char *label);
>   
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 6ba19986a598..fbed0ecd9250 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -357,6 +357,7 @@ void ntfs_handle_error(struct super_block *sb)
>    * @vol:	ntfs volume on which to modify the flags
>    * @set_bits:	bits to set in the volume information flags
>    * @clear_bits:	bits to clear in the volume information flags
> + * @nowait:	do not wait for the $Volume mrec_lock
>    *
>    * Internal function.  You probably want to use ntfs_{set,clear}_volume_flags()
>    * instead (see below).
> @@ -368,19 +369,33 @@ void ntfs_handle_error(struct super_block *sb)
>    * All bit manipulation is done on CPU-endian values, and the result is
>    * converted back to little-endian before storing it.
>    *
> + * When @nowait is set, the call must not sleep: the mrec_lock is acquired
> + * with mutex_trylock() and a contended lock fails with -EAGAIN, the search
> + * context is allocated with GFP_ATOMIC and exhausted memory fails with
> + * -EAGAIN, and a $Volume inode carrying an attribute list, whose extent
> + * mapping could block, is rejected with -EAGAIN as well.  The remaining
> + * transition work is non-blocking: the mft record of $Volume stays mapped
> + * for the lifetime of the mount, so the attribute lookup is an in-memory
> + * scan, and marking the record dirty does not submit I/O.
> + *
>    * Return 0 on success and -errno on error.
>    */
>   static int ntfs_write_volume_flags(struct ntfs_volume *vol,
>   		const __le16 set_bits, const __le16 clear_bits,
> -		const bool skip_if_errors)
> +		const bool skip_if_errors, const bool nowait)
>   {
>   	struct ntfs_inode *ni = NTFS_I(vol->vol_ino);
>   	struct volume_information *vi;
> -	struct ntfs_attr_search_ctx *ctx;
> +	struct ntfs_attr_search_ctx *ctx = NULL;
>   	u16 flags;
>   	int err;
>   
> -	mutex_lock(&ni->mrec_lock);
> +	if (nowait) {
> +		if (!mutex_trylock(&ni->mrec_lock))
> +			return -EAGAIN;
> +	} else {
> +		mutex_lock(&ni->mrec_lock);
> +	}
>   
>   	if (skip_if_errors && NVolErrors(vol))
>   		goto done;
> @@ -394,9 +409,21 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol,
>   	if (le16_to_cpu(vol->vol_flags) == flags)
>   		goto done;
>   
> -	ctx = ntfs_attr_get_search_ctx(ni, NULL);
> +	/*
> +	 * The nowait path must not sleep past this point either.  An
> +	 * attribute list on $Volume would make ntfs_attr_lookup() map
> +	 * extent mft records, which can block; sane volumes never have
> +	 * one, so refuse such a volume instead of risking the sleep.
> +	 */
> +	if (nowait && NInoAttrList(ni)) {
> +		err = -EAGAIN;
> +		goto put_unm_err_out;
> +	}
Hi Hongling,
    This should not go through put_unm_err_out. Both this case and the 
NOWAIT allocation failure below return -EAGAIN for conditions where the 
operation cannot be completed without blocking, but put_unm_err_out 
calls ntfs_error(). That turns an expected NOWAIT failure into a 
filesystem error and may trigger errors=remount-ro or errors=panic.

   Please use a separate exit that only drops the search context, 
unlocks mrec_lock and returns the error. The mrec_lock contention case 
already returns directly.

Thanks,
Baolin.

> +
> +	ctx = ntfs_attr_get_search_ctx_gfp(ni, NULL,
> +			nowait ? GFP_ATOMIC | __GFP_NOWARN : GFP_NOFS);

Also, GFP_NOWAIT should be sufficient for the search-context allocation. 
This is process context and the operation only needs to avoid reclaim, 
so using GFP_ATOMIC unnecessarily consumes the atomic allocation reserves.

>   	if (!ctx) {
> -		err = -ENOMEM;
> +		err = nowait ? -EAGAIN : -ENOMEM;
>   		goto put_unm_err_out;
>   	}
>   
> @@ -435,7 +462,30 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol,
>    */
>   int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
>   {
> -	return ntfs_write_volume_flags(vol, flags, 0, false);
> +	return ntfs_write_volume_flags(vol, flags, 0, false, false);
> +}
> +
> +/*
> + * ntfs_set_volume_flags_nowait - set bits without sleeping
> + * @vol:	ntfs volume on which to modify the flags
> + * @flags:	flags to set on the volume
> + *
> + * Same as ntfs_set_volume_flags(), except that the call does not sleep.
> + * Contended mrec_lock, exhausted atomic memory and an attribute list on
> + * $Volume (whose extent mapping could block) each fail with -EAGAIN; see
> + * ntfs_write_volume_flags() for why the remaining path is non-blocking.
> + * For callers servicing an IOCB_NOWAIT request, which must fail with
> + * -EAGAIN rather than sleep.
> + *
> + * A failure means the flags were NOT set; such callers should fail the
> + * request rather than proceed with the modification.
> + *
> + * Return 0 on success, -EAGAIN when the operation would have to sleep and
> + * -errno on other errors.
> + */
> +int ntfs_set_volume_flags_nowait(struct ntfs_volume *vol, __le16 flags)
> +{
> +	return ntfs_write_volume_flags(vol, flags, 0, false, true);
>   }
>   
>   /*
> @@ -451,7 +501,7 @@ int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
>    */
>   int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
>   {
> -	return ntfs_write_volume_flags(vol, 0, flags, false);
> +	return ntfs_write_volume_flags(vol, 0, flags, false, false);
>   }
>   
>   /*
> @@ -464,7 +514,7 @@ int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
>    */
>   static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume *vol)
>   {
> -	return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
> +	return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true, false);
>   }
>   
>   int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)

