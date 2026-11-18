Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012582;
	b=c1is3l9mfC5JNb5vJLTljFmLjNhag/bLITHeA5XAtdj2hk5iEJLkgJetUKw60Yz7sn5x
	 5BBWRviCCIiRMJOC2mOGesecIKmO4xhlfJyogyosnZJjRNJD9N05NLklrcZsLHnAb/+FZ
	 TiqTE03eXR2Iee7UKW2btFH9eFvMolISqQmN4meHTuIuXW1MyB4HtXlOTSWs3Mnu5pzSU
	 uXlZmYIqvPlgk4C+KqThlL2uA+dRIYBDoRDZBKh6f11Us4cxiPzRmH+I+6Pqj1XWURu0K
	 nma0jh3HhV9YY71eHKcnPTf0UfrVEVbB29B58ySs/jANNTzTQyeZPTT73Z6cAurXXrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012582;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e8UvEUdPEpQSyC1Lt+i4VJDuesDW8Qmi23ISsGkjBeA=;
	b=fEiUR/YxRZ6ObZtb0QzErLCfUewWXXDib1b6htpoMpIBEKeeYTWy0+KH4dftm+1/oCQq
	 ynZ9SqixtA2s3GNe+N3fcWCiZid+F0rE6CLD0PgtHiG7/Hx89Kg3dSSjoq3bvWd1ngHHz
	 rbYCZ/Bs0m7KosIlGLW9haqqRjdbsv5LOBBMO1R2cuT1eo4FvD6TUiTvAnKbJRvve9sQc
	 7/LEVYESh7W8y1x8kd5hLN8Bi7Tf/2Lv3Zn4QnedffdM6nhkLeXmgViOP+8HvmD/lWXJx
	 79EspGZmLm39uU/6kU4nCXZM+YPxju6tVTO2NctCWin4U34u5Jl0c5wNIpAB4YiJqdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2u0A3+O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE874606A32A;
	Wed, 18 Nov 2026 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2u0A3+O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3670F1F000C5;
	Wed, 18 Nov 2026 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012581;
	bh=e8UvEUdPEpQSyC1Lt+i4VJDuesDW8Qmi23ISsGkjBeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M2u0A3+OGPPITpKUDe303YKDFeGSqQXhJqzLBj8QzweAoMR5Kmk3SBVnEOIe0zRcO
	 1GHtv2j+Mh/vnVGz+wAwz+40erRTwTCExEBZkIlYvgr2E/kynfoA893QsSTYqKsscR
	 5XxSrXE2FTxAw17jFnoDxMbyp4WxNkNApjeEbr5Ym8K2j030bfVnLInTeWF50CZy9Z
	 3tPn98VL7D0hmdW3hhL1xcHPtnftzdt0OuiaUmFYMUOnZz0gixhhvxqsZmIG2asGq/
	 4JBbbgRnKNZ/WkqC9DW6hs2FDCu1yxwaLDnNZX7hQBX/KEblYsp6nKg1njZX29ZbV+
	 xIFwRV50G17ew==
Date: Wed, 18 Nov 2026 16:36:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	James Houghton <jthoughton@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Andrei Vagin <avagin@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/9] fs/proc/task_mmu: downgrade writable migration
 entries in PAGEMAP_SCAN write-protect
Message-ID: <av231_prsp4eDeBF@kernel.org>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <20261117-uffd-state-fixes-v3-3-b617009d1a4a@columbia.edu>
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
In-Reply-To: <20261117-uffd-state-fixes-v3-3-b617009d1a4a@columbia.edu>

On Tue, Nov 17, 2026 at 11:28:43PM -0500, Tal Zussman wrote:
> PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects pages in a VMA
> registered for async uffd-wp, and sets the uffd bit on non-present
> entries as they are. An entry with the uffd bit set must not be
> writable, so that the page is write-protected once it is mapped again.
> change_protection() therefore downgrades writable migration and
> device-private entries to readable ones first, but PAGEMAP_SCAN does
> not.
> 
> For a writable migration entry at the PTE level,
> remove_migration_pte() restores a writable PTE without the uffd bit. So
> if a page is under migration while PAGEMAP_SCAN write-protects it, the
> write protection is lost. A user tracking writes with async uffd-wp
> sees the page reported as written on the next scan although nothing
> wrote to it.
> 
> With CONFIG_PAGE_TABLE_CHECK, setting the uffd bit on a writable
> non-present PTE or PMD also triggers a warning.
> 
> To fix it, downgrade writable migration and device-private entries
> before setting the uffd bit, as change_protection() does, at the PTE,
> PMD, and hugetlb levels.
> 
> Add softleaf_is_writable() and softleaf_mkreadable() to leafops.h for
> the downgrade. The open-coded copies in change_protection() can be
> converted to them separately.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Reported-by: Breno Leitao <leitao@debian.org>
> Closes: https://lore.kernel.org/all/avNEgmvYdoukt6MS@gmail.com/
> Cc: stable@vger.kernel.org
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  fs/proc/task_mmu.c      | 40 +++++++++++++++++++++++++++++++++++---
>  include/linux/leafops.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 3 deletions(-)

-- 
Sincerely yours,
Mike.
