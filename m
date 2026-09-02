Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4947FB1C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350926; cv=none; b=UiLZFIOhqkcOylIhVH/rp4E43fGOdLxPwHHkvCxcVAyDbTVyaFWO5NLxbfkiGCL2Hs37KKlXVXm2HCHHTBRGYwQWxR8U/j9IEswbfx032z+cgL+yz/zu82K/86lgnDeXUhzilcnz1PtBk8rren7mVBbKX+QiZv7I/sD7oUBfkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350926; c=relaxed/simple;
	bh=hEgKcI0xSVAo+OQaZ6TD8YxlJUNtrHvb4B26iG5AXFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu+zMtbsMLEll2DAXYLwpOMTN+gd16PDbDxqkcaBeE305Tb5fxD+uznHXoac2OLwpYH0Ophfs8jsHLDaET8K44U7nGGR3e5/bg1bWk7k6sNTHnXv2eK9YcoR5sOVYBN1ZPd2tWDq4+643ErzVMu4zVo4xTIKCdF47GR/H4cQqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P3PRkCXN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P3PRkCXN"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c08df8513so6256361cf.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788350914; x=1788955714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=puJ4uTbfv83ic1yzfkUg8CloAoVj8WRg32Yh9dx02hk=;
        b=P3PRkCXNGcr5WbRgqSiwi7FWYnQgwhkSK8l+Nz4c3Ak6A0GJtbObjN7ZGh4Fzy7Yum
         g2c6mnKHpQS7MXhGzBtgo2LCFO9VNtXDHJ1B6uf3mXH8vv2Vd3z71rhMJ3YD+Wl5xTxp
         bxCtq89JVHhq0jhl3b7JdhZkUDspxHJoIhMCQW2yzTkxUl9Cbyx7Zc8CTM8kUstZOwgC
         LH+/UgS5PabchPBRtozJe0aO7NzMGwYEFmgbYWR6CJ2oXigtspnsHpmtIENaxKPfTUQp
         Zgu76ZiRHpm9ITQna5WEztz6HVVxDacrw8ZjBkJWMq4M5CwdYFSFkKIQAABtNYombU8l
         mkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788350914; x=1788955714;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puJ4uTbfv83ic1yzfkUg8CloAoVj8WRg32Yh9dx02hk=;
        b=frn8iQEZlCiyyz0a5b+yjIM3qwCCSNqhjmIK84h++pQi58RxHznCnl1HATW3//lOnB
         fa1GcuO64nhRnq/0mmpFoTO5yiq7v+pEdMkEt9/N+8cbt9YFnchwD4i1cd1HrTVZKoN/
         3LM+desnuVx2xeQm365dFw3NeJTB7vKl6qPjPeRDZjZDquNMCNzQCMTswx8dL3UCKcrf
         v7/ZnTCKEArg/zf5faQ+3stCIrg2jtJm73tzuotz1mByVHu7VTLrc/+2g+QKXJ13uruy
         Ae6GaHpLdm8skhPmP+CeIkuH4Smu30xgroFUv8B7VEzDkOpyliNvcB7B1vcgeQagddi+
         xY7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqTBpjWyluHRViX6DBAi2qTPe3iptwCtI8Ym5rhXE2uINF/1WIUqdQvLAuFQHASh4za2jpPXWc=@vger.kernel.org
X-Gm-Message-State: AFuF++mChY/dlew6njJ1bSwXb+soPRATkmrKQr2mJQBq3vcUktkvcjXY
	rqKZRLC2TajIVywgqyyKnDv/AyzlK6HosjMZRL0YS3UMe2u9rJb2EeAuXbscYyJ+Urg=
X-Gm-Gg: AR+sD11XHM96Q1/W9y62uO3EhqsZaIsyftkpquMG531BuVRjNQtr9xQHpcGHby9mKZ7
	al1ugkhO1hUxBAGnfcc7o1c5qWHEWcln7/D3Z/KngpZF/WiwHkjotZtk9po59/un7aBxf+VTI9V
	TvTrGXGM2CCVFaRWoyTn0h0NRnFlFrzxvzFFdFMVnRUG9YyF3ROpeSubk+8GccqDd2N0J27dwto
	GzAjWOq5FjYYeUJZQMd785s0Yk27hNPyt+YE6GEJouDYSXlJmPeufCEp6mvgs1iqOf7TrU3zdBv
	lnKYGXMYLjIf0I4wDyk+KRC8i/IG/jPzArJSjL8hYCpvZ0YBkHt1NSY5g7K+u4/+JWDtsXJ/CET
	T9Cv2ituZdNO9iax6OAnFvgeSM7/CMJDjyEvSLemUymqbca1iVA+7YHEqaUe4/WX+kKMlTXz0ok
	MSTBKTpJIO/xQKcwtnHB6dG0vgkhl59Ijr1RHZ6DGWi9YVIgFyAbs1Qr1JfgL1XvkAkdru3mzna
	39v93hNj9DDQ5sH/AMJzDcqiWS6cRP5j6KXm82zPv1KkGcnwry9ThLD
X-Received: by 2002:a05:622a:1452:b0:52d:9c11:8937 with SMTP id d75a77b69052e-53036cc0d8amr38235061cf.26.1788350913894;
        Wed, 02 Sep 2026 05:08:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff4e90sm17442101cf.2.2026.09.02.05.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:08:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x1jlY-0000000E9vh-1aE2;
	Wed, 02 Sep 2026 09:08:32 -0300
Date: Wed, 2 Sep 2026 09:08:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hu <dhu@x6u.co>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, alex@shazbot.org,
	ankita@nvidia.com, chriscli@google.com,
	david.laight.linux@gmail.com, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, jmoroni@google.com, kevin.tian@intel.com,
	kpberry@google.com, leon@kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	nicolinc@nvidia.com, praan@google.com, sashiko-bot@kernel.org,
	stable@vger.kernel.org, viursachi@google.com, xuehaohu@google.com,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260902120832.GB2890729@ziepe.ca>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <20260901170849.4052816-3-dhu@x6u.co>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901170849.4052816-3-dhu@x6u.co>

On Tue, Sep 01, 2026 at 05:08:49PM +0000, David Hu wrote:
> From: David Hu <xuehaohu@google.com>
> 
> Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> first entry, resulting in non-page-aligned DMA addresses for all
> subsequent entries.

This patch is fine, but pedenatically a scatterlist's entry limit
should be bounded to dma_get_max_seg_size(), though I don't think it
helps this. Operating scatterlists at the size limits has proven
problematic in a number of places already...

> In addition, a non-page-aligned sgl length will trigger an edge case
> in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
> buffers, we will have a `va` with lowest bit set to 1. That will lead
> to `ib_umem_find_best_pgsz()` always return 0, and break the promise
> to find best page size for the mapping on the NIC side.

That's an IB side bug, the newer logic that joins adjacent SGLs should
have avoided it?

Jason
