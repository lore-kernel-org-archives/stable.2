Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945C141D63D;
	Thu, 16 Jul 2026 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206163; cv=none; b=fHL98f/6/jn6CvM04qprZ9QG/p3o7fVgeNU4rXxGBfENSBMWDaZDsmI4+DEBphV8cYdfjM2ti4SrMIzEdbIWBxm/xmRBv0lFN535odUAid3Hu5dYunPuoAdiwjiXEYGxH5/5SmFcbbFqAq/S548/1/yYdRL9Db5ufdYhQEypb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206163; c=relaxed/simple;
	bh=Bus2ruuxt4jS5897GqFvCmeDlh5ATzw9taggVhAgYRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2QIXk39mC7GIY2mqmWCOW5Cu0Ic0XxazHuaemtlVpi+l/FEDxN5SJVPDre3VPLkY6Cdk8D1zGP/Zu8pHs/1JXckYXDIUPdpRvriBrgWuhSX4m55XUm9p8hX8RhUBCb8PeMR7wyHHxOH1tQHSI0rRaxfmueAS4tzEvxcKvgsFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBTnCvJ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBTnCvJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8401F000E9;
	Thu, 16 Jul 2026 12:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784206162;
	bh=hPC4/bkySYuEIDm7sSNDHaTK4nJg9WPIz/TBHjyeJK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EBTnCvJ9LBKnvWT6txkoqJfPx80j2qmCPPgtys2eexys61AqRBL/PikdcJ6hRJAu9
	 N/7/eAlmSuk+e3pdfg1br9QTOhJW2GGB9kHXTsWQFNTHz0JCZ97PbPUW/LdJ4+wRy/
	 +XTaRU6ByVV8cgDQ/Y8URNaE9ixhEq3zlBP78l090NnAF3jztLYymQ9AP81piPIYAS
	 +eLW/SudvgS/2t8T899cAQ7pEdr9DwlUjvvFQEk6oEwv3wdptotD0TLRa6MM1FffAR
	 YHD2d42XYxRErp70skW71CAatVzJVw6VUlhs8jh9r8ff+ImW/liW57cAnWmulaWueU
	 l0WsUaQ0QduBw==
Date: Thu, 16 Jul 2026 13:49:12 +0100
From: Will Deacon <will@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org
Cc: Dev Jain <dev.jain@arm.com>, muchun.song@linux.dev, osalvador@suse.de,
	ljs@kernel.org, liam@infradead.org, riel@surriel.com,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	lance.yang@linux.dev, kas@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, apopple@nvidia.com,
	rcampbell@nvidia.com, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, ak@linux.intel.com,
	nao.horiguchi@gmail.com, mel@csn.ul.ie, j-nomura@ce.jp.nec.com,
	pfalcato@suse.de, tglx@kernel.org, dave.hansen@intel.com,
	jpoimboe@kernel.org, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/6] arm64: make huge_ptep_get handled unaligned
 addresses
Message-ID: <aljTSN3yGRv1OoUN@willie-the-truck>
References: <20260703114202.365553-1-dev.jain@arm.com>
 <20260703114202.365553-2-dev.jain@arm.com>
 <20260705003559.8b124d2b94b685cc2e4e77ae@linux-foundation.org>
 <8fdbe0d6-87fd-441c-b6d2-baac380f6fb3@arm.com>
 <4b4e8007-3747-457a-85cc-d1003e1c8fe2@kernel.org>
 <39a13445-dc6f-4a75-92b8-f4a122c63b89@arm.com>
 <7ac558fd-1081-456b-b997-c7321241cf8c@arm.com>
 <2b9d60a2-8698-46b0-80ae-b8747a66a85b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b9d60a2-8698-46b0-80ae-b8747a66a85b@kernel.org>

On Mon, Jul 06, 2026 at 04:04:40PM +0200, David Hildenbrand (Arm) wrote:
> On 7/6/26 12:54, Dev Jain wrote:
> > 
> > 
> > On 06/07/26 4:22 pm, Dev Jain wrote:
> >>
> >>
> >> On 06/07/26 2:15 pm, David Hildenbrand (Arm) wrote:
> >>>
> >>> Even worse, right? We could walk 128 entries, when we really should just walk 16
> >>> (IIRC) entries, possibly reading garbage or even worse, into a memory hole at
> >>> the end of memory?
> >>
> >> Hmm I was thinking that the checks pte_dirty() and pte_young() wouldn't care whether
> >> the pte is garbage. But, we could actually dereference a ptep pointer not having
> >> backing memory at all.
> >>
> >> Does the following sound good?
> >>
> >> "On systems where CONT_PTES != CONT_PMDS (meaning page size is 16K), we could collect
> >> excess a/d bit state, meaning extra work for the kernel. Even worse, we may iterate
> >> beyond the PTE table and dereference a garbage ptep pointer to access physical
> >> memory we don't own. Since the ptep pointer is a linear map address, we may run off
> >> the end of the linear map, dereference a VA not mapped into the kernel pgtables and
> >> cause kernel panic."
> >>
> >> Although I checked on arm64, there is no case in which there is a hole after the
> >> linear map, but still that assumption shouldn't be made.
> > 
> > Oh but we could access a linear map address which corresponds to a DRAM hole, meaning
> > there is no entry in the kernel pgtable.
> 
> Yes, exactly. With debug-pagealloc and things like that we might have many holes
> in the direct map.

I think this one patch should go in as a fix.

Andrew, do you mind if I pick it via arm64? If you'd rather manage the
whole lot, please can you send just this one as a fix for this cycle?

Thanks,

Will
