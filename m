Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695315;
	b=TjIiPBao8Y3Movk+x0Y5vQd2AgvgeAWXzqpXQlNfKik2pBpz+vJThXuY79Usxf63Aj0a
	 FTCvGNlH3afXXGi1LtsN5rB7jMGPRhtj48XhtoyqfBqtyC3kCkF3uSXFqKT5Qu7RkApdt
	 QNGW1Ob4jz7Tedsk112q8NWRRMEiXiCRbUidp3ZUuw0R5Yy9j1QhqZQHu8SPzmHz6JCsj
	 90NHgtrntQ0hWCbMNlOddQQN8XZD3dPOyAJZ8ntTGyByCdRxH+SF2KWisOtcXF6cN5yz/
	 m02PEUD7108luwylaOq+VnYzNdbaZoOESRqu1Jxa5hi+CXDpEeP91JhFT+I8xuZ3BMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695315;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=r35ebxTXAFp75IFXPLib2rMbuUcQ84dYXkx8V7iwL8A=;
	b=WuPaw5p5Y7HFoZFkb4ieVgMa3/exC2fiPRhr3wKrRu89CITAkm+bQRR+tV+mrja4StLA
	 c4bp+tjx5aQ+e89RFGYQWoT3dhaT6yWYZ/FqsfANf5kxeJQvkQe1uD5FxBZRaan4rEkty
	 6LqWbsI8lk7VWM8KdYu7+gMVOA8tOKyBx/yoswB3KqPMk+bNBwUATvz5A/dVdLxyl3Wbw
	 WV82BYpH+2fiLNSYodgx+ZI8B4xOeHKm0ASX9QoH14XcRjbb9G8LMZTKqkqfDYF8WDk1o
	 PtuFQJxCDJ3Rb1CkgPWAXvV9HYd+kqMYOFW5rEWv/S1JcT9+Vx4Azd/+1zeZNoTMxcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XK1DYUpv;
	arc=none smtp.remote-ip=91.218.175.192
Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5F606C697
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FE5F606C697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XK1DYUpv
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=r35ebxTXAFp75IFXPLib2rMbuUcQ84dYXkx8V7iwL8A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793695313; v=1; x=1794300113;
 b=XK1DYUpvLk5CYvkb7JFC+S4lsX1Qqv4eUJlrtaue3W3zZb7pCf3qpo4zLyxKVIkvEtUzWZ+4
 S7M1RAa8eGkZH3JNO6bg+/5kwjAD1+ljLXL5I4B0+hAixXEB+fxlf7+rJokMyImgQB9peBBDw9m
 TU5YoENfR5BdtdIOzbGdNBa8=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 06b8647df261ab87;
	Tue, 03 Nov 2026 08:41:53 +0000
X-Mizu-Trace-ID: 06b8647df261ab87
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 1/4] x86: hugetlb: disable default CMA reservations on
 32-bit kernel
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <61eee83da19a87337e68a7747fc0b89ee5d0393b.1793692578.git.zhengqi.arch@bytedance.com>
Date: Tue, 3 Nov 2026 16:41:38 +0800
Cc: osalvador@suse.de,
 david@kernel.org,
 akpm@linux-foundation.org,
 azpijr@gmail.com,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org,
 x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4EE65C7C-3532-4056-9794-47A9B894969F@linux.dev>
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
 <61eee83da19a87337e68a7747fc0b89ee5d0393b.1793692578.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 3, 2026, at 16:01, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> A 32-bit x86 kernel can run on a 64-bit-capable CPU advertising =
GBPAGES.

I don't think anyone would do that. That said, it is genuinely an issue.

> arch_hugetlb_cma_order() checks only this feature and returns a =
nonzero
> order, although gigantic HugeTLB support on x86 requires =
CONFIG_X86_64.
> Specifying hugetlb_cma=3D can therefore reserve a CMA area that cannot
> serve the intended gigantic HugeTLB allocations.
>=20
> On non-PAE kernels, the folded PUD_SHIFT yields a 4 MiB order, which =
is
> equal to MAX_PAGE_ORDER. With CONFIG_DEBUG_VM enabled, this triggers =
the
> VM_WARN_ON(order <=3D MAX_PAGE_ORDER) check in hugetlb_cma_reserve(),
> warning that hugetlb_cma is attempting to reserve a non-gigantic =
order.
>=20
> Require CONFIG_X86_64 as well as GBPAGES when selecting the default =
CMA
> order to avoid these ineffective reservations.
>=20
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic =
hugepages using cma")
> Cc: stable@vger.kernel.org
> Cc: x86@kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

