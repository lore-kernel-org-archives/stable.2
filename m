Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCDC1DE894;
	Thu,  9 Jul 2026 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602448; cv=none; b=lG5nMyqhOF5D6ybK6ZZPWnuOAeCHetiJtOzyEIYKBHpj5KikZYWOp35i2g6efMZiJuSy+4bRtzQHtGeKbKYpdq9QtQyQ0EVPyzoU9aAco/04YgDnJPH4pVR3uJzGO+eIReycEuTy4DTI/kYApEIw/C1JkxEhXCBItdGGlTrX6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602448; c=relaxed/simple;
	bh=v6wGCAJ+OjIEmrlQX6g4/fsLs9G2nvAmX69ExwtwMjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+vFsWVphVXEyZfZ6YyLiMM2ToTsEvr1pMPcMbAOB1UBIolcO7J4VucbwjknhAYXCy3Rxa8OUP8uG2FT8h5w99JXTea0m5zVrLKXAYwkDcC1itWBYT0MHW3W6TUNYuJN0b4OGakxTtfAp6Q9fGmiubaJs9hiUe2ufI3ds/T441w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O8+/xFBP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O8+/xFBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E391F000E9;
	Thu,  9 Jul 2026 13:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783602446;
	bh=8WW2suDc45jup1BOs8EMK1QW5Oz+r1eQvcIaoKjWMPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O8+/xFBPkIJDN5R2fVxmbOXNjSlOburat+QvNk+j8YbdRp8cRDNr01292CvubMM4h
	 iPiF/wfMijr4cqbObhP0hpbcHYr+vY2pEb+zNQ+zvkyzxgtIg3S8i6cbHdqFAuQ/tg
	 vpfkVN6bqe2bLCWmzkq8zdQZnUr4u8buVTTNtOz4=
Date: Thu, 9 Jul 2026 15:07:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH 6.18 4/4] slab: recognize @GFP parameter as optional in
 kernel-doc
Message-ID: <2026070910-crisped-crewman-25ab@gregkh>
References: <20260709043301.142931-1-ebiggers@kernel.org>
 <20260709043301.142931-5-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709043301.142931-5-ebiggers@kernel.org>

On Thu, Jul 09, 2026 at 12:33:01AM -0400, Eric Biggers wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> commit 7b5f5865fb11e60edd03c5e063e2d228b7062317 upstream.
> 
> Since the @GFP parameter in kmalloc_obj() etc. is now optional, change
> the kernel-doc to indicate that it is optional. This avoids kernel-doc
> warnings:
> 
> WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' description in 'kmalloc_obj'
> WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' description in 'kmalloc_objs'
> WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' description in 'kmalloc_flex'
> 
> Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in the new *alloc_obj() helpers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
> Link: https://patch.msgid.link/20260617163125.2716279-1-rdunlap@infradead.org
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  include/linux/slab.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Also added to 7.1.y to keep in sync, thanks!

greg k-h
