Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338346;
	b=f5QC/o76jY8oTMgE5yIswTVu4+0XY+hjDk3aKcp9xVGiKSNrOkFfaNjoZfq0wDpif8dP
	 TWv/QyulPczrepZRyTxWreVOZP3hvPdxjaUi6gEhIPu2WV8U/D4061z+aLGsORGgEBxmX
	 BVAg4D0bxkwLf3x2X3XNOH4YZCtzRZgZ8hcsBun2TyWl57pLPe8sPlw22pGs33lJDl1nN
	 9u1nZrLjgnJE1wh68a9Qfn2f42gg8zZjRxPrXPZsoq6aaT6MJ88Gtc19ucB8+EBOyxe16
	 IPkyrzvlN28YjFWU1g0VXlDpfM8b1dKmy5E/vrCniXlNa2lGlXFDyi470zRFR2c5WFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338346;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=VTDrdrBuAyTJnkqjgvXYYtVwc9zTl+F88XwMGcc4YDE=;
	b=JuLMzqPz+mjTuDm63YMBJ0YqlbdWnt8EvQsiWitJsa3Hb13ZwrtcUBvh8khLja7elxi2
	 DA6B1CVjDSm96hHednWa89qPAJWp0lCZJ9fvFWhOG1gVRMKTVx1j9lNpRJnWTvlRKxTkY
	 vskrRX3qOxhRu05+uznOW1b5jcyGMf3nWwO878ManJRN95gVdEPy/lLvyepJadlfJKFJe
	 FvjM2AZ2pDQPqnkP+ye6NgrHNQEjnTQCbm5NmHRYiYca80LVglAoxW9IL+1t4FEi7/0/x
	 OQSMy3bhXt0Z9dpyoskIcYMS0BO85yKlTSOhWdlQ0yw9f3svitigpHb8ZRfE8ULg11w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vHfRjYMT;
	arc=none smtp.remote-ip=91.218.175.25
Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB58606A331
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DB58606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vHfRjYMT
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Bf0WWkeJSETIqyNNL0Tk2W1KhY+0SCl/fI1XWH+Qygc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793338342; v=1; x=1793943142;
 b=vHfRjYMTLE8GNmV/NQ930J2ywQJhyanjVI75XVY+Rep9T7tsczB1jt3b7nefwWbYQQHhTYpb
 iqzg8eNAu1Xwp0lliVRb1Bc0n0dDbxlw7ENRHSVJ1UOiue1mIXVgC4W1E5mOo6hJME16DhnrQBq
 go8H6oQ4AOnRkh5x1foQvjtU=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 9f9ebc0d777873bb;
	Fri, 30 Oct 2026 05:32:22 +0000
X-Mizu-Trace-ID: 9f9ebc0d777873bb
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH] mm/hugetlb_vmemmap: Fix usemap overrun on nodes with
 multiple ranges
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261029212137.3141875-1-tim.c.chen@linux.intel.com>
Date: Fri, 30 Oct 2026 13:32:06 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Frank van der Linden <fvdl@google.com>,
 Mike Rapoport <rppt@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Mohini Narkhede <mohini.narkhede@intel.com>,
 Pooja Jain <pooja.jain@intel.com>,
 Doug Nelson <doug.nelson@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <0611C182-4A76-4751-A04B-0849EC31DAD3@linux.dev>
References: <20261029212137.3141875-1-tim.c.chen@linux.intel.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 30, 2026, at 05:21, Tim Chen <tim.c.chen@linux.intel.com> wrote:
> 
> sparse_init_nid() allocates one usemap slot (struct mem_section_usage)
> per present section in [pnum_begin, pnum_end), and
> sparse_init_early_section() hands them out in order, with a BUG_ON() when
> they run out. hugetlb_vmemmap_init_early(nid) however initializes the
> sections of every bootmem gigantic page on the node, including pages
> outside the range being initialized. If a node's memory is split into
> more than one range, sparse_init() calls sparse_init_nid() once per range,
> and this takes more slots than were allocated. The same happens if a
> gigantic page straddles a node boundary.
> 
> For example, with this SRAT layout every node has a small range below 4G
> and a large range above 4G:
> 
>  Node 0 PXM 0 [mem 0x00000000-0x2fffffff]          768 MB  (low)
>  Node 0 PXM 0 [mem 0x100000000-0x80cfffffff]               (high)
>  Node 1 PXM 1 [mem 0x30000000-0x5fffffff]          768 MB  (low)
>  ...
> 
> In 128 MB memory sections (x86_64 SECTION_SIZE_BITS = 27), node 0's low
> range is sections 0x00-0x05 (6 present sections) and its high range is
> sections 0x20-0x1019. The low ranges of the other nodes are 4 or 6
> sections, all smaller than the 8 sections of a 1G page.
> 
> Node 0's first range has 6 sections, so 6 slots. With "hugepagesz=1G
> hugepages=400", hugetlb_vmemmap_init_early(0) then initializes node 0's
> 1G page at 0x67c0000000 (sections 0xcf8-0xcff, in its high range), and
> the 7th section hits the BUG_ON() (seen on v7.2.6):
> 
>  kernel BUG at mm/sparse.c:268!
>  RIP: 0010:sparse_init_early_section+0x9f/0xb0
>  RAX: 0000000000200000 RBX: 0000000000000cfe RCX: 0000000000000020
>  RDX: 0000000000000cfe RSI: ffd7e1d09fc00000 RDI: ff252cb28ffb3f50
>  R10: ff252cb28ffb3d40 R13: 0000000000000d00
>  Call Trace:
>   hugetlb_vmemmap_init_early+0xe1/0x140
>   sparse_init_nid+0x56/0x370
>   sparse_init+0x192/0x2b0
>   free_area_init+0x7f/0x690
>   start_kernel+0x64/0x540
> 
> Here RDX is the section number, and R10/RDI are 6 slots apart: the start
> of the usemap buffer and its current position, which is the end.

A detailed analysis.

> 
> Pass the section range to hugetlb_vmemmap_init_early() and only pre-HVO a
> page whose sections are all present and within it. Ranges are disjoint,
> so each page is handled once, in its own range.
> 
> Skipped pages are not marked HUGE_BOOTMEM_HVO. Their sections get a
> regular memmap from sparse_init_nid(), and the pages are optimized later
> by hugetlb_vmemmap_optimize_bootmem_folios().

Thanks for fixing this.

However, the master branch has already switched to section-based vmemmap
optimization, it has been already fixed. So this fix should target the
stable kernels (6.18, 7.2 and 7.3).

The change LGTM. So:

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.
