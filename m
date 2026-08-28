Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2A3F107F;
	Fri, 28 Aug 2026 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937639; cv=none; b=cs9oFT/sefHKoJYP2KPwQMSsrtQ27E5dH+m3SilT3/Ju/3wsTbeKaxBXy9wgCB5Rs3ZNsw/W/xQGWxVlgM6uZfoXuBVQCPSADO3zAsQhZqgnY7JIcE0riR0a1A1YqFVZ4ZU4WaHFf7WlHAqSxZ3BcTN9P6CDLgpol0nsbIEwfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937639; c=relaxed/simple;
	bh=+JKtfIZXdRMzwUn3du+AXO0BqAitIb9kz0MGQdgCQYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdCH/Hip26Pz5tv0gdCnjY56n9EtDC4g3XUCuFpqNbID7pMsHTPGLNj3EkX1S0iBNchvxnqeUuw6pMAYHerO8qijGCWdeRkxfTy2P0R8aebMAw5uOLdvaSm52+iZNb4ILkC4y/m/GaRJTWSRaK3ic4kzcYP47UNoEm7QWFefu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We1NrLZp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We1NrLZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB271F000E9;
	Fri, 28 Aug 2026 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787937638;
	bh=vEpWbdrotVCakHs/M3xW3vTkrtuo0K6HufK/TXB7tFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=We1NrLZpFnRw3SNelW3DS0SKnGuntUgqP8nU/DBa/LA05Utjgwv0HOXsBcldsKERi
	 AEw7uiElAdJagGqDGuHCTXUbx2SjjOhLCr0Mv7FNYaaW4VWHgvoHE/jpRyDfHWCDAC
	 WUSgGfpTkeDm0qqY2DCMZn3Q6+DtCcFUNON1aM+9VILGBJCNz6jGc8h9xUWa+zeEqM
	 AKeZbnAMgqlLxSb8Ob1D99gYxtwEFjM9r179FT6r1Y9EQPxWNc/USzOXYNlDypD+KV
	 /odd+a6BZWFX4kw29GI4aKNT4gc+KP68X06mnm7mb/7ofpO4RRL4zPtvbFSLeauckq
	 xXsR/IKgPv4hg==
Date: Fri, 28 Aug 2026 18:20:06 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Saravanan D <saravanand@crusoe.ai>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Cedric Le Goater <clg@redhat.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: bypass THP tuneables for huge pfnmap
 mappings
Message-ID: <apHDI2LzF3c6RB_S@lucifer>
References: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
 <20260828164649.77283-1-saravanand@crusoe.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828164649.77283-1-saravanand@crusoe.ai>

On Fri, Aug 28, 2026 at 09:46:49AM -0700, Saravanan D wrote:
> On Thu, Aug 27, 2026 at 08:55:57PM +0100, Lorenzo Stoakes (ARM) wrote:
> > This is incorrect - if a huge PFN map is available (defined by
> > vma->vm_ops->huge_fault being non-NULL for a VMA_PFNMAP_BIT VMA), then it
> > should be mapped huge upon fault-in.
> [...]
> > Correct this by explicitly checking for this while ensuring that smaps
> > continues to accurately report THPeligible statistics.
>
> I backported this to a 6.17 based kernel and tested it under
> cloud-hypervisor with THP left at the Ubuntu default of madvise, on
> two GPU generations:
>
>   - 4x H100, 128 GiB BAR1 each
>   - 8x B300, 512 GiB BAR1 each
>
> With the patch every BAR faults in entirely at PUD (1 GiB)
> granularity, one entry per GiB of BAR, so 128 for each H100 BAR and
> 512 for each B300 BAR, and smaps reports THPeligible: 1 for every
> vfio-device VMA. Total time in the huge_fault path was 4.5 ms on the
> H100 node and 130 ms on the B300 node, and the VMs booted in 11.6s
> and 32s respectively.
>
> Tested-by: Saravanan D <saravanand@crusoe.ai>

Thanks! Appreciate the testing :) and glad this helps your usecase.

--
Cheers, Lorenzo
