Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB4572EA4;
	Mon, 19 Oct 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420115; cv=none; b=p8msmhrCKsFEgD8EtAeDZ1L8GIJztkl0h2uCwTuU0lDNILxXtzbi6PnBxEIwsmFd7UxnlGqqvNs+YkbfcraVthu0Z6MMmHxyRFE+2sdo16PjuVxuY/7KWIjbFL2cnOoOLbRcJo8u9Fj9Lh5d04HZO2TorpfJRWCokSu0vkOg4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420115; c=relaxed/simple;
	bh=1KwnnSydsrMowhW6/UrPI5beylcA0+sO0VKAeZUDuRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RLkyZTzbtd9ODig8B5XsDjhllrWOu0SQa4wWKjrOb7ym70RD4kBRZaLPGznqRaJQSqMyyssyf2jjexJCD3E1k5XWEYCFAYN+dGV5Aq/rpq1vPhmqRxl2eTr7zACR0M3OiO4ckQXsC22FSFOVbC4mrCspCCAlOmBOurRZ29JUegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0tceiBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0tceiBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A281F000CB;
	Mon, 19 Oct 2026 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420113;
	bh=a0eu8oJCqbVdCYPiFjU8ZN1euvr9n6L7NmwFCs6qrSo=;
	h=From:Date:Subject:To:Cc;
	b=R0tceiBTdz93YJdfHeH8pZUiTkWguzroOhkkNnGd4l02iujB4nuCLY6w7JpjZAQli
	 tNRk1jPdbOUxETxdoint4A+ivorhOlzSfkVh0iOq4DiRYiDgo9b4C971SNl657Txpv
	 /eU/p8GtkpyL+1c1nLliUW6yRKn9Q8myCatKat4igI2Ulgq2g160ubptBeMz+uz1Nr
	 HVb/RYaJcu0mdiiH1UHYx2Jn9SPjO5Y85XcbxpPMKFzW0KHNgyV+CewXhQWKXBokxR
	 EBfuBaX0Z2A9z7fFDEs+2NPKK6ZvoEo3sJ/w6VjTVGBwC/ZpuR4KHyPc+Hg303h3aM
	 tobUBwbRV+VFA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Mon, 19 Oct 2026 15:28:27 +0100
Subject: [PATCH] mm/mremap: populate calculated fields in vrm state
 correctly
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-mremap-fix-shrink-charge-v1-1-a3ce209e5360@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3M0QpAQBCF4VfRXJvaWSJeRS4Wg0mWZktK3t3k8
 q/vnAcSq3CCNntA+ZIkR7SgPINxDXFhlMkavPMVOWpwV97DibPcmFaVuKE5NTdw2bjgC6KpBpu
 fyob+665/3w9JyZs/agAAAA==
X-Change-ID: 20261019-mremap-fix-shrink-charge-be490a2311d7
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ljs@kernel.org, 
 "Liam R. Howlett" <liam@infradead.org>, stable@vger.kernel.org, 
 Nickolai Zeldovich <nickolai@csail.mit.edu>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473; i=ljs@kernel.org;
 h=from:subject:message-id; bh=1KwnnSydsrMowhW6/UrPI5beylcA0+sO0VKAeZUDuRc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKuafKsWPJgxxzPY3+XHFw5Q3ZZjFanlDxPwJ+ilX2ZP
 R1nJ7If6ShlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEnl9g+J+azVxxzaNamMPJ
 u3R6bLbNv8wdrxTlmlf2vly099XKr/oM/yN/XSzlbWm0MLG8ulvixdb0ppvcyg//Rngsfv59sZu
 CPisA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit d5c8aec0542e ("mm/mremap: initial refactor of move_vma()")
introduced the vma_remap_struct helper to pass state sanely through
mremap() logic.

Part of this state is vrm->delta - equal to the absolute difference between
vrm->old_len and vrm->new_len (the old and new lengths of the VMA,
respectively).

This value is used to correctly charge accounted VMAs.

When shrinking a VMA, mremap_to() sets vrm->old_len equal to vrm->new_len
having performed the shrink of the VMA first, prior to any potential
move (e.g. MREMAP_FIXED | MREMAP_MAYMOVE specified).

However it does not recalculate vrm->delta, which results in incorrectly
overcharging the VMA.

The charge leaks to Committed_AS globally, meaning a mischievous user can
cause allocations to fail across the system in strict overcommit mode.

Resolve the issue by abstracting the update of vrm->delta to
vrm_populate_calculated() and invoking this from mremap_to() when
vrm->old_len is changed.

Additionally, update vrm->remap_type whose value depends on
vrm->delta. The field is not read again after the shrink, but it is the
logically correct thing to do and protects against future changes which
break this.

Fixes: d5c8aec0542e ("mm/mremap: initial refactor of move_vma()")
Cc: stable@vger.kernel.org
Reported-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
Closes: https://lore.kernel.org/all/20261017233527.797191-1-nickolai@csail.mit.edu/
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/mremap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 6970783fc445..24827e13e617 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -887,12 +887,6 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 	return pmc_progress(pmc);
 }
 
-/* Set vrm->delta to the difference in VMA size specified by user. */
-static void vrm_set_delta(struct vma_remap_struct *vrm)
-{
-	vrm->delta = abs_diff(vrm->old_len, vrm->new_len);
-}
-
 /* Determine what kind of remap this is - shrink, expand or no resize at all. */
 static enum mremap_type vrm_remap_type(struct vma_remap_struct *vrm)
 {
@@ -905,6 +899,13 @@ static enum mremap_type vrm_remap_type(struct vma_remap_struct *vrm)
 	return MREMAP_EXPAND;
 }
 
+/* Populate calculated fields. */
+static void vrm_populate_calculated(struct vma_remap_struct *vrm)
+{
+	vrm->delta = abs_diff(vrm->old_len, vrm->new_len);
+	vrm->remap_type = vrm_remap_type(vrm);
+}
+
 /*
  * When moving a VMA to vrm->new_adr, does this result in the new and old VMAs
  * overlapping?
@@ -1523,6 +1524,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 
 		/* Set up for the move now shrink has been executed. */
 		vrm->old_len = vrm->new_len;
+		vrm_populate_calculated(vrm);
 	}
 
 	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
@@ -1795,8 +1797,7 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (vma_is_hugetlb(vma) && !align_hugetlb(vrm))
 		return -EINVAL;
 
-	vrm_set_delta(vrm);
-	vrm->remap_type = vrm_remap_type(vrm);
+	vrm_populate_calculated(vrm);
 	/* For convenience, we set new_addr even if VMA won't move. */
 	if (!vrm_implies_new_addr(vrm))
 		vrm->new_addr = addr;

---
base-commit: 4dbe24720eb3811563cd56b35d87ddf3f9beed2a
change-id: 20261019-mremap-fix-shrink-charge-be490a2311d7

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

