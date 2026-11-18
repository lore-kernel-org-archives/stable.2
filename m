Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994934;
	b=Ld255b4iOD2MWx4fMZtE6asQ89m5OAXknNhDrFMq2JHQ7+fAj8QsNYs0+R2c6ZKrynCO
	 1rZhc0l45dzLiyphdzVrhohxU7RGNpy9tbjoe828B2K7BSsmt2LpxQIcBSrYkK+EwkIv4
	 3fvyfBgnnzq8l4LDPRSqjX/6boZPNGE7M5B1TAwqZ13NHdyphS/b/iJWSEOHR/QZd8X/m
	 sTPxaH6BmmVapwLLnJ1JzAfFXRruQc1194woedAloK70Fdcjtalr4unijMirCjjwiVcei
	 Xfi9mIuG3s+3MXQ0DbWWvfgUISFVxbp5q8sVsEYSWXbo6GhITKPKvpDcAX2ToRoELVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994934;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=9ATyR+9qHOct/xUnPH9mJnbBD7GZTG+HINgSyr3PxaI=;
	b=ysiJOIgU1aT/p0T3EZs4i6kL55iRL+cOaxDQt1GqhlWM5G2cRYL1+3b63r4i8AJC3gcM
	 gpcJNC/uoEEW/b8QKub1vT9ajd7/FzYwzvgbDydOswmKrN2tw7UC3X3+NyB/1tgyPuKwh
	 h5O3yIeoCQByeRon2SEL4VAlE/vqzyT0bsATB12krd4vWNCE3R8BP8TPueme/Tt3Pn/CU
	 6in1ZPBXZ8VmtSeedAClOarMwUFbTeI73UAXN/B+tVhgDHjT/zxMfNlv9581rngRJ1qqL
	 glvKzzQMSc4kkhvN0uqaVD4miVJwks11+31zahKylAeRbV5esbcLco6P0Fg0ke2orbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B64ocKDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA5606A330;
	Wed, 18 Nov 2026 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B64ocKDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0951F1F000C6;
	Wed, 18 Nov 2026 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794994934;
	bh=9ATyR+9qHOct/xUnPH9mJnbBD7GZTG+HINgSyr3PxaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B64ocKDlyHLo7JKiB71qN7xPUGSas5O496TWP1Vb9kTdaWOBu3xdB4W0dYEjMGJF6
	 wg63AHZj+PtfQQoLIvdVK5b0Pn24hBYJyxfSpX6Pbdx7+0UD7pxzuycdP5058yMa2/
	 ETsOGLXBxuNitQ/Kl8b79+0Jb6zJ/9tkNCkDoeOp1+TbzpuDHZ0n4zlZoqpl87gr1W
	 pPJbvsAYwFFaxlR7b0zjG5AJvUmmyOwORf3q9TMKLI+0tgiC27CXTjuz/JPWS1M1Zv
	 +10DRh/IigcridN5ngx3Cid6k5sD2VJJyvtymSBjTvvQczytGNBB7uRDQaOstIJFHh
	 AG2gXV+iJZLJg==
Message-ID: <4f23b0bc-b89a-46c1-b8cd-853e7815b7ac@kernel.org>
Date: Wed, 18 Nov 2026 10:41:55 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
To: Tal Zussman <tz2294@columbia.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Michal Hocko <mhocko@suse.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Andrei Vagin <avagin@gmail.com>, Muhammad Usama Anjum <usama.anjum@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Breno Leitao <leitao@debian.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 05:28, Tal Zussman wrote:
> This is a first batch of userfaultfd fixes, with more to come.
> 
> These were found by a mix of regular old LLM review and by having an LLM
> write a TLA+ model of uffd interactions with PTE bits and other state
> and seeing what issues fell out.
> 
> Most of these fix places where mm code loses uffd-wp or RWP protection
> while moving or migrating an entry. Userspace then either misses writes
> and accesses, or gets pages reported that nobody touched.
> There is also a hang in UFFDIO_MOVE, and UFFDIO_ZEROPAGE modifying a
> file through a private mapping.
> 
> Patches 1-2:   UFFDIO_ZEROPAGE and UFFDIO_MOVE fixes, cc stable
> Patch 3:       PAGEMAP_SCAN write-protect vs. writable migration
>                entries, cc stable
> Patch 4:       warn on a writable migration entry with the uffd bit set
> Patch 5:       PAGEMAP_SCAN write-protect vs. device-private THPs
> Patch 6:       UFFDIO_MOVE of the huge zero page from an RWP source
> Patch 7:       mremap() losing uffd state when a move fails halfway
> Patch 8:       migrate_vma losing uffd state of a zero page
> Patch 9:       hugetlb alignment checks in UFFDIO_REGISTER and
>                UFFDIO_UNREGISTER
> 
> A few of the fixes change what userspace sees:
> 
>  - UFFDIO_ZEROPAGE on a private file mapping no longer fails with
>    -EEXIST where the file already has a page, on an mm that cannot use
>    the zero page (patch 1)
>  - UFFDIO_MOVE returns -EEXIST for any huge destination PMD, not only
>    for a present THP (patch 2)
>  - UFFDIO_UNREGISTER with a misaligned hugetlb end fails before
>    unregistering anything, also if that hugetlb VMA is not registered
>    (patch 9)
>  - UFFDIO_REGISTER and UFFDIO_UNREGISTER accept a misaligned start that
>    lies in a gap before the first hugetlb VMA of the range (patch 9)
>  - UFFDIO_REGISTER returns -EINVAL rather than -EPERM for a misaligned
>    end in a hugetlb VMA without VM_MAYWRITE (patch 9)
> 
> Patch 6 has little user impact on its own. It is included because,
> together with patch 7, it allows removing clear_uffd_wp_pmd().
> 
> Patch 7 adds spurious write faults on shmem and hugetlb after mremap():
> when dropping uffd protection there, change_protection() makes writable
> pages that were never protected read-only. UFFDIO_UNREGISTER and
> UFFDIO_WRITEPROTECT already behave this way and lead to the same
> spurious faults. This will be fixed in change_protection() in a separate
> series.
> 
> Based on mm-new.
> 
> ---
> Changes in v3:
> - Collect tags (Thanks David!)
> - Patch 1: use vma_is_cow_mapping(), per David
> - Patch 4: warn on a writable migration entry with the uffd bit set, and
>   make the PMD path match the PTE path, per David.
> - Patch 4: Drop the Fixes: tag and the review tags due to changes
> - Patch 8: add helpers and read the PMD once with pmdp_get(), per
>   David
> - Patch 9: move the hugetlb alignment checks into a helper and use it in
>   both ioctls, per David
> - Link to v2: https://patch.msgid.link/20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu
> 
> Changes in v2:
> - Collect tags (Thanks Kiryl, Lorenzo, Gregory, Alistair!)
> - Patch 2: say "softleaf entry" in the commit message, per Lorenzo
> - Patch 3: add softleaf_is_writable() and softleaf_mkreadable() to
>   leafops.h and rename the helpers to say softleaf, per Lorenzo
> - Patch 3: add Reported-by and Closes for Breno's report, and cc stable
> - Patch 4: explain in the commit message how PAGEMAP_SCAN set the uffd
>   bit on writable migration entries, per Lorenzo
> - Patch 5: use pmd_is_valid_softleaf() rather than open-coding it, per
>   Lorenzo
> - Patch 7: say "write faults" rather than "minor faults" in the commit
>   message, per Kiryl
> - Patch 7: trim the commit message, per Lorenzo and Gregory
> - Patch 8: trim the commit message, per Gregory
> - Patch 8: Cc the GPU driver maintainers and lists, per Gregory and
>   Alistair
> - Patch 9: use IS_ALIGNED() and a local variable for the VMA's ctx, and
>   shorten the comment, per Lorenzo
> - Drop the three guard region patches, per Lorenzo
> - Link to v1: https://patch.msgid.link/20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu
> 
> ---

So, I would be picking up ...

> Tal Zussman (9):
>       userfaultfd: use anonymous memory for UFFDIO_ZEROPAGE on private file mappings
>       userfaultfd: refuse UFFDIO_MOVE into a non-present huge destination PMD
>       fs/proc/task_mmu: downgrade writable migration entries in PAGEMAP_SCAN write-protect
>       mm/migrate: warn on a writable migration entry with the uffd bit set

This

>       fs/proc/task_mmu: write-protect device-private THPs in PAGEMAP_SCAN
>       mm/huge_memory: build the moved huge zero PMD from the destination VMA

This

>       mm/mremap: resolve uffd state when the context is dropped, not during the move
>       mm/migrate_device: do not migrate a uffd-protected zero page

This

>       mm/userfaultfd: check the hugetlb alignment of every VMA in the pre-scan


After waiting a bit longer for more review. Andrew can take the rest.


-- 
Cheers,

David
