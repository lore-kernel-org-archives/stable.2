Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CA04218B1;
	Mon, 13 Jul 2026 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949534; cv=none; b=aySLHdO0roYZr3G8Qy/6AjkOQbsV19+rNtnTflV7UyAg3aTT1h4rRa49rKXo0seczaLZlLvXisA0DhXcxDbthvIxooynuZjAM/XXL8PjVo9Anl9/CpEKudrwD8GVJjz4ILuT1nWB/Zz+Q5JdX8C/ZylRDTDK8qZ1qdx1S+ArAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949534; c=relaxed/simple;
	bh=RMBNf0nz6UqVKObHbtRoALMqXm0jYPaVeg/zELKfVqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyC8EigVemr2f6e5jXwJZHd4ilLjfdYPSwBkur8aJLUDg9CbxlI8TDH8WLVkvHVUAZ+hdZYcQXrBsC3iLLAmK97rB6iodWjaTgotOXgR0873lFhiI2kv6Dnx2kSmHXO/1sWmJT7IAoR2HKEZe0+NUNBxc13+AqpLk3FOUcVqzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaxJIDin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaxJIDin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9BD1F000E9;
	Mon, 13 Jul 2026 13:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949532;
	bh=HebesSjqW6Ei186xyy2KHgsVFXclOSjyLdpPX4+hId0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HaxJIDinBW7qhd8TWrNK4s8T3PTUfLTXFXS85kDKWcN4pWvtuL6xy0nsCIx7iq40O
	 QxcAYjybAjwroqbFOs9TRta3swb5bYhfKBvWawcyqH0Zge2Lx6VdtiZhiBafycuXNH
	 i4/Vlvk4FSU2fyS8bhx8BrQr4NQvM3DRQrVhBKQMkp91hb5Fa4g7Pw14ueQNVgVdTi
	 /h2k/N+9tWkQ4UDofeftbfgEXnxzcX8poyxZ4F8EiUKIMqeXWUW1W0KUWktE6mpRmX
	 RGfWv776A9M5DdWrONyX3UluBAo//ouIVD4GlnqfJmLYmgxG+cxXo7deuEwlEEEjCb
	 MiFOa9IU3UB2A==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id DF046F40119;
	Mon, 13 Jul 2026 09:32:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 09:32:10 -0400
X-ME-Sender: <xms:2uhUajOJ6o0IkHECCjHAkKUVhPE0Boq32n16IxuwUb8qx_me03fgwg>
    <xme:2uhUaua0NvhWILEF9Sxf9_9wz151PQ8fPiEp73LaeMgWC-DQJaiXxn4HYApdFNqVD
    pkxd-bsOBJpRWdPvlmMSXRDek6HhjKp5vhX3BvtHxdpR6RBZu_qS1H->
X-ME-Received: <xmr:2uhUajtAPLpWxfCImZEQ7-lfeyLnIftK-qeVlUcWfWQghfbRNQiHsjuNUz5QMA>
X-ME-Proxy-Cause: dmFkZTGZpmVpeDsjZ8Vo2Jq64/2U20HFa/JrgfKn6CiNifuBo1pzPMXk0a4NqT0VMciG8K
    SugdcXNhzIz2GGRAcNPbldLn+3yx1gRLwC0eqh8SjcuMzzoyAOiQcW15pHkFoUU8sU93Ol
    20upXRjRc9bBvKSvF+ldu18a4Su7mlFUTAvgOHmfQ4EOLFyHDZ9CXRB5B0cLlRIRNNuJ69
    LDPcIZFQurDXONw9w7x2l+i30vbvXOnao60OZfbfVAcAC/fcUzZNKRbLUxuPN7zU2u+h2L
    lu3b55TVWwqQsO6vcM7WnlDCmGUWatjBJ4CSoYLZcP+x21iYiTGDYJ0lfqOuP9kAzP2JPg
    j8w8DwhG5wOdhN2Rk3Rdg8n9nLNaujJTGC620J5zoH7n5t3hX39aCaLsRBN9JGDO7mcmWL
    IzaLYY9N+V442PvDjYSTXuP4EHvI6v+fcV6Q/yTDaPZDQgnHPe1yyzGNJzxCUjaYKCCdpO
    z/OkCkLFvQT3MiYbDmeWq3a8qm4Z/Agi5IGGkB4PZs8GgeaaaXu1uHQ/ufm4VZ9+64V+QE
    8QtfNFMPv+xm7WYMT9O2psU2UIaozivzoRxbp2UTRKG5DvsMUoVZyOCnD4i8d0NJq/Rqe9
    jTIL8srd7T6/FERCHRYF/A9blfowGsOrxRZc+ML2aNnL8IwcxIqNnPaId1jw
X-ME-Proxy: <xmx:2uhUanuCa_oH3IVyt_HoThgNWUvv1acMMJfbjC90H2Nq77p1x1F7Lw>
    <xmx:2uhUaq189DO0V2p_spqOaFhIiqFBrCec7III9gjx4U0IMtDvOnqvgQ>
    <xmx:2uhUasO-I4V3wpEwkUedoK1wopX28y3s7esdQvgnTjYsrDF-dVm1hg>
    <xmx:2uhUan593b1xCOHaLKH3StbrybHDors6AC91jhpaHmP9qnHIgWbSqw>
    <xmx:2uhUara1OWRFLjD_9gN1CsUt5A0pYmkwSJBsl-81U2gW-oJMg0OqiWDs>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 09:32:09 -0400 (EDT)
Date: Mon, 13 Jul 2026 14:32:09 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 	Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 	Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, 	Uladzislau Rezki <urezki@gmail.com>,
 Toshi Kani <toshi.kani@hpe.com>,
 	Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 	Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, 	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 	"H. Peter Anvin" <hpa@zytor.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 	Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, 	David Carlier <devnexen@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 	bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v2 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-ID: <alTn7NguEW_4bodu@thinkstation>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>

On Sun, Jul 12, 2026 at 11:42:23AM +0100, Lorenzo Stoakes wrote:
> This series addresses the issue by having the vmap huge promotion
> logic acquire the mmap read lock while both setting the huge page
> table entry and freeing the prior leaf page table.

Hi Lorenzo,

Before we settle on the mmap lock scheme, have you considered handling
this the way GUP-fast handles page table freeing -- RCU-defer the free
and make ptdump a lockless walker?

The locking here is inverted from what one would normally expect
(walker takes the write lock, mutators take read locks, mutators safe
against each other only by range ownership). It works, but it is
subtle, it is what produced the arm64 deadlock and the ifdeffery, and
it depends on every current and future freeing site remembering the
rule -- patch 3 exists because two walkers did not fit the scheme.

The free side looks cheap: kernel page table freeing already funnels
through pagetable_free_kernel(), which already has a deferred path
(used for IOMMU SVA). Adding a grace period there -- synchronize_rcu()
in the worker, amortized over the batch -- covers every freeing site
by construction.

On the walk side, nothing on the ptdump path can sleep -- the pagewalk
core only allocates for install_pte ops, kernel PTE level uses
pte_offset_kernel(), and the arch note_page() implementations are
seq_printf()/printk() into a preallocated buffer. So the walk could run
under rcu_read_lock() as is. The real work is bounding the read-side
sections: a full walk can take dozens of seconds on a KASAN kernel per
the comment in mm/ptdump.c, so it would need to drop RCU and
cond_resched() periodically, re-descending from the top. Note we
currently hold the init_mm mmap write lock across those same dozens of
seconds, and this series makes that load-bearing: during a long walk
every promotion trylock fails, silently degrading vmalloc to small
pages, and CPA collapse blocks.

That would give us: no inverted locking, no arm64 deadlock possibility
(your patch 4 stands on its own), the patch 3 walkers covered
structurally rather than by locking init_mm as well, and ptdump
invisible to production paths.

Given the live UAF, this could also be a follow-up rather than a
respin. But I would like to hear whether you see a fatal flaw in the
approach first.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
