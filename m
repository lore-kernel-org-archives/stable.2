Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F438228A;
	Fri, 17 Jul 2026 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316551; cv=none; b=FIcVd8+ce48h7MUhD5/v54NLMbYx+m6J0Q6HbuI4R5R8BL1enFApomHiu/AMic6MVbYFlewoD//WuvVY36UR/ontoG7MgDtzEe/sp6KjHtjSJrGlHxTCtMWzCQAHqhYckB5a3jY9ImTNxuvJt4eQnXzjnDve/bo6tqqFyomP5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316551; c=relaxed/simple;
	bh=KgINJPKFLM01aqOJA6LxNGcRE/h96xrGUwHHr58I1aY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eTl1Dc3AnsG3RkE9dVXX3N1rfYQLEecO58iGA3sfXOercVpuqjdh1ZQ80mpNwmSk9FvXcbbvfgbo/6FLaaHo4GzDkKRBj/Nq0XAmqn3BxtsR0FiWbsvIR2K0lwwO1bQ5G31Ng07QNgeNGq+tndWjVDp1sa6qR3gjLPv3qZD1paY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RBUssh5E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RBUssh5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5171F000E9;
	Fri, 17 Jul 2026 19:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784316549;
	bh=ui+ORj1/z8nhcz2rVBcwlFO5TeUDA1QRckff/Axxhfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RBUssh5EaLehERy4Cgi0QGmJnAOAqgTzVfUX3zA0MRCL/hp/gU1KuyrB1kS6Q7wSc
	 3CuE6RDTXx/8Yl95lAMi7m9NoXKXnJyX7bcJPQVkywGVvyBnHKTn7ZcFYO3itBGKP1
	 rCb1/Gdr+DbERUhJfZim7lwhNLXLpKzROb62w/uo=
Date: Fri, 17 Jul 2026 12:29:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Uladzislau
 Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain
 <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, David Carlier
 <devnexen@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Denis V. Lunev"
 <den@virtuozzo.com>, stable@vger.kernel.org,
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v5 0/5] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-Id: <20260717122908.3d9f4a8ad76a748d859b43f2@linux-foundation.org>
In-Reply-To: <20260717-series-vmap-race-fix-v5-0-606a0ac6d3e5@kernel.org>
References: <20260717-series-vmap-race-fix-v5-0-606a0ac6d3e5@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 18:30:06 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> Kernel page table walkers fall into two broad categories - those ranges
> where no exclusion is required via walk_kernel_page_table_range_lockless()
> and those where exclusion is required via walk_kernel_page_table_range()
> or walk_page_range_debug().
> 
> The former category is used only by arm64 arch code operating on ranges it
> both wholly owns and does not concurrently write.
> 
> The latter category consists of kernel page table walkers operating on
> ranges that are wholly owned (but which need exclusion against concurrent
> writers).
> 
> The lock used for exclusion is the mmap lock, and for kernel ranges this
> the mmap lock on init_mm.
> 
> ptdump is a special case being both the only user of
> walk_page_range_debug(), and the only case in which it walks ranges it does
> not own.
> 
> This presents a problem, as page tables may be freed under ptdump. And
> indeed there is a use-after-free bug in the kernel as a result, which this
> series addresses.
> 
> ...
>
> This series works around this by #ifndef CONFIG_ARM64'ing the mmap read
> lock in vmap logic, then partially reverting commit fa93b45fd397 ("arm64:
> Enable vmalloc-huge with ptdump"), keeping the enablement of huge vmap
> support, and removing the ifdeffery with the partial revert patch.
> 

Thanks, I updated mm-hotfixes-unstable to this version.

> v5:
> * Rebased on latest master of Linus's tree.
> * Accumulated tags, thanks everybody!
> * Added additional commit to fix race between CPA collapse/attribute set.
> * Slight commit message tweaks.

Here's how v5 altered mm.git.  This is from the addition of [3/5] - no
other patches changed.


 arch/x86/mm/pat/set_memory.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/mm/pat/set_memory.c~b
+++ a/arch/x86/mm/pat/set_memory.c
@@ -2122,7 +2122,9 @@ static int change_page_attr_set_clr(unsi
 	cpa.curpage = 0;
 	cpa.force_split = force_split;
 
-	ret = __change_page_attr_set_clr(&cpa, 1);
+	/* Avoid race with concurrent CPA collapse. */
+	scoped_guard(mmap_read_lock, &init_mm)
+		ret = __change_page_attr_set_clr(&cpa, 1);
 
 	/*
 	 * Check whether we really changed something:
_

