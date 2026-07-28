Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2542BEC27;
	Tue, 28 Jul 2026 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250004; cv=none; b=MC/++84z/loT06V1kLki7LtWJRArsDVMqMEeJIT6zfiziFccCMwOG/lBFBZoTrVJJxHdr4cGYFriio5z1vPQMMQfpmTi5owK3BteuZ1xDmsJwLySyOf69DWMFd+QieVNIPYOLIV8fcJ+07L0htKUutpjTSSt58e+2NZPYdWT+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250004; c=relaxed/simple;
	bh=O6TzO3WCmWfJbSDCufatOXOyugJ1dH3fpBukvM6eJq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXH60wiJVJGxnlz8SSlG5LbBRItd+w1xPh19H2tE2v2DrpoNim2bH/udTIVC1v4ns700Oq+mPtVJRxwA6AtpmhM6OnMzN4eqePC0cE+5TBcHZgKyMhAkhV8G7wQqigTnO2GY2uRk0tTsY21SkAcjk00d/RygLL5oPw4BKll7Qgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcLhbjoi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcLhbjoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB901F000E9;
	Tue, 28 Jul 2026 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785250002;
	bh=OHMN8cA8fITPlPJWm1+s1dgIvNUxrIp2dw8vHkotxoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IcLhbjoifecXqh6wJXtKrMKtUKA7SHBfbvqA+CIeIbTdnLpLzptuCxCC2vw2VlrHG
	 yPtd1sj5tRxEBE2k3LKb2mnZfdeVzetU0cKtHmQHwAq2NTGvUBLsrfk9hE4MpGsZxu
	 jErf6p5eZT+qPe9vZo/c6m5IsiEFu8tUlStFHa4yZYfXl+elMs/hPhcERHRIUeVIte
	 Jz7P4a3kTkkEn3Ok81eal3HUI+qmg1EZ4mjrMm7Qa2p+6/JE0GVKrFRTUYORDWuL/I
	 a9OfJ0A5++kgn5ZPHOv0DMq5A2UAR4Hl7KamuopGcI/0TyF6d2017I+PmJUeQ8qGBN
	 qbNWfIrlAef+Q==
Date: Tue, 28 Jul 2026 17:46:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	David CARLIER <devnexen@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/5] x86/mm/pat: introcude cpa_lock() and cpa_unlock()
Message-ID: <amjAxhL-IeeJITEv@kernel.org>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <20260728-cpa-fixes-v1-1-2ed2352300b3@kernel.org>
 <20260728142108.GW751831@noisy.programming.kicks-ass.net>
 <adfffb36-9943-4af7-a0ee-0e762e47fa11@intel.com>
 <20260728143135.GG651302@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728143135.GG651302@noisy.programming.kicks-ass.net>

On Tue, Jul 28, 2026 at 04:31:35PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 28, 2026 at 07:30:27AM -0700, Dave Hansen wrote:
> > On 7/28/26 07:21, Peter Zijlstra wrote:
> > > There was already a patch merged that removed the shole debug_pagealloc
> > > exception. Is that not better?
> > 
> > As I'm scanning through email this morning, there's another issue that
> > popped up with that patch. It's causing hangs on boot.
> > 
> > It's looking like debug pagealloc not taking the lock is actually
> > functional, not an optimization. Although, I hesitate to say
> > "functional" and would prefer to use much less nice words to describe it.
> 
> Yeah, lets figure out why that is before we retain this wart ;-)

As Lorenzo said:

  __kernel_map_pages() can be called from irq context:

  < GFP_ATOMIC context >
  kfree() or whatever
  -> ...
  -> __free_pages_prepare()
  -> debug_pagealloc_unmap_pages()
  -> __kernel_map_pages()
  -> __change_page_attr_set_clr()
  -> cpa_lock


-- 
Sincerely yours,
Mike.
