Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FE4EE869
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891780; cv=none; b=AXLG18eHLSDPDX63++Eq9WhLMqzsTiR0Q4t2hFAYaBG4YAu9fjbdpOf3SoIhQ6vdp5a4wn/aLpHOpUGmc+U7BdLVsBqlKdyBpUbIC8PszBkgyaNkTUyGzSMKB090G4v2y5Ks89Q1+xBEn+VQ37/HyX+xy25Uy/8VGXPTOsr7kys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891780; c=relaxed/simple;
	bh=CIMdMh++ZEplhGMSLLwZfKOvEgqA6HcnBv+q4ybPNGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=qFzlfeJQGcvt2QPm7m/77w/SVzCXLiUVnZ+DD0b1Hr+lWcgGUyCxJvhNv6BBF1WZKYOOI/tPZEGhFRJtB+oUb0wo/eNY5abrnVrUgcdnl/eeqlZrLWEGTkTPL9kUdWvTkcXDhaTwUiQmJEf1NI5/dmkDz2NKwqABz0O3PsZRit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QiQ+ZZL4; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QiQ+ZZL4"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261013114256euoutp02db66fac054c9cc73afdb76e5870a1cce~eFBOyay392825728257euoutp025
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:42:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261013114256euoutp02db66fac054c9cc73afdb76e5870a1cce~eFBOyay392825728257euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791891776;
	bh=Q9aqMDODe600BFm8D61Dvnouj+6fVW9MMKyx7NIsysw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QiQ+ZZL4DOyVlsSJovFzb1XiCOM/4TnpHoRjojfXPD6vpOv0PEdAtOIeCtI4V+RhW
	 p7rc8Wa50YHaXCnZXqqKHYfEtV+IZxG762XRV1obJrIHrLlXHAMIYaugnPJ7/2lnhA
	 Bbb+PFKIRLtl5VvDsM+i52K0kISioy9xLhDWyMqQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261013114256eucas1p16397bdcc2581199fc88c07ed85140cda~eFBOZ9TQG2531425314eucas1p1O;
	Tue, 13 Oct 2026 11:42:56 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261013114255eusmtip205abe02f05a4bd61c6ad22500639b211~eFBNseO-R2337123371eusmtip2F;
	Tue, 13 Oct 2026 11:42:55 +0000 (GMT)
Message-ID: <6b66c6fb-14d2-4d71-b638-59e7595e4896@samsung.com>
Date: Tue, 13 Oct 2026 13:42:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] tools/dma: fix building from the top level with O=
To: Sasha Levin <sashal@kernel.org>, Barry Song <baohua@kernel.org>, Qinxin
	Xia <xiaqinxin@huawei.com>
Cc: stable@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261011223358.2327625-4-sashal@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261013114256eucas1p16397bdcc2581199fc88c07ed85140cda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261011223410eucas1p1db84283e5fc98bfb7d0bdeff84fd1a7c
X-EPHeader: CA
X-CMS-RootMailID: 20261011223410eucas1p1db84283e5fc98bfb7d0bdeff84fd1a7c
References: <CGME20261011223410eucas1p1db84283e5fc98bfb7d0bdeff84fd1a7c@eucas1p1.samsung.com>
	<20261011223358.2327625-4-sashal@kernel.org>

On 12.10.2026 00:33, Sasha Levin wrote:
> "make O=<dir> tools/dma" fails:
>
>   Makefile:27: /tools/build/Makefile.include: No such file or directory
>
> tools/Makefile clears srctree, and the dma Makefile only works it out
> again when building_out_of_srctree is not set, which the top-level
> Makefile sets for O= builds.
>
> Also work out srctree when it is empty, as tools/bpf/Makefile does
> since commit a89b2cbf71d64 ("tools, bpf: Fix build for 'make -s
> tools/bpf O=<dir>'").
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

