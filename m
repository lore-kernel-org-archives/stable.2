Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC531AABF;
	Wed, 26 Aug 2026 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787717006; cv=none; b=c3nn78tzbtvIm7LiZVU3z7UdbwtaXu3gVu6imnUHHslb+fSHT5AaHMVh7LhoO2Mf+U70kNCxB7bAlUDpKITR40VApuk2qoh6C54LLVuwSPRgd7VD8sKGayxqnC1EuuIh1kk9XqOKYxGJ9c00HD4l04cGkLFlJ4NC0TgylPuVxcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787717006; c=relaxed/simple;
	bh=bSDn2epmMiayVV0Y41DpgzuHRjkHHR3rT0lWRIzi7IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnI0PRVb+EoAGxalM6fgSTGtJ6fTqLGylJn3whuYAwM/mHM+VaydVXWM6JLwVD5eUJElN+tbJRrORPQDXJxEuQXOGsfJSACTIoh4NaNuhuthaTUnidthY6YJK0agusR5bXAsNZsOb17HFMsTPVuWSLxzhL1KSxQCB2TRqSJMZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kqenXMCC; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kqenXMCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=DmxsRKcnb7WDRxu3MJzyelDGNdYl5ZdepQ+KDq39cQA=;
	b=kqenXMCCKwN0keuepbj0EEyi5YRr1qzv68jZI2D8iOubVHuDqrISbtCzpWCH+o
	litSp0NOroxc7dORmmFy02E5N2sWP6pIJtGO5aWk+eYKRZZZ201QkbjOe7WG34lB
	rjZrJutGPfNGHv5k8Vsm2yQVG4Py4NXBN7+gNvKRI9UJA=
Received: from [IPV6:2409:8900:1ef9:dee:fd7d:3170:e603:8258] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3Bf1tZY5qp0SOPA--.63544S2;
	Wed, 26 Aug 2026 12:02:55 +0800 (CST)
Message-ID: <e71a505f-1113-4268-930f-bfb22d2af27f@163.com>
Date: Wed, 26 Aug 2026 12:02:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs: fix undefined behavior in mft/index record size
 calculation
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260825095405.858623-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260825095405.858623-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3Bf1tZY5qp0SOPA--.63544S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF13Xw1ktw1UJrWftF47urg_yoW8KFWkpr
	ZIkryfKw4vyFW8Awn8GF45t34rGr98Ja1UW34UZrWxurs7tr17G34Dtr9Y9rZ5KFnYqr48
	AFsYgw4fCFy8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uf8nrUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwRCzfmqOZXDbBQAA3z


在 2026/8/25 17:54, Hongling Zeng 写道:
> The boot sector validation allows clusters_per_mft_record and
> clusters_per_index_record to range from 0xE1 (-31) to 0xF7 (-9) when
> interpreted as signed values. When these are used as negative shift
> counts in expressions like `1 << -clusters_per_mft_record`, values
> like 0xE1 cause `1 << 31`, which shifts into the sign bit of a 32-bit
> signed integer, resulting in undefined behavior.
> 
> Fix by using unsigned shift (1U << ...) instead of signed shift.
> This prevents undefined behavior while preserving the full valid
> range of negative values (-31 to -9) that may appear in NTFS boot
> sectors.
> 
> The encoding scheme uses negative values to represent record sizes
> smaller than cluster_size: -log2(record_size). Common values include
> -10 (1024 bytes) for mft_record_size and -12 (4096 bytes) for
> index_record_size.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 30481e5d5dd4..a1813093222b 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -695,7 +695,7 @@ static bool parse_ntfs_boot_sector(struct ntfs_volume *vol,
>   		 * = -log2(mft_record_size) bytes. mft_record_size normaly is
>   		 * 1024 bytes, which is encoded as 0xF6 (-10 in decimal).
>   		 */
> -		vol->mft_record_size = 1 << -clusters_per_mft_record;
> +		vol->mft_record_size = 1U << -clusters_per_mft_record;
>   	vol->mft_record_size_mask = vol->mft_record_size - 1;
>   	vol->mft_record_size_bits = ffs(vol->mft_record_size) - 1;
>   	ntfs_debug("vol->mft_record_size = %i (0x%x)", vol->mft_record_size,
> @@ -732,7 +732,7 @@ static bool parse_ntfs_boot_sector(struct ntfs_volume *vol,
>   		 * index_record_size normaly equals 4096 bytes, which is
>   		 * encoded as 0xF4 (-12 in decimal).
>   		 */
> -		vol->index_record_size = 1 << -clusters_per_index_record;
> +		vol->index_record_size = 1U << -clusters_per_index_record;
>   	vol->index_record_size_mask = vol->index_record_size - 1;
>   	vol->index_record_size_bits = ffs(vol->index_record_size) - 1;
>   	ntfs_debug("vol->index_record_size = %i (0x%x)",

Looks good to me.
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

