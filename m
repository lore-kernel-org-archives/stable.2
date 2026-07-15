Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31544685C;
	Wed, 15 Jul 2026 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127698; cv=none; b=JNvQnOEx+wOSInBcBhGBA/bzy4VEVMAL6tfBrrLGV1Ezh1LjqMSBWHbQdM25/uk6+6bf7im7N310IBxBfgGiCDyqgFrKx5LfrgxtESyfh8nL4PWqd214Cx4eVtjWT2EpaQrc79AY2kuKLUIejByxpZVzFjotkz5m+MjOpYXkWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127698; c=relaxed/simple;
	bh=kAzRGKP92JPZRRbuxgorrVVah4f5tGWg7tnMlFAPBmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/b5ZLJd+r8+649x8VXmEDaTw0Zc5UkFu6jPBxQ6TdeZukY4yLtzhCl347ejBHOpBv6euN1857tp85ijhIFhVgJjwmT6yzGZjy5WmTMOfPHRRgdheQPZkIL+uzrAKsUVYiFryToCq281JWO2PMOWkuJQfseTKGNnC35vbf2EdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPiuISMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPiuISMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95521F000E9;
	Wed, 15 Jul 2026 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784127696;
	bh=9Z2zNKjRbgDz18AB/OdbEQN5wpqYTgFBDPBnDwJEk2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cPiuISMOHZKbNJ/q+U6zBqKZl6i/54DB+RZCuayF6sI/kqfwtjdaALQ69uJ88Y9Tb
	 t9oj0Gwrjx61elraU/lF3M+8XrCqQFajfZU2mv8YfRrP78r/Wx340y3KQ4iUlEGzM5
	 eE16z35L/cQdoa8olim+hEXZt4VTFLQlzUnuc/usVzrf89juTGp0WUhVkaElN3dhQx
	 LbUCrcNvso4ErQy0XseZ4PxpaGqrP2jfw6djWjwKyuHqNf1PD0jPkdNqnYsTErA07p
	 qx9E+rQb+xIH6dJ9sMrZ7/kfrX+NQDC/1YbeWlscd9NRHmuuwccHGiNexKkLt5Onau
	 bl+psB0aDqyCw==
Date: Wed, 15 Jul 2026 16:01:18 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Carlier <devnexen@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH mm-hotfixes v2 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-ID: <aleYrvnf4nVUCu-f@lucifer>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <alTn7NguEW_4bodu@thinkstation>
 <alTq4V50767L-s5H@lucifer>
 <alUNiWcygLd4rqBo@thinkstation>
 <178404602957.85099.8935151447302412515.b4-reply@b4>
 <alZm0tBf8DpMXimM@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alZm0tBf8DpMXimM@thinkstation>

+cc Lance for thanks :)

On Tue, Jul 14, 2026 at 06:05:01PM +0100, Kiryl Shutsemau wrote:
> On Tue, Jul 14, 2026 at 05:20:29PM +0100, Lorenzo Stoakes (ARM) wrote:
> > Basically you need the IRQs disabled to get the semi-RCU behaviour and to
> > be able to safely traverse page tables that way.
> >
> > So with CONFIG_PT_RECLAIM you're safe to RCU traverse PTEs only.
>
> I think this is stale. Since 1fb3d8c20bfa ("mm/mmu_gather: replace IPI
> with synchronize_rcu() when batch allocation fails") the !PT_RECLAIM
> fallback is a real grace period -- note your own quote of
> __tlb_remove_table_one() calls tlb_remove_table_sync_rcu(), which is
> synchronize_rcu() nowadays, not the IPI broadcast. The name invites
> the confusion.

Ahhh, nice thank you Lance :)


>
> Together with a37259732a7d ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE
> unconditional") that means every freeing path through the generic
> mmu_gather is genuine RCU, batched or not, all levels. A plain
> rcu_read_lock() walker is protected; IRQs disabled is not required.

Lovely. I'll probably send a patch to fix the comment then :)

>
> > HAVE_ARCH_TLB_REMOVE_TABLE is set for powerpc, which also enables PTDUMP :)
> > and that's because it actually tracks multiple PTE page tables together as
> > a fragment.
>
> sparc also sets it with SMP. So the audit list for custom
> tlb_remove_table() implementations is powerpc and sparc -- everything
> else gets the generic behaviour above.

Yeah.

>
> No disagreement on the rest: the walker needs
> ptep_get_lockless()/pmdp_get_lockless(), and the ppc kernel-side
> fragments need a look.

Indeed.

I know Suren's been taken a look at this, pinged him off-list (he's also
cc'd) to see where he's at but I'm going to take a general look at this.

I feel that RCU page table freeing is likely to be a requirement for
scalable CoW, so directly impacts me :)

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Cheers, Lorenzo
