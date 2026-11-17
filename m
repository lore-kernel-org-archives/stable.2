Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940332;
	b=uTvhMz6aGNc8ydBYvJ6sCut88/eXh7eIb5Xg1qSj8lteAwi40jqMFK7hYjT7dwI5/9O4
	 9S1cNsT9CV9rwaPlXPFcxw0LIcF7c7vC4P42ObwXdYA/8Kv4THcXNxwp7cRCOCMv4oQuy
	 /HLRxUGFEf2RE0NU3O4IbF1AS6CZFmZPHkKMjFejX7iNS0QXDvN/aKlvgRlEukI0LesyI
	 hwUdkOpTdkj0LwR5lWW/31vtZHbXDjGbFqghJsxOlv4GdiqvX0fWBfABpv+Np1vjeUs7m
	 JgL7aBZEVfaIA8V0kK6iZDs9p9+Zg74i90GjPWjFycxy9RDojnfymqhIjUmoRkbUdqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940332;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PvX28kMT2JOA9V7LVP/iYVU7syU20+iC1OkNeLZAOFU=;
	b=gN1ydrq6HhEghnwQy0rci9h5kWbrGJYDz5K6Fmfz1I3DL/GMpaYsdbwgfwFbbpWKC3GS
	 P8Q9LjjxARKsJkT3BPnF+EFAR8ocDd7+4MOD+XmpChtivdXGSJibJF+UBFfjPMe1kX20T
	 nHUFYWzzijDd3vSJ/xcQDKrtctyoPNc53jI7KescQiuvZJnDnbHBFVcAsLczOpVvtwn0Z
	 M9/k/rYYlOt3MfCGJKEFmEvzR4RsMn4mKfwbh7kK+G2X8/wSPzhh5YDk+nTpVF2GxsPWM
	 zl8CN6uYswziLorbtz0IpAkCdmAR4dSz4NEFwptWOO9gXAHulB8TaKL9+lkgUAlE31g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXzWu4HH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940960A261F;
	Tue, 17 Nov 2026 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXzWu4HH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02FB1F000C5;
	Tue, 17 Nov 2026 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794940332;
	bh=PvX28kMT2JOA9V7LVP/iYVU7syU20+iC1OkNeLZAOFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WXzWu4HHGGKFkosG2W8m6TAHTJeu74jnTyk2/2eKhQg1x9D8yzJWRciKHxxA+cCFD
	 Y7/lTodu9vRLqwSXbHmwavH3ssPx1sgiilTASBf7tKG1G5/RghKa/Q2E+hKFqRZiK1
	 MwnvoPqjW1b6AavB2L0Vdqs4x6Nwo2viI+99EDD0sBbrmEF/XsKyrjhVmoEd0x9jqJ
	 5rcZaB6GM3lJYBZWlocxMaTSvYCeaWjrT2tgiSWLtfAqPqSJi5es0pxiB2o5vFSzo7
	 zBJhtMW5o0nLayEAXtz+92oXMu7Y/mIp9hBMACC6Qi0JC9r6QOnohqeRZBp/42oQ9/
	 5jyf7STTal2zA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 17 Nov 2026 18:31:35 +0000
Subject: [PATCH v2 4/4] mm/huge_memory: only compare PFNs of huge entries
 on huge fault insert
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-huge-pfnmap-fault-races-v2-4-276007e73bcb@kernel.org>
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
 Roman Kisel <romank@linux.microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>
Cc: ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 "Gregory Price (Meta)" <gourry@gourry.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2957; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Ud05cZZbfU6vNs2buNKiOFsC3ukoxS/P1Cwl2+ETDnM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLL+zO3+/e6r2kKtptUaGvku6tWvbmjM/1lsznKn7vwDq
 zWnlKZv6ihlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEvmgyMixU4NGxtEqvr/np
 rH10b7LnT5YF6az6CzftvFJltbdOuZqR4WbgijzGru3PFr3dNVdkVs78w0+l+o/V/it5V+pwQyv
 xNyMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

A driver that implements both ->fault and ->huge_fault must anticipate
concurrent use of both.

This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
concurrent with faulting, as that only holds the mmap write lock and thus
does not exclude faulting threads stabilised by VMA lock.

insert_pmd() and insert_pud() have issues with this as they both assume
that, if the page table entry being populated is not empty, it must be a
present huge entry.

This is problematic as if it is a write fault, it compares its PFN against
the one being inserted, warning if they differ, on the assumption that the
entry is a huge leaf.

Since the entry may be a page table, this is invalid and can result in
spurious warnings.

Equally, the entry might be non-present. Nothing can install such an entry
in the VMAs that reach this code today, but there is no reason to rely upon
that.

Therefore only examine the PFN if the entry is both present and huge, and
otherwise simply return VM_FAULT_NOPAGE so the fault is retried and handled
at the appropriate level.

This is what already happens for a read fault, for which the existing entry
is not examined at all.

Target the commit which introduced the first driver which both mixes fault
orders and passes the write flag for the fix (since this commit, both
drm_gem_shmem and panthor are prey to this issue).

Reported-by: Eliav Farber <farbere@amazon.com>
Closes: https://lore.kernel.org/all/20261112051440.16140-4-farbere@amazon.com/
Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: stable@vger.kernel.org
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/huge_memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0d589be136d2..ab267ad48020 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1643,6 +1643,10 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
 
+		/* We may have raced a fault which installed a page table. */
+		if (!pmd_present(*pmd) || !pmd_leaf(*pmd))
+			goto out_unlock;
+
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
@@ -1770,6 +1774,10 @@ static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
 
+		/* We may have raced a fault which installed a page table. */
+		if (!pud_present(*pud) || !pud_leaf(*pud))
+			goto out_unlock;
+
 		if (write) {
 			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
 				goto out_unlock;

-- 
2.56.0

