Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997B3F8243;
	Wed, 26 Aug 2026 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746192; cv=none; b=McGoRfpnebxmJAZB8hsihR4Ns62V4EUheA4eNNoBQn9KTiEd6LFtrcYVy/coxR7X+GXSA5VpQnK7Cj8MnxhKtIsgvIQ2ejN8bCHShmm0ESJ54sbZaC09y81agrDCGmlVadQgMTWy2lBkJSPrUzwthcq0Tvg5mUHp/kSCip82y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746192; c=relaxed/simple;
	bh=tVESxrkysASDZtz8u5tIVzEav1NZ7JHJDUehOyzURc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSI24187p4/2BM8lI+DEEBrWXdUc5MLEktUJV6krxWNO33A60LRuPHORxoSSj0x3HhSEFdyv0wfD8NpMzW/wrPj6fQgg0ua8vMLBMYjLCuqPBunAF3HYgtNM1tQ0Js8IeNAT+lRlkAibGpVIobbaKfW/qVBo4ZRVV1rRUvHNx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WezzRXDS; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WezzRXDS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=OR27lAMvT0wF9I/E939+cWjWXgTuo5inFEVMKcGCh9s=;
	b=WezzRXDSeSh2wfN+BaAktVBWAV8ueUi3u4Yx6PxD0fKKEV1GC8MOisuie2BxR4
	onplNV34E0svtUPrFZprnyJZA5MozC3aA6JjyEVwOGIoPChP7/LGQVHXl6oRzdU9
	6GlUdMiittci76FFpjSY0EkFn7XHdm7LqTE4WpTnyS5Mk=
Received: from [IPV6:2409:8900:1ef9:dee:fd7d:3170:e603:8258] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCnD5Ri145qRTSASA--.60674S2;
	Wed, 26 Aug 2026 20:09:08 +0800 (CST)
Message-ID: <28cce6b3-60ea-4ff5-b5bd-ff5c11516b08@163.com>
Date: Wed, 26 Aug 2026 20:09:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs: fix race between fallocate and mmap reads
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260826054204.1364589-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260826054204.1364589-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnD5Ri145qRTSASA--.60674S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF15Wr17uF1kAw4DWrykZrb_yoW8ZF1xpr
	ZIgF1rK34fXryjqF1kKw48uF1rWw4kW3y5Wr4Fq3WxuFn3tFn7Kw4jkrn5WFyxKF98Xr45
	Xr12qrZrua42vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTCJQUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gRNGGqO12TEVgAA3+



在 2026/8/26 13:42, Hongling Zeng 写道:
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
> ---
>   fs/ntfs/file.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 88747217ba61..6958a1469fb0 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -1153,11 +1153,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
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
> +	map_locked = true;
>   
>   	switch (mode & FALLOC_FL_MODE_MASK) {
>   	case FALLOC_FL_ALLOCATE_RANGE:

I verified the race window exists and the fix looks correct.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

