Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394494;
	b=mIqM3NC/CnvwXbnWxAK62zaHpDnQ/MnyZ/sRZFet2qyYme2y8kF2yqu7FAVtzQZc1dif
	 jhH0qfUzg2SV9gHmUSfXtl+VnuSOO3WE5p7XfqzfULUhewRf4MMZkjRxugDraPZSCntKK
	 nZOLpRgnzepVv4eBuoVi1OB0Dc8hwYKrLmfSLbNoVlQsiQDKABhfmPnyVJU1XC4hlyDaG
	 Jg7FdtZIhNoYe4TC7FG/Uc58VGCtyJWKiAojZ9QK6MbY7fk0sYbq7qyGNKyxb9kWlQCAs
	 3PiURpXPfmqCxo6mltdLm6HmITvbXnz9NGJopcOYaEsK1Y96z4Alx0tjvpUb4C+CqmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394494;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=VuNZ7cfgkn64XZBhopOwYjZ4PrGgE6PweZ/cwTmJkNg=;
	b=wRBgk43zjLRmO2k1jAvoBJ5o3N/rZBeNCT6Dp9BAC55He8ZqtkIccAA/c0hzHah1GgNl
	 RgG2u+22eA4NNOCtrvnHpYfhxLWrnFL4w7HslTnLwIYiiBKReioHsYoMmcoydIgY67b9E
	 zPMUe7ua9jIy3A19YJXtyaEd/BJvOut/P+BACuZidUSEKo1TsxC+dCpmKi4n3dXSwlGiX
	 hH06QMy4/LqcNrb1kBzrVe1Q+h/fqwhYLDhbmzy4YTpAVucLmBVxpeZUCd3y5wPXDbifo
	 Gz2yoXhR40jg0G3HCkt6yCLCF1KMrFL0cRA7YZGNNo5xjXv994NPjcrlpZ+IBeNRplQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RXsOEBWq;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D519E606A31A;
	Fri, 30 Oct 2026 21:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D519E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RXsOEBWq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793394494; x=1824930494;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JfsC+5Gm92RBF81R+5io695VP7oyD4ZIWHKa/oplgeQ=;
  b=RXsOEBWqtH0wSk6r/F8o5mk7xHOYCATJ2aYjOJNCQXj1txN6uFvYxMwW
   y7FdihzISS6FmoIM+vvIls01dr7PI5w/BhXvdvBmXm48XD2KDUel21Ghr
   5UVf/ZEW+lEzEZ66OESylEs3xbyTpKbIWtYmmIkef8wK9J2wrF+l0upTL
   lDWFAq3MPY6Mg+bBZVEZfoVtFHJP9Da/lOIppyYZJTXT1xJvpYmPFqL4+
   wG1tNFAd2qrSvw2qb22RJ6TeYzhLxHUdKfJd8urEggoNiWhu+f04Gel65
   pmghYYMYJ84Q10tz2GepeGI7SPDuKnIZIPFgM/mVoTQW4PpIR3YqJjO39
   g==;
X-CSE-ConnectionGUID: fKJjf2tdR86fvmP1Rttciw==
X-CSE-MsgGUID: 509sOWieSsOhch9ugQ1eQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2170685"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2170685"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 14:08:13 -0700
X-CSE-ConnectionGUID: j6W+B9UvRdWl0vyRtc/1ZA==
X-CSE-MsgGUID: dnK4t5d2T0+au4hpgrffAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5622615"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.109.99]) ([10.125.109.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 14:08:13 -0700
Message-ID: <6f2aac82469fe90c8902e6e018b6259e3503fee7.camel@linux.intel.com>
Subject: Re: [PATCH] mm/hugetlb_vmemmap: Fix usemap overrun on nodes with
 multiple ranges
From: Tim Chen <tim.c.chen@linux.intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton
	 <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Oscar
 Salvador <osalvador@suse.de>
Cc: Frank van der Linden <fvdl@google.com>, Mike Rapoport <rppt@kernel.org>,
 	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mohini Narkhede <mohini.narkhede@intel.com>, Pooja Jain
 <pooja.jain@intel.com>, Doug Nelson <doug.nelson@intel.com>
Date: Fri, 30 Oct 2026 14:08:12 -0700
In-Reply-To: <6086c386-3903-476f-ba55-bd6c21072f72@kernel.org>
References: <20261029212137.3141875-1-tim.c.chen@linux.intel.com>
	 <6086c386-3903-476f-ba55-bd6c21072f72@kernel.org>
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

On Fri, 2026-10-30 at 09:58 +0100, David Hildenbrand (Arm) wrote:
> On 10/29/26 22:21, Tim Chen wrote:
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
> >   Node 0 PXM 0 [mem 0x00000000-0x2fffffff]          768 MB  (low)
> >   Node 0 PXM 0 [mem 0x100000000-0x80cfffffff]               (high)
> >   Node 1 PXM 1 [mem 0x30000000-0x5fffffff]          768 MB  (low)
> >   ...
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
> >   kernel BUG at mm/sparse.c:268!
> >   RIP: 0010:sparse_init_early_section+0x9f/0xb0
> >   RAX: 0000000000200000 RBX: 0000000000000cfe RCX: 0000000000000020
> >   RDX: 0000000000000cfe RSI: ffd7e1d09fc00000 RDI: ff252cb28ffb3f50
> >   R10: ff252cb28ffb3d40 R13: 0000000000000d00
> >   Call Trace:
> >    hugetlb_vmemmap_init_early+0xe1/0x140
> >    sparse_init_nid+0x56/0x370
> >    sparse_init+0x192/0x2b0
> >    free_area_init+0x7f/0x690
> >    start_kernel+0x64/0x540
> >=20
> > Here RDX is the section number, and R10/RDI are 6 slots apart: the star=
t
> > of the usemap buffer and its current position, which is the end.
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
> >=20
> > Fixes: b1222550fbf7 ("mm/hugetlb: do pre-HVO for bootmem allocated page=
s")
> > Cc: stable@vger.kernel.org
> > Reported-by: Mohini Narkhede <mohini.narkhede@intel.com>
> > Tested-by: Pooja Jain <pooja.jain@intel.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  include/linux/mmzone.h |  9 ++++++---
> >  mm/hugetlb_vmemmap.c   | 38 ++++++++++++++++++++++++++++++++++----
> >  mm/hugetlb_vmemmap.h   |  7 +++++--
> >  mm/sparse-vmemmap.c    | 16 +++++++++-------
> >  mm/sparse.c            |  2 +-
> >  5 files changed, 55 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 94f9c3ff54160..da17dae8b057b 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -2167,13 +2167,16 @@ static inline int preinited_vmemmap_section(con=
st struct mem_section *section)
> >  		(section->section_mem_map & SECTION_IS_VMEMMAP_PREINIT));
> >  }
> > =20
> > -void sparse_vmemmap_init_nid_early(int nid);
> > +void sparse_vmemmap_init_nid_early(int nid, unsigned long pnum_begin,
> > +				   unsigned long pnum_end);
> >  #else
> >  static inline int preinited_vmemmap_section(const struct mem_section *=
section)
> >  {
> >  	return 0;
> >  }
> > -static inline void sparse_vmemmap_init_nid_early(int nid)
> > +static inline void sparse_vmemmap_init_nid_early(int nid,
> > +						 unsigned long pnum_begin,
> > +						 unsigned long pnum_end)
>=20
> Two tab indent please in all cases here that you are touching, thanks.
>=20

Thanks David. Sent out a v2 patch with this format update.

Tim
