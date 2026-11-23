Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429905;
	b=JjoIbyYTM+ICRzKJ+RSN7ZhJ+qjLzTZPHqGl9j4xwASw6iPIO4cMqNGantutWI+g50t9
	 b4wWK4YgK3bCtwJkSMrKewnjWEZlukknizycyUzRWwHiew+HLzeu+TrWdOUWaZ/YHYIw3
	 9Z9eOV19x5tpJyB2cNb0Nw2iGCt4z9Rw18FO94ka15TmEeUec8lmm3bczoFAjRbpupaFU
	 +zb5dLaxRlgZPcdHEgKRpr4jwdOYqITuMxLPE0HTSjw3BofRjEIPGHV4BY50Gu2m/2Z7e
	 aI1f3n9elt+r6xK0Zc2PNnEw90ptOZ19KOpvPGLCnDQQpXruBNU9PYx5FcAScRb318w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429905;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kWwm2LO8jLAywfexdnKv+KQglI5Zy5I2r2hAxvVQ9Uc=;
	b=AOlyqvZYDaxIf+kBex0NPmhkf61uNobdHvwbV9fq46TVkuFDWGMeoWWGCjLJ3hEEHQaF
	 zi2+aC7VxLGSFAgQUbQtpNPItdmMuP/If3RkPVckT/2e0jRXLslrzUekQgO74YVMH9Utu
	 oqhJMbvbtJZ7DDvuiCsGTs+RDLpWtLsOWTRDlTL0y2C3Pbr5josyDqMb41EDqcYA8WCCw
	 Fs3PLGvLr4ZcF1J4dKG1rO8Cg+WqIG8w/DrqzhNgKGqQbDiWtjF8Em+WQhRlXJ375B33f
	 u7vhPL0jVW3sRcmNq7jEv2PC1a1v0j5sOd7AlhQ+adVd+6z95Hd7/v0rwUH5o7vRlCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749C8606A31A;
	Mon, 23 Nov 2026 10:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 749C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9F5482436B3;
	Mon, 23 Nov 2026 11:31:44 +0100 (CET)
Date: Mon, 23 Nov 2026 11:31:43 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: aiyengar1990@gmail.com
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu/vsi: Fix the domain locking and a probe leak
Message-ID: <awQWAaaqvPe-gN01@8bytes.org>
References: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>

On Sat, Nov 14, 2026 at 12:14:24AM +0000, Arun Iyengar via B4 Relay wrote:
> Arun Iyengar (3):
>       iommu/vsi: Don't use the identity domain as a paging domain
>       iommu/vsi: Unlink the IOMMU from its old domain under that domain's lock
>       iommu/vsi: Unprepare the clocks when getting the IRQ fails

Applied, thanks.
