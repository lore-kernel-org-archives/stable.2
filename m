Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE625328B7;
	Wed, 14 Oct 2026 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985657; cv=none; b=cq6HaRPH8sDFLHp2CGW8ddb1A7gkrk3JGcYnDUIMnGbRLjTbaKAYrGayzG5b2ruHmq5VRwtssrAyryW8euBqQCVBLG/n35sTy8tKy0MNWc/bADbyMspfJ53x3OFgQHVSfibRW9YIZBUepe5l1PYmohmt/AIzvW8H4Cax+9KVijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985657; c=relaxed/simple;
	bh=kLk9uccwadXxq7XHGk2EaY7CdTlvM4jH7qozkU+Zt1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBbZ75GgVZbQZHmjOpNaW2Bqr83OmY48PaEAqgGqP/2542m69AYjDCDyrYizxqSdX8+YKkKHkndq3AzxB4FZxB5mxTvjB9ILfx2NHFDvRsOz9VPLCz2zAn3smrNMwoEuPB+Ofr5OIoGA2eWDe8kdcSjHWGLrXS3HqH6bMyV+hQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00b07e11c7dacd6f16.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:b07e:11c7:dacd:6f16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D4CBC1C7802;
	Wed, 14 Oct 2026 15:47:30 +0200 (CEST)
Date: Wed, 14 Oct 2026 15:47:29 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>, Ankit Soni <Ankit.Soni@amd.com>, Baoquan He <bhe@redhat.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH v2 0/2] iommu/amd: Fix device table setup in kdump kernels
Message-ID: <as-H4Ln2ew1lQX7Q@8bytes.org>
References: <20261013121944.4060097-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013121944.4060097-1-matt@readmodwrite.com>

On Tue, Oct 13, 2026 at 01:19:42PM +0100, Matt Fleming wrote:
> Matt Fleming (2):
>   iommu/amd: Program device table when kdump reuse fails
>   iommu/amd: Don't allocate kdump device table from DMA32

Applied, thanks.
