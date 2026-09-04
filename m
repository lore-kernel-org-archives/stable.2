Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CD4746C1;
	Fri,  4 Sep 2026 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525170; cv=none; b=Pwl7X44vk23yAFjXXWj7qsSpBf67aSBUsG9iVlU1lhNhPp9kbokcDoSxn0POb59vsYNiUtfE6YRMmiCdcW42t0apcXZ3UrFiVPepzLXJmNsF0AgXsBZUECGXf2vEmDGLo8MjTvk3p7LdwW0g+IuVsgVm++hNNB6gRSru+mllSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525170; c=relaxed/simple;
	bh=uVe5KPmdXIV5TGHBYVbgYuT3T6AS+qTzDEEgflvdbaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmuXVN/XxLUruGHqvU8sBCnjx8cVWyzgLfunZVacpYqwpMtBcy7G9Q2IcoYPi2lmoR58LLOjVYomML2GZtOTx9QTmKtpUqhasaqMlzd70SanJGAEqYOG0dG3nRBobxhakTuDvTFSqSgcUZzY6wMzEQhOYMkqkt1XtsxjRCpBa5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kg2pFv3y; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kg2pFv3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=R+OO0FIeZ4jR48hQ7DPYIbFnRwaPxTHGZNwKCKboTtE=;
	b=kg2pFv3yy2H+wLNVnxEag37YEqsHsAMJTKwChuwDpWvp5CmL/PN1AuXrCYdlLo
	H0dSiiROtpEs24Gcyc/WQ8/48T4LPYrqzITaMPqkKwU37nbE4TU213+tVMQNZehW
	1MgYU9UGGnWHnHkHLT14DRMI/TcDVewzZwXfH28yxp7p4=
Message-ID: <43668fe8-3d00-4510-bf1d-42edcb2db479@163.com>
Date: Fri, 4 Sep 2026 20:32:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ntfs: add helper to record error flag before
 setting volume dirty bit
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260903075438.306793-1-zenghongling@kylinos.cn>
 <20260903075438.306793-2-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260903075438.306793-2-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnXN9TuppqgNetAg--.49013S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFW8uryrAr17Wr18Kw1ftFb_yoWfJFW8pF
	Z2qwnxKr4vv34I9wnak3yIg3Za934xGa17GryfJ343Zwn5tr1IqF1Igw1fuF1IkrZ8Jw4I
	qF4jkryUuayDZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uf-BiUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwhQFz2qaulQ03QAA3r



在 2026/9/3 15:54, Hongling Zeng 写道:
> The runtime metadata-corruption paths in fs/ntfs record the error flag
> with a bare NVolSetErrors() and separately rely on ntfs_set_volume_flags()
> or nothing at all to persist VOLUME_IS_DIRTY.  Since the clear side
> (ntfs_sync_fs() via ntfs_clear_volume_dirty_if_no_errors()) evaluates
> NVolErrors() under ni->mrec_lock, a writer that records the error flag
> after the lock has been checked leaves a window in which the volume ends
> up persisted as clean despite the recorded error, so chkdsk will not run
> on the next mount and corrupted metadata can persist.
> 
> Introduce ntfs_mark_volume_dirty_with_error(), which records the error
> flag before the locked dirty-bit write: the mutex acquire/release in
> ntfs_write_volume_flags() then provides the ordering, as any clear path
> running after us can only evaluate NVolErrors() under the lock once the
> flag is set.
> 
> On a read-only mount or before the $Volume inode has been loaded, the
> helper only records the in-memory error state because the dirty bit
> cannot be persisted.  On a writable volume it waits for the lock instead
> of silently dropping the dirty-bit update, and propagates any write
> error to the caller.
> 
> Waiting is safe: the $Volume mrec_lock is a leaf lock.  Its critical
> sections only look up and update the resident volume information
> attribute and never acquire the locks the callers hold (lcnbmp_lock,
> runlist locks), so no lock cycle exists.  To make that explicit to the
> lock validator, give the $Volume inode its own mrec_lock class, the
> same way $MFTMirr already gets one; otherwise the lockdep class shared
> with regular file inodes would report an inversion for the
> lcnbmp_lock -> $Volume mrec_lock ordering that the helper introduces,
> even though no deadlock is possible.
> 
> Mount and remount paths remain serialized by sb->s_umount and keep
> using NVolSetErrors() directly, since they do not race with
> ntfs_sync_fs() and may not be allowed to write the volume: before
> $Volume is loaded, with a read-only opened bdev, or on a hibernated
> volume, which we must not write to at all.  The same applies to the
> ntfs_attr_lookup() failure paths and the mft record writeback paths,
> which hold a caller's mrec_lock and would self-deadlock the helper on
> the $Volume inode.
> 
> Converting the runtime metadata-corruption call sites in mft.c,
> lcnalloc.c, bitmap.c, inode.c and attrib.c to use the helper is done
> in the next patch.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/ntfs.h  |  1 +
>   fs/ntfs/super.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
> index df5a75d506f6..63d7900b6dba 100644
> --- a/fs/ntfs/ntfs.h
> +++ b/fs/ntfs/ntfs.h
> @@ -222,6 +222,7 @@ struct option_t {
>   extern const struct option_t on_errors_arr[];
>   int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags);
>   int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags);
> +int ntfs_mark_volume_dirty_with_error(struct ntfs_volume *vol);
>   int ntfs_write_volume_label(struct ntfs_volume *vol, char *label);
>   
>   /* From fs/ntfs/mst.c */
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index a7977b95b967..64f8d4469af3 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -454,6 +454,45 @@ int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
>   	return ntfs_write_volume_flags(vol, 0, flags, false);
>   }
>   
> +/*
> + * ntfs_mark_volume_dirty_with_error - record an error and mark volume dirty
> + * @vol:	ntfs volume on which an error has been recorded
> + *
> + * To be called when runtime metadata corruption is detected so that chkdsk
> + * runs on the next mount.  NVolErrors() is recorded first, so the in-memory
> + * error state is kept even when the dirty bit cannot be persisted; the
> + * mutex acquire/release in ntfs_write_volume_flags() then provides the
> + * ordering against ntfs_clear_volume_dirty_if_no_errors(), which checks
> + * the flag under the same lock.
> + *
> + * On a read-only mount or before the $Volume inode has been loaded, it
> + * only records the in-memory error state because the dirty bit cannot be
> + * persisted.  On a writable volume it waits for the lock instead of
> + * silently dropping the dirty-bit update, and propagates any write error
> + * to the caller.
> + *
> + * Only for runtime error paths that can race sync and hold no mrec_lock.
> + * The $Volume mrec_lock is a leaf lock: its critical sections never
> + * acquire the locks those paths hold (lcnbmp_lock, runlist locks), so
> + * blocking here cannot deadlock.  Do not call while holding the $Volume
> + * mrec_lock itself (ntfs_attr_lookup() failure and mft writeback paths),
> + * on mount/remount paths (serialized by sb->s_umount, keep using
> + * NVolSetErrors()), or on volumes we must not write to, such as
> + * hibernated ones.
> + *
> + * Return 0 on success and -errno on error.
> + */
> +int ntfs_mark_volume_dirty_with_error(struct ntfs_volume *vol)
> +{
> +	NVolSetErrors(vol);
> +
> +	/* Nothing to persist on a read-only or still-mounting volume. */
> +	if (!vol->vol_ino || sb_rdonly(vol->sb))
> +		return 0;

Hi Hongling,
    It seems that vol->vol_ino != NULL alone may not be sufficient to 
determine whether it is safe to update $Volume here.

   In load_system_files(), both the $Volume inode and the root inode are 
  loaded before the hibernation status is checked:


   vol->vol_ino = ntfs_iget(sb, FILE_Volume);
   ...
   vol->root_ino = ntfs_iget(sb, FILE_root);
   ...
   /*
    * Check if Windows is suspended to disk on the target volume.  If it
    * is hibernated, we must not write *anything* to the disk so set
    * NVolErrors() without setting the dirty volume flag and mount
    * read-only.  This will prevent read-write remounting and it will also
    * prevent all writes.
    */
   err = check_windows_hibernation_status(vol);


    The existing comment above explicitly states that, when hibernation 
is detected, only NVolErrors() should be set, without setting the 
on-disk dirty volume flag or issuing any write to the volume. This is 
necessary because the resumed system continues using filesystem state 
saved in the hibernation image, which is based on the on-disk contents 
at the time of hibernation. Any intervening write by Linux may make the 
saved state inconsistent with the disk and lead to filesystem corruption.

    With patch 3 applied, an error path in ntfs_read_locked_inode() may 
call ntfs_mark_volume_dirty_with_error() while loading the root inode or 
the hiberfil.sys inode. At that point, vol->vol_ino is already valid. On 
a writable mount using errors=continue, sb_rdonly() is also false, so 
the helper may write VOLUME_IS_DIRTY before the hibernation status has 
been established.

    Therefore, I think "$Volume has been loaded" and "volume flags may 
be updated" need to be represented as separate states. The helper should 
persist VOLUME_IS_DIRTY only after the hibernation check has completed 
successfully and the mount has been confirmed writable. Before that,it 
should only set NVolErrors().

Thanks,
Baolin.



> +
> +	return ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
> +}
> +
>   /*
>    * ntfs_clear_volume_dirty_if_no_errors - clear dirty bit if no errors exist
>    * @vol:	ntfs volume whose dirty bit should be cleared
> @@ -918,7 +957,8 @@ static void ntfs_setup_allocators(struct ntfs_volume *vol)
>   }
>   
>   static struct lock_class_key mftmirr_runlist_lock_key,
> -			     mftmirr_mrec_lock_key;
> +			     mftmirr_mrec_lock_key,
> +			     volume_mrec_lock_key;
>   /*
>    * load_and_init_mft_mirror - load and setup the mft mirror inode for a volume
>    * @vol:	ntfs super block describing device whose mft mirror to load
> @@ -1502,6 +1542,15 @@ static bool load_system_files(struct ntfs_volume *vol)
>   		ntfs_error(sb, "Failed to load $Volume.");
>   		goto iput_lcnbmp_err_out;
>   	}
> +	/*
> +	 * Give the $Volume inode its own mrec_lock class: the error paths
> +	 * take it while holding locks (lcnbmp_lock, runlist locks) that
> +	 * nest inside mrec_lock elsewhere in the driver, and the lock
> +	 * validator would otherwise see that as an inversion even though
> +	 * the $Volume critical sections never acquire those locks.
> +	 */
> +	lockdep_set_class(&NTFS_I(vol->vol_ino)->mrec_lock,
> +			  &volume_mrec_lock_key);
>   	m = map_mft_record(NTFS_I(vol->vol_ino));
>   	if (IS_ERR(m)) {
>   iput_volume_failed:

