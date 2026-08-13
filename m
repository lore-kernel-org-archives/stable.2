Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3747DD63
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628061; cv=none; b=PCuB5D/P6+1yxDIGyUPFhtxUsTnzpd5zmwbyJbnk82eHfXuDIODwPs+NiljCUcW0GwcMF8Uo3+0H1rpmwhJcwqR7rXbg7TiuchDp+96Y+X4Nhhc8zkYSqOgFQJgrIQfEdCcV+cTU9Rlj+jP/t56H8+ipXIgNUnhTfk3uum+TYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628061; c=relaxed/simple;
	bh=OcEezsanPwyYtHJiGOZFG+K3KM7vvhSN97luIVPI1Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIqt8dORUr1iD68nHA4mGyCX1eLPM+k2Cp97L1FwokW7FA+Bvnx+suEbE+8Rulns9cgS1T+PF96VB1AS108fj5nbgt+PXRq8/nq6bhOg8EBlc5JzcPvVBNv8j31zRAE3R4nhC1ZBsb+QUDA1AqwWYuOOFazUDKzE87pJIcZYC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CcjQFiP0; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CcjQFiP0"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8efcef23d21so12700896d6.2
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786628057; x=1787232857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b7FsOVpsR2u+8zsOB4pxP+7DxIyGo4TmTgnx74/xvuo=;
        b=CcjQFiP0ctTj0Le2Ky8m6tyQQqz01JPLLWNocwgNl4gLqqqfEgww/MR21xUeoijZXk
         4p/FO56zAe/dL4giGgvD0YAe+r1BXIOaJQGtiiMbU04Rpm+4e2FDKm4oZlaO3A7ECfD4
         FuYlPDfMTXWj7EZj8Lwmtl+3MhNXGPjhMuajuRd3EilDvaBnASsNfWyOxAM8h0/vET8Y
         pBaVdf1nGyaj54If4XHck++6BFpnKnyxysS6aVJHVTy6oPws0u30L2YdZDUc0V8KuH86
         1ov4gX0PId7yRqdgl8G0aTOUM4mx1sS/ZB4mRG+ufQNeMOh8xTWV1FGkOfTiwurZaYOs
         S0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628057; x=1787232857;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b7FsOVpsR2u+8zsOB4pxP+7DxIyGo4TmTgnx74/xvuo=;
        b=juVNSUG7ksU09ObbCUAp+ZNl6vzoER27NVqefFD+4GOISP1PkrYHg1QY/GbnTpgkbJ
         ++rbB6bI8dbtwraW/Wo8PlpEw5uBxY5QxA0faLnbwivrdEdSeqiTrwoxCjIWLnj0Ka0Z
         cqUjZTw3RwAiR2M5dxRnLcd4I2pw7fRUsMa5ZKDJaQ2VhEU0nQm/wMjybDFUi7tJGJ8o
         p6HXxgNudg5soo4X0978oSf15Z6HwRTs/7sZqOrUTdobvw1gWGvsPyXvFLmaLUhPmO1Q
         yGpPYWV2XGGfa+5YFQGxTcTHgAvNrrnTRNKx1BgzypmfWavkqkld0zQ4g4NCaWh0/V6e
         oJXw==
X-Forwarded-Encrypted: i=1; AHgh+RqXJOGxzPvQZ8U+MlMdZe1icyISdVVNWlFSuUuDMOLMSUTvQJw5fdVIILkQC2ysX3v9qNa0Hks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWarU6KUEmv3ZVyNKJwJ4MbjpMVF0uC3DLoWsIX1hk5zxoMCWD
	ZVUD30uVp36aKUdxvHuyaZOcMM9pB3KhoSrxO3aqmlCOoCYXtOTOeLq9EOFTPCWmZoo=
X-Gm-Gg: AR+sD13tTVUxFtBsjlJMNd6AabQHx6vh7eBZVI72Gtw0lTxYWiDpKyxGvrxA/4gLiEr
	5iE1N63L+cq497sYpI132jXDDKkJ6a1CmCV1f8GrpXp4r/sB2BgxMm/cLFJ/9U0bS3nJtx7u4To
	WjkZ9HqRQzcqJzMBAMyni+sdBDGWnHdpIhktuU5xIiqij+0pzYG79tqICPmOVIujLEfdIfZzNdE
	tF+mRSJGRNK51PJV4TQY+xWC0s5skXYGrI7Dw/G1NcQGDzdtvJ0RjkTwZHjPCXyb7fCgOIS5En/
	TUpid5RZgrJlCHtjbO3t/freZSSs1l7OqElvqkCmR4SSrcnHhdwpZ0yKevfFxSw70McT/Pk2q+J
	XqDfRi/f1DUcpOaNjvWJOMntxVoSXHiEPGNcHKIkHLX3bAEKXdxsRB41rOqqLUwR/BIRWK7troP
	oEqpTEJJWEjUvZhvIp8g4ki6D+MuoBvxETT7b6iA==
X-Received: by 2002:a05:6214:5d10:b0:8fb:7e7c:b494 with SMTP id 6a1803df08f44-90a80bdf66fmr57373736d6.26.1786628057084;
        Thu, 13 Aug 2026 06:34:17 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a81aba04bsm14700066d6.44.2026.08.13.06.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:34:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuVZX-00000003nJq-3M6L;
	Thu, 13 Aug 2026 10:34:15 -0300
Date: Thu, 13 Aug 2026 10:34:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Mohammed Almaroof <moh@anthropic.com>,
	Ben Cressey <ben@cressey.dev>
Subject: Re: [PATCH 6.18.y] iommu/vt-d: Gather the unmapped range before
 freeing its page tables
Message-ID: <20260813133415.GK662699@ziepe.ca>
References: <20260813-b4-vtd-unmap-gather-v1-1-4c52f4a7a1ac@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-b4-vtd-unmap-gather-v1-1-4c52f4a7a1ac@linux.dev>

On Thu, Aug 13, 2026 at 12:05:26AM +0000, Jose Fernandez (Anthropic) wrote:
> Under a userspace driver that maps and unmaps DMA buffers through VFIO
> type1 continuously, this shows up as wrong data in device reads and
> writes. An occasional DMAR fault on a mapped IOVA is the only thing in
> the logs. With an Intel DSA engine assigned through vfio-pci, remapping
> a 16 MiB buffer at a fixed IOVA and reading it through the device
> returned data from the wrong pages in 280 of 400 iterations. With a
> fresh IOVA per iteration it never did.
> 
> Add the range to the gather first and splice the freed tables into
> gather->freelist afterwards, so that they are only freed by a sync that
> also invalidates their range.
> 
> Mainline removed this code in v6.19 with commit d373449d8e97
> ("iommu/vt-d: Use the generic iommu page table") and is not affected.

Yeah, I noticed this bug category in iommupt at some point, I didn't
realize there was long existing errors in the drivers.

I don't know what the process is to put a unique patch into stable
(backporting the upstream iommupt based fix is not reasonable), but
this looks correct to me, it follows the pattern iommupt is using and
I have now extensively tested.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
