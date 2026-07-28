Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F173F58EB;
	Tue, 28 Jul 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244091; cv=none; b=MZlgMLt6go/WAwdfDRKznjOoBr4WdD3RpdkmvWSbLo4nYcatmvZhCql3W8//0+ezcLZoNshdzdRkQzgCbrpSHJzIjYjWShKuTO+kIwKr7OxH7XWi4bE4MFkUerfREWoALsfkAXIXx3NG2Cyuw4PxKswmZixPO3FoLqffZcoh0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244091; c=relaxed/simple;
	bh=S4xIHLk1+OlvIQOz+RXYU3Jrva9G8SJN9D563RqZqg8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A5PuSd47hnlJnAf0dKePM7qSfNFWpLBKCz0u//gQoZutLiL1Q9G28snyApu2uZhi9icMTWXlLUIrXXjLmcsPYzAIkXAPbaDkXj4/+iUjVmRmaaksBMNbQoRLPnXOOD4FYABJWropKD+QW0fNKxTOwZE865IXpDvacOEt2msKEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdJvjp+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdJvjp+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44961F00A3A;
	Tue, 28 Jul 2026 13:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244090;
	bh=OrNn0+AoJsT4fnoiy11cQIXKSP43P9bDOeyyTlsXx8M=;
	h=From:Subject:Date:To:Cc;
	b=SdJvjp+drwuDXaqChRVRyODfl0G/+o4sQ161wCjGjH39syvXqnUCInMNz5oYJ6tno
	 tGbouXzMCxKQeTH3kpHHyuvmX+VwmTsx5ly4dIp+mwV/Hg62AoOSjOq1lmXLAMrOFY
	 UlDOg87C5Lcvx1D4UJeQ/q7chzGF8uowORBf+95JdxtrJFX0zzIChRlfWQJHfUCfs7
	 gaE7L5pdr+YNZBMw8G8HWpSCVp1v8j/1/DKTv3gLJFSLc3BQ/fRSxN0KBQOhf7xAH5
	 JDivhnvJ5uSPrA//JExL7jErLY64F5TNi0+WhRovjsP+IJJ+QDmU2lX0wd+uI58tP/
	 8VyMMrqTedzfw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/5] x86/mm/pat: CPA fixes
Date: Tue, 28 Jul 2026 16:07:43 +0300
Message-Id: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ+paGoC/yWMQQrCMBBFr1Jm7dCYYiJeRVwk09GO0BgyVQqld
 zfR5Xv/8TdQLsIKl26Dwh9ReaUKx0MHNIX0YJSxMlhjnfHWI+WAd1lZcRzID2T8yXkLtc+Ff0P
 Nr7c/6zs+mZZ20IoYlDGWkGhqapHcr2fXzzPs+xf7Fi/FigAAAA==
X-Change-ID: 20260727-cpa-fixes-d3c73c075672
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
 Mike Rapoport <rppt@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 stable@vger.kernel.org, x86@kernel.org, syzbot@syzkaller.appspotmail.com
X-Mailer: b4 0.16-dev

There are a couple of CPA fixes floating around:

Denis Lunev fixed races between split and collapse of the large mappings:

https://lore.kernel.org/all/20260715183453.2381141-1-den@openvz.org

Lorenzo Stoakes fixed UAF caused by races between CPA and ptdump:

https://lore.kernel.org/all/20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org

and an issue with stale page tables in IOMMU:

https://lore.kernel.org/all/20260721-fix-cpa-kernel-pagetables-v2-1-2b255deed710@kernel.org

Mike Rapoport fixed a check of RW attribute in lookup_address_in_pgd_attr()
used for the verification of RWX:

https://lore.kernel.org/all/20260715144519.934289-1-rppt@kernel.org

Some of the fixes got merged into x86 tree, some of them got merged into mm
tree and some are still hanging in the air.

Beside the fixes there was a supposed simplification of cpa_lock locking 
that looked like removal of an optimization for DEBUG_PAGEALLOC, but it
turned out that it was not an optimization but rather a correctness
guard because with DEBUG_PAGEALLOC the locks could be taken in an atomic
context and couldn't use plain spin_lock()/spin_unlock().

The changes here are collected from all these fixes into a sinlge coherent
set on top of tip/x86/mm:
 
* update to cpa_lock handling with DEBUG_PAGEALLOC
* fix for races between CPA and ptdumpi causing UAF
* fix for stale page tables in IOMMU
* update to the fix of the race between split and collapse of large
  mappings
* fix for effective RW computation in lookup_address_in_pgd_attr()

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
Lorenzo Stoakes (ARM) (3):
      x86/mm/pat: acquire init_mm write lock on collapse to avoid UAF
      x86/mm/pat: acquire init_mm read lock on attribute change to avoid UAF
      x86/mm/pat: allocate split page tables as kernel page tables

Mike Rapoport (Microsoft) (2):
      x86/mm/pat: introcude cpa_lock() and cpa_unlock()
      x86/mm/pat: fix effective RW computation in lookup_address_in_pgd_attr()

 arch/x86/mm/pat/set_memory.c | 95 +++++++++++++++++++++++++++++++-------------
 include/linux/mmap_lock.h    |  2 +
 2 files changed, 70 insertions(+), 27 deletions(-)
---
base-commit: a5a162fe1ae130e3d2ceefef3f43afe3773c1d56
change-id: 20260727-cpa-fixes-d3c73c075672

--
Sincerely yours,
Mike.

