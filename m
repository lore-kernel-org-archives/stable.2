Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559226;
	b=k2b6lPpU0T+1lzZPA/AeA9QluWccogsalE0lEP8yXJZxemgaVG7sLL0LLBaG9Jx0cZom
	 UvyFsS6fAe5VraGedU0QFM5x8wAhSAmrlDrmk3hE1DNGDcq15fbsInKkVXRWnZN2xc59B
	 Ag0w3pd5kQe7Yi1KPuDbqsObXxeRHmYe9RQodl3G0ejOg8Mw8AqJgSeLF3azZ/29dptuX
	 uegh07pNivbFwBDXvtJC+u6/5+33bvS3mSjgHVHXA5eMNocCTKgMwoOFib7tU2jHydo81
	 AWA13JsLYH8Gmo7bIfJNP8/QHOBqGfA1Y72/6UN7R+9UMx+OaQFickVxhc5Ptu0Zo8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559226;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dtMZbHm3lkM6o/yW+HmQOChZENqEt7jGlIYiYyXmUrc=;
	b=MkSYg/ltagjX51R3H8BXXDm6+ET6TWRFH7MbBO9dzcK/Q7LkTQWslBm66W3B7Yozcdum
	 J6NABQVR7fLcVQERsFaqTkv+5HuAcjI1TX/8G4dy+jdy/W4oWSqd8pCM7YkKR2FqyMnLy
	 nIGJvJbVw9ZgWKcaZQD+m8Ijrlj+08yBToo4yr2gMtsJVI6MsNZ2EcQFZ6kYp/goKbUYx
	 KEHLJXxzCC8UupiEDX8iTWsK7HAib1hsq2JaMTj3dGi3hEB9KqoiXh1vu2kZkXwYI2O75
	 ZftysgPdE3Ub5NDoLF7VhXS1Ri/M+xYQU3f8bC4+sel3mBqG9euwywY4v9Mg/HQyxTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b="ugOr/v4c";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7774606A327;
	Tue, 24 Nov 2026 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ugOr/v4c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5741F000ED;
	Tue, 24 Nov 2026 22:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795559226;
	bh=dtMZbHm3lkM6o/yW+HmQOChZENqEt7jGlIYiYyXmUrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ugOr/v4ceQqckoPQJ/g4UCaTyO+koHIT2A4RUIfXBsU1JVNTjLPiYJiVbIG3PBhXs
	 cQ9UXFCWsh7ke9FpqJnH2bUu4Jume8Vz7EZPuKtb9E8g8EMBIGl7EyVWY/I16PMPbn
	 B5BPEJXFGwvq3OGEHbKmuOIcSyHevi31Sq/46n4I=
Date: Tue, 24 Nov 2026 14:27:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, James Houghton
 <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, Suren
 Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro
 Falcato <pfalcato@suse.de>, Michal Hocko <mhocko@suse.com>,
 =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Andrei
 Vagin <avagin@gmail.com>, Muhammad Usama Anjum <usama.anjum@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Zi
 Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau
 <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
 <osalvador@suse.de>, =?UTF-8?Q?Miko=C5=82aj?= Lenczewski
 <miko.lenczewski@arm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>, Thomas
 =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Lyude Paul
 <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
Message-Id: <20261124142703.8b6e07eabcd510e9b99b03a4@linux-foundation.org>
In-Reply-To: <3ebb01ea-fe77-4467-a1de-7f30a91593f3@columbia.edu>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
	<4f23b0bc-b89a-46c1-b8cd-853e7815b7ac@kernel.org>
	<3ebb01ea-fe77-4467-a1de-7f30a91593f3@columbia.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Nov 2026 14:37:11 -0500 Tal Zussman <tz2294@columbia.edu> wrote:

> 
> 
> On 11/18/26 4:41 AM, David Hildenbrand (Arm) wrote:
> ...
> > 
> > So, I would be picking up ...
> > 
> >> Tal Zussman (9):
> >>       userfaultfd: use anonymous memory for UFFDIO_ZEROPAGE on private file mappings
> >>       userfaultfd: refuse UFFDIO_MOVE into a non-present huge destination PMD
> >>       fs/proc/task_mmu: downgrade writable migration entries in PAGEMAP_SCAN write-protect
> >>       mm/migrate: warn on a writable migration entry with the uffd bit set
> > 
> > This

1

> >>       fs/proc/task_mmu: write-protect device-private THPs in PAGEMAP_SCAN
> >>       mm/huge_memory: build the moved huge zero PMD from the destination VMA
> > 
> > This

2

> >>       mm/mremap: resolve uffd state when the context is dropped, not during the move
> >>       mm/migrate_device: do not migrate a uffd-protected zero page
> > 
> > This

3

> >>       mm/userfaultfd: check the hugetlb alignment of every VMA in the pre-scan
> > 
> > 
> > After waiting a bit longer for more review. Andrew can take the rest.
> > 
> > 
> 
> @Andrew, could you pick up the rest of these (everything but 4 and 8)?

9-3 != 9-2

np, I grabbed 1,2,3,5,6,7,9 (whatever isn't in other-peoples-trees) and
massaged the cover letter a bit.

