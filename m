Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB74779B2;
	Fri,  4 Sep 2026 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523616; cv=none; b=SPkD0MGLEHOmpxdNcWiWiEVJm+GCxmsQLHpnd1DaaaPcfwBXzJKMUrx8CVG7ah/suW0BmSB7qdec2FnSJ7VeIw5RM7HKCMHijldRE7cOnDefX83qADphXaD9YTtBraRkXi0NtRvF36jzxRiLyhox6mDmLqWrgThZh04oLH7HO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523616; c=relaxed/simple;
	bh=/0xSHkvGkWBLut5hgLuUOPBtF44cnE8G8O1sBZV39sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKo+eFVYiUH3gZicGHdfc9mCpp6+iBcdh/XvCjyy6t6csFwn2/pUeCNbWP/WntAyiOyV+ElTMkzNxDS60Uv5G5S+K4TfMR2dgUQL1AReCMmEBfiSzLlBMcSa8mLjYanV+TiCei3QbPrHIvTkr+LFGt4RPiKpjr7CJyuaCpmeIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UjRyQm5o; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UjRyQm5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=bHy0K7hiAjWDGJdeTs7jklwrmWW0vhzboRPTq9Qs7hk=;
	b=UjRyQm5oUSfOSDRn/gznez75ih3NohwJXrxvdmK5W/53qyy1Wa8ugi6X2ET5Ut
	HoFIJFzbJ3LPknPVDSHxrb08jK2A8GAWtjVpyLOg5k2xv2N+kDKRVRlZ9FMTBdMK
	SuF9DqFGkU9bZnST2PVUeXHCQ3XJP7AE7Ddq8NPfr30r8=
Message-ID: <9120e094-a5ac-4d27-954f-20528815b954@163.com>
Date: Fri, 4 Sep 2026 20:06:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ntfs: fix volume flag update races
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260903075438.306793-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260903075438.306793-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnLpo+tJpq4ReHAg--.42905S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfGrWDAw17Ww4ftF47WF1rZwb_yoWDCr1rpF
	ZayF9xKa1Dtr1xWws7tw4IgFWS9ry8JF4UCryxJw1av3s0yryUXF18K3WrZFyvyr9rAr1I
	qFWjy3y5uw1UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfnY7UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6h99SGqatD-jDQAA3V



在 2026/9/3 15:54, Hongling Zeng 写道:
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

   Thanks for the update.
   Moving the read-modify-write of vol->vol_flags under the $Volume 
inode's mrec_lock looks correct and prevents concurrent 
ntfs_set_volume_flags() and ntfs_clear_volume_flags() operations from 
overwriting each other's updates.

   However, I think two races involving the clearing of VOLUME_IS_DIRTY 
remain unresolved.

   First, there is still no synchronization covering the complete 
lifetime of a normal writer against ntfs_sync_fs(). The normal write 
paths still contain code such as:
   if (!(vol->vol_flags & VOLUME_IS_DIRTY))
   	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);

   /* File data or metadata is modified afterwards. */

   The following sequence therefore appears possible:

   Writer                              ntfs_sync_fs()
   ------                              --------------
   Observes that dirty is already set
   and skips ntfs_set_volume_flags()
                                       Acquires $Volume mrec_lock
                                       Finds no volume errors
                                       Clears VOLUME_IS_DIRTY
                                       Releases $Volume mrec_lock
   Continues modifying file data
   or metadata
   Completes without setting dirty again

   Even if the outer check were removed and ntfs_set_volume_flags() were 
called unconditionally, this would only serialize the individual flag 
update. It would not protect the complete interval between setting the 
dirty bit and completing the metadata modification.

   The helper introduced by patches 2 and 3 only handles metadata-error 
paths. A normal successful writer does not call that helper, so those 
patches do not address the race above.
   Could you please clarify whether another synchronization mechanism 
prevents ntfs_sync_fs() from clearing the dirty bit while a writer is 
still in progress?



   Second, the forced/emergency remount race mentioned in the previous 
discussion also remains. A normal read-only remount goes through 
sb_prepare_remount_readonly() and fails if there
   are existing writers. The SB_FORCE path only calls 
sb_start_ro_state_change(). This prevents new writers from acquiring 
write access, but it neither checks nor waits for writers that
   have already entered the filesystem.

   The following sequence therefore still appears possible:

   Writer                              Forced remount
   ------                              --------------
   Acquires write access and enters
   the NTFS write path
                                       sb_start_ro_state_change()
                                       Prevents new writers
   Remains in progress                 sync_filesystem()
                                       Finds NVolErrors() clear
                                       Clears VOLUME_IS_DIRTY
   Continues modifying metadata,
   or detects and records an error
   only afterwards

   Holding s_umount for write excludes concurrent sync and remount 
operations, but it does not exclude an ordinary writer that has already 
entered NTFS. Likewise, sync_filesystem() does not prove that such 
writers have completed.

   I think a forced remount should clear the dirty bit only after 
confirming that all existing writers have exited while preventing new 
writers from entering. If that cannot be confirmed, the forced remount 
may still proceed, but it should preserve VOLUME_IS_DIRTY.

   This is my analysis, and further discussion is welcome. If you agree 
with it, I suggest adding a follow-up patch to address this race. Please 
also correct me if I have overlooked or misunderstood anything.

Thanks,
Baolin.

