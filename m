Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC24E4C28;
	Tue, 13 Oct 2026 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891694; cv=none; b=C9iVOE7m4hgpODN1czonydreE0tW7gB0MMGQickcznOFe4lr0eKf5QqHCDWzSPD/OL+lOz+ZSZtg+f6KUGnHcuIMYm0+GO+I9E8LF6/HWeX3vE2PbbAllS6iw5l6egqRwFiqCVQDciUR2M2DFf7obl5M3QlRVTRRGUO5YxjpQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891694; c=relaxed/simple;
	bh=9fyepUSFbap3das+eKlha3QFUTceWJGofHIg/6dNGCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=quJsgYcw8sUgLZMynRnsOReM8BUBH1zjH9SjHGod2/G2/m04XPAQEY2/RUEijJutMFt14hz9Erx3+KNi5O8e+Iy6Vye7dogXF76zG8k8AWPKG4TTk8M4uema3e/q93x04pSTn2eb7+184ovJ7w2ydjHZ+ic0lX+DeaIbSNFkmNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOLZmlgc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOLZmlgc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B81F1F000FF;
	Tue, 13 Oct 2026 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791891693;
	bh=F93gnhxwnZO5S1/DscLlicVfv27bgs8rbwtUzEPimv0=;
	h=From:Date:Subject:To:Cc;
	b=OOLZmlgce05m/yaxI8/uEpHWHpgwwZWngSGvYKvMt2dwL8iUBw3yTtiW2JE1wSqo0
	 /V88R5r9cuNnozbtMFjr5aHJW0+fUKM65LvgQKklm9RpD/MN9e3EMj4Xz3DReAydiB
	 gm10EpbDJBWYtymh9vwAaDLXkRP0OENRNrsD9OUNJ2E5q6S5ZR6EGc1kW9lISklk70
	 f5IsMMJhlEEPafgI+jSCPFzSsz4xKFuZ0RU9iYsJG6N/uigsVV1pGkqgAQhS+NEpKl
	 IZO5Kqo7VwWVut+6nd/joTJONbId64t663bDwBl6nbNOFxyJ23XgOqSGIyA8PLNpEl
	 R1ILmp+IVBkmg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 13 Oct 2026 13:41:24 +0200
Subject: [PATCH] mm: disallow ioremap'ing ordinary RAM in
 generic_access_phys()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-generic_access_phys-v1-1-b3963ef76e37@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOMYzmoC/yXMQQqDQAxG4atI1h2ISqX1KlLExl+Ni1EmKop49
 07b5bd47yRDUBiVyUkBm5pOPiK9JSRD43s4baMp46xImZ+uh4+F1I0IzOp5OMxxl4MfXOR8bym
 Wc0Cn++9avf629T1Clu+KrusD+UT1mncAAAA=
X-Change-ID: 20261009-generic_access_phys-0f3e0806305d
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Benjamin Herrensmidt <benh@kernel.crashing.org>, 
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, 
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 syzbot+49b1021becba70c1f3f6@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3277; i=david@kernel.org;
 h=from:subject:message-id; bh=9fyepUSFbap3das+eKlha3QFUTceWJGofHIg/6dNGCg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLOSTx7YW87s+XvMXWn2Z+4+nZU/npuMLN5rZ3H0VTdX
 suDoS8rO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiInzTDP6utt7Qf5NvM7+9+
 nnrm5fEjTTvyK9mqLR/sjOiyubf28m6G/7UHtOZsP9r8sGFl2te4mWqPdbkC5mne/rbjwxe96mu
 Jp9gA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

generic_access_phys() can end up getting called on CoW PFNMAP mappings,
resulting in it trying to ioremap anonymous folios, which especially
the x86 code doesn't enjoy, and which is in general just odd/wrong.

E.g., with a CoW mapping of a PCI BAR:

ioremap on RAM at 0x0000000045623000 - 0x0000000045623fff
  WARNING: arch/x86/mm/ioremap.c:216 at __ioremap_caller.isra.0+0x4c2/0x5f0
  Call Trace:
   generic_access_phys+0x130/0x4d0 mm/memory.c:7178
   kernfs_vma_access+0x1ce/0x280 fs/kernfs/file.c:437
   __access_remote_vm+0x58f/0x890 mm/memory.c:7256
   mem_rw+0x2a1/0x670 fs/proc/base.c:912

But more generically, we should disallow access to anything that looks
like ordinary RAM in the system: including allocating memory (e.g.,
alloc_pages) and mapping them in a VM_PFNMAP.

For pages with an online memmap, allow only pages marked as reserved
(PageReserved). This also includes memblock allocations, however,
distinguishing them from other MMIO is tricky, and nobody should really
be mapping them in a PFNMAP (except someone abusing /dev/mem, which we
do not care about).

So only allow access if there is no online memmap, or if the pages are
marked reserved. Reject other pages with -EINVAL.

Note that, just like other pfn_to_online_page() users, we won't care about
concurrent memory offlining; mapping memory that can concurrently get
offlined is highly dubious.

Reported-by: syzbot+49b1021becba70c1f3f6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=49b1021becba70c1f3f6
Reported-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Closes: https://lore.kernel.org/r/20261001152524.171115-1-ngocthang2710.1999@gmail.com/
Fixes: 28b2ee20c7cb ("access_process_vm device memory infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
I went back and forth 10 times and concluded that using PageReserved
should be the right thing to check for now.
---
 mm/memory.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 1f5d5f7d39cd2..5d9f757a00073 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7226,6 +7226,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	resource_size_t phys_addr;
 	pgprot_t prot = __pgprot(0);
 	void __iomem *maddr;
+	struct page *page;
 	int offset = offset_in_page(addr);
 	int ret = -EINVAL;
 	bool writable;
@@ -7240,6 +7241,19 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 retry:
 	if (follow_pfnmap_start(&args))
 		return -EINVAL;
+
+	/*
+	 * Reject anything that looks like ordinary RAM, including anonymous
+	 * folios in CoW mappings or allocated kernel memory. Note that we
+	 * cannot distinguish memblock allocations from non-RAM reliably, so
+	 * we cannot easily reject them here.
+	 */
+	page = pfn_to_online_page(args.pfn);
+	if (page && !PageReserved(page)) {
+		follow_pfnmap_end(&args);
+		return -EINVAL;
+	}
+
 	prot = args.pgprot;
 	phys_addr = (resource_size_t)args.pfn << PAGE_SHIFT;
 	writable = args.writable;

---

base-commit: 634cbf5b794b734c78631b92e381cfc85f357bbe

change-id: 20261009-generic_access_phys-0f3e0806305d

--

Cheers,

David

