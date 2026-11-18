Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020121;
	b=H+GHg45ZM8drhgR3CuguUVyEqobZKh1apo48vPchsp7QRXWl/ASS8TcshSqkpj8RF4zi
	 VNFbGSL6R4YtmLU4YDjgN/Y4sUORK2LYXKDkFaLvMGiwgjrMnp2F53G36TrFjIxH1MYHW
	 KBnIWCWusEZhR751RgKDDvX3Tl8H6zwqNk/9ifxwPMc+52LI0lpd6AYrvtTczc8owhgPF
	 eU/ZpBcFkWEdzIzVTiJAxwhm95m7srjWEi1IG+btHSdhjU7DZV/0w5Z9u1yCZUnZUKizP
	 8HSz47CLSUNP3BZ+6zrMfWvc4aRgiFl9JJoM5+YC7DNOvJlo3bLxb4CbByBLitL7xAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020121;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NCJizk8bzcFH2AbvcH+Cs7sTkFlxW/3L98puwCtipF8=;
	b=nDL0RIoIzEf3W5aj58lgzrPaygqEpWH5lnM2I7NOxN/8ECK7bF885eLBQO3/35576VYG
	 L3OyoG0aay3gd8werK+G+ecSWtbCG0ZeMgwh6LgW2PLWgoPcfh16E6AL8vPrcdB8ts6ot
	 kkIde1GLkwaZsU57tcvhlab/7F/KhOEEF7wv9t5pBPdH55tS3bAfgiiKrLYpHpLk/vLFc
	 SGOR9LaqmC5YWciO45+hkx6gWpZ3fyv1FLe7w2GgnE1LMzPgM5JHiL2aurCf7f7E/A3lZ
	 6PEjNy2qH6DJzqe51F+/YWG7YupuAybrN9BEMHfXcY8IyuBNWAS/PBD1ivx5mBlUT5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFMkljvJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC69606A338;
	Wed, 18 Nov 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFMkljvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99B41F000C6;
	Wed, 18 Nov 2026 16:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020120;
	bh=NCJizk8bzcFH2AbvcH+Cs7sTkFlxW/3L98puwCtipF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QFMkljvJawec5NmrO3WRFAgrg16D5amWq/3qOZJySjcI3zkdLFyHx7qt/VJlC9Lrm
	 rSHrnHsr0If7GeXaKoUgThoNSnbxJgzA69q6FDjUD+2mVMdOKq+wmTQ6MZMmKotJgE
	 66PhJDfZH9qhEu7eBErOQRP50O2w7i/CA1T0JD4324mFPMAOPAtUcAKsyDk61PYvzw
	 hlPic5EBWUu1uBSW3I1B3ik2XxIF8i8Ieqc0aaOP2wgzYy7SItackWUGeHDYhxDu4U
	 S9KDdlpsuTmsA232DK65bIXrfRmH3XiJEVKdKDJsb1aoT9T2chlBroNfWVnZEHpoX1
	 bYGA1hpCeJcjA==
Date: Wed, 18 Nov 2026 16:41:48 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
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
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 06/13] mm/migrate_device: don't let go of the fault
 page
Message-ID: <av3VJFuimrc9g9EY@gremlin>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <20261113-mason-migrate-et-al-fixes-v2-6-50a2ed382b61@kernel.org>
 <0dc23953-328a-46b5-9432-4b1a1a16fac0@kernel.org>
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
In-Reply-To: <0dc23953-328a-46b5-9432-4b1a1a16fac0@kernel.org>

On Wed, Nov 18, 2026 at 04:31:25PM +0100, David Hildenbrand (Arm) wrote:
> On 11/13/26 22:45, Lorenzo Stoakes (ARM) wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > When migrate_vma_split_folio() has split the folio of the fault page,
> > the lock and the reference which the fault handler has taken are at the
> > former head page.
> >
> > It then moves them to the folio which now holds the fault page, by
> > taking a reference on and locking that folio, then unlocking and putting
> > the former head.
> >
> > split_folio() has unlocked the new folio and has dropped its own
> > reference on it, so until folio_get() nothing but the page table entry
> > holds it.
> >
> > Only the mmap lock is held for read, which does not prevent another thread
> > from zapping the entry with MADV_DONTNEED.
> >
> > If this happens the folio is freed which results in folio_get() taking a
> > reference on a free device page, which the driver can hand out again at any
> > time.
> >
> > In addition, folio_lock() can sleep here with the lock of the head page
> > held.
> >
> > Utilise split_huge_page() which will leave the lock and reference at the
> > fault page correctly.
> >
> > Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > [ ljs: tweaked commit message ]
> > Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
>
> This code is so bad we should remove all of that from the tree, seriously.

Yes stuff like this really does remind me of many scenes from the all-time
classic movie Event Horizon... :)

>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks! :)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
