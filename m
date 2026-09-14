Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C353491C9;
	Mon, 14 Sep 2026 04:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789359391; cv=none; b=JTSfCWIstw669Hb1nmimQeanZFYfobD2OmUMS6fY6UU+AxmaDmf10KdI9gIRTW7g6uOMjAwtNjAPks1pp6zhH788rtC+ikafacVWGT1v5765XnFkcVmpaHin6ubPvwWmAtHfgYwjHagTlarP9ijaLBbgDIqIG5TtJ7rAgvoCFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789359391; c=relaxed/simple;
	bh=QzVrZoukw7WTuOu3cgNefcnDjFp6nTct084mVJfLnnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mh9jMeyTdUI3XjnWfxPw+1rG4Fus94mRwfKq7sD0ujChqYGtLyyHSJvVNqSit9AosBv2Da8XtB4zDe/CJEMYztMPUJo/eAvT8UFyYWEGDd9KvngEVaC2nU7WfL5KOt/1v09aFPmf8wXqIZVXssMEjCmHdqeOXMyezCtyjq1yepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N7dUSa0B; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N7dUSa0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Xrx0krtMKGlJL4nzoC0zRjMGy+yB3MCiq7DW8qKGnTs=;
	b=N7dUSa0B0kUwwTcMPbU9Wvbk8PYuXoyLpJHjLkQq3KjnCY3/71MT19EqlCyuR9
	GU5d5V9aumU0e0feiSi6OwpsAcF9CA67BHkywDNrhUsbL8aTyx2SKoYd4y03G4ss
	1oqgsdFPXxs1chF90Di/lTTvM0QVFSahttBY/gwpQPckU=
Received: from [IPV6:2409:8900:1e93:14fb:a085:adb4:61d:add9] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wB3OQsFdadqn7o9Ag--.17275S2;
	Mon, 14 Sep 2026 12:16:07 +0800 (CST)
Message-ID: <2ee32e03-e39e-4dd1-be1e-13d3b68f5683@163.com>
Date: Mon, 14 Sep 2026 12:16:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs: mount hibernated volumes read-only regardless of
 errors=
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260914034202.52011-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260914034202.52011-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3OQsFdadqn7o9Ag--.17275S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF17XFWrJr1rtw1DKr4kJFb_yoW8Ar18pF
	9rCrnrKr18tw1j93Z7CFW8t3WF93s2ka1DKr1UAF47Zr4kJw1agas0gw1fuFWI9ryaqr4I
	qF40krWfWFW7AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTKZAUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gfirWqndQcpCAAA38



在 2026/9/14 11:42, Hongling Zeng 写道:
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/super.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 2d4132aa39d3..fd7e5dbd1115 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -1660,8 +1660,13 @@ static bool load_system_files(struct ntfs_volume *vol)
>   		const char *es1;
>   
>   		es1 = err < 0 ? es1a : es1b;
> -		/* If a read-write mount, convert it to a read-only mount. */
> -		if (!sb_rdonly(sb) && vol->on_errors == ON_ERRORS_REMOUNT_RO) {
> +		/*
> +		 * A Windows hibernation image is not a filesystem error, so
> +		 * this is a safety interlock rather than something the
> +		 * errors= policy may downgrade: always convert a read-write
> +		 * mount to read-only.
> +		 */
> +		if (!sb_rdonly(sb)) {
>   			sb->s_flags |= SB_RDONLY;
>   			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
>   		}

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

