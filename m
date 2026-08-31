Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37282DFA4A;
	Mon, 31 Aug 2026 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155798; cv=none; b=Nof6lWAnC5bplFusIK8lB8P4pWich4eftGSzgHzIRcZnD93OiRvKheHq8UznEPshajw1+nEYC0+ISdEIqFFj2z7PWkJG33IWzD0ik4YaveIKAQI6Oy5x3gtCL4GS0QB26sjMCaTIrOnI1RFXXlgjs1mriKotX2w1CX25a6/09/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155798; c=relaxed/simple;
	bh=bin9NXtJWi57hDxQlBrqsEg8GSI/8APYeOg7QtDU4co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oO2B8cY8/LRgDNMBhT6crmwTt5U3gy1pHfaVjsxlc4isFjRqGb5cL1dO1PZoj6O66l9+KttV4Q+jDAusrdQ59Z737JYdtCjbNcRAkTUYP8KSTfC1Cjoicn/sSJ/newzAOLfmN71U2EFraWjvphjjIPWPOm7E/BtF2CogC5jAsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NEvzNMbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NEvzNMbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1A71F000E9;
	Mon, 31 Aug 2026 05:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788155797;
	bh=USN4d79UJ49yqpib476gxNiB1WI2UqXv3xsLWvCnIjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NEvzNMbTQZQ5Z9PWIZ/1dcKiKGFUWwSwk71T1wKJoGGDj+fy3Hk8LCrIITmovC2Lp
	 yQXubfXW37fNJsD4U2mL46KIc09MBNvfgaifm3uxHopJMVVZRCyF8opS/ZiwY4184p
	 ZxLZPuWaw7rZEQa1Q04D/b3aQ3GgjPduTrwbaKFU=
Date: Mon, 31 Aug 2026 07:54:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] arm64: mm: clear extra idmap level before use
Message-ID: <2026083125-upbeat-series-9565@gregkh>
References: <20260831054247.33352-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831054247.33352-1-kmehltretter@gmail.com>

On Mon, Aug 31, 2026 at 07:42:47AM +0200, Karl Mehltretter wrote:
> The 6.6.y adaptation of commit 0e9df1c905d8 ("arm64: mm: Don't remap
> pgtables for allocate vs populate") removes the clearing performed by
> early_pgtable_alloc().  Its replacement clears allocations made by the
> generic page-table walkers, but 6.6's create_idmap() still allocates an
> extra root level directly when a sub-48-bit VA kernel is loaded
> sufficiently high in physical memory.
> 
> memblock_phys_alloc_range() does not zero the returned memory.  The direct
> caller therefore publishes an uncleared root page and passes it to
> __create_pgd_mapping().  A stale nonzero entry can trip the bad-descriptor
> BUG_ON or be followed as a page-table descriptor, preventing the kernel
> from booting.
> 
> Clear the direct allocation through its linear alias before publishing it.
> init_clear_pgtable() also supplies the barrier required before the table
> descriptor becomes visible.
> 
> Mainline is not affected because commit e6128a8e523c ("arm64: mm: Use
> 48-bit virtual addressing for the permanent ID map") removed the dynamic
> extra level before page-table initialization moved out of the allocator.

Why can't we take that change instead?

> 
> Fixes: 54322d95309d ("arm64: mm: Don't remap pgtables for allocate vs populate")

No signed-off-by?

thanks,

greg k-h
