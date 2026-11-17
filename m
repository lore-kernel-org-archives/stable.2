Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908140;
	b=crwUK2DQD7cbL8nYzy0ZahbyEjhrdS7FtxbTL2cO0ndbvdAJZE4cBmsqFe2gYP9KKu9S
	 7dC7HsU99KKwL+qi1ZnIx2swiDfhlvlqhEVvGVA+BfLrY8eC4gkEff9zAk3VvCCUm0NpC
	 IvknMHXTOhNZXz7i9pHZDLa6eKsoYHoQudKbu9o7OsHa1U7GJXYVQjT4M4ouDMiA9CWmi
	 10dMv+2VeQN+su3uCeM564PmROPDAfzhZBS1OJ20mBJOCAjFFfvpPyhovrB8Jadeh5XXS
	 Kd38DlHN/Q0b/1CyUA/ZBXW+Dd1X697ySLANNV794S2h7MkvYfEOiP8w1g42NP/b1Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908140;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OhiR+JSPx8omGjT6b8YvAiFiu4YN/j7mPCjJR2bPM4M=;
	b=0JVvMRMQOK9NO1Xp9k50FbW9440v7lPlfGg9rI8IXr5lM95+ur28zeG3Dd7XiADjPW4+
	 YhCkh+9X7NPVHlTKeDKcGRr4f3F8YaNJDVB0WuJ4bSIDXYlb/Vd2zRAeWA7Hoh8hKD0b/
	 2qvuHtDN5iSNx9BeKt2PJtO/BONyzQYuhHIUqNEaJ6N/OMuZqlTnuastUuZ1YVupPzVhK
	 OM9KTW7LTlwfYnAyTL6aiHFs95VlcyZITTwB2cR/k95GuoJIBc2o5NcTvEzWJEXqOKUBc
	 stNzgQobF8M2o7jWxXQO6pEj4SKZleJBWQzrLblUZf4qiBabAZJiqjz7FcH3PCptojA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeiMapPB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8DB606A31C;
	Tue, 17 Nov 2026 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeiMapPB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4831F000C7;
	Tue, 17 Nov 2026 09:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908139;
	bh=OhiR+JSPx8omGjT6b8YvAiFiu4YN/j7mPCjJR2bPM4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DeiMapPBv1qnuZUks3+vkS9vQKhSFANKRAJ00GG+00KAmW2BdHrdtW8WHT3e7iLFT
	 nFsxfKcIH+zwLmNxDc5T82lDHypUqr4zvbMzkDiBdX2xlVsMRMDXlYIUMN86mqKymX
	 LPDm1tMHkzqr+5j3EGKoPojPubh99V3FTvO4EHnXyOT6BZr6aCr784DVkDXJ09lGLZ
	 1VMTbY4l0g4skbmWuvlOozXZGbmB3QTOv8+K+o3njnYzVx5p4wxsAAor6jUfgfr3aR
	 Yqx/cKJrh+//dpjUnqtVm56/u+soAo0+ZDo/oDtwLoIAOUEg9Q6UoAbP+CbK3yiizj
	 QvU61S7rOaqjw==
Date: Tue, 17 Nov 2026 09:35:30 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
	Roman Kisel <romank@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Naman Jain <namjain@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/memory: remove racy huge PMD assertion from
 walk_to_pmd()
Message-ID: <avwbrON3_cCtaR20@gremlin>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-1-537605643f6f@kernel.org>
 <dccf94b3-b901-4311-a233-488c87195dc5@kernel.org>
 <avs1rOJQ1gV33z8w@gremlin>
 <61d4f3ee-7a0b-4a8b-b5a2-35380dd46b4c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d4f3ee-7a0b-4a8b-b5a2-35380dd46b4c@kernel.org>

On Mon, Nov 16, 2026 at 09:06:21PM +0100, David Hildenbrand (Arm) wrote:
> On 11/16/26 18:10, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Nov 16, 2026 at 04:56:25PM +0100, David Hildenbrand (Arm) wrote:
> >> On 11/15/26 21:58, Lorenzo Stoakes (ARM) wrote:
> >>> From: Eliav Farber <farbere@amazon.com>
> >>>
> >>> walk_to_pmd() asserts that the PMD entry it returns is not huge, but does
> >>> so without holding the PMD lock, so the assertion is only valid if nothing
> >>> can concurrently install a huge PMD entry in the range.
> >>>
> >>> This is not the case for a VMA whose driver implements both ->fault and
> >>> ->huge_fault and which invokes vmf_insert_pfn() from the former.
> >>>
> >>> The existence of prctl(PR_SET_THP_DISABLE) is problematic here, as it only
> >>> takes the mmap write lock and faults taken under the VMA lock are
> >>> unaffected by this.
> >>>
> >>> This can result in two concurrent threads faulting the same thing
> >>> disagreeing as to whether to attempt a huge fault and thus ->fault and
> >>> ->huge_fault running at the same time and triggering this assertion.
> >>>
> >>> So just remove the assert.
> >>>
> >>> Target the commit which introduced the first driver able to do this for the
> >>> fix - vfio-pci. DAX also mixes fault orders within a VMA, but serialises
> >>> them using its own mapping entry lock.
> >>>
> >>> Link: https://lore.kernel.org/all/20261112051440.16140-2-farbere@amazon.com/
> >>> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Eliav Farber <farbere@amazon.com>
> >>> [ ljs: rewrote commit message ]
> >>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >>> ---
> >>>  mm/memory.c | 1 -
> >>>  1 file changed, 1 deletion(-)
> >>>
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index 3a20d64fd276..e03110906aa8 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -2384,7 +2384,6 @@ static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigned long addr)
> >>>  	if (!pmd)
> >>>  		return NULL;
> >>>
> >>> -	VM_BUG_ON(pmd_trans_huge(*pmd));
> >>>  	return pmd;
> >>>  }
> >>>
> >>>
> >>
> >> Could this also stumble over a huge PUD somehow? Should we just prepare it for
> >> any leaves and bail out if we find some?
> >
> > No, walk_to_pmd() can only come from the order-0 path right now and
> > __handle_mm_fault() makes sure that can't happen in the fault path:
>
> That implies that get_locked_pte() and all insert_pages interfaces can only be
> called from that path in __handle_mm_fault().
>
> x86 an s390x use get_locked_pte() for some other paths, so I wouldn't want to
> trust on that :)

Well, I had claude go look through everything and there are no paths which are
problematic _now_ :) but future-proofing is a good idea because assumptions like
this bite you in the... assembly *ahem*

>
> (did I say that I hate walk_to_pmd and get_locked_pte? But you likely guessed it
> at this point lol)

Yeah they're bloody awful aren't they? :)

>
> >
> > 	vmf.pmd = pmd_alloc(mm, vmf.pud, address);
> > 	if (!vmf.pmd)
> > 		return VM_FAULT_OOM;
> >
> > 	/* Huge pud page fault raced with pmd_alloc? */
> > 	if (pud_trans_unstable(vmf.pud))
> > 		goto retry_pud;
> >
> > So by the time any ->fault path runs, the PUD is stable.
> >
> > We don't have to worry about the mmap paths as at that point nothing has
> > faulted in and it's all fresh.
> >
> > So it's all safe as things stand.
> >
> > But could update for future-proofing like:
> >
> > 	/* PUD leaf might have been installed. */
> > 	if (pud_trans_unstable(pud))
> > 		return NULL;
>
> Yeah, that makes sense. I was just wondering whether we'd actually want to
> return a proper error then instead, because this would not be an -ENOMEM case.

Let me have a fiddle and see what I can come up with, maybe we can use this as
an excuse to improve things a bit... :)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
