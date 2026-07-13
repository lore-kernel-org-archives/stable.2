Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D4364022;
	Mon, 13 Jul 2026 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923026; cv=none; b=WSgFZxMaqlfE/+zojwdaxWVpcKkbTmOetJU+6fzwJJBuB5zceNXbMiLx3lE8mgX3f70T4cxkEX1kUsOr2J4nQT2ktA5V/tVaHO+5lMclrsDTcwfdz3Ac1a3+TYz06+lGQF0ssRF20CbJW7CvdVUDBV32Oqo4uUiXJ4hw0Ry5Fnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923026; c=relaxed/simple;
	bh=6J/qqGxldeMlt/8oruwThcr42TdSBWOszXKMMXM1hrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsZqEN1HPY929wQG4J+OwxTPOZ1icJJo4kgiLsY5l6L38VnRjT9M5WhfTXcNEgJDxmffkQQ9aiSwAN4iEk27WQb9Os+Xx4NPQJnaHTLIndl+pds6EH+XpdRos6YiDoV3UBpNURdJRLwU/P0StcoctHzk+A9NOT399Fgi3H+kQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ql3wyiIT; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ql3wyiIT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783923015; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1SMTFYvRuB2vL+mgHf0VCkl/61cqdKhN04NrXntKSqA=;
	b=ql3wyiITy7eSLciiSz2ePc2O+w33FFtLDi7iHOmuzwRpNG8SC3JJbOjmvASC0zGv7ueqb58NGdRwVTSyJZSEaQaVUvKYXt2Kn1f9Lf95M35G4B05SfHT7jRQyIsafeMN7gzrA+SEyU3e/o9OsOzO20zXjvLUBTaQaM8B4jHp8WQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6u73ps_1783923013;
Received: from 30.221.131.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6u73ps_1783923013 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 14:10:14 +0800
Message-ID: <d8f92099-83b3-4161-9c17-ec97919f41a1@linux.alibaba.com>
Date: Mon, 13 Jul 2026 14:10:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: cap LZMA stream pool size
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Cc: Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260711143419.2762894-1-michael.bommarito@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260711143419.2762894-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 2026/7/11 22:34, Michael Bommarito wrote:
> fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
> pool from num_possible_cpus() or the lzma_streams module parameter, then
> z_erofs_load_lzma_config() preallocates one image-supplied dictionary per
> stream, accepting dictionaries up to 8 MiB.  On high-CPU systems, a small
> EROFS image can pin hundreds of MiB of vmalloc-backed decoder state until
> the erofs module is unloaded.
> 
> Impact: an attacker-supplied EROFS image mounted by the system can pin up
> to 8 MiB times the LZMA stream count of kernel vmalloc memory.
> 
> Bound the LZMA stream pool by a new CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS
> option, default 16.  The default keeps the worst-case preallocated
> dictionary pool at 128 MiB while preserving the existing per-image
> dictionary limit; memory-constrained systems can lower it and large
> servers can raise it.
> 
> Fixes: 622ceaddb764 ("erofs: lzma compression support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v2: bound the pool with a Kconfig option
>      (CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS, default 16) instead of a
>      hardcoded 16, per Gao Xiang's review, so memory-constrained and
>      server deployments can size it.  Kept the EROFS_FS_ZIP_ prefix of
>      the sibling options.
> v1: https://lore.kernel.org/linux-erofs/20260710023036.3745254-1-michael.bommarito@gmail.com/
> 
>   fs/erofs/Kconfig             | 20 ++++++++++++++++++++
>   fs/erofs/decompressor_lzma.c |  7 +++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 4789b1077d8ce..3e4731dd03e7c 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -131,6 +131,26 @@ config EROFS_FS_ZIP_LZMA
>   
>   	  Say N if you want to disable LZMA compression support.
>   
> +config EROFS_FS_ZIP_LZMA_MAX_STREAMS
> +	int "EROFS LZMA maximum decompression stream pool size"
> +	depends on EROFS_FS_ZIP_LZMA
> +	range 1 1024
> +	default 16
> +	help
> +	  EROFS preallocates a pool of MicroLZMA decoder streams, one per
> +	  possible CPU by default, or as set by the lzma_streams module
> +	  parameter.  Each stream can hold a dictionary of up to 8 MiB taken
> +	  from the mounted image, so on systems with a large number of CPUs a
> +	  single small image can pin a large amount of vmalloc memory until the
> +	  erofs module is unloaded.
> +
> +	  This bounds the number of preallocated streams.  The worst-case
> +	  preallocated dictionary memory is 8 MiB times this value.  Lower it on
> +	  memory-constrained or embedded systems; raise it on large servers that
> +	  decompress many EROFS images in parallel.
> +
> +	  If unsure, keep the default of 16.
> +

Currently z_erofs_lzma_nstrms is exposed as a module parameter
too, I hope if users specify a non-zero "lzma_streams", it won't
be limited to this setting.

So after a second thought, I hope "EROFS_FS_ZIP_LZMA_MAX_STREAMS"
may be called "EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS"?

And I wonder if the description can be simplified and closer to
the end users rather than the internal details.

>   config EROFS_FS_ZIP_DEFLATE
>   	bool "EROFS DEFLATE compressed data support"
>   	depends on EROFS_FS_ZIP
> diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> index f6692d0f2f04d..882684c663f47 100644
> --- a/fs/erofs/decompressor_lzma.c
> +++ b/fs/erofs/decompressor_lzma.c
> @@ -52,6 +52,13 @@ static int __init z_erofs_lzma_init(void)
>   	/* by default, use # of possible CPUs instead */
>   	if (!z_erofs_lzma_nstrms)
>   		z_erofs_lzma_nstrms = num_possible_cpus();
> +	/*
> +	 * Each stream can pin an 8 MiB image-supplied dictionary, so bound the
> +	 * module-global pool to keep the worst-case preallocation in check on
> +	 * systems with many CPUs (or a large lzma_streams request).
> +	 */

The comment here is unneeded I think since developers can just
check the description of "EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS"
I guess.

Thanks,
Gao Xiang

> +	z_erofs_lzma_nstrms = min_t(unsigned int, z_erofs_lzma_nstrms,
> +				    CONFIG_EROFS_FS_ZIP_LZMA_MAX_STREAMS);
>   
>   	for (i = 0; i < z_erofs_lzma_nstrms; ++i) {
>   		struct z_erofs_lzma *strm = kzalloc_obj(*strm);

