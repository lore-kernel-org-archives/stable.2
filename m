Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FD35F5F8;
	Thu, 27 Aug 2026 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787802673; cv=none; b=Gsm5s70rc6WWXlBAPOpotXGsHXBErd8nFucFkESkhsrxobGoZdwG98lwHmaXvsWaliKODhErrsOyDp7flfiLT4TKexSSWqa4Us58eEt1vJlIH9Lr1i+6XXyB8Kt/u3WZTv1wDaM4ix07So2lVXGbdxLLhQQ04QrrVhc+DDbr/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787802673; c=relaxed/simple;
	bh=nJJdIuhlyq2LsJoNbOyBTovLQCQaKFBBLulqW0ZCI5M=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=L9iNoSRmaBwzQk5OYw7UhQnQzH5MgU8Z5r4PjiCIJnCYGQ+3vBmDqWWm/ooyTcjZpJJXR6pQ7zLLOEiEcNdHOvaT58REO1skGHA3/6Es4gaREJT5DETNsZ4eGunPf2IQNG76bGdOQeVBA/ysQiJWDPS7YTw8Og6KRMQ0sQT1sTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MQ1SlbLE; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MQ1SlbLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=S6IWZcauZ5CVhTe3iMxKoYaYNxGO74TAmSY2P28AfYs=;
	b=MQ1SlbLETn1P6G0veZExdBmtq4f0qyXAAcZY0Vbb8RJHFM/vGBbZXlN0ZMIBk3
	S89CPaqZ08i9mA4I31Aho+Abl95fJz6rf1r101kRiA8NaYMNVbKrHSaQkQvMMshf
	Zuh1mB02jGxZIg6KTDcB5Ozljxveh9k9hMQf/Bn/qsC+0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDnD+sVtI9qu_uLFQ--.56921S2;
	Thu, 27 Aug 2026 11:50:46 +0800 (CST)
Message-ID: <6A8FB3FB.9040205@126.com>
Date: Thu, 27 Aug 2026 11:50:19 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org, 
 hyc.lee@gmail.com
CC: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v2] ntfs: fix race between fallocate and mmap reads
References: <20260827031647.1605970-1-zenghongling@kylinos.cn>
In-Reply-To: <20260827031647.1605970-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgDnD+sVtI9qu_uLFQ--.56921S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1kCr4kXFW8CryktFW3Awb_yoW8Kw47pr
	ZFgF4rK3s3XryUX3WkKw48uF1rWw1kGrW5WrWSqw1xZFnxtFn7Kr4UKr1S9a4xKF93Jr45
	Xr4jqr9rWa4avaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-sqJUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrxawgWqPtBaeVwAA3G

Hi Hyunchul,

Thanks for the review.

I sent an updated patch too quickly. Simply removing map_locked is not
correct because there is an early compressed-file exit before
invalidate_lock is taken, so making the unlock path unconditional would
unbalance the locking.

Please ignore the previous version. I'll send a v3 with the control-flow
fix shortly.

Thanks,
Hongling
在 2026年08月27日 11:16, Hongling Zeng 写道:
> The fallocate implementation only takes invalidate_lock for punch hole,
> collapse range, and insert range operations. For standard allocation modes
> (mode == 0, FALLOC_FL_KEEP_SIZE), the lock is not held.
>
> During ntfs_attr_fallocate(), new clusters are mapped to the runlist via
> ntfs_attr_map_cluster() before being zeroed by ntfs_dio_zero_range(). This
> creates a window where concurrent mmap page faults can read uninitialized
> disk data.
>
> Since mmap uses filemap_fault() which takes invalidate_lock in shared mode,
> it can fault in pages during this window and expose old disk contents to
> userspace. This is an information leak and data integrity issue.
>
> Fix by taking invalidate_lock for all fallocate operations, not just for
> punch/collapse/insert modes. This prevents concurrent page faults from
> accessing unzeroed clusters during the allocation window.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
> Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
> ---
> Change in v2:
>   -Remove now-unnecessary map_locked variable.
> ---
>   fs/ntfs/file.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 88747217ba61..779baafa0319 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -1153,11 +1153,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
>   	}
>   
>   	inode_dio_wait(vi);
> -	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
> -		    FALLOC_FL_INSERT_RANGE)) {
> -		filemap_invalidate_lock(vi->i_mapping);
> -		map_locked = true;
> -	}
> +	/* Take invalidate_lock for all fallocate operations to prevent races */
> +	filemap_invalidate_lock(vi->i_mapping);
>   
>   	switch (mode & FALLOC_FL_MODE_MASK) {
>   	case FALLOC_FL_ALLOCATE_RANGE:

