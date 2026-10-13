Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40B36606A;
	Tue, 13 Oct 2026 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857370; cv=none; b=rYlS98e9TQnTka7JaDssfOJAuZRrrI5D+LMexu5PZ34+N4PNtSs30fYcBI9oPdpjMf0HBife612KVLEnwzA2dntEP5aIWGUGA2kq4rtMPt1pJU993WRtGEHC04YVC3wvzg8ThnkIUWOOON673CBMP7uDRnM8UKqJFfAnYnQ6qKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857370; c=relaxed/simple;
	bh=F/tFZnIesbEp/jouf3jZn0ZNdnUf1tTCCFrENvkWFpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P8YBqRke2U5jzmI+r3LTuNRhR7FPfgHtHi4L6NJ+mBK/s3NihMfKTtP3xI4K3AjAieiKhPLWyZhvIHXvBb8EJt1fZaDnuEGI5dvpxpJ0jfoB9/7cs/5rq/JCL3l+cUPdD//5sjVjb7eR5LbQP+giONfk3x+TuUXAKPFk74F3sgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Y/02cg6s; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Y/02cg6s"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XBHUkK44x866PxdO3DxpbAK9UVhaScIzV3W9hPGWv1A=;
	b=Y/02cg6spwfx6hG2o7IR5zb0lX3hHl2nvACuyB75ShwrcV3MvkazFo/aqV5ddz1N5W1qCJ98f
	CLBHm/r1Tcc3bV5qW4t2chNz5RKh9iOoAw3piXwKGqHCB2LMYzTvx1IMmrtNGTmfp8m5nmIf67T
	JaXdNOv3iTdMAT16uP0ceYU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4j3csN2RmhzRhTk;
	Tue, 13 Oct 2026 09:57:12 +0800 (CST)
Received: from kwepemo500007.china.huawei.com (unknown [7.202.195.114])
	by mail.maildlp.com (Postfix) with ESMTPS id F2B9B40538;
	Tue, 13 Oct 2026 10:09:25 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemo500007.china.huawei.com (7.202.195.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 13 Oct 2026 10:09:25 +0800
Message-ID: <9c81fb51-ba0d-4b4a-b08b-7bdfaf3b51ff@huawei.com>
Date: Tue, 13 Oct 2026 10:09:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/dma: fix building with O=
To: Sasha Levin <sashal@kernel.org>, Barry Song <baohua@kernel.org>, Marek
 Szyprowski <m.szyprowski@samsung.com>
CC: <stable@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20261011223358.2327625-3-sashal@kernel.org>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <20261011223358.2327625-3-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500007.china.huawei.com (7.202.195.114)



On 2026/10/12 06:33:31, Sasha Levin <sashal@kernel.org> wrote:
> With O= set, "all" depends on $(OUTPUT)dma_map_benchmark, but the only
> rule builds dma_map_benchmark in the source directory, and built-in
> rules are disabled:
> 
>    make: *** No rule to make target '<O>/dma_map_benchmark', needed by 'all'.  Stop.
> 
> Build $(OUTPUT)dma_map_benchmark.
> 
> Fixes: f74ee32963f1b ("tools/dma: move dma_map_benchmark from selftests to tools/dma")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   tools/dma/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
> index e4abf37bf020c..0c239a6b9eae5 100644
> --- a/tools/dma/Makefile
> +++ b/tools/dma/Makefile
> @@ -38,8 +38,8 @@ prepare: $(OUTPUT)include/linux/map_benchmark.h
>   FORCE:
>   
>   DMA_MAP_BENCHMARK = dma_map_benchmark
> -$(DMA_MAP_BENCHMARK): prepare FORCE
> -	$(CC) $(CFLAGS) $(DMA_MAP_BENCHMARK).c -o $(DMA_MAP_BENCHMARK)
> +$(OUTPUT)$(DMA_MAP_BENCHMARK): prepare FORCE
> +	$(CC) $(CFLAGS) $(DMA_MAP_BENCHMARK).c -o $@
>   
>   clean:
>   	rm -f $(ALL_PROGRAMS)

Acked-by: Qinxin Xia <xiaqinxin@huawei.com>
-- 
Thanks,
Qinxin

