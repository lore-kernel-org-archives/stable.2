Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6384EBAE8;
	Tue,  8 Sep 2026 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859444; cv=none; b=nC3cQ1Swa9EbgT9cPtwE27mbQQBnlVStWNmQY0l00XZkBFa2w5cwOtxcekjJozGvjgrLXvyC8GM6cn2+BAvrbrY1KvqBLnVJlNDHGPXRftXR5dmtBfnLmdH74ZYe32LNXdJeDfKAgMfKt39+3AQX7IZWCFMfBlvZu2vQY+V5peU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859444; c=relaxed/simple;
	bh=/S7cHlwwlQM5WHEKjtSdmzrRyb3xo6qy5EiMvU46KQY=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=fTyjtm1UbnsiRIWeX6Cw+vixoVC/see24LMvf6BrRsRurLqWoFWXNkL16+e2ArrMCUZPmVx2blr4E0JaZ8hHVYoKPGPKfoF2+178beyzR2lgYpe+3yiVJ2z2CD19PzUYhZpwFVVAUrZ3PrctAtIQaoKP4PjUswv0VsUiA18oOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=iiD2BRac; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="iiD2BRac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=TX2zMbG+jrYeGRaPgg9CX73U6f7Qxz+V0Grnf5QlXK0=;
	b=iiD2BRactZkconNd+ip3Wzh41fj7+Mds/uxoB7xrFXXendBxf8G8THjjD0CS1/
	p/cEFnYNf+JI49XKV0yDw/aBSzWDSh0E0qIh6KmcQ8ev0HmyhLSemYZ/se8JkPbE
	wDZ7HN0HLkihZ4moOWfurU67RhI7aGg3m/Wzqnm/9zq70=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3pzMS1J9qLCDCAg--.27799S2;
	Tue, 08 Sep 2026 17:23:30 +0800 (CST)
Message-ID: <6A9FD3F3.7060805@126.com>
Date: Tue, 08 Sep 2026 17:22:59 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: liubaolin <liubaolin12138@163.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>,
 linkinjeon@kernel.org, hyc.lee@gmail.com
CC: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] ntfs: sync the volume dirty bit with the recorded
 error state
References: <20260907070852.291323-1-zenghongling@kylinos.cn> <20260907070852.291323-3-zenghongling@kylinos.cn> <9c1e89d4-f242-4d20-996a-bcc2631e01b7@163.com>
In-Reply-To: <9c1e89d4-f242-4d20-996a-bcc2631e01b7@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3pzMS1J9qLCDCAg--.27799S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3KF4fXF4rZrW7JrW5XFW3Awb_yoW8XF18uo
	WFkF10vws7twnrAa90y3s3C3yfua909F4xXF45Gr1DZ34qgw4UC347Wws8WFZrCa1Ykr1U
	Ca4xJr4qqFWktFyfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsvPfUUUUU
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrxK7jGqf1BIPzgAA34


在 2026年09月08日 13:23, liubaolin 写道:
>
>
> 在 2026/9/7 15:08, Hongling Zeng 写道:
>> The runtime metadata-corruption paths in fs/ntfs only record the
>> in-memory NVolErrors() flag; whether VOLUME_IS_DIRTY ever reaches disk
>> depends on ntfs_set_volume_flags() being called by some other path,
>> which for most error sites never happens.  A volume can therefore
>> unmount with a clean on-disk flag despite recorded corruption, and
>> chkdsk will not run on the next mount.
>>
>> Persisting the dirty bit from the error paths themselves does not work:
>> they run under a wide variety of ntfs locks, and the dirty-bit write
>> takes the $Volume mrec_lock and maps the $Volume mft record, which on
>> an $MFT page-cache miss takes the $MFT runlist lock for writing.  That
>> is enough to self-deadlock or form ABBA cycles from several of them:
>> the $MFT extend undo paths hold the $MFT runlist lock and then take
>> vol->lcnbmp_lock inside ntfs_cluster_free(); the cluster allocation and
>> free rollback paths hold vol->lcnbmp_lock; and the whole mft record
>> allocation tree is reachable from ntfs_write_volume_label()'s
>> attribute-list maintenance while it holds the $Volume mrec_lock itself.
>>
>> Instead, make the persistence a property of the sync paths, which run
>> without ntfs locks held.  The new ntfs_sync_volume_dirty_state() sets
>> VOLUME_IS_DIRTY when NVolErrors() is recorded and clears it otherwise,
>> evaluating the error flag under the $Volume mrec_lock.  It is called
>> from ntfs_sync_fs(), from the remount-to-read-only path of
>> ntfs_reconfigure(), and from ntfs_put_super(), which previously
>> evaluated NVolErrors() outside the lock before clearing the dirty bit
>> unconditionally, and which now also persists the dirty bit for volumes
>> with recorded errors so they unmount with chkdsk scheduled.
>>
>> The guarantee this provides is eventual, not instantaneous: the error
>> paths record NVolErrors() with a lock-free set_bit(), so a persistence
>> point that evaluates the flag just before an error is recorded can
>> still leave the on-disk bit clean until the next one.  This is sound
>> because NVolErrors() is sticky for the lifetime of the mount and every
>> persistence point re-derives the on-disk bit from it; the last one,
>> ntfs_put_super(), runs after evict_inodes() on a quiesced filesystem,
>> so a volume that is read-write at unmount time cannot unmount clean.
>> A volume that is already read-only when the error is recorded
>> (errors=remount-ro flips the superblock on the first error, as does an
>> earlier remount-ro) has no persistence point left and keeps whatever
>> on-disk bit it had; that behaviour is unchanged.  The residual window
>> is a crash between the error and the next persistence point.
>>
>> The persistence paths never write a hibernated volume: resuming Windows
>> from a modified image corrupts it.  Record the mount-time hibernation
>> verdict in the new NV_Hibernated volume flag and make
>> ntfs_sync_volume_dirty_state() a no-op while it is set, so the dirty
>> bit is left exactly as it is on disk and only the in-memory error
>> state is kept.  Without this, an rw mount of a hibernated volume with
>> the default errors=continue would gain a filesystem-internal write on
>> the first sync, remount or unmount.  Other writes to such a mount,
>> like the mount-time logfile emptying, are pre-existing and unchanged.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> ---
>>   fs/ntfs/super.c  | 113 ++++++++++++++++++++++++++++++++++++-----------
>>   fs/ntfs/volume.h |   4 ++
>>   2 files changed, 90 insertions(+), 27 deletions(-)
>>
>> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
>> index ce159ae8169a..4b4af1ea8b09 100644
>> --- a/fs/ntfs/super.c
>> +++ b/fs/ntfs/super.c
>> @@ -262,6 +262,8 @@ static int ntfs_parse_param(struct fs_context 
>> *fc, struct fs_parameter *param)
>>       return 0;
>>   }
>>   +static int ntfs_sync_volume_dirty_state(struct ntfs_volume *vol);
>> +
>>   static int ntfs_reconfigure(struct fs_context *fc)
>>   {
>>       struct super_block *sb = fc->root->d_sb;
>> @@ -312,11 +314,19 @@ static int ntfs_reconfigure(struct fs_context *fc)
>>           }
>>       } else if (!sb_rdonly(sb) && (fc->sb_flags & SB_RDONLY)) {
>>           /* Remounting read-only. */
>> -        if (!NVolErrors(vol)) {
>> -            if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))
>> -                ntfs_warning(sb,
>> -                    "Failed to clear dirty bit in volume information 
>> flags.  Run chkdsk.");
>> -        }
>> +        /*
>> +         * With errors recorded the dirty bit is set rather than
>> +         * cleared, so it survives until the unmount.  Note that
>> +         * once this remount succeeds no further persistence point
>> +         * exists: ntfs_sync_fs() is only ever invoked for
>> +         * read-write superblocks (all its VFS callers skip
>> +         * read-only ones) and ntfs_put_super() skips them, so an
>> +         * error recorded only after the remount is never
>> +         * persisted.
>> +         */
>> +        if (ntfs_sync_volume_dirty_state(vol))
>> +            ntfs_warning(sb,
>> +                "Failed to update dirty bit in volume information 
>> flags.  Run chkdsk.");
>>       }
>>         ntfs_debug("Done.");
>> @@ -357,9 +367,10 @@ void ntfs_handle_error(struct super_block *sb)
>>    * @vol:    ntfs volume on which to modify the flags
>>    * @set_bits:    bits to set in the volume information flags
>>    * @clear_bits:    bits to clear in the volume information flags
>> + * @dirty_if_errors:    force VOLUME_IS_DIRTY on when NVolErrors() 
>> is set
>>    *
>>    * Internal function.  You probably want to use 
>> ntfs_{set,clear}_volume_flags()
>> - * instead (see below).
>> + * or ntfs_sync_volume_dirty_state() instead (see below).
>>    *
>>    * Combine @set_bits and @clear_bits with the current in-memory 
>> flag state and
>>    * write the result back.  The set/clear helpers pass only the bits 
>> to modify,
>> @@ -368,11 +379,18 @@ void ntfs_handle_error(struct super_block *sb)
>>    * All bit manipulation is done on CPU-endian values, and the 
>> result is
>>    * converted back to little-endian before storing it.
>>    *
>> + * When @dirty_if_errors is true and errors have been recorded on @vol,
>> + * VOLUME_IS_DIRTY is forced on after the requested changes. 
>> NVolErrors() is
>> + * evaluated under the same mrec_lock, which orders this against other
>> + * locked flag updates; the runtime error paths themselves record 
>> the flag
>> + * lock-free, so see ntfs_sync_volume_dirty_state() for the 
>> guarantee this
>> + * provides against them.
>> + *
>>    * Return 0 on success and -errno on error.
>>    */
>>   static int ntfs_write_volume_flags(struct ntfs_volume *vol,
>>           const __le16 set_bits, const __le16 clear_bits,
>> -        const bool skip_if_errors)
>> +        const bool dirty_if_errors)
>>   {
>>       struct ntfs_inode *ni = NTFS_I(vol->vol_ino);
>>       struct volume_information *vi;
>> @@ -382,12 +400,11 @@ static int ntfs_write_volume_flags(struct 
>> ntfs_volume *vol,
>>         mutex_lock(&ni->mrec_lock);
>>   -    if (skip_if_errors && NVolErrors(vol))
>> -        goto done;
>> -
>>       flags = le16_to_cpu(vol->vol_flags);
>>       flags |= le16_to_cpu(set_bits) & le16_to_cpu(VOLUME_FLAGS_MASK);
>>       flags &= ~(le16_to_cpu(clear_bits) & 
>> le16_to_cpu(VOLUME_FLAGS_MASK));
>> +    if (dirty_if_errors && NVolErrors(vol))
>> +        flags |= le16_to_cpu(VOLUME_IS_DIRTY);
>>       ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
>>               le16_to_cpu(vol->vol_flags), flags);
>>   @@ -455,15 +472,43 @@ int ntfs_clear_volume_flags(struct 
>> ntfs_volume *vol, __le16 flags)
>>   }
>>     /*
>> - * ntfs_clear_volume_dirty_if_no_errors - clear dirty bit if no 
>> errors exist
>> - * @vol:    ntfs volume whose dirty bit should be cleared
>> + * ntfs_sync_volume_dirty_state - persist the dirty bit per the 
>> error state
>> + * @vol:    ntfs volume whose dirty bit to persist
>> + *
>> + * Set VOLUME_IS_DIRTY if errors have been recorded on @vol and 
>> clear it
>> + * otherwise, under the $Volume mrec_lock.
>> + *
>> + * The guarantee this provides is eventual, not instantaneous: the 
>> runtime
>> + * error paths record NVolErrors() with a lock-free set_bit(), so a
>> + * persistence point that evaluates the flag just before an error is
>> + * recorded can still leave the on-disk bit clean.  This is sound 
>> because
>> + * NVolErrors() is sticky (nothing clears it for the lifetime of the 
>> mount)
>> + * and every persistence point re-derives the on-disk bit from it; the
>> + * last one, ntfs_put_super(), runs after evict_inodes() on a quiesced
>> + * filesystem, so a volume that is read-write at unmount time cannot
>> + * unmount clean.  A volume that is already read-only when the error is
>> + * recorded (errors=remount-ro flips the superblock on the first error,
>> + * as does an earlier remount-ro) has no persistence point left and
>> + * keeps whatever on-disk bit it had; that behaviour is unchanged.  The
>> + * residual window is a crash between the error and the next
>> + * persistence point.
>> + *
>> + * This is the single point that persists the in-memory error state 
>> to disk.
>> + * The runtime error paths only record NVolErrors() because they run 
>> under a
>> + * variety of ntfs locks the dirty-bit write cannot be taken under 
>> (runlist
>> + * locks, vol->lcnbmp_lock, vol->mftbmp_lock, mrec_locks); the first
>> + * ntfs_sync_fs(), a remount, or the unmount then persists the flag 
>> here.
>>    *
>> - * Check NVolErrors() and clear VOLUME_IS_DIRTY under the same 
>> mrec_lock so
>> - * ntfs_sync_fs() cannot clear the dirty bit after a concurrent 
>> error has been
>> - * recorded.
>> + * A hibernated volume is not written from these persistence paths:
>> + * resuming Windows from a modified image corrupts it, so the dirty bit
>> + * is left as it is on disk and only the in-memory error state is kept.
>> + *
>> + * Return 0 on success and -errno on error.
>>    */
>> -static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume 
>> *vol)
>> +static int ntfs_sync_volume_dirty_state(struct ntfs_volume *vol)
>>   {
>> +    if (NVolHibernated(vol))
>> +        return 0;
>>       return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
>>   }
>>   @@ -1621,6 +1666,11 @@ static bool load_system_files(struct 
>> ntfs_volume *vol)
>>               ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
>>           }
>>           NVolSetErrors(vol);
>> +        /*
>> +         * Remember it for the lifetime of the mount: see
>> +         * ntfs_sync_volume_dirty_state().
>> +         */
>> +        NVolSetHibernated(vol);
> Hi Hongling,
>    check_windows_hibernation_status() returns a positive value when 
> hibernation is detected, but a negative value when the check itself 
> fails. This sets NV_Hibernated in both cases, so dirty-bit updates are 
> also skipped after a detection error.
>
> Thanks,
> Baolin.
>
   Thanks, Deliberate: the flag is a write gate, not a detection claim. 
A failed  check means we cannot prove the volume is not held by a hibernated
   Windows, and gating wrongly costs only an untouched dirty bit, while  
writing wrongly costs Windows resuming on a modified image.
>>       }
>>         /* If (still) a read-write mount, empty the logfile. */
>> @@ -1776,22 +1826,31 @@ static void ntfs_put_super(struct super_block 
>> *sb)
>>       ntfs_commit_inode(vol->mft_ino);
>>         /*
>> -     * If a read-write mount and no volume errors have occurred, 
>> mark the
>> -     * volume clean.  Also, re-commit all affected inodes.
>> +     * If a read-write mount, persist the error state in the volume 
>> flags:
>> +     * mark the volume clean if no volume errors have occurred, and 
>> make
>> +     * sure VOLUME_IS_DIRTY is on disk if any have, so chkdsk runs 
>> on the
>> +     * next mount.  Also, re-commit all affected inodes.
>>        */
>>       if (!sb_rdonly(sb)) {
>> +        if (ntfs_sync_volume_dirty_state(vol)) {
>> +            ntfs_warning(sb,
>> +                "Failed to sync dirty bit in volume information 
>> flags.  Run chkdsk.");
> Hi Hongling,
>    This looks a little too early. There are more ntfs_commit_inode() 
> calls,and a write_inode_now(), later in ntfs_put_super(). 
> __ntfs_write_inode() sets NVolErrors() on failure, so an error 
> recorded after this point would not be reflected in the on-disk dirty 
> bit.
>
>   Could the dirty state be synchronized after the remaining commits, 
> while vol->vol_ino is still available?
>
> Thanks,
> Baolin.
   Yes - I'll move the sync and the vol_ino commit after the last 
write_inode_now(), with the vol_ino iput moved to the end of
   ntfs_put_super(), and post the incremental for 2/3, and I'll post it 
once  there is agreement on this approach.

   Thanks,
   Hongling

>
>> +        } else if (NVolErrors(vol)) {
>> +            /*
>> +             * The dirty bit is on disk now; only warn when the
>> +             * sync actually succeeded, or this message would
>> +             * contradict the one above.
>> +             */
>> +            ntfs_warning(sb,
>> +                "Volume has errors.  Leaving volume marked dirty.  
>> Run chkdsk.");
>> +        }
>> +        /* Commits the updated volume flags if they were written. */
>> +        ntfs_commit_inode(vol->vol_ino);
>>           if (!NVolErrors(vol)) {
>> -            if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))
>> -                ntfs_warning(sb,
>> -                    "Failed to clear dirty bit in volume information 
>> flags.  Run chkdsk.");
>> -            ntfs_commit_inode(vol->vol_ino);
>>               ntfs_commit_inode(vol->root_ino);
>>               if (vol->mftmirr_ino)
>>                   ntfs_commit_inode(vol->mftmirr_ino);
>>               ntfs_commit_inode(vol->mft_ino);
>> -        } else {
>> -            ntfs_warning(sb,
>> -                "Volume has errors.  Leaving volume marked dirty.  
>> Run chkdsk.");
>>           }
>>       }
>>   @@ -1890,8 +1949,8 @@ static int ntfs_sync_fs(struct super_block 
>> *sb, int wait)
>>           return 0;
>>         /* If there are some dirty buffers in the bdev inode */
>> -    if (ntfs_clear_volume_dirty_if_no_errors(vol)) {
>> -        ntfs_warning(sb, "Failed to clear dirty bit in volume 
>> information flags.  Run chkdsk.");
>> +    if (ntfs_sync_volume_dirty_state(vol)) {
>> +        ntfs_warning(sb, "Failed to sync dirty bit in volume 
>> information flags.  Run chkdsk.");
>>           err = -EIO;
>>       }
>>       sync_inodes_sb(sb);
>> diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
>> index 65fd3908af26..b946263153db 100644
>> --- a/fs/ntfs/volume.h
>> +++ b/fs/ntfs/volume.h
>> @@ -175,6 +175,8 @@ struct ntfs_volume {
>>    *                Windows-reserved names (CON, AUX, NUL, COM1,
>>    *                LPT1, etc.) or invalid characters.
>>    *
>> + * NV_Hibernated        Windows is hibernated on the volume; the sync
>> + *                paths must not write the volume flags.
>>    * NV_Discard            Issue discard/TRIM commands for freed 
>> clusters.
>>    * NV_DisableSparse        Disable creation of sparse regions.
>>    * NV_NativeSymlinkRel        Translate absolute Windows reparse 
>> targets (native_symlink=rel).
>> @@ -193,6 +195,7 @@ enum {
>>       NV_ShowHiddenFiles,
>>       NV_HideDotFiles,
>>       NV_CheckWindowsNames,
>> +    NV_Hibernated,
>>       NV_Discard,
>>       NV_DisableSparse,
>>       NV_NativeSymlinkRel,
>> @@ -231,6 +234,7 @@ DEFINE_NVOL_BIT_OPS(SysImmutable)
>>   DEFINE_NVOL_BIT_OPS(ShowHiddenFiles)
>>   DEFINE_NVOL_BIT_OPS(HideDotFiles)
>>   DEFINE_NVOL_BIT_OPS(CheckWindowsNames)
>> +DEFINE_NVOL_BIT_OPS(Hibernated)
>>   DEFINE_NVOL_BIT_OPS(Discard)
>>   DEFINE_NVOL_BIT_OPS(DisableSparse)
>>   DEFINE_NVOL_BIT_OPS(NativeSymlinkRel)

