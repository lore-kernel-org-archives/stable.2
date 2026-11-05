Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866161;
	b=cIh6d/dJ8vA+KOGgslOQ90t9o6FLyh4X9PlyMxjGpEyA5myrADO1NxMqjbLIJM2XKy0t
	 3gbdqkAe005uuTbaGFfZQ4FOwssm07LZNH/UrFbjm5Da+1T10AY6ZfhydUjiuCBvmss/8
	 5FRq+ZVBq+zvIJRWJG2euAcZoWGLJr42d9k93mi5aOtYAdQaguPJbBhqpnOtikjPCC6cU
	 LAxlqXO8yGNlaW22R4bAi5H5vUP5/fm2JsW25MXS67N06csqRcsW2belos2SCuTwxbiH/
	 Y9DKA7nftbogqwBZ5QhMeyaFHTBKFsUvI8fL2BnVLrPCMb7iL4UdX+PvFPb9NNedqwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866161;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=bjETVxfVLMt2IiYKGkceVRGimWMB+LTEJ4OhF5ADDZA=;
	b=NqNa9QVKCf1DlqUIDcGWeawXJyBDZqZmCB+fGzfpZBumOErR8GdurVD1P2rbR22gW3Ur
	 fKBEGaFDOanI5vVgiJCF1hRU0+5ei0xo6yJqFWUqK88UvOoXpU/SDydJTIkFeP3hd5TYV
	 kdfA6yLhkxd37RFrm6QdIuX6R+dJ9UzvLmlSpZ+W+V4d6UXqKEzszKlyo5PZKJR3gCj5W
	 5Ha9fQMeSvTBBM2Kpg7prZpk+S/y6tvlxvbeNPiezd3Jqu4QbAh40DMYhecALeWNEKVSn
	 +VN8bfE1YPaMZ/Bsb0LxHS/Kv6U5lf75StRtoNctPEjaimzMSVQxBhz4UZMrvWzWBWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="SPwF/kbq";
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB897606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB897606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=SPwF/kbq
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261105080918euoutp01f50a50609fed979e8cb6e64ca61b5e5c~lF8Q76GVU1153211532euoutp01O
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:09:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261105080918euoutp01f50a50609fed979e8cb6e64ca61b5e5c~lF8Q76GVU1153211532euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793866158;
	bh=bjETVxfVLMt2IiYKGkceVRGimWMB+LTEJ4OhF5ADDZA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=SPwF/kbqDZMLDzZP74/liMmXBJWtDVqjU0tziMDe2iU42wJ+8HmyWpcU0MUw71UaY
	 5WbIOX7XRbIFjnhyiqDPulduYKEhdkyZxBjtlm0fxW/33RHopgZrMcFTPJtSKDd+cz
	 4eifBu4PatwDNFO9hJeOwsDlU94AzDeKx+P3sCo0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261105080917eucas1p2cceb741925f5b4810aa967fbc7d69736~lF8QpZTbj1672116721eucas1p2J;
	Thu,  5 Nov 2026 08:09:17 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261105080916eusmtip29e6e775c57e338e67abb69f5e93d8525~lF8P0c5Yo1415414154eusmtip2b;
	Thu,  5 Nov 2026 08:09:16 +0000 (GMT)
Message-ID: <b32a78a0-f984-448a-aa9b-6d1469b2672b@samsung.com>
Date: Thu, 5 Nov 2026 09:09:16 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma: swiotlb: Round restricted DMA pool size down to
 IO_TLB_SEGSIZE
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Claire Chang
	<tientzu@chromium.org>, Konrad Rzeszutek Wilk <konrad@kernel.org>, Giorgi
	Kobakhia <gkobakhi@asu.edu>, Michael Kelley <mhklinux@outlook.com>,
	stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261103155016.1107958-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261105080917eucas1p2cceb741925f5b4810aa967fbc7d69736
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862
X-EPHeader: CA
X-CMS-RootMailID: 20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862
References: <CGME20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862@eucas1p1.samsung.com>
	<20261103155016.1107958-1-m.szyprowski@samsung.com>

On 03.11.2026 16:50, Marek Szyprowski wrote:
> All other paths creating a swiotlb pool ensure that nslabs is a multiple
> of IO_TLB_SEGSIZE, and the swiotlb code relies on that. Since commit
> 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization") a
> restricted pool can have an arbitrary size taken from the device tree.
>
> If the pool size is not a multiple of IO_TLB_SEGSIZE, the last segment is
> partial and swiotlb_release_slots() reads mem->slots[index + nslabs],
> which is one past the end of the slots array when the freed buffer ends
> at the end of the pool:
>
>  BUG: KASAN: slab-out-of-bounds in swiotlb_release_slots
>  Read of size 2
>
> Round the pool size down to a multiple of IO_TLB_SEGSIZE, wasting a bit
> of memory, and warn about it.
>
> Reported-by: Giorgi Kobakhia <gkobakhi@asu.edu>
> Closes: https://lore.kernel.org/all/20261026032007.1957949-1-gkobakhi@asu.edu/
> Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
> CC: stable@vger.kernel.org
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied to dma-mapping-fixes.


> ---
>  kernel/dma/swiotlb.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

