Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907706;
	b=lsLLavTO00ryJ1l/hwYNceR0TWY3oG8Ms+1https9PDPhLkA2lMhrErFE4d9ed3qCAFt
	 AeWnA84KtoWPuorAO8fgAnvuX1OrtbO0vTOVIJiDv2Bh0JPFD7/EstShcONFny2r5x1Gf
	 U/PjkNSbbxGtBMUxH1MhRCvv7QevcGdYuDUJPTpfgLhpqNkZfED5GQ4HetJSG/tgHTn7C
	 zZP0RteP/nkooRfjmCQ2t1yDSOA4H/8/qv50Oy6n2/gz2FJKr06DLeg7jWMxbJi0uSH03
	 1ENwqEjIMSIy+rV+coyUtk7q4S2oEvKEOb1hkemzLdBjj5BoeHRBVlvPjrbsCP/Q0Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907706;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JWFRXkfma6kJ/DdhTdP8QnpGxO6I9Q72iA/ysnVQGz0=;
	b=n+XwPR0YaNKZJy30PZWgMxi9znYtfWVIMurMcG9sT2i1E36TBGCrLFNKT+HBAmOqntAA
	 fVFW7U0MgtfOHhnlOa/DKOG+xC5NResYVlsiKFemLe0SZpEZgyXyuynKobdy/Rpy+hpOa
	 ltCZHuDe/VyYgOnNBkgXQnFqZIgSBchpAJNcT8GsipVFEkdrGFFut/4Nn/0vUKysSqKLV
	 zViVZiKz6Nj9WEcAZ/YFgey9v8LcuF6D6SMR1vDcRbFq3dOoPQD64GXGlnhpzSs+18GE8
	 SiTr37abt996p5bYGsMZAuKRoi7gI2yr+pnb+95OqxC96FKjXyMUNaQnk4PlpeIvpIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbvSV1cj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEF2606A323;
	Tue, 17 Nov 2026 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbvSV1cj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEFC1F000C4;
	Tue, 17 Nov 2026 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794907705;
	bh=JWFRXkfma6kJ/DdhTdP8QnpGxO6I9Q72iA/ysnVQGz0=;
	h=From:Date:Subject:To:Cc;
	b=jbvSV1cjrsKP/qSvWAPv1cKLjYo68GOAuhqUUV+X/UaBiE3CC38LaQywuesl+u699
	 8pLOs4l0099QmrGyfF4j1f83xVpk8ybz/nkh/1PZ51zaWUqRIIzTmu91GvCz9TSGQB
	 o6zO0hZW7q7Cns6vMwZqtwN24y/wJ//KrCwBtrEgY2FBA3zpaFAYjXtu97262VEYlk
	 Z0vVyNxumCUY/QaoKqluttIEUs+12PVNJMx3JKqzcEzPgi+r8mLnctXmqC8SWGllZq
	 CrOJrpFR8+Lo1DCTgAuEOwkD3JxsLbw+Qc7IvX2K4H3ppjELK1X4thD+GKJtIbA6Z0
	 DY7FduHR37bsQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 17 Nov 2026 10:28:18 +0100
Subject: [PATCH] mm/khugepaged: mark ptes dirty and soft-dirty on mTHP
 collapse
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
Message-Id: <20261117-khugepaged_mthp_dirty-v1-1-024e4a12c2fa@kernel.org>
X-B4-Tracking: v=1; b=H4sIADEe/GoC/yXM0QqDIBSA4VeRc52QFjl6lYhwedKzUYna2IjeP
 WuX38X/7xAxEEZo2Q4BPxRpXTJEwWB0erHIyWSDLGUjhFD87TaLXls0w5ycHwyF9ONloyZV1aZ
 6aA259QEn+t7frv87bs8XjumawXGcML2iXHkAAAA=
X-Change-ID: 20261117-khugepaged_mthp_dirty-067f734d38aa
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Nico Pache <nico.pache@linux.dev>, Lance Yang <lance.yang@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 Daniel Wade <danjwade95@gmail.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=david@kernel.org;
 h=from:subject:message-id; bh=pWmy/78IyBmo0DcIlSiiIb0hh8w6aq2PIN74mUuISOk=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+yJle8vm29ZbDB5mXOqzSq4v0nv1+uePGacMHyot+x
 ESKsBoc7ihlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAim+4wMjxSW9adcfTTLlmz
 U1O+RD09Gr9P5NT/tSw6Xio8L606S74xMpw/VV/LWcrw/kiGmML8eWbP7kftKlko17Yz+eXZqwv
 dNnAAAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

An mTHP collapse can lose soft-dirty PTE bits if pages were written and
the VMA was then made read-only, and not setting the PTE dirty in
VMAs without VM_WRITE can interact with a later MADV_FREE on a COW-shared
page such that all processes lose the data even though a single process
MADV_FREE'ed it.

Collapse does not preserve the soft-dirty bits of the old PTEs, so the
new entries must be marked soft-dirty. map_anon_folio_pte_nopf() relies
on pte_mkdirty() to do that, but only calls it if the VMA has VM_WRITE.

Further, after CoW-sharing such collapsed folios later, all PTEs will be
clean and the folios will be clean. One process doing a MADV_FREE can mark
the folios as lazyfree and result in all processes sharing it losing the
data once memory reclaim zaps it.

In map_anon_folio_pte_nopf(), call pte_mkdirty() unconditionally, just
like map_anon_folio_pmd_nopf() already does with pmd_mkdirty().

Consequently, we always mark these PTEs dirty (including soft-dirty) but
only set them writable if the VMA has VM_WRITE.

This essentially reverts Hugh's commit 1ac0cb5d0e22 ("mm: fix anonymous
dirtying") that back then touched do_anonymous_page() to avoid forcing
clean anonymous pages through swap instead of discarding them. This no
longer applies as shrink_folio_list() allocates swap for ordinary
anonymous folios and unconditionally marks them dirty before unmapping,
regardless of PTE dirty state. Keeping their PTEs clean does not make
them discardable.

This now also marks fresh anonymous PTEs dirty and soft-dirty in read-only
VMAs when page faults allocate real pages.

This has low urgency.

Fixes: e22f2fe72c74 ("mm/khugepaged: generalize collapse_huge_page for mTHP collapse")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Reported-by: Daniel Wade <danjwade95@gmail.com>
Closes: https://lore.kernel.org/all/20261117075246.61336-1-danjwade95@gmail.com/
Reviewed-by: Daniel Wade <danjwade95@gmail.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d2f48d78b0d7b..45875d1d3b3df 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5522,8 +5522,7 @@ void map_anon_folio_pte_nopf(struct folio *folio, pte_t *pte,
 
 	entry = pte_sw_mkyoung(entry);
 
-	if (vma->vm_flags & VM_WRITE)
-		entry = pte_mkwrite(pte_mkdirty(entry), vma);
+	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	if (uffd_wp)
 		entry = pte_mkuffd(entry);
 

---

base-commit: 1c2962a57377c9878cbefb747488324d4e678982

change-id: 20261117-khugepaged_mthp_dirty-067f734d38aa

--

Cheers,

David

