Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F680363C5E;
	Tue, 14 Jul 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024985; cv=none; b=FeM3vAO8szNhWfJjZNwExkvcNgiQ3ecwKmubEHMuDZfFHG+9ujWhPV+U831ruUp82btfmmYKma4MUdxmo8blHTiYsH8RTleUlRtBExqZFiajNQOyadLw/3F5tNZKybomzVISdMyUNjNN3Dxtf/TUOxQkmrBH27njQit6/g17z8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024985; c=relaxed/simple;
	bh=b2KoF/ZdvnS+1NbXWLxi8vnBDnwa3H3fVyTHe5v7DVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDrUGq3QXwVcdL5FLrai8rVOjt+D17uWeIaTEokHjcC0dy89YiUHyItfM+wTJkC0aSGjhEw+FcxQlzQi6/22IgvlQ8cY9FodI7wON5W8pVV2AJev15yQ2CM/NZW6Htq0XrizXMoiW4c6xDhPh48OH7bT6HyA7qBTp8N+YqPq284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=dPIydHwD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XC07vfoK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="dPIydHwD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XC07vfoK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 77E2B1D000B0;
	Tue, 14 Jul 2026 06:29:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 14 Jul 2026 06:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1784024981; x=
	1784111381; bh=D/druKhd9IvNef2J0pJK27qVVVk4qI3tVilOxadA1e8=; b=d
	PIydHwDr3/Tg+Hi3OkA+1QoItUIckCj1nhbg0b9h5NSTS4gYSsFuoy2CSmb4AQNM
	orGtwGN9bp1pQGPWIkLrQmBvjxz/NV2ZrMw1GV6Atuw959cnU4Bia6H95pTC7kSJ
	JzIs7af1KEx3MvzY287uWhUdNSmtKeDz5ma+OkrFdlEwji5qjGk1KpSRekLidyF4
	bmLmHz8OxCYK3sJ9DOlFXi+J1mLwXkiX2KAwTr5DbggRxxCG8NIVadPs2FIUMW4U
	pyr2yRot8Ueq1amRdyxZwkfgYgXtdJL2Otk+h3Ko2716sMcgQj0od8BYId6LdphJ
	NCjWM730NBRX2Oxc667Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784024981; x=1784111381; bh=D/druKhd9IvNef2J0pJK27qVVVk4qI3tVil
	OxadA1e8=; b=XC07vfoK4nsA+cBeBnFTMekbPtk+TK+HRAQIT64nptDzo2nmP/4
	vHUAPC58ZBZNMt4eSuuAKUz5bcsw55FSa0JZg7cYxxqujb7XJEUZkghyao8C5n1S
	BXco/DxCGNkmV7Zx59nQlrsGdcdJsVZiHpgA3HwEOlzJ//PYL+t8sPWZAkdPFAaP
	40iYrCS4A3lZtcciy8lT+msxcyDWHOUzT8+BusKWb5jnH0XjlR78NhQuA0QMHKSL
	sIMhBja/Dpu23e0OhjfutuCMCclE6g2HRfKjtu1ccUM/T/4ddH5fC8A1eVq30/bP
	tX95DSxT7eOfAec1VoEdK6nX95dTIaEvzXA==
X-ME-Sender: <xms:kw9Wat9C2QTeHF6-ePmUCQcBAUFGKePfFf5wh5wss2uh9V_8HVHPKQ>
    <xme:kw9WakB3I-eXBfmkWnUSUpQvDP3B5aduq9oh3HB8yYqObfBCvx8fhp7D6vjgoiRPC
    B4WbGVlmjbHEveoWiXwg622qP_Y-N1u-LaAxUbC_MMtElP8Nf1y3I4>
X-ME-Received: <xmr:kw9WapujENMK8sn9Fr1bprk9NFRT9_p6wahvM-bDtzBN1p_D0fb45Dta8x2J7A>
X-ME-Proxy-Cause: dmFkZTEjQddmFbvKigDMQdRqPJ9XSi1XrBW+ZC8BP7zhnCiYnrJnKj9UHprC+RU4ycuqir
    wV2GJTTRlRcTN/CyiH+ODp1oFJ0eBsmClA3QYKTzOlBg+03PAxve7QMoYT1uOexdoEKBHl
    3D2PiTA4kPq9gZAetGrReve0e9NbA5Lj5KTZMrwybItPm9IQH5qiiBz+sOFqdOHWjvibSB
    uSjuhGtKEyH8YUM4yLTvaYcQLtEM6zfk6b3p8QJ2wQ+x/1luB8vJvYj2DuGjcrEsBkbwnh
    Tl3VozsJM7BFQNSjYATBTvTc+zLxNS4S+NSy5bPvx9nbwkiBt9JqIEcfzhOy7t9Q1qEdJC
    OYTpVUjelx4tRsH9EaKnse8jHJMVDHuw96Z5hTUcOva+qHMp6m+4X0XhgabBRrbWtC5Y1B
    1PUTKJNyvqBrC0azgWq2E85ld4QJ+i4cOEUmlVbbiXDaV4jBYbyDT1SVC0MZnraB/ySvuq
    wYzDVHnqNvCWXcHdlJNN7gp9qY8Vtv6eg5N6I6fv/47U/dWmMoilKh+2iZv/HfFYqjXUE2
    D47+tLGrxVKSAZzXNcmzQZjcbgAzKp4mem39Zv51sEXOWi6fgdxfHybzU4lAuLTR4UfUy2
    2872xGer3gtOh6wB2hmMtPVmX4SnCARpvYsE1jSvz8F50O6wO7gpFY9xb6JQ
X-ME-Proxy: <xmx:kw9WauYAJIfJyg9M4SXs_Nme2bzDJoeSCD2CPzGuUIGS9gmopEAAbA>
    <xmx:kw9Wav0ivMgNKptookebq9rZ9_P4eP_h7ViSgZpv68k0bLYrL9z8wQ>
    <xmx:kw9WarnjlVZo4mEjG2GzGSVUxalHgCW_BhhAiXbwWn6bXLqcTjy_cg>
    <xmx:kw9War9Ba-_ihxLsCURfA7Y5LobYraL9QZ7ZtLpo1QVRbaMPs093xA>
    <xmx:lQ9Wap6J8O2PmRR8gtF5rczRAW_O-D6kQgsOgb-g7nQ06yXGRKFH30Kn>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 06:29:38 -0400 (EDT)
Date: Tue, 14 Jul 2026 11:29:38 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Hao Zhang <hao_zhang_kdev@163.com>, 
	Hao Zhang <zhanghao1@kylinos.cn>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: thp: pin the inode across a file folio split
Message-ID: <alYPE1CDJE4HaP1J@thinkstation>
References: <20260713170915.239819-1-kirill@shutemov.name>
 <20260713161341.eefb7ad32bca25ffc8f3390a@linux-foundation.org>
 <alV3oLwvbeQsagsA@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alV3oLwvbeQsagsA@thinkstation>

On Tue, Jul 14, 2026 at 12:45:41AM +0100, Kiryl Shutsemau wrote:
> On Mon, Jul 13, 2026 at 04:13:41PM -0700, Andrew Morton wrote:
> > On Mon, 13 Jul 2026 18:09:15 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> > 
> > > From: "Kiryl Shutsemau (Meta)" <kirill@shutemov.name>
> > > 
> > > __folio_split() looks up mapping = folio->mapping for a file-backed
> > > folio and keeps dereferencing it after the split completes:
> > > shmem_uncharge(mapping->host) for folios dropped beyond EOF and
> > > i_mmap_unlock_read(mapping) on the way out.
> > > 
> > > Nothing holds an inode reference for that duration. The split relies on
> > > the folio the caller keeps locked (@lock_at) to pin the inode through
> > > the page cache: while it is locked and present,
> > > truncate_inode_pages_final() in evict() cannot make progress. But the
> > > split drops @lock_at from the page cache when it falls beyond EOF (the
> > > @end handling in __folio_freeze_and_split_unmapped()), while keeping it
> > > locked for the caller. That removes the last pin, and a concurrent final
> > > iput() can then evict and RCU-free the inode before __folio_split() is
> > > done touching mapping.
> > > 
> > > This is reachable from memory_failure(): poisoning a tail page of a
> > > shmem THP that straddles EOF makes try_to_split_thp_page() split at that
> > > page, so the dropped @lock_at is the folio returned locked. The result
> > > is a use-after-free, e.g.:
> > > 
> > >   BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
> > >    i_mmap_unlock_read include/linux/fs.h:537 [inline]
> > >    __folio_split+0x732/0x1640 mm/huge_memory.c:4100
> > >    try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
> > >    memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470
> > > 
> > >   Freed by task 4601:
> > >    shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
> > >    i_callback+0x4c/0xa0 fs/inode.c:326
> > >    destroy_inode+0x144/0x1e0 fs/inode.c:402
> > >    evict+0x57f/0xac0 fs/inode.c:870
> > > 
> > > Pin the inode with igrab() before the split and drop the reference with
> > > iput() after the last mapping dereference. igrab() returns NULL only if
> > > the inode is already being evicted (i_count 0 and I_FREEING set), which
> > > a split racing eviction can observe; there is nothing safe to split
> > > then, so return -EBUSY, which callers already handle.
> > 
> > Sashiko is worried about iput() while holding folio_lock():
> > 
> > 	https://sashiko.dev/#/patchset/20260713170915.239819-1-kirill@shutemov.name
> 
> Sashiko is right. If iput() drops the last reference and
> @lock_at is still in page cache we would self-deadlock.
> 
> I don't see an obvious solution. Will think more tomorrow.

Andrew, please drop the patch. Zi and I are discussing possible
alternatives.

https://lore.kernel.org/all/alYNlDNMQy0Fl2VB@thinkstation/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
