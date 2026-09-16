Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1A484220;
	Wed, 16 Sep 2026 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593564; cv=none; b=Gjo4fqVKeC8DmrLqE2j6TjTwxzzCofgxOcMex8dnYw1y5bujk7g8mT385pqF55UpEOxg9v2qUAOebYFQ2t7/GbEAkUv0b8dDjuLfZjEV0d9yPssjuWtPXS151r3b4DXFgWBntV4SOocrEWJmm+tpWh0kPUlS2yJCL68hXqKfIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593564; c=relaxed/simple;
	bh=zXDJuJB/O0iIaGyq0VHQ35mZi8v73zGNbYzjjTH9Igs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAT8bccOx+h4DeKqCidtIW8we0N1G5gkHTViRavF72IEVsuoePPsot2XrqPqQJ841i4AK9U1nzwdqwlz8DdAca4RGUgQcifHwEFKEzeyox1hlKv7lGXpTxz7zArFTn0T4bg/iah6oaqS0f9UNZkfx4x8h+bDsmZoQIu3GAA387I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Fph1bYti; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Fph1bYti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Mhm0Cqv9nr0dnfojm5BB9FQ3ji0Ip1DTJBZdypnLaCg=;
	b=Fph1bYtijkjf714mS8uW+mKvT2gphlbuMbU1p/9jIF05bRCcEf1vrO9/qbupYV
	OaNMBisLAuAaQvoUJWqvs4XWnub/ozXIGF7AEWecJwxfKWULJXDkALPvTCwY79TT
	MpUDjO33yS1X7GzzzCGasDXO5yAIBxL7Sl+FrJv2UlvhA=
Received: from [IPV6:2409:8900:21a7:a33a:b45d:31d1:c098:7d46] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3f8KrB6tqSyo9BA--.43583S2;
	Thu, 17 Sep 2026 05:18:36 +0800 (CST)
Message-ID: <3e9cb05c-8790-4ccb-a435-2013c474b06a@163.com>
Date: Thu, 17 Sep 2026 05:18:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 7/7] ntfs: fail remount on sync errors and keep the
 dirty bit on SB_FORCE
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260915083252.812126-1-zenghongling@kylinos.cn>
 <20260915083252.812126-8-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260915083252.812126-8-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f8KrB6tqSyo9BA--.43583S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1UJr48Cw47Cry5GrW5Awb_yoW5GF1DpF
	y7AFn8GayktF17Cwsa9FWftF4rur97Ca17K347Cw47XwnYyrnFyr18tryrWayxJr9Yyw4r
	XF4vkrW5KF1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaksgUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwgxyPWqrB6zHcAAA3c



在 2026/9/15 16:32, Hongling Zeng 写道:
> ntfs_reconfigure() currently ignores sync_filesystem() errors, allowing
> a regular read-only remount to succeed even when dirty data was not
> synced. Check the error and fail regular remounts, leaving the
> superblock read-write so ntfs_put_super() can retry at unmount.
> 
> SB_FORCE does not wait for writers already in progress, so it must not
> clear the on-disk dirty bit. Warn and continue on sync errors for
> SB_FORCE. A forced remount updates the dirty state only when errors
> have been recorded, and never clears the dirty bit. Skip the commit if
> that state update fails, since the in-memory flags may be inconsistent.
> 
> Reported-by: Hyunchul Lee <hyc.lee@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/super.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 0228d7429596..82b5bf28b6ab 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -272,7 +272,13 @@ static int ntfs_reconfigure(struct fs_context *fc)
>   
>   	ntfs_debug("Entering with remount");
>   
> -	sync_filesystem(sb);
> +	err = sync_filesystem(sb);
> +	if (err) {
> +		ntfs_warning(sb, "Failed to sync the filesystem.");
> +		/* A forced remount must still turn the superblock read-only. */
> +		if (!(fc->sb_flags & SB_FORCE))
> +			return err;
> +	}
>   
>   	/*
>   	 * For the read-write compiled driver, if we are remounting read-write,
> @@ -329,11 +335,20 @@ static int ntfs_reconfigure(struct fs_context *fc)
>   		 * or flush fails the remount, leaving the superblock
>   		 * read-write so ntfs_put_super() retries at unmount.
>   		 */
> -		err = ntfs_sync_volume_dirty_state(vol);
> -		if (err) {
> -			ntfs_warning(sb,
> -				"Failed to update dirty bit in volume information flags.  Run chkdsk.");
> -			return err;
> +		/*
> +		 * A forced remount does not drain writers in progress,
> +		 * so one may still be modifying metadata when the flags
> +		 * are committed: never clear the dirty bit then; if
> +		 * errors have been recorded, the update preserves or
> +		 * sets it; otherwise, skip the update entirely.
> +		 */
> +		if (!(fc->sb_flags & SB_FORCE) || NVolErrors(vol)) {
> +			err = ntfs_sync_volume_dirty_state(vol);
> +			if (err) {
> +				ntfs_warning(sb,
> +					"Failed to update dirty bit in volume information flags.  Run chkdsk.");
> +				return err;
> +			}
>   		}
>   		if (NInoDirty(NTFS_I(vol->vol_ino))) {
>   			/* ntfs_commit_inode() would discard the error. */

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

