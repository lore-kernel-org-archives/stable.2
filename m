Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84B381E92
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653569; cv=none; b=pnwUT8O78AE31KQN6CkLp91rJIFUg+ciPLjfQaqlRJ04C71xlfGIhD5kx5ZvP6LwIRN62nLHpr2JIKB6CCZE7FCC9zAPSf2i9CFbkvmZZwN8Jh0SdQN7QwFRJV7i6ixYUd69cOrrKRDQEjb/y8QBJCwyMoWb2T873Lo6R6dGYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653569; c=relaxed/simple;
	bh=4IrHsiAS5RlY/yZO5MU8rItGwplYzpm+UIMFHUYdnGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1YVmHycVU6B42UPDlLBWhZxA7WD3YiZTY9XifQqoViUeuP4XKrh1edw7ca3FR0nWsKBWtKrIgsrSNgX4TgvI7vO1R/5A3Oy4LtF8KY4AaqMn5fVL4eneh9M/OL4sT+edb4Lxl2qUOO0OOd/xpq0zorcW2KBMDnmzDmkERI8v44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9FK3e8F; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9FK3e8F"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38511175ad3so9423217a91.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784653567; x=1785258367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UaZs0dUksz9lWWombvtYA7KfGwaIYElA59FlH0y/uOc=;
        b=d9FK3e8FyUAgFPXiYlNefAbGWFW1kC9ZsLQnIwzOjVewPtv32w647EgevRHL//w36o
         FEO24GZsOahUTAud+At9XUXnDxvq01EBLtrGfq7pPQK1GuG6pnyyOOgMR0Cjb6SPCBhy
         3m3cUMQh7F7DULAt7hbPNJ/wx0dVktEj+vIiLYT6rkGqLuAk/vmZ3SV8wuCnS9hNtDm5
         S4sggOzTL05KTrGVV9FOmPI1n0bkyr/La/a5uBPKyIyKGmUn93q31QLlH6a4SSqsSsWm
         vCtKyGcx1w/Wwg3YmQa0kQ0MAdUavj/2Kb3Kkuh54lXvLrxG8qVS9RnUTNJ6giZzX1Rs
         EcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653567; x=1785258367;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaZs0dUksz9lWWombvtYA7KfGwaIYElA59FlH0y/uOc=;
        b=Tm3YJHic6RsjWqOOMdccLBBzYqzyRqFZPbMF3wIHsVb0eReBkOCDU7LMquRxbJjv+s
         zbt0rVECBPRdY6HgDpnvVXnkAA5HdIg8wvnVn+/MyKZ0bJWguUngZC5R38AeOtQKu/S0
         poKC7l5J8Bh7MDi5Y7G/ngAeJ9Op6qCwCLFAxI0a7c/8/j6+TaasKFRoBWCN7TqEVzps
         gzmFUjXcxlQe/zEYl9TJgFb638u45oqMiRvHqAFj50tmm3oFyaUHqO6RmiWVwN9Y4xJs
         xtuAPqobOzHbzVuq3OvzCnwpQloR8dZnuAIL3AdZ0VdMDSgRAw3+ymK4x5Vl3Bv2awbF
         o5kw==
X-Forwarded-Encrypted: i=1; AHgh+RqsXf2CETnB2d4dgqUdBMi6vz/jls6N7B44Kd2Nyze/GIHzMuKgJU/VTi1ulAsftpM4tSPXFSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvX7k6WShGwYXb0YCzse/xdlmw2WP0BVBoEpzvijWBE90ZLO6o
	tP4aQzl0bOEhI8pU1E7raT+rrKDUUHzyAb4XWmN5V88FdwnKjhGJ9Ajy
X-Gm-Gg: AR+sD12dax1mv9aJqvPrt3K6nFVGSVYTguuLxF1g4PUPjSW1pVv71aaiPLcMday6r9o
	W/G1pewXq5uvQB+vYFQLYVWWtDTuj9MZIAi5WeKVQhUwwMZAiBRhwY0vTreRX4ZHYLahFL7GIir
	dBkED8J5jKgnLO8sKEUKVrbmckvlZQSEA1k7yKLySHhmkwu1ERdw/DKfuMiwWE6H1nlG+wkDMQa
	JV/jE+JtVXnuh1iPjAMcSXamsi5+FW7dRmn1FtEOR/vsslgj5Z0SNdcbObQpO5ySSIFsHPeC+Xf
	Pb31oLFrrY7OVCNy8O38bomZ0xjXUbriGdIKivhZLtY4qYLeAQXNFefmDXg+SsaWvGTNjSynr9r
	7F0PcjQrrRqxEVWgoR1JFpHBsZZNJSVzYA29GZIC04N3DSpXdkdPGmK76o9fLOfGrhMMVngf8+P
	iSZeRe2mPJrO0pnMZ4EyfG7WaSp6jcIwdg7A==
X-Received: by 2002:a17:90b:17cc:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-38e4b3dc089mr20506488a91.4.1784653567393;
        Tue, 21 Jul 2026 10:06:07 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb6e8sm39508170c88.9.2026.07.21.10.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:06:06 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:06:03 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Kiryl Shutsemau <kas@kernel.org>,
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: allocate split page tables as kernel page
 tables
Message-ID: <al-m-6iCSScC7M9x@fedora>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
 <al5-fDRStgU6gjk6@fedora>
 <al5_Le9QlD4zlt25@fedora>
 <al8hE_ded6qyWiDv@lucifer>
 <al8_xx_99BjAUn5A@fedora>
 <al9BpTu2ma8GpiPW@lucifer>
 <al9KzIhKXa3PCMqa@kernel.org>
 <al9b5uE-ep9ADtLt@lucifer>
 <al9hMyqpjd4l0Fql@lucifer>
 <al95Y5aXof0ISEkI@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al95Y5aXof0ISEkI@kernel.org>

On Tue, Jul 21, 2026 at 04:51:31PM +0300, Mike Rapoport wrote:
> On Tue, Jul 21, 2026 at 01:09:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Jul 21, 2026 at 01:00:53PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Jul 21, 2026 at 01:32:44PM +0300, Mike Rapoport wrote:
> > > > On Tue, Jul 21, 2026 at 10:58:50AM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > > On Tue, Jul 21, 2026 at 02:45:43AM -0700, Vishal Moola wrote:
> > > > > > >
> > > > > > > Well some kernel page tables are still allocated without ctor (early allocated
> > > > > > > direct map for isntance), and if you did pagetable_dtor_free() it
> > > > > > > unconditionally calls pagetable_dtor().
> > > >
> > > > TBH, I cannot think of a scenario when page tables allocated at boot would
> > > > be collapsed. But surely, checking the page type is safer just in case.
> > >
> > > Yeah nor can to be honest, anything that could be made large in the direct map
> > > would already be large right?
> > >
> > > But it's 'just in case' somebody did something dumb :) Later can maybe make it a
> > > WARN_ON(). But just to fix the proximate issue for now.
> > >
> > > >
> > > > > > > The ptlock_free() and __folio_clear_pgtable() there would be harmelss (no locks
> > > > > > > assigned for kernel page table, and if PG_table never set clearing it is a noop)
> > > > > > > but the lruvec_stat_sub_folio() would cause an unbalanced decrement of
> > > > > > > nr_page_table_pages.
> > > > > >
> > > > > > Gotcha, thanks for the explanation :)
> > > > >
> > > > > No worries, this is subtle stuff with lots of weird gotchas and stuff we need to
> > > > > improve... I seem to have fallen down an unexpected rabbit hole with these fixes
> > > > > :)
> > > > >
> > > > > >
> > > > > > > It sucks, but until everything is updated to call the ctor we have to do it this
> > > > > > > way :>)
> > > > > >
> > > > > > Yeah that makes sense. Although I'd rather see the condition as:
> > > > > > if(PageTable(ptdesc_page(...)))
> > > > > >
> > > > > > We really shouldn't be calling ptdesc_folio() anywhere anymore.
> > > > >
> > > > > I think better for a follow up since the code already uses ptdesc all over the
> > > > > place (fundamental to the approach really, keeping a list of page tables etc.)
> > > > > and this is a fix that needs backporting.
> > > >
> > > > I agree with Vishal that it's better to use page type rather than folio
> > > > type. And it's the same for backporting ;-)
> > >
> > > Ah sorry misunderstood, you mean straight up PageTable(ptdesc_page()), I thought
> > > Vishal was saying we shouldn't be directly referencing ptdesc's at all (which
> > > would be the rework).
> > >
> > > I guess definitionally page tables are never folios. I lazily went with what I
> > > saw elsewhere, my bad :)
> > 
> > Ah yeah I remember now, i saw __pagetable_ctor() dealt with folios:
> > 
> > static inline void __pagetable_ctor(struct ptdesc *ptdesc)
> > {
> > 	struct folio *folio = ptdesc_folio(ptdesc);
> > 
> > 	__folio_set_pgtable(folio);
> > 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
> > }
> > 
> > 
> > And was like 'huh?' (surely definitionally they're _not_ folios) but went with
> > that on that basis.
> 
> I wonder why setting the type is even in ctor rather than in allocation.

Yeah, you're not the only one wondering that ;)

Kevin is actively looking at moving those to the allocation/free site instead[1]!

> > Another place to clean up I guess? (that one _definitely_ is a follow up though
> > ;)
> 
> Yep :)

Yup. It makes most sense to clean those up when we add a per-memdesc
api (i.e. for memcg in this case). I haven't really had the time to work
on those though :/

> > Cheers, Lorenzo
> 
> -- 
> Sincerely yours,
> Mike.

[1] https://lore.kernel.org/linux-mm/20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com/
