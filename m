Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE64E324A
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891761; cv=none; b=GtyW694gKVQyFd2a0ApBHxerKZ8R9pWe7Xae6ZrJgWy29oxh5eOBFKvt8Eej0ED3JhDaqvv5tCMkdAzTRyG2JhJxB8PBLXVMa3X8YU5TGn3qwyTYfu7x2l7W/WmbpK9ZFKDvLY3AFFQN8NO4ljpjUa1nkTxlkVTwvwa2mdHjTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891761; c=relaxed/simple;
	bh=U+bBpLTdTRTSEkHogsiFc83MBh4G9kcX+GFQfUE+O8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=iarwwLS7ifNAq8zTmfM1Gp2UFvU/LBCiwX/Wm6D/W8jMa2oLWAkjYKRZkz48O3DAUqdR3iun5wy9ifI8RSy9rm2wxocOcPXqmaXw6pnCVZjptrIWzdfiNVzqjd6GSJfh/mZ891kmJqxYhmAXbXAFKEf1ffeDeQnByKiC6YNsM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eF5dRg/I; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eF5dRg/I"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261013114236euoutp01b24edafe5947520392ecbf3e512b2cc0~eFA8DnZaR0439604396euoutp012
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:42:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261013114236euoutp01b24edafe5947520392ecbf3e512b2cc0~eFA8DnZaR0439604396euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791891756;
	bh=uRBIAKjoJ8RCkVLKYLuj3GFPkt1qXY/TvTqILvRxUmc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=eF5dRg/Iz0xdB9vIfnA8WEXkecAB6Q712yf/IOphJJLa7iffLfjK2ZMOLyILoBgsf
	 SgqP8JjkPySZiF6pvT1bJ4PndyT/HvXLdzAI9VObO0sKomu2qGFYwQV0PLrXc6Jfzq
	 grBcmvZSzFPU0D7FoulcWhy2Rdkjx10uEHvXiNnw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261013114235eucas1p2582fa2b9e0489de3172f7657961c2254~eFA7iy_PL2127721277eucas1p23;
	Tue, 13 Oct 2026 11:42:35 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261013114235eusmtip16edaedcd2e9ca33d3cec0a46e7be8981~eFA6-XzPy2231722317eusmtip12;
	Tue, 13 Oct 2026 11:42:35 +0000 (GMT)
Message-ID: <028a2bfb-bdad-4685-9d50-04afa1d170bb@samsung.com>
Date: Tue, 13 Oct 2026 13:42:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] tools/dma: fix building with O=
To: Sasha Levin <sashal@kernel.org>, Barry Song <baohua@kernel.org>, Qinxin
	Xia <xiaqinxin@huawei.com>
Cc: stable@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261011223358.2327625-3-sashal@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261013114235eucas1p2582fa2b9e0489de3172f7657961c2254
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261011223409eucas1p2100147e14b9393639235b1858cd48e20
X-EPHeader: CA
X-CMS-RootMailID: 20261011223409eucas1p2100147e14b9393639235b1858cd48e20
References: <CGME20261011223409eucas1p2100147e14b9393639235b1858cd48e20@eucas1p2.samsung.com>
	<20261011223358.2327625-3-sashal@kernel.org>

On 12.10.2026 00:33, Sasha Levin wrote:
> With O= set, "all" depends on $(OUTPUT)dma_map_benchmark, but the only
> rule builds dma_map_benchmark in the source directory, and built-in
> rules are disabled:
>
>   make: *** No rule to make target '<O>/dma_map_benchmark', needed by 'all'.  Stop.
>
> Build $(OUTPUT)dma_map_benchmark.
>
> Fixes: f74ee32963f1b ("tools/dma: move dma_map_benchmark from selftests to tools/dma")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Applied to dma-mapping-for-next. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

