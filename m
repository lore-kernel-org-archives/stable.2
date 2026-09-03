Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1E48CFC;
	Thu,  3 Sep 2026 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404497; cv=none; b=Sy9aRbqpaRv7Zle5RJQC8B/aJXn12tIiKTqE71qC11T+VUwfFlnygD5xC/D17jFrRnE4pfP3sSxQYNucJue5z0KfGSlLAv2DD0HjvK3n6pT27vh6eZash0+KS6d6pQgu9IWpgSWrRIFlxA/mJei85wICV/wvlODKTU6vgD+vCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404497; c=relaxed/simple;
	bh=2DtE4kXflOyOPHgQbVcdlq8uGI0Og9ZVoQKaVqksoUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKeUshKoljxrRjRMzae3M9CYygmMJu1DTJT0T+YVkKmr24obb827866KDHfuGFGfJIhsg76cwLN8fMFyLwigoArK+Cp7nh+Cqci/WY6xn5DgKwFnAUd0ZR4unfGlOYvS30Q2z7Cqw8YhaRpgnOpZAWhvUMERZP1ntHHoz7N6ZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BCkg+hfX; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BCkg+hfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=/vyZGP3AqBX16rWx2MyA0v2TVP0L/R2KvgKkquwUJ6Y=;
	b=BCkg+hfXnR7HpemdNvTFxiDkzWZz3XejtFhXv2tAh9kgid9jvFe9G6eskXJBQL
	AujjANF+0xaubImxq2v+wbbZP25K2d+ETrdLxhfrM+yk6ZRk8IO6wh77t3YaB4l0
	fVZAYvYG3/i6ljWmQwp1LAjI596vR4ub7rP6VALm3hnRY=
Received: from [IPV6:2409:8900:1a96:d5f:b0d5:8955:9102:74c7] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnawDz4phqwbdwOQ--.17148S2;
	Thu, 03 Sep 2026 11:01:08 +0800 (CST)
Message-ID: <d576d6d6-e378-4124-817a-f019c09c391e@163.com>
Date: Thu, 3 Sep 2026 11:01:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ntfs: fix volume flag update races
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260903012104.185926-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260903012104.185926-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDnawDz4phqwbdwOQ--.17148S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF4UZrWrAr4fCw1DGr1rZwb_yoW3CF1Dpr
	s2yF9rKa1qyrnrWws7t3yIgw4S934rGr48Cry7Jw1av3sIyryUXF18K3WrA3Wvyr97Ar1x
	XFWjyrW5uw1UZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-db8UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6hS2gWqY4vTjBwAA3J



在 2026/9/3 09:21, Hongling Zeng 写道:
> ntfs_set_volume_flags() and ntfs_clear_volume_flags() both read
> vol->vol_flags outside any lock to compute the new value before handing
> it to ntfs_write_volume_flags(), which only takes ni->mrec_lock around
> the actual write. The read-modify-write is therefore not atomic, and two
> concurrent callers can lose an update: ntfs_sync_fs() may derive a
> "clean" value from vol->vol_flags while a writer concurrently records an
> error and sets VOLUME_IS_DIRTY; the locked write then silently
> overwrites the freshly-set dirty bit. The on-disk volume looks clean
> despite the recorded errors, so chkdsk will not run on the next mount
> and corrupted metadata can persist.
> 
> Fix by moving the read-modify-write inside the mrec_lock: pass the bits
> to set and to clear separately, and combine them with the current flag
> state under the lock inside ntfs_write_volume_flags(). The set/clear
> helpers pass only the bits to modify, not the complete flag state. The
> bit manipulation is done on CPU-endian values, and the result is
> converted back to little-endian before storing it. The wrappers keep
> their signatures so callers are unchanged.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
> - Also fix the ntfs_sync_fs() race by checking NVolErrors() and clearing
>    VOLUME_IS_DIRTY under ni->mrec_lock.
> - Keep ntfs_set_volume_flags() and ntfs_clear_volume_flags() semantics
>    unchanged.
> - Do not tie setting VOLUME_IS_DIRTY to NVolSetErrors() in the generic
>    set helper.
> ---
>   fs/ntfs/super.c | 62 +++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index a1813093222b..a7977b95b967 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -353,31 +353,45 @@ void ntfs_handle_error(struct super_block *sb)
>   }
>   
>   /*
> - * ntfs_write_volume_flags - write new flags to the volume information flags
> + * ntfs_write_volume_flags - apply flag changes to the volume information flags
>    * @vol:	ntfs volume on which to modify the flags
> - * @flags:	new flags value for the volume information flags
> + * @set_bits:	bits to set in the volume information flags
> + * @clear_bits:	bits to clear in the volume information flags
>    *
>    * Internal function.  You probably want to use ntfs_{set,clear}_volume_flags()
>    * instead (see below).
>    *
> - * Replace the volume information flags on the volume @vol with the value
> - * supplied in @flags.  Note, this overwrites the volume information flags, so
> - * make sure to combine the flags you want to modify with the old flags and use
> - * the result when calling ntfs_write_volume_flags().
> + * Combine @set_bits and @clear_bits with the current in-memory flag state and
> + * write the result back.  The set/clear helpers pass only the bits to modify,
> + * not the complete flag state.  The read-modify-write happens under
> + * ni->mrec_lock so that concurrent set/clear operations cannot lose updates.
> + * All bit manipulation is done on CPU-endian values, and the result is
> + * converted back to little-endian before storing it.
>    *
>    * Return 0 on success and -errno on error.
>    */
> -static int ntfs_write_volume_flags(struct ntfs_volume *vol, const __le16 flags)
> +static int ntfs_write_volume_flags(struct ntfs_volume *vol,
> +		const __le16 set_bits, const __le16 clear_bits,
> +		const bool skip_if_errors)
>   {
>   	struct ntfs_inode *ni = NTFS_I(vol->vol_ino);
>   	struct volume_information *vi;
>   	struct ntfs_attr_search_ctx *ctx;
> +	u16 flags;
>   	int err;
>   
> -	ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
> -			le16_to_cpu(vol->vol_flags), le16_to_cpu(flags));
>   	mutex_lock(&ni->mrec_lock);
> -	if (vol->vol_flags == flags)
> +
> +	if (skip_if_errors && NVolErrors(vol))
> +		goto done;
> +
> +	flags = le16_to_cpu(vol->vol_flags);
> +	flags |= le16_to_cpu(set_bits) & le16_to_cpu(VOLUME_FLAGS_MASK);
> +	flags &= ~(le16_to_cpu(clear_bits) & le16_to_cpu(VOLUME_FLAGS_MASK));
> +	ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
> +			le16_to_cpu(vol->vol_flags), flags);
> +
> +	if (le16_to_cpu(vol->vol_flags) == flags)
>   		goto done;
>   
>   	ctx = ntfs_attr_get_search_ctx(ni, NULL);
> @@ -393,7 +407,7 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol, const __le16 flags)
>   
>   	vi = (struct volume_information *)((u8 *)ctx->attr +
>   			le16_to_cpu(ctx->attr->data.resident.value_offset));
> -	vol->vol_flags = vi->flags = flags;
> +	vol->vol_flags = vi->flags = cpu_to_le16(flags);
>   	mark_mft_record_dirty(ctx->ntfs_ino);
>   	ntfs_attr_put_search_ctx(ctx);
>   done:
> @@ -414,13 +428,14 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol, const __le16 flags)
>    * @flags:	flags to set on the volume
>    *
>    * Set the bits in @flags in the volume information flags on the volume @vol.
> + * The bits are combined with the current flag state under the lock in
> + * ntfs_write_volume_flags(), so concurrent updates are not lost.
>    *
>    * Return 0 on success and -errno on error.
>    */
>   int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
>   {
> -	flags &= VOLUME_FLAGS_MASK;
> -	return ntfs_write_volume_flags(vol, vol->vol_flags | flags);
> +	return ntfs_write_volume_flags(vol, flags, 0, false);
>   }
>   
>   /*
> @@ -429,14 +444,27 @@ int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
>    * @flags:	flags to clear on the volume
>    *
>    * Clear the bits in @flags in the volume information flags on the volume @vol.
> + * The bits are combined with the current flag state under the lock in
> + * ntfs_write_volume_flags(), so concurrent updates are not lost.
>    *
>    * Return 0 on success and -errno on error.
>    */
>   int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
>   {
> -	flags &= VOLUME_FLAGS_MASK;
> -	flags = vol->vol_flags & cpu_to_le16(~le16_to_cpu(flags));
> -	return ntfs_write_volume_flags(vol, flags);
> +	return ntfs_write_volume_flags(vol, 0, flags, false);
> +}
> +
> +/*
> + * ntfs_clear_volume_dirty_if_no_errors - clear dirty bit if no errors exist
> + * @vol:	ntfs volume whose dirty bit should be cleared
> + *
> + * Check NVolErrors() and clear VOLUME_IS_DIRTY under the same mrec_lock so
> + * ntfs_sync_fs() cannot clear the dirty bit after a concurrent error has been
> + * recorded.
> + */
> +static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume *vol)
> +{
> +	return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
>   }
>   
>   int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
> @@ -1862,7 +1890,7 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
>   		return 0;
>   
>   	/* If there are some dirty buffers in the bdev inode */
> -	if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY)) {
> +	if (ntfs_clear_volume_dirty_if_no_errors(vol)) {
>   		ntfs_warning(sb, "Failed to clear dirty bit in volume information flags.  Run chkdsk.");
>   		err = -EIO;
>   	}

Hi Hongling,
   Patch 1 fixes the race in ntfs_sync_fs(), but there are two other 
sites with the same check-outside-lock-then-clear-inside-lock pattern:

   1. super.c:315 (ntfs_reconfigure, remount read-only path)
   2. super.c:1755 (ntfs_put_super, umount path)

   Both use:
       if (!NVolErrors(vol)) {   // check outside lock
           if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))  // clear 
inside lock

   The same race can occur: if an error thread sets NVolErrors() and the
   dirty bit after the check but before the lock acquisition, the clear
   operation will overwrite the freshly-set dirty bit.

   Although the race window is much narrower for remount/umount, should
   these two sites also be converted to use
   ntfs_clear_volume_dirty_if_no_errors() for consistency?

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>


Thanks,
Baolin.

