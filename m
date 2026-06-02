Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F13D0BF3;
	Tue,  2 Jun 2026 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395917; cv=none; b=BUTwPUWOg6xVWTsS5PHTwNM5j4dSoiQgKWzteD/eKwxFUIB7henZP68DMcLqQgpmvkq0Dmt+5lAbgDQnUN5NZX1qytBUOn/wUtPwwcuxEclRhuJFpoRGNGv17YiEyjgYEdUShFw4zlN6tT+h4d1m0RStWsc37aHpLsdjYKoa+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395917; c=relaxed/simple;
	bh=BUZ6l3xZ0P1H+mzazYoO94kEUui2SHGzBWm8iIXhYys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDsGMnIBxe+hRmRDnvyspWTM3pzEJ/ayRactwXpT4o0gpADe2KEpf5aKa2Vb/qVIOTiIJbI43cq8q4eIHuT4wk73KUOiyEdo0mLMMwxL/m0Bd7hhGLARr+HXuZrw/zUaA7/L+VKGsiAxzPy8CiMzIFLBEAloJHL71orWWcdaYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaE2y1B9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaE2y1B9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8761F00893;
	Tue,  2 Jun 2026 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395916;
	bh=ujYRedhk5lwMgFqV8/GJR30PtxWyUV4s3ZYme0N6EKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VaE2y1B9bNcNJz9ygk1tsvahF/A9NwlIdtilgqw3HNl3s6OCq4NeFGSCkPstpjy9l
	 TJZd7CMWDPU8AL9wv3CiUwvS4ceuH6QCe2vYxCRFY5VjSWI4qnzER0h221cUtYuXiE
	 5TQzdE6xAVDTa3SEb5XlA2cyIIaeVAT6nIsoO/p8G8iWZu20KUd8Qig2dg5QAvZpR9
	 7rn43/EdyDhN+kGlNCFCpRF7Z7rq04vgwwST7vzHqkFnQNxyqls52tD/1SvBqdM+0k
	 wLDM5Xkrt5uPZC/YwBiJ7NvKHYHOCjwC6UL8WwYSJ52Dc8emF/urX9i0fZ1GxoIOT7
	 VsKiVnZPlw/8Q==
Date: Tue, 2 Jun 2026 11:25:11 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	robin.clark@oss.qualcomm.com, joro@8bytes.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu: pass smmu->dev to report_iommu_fault
Message-ID: <ah6vhy58ztNm0Nlt@willie-the-truck>
References: <20260517005052.3783378-1-shyamsaini@linux.microsoft.com>
 <83e27ae0-870e-4bfe-806d-2c2f21a719df@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e27ae0-870e-4bfe-806d-2c2f21a719df@arm.com>

On Mon, May 18, 2026 at 06:00:14PM +0100, Robin Murphy wrote:
> On 17/05/2026 1:50 am, Shyam Saini wrote:
> > report_iommu_fault() passes the dev argument to trace_io_page_fault(),
> > which dereferences it via dev_name() and dev_driver_string(). Passing
> > NULL causes a kernel crash when the io_page_fault tracepoint is
> > enabled.
> > 
> > In arm-smmu.c, 'commit f8f934c180f6 ("iommu/arm-smmu: Add support for driver IOMMU fault handlers")'
> > replaced a dev_err_ratelimited() call that correctly used smmu->dev with
> 
> I'm not sure it was really correct - it's pretty clear that "dev" is
> intended to be the client device that _caused_ the fault, since why would it
> make any sense to pass the IOMMU device to some other driver/subsystem's
> fault handler? (Yes, other IOMMU drivers already do that; I would consider
> them just as wrong too).
> 
> IMO it would seem more robust to just fix the tracepoint to handle a NULL
> "dev" in the case that one can't (easily) be identified.

Yeah, I agree. Passing the SMMU device just because it's the only thing
we have is just a bodge around the NULL dereference. We'd be better off
hacking include/trace/events/iommu.h to print placeholder "(NULL)"
entries when the device pointer is NULL.

Will
