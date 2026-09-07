Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90935352005;
	Mon,  7 Sep 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797728; cv=none; b=UiHX76uc3nHCqX64FF3+DedNZSLs3F/8weLN77pYCJzV50v5iSJOKHpFabZYOFMdk/LCno85+7hvWq2pu0DdiKrd6THqNKOvEpct4L1YeCAzuWD08M6Nx2zQdluiVPrQbilAunmB+LEEnVO5V3egcaP3H6ukmZjTTI4H2+dEsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797728; c=relaxed/simple;
	bh=3HHTxEmMDrd4mbz2CZq7LOhyZdOeqzcmC/xXR4emUF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6cZPduL1S+dcmdVD768gu5HZ47DtWdEPIAVfyGNhgiZV5v8lwaC9u9tkXCZ7om2gmfJGm8vjyn4NOtR08L/OJotZNSwU0s5nZAhijvveNXhkRWqL+EH8DkDV2KbI45WtLZ+NCEPkIo7adWwBELPTregIBDzu7YLEq47B8y39KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVmLGkdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVmLGkdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8871F00A3A;
	Mon,  7 Sep 2026 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788797727;
	bh=3HHTxEmMDrd4mbz2CZq7LOhyZdOeqzcmC/xXR4emUF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RVmLGkdiqRDy/Qv/2DAiQkxmtVGnTbk9SrBFJA8m7sVJMLS24Ypdg7O4mYULExi1l
	 ApPOtLm8uIeEorzY0nM29nueqklM237uqHI71Ddu6TczR3NxCwCAEa6saFLf9BJnvp
	 kx8OmnL4LKcbmQGHnO7CeBOWbjRfNcwFsbxAeqqExg/3FicAkvHmMXP8DHF1kYRs/R
	 8TNeOwZKxjD4AJlaOeLLE0n5LufydDGO1sK3NfBPuWeT2rpkuyGWAArwW7+IkfseKf
	 vYNGZujXRwUQYfqCcM4ZJhq2UKtsMQH/Tb/vVdHuIq/2uMOwRXSqeeH0IeuUS2voXZ
	 V4oZrKyLNuiow==
Date: Mon, 7 Sep 2026 17:15:20 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Cedric Le Goater <clg@redhat.com>, 
	Saravanan D <saravanand@crusoe.ai>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: bypass THP tuneables for huge pfnmap
 mappings
Message-ID: <ap7i1vLkfZj4rbNM@gremlin>
References: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
 <DL08J4JGJ4UK.2G92WO0NK8XU3@nvidia.com>
 <apEzvfGgsvbc3vBI@gremlin>
 <dc52dd1d-f62d-4278-ab4d-95746383fd50@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc52dd1d-f62d-4278-ab4d-95746383fd50@kernel.org>

On Mon, Sep 07, 2026 at 06:08:31PM +0200, David Hildenbrand (Arm) wrote:
>
> >> 1. is vma_allow_thp_tuneables_file() better? Then all three helpers are
> >> vma + a verb + thp_tuneables_file().
> >
> > That's a good idea! Much better thanks.
> >
> >>
> >> 2. is vma_file_ a better prefix than putting file at the end?
> >
> > Yeah, it's an annoying one as kinda want to say 'file-backed VMA' but I think
> > you're right vma_xxx_file() -> vma_file_xxx() is better.
> >
> > Andrew - could you fix that up in place?
> >
> > Obviously if there's further feedback I can respin as well.
>
> Just as a general note I really hate these in-place updates.
>
> For a reviewer perspective (like me stumbling over this) this is just a mess.
>
> Resending with b4 is as easy as it gets.

Ack, you are right to be honest, and I do empathise obviously.

I will respin these in future!

Let me know if you want me to respin this to make life a bit easier?

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
