Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8204322A;
	Tue,  8 Sep 2026 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788826554; cv=none; b=Yu6k9jPBRmcEeDytN9vURDgkdsWwiifrNT67CoYGpy4vzOMr1krDQJqyUU92xgzc0t/Kqh9HyH1JUr77ywbQj/q2jedHaYtEaKXxVyILvgw3z1hu7ajJB6v+4+69y0nOO9WDBP1vb8yXemMGmbbcTxo+BOZkrfOpEpDaroIXoNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788826554; c=relaxed/simple;
	bh=SXguv3amBMe23KPDxvQOFKFBQSy6nHDxgmAQrNGnphU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cGt1a6Mlcw/hgMcWuMlz2/2y2eBso4eK6WpMsEmAa6QRiNeMfL0OCsDbCGJ9b7M2TaQzqswdGEsDGbXjd6GzCV9QkTujeoJR9iDzwn3jWkGhxaYRLyrq8V3J7XcLn7nC0oygYWti2n/s2C42NpwdTIm0r4lYxJhr22iCsd5kI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1rXJ6Dk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1rXJ6Dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DA21F00A3A;
	Tue,  8 Sep 2026 00:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788826553;
	bh=u6vi8Rb6/gBzlGLkta4lZeRt2WHuRcBjCNqaFrwusn8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=i1rXJ6DkJj2sMXRT3npeM6KrYNLTadUhqDz7uMKitdmKGXc4IY+0oKdBjPNXXJw1H
	 BJVHQWtvsh6G0gdgf3hKefVzpaqe1QyHA/7z8JEQK8Ne95SdeleOzKKKUQJQbct+Na
	 ELlLi6Y6av2MxaUTuWjbHFFkxMPs4eIwAp1M6/74VidlDoQHogNYiqfAXWoTjsDBq4
	 zO+52jfZ66AxotnRLF7wKV5ZSWu2C5zWiRkf5Letyvpdhpbx9ui8nSEDuTpm0vZZSH
	 4LonR/3pSyR16zE6JC3bwyDVTQTXEFfzpBb2BRFZGOtiMXLbGVv2OE3qb9nl46X4tv
	 0UmPmRq+MrMxQ==
Message-ID: <3c4629c6-536b-44de-add4-39df3381e7d1@kernel.org>
Date: Tue, 8 Sep 2026 08:15:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 jianxin.pan@amlogic.com, tao.zeng@amlogic.com, tuan.zhang@amlogic.com
Subject: Re: [PATCH] f2fs: force out-place update for all writes on compressed
 file
To: jiucheng.xu@amlogic.com, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260907-origin-dev-v1-1-85ae7ebc8c98@amlogic.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260907-origin-dev-v1-1-85ae7ebc8c98@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 19:35, Jiucheng Xu via B4 Relay wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> For compressed file, compressed write may fail and fall back to raw
> write.
> 
> -Thread A                                         - Thread B
>    - f2fs_write_multi_pages                          - f2fs_down_write(&sbi->cp_rwsem);
>     - f2fs_write_compressed_pages                    - ...
>      - f2fs_trylock_op                               - ...
>       - f2fs_down_read_trylock(&sbi->cp_rwsem);      - ...
>     - f2fs_write_raw_pages                           - ...
> 
> Thread B acquires the lock first, which causes Thread A to fail lock
> acquisition and fall back to raw-data write.
> IPU_FORCE is enabled on small-capacity storage devices (< 16GB),
> so f2fs_write_raw_pages() overwrites the original compressed data
> in-place.
> 
> The in-memory node has been updated with raw-data addresses, while the
> node metadata stored on eMMC still remains in compressed state.
> If a power-cut occurs before the node is flushed to disk, on-disk
> inconsistency arises: disk data is raw, yet metadata treats it as a
> compressed cluster, leading to decompression failure.
> 
> To eliminate this risk completely, force out-place update for all
> write operations on compressed file.
> 

Cc: stable@kernel.org
Fixes: 4c8ff7095bef ("f2fs: support data compression")

> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
