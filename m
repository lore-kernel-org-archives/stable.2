Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A6369D54;
	Thu,  3 Sep 2026 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414594; cv=none; b=J9e5FOzypCKcKzcwRrj5UFtzHHquLBSZIPsuKYKHOi9s2Cm1v/ALnjVpMPFajwxEUyuTq7IAX93847KQZU7+yKCru4ypra8LZQLjIrb1EYw/fpW+TQPwT4e7YETBD0idupkbJLL6pqefDrVxtU8jGODOfOG8zOEpT47Lh997n6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414594; c=relaxed/simple;
	bh=zxUxLclfdWQEsHuRLtYixdTvMh66TthoGEGT/o5Yk/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wzc0TSChdQBsBT9hYFFhjYomlxEbNrPo5tHZa62UMd+a7tFPxm+Ud9cHUG8ZOXcuOXU4x7Xr1+1S72D7yhc3SWQjhGF9BGirB4C0X/+yp1BcHcJqXyKDPxtZ3hilqhdM+2+9Bt03dp63PNvzlNDSdNNI84wq0RLgbGSkIoTf/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 665786732A; Thu,  3 Sep 2026 07:49:49 +0200 (CEST)
Date: Thu, 3 Sep 2026 07:49:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] xor: add missing vzeroupper to AVX code
Message-ID: <20260903054949.GA16883@lst.de>
References: <20260831212248.213805-1-ebiggers@kernel.org> <20260902133706.GA21538@lst.de> <20260902162359.GA2497@quark>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902162359.GA2497@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Sep 02, 2026 at 09:23:59AM -0700, Eric Biggers wrote:
> > 
> > Can we do kernel_avx_{begin,end} instead of having to open code
> > and document this everywhere, please?
> 
> Again, there are cases in the kernel where both AVX and SSE are used
> within a single kernel-mode FPU section, or where a CPU feature check
> occurs within the section and one or the other is used.  So that
> abstraction will not work as-is,

So don't use it for that one case (which I've seen, but make it two or
three and the same still applies), and everyone else gets to use the
easy case.

> and it would be different from all
> userspace code as well.

I don't know how you defined "all".  Almost no userspace code has
kernel_fpu_{begin,end} to start with.  The one code base I've recently
ported to the kernel that has it, also has kernel_avx_{begin,end}
already.

