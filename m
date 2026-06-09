Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A23377560
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024620; cv=none; b=hWxUSnMeCaDur0FgnosS+Qek9FyB68aW5XukFOX7Q9xkpl7feveJQq55DqE+8ePYxunDeA/agAUIrRXEsLqQnO87vfUghzHZx/VA/HPNkg/vEma+QeDgNxkqfwVMpfXH4AiB52IVg1rh83Wr0/iXhYbODsTn2foWR3vhyd2pz3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024620; c=relaxed/simple;
	bh=S+ORIibTBKQ0pFdjGliKCIE3wa/sE73a0IDa+NYkQBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz7LTlQDKa1JqB8vffZ5LJadr0oF9uu8CVJW1LcVxsqydzBHezpd0ra9SnjjgDB0smwLBSdlvXjc/xe4mbf9aWzzzwjN4yKhJYeBqpciU7mF8D84r4TNygJuSqqKFetzQH+t023M3vjhlvKlrnvnKVmQiCVcdrnMl7ZgemfRLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=goprdiZZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="goprdiZZ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf2911f93cso460305ad.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781024619; x=1781629419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2CN/F+xLRpEvDTUPWxMr6FI2U9i+V7+WZC6JlOTISM=;
        b=goprdiZZacls0vpxuCZI/C3imIKQCZxDsxSwmmNMAO1/IRwa/zotmua7eKwwgOUsLP
         kmtZPj0IT+YpFU2J2UbxzRgR1l+XFO2Ct9/O/pQ2vwEIU+MH9mzqOr8xc2eBbamMiFgq
         RPMFXMBPjHxDI/gOjMgG4jW8w1ElMAJiQHPFpgDFYyqr4vfzI+L4dEMVYsMEyxNwpdTq
         5xv6GWOokuvziD4DSJj9vIYdDPxN6zsg/QOwKyWVkQkyZPlHP1KieqNs+spg1Imt51Ap
         YIrkLAIWSykAFdQYD42f3uJqo2ID8LsVxSr/PTx2adbBUvHGLgrK9aQDecyQ5r3tnZcK
         rnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024619; x=1781629419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2CN/F+xLRpEvDTUPWxMr6FI2U9i+V7+WZC6JlOTISM=;
        b=FlnBYoKcVJblNmzm3Ek7p7jkVFxYBmQO6oOGGnrrNYEFLe3bk09nJ4onB3bmoVLl+L
         /5OKZn2y9Snb+EXH5SXjht/WX+EPebs21mpk5w1L/ROuD3pqtwpgWndzynRa3UY4EIiz
         XJw92/4R/IplGYC8TA+8t5Po1eDYaTsYhu3ZBS9jvlYHn9w5veazyou9C0qFb2pTHhWR
         Etts2wU9VmXO80t25ZXF2t9WkZk/NvWk/KmIo7InP30HOQFvP8pKbZHBoWSRL69T3h87
         XOFrXMAcE5J8QGYdmOeUNlJjwMy1nWOlNlMe9umxgRcgFD5Tf4fnjQOr/9fQ/rpVZKZd
         0n2w==
X-Forwarded-Encrypted: i=1; AFNElJ+wb8gMsy28AfxDKsNxwQDQ3SZvJEpb+mL1FhWn7mdH7/JxOa+dU8usWl5dOZ8QutvfHmPa2W0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7zC4aGelOgXfoyHypqXu4bn6fFGpuUmjr2Zpi4VCu8+mtLZEd
	clZ6PzpnI9yBA49yFxrkWv7tH9NoKAQYi+Lgf4TWEL25Vk2Ynz5nLkwl76nfdpMt5A==
X-Gm-Gg: Acq92OE2f0A9kWDz0L7OGRFvozJ5KeGGIz5CqnNT6xdltktwbSrtTlPJ3LIUBTWAqCj
	TGzhyKnZpv5w0QJFHBnEcscvpTKQCjlOElNLxOm8baqX9XQyDOAT9wo86FsBmqrXHsl0rltlOhf
	XyO2SgdBgFuBicvQb5S5t9KP9TAjbNBlnimomxOhilmX43RTGY/HQU2TRGtpXhgc07YbK6lEpUj
	gpliDYnctHLXU6ov3HCT/nXRo5zZ+eKyrCUVSMtB0vmLfbUcgEpR4bD0U5M/JVRVFQr5Da/lfKn
	5SW4OUgLltpnewBpRfC7lJvMOWPvGW2lIZSkBG/efWblvPl4cNb3fogtU28FDi8hqNPsLZBGlcL
	JhZYuaMlhlLI/FqbttHp3aJEV70BaXyIvNOyLYAg22TRnbXaj8UOgS22QCtXgOuA8nWbqyO6Zsd
	VeuYnrtB6WNe1HOX9JPSy91+U3T940Ms+Pw2tvQnuEU+92s6PrDEc6AuUa604Jr4+ZIEk7xdZhQ
	bpysINQqBW9Vzc60StDJNv5I2NIRA==
X-Received: by 2002:a17:903:3d10:b0:2bd:6dad:3dfa with SMTP id d9443c01a7336-2c1eb9443abmr8784635ad.24.1781024618140;
        Tue, 09 Jun 2026 10:03:38 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86151154a8sm10528937a12.22.2026.06.09.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:03:37 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:03:34 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leonro@nvidia.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Lord <mlord@pobox.com>, patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH rc] iommu/dma: Do not try to iommu_map a 0 length region
 in swiotlb
Message-ID: <aihHRieLr9oEaNEK@google.com>
References: <0-v1-8536728bc89f+469-swiotlb_warn_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0-v1-8536728bc89f+469-swiotlb_warn_jgg@nvidia.com>

On Mon, Jun 08, 2026 at 03:10:04PM -0300, Jason Gunthorpe wrote:
>iommu_dma_iova_link_swiotlb() processes a mapping that is unaligned in three
>parts, the head, middle and trailer. If the middle is empty because there
>are no aligned pages it will call down to iommu_map() with a 0 size
>which the iommupt implementation will fail as illegal.
>
>It then tries to do an error unwind and starts from the wrong spot
>corrupting the mapping so the eventual destruction triggers a WARN_ON.
>
>Check for 0 length and avoid mapping and use offset not 0 as the starting
>point to unlink.
>
>This is frequently triggered by using some kinds of thunderbolt NVMe
>drives that trigger forced SWIOTLB for unaligned memory. NVMe seems to
>pass in oddly aligned buffers for the passthrough commands from smartctl
>that hit this condition.
>
>Cc: stable@vger.kernel.org
>Fixes: 433a76207dcf ("dma-mapping: Implement link/unlink ranges API")
>Reported-by: Mark Lord <mlord@pobox.com>
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/dma-iommu.c | 19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)
>
>This was discovered because iommupt errors on mapping length=0 instead of
>making it a NOP, so it is an became an issue since commit d6c65b0fd621
>("iommupt: Avoid rewalking during map") making it a regression this merge
>window.
>
>diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>index 54d96e847f161b..381b60d9e7ceaf 100644
>--- a/drivers/iommu/dma-iommu.c
>+++ b/drivers/iommu/dma-iommu.c
>@@ -1918,12 +1918,18 @@ static int iommu_dma_iova_link_swiotlb(struct device *dev,
> 			return 0;
> 	}
>
>+	/*
>+	 * After removing the partial head and tail, there may be no aligned
>+	 * middle left to map.  The tail still gets bounced below.
>+	 */
> 	size -= iova_end_pad;
>-	error = __dma_iova_link(dev, addr + mapped, phys + mapped, size, dir,
>-			attrs);
>-	if (error)
>-		goto out_unmap;
>-	mapped += size;
>+	if (size) {
>+		error = __dma_iova_link(dev, addr + mapped, phys + mapped,
>+				size, dir, attrs);
>+		if (error)
>+			goto out_unmap;
>+		mapped += size;
>+	}
>
> 	if (iova_end_pad) {
> 		error = iommu_dma_iova_bounce_and_link(dev, addr + mapped,
>@@ -1936,7 +1942,8 @@ static int iommu_dma_iova_link_swiotlb(struct device *dev,
> 	return 0;
>
> out_unmap:
>-	dma_iova_unlink(dev, state, 0, mapped, dir, attrs);
>+	if (mapped)
>+		dma_iova_unlink(dev, state, offset, mapped, dir, attrs);
> 	return error;
> }
>
>
>base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
>-- 
>2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
