Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B337A83F;
	Thu, 23 Jul 2026 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784849209; cv=none; b=iLSmSKPnzKBrPck2xVTj8UlixG15McAQcFBL2pic/52TOczUx/THF+DBuDWJRIX3wquezJpD8WX3zZVFM6bNUP1Slq3pvwTwCa8dk43Id3QbspTFW2iqxNbszqViW9RZkFuS4JkJCi583T/MbZ881aLgrYELt88NRD5n2X5CzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784849209; c=relaxed/simple;
	bh=7yPsWzW7Ef3YWJHoXc5/fdlErM9699Z1jMeBmq8yyE0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D38Z2EKb3sRbyRoL+NBUtBm/BlbI+Wy3dDPazN6/NOczsbWKtV7aDtKpDayPFk4CqLR1PbkCabOLwS3ya4vU2PKvCoOC7IHVYWWgPmaI/adnJUX7BIEoEItJjvg5uAEqUqXbuggOx3Ws0mrOhSGa0FjFMCPZZYTrEnEaukAEzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JgkzM7dC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JgkzM7dC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2061F000E9;
	Thu, 23 Jul 2026 23:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784849207;
	bh=iglblMPnjAGanPHzfwJ4G7yTcJ+FyPGK1MRMDiMSvoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JgkzM7dCM/Zxzo/X33WrAwQ6AAb4lf99G+tDra7/PJLz60BVyuGbnByOdwXTvCHUr
	 8ixHDSHqInlknVMXcQa9n0XkZXXdkSNo2VuXqP8GFWbHnVhkRGfTdswcCbcqyHGfmk
	 OlbDd+NmHmHOgbEeFTTzgxwjrDukDaeRj2Aaa/Uc=
Date: Thu, 23 Jul 2026 16:26:46 -0700
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
 <den@virtuozzo.com>, "Borah, Chaitanya Kumar"
 <chaitanya.kumar.borah@intel.com>, stable@vger.kernel.org,
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v6 0/5] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-Id: <20260723162646.350cf3bf415a0855140d139b@linux-foundation.org>
In-Reply-To: <20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org>
References: <20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 16:16:30 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> Kernel page table walkers fall into two broad categories - those ranges
> where no exclusion is required via walk_kernel_page_table_range_lockless()
> and those where exclusion is required via walk_kernel_page_table_range()
> or walk_page_range_debug().
> 
> ...
>
> This series works around this by #ifndef CONFIG_ARM64'ing the mmap read
> lock in vmap logic, then partially reverting commit fa93b45fd397 ("arm64:
> Enable vmalloc-huge with ptdump"), keeping the enablement of huge vmap
> support, and removing the ifdeffery with the partial revert patch.
>
> ...
>

Thanks, I updated the mm-hotfixes-unstable branch to this version.

> ---
> v6:
> * Rebased on latest master of Linus's tree.
> * Updated: 3/5 to drop the init_mm lock over page table allocation in order
>   to avoid deadlocks due to init_mm -> ... -> fs_reclaim -> init_mm
>   dependency cycles, as reported by Chaitanya with thanks!
> * Small cover letter typo fixes.

Here's how v6 altered mm.git:


 arch/x86/mm/pat/set_memory.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/arch/x86/mm/pat/set_memory.c~b
+++ a/arch/x86/mm/pat/set_memory.c
@@ -50,7 +50,8 @@ struct cpa_data {
 	unsigned int	flags;
 	unsigned int	force_split		: 1,
 			force_static_prot	: 1,
-			force_flush_all		: 1;
+			force_flush_all		: 1,
+			init_mm_read_locked	: 1;
 	struct page	**pages;
 };
 
@@ -1250,7 +1251,11 @@ static int split_large_page(struct cpa_d
 
 	if (!debug_pagealloc_enabled())
 		spin_unlock(&cpa_lock);
+	if (cpa->init_mm_read_locked)
+		mmap_read_unlock(&init_mm);
 	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+	if (cpa->init_mm_read_locked)
+		mmap_read_lock(&init_mm);
 	if (!debug_pagealloc_enabled())
 		spin_lock(&cpa_lock);
 	if (!ptdesc)
@@ -2123,8 +2128,10 @@ static int change_page_attr_set_clr(unsi
 	cpa.force_split = force_split;
 
 	/* Avoid race with concurrent CPA collapse. */
+	cpa.init_mm_read_locked = true;
 	scoped_guard(mmap_read_lock, &init_mm)
 		ret = __change_page_attr_set_clr(&cpa, 1);
+	cpa.init_mm_read_locked = false;
 
 	/*
 	 * Check whether we really changed something:
_

