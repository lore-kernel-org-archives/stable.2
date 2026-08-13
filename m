Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69E33E37C;
	Thu, 13 Aug 2026 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611702; cv=none; b=r0bLPHcQTsrXFWO7c5ZiI/UMCmTojtfI0jUb0pR3OwNoOTONhFsl5DhZXH/tpFKLwXRS/rMfTBkAMoAERp+pfRA1YrVhGMQ6nsqX+PLVzJAT4hAcAOQ9YvK/EYqChWo4keAIuzekQmOGRRjz7gX+Xft2ZQMqf7njmpjZcqQr1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611702; c=relaxed/simple;
	bh=P/Jiauk9uo7AggRZVB48OAe10wayIG5sTIb6GWDCgOQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D6XWXUoC9zpjQyi8FYBAYdqNx55AQVEHRFr6/C3Dd/A9wsHSgwdzBkiRZfu6tE8oFstslQnR5NNRcDYo31upcyHgvAMtPoRO3oPCIqkDSrxNKzGc71CLgQRd19/xrvfAoeIlG/rI5rSsKFlt+GJuGToS4Ydcsk0/hz9dDkuBAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsbqgX3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsbqgX3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2104E1F00A3A;
	Thu, 13 Aug 2026 09:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786611700;
	bh=TeOxiJEUoJt9ta7d0802hJ6XT8ew33Za02S/dYKxQzE=;
	h=From:Subject:Date:To:Cc;
	b=QsbqgX3pco4IttYrm2WPSSzVQc3us8bd0J/04fo2HISthgSft/f/U+Vt4mA4VLmQG
	 kevvRNCb8JBMdIti0BOAJVlTJTZ9413L2W1qC8tWHp9FiyLiVG9YHbfhh5jkwV/8It
	 iQTcwbyy1RuDsq2RZJxD2f84SSpFhE1dPPSPf/eyNZbrNRlgImYqkXpuG2+wNlibSt
	 r9ZNWv1nhmLOvO9P2INYKLukrtPvhPdcStrvJR5mu+txjIhGXSai65FRF3DdRGhnQz
	 eQt9BMRMD5VS+joclkejrvcjSfRhjjteVCMiIHQGSVJvuCS9osJhU757cYwQ55q/jh
	 spV//z95QabQw==
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 0/5] x86/mm/pat: CPA fixes
Date: Thu, 13 Aug 2026 12:01:23 +0300
Message-Id: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02OQQ6CMBBFr0JmbbVMAyWuvIdh0ZYRqlJIiwRDu
 LstxsTlm//y/6wQyFsKcM5W8DTbYAcXAQ8ZmE65lphtIgNyLLlEycyo2M0uFFgjjBSGy6KUCNE
 fPe1B1K/1l8NL38lMqSAZWgVi2itnunSa7HhaqvLU9ynsbJgG/94/mfNU8hut/kbnnHGG1KAoU
 HCuxeVB3tHzOPgW6m3bPvkuFLbSAAAA
X-Change-ID: 20260727-cpa-fixes-d3c73c075672
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, 
 Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Mike Rapoport <rppt@kernel.org>, 
 Nikunj A Dadhania <nikunj@amd.com>, Pedro Falcato <pfalcato@suse.de>, 
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Steffen Dirkwinkel <lists@steffen.cc>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 stable@vger.kernel.org, syzbot@syzkaller.appspotmail.com, x86@kernel.org
X-Mailer: b4 0.17-dev

The first three patches are urgent, the third patch fixes BUG() reported
y several people and it depends on the first two.

There were no bug reports that the last two patches fix because bug
manifestations won't yell at users.

TL;DR version:

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

Pedro Falcato closed a race between text poking and collapse of large
pages:

https://lore.kernel.org/all/anCK3eWFMwZqq5ka@pedro-suse

Some of the fixes got merged into x86 tree, some of them got merged into mm
tree and some are still hanging in the air.

The changes here are collected from all these fixes into a single coherent
set on top of tip/x86/mm:
 
* fix for races between CPA and ptdump causing UAF
* update to the fix of the race between split and collapse of large
  mappings
* fix for races between CPA and vmalloc_to_page() in text poking
* fix for stale page tables in IOMMU
* fix for effective RW computation in lookup_address_in_pgd_attr()

---
v2 changes:
* rebased on the current tip/x86/mm that includes peterz's changes for
  DEBUG_PAGEALLOC
* added fix for CPA vs text poking race

v1: https://patch.msgid.link/20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org

---
Lorenzo Stoakes (ARM) (3):
      x86/mm/pat: acquire init_mm write lock on collapse to avoid UAF
      x86/mm/pat: acquire init_mm read lock on attribute change to avoid UAF
      x86/mm/pat: allocate split page tables as kernel page tables

Mike Rapoport (Microsoft) (1):
      x86/mm/pat: fix effective RW computation in lookup_address_in_pgd_attr()

Pedro Falcato (1):
      x86/alternative: exclude text poking against change_page_attr()

 arch/x86/kernel/alternative.c | 39 ++++++++++++++++++++++++---
 arch/x86/mm/pat/set_memory.c  | 61 +++++++++++++++++++++++++++++++------------
 include/linux/mmap_lock.h     |  2 ++
 3 files changed, 83 insertions(+), 19 deletions(-)
---
base-commit: 7da514d819a0afb148634aac92b3d190f34947c3
change-id: 20260727-cpa-fixes-d3c73c075672

--
Sincerely yours,
Mike.

