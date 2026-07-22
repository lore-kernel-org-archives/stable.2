Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791762E2665;
	Wed, 22 Jul 2026 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726689; cv=none; b=D9Re5bMo4IsNKpr+SCI8ss6DgfIdAPPBfSHQFM+BOXiu1UwvNzKd+4vngWGAMDq1K6ayrxMJVqRu/scoyE2BdSBVd0D35xAKGp8hZRksw1pY454X05MNEN0wfGl2h+To0MjleGDVCX98sUenNC6Pgams/S3d3M0dQGb78FQqS+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726689; c=relaxed/simple;
	bh=3Pv/mM9EexH5umZTOWtW4bK0711TlASt4S/BqOifAFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCA+I9RJum02H0Fk+VliABRWIZd8JIYPg+FfaLrGHPWhffFRiU+5Tent6ckO2yoUJ5YFlYm+gFcgz5ZaaabEDNLeGkhs9Bj9mQcb+HGmJu61EeB4rX2azFp7R0WuSFZNqpkhnvZ5PSOZpYyUTtfq6b+vrXQJzZ+8yahS2j6n3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpB1ajNa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpB1ajNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF6C1F000E9;
	Wed, 22 Jul 2026 13:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726688;
	bh=6aDhpdQaHijSq9esch5+WU8dacA002S+0r+30kHtios=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PpB1ajNaE2DYHXFwM/2M8Offi2IW09ORNIXaMj9ZoAp3j2id7U7RQcvGBnJrs/Yjq
	 /r9pCis9WWRf22Y34q74VZ/2Ui0+ScMMOP2J4zVgMtsqSCiGJ7/WotWKZ0np/iDpTk
	 OrCh6Y3kvc7bFRmezmnv1MEfGIm5gcpKV3MZdjqstHZ6r6OpALxlxJ3iwjdLrDpwbk
	 XFf9coYywFWr0KOleLs5xLmaglD4DVDqU9TGwySzfQKC+MDtmokyGqBorLIOHYEKFl
	 54SF+8VI1U5NscpU+rq+wvh6cWFiCa/0uH/ZByDvwRy5tJNyJxGLi/zGMsEDcc7B7O
	 3IVsac2M8Muhw==
Date: Wed, 22 Jul 2026 14:24:42 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, jpb@kernel.org, catalin.marinas@arm.com,
	yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <amDEmlcyC3Tfmkel@willie-the-truck>
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>

On Wed, Jul 01, 2026 at 06:45:17PM +0100, Robin Murphy wrote:
> Since table access flags cannot be software-managed, if process
> pagetables are using HAFT then SVA must require the SMMU to support and
> enable it too, otherwise page aging is liable to get out of whack.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 62df5870ebf7 ("arm64: Enable ARCH_HAS_NONLEAF_PMD_YOUNG")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 +++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 6 ++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 3 +++
>  3 files changed, 14 insertions(+)

This looks ok to *me*, but Sashiko raises two interesting points:

https://sashiko.dev/#/patchset/878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com

1. This may break hitless updates when transitioning to a faulting entry.
2. IORT has HTTU overrides for HA/HD. Does it (will it?) have anything
   for HAFT? At the moment, it looks like you'll trigger a warning
   message.

Given Jason's comments, it's probably worth sending the idreg override
patch as well...

Will
