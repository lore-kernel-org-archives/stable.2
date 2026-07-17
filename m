Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2390A334C2E;
	Fri, 17 Jul 2026 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259834; cv=none; b=JvHc5stwTvVX2l+lg3T8OBvLAV7G6/Gr6ZZu+Oxwuvd2RRHPgRPj595lKPR+f9k0w1sz/fH0udeX1GWs3UH+yOvkpUCyrvUO9pPohHYzJ//4jQwOr6SUNwhQHjGsTH/FSJnhHe8lzs2XOWL87Zh1M8UlXwieMZ6Dxr1xRtdsT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259834; c=relaxed/simple;
	bh=JuQbv5cWU1143Gyz0JiFZ2pjTxb83sS9hV67NH0rsyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOjgRPEguNQfbMsVVycrWHWWDbUv3TUpEyRADX4Aya0sl5qK2FTeYP1bI12KtpzrhbqivgzywqVOAwqwEGGlTbrury00BIiepKSvWCTsOisRLrcur+hTpqAlI4aWV/TGjc65as63xhIfYf+L96U6y3fjZEdvVGqOZawRhtRX0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WkxHc9wr; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WkxHc9wr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784259824; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hbG0T2IH58E2ZuetAf/eBFvgeoRb92lgSfBdcK6cl+Q=;
	b=WkxHc9wrIz3ryVqQbmXJQ2SE62O6x5t0+toeaaY5GNhQSezVww8IZnl+yql6wrsVNMW0gm63IDq7pLb3MMoSW6lG4dda54PrzZIg/EQc06qJK0oKPtbWc1d52sgQiBhvffMfRLxAPRny58RyqmZDjLAU2pwIOuHioOThHTaYL1A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X7G2U7i_1784259822;
Received: from 30.221.133.5(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X7G2U7i_1784259822 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jul 2026 11:43:43 +0800
Message-ID: <d0d5816c-8aef-4155-806f-37094c79d847@linux.alibaba.com>
Date: Fri, 17 Jul 2026 11:43:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: cap LZMA stream pool size
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Cc: Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260714114729.3760594-1-michael.bommarito@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260714114729.3760594-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/7/14 19:47, Michael Bommarito wrote:
> fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
> pool from num_possible_cpus() when the lzma_streams module parameter is
> unset, then z_erofs_load_lzma_config() preallocates one image-supplied
> dictionary per stream, accepting dictionaries up to 8 MiB.  On high-CPU
> systems, a small EROFS image can pin hundreds of MiB of vmalloc-backed
> decoder state until the erofs module is unloaded.
> 
> Impact: an attacker-supplied EROFS image mounted by the system can pin up
> to 8 MiB times the LZMA stream count of kernel vmalloc memory.
> 
> Bound the default stream count by a new
> CONFIG_EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS option, default 16, so the
> worst-case default preallocation is 128 MiB while preserving the existing
> per-image dictionary limit.  An explicit lzma_streams module parameter is
> still honoured as-is, so administrators who deliberately size the pool are
> not affected.
> 
> Fixes: 622ceaddb764 ("erofs: lzma compression support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
