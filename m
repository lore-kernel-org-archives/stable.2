Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FA2264A3;
	Tue, 22 Sep 2026 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036360; cv=none; b=BCx0WxTrcnjb/7keKq7qwiSpmZj1k+/bvlMqU4NC+0eiWVd/qBlk11ZYhjGguJSttSo8l7RMfABvIQYJC7R24Qfp6PpUrb4k45aRj2/yB2liznF8+0SyUFKvwTa6+eIk/5/HTmXxdTNcLaQvsVw+qWMbRcWF47969cKgps0Ya00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036360; c=relaxed/simple;
	bh=9ynVDx+M+tsHxddJCjeo530HuQORa+JDd70XIZw2fMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePMMPSOrkIR4x3dcqp+TyXu/Ml9qKh0vBQcXmBMb9wgzxRw6/7HNBxilm/N3dnMYMEupmaXMoIgeeaSf6W0yWEo0qSJTe6QTLhHLmtM0+wH0KoYDWtoEs8lpUUH+nc7DHV2BIw844ut2V4EC3DJEw9jxKLF9v8a3uaL37gAA+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l2PShznm; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l2PShznm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=sg2FEsDZy/ikb2xP2ZYdfBuEwcQDzSuOZTV0h5Qesl0=;
	b=l2PShznmTvJVT0zCvP5rWxjOSAvzKWW3wTqQ7qg2mo2lxKemJTJXTjkQsWwTVE
	E17Igx7QeRRzbVMNrNH+EgfYWltFMhTGByp8iKsOxmqrxmRI8fKXSlQKk8OO92mr
	50rzBBZs4t5vgAIHTb9cTj/Z79rOAcN8Gyuwp6gFi5bNM=
Received: from [IPV6:2409:8900:1ee3:222c:420f:a5a2:eb51:8645] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHz+puybFqvlbRAg--.32355S2;
	Tue, 22 Sep 2026 08:18:55 +0800 (CST)
Message-ID: <bc5546de-6548-4abd-a1d5-d62e6a4d744c@163.com>
Date: Tue, 22 Sep 2026 08:18:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] ntfs: mount hibernated volumes read-only regardless of
 errors=
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org,
 Baolin Liu <liubaolin@kylinos.cn>
References: <20260921091907.1491879-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260921091907.1491879-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDHz+puybFqvlbRAg--.32355S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4fGr4xKFWfJr17tryxZrb_yoWrtw1fpF
	ZrJwn8tr4kKr129rn2yay2k3Wru392kayUKr18Aw4xXr95ArnIq34xKw1F934Ikr9Yqw48
	XF4j9ay3WFWUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVUDXUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6Q+UX2qxyW+p6AAA3R



在 2026/9/21 17:19, Hongling Zeng 写道:
> The hibernation check in load_system_files() only converts the
> superblock to read-only under errors=remount-ro.  With the default
> errors=continue (and with errors=panic), a hibernated volume is
> mounted read-write and the mount-time $LogFile emptying writes to it,
> although a hibernated volume must not be written to at all.
> 
> Drop the on_errors term so that a hibernated volume, or a volume whose
> hibernation state cannot be determined, always mounts read-only.
> NVolErrors() is still recorded, so ntfs_reconfigure() keeps refusing
> remounts to read-write, and the $LogFile emptying is skipped by its
> !sb_rdonly() check.
> 
> The check itself must not apply the errors= policy either: it runs
> before SB_RDONLY is set, and ntfs_lookup_inode_by_name() and ntfs_iget()
> call ntfs_error() internally on corruption or I/O errors, which under
> errors=panic would panic the machine before the read-only fallback has
> made its decision.  Temporarily substitute errors=remount-ro for
> errors=panic around the check: nested ntfs_error() calls then fall
> back to read-only, and any read-only transition they trigger is
> preserved even when the error is not propagated to the check's return
> value or recorded in NVolErrors().  This is safe during initial mount,
> before the super block is published.
> 
> If the check reports hibernation or fails, set SB_RDONLY and record
> NVolErrors() unconditionally: hibernation safety takes precedence over
> the errors= policy.  A volume with errors recorded during the check or
> earlier in the mount, e.g. when loading the LogFile, also stays
> read-only, matching what ntfs_reconfigure() enforces for remounts.
> 
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Cc: stable@vger.kernel.org
> Suggested-by: Baolin Liu <liubaolin@kylinos.cn>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
> Change in v6:
>   - Temporarily substitute errors=remount-ro for errors=panic during
>     the hibernation check.  ntfs_error() does not always set
>     NVolErrors(), so the v5 restore condition could re-enable write
>     access after a real error.
> ---
>   fs/ntfs/super.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index f4a73e45773d..da2c8f310a7f 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -1398,6 +1398,7 @@ static bool load_system_files(struct ntfs_volume *vol)
>   	struct ntfs_attr_search_ctx *ctx;
>   	struct restart_page_header *rp;
>   	int err;
> +	u8 saved_on_errors;
>   
>   	ntfs_debug("Entering.");
>   	/* Get mft mirror inode compare the contents of $MFT and $MFTMirr. */
> @@ -1572,8 +1573,19 @@ static bool load_system_files(struct ntfs_volume *vol)
>   	 * NVolErrors() without setting the dirty volume flag and mount
>   	 * read-only.  This will prevent read-write remounting and it will also
>   	 * prevent all writes.
> +	 *
> +	 * Nested lookup and inode-loading errors must not panic before the
> +	 * read-only fallback has run.  Temporarily use errors=remount-ro
> +	 * instead of errors=panic, preserving any read-only transition even
> +	 * if an error is not propagated to the check's return value or
> +	 * recorded in NVolErrors().  This is safe during initial mount,
> +	 * before the super block is published.
>   	 */
> +	saved_on_errors = vol->on_errors;
> +	if (saved_on_errors == ON_ERRORS_PANIC)
> +		vol->on_errors = ON_ERRORS_REMOUNT_RO;
>   	err = check_windows_hibernation_status(vol);
> +	vol->on_errors = saved_on_errors;
>   	if (unlikely(err)) {
>   		static const char *es1a = "Failed to determine if Windows is hibernated";
>   		static const char *es1b = "Windows is hibernated";
> @@ -1581,12 +1593,15 @@ static bool load_system_files(struct ntfs_volume *vol)
>   		const char *es1;
>   
>   		es1 = err < 0 ? es1a : es1b;
> -		/* If a read-write mount, convert it to a read-only mount. */
> -		if (!sb_rdonly(sb) && vol->on_errors == ON_ERRORS_REMOUNT_RO) {
> -			sb->s_flags |= SB_RDONLY;
> -			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
> -		}
> +		/* Hibernation safety takes precedence over the errors= policy. */
> +		sb->s_flags |= SB_RDONLY;
>   		NVolSetErrors(vol);
> +		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
> +	} else if (!sb_rdonly(sb) && NVolErrors(vol)) {
> +		/* Match the read-write remount restriction for recorded errors. */
> +		sb->s_flags |= SB_RDONLY;
> +		ntfs_error(sb,
> +			   "Errors were recorded during mount.  Mounting read-only.  Run chkdsk.");
>   	}
>   
>   	/* If (still) a read-write mount, empty the logfile. */
Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

