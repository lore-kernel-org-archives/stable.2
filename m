Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1B3B9D81;
	Wed, 16 Sep 2026 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593562; cv=none; b=kmenQiboPWTjl5jSgDBxiSXLBYI0kPCXQ3QmCE8u+glXxPr6xRZwSW3jDtx6PZsD/jF7gZNrKW2qzRif8mcU1sWcJdOTNi57AdX2+buCFD7XjAZnk8EEeK/JItgEA+8Sn4sCFfGYyuQwyo53vMGg3SSQlXxFoZZGL0j7WueWMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593562; c=relaxed/simple;
	bh=+EBw57/rFH0XWMl5nebXIouA0KdfKO1qFcRm561aBC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5IWQYbMKFjcpW9MYwF54s7CchXgGvJFzP8rnfdkvYuwjGfKjhDKrwTYzaE5CxtZAKYn9Y8u/sThZQOb6RHQVKvlnUJo4cNksRaLhnFfQpeEcSl8z4Se4tkyZ5g1VNlJ1OBXMayDtfwL6ViTiIFVq6hKYFrOGTpaqg4HTTJX46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UL2m8ysa; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UL2m8ysa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=3T3VyGT3/1mRXHqqrNTQqE6TeL6iYTnHree8fp3aLWI=;
	b=UL2m8ysaxd2o3t8HHpuJTWkEprXk/lETht9XT4k8ZKFzpr8xuRLVns6PmnKbQG
	i45zoO3QrTJz4G49XxidO6kGGlDLzWznhhC/f8kyPsM9uEk4gi+cs3QdiNLEzEsl
	xp9LayaF4Xtx4gi4VRVfI1lp2IUbg6PcaxgkS7E7Q1Azk=
Received: from [IPV6:2409:8900:21a7:a33a:b45d:31d1:c098:7d46] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAX_EmUB6tqF8zMPQ--.18673S2;
	Thu, 17 Sep 2026 05:18:13 +0800 (CST)
Message-ID: <2cc9b583-8966-454e-9e5e-48e992ca6070@163.com>
Date: Thu, 17 Sep 2026 05:18:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 5/7] ntfs: do not clear the volume dirty bit during
 sync
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Baolin Liu <liubaolin@kylinos.cn>,
 stable@vger.kernel.org
References: <20260915083252.812126-1-zenghongling@kylinos.cn>
 <20260915083252.812126-6-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260915083252.812126-6-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAX_EmUB6tqF8zMPQ--.18673S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyDKF1xWFWfKr4kCFykKrg_yoW7Wr13pr
	Zrtwn3CFWkJry7CwnI9w429F1S93s7Cay5Cry3Jw1aqrs5tr1UtF4rt3Wrua1vkryxXr1Y
	qrWjg3y3ua1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxxhLUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6RVsN2qrB5V+IAAA3q



在 2026/9/15 16:32, Hongling Zeng 写道:
> ntfs_sync_fs() clears VOLUME_IS_DIRTY while the volume is still mounted
> read-write, so a sync running concurrently with an in-flight metadata
> modification can clear and persist a bit that was just set: the
> modification then lands on a volume that is clean on disk, and a crash
> does not run chkdsk.
> 
> Stop clearing the bit in ntfs_sync_fs() and leave the clearing to the
> remount-to-read-only path, which the VFS reaches only after
> sb_prepare_remount_readonly() has drained in-flight writers, and to
> ntfs_put_super(), which runs after evict_inodes() on a quiesced
> filesystem.  A mounted read-write volume now keeps the dirty bit until
> it is dismounted cleanly, which matches the NTFS semantics; the cost is
> a needless chkdsk if the machine crashes between a sync and the unmount.
> 
> A recorded error state is still persisted right away when the
> filesystem is synced: with NVolErrors() set,
> ntfs_sync_volume_dirty_state() can only set the bit, never clear it,
> so it cannot lose a modification the way the old unconditional call
> did.  This keeps the error report from being lost to a crash on a
> volume that has seen no modification; an error recorded after the
> last sync is still only persisted at the next quiescent transition.
> 
> sync_blockdev() and blkdev_issue_flush() are both called and the first
> error is returned, so a writeback failure neither hides a flush failure
> nor skips it.
> 
> A RWF_NOWAIT write still blocks in the marking when the volume looks
> clean, as it already did on the base; a non-blocking marking is
> follow-up work.
> 
> Reported-by: Baolin Liu <liubaolin@kylinos.cn>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/file.c  |  7 ++++---
>   fs/ntfs/super.c | 31 ++++++++++++++++++++++++-------
>   2 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index cfc7b36b7dff..99a2c7a5cf81 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -621,9 +621,10 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   
>   	/*
>   	 * The volume must be marked dirty before the modification is made,
> -	 * without an unlocked check of the in-memory flag: ntfs_sync_fs()
> -	 * can clear the bit concurrently and the modification would then
> -	 * land on a volume that is clean on disk.
> +	 * without an unlocked check of the in-memory flag: the dirty bit
> +	 * is only cleared at the quiescent transitions, under the same
> +	 * $Volume mrec_lock this call takes, so an unlocked skip could
> +	 * lose the set to one of them.
>   	 */
>   	ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>   
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 3574c224fe28..463050ae1b0e 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -486,8 +486,9 @@ int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
>    * This is the single point that persists the in-memory error state to disk.
>    * The runtime error paths only record NVolErrors() because they run under a
>    * variety of ntfs locks the dirty-bit write cannot be taken under (runlist
> - * locks, vol->lcnbmp_lock, vol->mftbmp_lock, mrec_locks); the first
> - * ntfs_sync_fs(), a remount, or the unmount then persists the flag here.
> + * locks, vol->lcnbmp_lock, vol->mftbmp_lock, mrec_locks); a sync of a
> + * volume with recorded errors, a remount to read-only, or the unmount,
> + * then persists the flag here.
>    *
>    * A hibernated volume is not written from these persistence paths:
>    * resuming Windows from a modified image corrupts it, so the dirty bit
> @@ -1955,7 +1956,7 @@ static void ntfs_shutdown(struct super_block *sb)
>   static int ntfs_sync_fs(struct super_block *sb, int wait)
>   {
>   	struct ntfs_volume *vol = NTFS_SB(sb);
> -	int err = 0;
> +	int ret, err = 0;
>   
>   	if (NVolShutdown(vol))
>   		return -EIO;
> @@ -1963,14 +1964,30 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
>   	if (!wait)
>   		return 0;
>   
> -	/* If there are some dirty buffers in the bdev inode */
> -	if (ntfs_sync_volume_dirty_state(vol)) {
> +	/*
> +	 * The volume dirty bit is deliberately not cleared here: a sync
> +	 * running concurrently with an in-flight modification could clear
> +	 * and persist a bit that was just set, leaving the modification
> +	 * on a volume that is clean on disk.  The bit is only cleared at
> +	 * the quiescent state transitions, remounting read-only and clean
> +	 * unmount.  A recorded error state, however, is persisted right
> +	 * away so that it is not lost to a crash on a volume that has
> +	 * seen no modification; with NVolErrors() set this can only set
> +	 * the bit, never clear it.
> +	 */
> +	if (NVolErrors(vol) &&
> +	    ntfs_sync_volume_dirty_state(vol)) {
>   		ntfs_warning(sb, "Failed to sync dirty bit in volume information flags.  Run chkdsk.");
>   		err = -EIO;
>   	}
>   	sync_inodes_sb(sb);
> -	sync_blockdev(sb->s_bdev);
> -	blkdev_issue_flush(sb->s_bdev);
> +	ret = sync_blockdev(sb->s_bdev);
> +	if (ret && !err)
> +		err = ret;
> +
> +	ret = blkdev_issue_flush(sb->s_bdev);
> +	if (ret && !err)
> +		err = ret;
>   	return err;
>   }
>   

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

