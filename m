Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A480442FDB;
	Thu, 13 Aug 2026 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611078; cv=none; b=WzzO7RYo82ek4ZAspK3E2BV4riiS46V/TsoFvkm+7h1hX7UyMM3fLTqI8kJONT1b+5EHRCIX3yIZ6TWckqynp79EPd8NFl8Pmh8Nf+dc3AlV8Rm6PCxsEtiPt9uUlTxAvQiaS4s3J/YFFtciPKKgwZbDaws7S3USxDjM2QabRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611078; c=relaxed/simple;
	bh=yP2T/dRfoOq9lZp6dYfuhCi5+xWv9PTfpDgNcUv5UNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLocmwi4kl0k59g5P+//+PBy4z6NVtcGKmJHjtBoUvC2oWNYLqhnk/Dqeif4v9w4DInnjjgnx9PwNX85BvgiSth8iLe6VCoaCimgKUs+YMSr2HB0baMrLD3HxHzu8Sh+BiPGzSC0+TYlqLwkwAIvyY7OErf3QpUU5dqNZpd3axA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWPYIb/p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWPYIb/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6A31F000E9;
	Thu, 13 Aug 2026 08:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786611074;
	bh=s15YMfOwxWEvAnRRd4hU5g+v53XbUCKXoccrAXlR3Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nWPYIb/pH6H6oqPWsIPtUjNPbp07s6id5XEc1hMPQDMdeKAuZOc9j8PNXJxfz33n6
	 G5IxTmlmRhScRf8Rtc8d+7pqOLpyuMN6lUMOhfbf5lTZefaXpD7B6E3/5v9m1xTNDp
	 m+i2jwmBGB+jr7V/SNZYlKjYsTuYkARctVNycKJoDlAUIXVy5KJ41TZo8kC+RuWTco
	 vSV1Z6V0YTo37RIgaBT+JA47S9pvA5P8NoFDBjXkG5xW+1Ddj3Teg0/cbcV7yJ5tKj
	 LOuXPzmtuHuqAqKA4GyOzCA7qcxeXCTdSVdbHMX+vPJboJijElcEOPP7vokRjodtrn
	 NPX5Z2P3YnCig==
Date: Thu, 13 Aug 2026 11:51:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: ljs@kernel.org, akpm@linux-foundation.org, baolu.lu@linux.intel.com,
	bp@alien8.de, dave.hansen@linux.intel.com, david@kernel.org,
	den@openvz.org, devnexen@gmail.com, hpa@zytor.com,
	iommu@lists.linux.dev, jgg@ziepe.ca, jgross@suse.com,
	jirislaby@kernel.org, kas@kernel.org, kevin.tian@intel.com,
	liam@infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lists@steffen.cc, luto@kernel.org,
	mingo@redhat.com, peterz@infradead.org, pfalcato@suse.de,
	shakeel.butt@linux.dev, stable@vger.kernel.org, surenb@google.com,
	syzbot@syzkaller.appspotmail.com, tglx@kernel.org,
	toshi.kani@hpe.com, vbabka@kernel.org, vishal.moola@gmail.com,
	will@kernel.org, x86@kernel.org, bharata@amd.com,
	Ananth.Narayan@amd.com
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <an2FdPPOWT50lLD4@kernel.org>
References: <anXvODEvV4f_Taj7@lucifer>
 <20260813055544.25567-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813055544.25567-1-nikunj@amd.com>

On Thu, Aug 13, 2026 at 05:55:44AM +0000, Nikunj A Dadhania wrote:
> On Fri, Aug 07, 2026 at 04:36:08PM +0100, Lorenzo Stoakes (ARM) wrote:
> > +static void poke_vmalloc_pages_safe(struct page **pages, void *addr,
> > +				    bool cross_page_boundary)
> > +{
> > +	guard(mmap_read_lock)(&init_mm);
> > +	poke_vmalloc_pages(pages, addr, cross_page_boundary);
> > +}
> 
> Tested just the proposed patch from this email (without the rest of the
> CPA fixes series) on the 512-guest concurrent boot harness (details in

For this fix to actually fix anything, the patches that add locking of
mmap_lock to CPA are needed still.

> [1]) and still see the memcmp BUG, I havent hit the first BUG though:
> 
>   kernel BUG at arch/x86/kernel/alternative.c:2727!
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   CPU: 1 UID: 0 PID: 485 Comm: (udev-worker) Not tainted 7.2.0-rc5-pokesafe+ #42 PREEMPT(full)
>   RIP: 0010:__text_poke.cold+0xdb/0x2af
> 
> The instrumentation captured the following before the memcmp BUG:
> 
>   SMP alternatives: __text_poke: memcmp failed at addr=ffffffffc06ce1bb len=4
>   SMP alternatives: __text_poke: expected (src): 2e 2e 31 c0
>   SMP alternatives: __text_poke: found    (dst): f9 b8 9b d3
>   SMP alternatives: __text_poke: pfn at poke time (vmalloc_to_page): 8ece
>   SMP alternatives: __text_poke: pfn at readback time (vmalloc_to_page): c6ce
>   SMP alternatives: __text_poke: page table dump for addr:
>     PGD 2f042067  P4D 2f043067  PUD 2f045067  PMD c6001a1
> 
> pfn acquired at the start of __text_poke() (0x8ece) differs from pfn
> at readback time (0xc6ce) in the instrumentaion.
> 
> [1] https://lore.kernel.org/all/20260812063316.21371-1-nikunj@amd.com/
> 
> Regards,
> Nikunj

-- 
Sincerely yours,
Mike.
