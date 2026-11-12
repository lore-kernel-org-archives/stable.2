Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510662;
	b=ZF9J7+mt7nf7JFV0Ml5MBvnP0ldvJyowvAuhozbyC/672ZsWxJCxYyDGoM2Ki/C65nv3
	 JdYMyCmoN/kJYky83OLgGxAyoanMj896ly8DKFq7YLmgvo2uuLqFQFBzCkzXQmCSHasna
	 XXB6K/6+XqHAq2ELy2jo9YPhXacbFxoSe6M9Ym+Zm16CKJPANewvaLeTZOrgL21V4UaEw
	 jTzDGY29wZb9vM09pKvGDwmRF1HgXn0Ld7HjCFEMcepqC94BZSCQzp3fYgjAuYgYH8aPQ
	 zPLZaokDe+iSeNmTUZeg543dY2x5qAbFWt8SXRc48NZ3X3o1tWGBHbLn0aAOr3YRXmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510662;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/gw31v8Bft63XKNn3Br3X2FoH4VN3mvM371V5gzzTAM=;
	b=BJ88JWKrp3bs7z+r7YJKWDUeucyo2d332ZwpkXx5tFagDTuWJvzgp8WVQex1kQjRC3Zh
	 3PO24Dwpm3YuoLw2lq0xdoNgOvIJI8TAuXrTj4uTtsJANgj7yILV2LrGugthnG2prL/GI
	 Wx4YwqNCIlJJjV5tV/Wx8umXPrlZNVoViDyoHzJTSJ4wCI1X6Sc+K2NKVTMgyZm8SVBT5
	 yDtCU7DIi+69UR01pS62kKrlExm8kqC94WIrNCOq2zxQqztj0tiRsVRD8eEYfetzt3ILJ
	 VxwztXpj2JrOrs9rdbWr5lDi0aLY+LXaZjjQRkpw2+T4o/G8GBQEPcBaTekEkktt3Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPbefH6V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52FB606A31C;
	Thu, 12 Nov 2026 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPbefH6V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A37F1F000C4;
	Thu, 12 Nov 2026 19:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510662;
	bh=/gw31v8Bft63XKNn3Br3X2FoH4VN3mvM371V5gzzTAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SPbefH6V+SmZKkoSlfrGde0d2vD7MrhExaaRt39+4BLZsS8oRxtLfgAA2xCoeBw7X
	 ZhvzYeqntZBqIGOYIQO/GB2Hx1+vcJXp3cuXfuw8TYReN7u25g8kUtBpemZ3I34sLW
	 hZq0KIKRQQInzsuj/jWveLASxL0crZcHkICxAFYZJlTRZuzVsLBvkwGeVYXyNbk+Mo
	 f0kbbZCvB+jv6xrJmmqjFOaN9qcFk7t65cWxC6WiYMLUNCL4f0IKt6SG5nGkkloDqP
	 xPJSDzmabXQ426slGYq4buWaHmau6XK/QiYFyLbdoJKLy5LQvdNemOWHQ/N/OVnMoB
	 5eiaeZYXL3mCw==
Date: Thu, 12 Nov 2026 19:10:50 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 09/13] mm/migrate_device: fix use-after-free of the anon
 rmap
Message-ID: <avYOYgW_lJiSKXH5@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-9-3d2454362e8d@kernel.org>
 <179450709690.482102.6960491372735414259.b4-reply@b4>
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
In-Reply-To: <179450709690.482102.6960491372735414259.b4-reply@b4>

On Thu, Nov 12, 2026 at 01:11:36PM -0500, Gregory Price (Meta) wrote:
> On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> > A munmap() of anonymous memory can result in a use-after-free of the
> > anonymous rmap if a concurrent device memory migration occurs and the
> > migration runs without the mmap_lock held.
> >
> > This can occur for a long-term pin of device-coherent memory, or a driver
> > evicting its device memory by PFN.
> >
> > Consider:
> >
> >     eviction                        munmap()
> >     ========                        ========
> >     migrate_device_range()
> >       migrate_device_unmap()
> >         try_to_migrate()
> >                                     zap the migration entry
> >                                     unlink_anon_vmas()
> >                                       last VMA: free the anon_vma
> >     migrate_device_finalize()
> >       remove_migration_ptes()
> >         /* locks and walks the freed anon_vma */
> >
> > If munmap() runs before try_to_migrate() instead, the folio is no longer
> > mapped and gets no migration entry. The walk still runs, and follows the
> > stale folio->mapping to the freed anon_vma.
> >
> > Resolve this by pinning the anon rmap of each folio which possesses one in
> > migrate_device_range(), migrate_device_pfns() and
> > migrate_device_coherent_folio() before its PTEs are replaced, and
> > unpinning it once the walk is done.
> >
> > A folio which is no longer mapped cannot be pinned and has no migration
> > entries to remove, so skip it rather than migrating it.
> >
> > Reported-by: Chris Mason <mason@kernel.org>
> > Fixes: e778406b40db ("mm/migrate_device.c: add migrate_device_range()")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> Was able to reproduce/observe a slab-UAF in rmap_walk_anon with KASAN
> enabled, and that this patch resolves it.

Great thanks! I guess you have some mega-schlopped setup for triggering testing
like this? (Meant in a complimentary way in this case :P)

>
> Can't say i understand the change well enough to R-by, but I can say
> this resolves a clear bug.

A-b is often the way for that ;) but I don't want to be greedy here :P

>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>

Thanks! :)

--
Cheers, Lorenzo
