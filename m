Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389710;
	b=zjg6YoucII5eWDqBtbtJC3lYiwmcejdudMzztlqeeTEg/kWg35L7nfa+1MNQEOfmlMeq
	 zn23crYai28ZvSb3CjmuT7tSWHneyuNUcsxUyn459KTVJ7W82ePB8CToWLpng+BgWeKy/
	 ibJy0fZ5ISiQBlxrUYtfaXk+yTJq1EYTWTINmFeD5HZVb5FoEIxNDQklkC3IYIXCl3n6J
	 6SpMTKKUo6iVMUa0ZqM3ciooiyX/iXJZlUoBbZBOcymMB4jA1N7jFPDsUa/TDFJByBotX
	 eRgUkXG1FyuGt72usFCQ4l1atGhgbQCEjzBHzZxvMD4s06B7gPXphyCA4mLDngopQlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389710;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=5cAqrwEG4tJIMReOWfjqK8hyBrP8PRADznX2SjMD38Q=;
	b=rC8/MUMWOYSLH4citx7ZNVMmb95ueOm/dk/rkac/PH06NpW/zW8QtrG7ZZZk7rRuOkuG
	 eoZs46/wb7sosBDm6kv0y1xmZR8JWqxP5bCtz1shb8ZuFxYQVZGea08+xE6JCwnol3OST
	 cAqlpaRTSqVgVfU+F4+rohDmLndSiQmzVz2y6uqmo3q96bpT5M3trlH6xRnx1XDxCeUpY
	 ZkmYMRVAo3+BtGPmzRbv7pbp1EdICwgwrowk+C1A2MN4/8XCX3rhFX5c/dmP3fOw//Itg
	 U+UVWsD0A6IDYqvJT1RkbyW8LWlKMdlnroK7atuf7MxJB0OmgimxCD6fFGM4y+je3cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fXjOzohu;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57710606A31A;
	Fri, 30 Oct 2026 19:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57710606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fXjOzohu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5cAqrwEG4tJIMReOWfjqK8hyBrP8PRADznX2SjMD38Q=; b=fXjOzohuKhVw0dSm7kurhSEjMx
	6ncivLeUVzuEuljHndk6KFMsr0Gp5XJxpEaViT0PKxjF1DxJfKVZD6Q9Al06C0cKCR263e2//KE/9
	BhqcqOXfNHTNAU8tqbvd360LrmpIB7/G6QybSUdbCUP+XIVqT+B4wc0s+jHx/u/oZmUGjxHOSgHuD
	ij8KyKAVJ4xrVQoXVUEhC4MyuFwAz5abZibH9qw/n8SJv12+1cg+iQN2+0QVbJrsVhozc2r2JDydh
	94x47YWl3uDla8PHV/FnwU3PocKKFJUVUdCMHBvxmzPrP1wVloEWX1Va5n3rsEpyB+qYG+JdCSjcj
	2hxJXohQ==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMsa2-0000000Abtz-11sU;
	Fri, 30 Oct 2026 19:48:02 +0000
Date: Fri, 30 Oct 2026 19:48:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
	Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 06/46] mm/filemap: read mapping->a_ops->free_folio under
 i_lock
Message-ID: <auT0csDIJwvwfDqb@casper.infradead.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-6-6f74bec9a5bb@kernel.org>
 <auDG-5bYh2tSQem8@pedro-suse.lan>
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
In-Reply-To: <auDG-5bYh2tSQem8@pedro-suse.lan>

On Tue, Oct 27, 2026 at 03:47:35PM +0000, Pedro Falcato wrote:
> On Tue, Oct 27, 2026 at 12:17:26AM +0100, David Hildenbrand (Arm) wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> > 
> > memory_failure() -> ... -> filemap_remove_folio() can read mapping->a_ops
> > after the inode has been freed. Once the folio is deleted from the
> > pagecache it no longer pins the mapping, so after i_lock is dropped
> > e.g., a concurrent final iput() can evict and free the inode before
> > filemap_free_folio() looks up mapping->a_ops->free_folio.
> 
> Ok, but after iput() then nothing also pins the filesystem, and thus the
> module. So we can be calling into total garbage. So what gives?
> 
> You can't just take the pointer, you need to make sure the filesystem
> is also still alive.

I hate the existance of ->free_folio().  It'd be lovely to get rid of
it, but I think that's outside the scope of this patch series.

This patch narrows down the race (and removing modules is a CONFIG
option anywaysoit actually fixes it for some users).  I think this
patch is a significant enough improvement that it's worth applying and
perhaps we can work on removing ->free_folio in the near future?  There
are only four implementations of it today:

fs/nfs/dir.c:   .free_folio = nfs_readdir_clear_array,
fs/orangefs/inode.c:    .free_folio = orangefs_free_folio,
mm/secretmem.c: .free_folio     = secretmem_free_folio,
virt/kvm/guest_memfd.c: .free_folio = kvm_gmem_free_folio,

