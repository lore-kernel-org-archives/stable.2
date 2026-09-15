Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F32E6CA6;
	Tue, 15 Sep 2026 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789443569; cv=none; b=V07TaDMgTL9CXXdW/xnZme0SIhQ4l20S2gSkFZNlTlswRkiSOHIZp/69wAtirxA7ve6Gy5Bx8qKcIc+vPlVJRokGIrJ0WRFXWyv6DoM5UOPr6hLzjD4NOS2/MFKFw+vUpHUTTF1Wcj9Sny22JdnkJhQTCkuvW6f9eBweZD7Yxn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789443569; c=relaxed/simple;
	bh=ksNqJqY+HI9rtCVP3xRhanSbEy2ZA051zgWZvnUpPTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+K3q+enzIBNOxXvGFOj7K1du8ksK73rPfcY3sRA5G4YWooLD/CGF1EWnE5LV31EV4TpxBuf7KpOling+pBThYv/l5Cdd8yrxe9FgvzP9USHAqwlQwb0SbcT7JfH2YJvAoJvuxybPYTATaOzTJ4/LOwBfSCdxIXnrwjlz44Of5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TUmRXjMR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TUmRXjMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=AR+a6NnnWTjFz9AMsycnfyj4oHN9dzhv3lnEPgJyEY8=;
	b=TUmRXjMRsA848RuHwc/2jXcH2ViqcsoESEbBypkyKuBJIy/knWb90wkNA3oo8Z
	6s/AwCpDV5c6SY7Ps8hrYeQjjJwoCej9d0ztnjCz8u4e0WMcZ8G1jtGDGHvfDCBU
	cEMc44YRQ6K0QTA/awWK2VETT3nvM/RWa/o3LlENDaXjc=
Received: from [IPV6:2409:8900:1e93:14fb:93e6:4816:3b13:f1ac] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnD7jLvahqLHQEAw--.54802S2;
	Tue, 15 Sep 2026 11:38:53 +0800 (CST)
Message-ID: <c1c96d2a-2b0f-41fc-a40f-b2cc8748630a@163.com>
Date: Tue, 15 Sep 2026 11:38:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ntfs: mount hibernated volumes read-only regardless of
 errors=
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260915023820.621797-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260915023820.621797-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD7jLvahqLHQEAw--.54802S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFW7KFy7CFy3XF18trWDJwb_yoWrJF4xp3
	srGF4Dtr18tr10k3Z7tay2qw1a93s2ka1UKry8Aw1xXa95tFn8GasIgr1F9rWfK3y3Wa1x
	XF4jyrZxGrW7ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTKZAUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwQ1nMmqovc1xdgAA3s



在 2026/9/15 10:38, Hongling Zeng 写道:
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
> Also change the ntfs_error() calls inside
> check_windows_hibernation_status() to ntfs_warning(): they run before
> SB_RDONLY is set, so errors=panic could panic there, while the warnings
> preserve diagnostics for already read-only mounts.  The read-only
> fallback message is logged unconditionally: with SB_RDONLY set, or on
> an already read-only mount, ntfs_error() cannot panic, and the reason
> for NVolErrors() stays visible.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Hi Hongling,
The patch looks good to me. One suggestion: please add the following 
Fixes tag:
Fixes: 6251f0b0de7d ("ntfs: update super block operations")

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

> 
> ---
> Changes in v3:
>   -Use ntfs_warning() for the hibernation diagnostics so that
>    errors=panic cannot fire on this path.
>   -Always log the read-only fallback message, including on already
>    read-only mounts.
> ---
>   fs/ntfs/super.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index f4a73e45773d..d1edf1a891e8 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -1169,7 +1169,7 @@ static int check_windows_hibernation_status(struct ntfs_volume *vol)
>   			return 0;
>   		}
>   		/* A real error occurred. */
> -		ntfs_error(vol->sb, "Failed to find inode number for hiberfil.sys.");
> +		ntfs_warning(vol->sb, "Failed to find inode number for hiberfil.sys.");
>   		return ret;
>   	}
>   	/* Get the inode. */
> @@ -1177,7 +1177,7 @@ static int check_windows_hibernation_status(struct ntfs_volume *vol)
>   	if (IS_ERR(vi)) {
>   		if (!IS_ERR(vi))
>   			iput(vi);
> -		ntfs_error(vol->sb, "Failed to load hiberfil.sys.");
> +		ntfs_warning(vol->sb, "Failed to load hiberfil.sys.");
>   		return IS_ERR(vi) ? PTR_ERR(vi) : -EIO;
>   	}
>   	if (unlikely(i_size_read(vi) < NTFS_HIBERFIL_HEADER_SIZE)) {
> @@ -1188,7 +1188,7 @@ static int check_windows_hibernation_status(struct ntfs_volume *vol)
>   
>   	folio = read_mapping_folio(vi->i_mapping, 0, NULL);
>   	if (IS_ERR(folio)) {
> -		ntfs_error(vol->sb, "Failed to read from hiberfil.sys.");
> +		ntfs_warning(vol->sb, "Failed to read from hiberfil.sys.");
>   		ret = PTR_ERR(folio);
>   		goto iput_out;
>   	}
> @@ -1581,11 +1581,16 @@ static bool load_system_files(struct ntfs_volume *vol)
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
> +		if (!sb_rdonly(sb))
>   			sb->s_flags |= SB_RDONLY;
> -			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
> -		}
> +
> +		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
>   		NVolSetErrors(vol);
>   	}
>   

