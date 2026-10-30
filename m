Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379329;
	b=t5toew6dGYfEyQk2KplMosv2LOYFfWvhHJkea2Z8saRuuW+QanfnEkcClj3izPONjAaL
	 lwlnHUBkOjhHD6pift7LboPx08cg3aCeIzj/ssxrYV8m8x1oqldhkJxwiAja+fA+4osvh
	 U/v03wkfZoaIKgl266Q0j7WU2OYahJUOrXFns+VD7Dv90UqkvKawVPBmfMopPjaaZ030h
	 562xS0nCiiRBawZ34NpPZibaO+fHNwTVC0ZSDDvpXaopOaqOh2umR7cKymFQ2Wtgbn/u6
	 ItpqJ7POeS1wo3pvIepy8EJkA6E1/9d/uQIwIXace5xUXijX0rF4nLZJgw9ixHkYuKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379329;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=BgnmbS0qtZzofNOhBfAuY9e9ZGW0X9MHEKQwmV+gFd4=;
	b=A0vgNxB9RfYa7fs6i+cHaHZbQIW7i7maLxQQ3CvkCDGRkTw+9dPlZN+GmMvWa6yUowfh
	 bUZTUXe48zRo9zmXKiCaDCGkAuz17z4qKTHnQiAebFakClPExZzM7U/rkiJ1S+p8iEMyA
	 4tEfyz6/q0XWgwN+7d6ym9LMBUoF5rzUMtvgNLwL+fOnFd9VcwCQZZbZiyDjwtjzeCq4p
	 ZxVgl0jYXRJrcA6eDC7j9Sz3EVn37V2EEaFmP1QUuz5qLDGLutp1PZD/+kHEx/hy6E+l/
	 AqF7HtRb5VavWbzX54yrou5y1e8DAbZ2l+hHOwKAbUzIvihxpYXKI06nI43NUrWIm1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jO6GAPtF;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BF606A32D;
	Fri, 30 Oct 2026 16:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA1BF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jO6GAPtF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793379328; x=1824915328;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SfRf/e5D4fJBitFkWiH24F7RsXJMv4g9Vd/EK7VDuik=;
  b=jO6GAPtF6FNpocEfxd8Lq4qLOJbfbRtJMCRO8oUyrNF+jkpiScdnp7f6
   YpEs+d3S5A46Kih0ZWi1keZA5Efh3CdrRh1olbSX+FBxD0MlOodjJ4mA6
   XR3IcIRxhn5scJA+5zrPgxZMD3loWHaMHj6hKQf5/ui8qbNC4iK4xAykx
   DvH8SveAflGGQZ0xZXyI4J2hVHqbp5fe1QlBNHAP3l6N8AZS/e1P9rBD9
   22l6+YzgPO7tpJv64Ipys5AqsEnB2EpITYinvBSSI7EgYEQISlrVeaF75
   wsxSty53T1Z69TgEBeQsjHrVDzA01NEHZB70XgIEElZii2pCGjSnudESY
   w==;
X-CSE-ConnectionGUID: DFCrRd16RwmlXzueluhcXw==
X-CSE-MsgGUID: vIgRv54bTNujQ8GelJcK4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2241148"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2241148"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 09:55:27 -0700
X-CSE-ConnectionGUID: rhDb9+csTMmsZXY9RNR4aA==
X-CSE-MsgGUID: CmQR+n7gRuSQVAfNnNQelw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5487915"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.109.99]) ([10.125.109.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 09:55:27 -0700
Message-ID: <7efb942eb0f4fb81528e1a97e7f73996a95988ee.camel@linux.intel.com>
Subject: Re: [PATCH] mm/hugetlb_vmemmap: Fix usemap overrun on nodes with
 multiple ranges
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador	
 <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Frank van der
 Linden	 <fvdl@google.com>, Mike Rapoport <rppt@kernel.org>,
 linux-mm@kvack.org, 	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Mohini Narkhede	 <mohini.narkhede@intel.com>, Pooja Jain
 <pooja.jain@intel.com>, Doug Nelson	 <doug.nelson@intel.com>
Date: Fri, 30 Oct 2026 09:55:26 -0700
In-Reply-To: <0611C182-4A76-4751-A04B-0849EC31DAD3@linux.dev>
References: <20261029212137.3141875-1-tim.c.chen@linux.intel.com>
	 <0611C182-4A76-4751-A04B-0849EC31DAD3@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-10-30 at 13:32 +0800, Muchun Song wrote:
>=20
> > On Oct 30, 2026, at 05:21, Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >=20
> > sparse_init_nid() allocates one usemap slot (struct mem_section_usage)
> > per present section in [pnum_begin, pnum_end), and
> > sparse_init_early_section() hands them out in order, with a BUG_ON() wh=
en
> > they run out. hugetlb_vmemmap_init_early(nid) however initializes the
> > sections of every bootmem gigantic page on the node, including pages
> > outside the range being initialized. If a node's memory is split into
> > more than one range, sparse_init() calls sparse_init_nid() once per ran=
ge,
> > and this takes more slots than were allocated. The same happens if a
> > gigantic page straddles a node boundary.
> >=20
> > For example, with this SRAT layout every node has a small range below 4=
G
> > and a large range above 4G:
> >=20
> >  Node 0 PXM 0 [mem 0x00000000-0x2fffffff]          768 MB  (low)
> >  Node 0 PXM 0 [mem 0x100000000-0x80cfffffff]               (high)
> >  Node 1 PXM 1 [mem 0x30000000-0x5fffffff]          768 MB  (low)
> >  ...
> >=20
> > In 128 MB memory sections (x86_64 SECTION_SIZE_BITS =3D 27), node 0's l=
ow
> > range is sections 0x00-0x05 (6 present sections) and its high range is
> > sections 0x20-0x1019. The low ranges of the other nodes are 4 or 6
> > sections, all smaller than the 8 sections of a 1G page.
> >=20
> > Node 0's first range has 6 sections, so 6 slots. With "hugepagesz=3D1G
> > hugepages=3D400", hugetlb_vmemmap_init_early(0) then initializes node 0=
's
> > 1G page at 0x67c0000000 (sections 0xcf8-0xcff, in its high range), and
> > the 7th section hits the BUG_ON() (seen on v7.2.6):
> >=20
> >  kernel BUG at mm/sparse.c:268!
> >  RIP: 0010:sparse_init_early_section+0x9f/0xb0
> >  RAX: 0000000000200000 RBX: 0000000000000cfe RCX: 0000000000000020
> >  RDX: 0000000000000cfe RSI: ffd7e1d09fc00000 RDI: ff252cb28ffb3f50
> >  R10: ff252cb28ffb3d40 R13: 0000000000000d00
> >  Call Trace:
> >   hugetlb_vmemmap_init_early+0xe1/0x140
> >   sparse_init_nid+0x56/0x370
> >   sparse_init+0x192/0x2b0
> >   free_area_init+0x7f/0x690
> >   start_kernel+0x64/0x540
> >=20
> > Here RDX is the section number, and R10/RDI are 6 slots apart: the star=
t
> > of the usemap buffer and its current position, which is the end.
>=20
> A detailed analysis.
>=20
> >=20
> > Pass the section range to hugetlb_vmemmap_init_early() and only pre-HVO=
 a
> > page whose sections are all present and within it. Ranges are disjoint,
> > so each page is handled once, in its own range.
> >=20
> > Skipped pages are not marked HUGE_BOOTMEM_HVO. Their sections get a
> > regular memmap from sparse_init_nid(), and the pages are optimized late=
r
> > by hugetlb_vmemmap_optimize_bootmem_folios().
>=20
> Thanks for fixing this.
>=20
> However, the master branch has already switched to section-based vmemmap
> optimization, it has been already fixed. So this fix should target the
> stable kernels (6.18, 7.2 and 7.3).
>=20
> The change LGTM. So:
>=20
> Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks for the review.  Indeed the master tree has the section rework,
so this bug is fixed for current master.  It just needs to be
applied to stable 6.18, 7.2 and 7.3.

Tim

>=20
> Thanks.
