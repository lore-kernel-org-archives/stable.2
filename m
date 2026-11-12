Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485685;
	b=JDFrptrgciNAwYGDPdCEEvfPjzupnSHnHxKQd70Npmce0yewFa2/fX749agmgVroNAwg
	 cBVxeahOfMgB2IEkkzwWI3ki4kRFTWSVBnHlRa4p2BNQuxXk6cbUzU9hIWFGrynf9i+Pg
	 KSYr8OBt6V8FGSEPzOgKBVzII0/OMbOwTVZTJUsChULYXYTG3wuK2ooSJfEbWVaELRS+g
	 A8A2yiQl2NPEC9vCfa62KQqEnhU/+iTKVsA8nxEB8MwcAGeMtmL+sHZN3vmePGsxOLyY7
	 SLPgVcwzIJUzzdKERgXL0/JEX9JfGtne4nCpymAxrpGrckNgWVzb9O4gcCFKH9DffuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485685;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wSnWAvHtOMLFz4uzS2KYZ1SGi9EBgJHHln4xOPRtuRk=;
	b=P7PLIz7WUthiDfmf/ZKRYt4wsjfiYclbOtz9lrpm4AULHc3v8BTf9orD+glb/pRkneHO
	 wwQUMNNXgOjtg94vxL+Khp3yivIKjJoYvb34Q/fna2cnkcwPY3oZOA0tpiZeo/6H2hWmD
	 6GOieVBzBXPpa3TUgYX5aqCZLsJAbaCIDwu7XT8tCGxbXJvR/CNqv12Rar2C8UnDuRfL9
	 yu25AoR94zLX6qg3NqLQcIto3x3xwtOY6WUxj4b8uxwTkdTlO+GA3mXIYGZqeINee1c73
	 W0L4RG8mNKdbVoOujNwpJQyC3XU3Iv/s5idZwCSKMr/jUgJyIaBdbE9cpXp6VqnDApA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsCxIx0m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA10606A31C;
	Thu, 12 Nov 2026 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsCxIx0m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2E41F00A05;
	Thu, 12 Nov 2026 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794485684;
	bh=wSnWAvHtOMLFz4uzS2KYZ1SGi9EBgJHHln4xOPRtuRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CsCxIx0mR38bvlIFQiBxk6+Y9l6TgU4JRu2TXLPxpT1XJ38vOTZZbnd1ZUZe8XzPb
	 dZATWSN8bWSnf0qiSj/ZV8qjWjo38tSH971twZOTE//E6H7RuMnWH6EZ83OrW7/kDw
	 oid/SOUPKzABd6rrkVbxx5EYkuvgwW81uSn/A2OeHHZgYBQSEKwKF3jpQt8pHj+z3D
	 HXyrC3HAd8WA+VnndLLwi9Oflq7MJ58ptZ+ulVlE2e/x1xoHcHSjCAVGIUAC4hxQGo
	 4MqCwGhcqHsaFME19gmDjPiewxeNNV7+idvhLMxcj7jTNhpL7vEnW4qPnCkPZYmhwq
	 ZmrmnDDcAZhlw==
Date: Thu, 12 Nov 2026 12:14:32 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avWsG-zmuniUFio7@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <avWmfXu39vtp0DM9@tiehlicka>
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
In-Reply-To: <avWmfXu39vtp0DM9@tiehlicka>

On Thu, Nov 12, 2026 at 12:43:57PM +0100, Michal Hocko wrote:
> On Wed 11-11-26 18:13:15, Lorenzo Stoakes (ARM) wrote:
> > The OOM killer can quickly trigger again after having selected a
> > victim. That victim might not have freed its memory yet, but its mm will
> > be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.
> >
> > This can cause the OOM killer to kill an innocent process when the first
> > might have freed enough memory to relieve the memory pressure.
> >
> > Fix the issue by freeing the memory before marking the mm MMF_OOM_SKIP.
> >
> > Note that the task which calls mmput() might not be the victim - if it
> > took a reference on the mm (e.g. ptrace), it may hold the last reference
> > and release it when it calls mmput().
>
> I do not follow the reasoning here. MMF_OOM_SKIP is called after the
> address space has been unmapped either by the last mmput or the
> oom_reaper (or both when they are racing). Now all your patch does is to
> call tlb_flush_mmu which I suspect is to release batched pages. But why
> is that needed only for the oom victim and why there was no final flush
> in unmap_vmas?

Sorry maybe commit message isn't clear enough. I did have to pare these down
from really massive ones.

And yeah tlb_flush_mmu() is about freeing the batches.

unmap_vmas() doesn't have a final flush, it relies on the caller to figure that
out, and just batches up.

And currently tlb_finish_mmu() comes after MMF_OOM_SKIP is set (in
exit_mmap()), so at that point the memory is unmapped but whatever the last
batch is isn't freed yet, and the batch can be large (PMDs are single
entries if I recall correctly for e.g.).

This only matters for the OOM victim, hence reinstating MMF_OOM_VICTIM, which
made the patch _way_ smaller than the one proposed :)

>
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 7618e72766a5..4cb18b217048 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1313,11 +1313,18 @@ void exit_mmap(struct mm_struct *mm)
> >  	/* update_hiwater_rss(mm) here? but nobody should be looking */
> >  	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
> >  	unmap_vmas(&tlb, &unmap);
> > +
> > +	/*
> > +	 * Free the memory before marking MMF_OOM_SKIP so a re-triggered OOM
> > +	 * killer will only skip this mm if it's already freed all it can.
> > +	 */
> > +	if (mm_is_oom_victim(mm))
> > +		tlb_flush_mmu(&tlb);
> >  	mmap_read_unlock(mm);
> >
> >  	/*
> >  	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> > -	 * because the memory has been already freed.
> > +	 * because the memory has been already unmapped.
> >  	 */
> >  	mm_flags_set(MMF_OOM_SKIP, mm);
> >  	mmap_write_lock(mm);
>
> --
> Michal Hocko
> SUSE Labs

--
Cheers, Lorenzo
