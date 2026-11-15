Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794776405;
	b=SfPt2DefOlTbQs4xHfbRZiCr4QtMuNqocGiNZIyfZaXvKDy4N3dOrJel/swuxxlcH3Wr
	 tzm7P53qwYgCxMWsABjHO26aojN/Qqeyd632EWrhv5uJqrGB8N5azDTwPzjP2PkArjCCD
	 5swU7iNFUXCU7wTpZOVY7VGTy6Vg3oJvgry58bSeKKYjr8qYx4qk3RIIbZ90bTzAOvcBa
	 2WPfPyL4aPgnosbr7k1S/FP/Oy1ZdR9XN4NBhtSRyGCEGHJ5JTQtB6KWhL95sgfH5Mmk7
	 zxYCPyvsVnw3+6LOuLfgMYJZ5yaOduEDPIAE33qeg0SCGTbMwjS9ykcl71yIy0HTmrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794776405;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LeV6YEX2bH1ZNj9o0DW+0ahAYdvJN/jsXTtdRU8/9AI=;
	b=NzvVo5bwMrAnAzQcUHkcYpHFkDJoxflIg56MKSOQE09xOSIEs8rGWF35YyCiLF0Purec
	 8xgzGc/M5FQ0ew3XWbtN/fy0cQaADljygyNS3XbGefyvMqL9I1DmqzWtm8T5eR0P1/bGf
	 K+uqO+kxfCGM+EjjuzNurjeH6eCcZieNNkKgPcOHz9KpAIW2d5s1iEM4Vs3NHnbQP6BhD
	 Fk45fJSkM3jVjroV57s0TaV142L2CtlJdpiEYMAWK1gAxhHHq5EghQa+MSzjf+8hji6R5
	 hWbDsNR3RoiF53WtubK+N7YlPHnDL/D9XaaOr9kKT7TlT961gyA/9z7xKUzU+B15vzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2cip6gm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB12606A323;
	Sun, 15 Nov 2026 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2cip6gm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B013D1F000C9;
	Sun, 15 Nov 2026 21:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794776405;
	bh=LeV6YEX2bH1ZNj9o0DW+0ahAYdvJN/jsXTtdRU8/9AI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T2cip6gm8gB5h95y1ybRRsuA+GQPaDaTHCotw5DYJinkceb7agyh9YzpHtd/ZEFQb
	 m2LT8aDhL4DfNsxEZNB9+VGr+mEgYXQdLRGIo8WCwWeZuj5gGy2RjGH9U6KEFJX417
	 /JxhVXOHxbIt1IMPriPNrf0/4Qyw0v4mzLZ7z0Mg58Y2UCXk7U7pgSFCDgzsxQ9kTC
	 U8m2Fdyz1h8vxmjkgh+hOD/1cK7MT52qmKyujfXFv+UDn/JVUOruPqpLYtU5MMCNGH
	 CSMCTJEhIzT8RMee8Cuy8IF9YrQHecKhSHE0j3z4hBVvgBARrEygKu0+QcQKpInfF7
	 Wa5ztp6frLqxg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sun, 15 Nov 2026 20:58:22 +0000
Subject: [PATCH 3/3] mm/huge_memory: only compare PFNs of huge entries on
 huge fault insert
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
Message-Id: <20261115-huge-pfnmap-fault-races-v1-3-537605643f6f@kernel.org>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
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
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2744; i=ljs@kernel.org;
 h=from:subject:message-id; bh=WviD5NyuI8opANfsL1TGM2rHrGogh6uBq1tLgREc0rU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJ+yTrZHDqktpfZQmBWYV1LwAvx+w+yrrsrn5JO1fm76
 //3l7++dpSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAim6wZGdb/XdPJ9UmSpWa7
 UvJV+YwdybaGkhE9SxhW7+ZdZGaxU5iR4cner53/r/R9P5FSLKSasu3KK1HNtJWbjjuvnHTj3wG
 xrZwA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

A driver that implements both ->fault and ->huge_fault must anticipate
concurrent use of both.

This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
concurrent with faulting, as that only holds the mmap write lock and thus
does not exclude faulting threads stabilised by VMA lock.

insert_pmd() and insert_pud() have issues with this as they both assume
that, if the page table entry being populated is not empty, it must a
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
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/huge_memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0d589be136d2..da632c3e834b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1643,6 +1643,10 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
 
+		/* We may have raced a fault which installed a page table. */
+		if (!pmd_present(*pmd) || !pmd_trans_huge(*pmd))
+			goto out_unlock;
+
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
@@ -1770,6 +1774,10 @@ static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
 
+		/* We may have raced a fault which installed a page table. */
+		if (!pud_present(*pud) || !pud_trans_huge(*pud))
+			goto out_unlock;
+
 		if (write) {
 			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
 				goto out_unlock;

-- 
2.56.1

