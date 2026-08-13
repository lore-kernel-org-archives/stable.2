Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB6442FDB;
	Thu, 13 Aug 2026 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611469; cv=none; b=sipgbZI6bHSK0pxqFs8jv12Vj20R/GdtNHs/C+EE4F0Gtb0RqYDDqkKfirJ0FSWIsE5hPI9JpR5hVaTwll6g/yNDnKZ94hRfgMwPylnl52+SdHXy3XS8IWbLoCa6Fb+EG162V5QVtM7CJYyVlUOTjTo2SL+d6szzmJ622l/bC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611469; c=relaxed/simple;
	bh=CS/uFeZNXN1O+lOQ2w4NSPq2ALuka/C4I2LZRJhnRdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsDV/b3aQcTobPWrAiW/dFXOJsd6fGoOYTMXCwP05EWilRF3kOKkfx2N8JJbaKY5miro5P5uu/EegH5bP7uOaQeDwIHOo11ctGx9dhl+KDi9Vhlr9RChS+A58IgijK9mNTFOULqwmfZeUeNoVT3i2kGU5Ss8eJ1tKYchTNH4VD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQU9J7BE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQU9J7BE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C862E1F000E9;
	Thu, 13 Aug 2026 08:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786611467;
	bh=CS/uFeZNXN1O+lOQ2w4NSPq2ALuka/C4I2LZRJhnRdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XQU9J7BEex3WMosE+FwvoP5nSRkBg19PfE5WoUhr6AMneIaF1tAQSjGKnuT1ChOSW
	 7ZkptBhLgO7+hStx/PvVSK9zJCNOJCJEbT11Ehsx0nnLwfvL/9luP3t437TJ3eF8iS
	 5gJ6ZZIiUNppiROaOoKOXRHlSURiV6on64c25KUu/WakdmKzl1C8Y2b/180KBBBFMS
	 OjK7HtIGSEJ49/38v3NnJiGYEc5+tuWSFaBU9ltlEYAkl4+BVAHpzEmnaRpWOyqtYd
	 l521NxcYLpcRvgdifVmul6IYu1FGY5mGoEaCkyF2knRgoYIWaVn/g9hlCLLz9kwER1
	 DqVuRxKVXPiNw==
Date: Thu, 13 Aug 2026 09:57:24 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, David CARLIER <devnexen@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>, 
	Vishal Moola <vishal.moola@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org, 
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <an2GkrW35R5reoeC@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <anCwUb9lV18v6mfN@kernel.org>
 <anXp--mLLEE2Qo0g@lucifer>
 <90c2be6e-fe03-4da9-88d2-fe4d4f745cf2@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c2be6e-fe03-4da9-88d2-fe4d4f745cf2@intel.com>

On Wed, Aug 12, 2026 at 03:20:23PM -0700, Dave Hansen wrote:
> On 8/7/26 07:34, Lorenzo Stoakes (ARM) wrote:
> > In any case - Mike - I think you probably need to respin this on tip
> > x86/mm anyway?
> >
> > Maybe worth doing that and seeing if that makes life a little easier for
> > the x86 folks.
>
> Yes, please. If it interacts with things in there, a rebase would be
> much appreciated.

Thanks, Mike is already working on one I think he should get a rebased respin
out shortly :)

>
> Also, please do send things separately if they are fixing active
> regressions or bugs that folks are hitting in the real world. We'll send
> those urgently and not through the normal tip/x86/mm process.

By separately how do you mean, as individual patches? There are some ordering
requirements here I think, is it OK as a series on that basis?

--
Cheers, Lorenzo
