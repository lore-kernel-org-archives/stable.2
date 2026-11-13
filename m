Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603897;
	b=bECLsSB5E3xctJzm61sDQzmKF+28aWvPgxvHvG8LutXxOcWO10EKnRzz2UkUXn5x+b7g
	 IoNfG+AoHm7EdrZCAnbg6BDXGsnrs15x9SLMWdR5c/f+2i7D7bEaFEKyK5itIgIaXpbxK
	 GFl3AMQ/Do+mGUaW3vsLmellpZAEYpNYEtMUyUM6rBCyBKAFHLBokRcLFuMpOmEZB3KCO
	 ublNfWcWzC/ouFTA4HiGVihJJDCCudYebXl9xDVhFEY9HQUGYam4r9VV/LCJHcBrzv3Pa
	 6HOQnTAM4xwuCyTh7Cw5jhr1NdQ1Qqilmdk7H3En0y4/gZZZBOtxaRRJ5kmaLYS1/CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603897;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1ER8KpZ3zfRFsc0jAuE6Pv7xhdhSa8bJ/BY3j/U6NO0=;
	b=CyVco6XJLR9+9ySV6itcTpumN6i3Mpya20K5BO5lVN7nR3Fwu4PpfMQL6S5ztXTqoktd
	 aig7N6oYq/dpITg+N1hMJm72VPiQ8fqmAMjqcXB0EFo+Xu8FdZJS+32oYjn3x7hb9H3LW
	 WWhk2+z3D5iwvlelJ4X0laBaXqCkr2ucIbZ9j3mRW9CZ9KMF+zuHOgIUD9pXn1IkEwZUN
	 samQanOXQWIS30bkscHRhcUqFdXw8XEmkG87ea7AQpbVfLbDfBrwBySCNXOMkAVEuCD01
	 OmYOPHEv13cZ3fLLl1PmA4rRnOo9CHxogf+rcjy9OMEcqMLHx71NMQa2HpSxiiccDCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBDkP1ME;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B8606A332;
	Fri, 13 Nov 2026 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBDkP1ME
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DE21F000C4;
	Fri, 13 Nov 2026 21:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603897;
	bh=1ER8KpZ3zfRFsc0jAuE6Pv7xhdhSa8bJ/BY3j/U6NO0=;
	h=From:Date:Subject:To:Cc;
	b=XBDkP1MEYjEMGPCiPmFni2Ws0WRv4aL3OTjNO+w9UPvmGu3mzeiYhRQTgvPU1N5Ev
	 WA4d2hotLdiO5VF0t3MnFFJvphAgOW98+piK5A+4gmOygY3s4Y9xD3ZEipC4yhHiW6
	 wifW6CuA4bs01ifCUkSQc+VFLckm+nmsBVJC40SP3Wb5pYGXRKjv3SSZSCNVZEL+7h
	 LzH5FlT1p8yBdLx9YdQetNOkI4mXGsUbfRFYsYHVB42fFy1YNYm616jr90CqWVrv5B
	 HB4o/T2Dbm09kOwGm1ZN3/mAJEinmVexTAVx1gdUhbIboA85h2OUY59SQqm7FpDkuJ
	 cBi1c7kytoqWA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:04:45 +0000
Subject: [PATCH v2] mm/madvise: zap markers from guard regions
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
Message-Id: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBAAv0J6do27URFP/sNwWOgWNpLWtIAaw
 t+tvMDjzGFmMUmiSjLXYjFRZk0afAbaFabt2XcCajMbOtAZEQmsJh6G8ILJOQvdxNGC+jRmCXy
 i6ohUsS0bkwvPKE7fW/1eZ+41jSF+ttmMP/tfd0ZAaFp3aZCZS5LbQ6KXYR9iZ+p1Xb+8kMwdx
 wAAAA==
X-Change-ID: 20261112-disallow-uffd-guard-install-a5294129ad7b
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, ljs@kernel.org, 
 Tal Zussman <tz2294@columbia.edu>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5253; i=ljs@kernel.org;
 h=from:subject:message-id; bh=ood4PU4Ndo2QhkvUaqc8rbDLFfrVqELevFrBKP9tELw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+Vxfezvg0d+LfR989XbMj/8rY+k7wXj/j6WOriLDW4
 //PLD97sqOUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATea/KyDCJ+eCbM6zllktM
 mRe/TTuTKn+TbXZY8/amri/OD+78/3+L4b/3VQXmLHEhlowZvikJQRt62XlYyv4n9pzenvfr7Id
 X1swA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

In order to establish guard regions, guard markers are installed in the
page tables of a mapped VMA.

However, problems arise when one tries to combine this with registering a
VMA for userfaultfd, as such operations may themselves need to install page
table markers such as uffd-wp.

When the installation is attempted the guard marker prevents these markers
being applied, which can lead to unexpected results (especially if the
guard regions are later removed.)

This is especially problematic because guard region installation causes the
regions to be zapped first, meaning that the removal of userfaultfd-tracked
ranges will not be logged in this case.

Additionally, the uffd-wp page table marker will be propagated regardless
for file-backed mappings as the zap being performed does not clear these
markers.

This is problematic, as it can cause repeated failure to install guard
markers resulting in an infinite loop.

Therefore, update guard region installation to invoke the zap with the
ZAP_FLAG_DROP_MARKER flag applied.

Both before and after this change, uffd remove events will not trigger on
guard region installation, nor will write protect state be propagated after
guard region removal.

This makes sense as conceptually, guard regions mark a part of a VMA as
effectively unmapped at the page table level, and removing the markers is
like mapping the VMA again, over which operation uffd markers would in any
case be lost.

A survey of open source users indicates nobody is relying on installing
guard regions in uffd-armed VMAs. Software including glibc, android,
tcmalloc and CRIU were checked.

This change means that any already established guard regions are removed on
zap. These will be overwritten with the newly installed guard markers on
success.

However, if this fails for some reason (fatal signal likely the only
reasonable cause), guard regions may remain removed, and concurrent faults
may succeed in the interim in the range.

Since the installation failing guarantees nothing about the range being
installed into, and since success overwrites with guard markers, this isn't
an issue.

Since MADV_DONTNEED does something similar, abstract the zapping to
zap_range() and call it from both places.

Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
Reported-by: Tal Zussman <tz2294@columbia.edu>
Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-9-00713d368976@columbia.edu/
Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-10-00713d368976@columbia.edu/
Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu/
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
v2:
* Updated to just zap everything as per David + Tal.

v1:
https://lore.kernel.org/r/20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org
---
 mm/madvise.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0214efd2a014..4f7728583207 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -850,6 +850,19 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
 	return 0;
 }
 
+static void zap_range(struct madvise_behavior *madv_behavior,
+		      zap_flags_t flags)
+{
+	const struct madvise_behavior_range *range = &madv_behavior->range;
+	struct zap_details details = {
+		.reclaim_pt = true,
+		.zap_flags = flags,
+	};
+
+	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
+			      range->start, range->end - range->start, &details);
+}
+
 /*
  * Application no longer needs these pages.  If the pages are dirty,
  * it's OK to just throw them away.  The app will be more careful about
@@ -872,13 +885,7 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
 static long madvise_dontneed_single_vma(struct madvise_behavior *madv_behavior)
 
 {
-	struct madvise_behavior_range *range = &madv_behavior->range;
-	struct zap_details details = {
-		.reclaim_pt = true,
-	};
-
-	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
-			      range->start, range->end - range->start, &details);
+	zap_range(madv_behavior, 0);
 	return 0;
 }
 
@@ -1217,9 +1224,11 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 
 		/*
 		 * OK some of the range have non-guard pages mapped, zap
-		 * them. This leaves existing guard pages in place.
+		 * them. This also drops any PTE markers in the range,
+		 * including existing guard markers, which we reinstall on
+		 * the next attempt.
 		 */
-		zap_vma_range(vma, range->start, range->end - range->start);
+		zap_range(madv_behavior, ZAP_FLAG_DROP_MARKER);
 	}
 
 	/*
@@ -1845,6 +1854,7 @@ static bool madvise_batch_tlb_flush(int behavior)
 	case MADV_DONTNEED:
 	case MADV_DONTNEED_LOCKED:
 	case MADV_FREE:
+	case MADV_GUARD_INSTALL:
 		return true;
 	default:
 		return false;

---
base-commit: 4318887a3efa4c53d6f083ccfd7105b809a3ac65
change-id: 20261112-disallow-uffd-guard-install-a5294129ad7b

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

