Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615131E858;
	Sun, 13 Sep 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789307242; cv=none; b=DkqrM0BO2pBRQnIvgdCeJeKuUKS4dXH22uuZMr4ehYXJmRauELq9I0EplO8L1FJQ6utauNXHyAFsbfEeh7GOoMbTSY4tCVvu7YaKR8TShIEz5o0cV4ZiMIEfnY8cr42j01InELunLry3fdgto4VktksD9OukWdhzGprpoz8NXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789307242; c=relaxed/simple;
	bh=vKHGqNbZr3VHadp6mIYicoe0gb09lth0hEIzVxUMVk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMWMc00GXZIHLtEGk1KHE9nRIhhBAfI/JPl6mHzb41hGgNLJ/5I/tHMqbqB/EhEdYQG4lWzkiLRUZJa9uxTYFrpw7MlEoBAL6k7I8a3enc55qNmg+URk8Hzsf26ZvXuKXs28DuTcA0p1t8hDtajQLNLIlf8h36N1T8HThLWwaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B0Id+Nb8; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B0Id+Nb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=KrC9UM04WeLmGV4AVsItSPFNigY7hsSQQPp0oL8tF60=;
	b=B0Id+Nb8S4MlnFAK6ndSLcAEFOhEiwzw/8hLAu/09G5aCG0ItG7lXy5tMEjFxp
	p3o515aCDcVNs+Veam2VbsY6mZAFAo7p3ue/e1UnAING8t5tIL5Zu1frD70kMBcA
	eYgk0ev9OXQzd9K8WvWqeaQea7SjconjggDDA5Qs8djeI=
Message-ID: <5fbd935a-b62e-4081-b8b6-01c8f0af064c@163.com>
Date: Sun, 13 Sep 2026 21:46:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] ntfs: sync the volume dirty bit with the recorded
 error state
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260911020908.2376222-1-zenghongling@kylinos.cn>
 <20260911020908.2376222-4-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260911020908.2376222-4-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H2BGqaZqF+zqAQ--.27031S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3Kw4ktFyrCryxXFWrJw1xAFb_yoW8Wr1xCo
	W0kFyqvw4xKwnrAayvywn3Cw4S9a909F4fXF45Gr1DZ34qgw4UC347Wws8WFZrGa15Kr1U
	C34xJanYqFW8tFyxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUejgxUUUUU
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6ge-imqmqUcXsAAA3d



在 2026/9/11 10:09, Hongling Zeng 写道:
> The runtime metadata-corruption paths in fs/ntfs only record the
> in-memory NVolErrors() flag; whether VOLUME_IS_DIRTY ever reaches disk
> depends on ntfs_set_volume_flags() being called by some other path,
> which for most error sites never happens.  A volume can therefore
> unmount with a clean on-disk flag despite recorded corruption, and
> chkdsk will not run on the next mount.
> 
> Persisting the dirty bit from the error paths themselves does not work:
> they run under a wide variety of ntfs locks, and the dirty-bit write
> takes the $Volume mrec_lock and maps the $Volume mft record, which on
> an $MFT page-cache miss takes the $MFT runlist lock for writing.  That
> is enough to self-deadlock or form ABBA cycles from several of them:
> the $MFT extend undo paths hold the $MFT runlist lock and then take
> vol->lcnbmp_lock inside ntfs_cluster_free(); the cluster allocation and
> free rollback paths hold vol->lcnbmp_lock; and the whole mft record
> allocation tree is reachable from ntfs_write_volume_label()'s
> attribute-list maintenance while it holds the $Volume mrec_lock itself.
> 
> Instead, make the persistence a property of the sync paths, which run
> without ntfs locks held.  The new ntfs_sync_volume_dirty_state() sets
> VOLUME_IS_DIRTY when NVolErrors() is recorded and clears it otherwise,
> evaluating the error flag under the $Volume mrec_lock.  It is called
> from ntfs_sync_fs(), from the remount-to-read-only path of
> ntfs_reconfigure(), and from ntfs_put_super(), which previously
> evaluated NVolErrors() outside the lock before clearing the dirty bit
> unconditionally, and which now also persists the dirty bit for volumes
> with recorded errors so they unmount with chkdsk scheduled.  The
> ntfs_clear_volume_flags() wrapper, whose last callers this patch
> replaces, has no users left and is removed.
> 
> The guarantee this provides is eventual, not instantaneous: the error
> paths record NVolErrors() with a lock-free set_bit(), so a persistence
> point that evaluates the flag just before an error is recorded can
> still leave the on-disk bit clean until the next one.  This is sound
> because NVolErrors() is sticky for the lifetime of the mount and every
> persistence point re-derives the on-disk bit from it; the last one,
> ntfs_put_super(), runs after evict_inodes() on a quiesced filesystem,
> so a volume that is read-write at unmount time cannot unmount clean.
> A volume that is already read-only when the error is recorded
> (errors=remount-ro flips the superblock on the first error, as does an
> earlier remount-ro) has no persistence point left and keeps whatever
> on-disk bit it had; that behaviour is unchanged.  The residual window
> is a crash between the error and the next persistence point.
> 
> The persistence paths never write a hibernated volume: resuming Windows
> from a modified image corrupts it.  Record the mount-time hibernation
> verdict in the new NV_Hibernated volume flag and make
> ntfs_sync_volume_dirty_state() a no-op while it is set, so the dirty
> bit is left exactly as it is on disk and only the in-memory error
> state is kept.  Without this, an rw mount of a hibernated volume with
> the default errors=continue would gain a filesystem-internal write on
> the first sync, remount or unmount.  Other writes to such a mount,
> like the mount-time logfile emptying, are pre-existing and unchanged.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/ntfs.h   |   1 -
>   fs/ntfs/super.c  | 129 ++++++++++++++++++++++++++++++++---------------
>   fs/ntfs/volume.h |   4 ++
>   3 files changed, 93 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
> index 45f77848a9cf..a5cd5493c501 100644
> --- a/fs/ntfs/ntfs.h
> +++ b/fs/ntfs/ntfs.h
> @@ -219,7 +219,6 @@ struct option_t {
>   };
>   extern const struct option_t on_errors_arr[];
>   int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags);
> -int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags);
>   int ntfs_write_volume_label(struct ntfs_volume *vol, char *label);
>   
>   /* From fs/ntfs/mst.c */
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 6ba19986a598..733565953302 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -262,6 +262,8 @@ static int ntfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   	return 0;
>   }
>   
> +static int ntfs_sync_volume_dirty_state(struct ntfs_volume *vol);
> +
>   static int ntfs_reconfigure(struct fs_context *fc)
>   {
>   	struct super_block *sb = fc->root->d_sb;
> @@ -312,10 +314,24 @@ static int ntfs_reconfigure(struct fs_context *fc)
>   		}
>   	} else if (!sb_rdonly(sb) && (fc->sb_flags & SB_RDONLY)) {
>   		/* Remounting read-only. */
> -		if (!NVolErrors(vol)) {
> -			if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))
> -				ntfs_warning(sb,
> -					"Failed to clear dirty bit in volume information flags.  Run chkdsk.");
> +		/*
> +		 * With errors recorded the dirty bit is set rather than
> +		 * cleared, and it is committed right away: the VFS does
> +		 * not sync the filesystem during a remount, and once the
> +		 * remount succeeds no further persistence point exists -
> +		 * ntfs_sync_fs() is only ever invoked for read-write
> +		 * superblocks (all its VFS callers skip read-only ones)
> +		 * and ntfs_put_super() skips them, so the only remaining
> +		 * write would be the evict-time commit at unmount, which
> +		 * a crash never reaches.  An error recorded only after
> +		 * the remount is still never persisted.
> +		 */
> +		if (ntfs_sync_volume_dirty_state(vol)) {
> +			ntfs_warning(sb,
> +				"Failed to update dirty bit in volume information flags.  Run chkdsk.");
> +		} else if (NInoDirty(NTFS_I(vol->vol_ino))) {
> +			ntfs_commit_inode(vol->vol_ino);
> +			blkdev_issue_flush(sb->s_bdev);

Hi Hongling,
    The comment says that the dirty state must be committed immediately 
during remount-to-read-only because no later ntfs_sync_fs() persistence 
point is available. However, this code does not verify that this 
immediate persistence actually succeeds.

   ntfs_commit_inode() is a void wrapper, so failures while writing the 
$Volume record or updating $MFTMirr can only be observed indirectly 
through NVolErrors(), but that state is not checked after the commit. In 
addition, the return value of blkdev_issue_flush() is ignored.

   As a result, remount can complete successfully even though 
VOLUME_IS_DIRTY was not durably written to stable storage. A crash after 
the remount may then leave the volume clean on disk, despite the 
comment’s stated requirement that the dirty state be committed 
immediately. Please detect and handle errors from the complete $Volume 
commit and block-device flush sequence before treating the dirty-state 
update as successful.

Thanks,
Baolin.

>   		}
>   	}
>   
> @@ -357,9 +373,10 @@ void ntfs_handle_error(struct super_block *sb)
>    * @vol:	ntfs volume on which to modify the flags
>    * @set_bits:	bits to set in the volume information flags
>    * @clear_bits:	bits to clear in the volume information flags
> + * @dirty_if_errors:	force VOLUME_IS_DIRTY on when NVolErrors() is set
>    *
>    * Internal function.  You probably want to use ntfs_{set,clear}_volume_flags()
> - * instead (see below).
> + * or ntfs_sync_volume_dirty_state() instead (see below).
>    *
>    * Combine @set_bits and @clear_bits with the current in-memory flag state and
>    * write the result back.  The set/clear helpers pass only the bits to modify,
> @@ -368,11 +385,18 @@ void ntfs_handle_error(struct super_block *sb)
>    * All bit manipulation is done on CPU-endian values, and the result is
>    * converted back to little-endian before storing it.
>    *
> + * When @dirty_if_errors is true and errors have been recorded on @vol,
> + * VOLUME_IS_DIRTY is forced on after the requested changes.  NVolErrors() is
> + * evaluated under the same mrec_lock, which orders this against other
> + * locked flag updates; the runtime error paths themselves record the flag
> + * lock-free, so see ntfs_sync_volume_dirty_state() for the guarantee this
> + * provides against them.
> + *
>    * Return 0 on success and -errno on error.
>    */
>   static int ntfs_write_volume_flags(struct ntfs_volume *vol,
>   		const __le16 set_bits, const __le16 clear_bits,
> -		const bool skip_if_errors)
> +		const bool dirty_if_errors)
>   {
>   	struct ntfs_inode *ni = NTFS_I(vol->vol_ino);
>   	struct volume_information *vi;
> @@ -382,12 +406,11 @@ static int ntfs_write_volume_flags(struct ntfs_volume *vol,
>   
>   	mutex_lock(&ni->mrec_lock);
>   
> -	if (skip_if_errors && NVolErrors(vol))
> -		goto done;
> -
>   	flags = le16_to_cpu(vol->vol_flags);
>   	flags |= le16_to_cpu(set_bits) & le16_to_cpu(VOLUME_FLAGS_MASK);
>   	flags &= ~(le16_to_cpu(clear_bits) & le16_to_cpu(VOLUME_FLAGS_MASK));
> +	if (dirty_if_errors && NVolErrors(vol))
> +		flags |= le16_to_cpu(VOLUME_IS_DIRTY);
>   	ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
>   			le16_to_cpu(vol->vol_flags), flags);
>   
> @@ -439,31 +462,43 @@ int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
>   }
>   
>   /*
> - * ntfs_clear_volume_flags - clear bits in the volume information flags
> - * @vol:	ntfs volume on which to modify the flags
> - * @flags:	flags to clear on the volume
> + * ntfs_sync_volume_dirty_state - persist the dirty bit per the error state
> + * @vol:	ntfs volume whose dirty bit to persist
>    *
> - * Clear the bits in @flags in the volume information flags on the volume @vol.
> - * The bits are combined with the current flag state under the lock in
> - * ntfs_write_volume_flags(), so concurrent updates are not lost.
> + * Set VOLUME_IS_DIRTY if errors have been recorded on @vol and clear it
> + * otherwise, under the $Volume mrec_lock.
>    *
> - * Return 0 on success and -errno on error.
> - */
> -int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
> -{
> -	return ntfs_write_volume_flags(vol, 0, flags, false);
> -}
> -
> -/*
> - * ntfs_clear_volume_dirty_if_no_errors - clear dirty bit if no errors exist
> - * @vol:	ntfs volume whose dirty bit should be cleared
> + * The guarantee this provides is eventual, not instantaneous: the runtime
> + * error paths record NVolErrors() with a lock-free set_bit(), so a
> + * persistence point that evaluates the flag just before an error is
> + * recorded can still leave the on-disk bit clean.  This is sound because
> + * NVolErrors() is sticky (nothing clears it for the lifetime of the mount)
> + * and every persistence point re-derives the on-disk bit from it; the
> + * last one, ntfs_put_super(), runs after evict_inodes() on a quiesced
> + * filesystem, so a volume that is read-write at unmount time cannot
> + * unmount clean.  A volume that is already read-only when the error is
> + * recorded (errors=remount-ro flips the superblock on the first error,
> + * as does an earlier remount-ro) has no persistence point left and
> + * keeps whatever on-disk bit it had; that behaviour is unchanged.  The
> + * residual window is a crash between the error and the next
> + * persistence point.
> + *
> + * This is the single point that persists the in-memory error state to disk.
> + * The runtime error paths only record NVolErrors() because they run under a
> + * variety of ntfs locks the dirty-bit write cannot be taken under (runlist
> + * locks, vol->lcnbmp_lock, vol->mftbmp_lock, mrec_locks); the first
> + * ntfs_sync_fs(), a remount, or the unmount then persists the flag here.
> + *
> + * A hibernated volume is not written from these persistence paths:
> + * resuming Windows from a modified image corrupts it, so the dirty bit
> + * is left as it is on disk and only the in-memory error state is kept.
>    *
> - * Check NVolErrors() and clear VOLUME_IS_DIRTY under the same mrec_lock so
> - * ntfs_sync_fs() cannot clear the dirty bit after a concurrent error has been
> - * recorded.
> + * Return 0 on success and -errno on error.
>    */
> -static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume *vol)
> +static int ntfs_sync_volume_dirty_state(struct ntfs_volume *vol)
>   {
> +	if (NVolHibernated(vol))
> +		return 0;
>   	return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
>   }
>   
> @@ -1615,6 +1650,11 @@ static bool load_system_files(struct ntfs_volume *vol)
>   			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
>   		}
>   		NVolSetErrors(vol);
> +		/*
> +		 * Remember it for the lifetime of the mount: see
> +		 * ntfs_sync_volume_dirty_state().
> +		 */
> +		NVolSetHibernated(vol);
>   	}
>   
>   	/* If (still) a read-write mount, empty the logfile. */
> @@ -1772,22 +1812,31 @@ static void ntfs_put_super(struct super_block *sb)
>   	ntfs_commit_inode(vol->mft_ino);
>   
>   	/*
> -	 * If a read-write mount and no volume errors have occurred, mark the
> -	 * volume clean.  Also, re-commit all affected inodes.
> +	 * If a read-write mount, persist the error state in the volume flags:
> +	 * mark the volume clean if no volume errors have occurred, and make
> +	 * sure VOLUME_IS_DIRTY is on disk if any have, so chkdsk runs on the
> +	 * next mount.  Also, re-commit all affected inodes.
>   	 */
>   	if (!sb_rdonly(sb)) {
> +		if (ntfs_sync_volume_dirty_state(vol)) {
> +			ntfs_warning(sb,
> +				"Failed to sync dirty bit in volume information flags.  Run chkdsk.");
> +		} else if (NVolErrors(vol)) {
> +			/*
> +			 * The dirty bit is on disk now; only warn when the
> +			 * sync actually succeeded, or this message would
> +			 * contradict the one above.
> +			 */
> +			ntfs_warning(sb,
> +				"Volume has errors.  Leaving volume marked dirty.  Run chkdsk.");
> +		}
> +		/* Commits the updated volume flags if they were written. */
> +		ntfs_commit_inode(vol->vol_ino);
>   		if (!NVolErrors(vol)) {
> -			if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))
> -				ntfs_warning(sb,
> -					"Failed to clear dirty bit in volume information flags.  Run chkdsk.");
> -			ntfs_commit_inode(vol->vol_ino);
>   			ntfs_commit_inode(vol->root_ino);
>   			if (vol->mftmirr_ino)
>   				ntfs_commit_inode(vol->mftmirr_ino);
>   			ntfs_commit_inode(vol->mft_ino);
> -		} else {
> -			ntfs_warning(sb,
> -				"Volume has errors.  Leaving volume marked dirty.  Run chkdsk.");
>   		}
>   	}
>   
> @@ -1886,8 +1935,8 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
>   		return 0;
>   
>   	/* If there are some dirty buffers in the bdev inode */
> -	if (ntfs_clear_volume_dirty_if_no_errors(vol)) {
> -		ntfs_warning(sb, "Failed to clear dirty bit in volume information flags.  Run chkdsk.");
> +	if (ntfs_sync_volume_dirty_state(vol)) {
> +		ntfs_warning(sb, "Failed to sync dirty bit in volume information flags.  Run chkdsk.");
>   		err = -EIO;
>   	}
>   	sync_inodes_sb(sb);
> diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
> index bc85a9592245..c7cd27b6dc1a 100644
> --- a/fs/ntfs/volume.h
> +++ b/fs/ntfs/volume.h
> @@ -181,6 +181,8 @@ struct ntfs_volume {
>    *				Windows-reserved names (CON, AUX, NUL, COM1,
>    *				LPT1, etc.) or invalid characters.
>    *
> + * NV_Hibernated		Windows is hibernated on the volume; the sync
> + *				paths must not write the volume flags.
>    * NV_Discard			Issue discard/TRIM commands for freed clusters.
>    * NV_DisableSparse		Disable creation of sparse regions.
>    * NV_NativeSymlinkRel		Translate absolute Windows reparse targets (native_symlink=rel).
> @@ -199,6 +201,7 @@ enum {
>   	NV_ShowHiddenFiles,
>   	NV_HideDotFiles,
>   	NV_CheckWindowsNames,
> +	NV_Hibernated,
>   	NV_Discard,
>   	NV_DisableSparse,
>   	NV_NativeSymlinkRel,
> @@ -237,6 +240,7 @@ DEFINE_NVOL_BIT_OPS(SysImmutable)
>   DEFINE_NVOL_BIT_OPS(ShowHiddenFiles)
>   DEFINE_NVOL_BIT_OPS(HideDotFiles)
>   DEFINE_NVOL_BIT_OPS(CheckWindowsNames)
> +DEFINE_NVOL_BIT_OPS(Hibernated)
>   DEFINE_NVOL_BIT_OPS(Discard)
>   DEFINE_NVOL_BIT_OPS(DisableSparse)
>   DEFINE_NVOL_BIT_OPS(NativeSymlinkRel)

