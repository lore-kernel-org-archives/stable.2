Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056F35CB7C;
	Wed, 16 Sep 2026 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593573; cv=none; b=uYmbDFIYpzxT51QrNuqv9FO3uk8LpUh5uouRJWkANIEmK3EpCuJ8Xuix5dJWPmm+rsJv4XXdsU6sPw3sNo1wazNhvj048zSWL0gnSbhNs8K4FUj44N31Hvl0i62WbuaTzgHb/9r9yYJdVJgZE0R6b9ThNJ1z6WxuW+daSILNPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593573; c=relaxed/simple;
	bh=Jk4CsUnQWoCu3XtIjYMhAS8yDmBIce9gLNs1PdlrZ0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INxec6Er3ZTT/zu6ZPEpPky08OyAwBQ8aIgMHJhqScvmG/6lpouw8oxrugZ19uRxKfODvTdRR6VxRdo56L5+imM1Ndpx5MqjsJ4P9CPfE+s7wQjuxqwIlrpXQ0UiSx8Ars+yZM3+qbEbmQqGHy6Mg4XHGV+MNy4+6MPIRWU8bRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M3+j/OBh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M3+j/OBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=5l3OCgQkeB0cimXTGirBDTKoamgnQMpMl+ONfKkxh2E=;
	b=M3+j/OBh4xSATHdeAtHTsyfFZOdH8Bj7Bikzb+xNjapgVYKeSxrlgu14nPKnta
	63j9IPkvrEfa/DDmguQUYo7v/1fckop+hq0od4xleN8mAnx80PZlhXx97zZiDrhO
	cvxOtlzCr2g07lz/FKxU26XQT6THZmCqoXK5w/Th6zxFQ=
Received: from [IPV6:2409:8900:21a7:a33a:b45d:31d1:c098:7d46] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXuxSfB6tqm9N0BA--.14008S2;
	Thu, 17 Sep 2026 05:18:24 +0800 (CST)
Message-ID: <4a59bafe-601e-4bf0-878e-9ae400db07c5@163.com>
Date: Thu, 17 Sep 2026 05:18:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/7] ntfs: check the dirty-state commit on remount and
 unmount
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Baolin Liu <liubaolin@kylinos.cn>,
 stable@vger.kernel.org
References: <20260915083252.812126-1-zenghongling@kylinos.cn>
 <20260915083252.812126-7-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260915083252.812126-7-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXuxSfB6tqm9N0BA--.14008S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw4DurW7Kr45Ar17XF4ktFb_yoW7Kry7pF
	9xArn3GayDtr12kwsIvFW2gFWfW3s3Cay7Xr17Gr1xXws5Kr17K348tw1Fga40yr95Jw1x
	XF4kKw1YgF98uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxxhLUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwgBvOmqrB6DG7AAA3b



在 2026/9/15 16:32, Hongling Zeng 写道:
> The remount-to-read-only path commits the updated volume flags with
> ntfs_commit_inode(), a void wrapper around __ntfs_write_inode(), and
> ignores the blkdev_issue_flush() return value, so a failed commit or
> flush is reported as success.  Once the remount has succeeded no
> persistence point is ever reached again: ntfs_put_super() skips
> read-only superblocks and the VFS never syncs one, so fail the
> remount unless the commit and the flush succeed.  The superblock
> then stays read-write and ntfs_put_super() retries the persistence
> at unmount.  The errors=remount-ro downgrade does not go through
> ntfs_reconfigure() and is unchanged.
> 
> A zero-return commit is not trusted blindly: write_mft_record()
> redirties the record on allocation failure and reports success, so
> the $Volume inode is required to be clean afterwards.
> 
> ntfs_put_super() discards the same commit error.  Call
> __ntfs_write_inode() there with the same dirty re-check and warn on
> failure, as put_super() cannot return an error.  The commit is
> skipped when the dirty-state sync itself failed, as that could write
> back an inconsistent flag state; a record left dirty by an earlier
> update is still committed at evict time.
> 
> NVolErrors() is deliberately not used to detect the failure: it is
> sticky for the lifetime of the mount, so it cannot distinguish a
> fresh commit failure from errors recorded before the remount.
> 
> Hibernated volumes: ntfs_sync_volume_dirty_state() is a no-op for
> them and never dirties the $Volume inode on such a mount, since the
> on-disk flags are already dirty and ntfs_set_volume_flags() has
> nothing to change.  The commit only runs if something dirtied the
> inode independently, as before this patch; mounting hibernated
> volumes read-only removes even that.
> 
> Reported-by: Baolin Liu <liubaolin@kylinos.cn>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/super.c | 76 +++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 54 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 463050ae1b0e..0228d7429596 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -268,6 +268,7 @@ static int ntfs_reconfigure(struct fs_context *fc)
>   {
>   	struct super_block *sb = fc->root->d_sb;
>   	struct ntfs_volume *vol = NTFS_SB(sb);
> +	int err;
>   
>   	ntfs_debug("Entering with remount");
>   
> @@ -324,14 +325,39 @@ static int ntfs_reconfigure(struct fs_context *fc)
>   		 * and ntfs_put_super() skips them, so the only remaining
>   		 * write would be the evict-time commit at unmount, which
>   		 * a crash never reaches.  An error recorded only after
> -		 * the remount is still never persisted.
> +		 * the remount is still never persisted; a failed commit
> +		 * or flush fails the remount, leaving the superblock
> +		 * read-write so ntfs_put_super() retries at unmount.
>   		 */
> -		if (ntfs_sync_volume_dirty_state(vol)) {
> +		err = ntfs_sync_volume_dirty_state(vol);
> +		if (err) {
>   			ntfs_warning(sb,
>   				"Failed to update dirty bit in volume information flags.  Run chkdsk.");
> -		} else if (NInoDirty(NTFS_I(vol->vol_ino))) {
> -			ntfs_commit_inode(vol->vol_ino);
> -			blkdev_issue_flush(sb->s_bdev);
> +			return err;
> +		}
> +		if (NInoDirty(NTFS_I(vol->vol_ino))) {
> +			/* ntfs_commit_inode() would discard the error. */
> +			err = __ntfs_write_inode(vol->vol_ino, 1);
> +			if (err) {
> +				ntfs_warning(sb,
> +					"Failed to commit volume information flags.  Run chkdsk.");
> +				return err;
> +			}
> +			/*
> +			 * write_mft_record() redirties the record on
> +			 * -ENOMEM and still reports success.
> +			 */
> +			if (NInoDirty(NTFS_I(vol->vol_ino))) {
> +				ntfs_warning(sb,
> +					"Volume information flags remain dirty after commit.  Run chkdsk.");
> +				return -EIO;
> +			}
> +			err = blkdev_issue_flush(sb->s_bdev);
> +			if (err) {
> +				ntfs_warning(sb,
> +					"Failed to flush volume information flags.  Run chkdsk.");
> +				return err;
> +			}
>   		}
>   	}
>   
> @@ -1876,26 +1902,32 @@ static void ntfs_put_super(struct super_block *sb)
>   		if (ntfs_sync_volume_dirty_state(vol)) {
>   			ntfs_warning(sb,
>   				"Failed to sync dirty bit in volume information flags.  Run chkdsk.");
> -		} else if (NVolErrors(vol)) {
> +		} else {
>   			/*
> -			 * The dirty bit is on disk now; only warn when the
> -			 * sync actually succeeded, or this message would
> -			 * contradict the one above.
> +			 * __ntfs_write_inode(), not the void
> +			 * ntfs_commit_inode() wrapper: the error can only
> +			 * be warned about here.  The mirror inode is only
> +			 * released below: writing the $Volume record (mft
> +			 * record number 3, below vol->mftmirr_size) mirrors
> +			 * it through ntfs_sync_mft_mirror(), which fails
> +			 * with -EIO once vol->mftmirr_ino is gone.
>   			 */
> -			ntfs_warning(sb,
> -				"Volume has errors.  Leaving volume marked dirty.  Run chkdsk.");
> +			if (__ntfs_write_inode(vol->vol_ino, 1)) {
> +				ntfs_warning(sb,
> +					"Failed to commit volume information flags.  Run chkdsk.");
> +			} else if (NInoDirty(NTFS_I(vol->vol_ino))) {
> +				ntfs_warning(sb,
> +					"Volume information flags remain dirty after commit.  Run chkdsk.");
> +			} else if (NVolErrors(vol)) {
> +				/*
> +				 * Only warn once the commit has succeeded,
> +				 * or this could contradict a failure
> +				 * reported above.
> +				 */
> +				ntfs_warning(sb,
> +					"Volume has errors.  Leaving volume marked dirty.  Run chkdsk.");
> +			}
>   		}
> -		/*
> -		 * Commits the updated volume flags if they were written.
> -		 * The mft mirror must still be around for this: the
> -		 * $Volume record (mft record number 3, below
> -		 * vol->mftmirr_size) is mirrored by write_mft_record()
> -		 * through ntfs_sync_mft_mirror(), which fails with -EIO
> -		 * and leaves the mirror stale once vol->mftmirr_ino is
> -		 * gone, so the mirror inode is only released after this
> -		 * commit.
> -		 */
> -		ntfs_commit_inode(vol->vol_ino);
>   	}
>   
>   	/*

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

