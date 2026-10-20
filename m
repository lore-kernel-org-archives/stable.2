Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508174;
	b=d2y3LazKM6vBIOX/neYEv/2lQPVntPi954LtjvNcmNi4X4Ta+zEiY/K3ft3hNmtF5mhr
	 mTp1fQ/YVBXRjVvRX1ZE5qprnPQiBJB/ZPjhkbMGIRbaCtyokCI6QEKa7U030teRc8XKE
	 5PaRp9B8x+k1vOEdYnaQJ/A0WOzTLawP52m9VPmyu1D7fmEdCFFFypQO2FCXJWFwS92zP
	 5g3ravmFsAwWT5afFrXzchI7iq2h81rg/Qe5oLPQqnJeCs1qz7r8CvZJtz2KrhSSfgj4E
	 5zGeC3qCAoujZZPjBeSB6VKmhkxLBx8KvqPp9F6vOc4nnWh1oSqVx9bFNZaChk3E+kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508174;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YPJwaVZNA7XKvLKxSJHwt8AND996P5FWcqMfwW7J6O8=;
	b=HRE0AjtEFfVJByL2aUemlOSYqOEdIkKLQKZIZX66jz4WOtAxtZyBuBZ/+RFBMb6YnlzF
	 svAfe04Zr9uxNTOjethg9fCQo3PzC+2PC8p7arOJP4Vlz8Vo6iZM4B8TEr2y0uXhv8jpI
	 FLCg1da5NKa/DZPuIM5uvqbSUUtWvCWfFlHavUGt93qLb3w8RCnEpon05+L5ykDB0pbSr
	 kBoOT0nDM7UiOzBsa9VLqYHDnEDusMg2Ypom+HcQhDft4eYF0FPBkySP70QJmTGQzRG4M
	 vl+DwK2Hl5avK/UmPNqz2+fApwCI5MokJ5n+1ozX3V+lHpv+f29W7c7IPDgyvH7NTDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Br31H+Qh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02501606A31C;
	Tue, 20 Oct 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Br31H+Qh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918F31F000C4;
	Tue, 20 Oct 2026 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792508173;
	bh=YPJwaVZNA7XKvLKxSJHwt8AND996P5FWcqMfwW7J6O8=;
	h=From:Date:Subject:To:Cc;
	b=Br31H+Qh0kx6ex2p34z1bcfok8kj+ZeG4llZ75BUvFAo1Dq1oPIxoCeoO6p099xDz
	 B1wVy9dJMNDsufbp48mbsveiXBnHWXzouJ2SZR18uI60w+/rYgyR12elBi5JKs+kSv
	 tJNFoBdiDltvan4+zjzPLiRRlFGYh1nuA1ow+lXudu04U2EPrBg5DqrSrNJxtYqVhZ
	 Rbbr2NYOqf8bZeChGqW6uCbepAEJJ5VGDKkbO/h0ytPeIKRPxM+ivmh4DjT3fIABJj
	 yUGQyIgf6H4bPp5IRLW+NdAItwvsBLXzNwErHvQjRHby106yriXO/hY2eiQw45B43C
	 fpN2VdGoZJcAA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 20 Oct 2026 15:55:30 +0100
Subject: [PATCH] mm/vma: avoid broken uffd merge on mremap
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
Message-Id: <20261020-uffd-remap-fix-v1-1-0f34fc181f0a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7bsGMtPpKdDBbaw+VKEUg/T3pO
 AMzGRJFpgSDyBDp5sTnUaCuBLjNHishL4VBSaVrqSRe3i8YabcBPT/YG610Z5q5dQZKFCIV/Q/
 H6X0/AQvrAmAAAAA=
X-Change-ID: 20261020-uffd-remap-fix-97626873b5c7
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, ljs@kernel.org, shaos <shawnq1@163.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794; i=ljs@kernel.org;
 h=from:subject:message-id; bh=rkxTHg5wm6NIA3xJt/qMKzEyYMHeWzpVxMG0VaLooEw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKuN7JNvNWf1Vdy3yLzNEfs+l7e7qnXpQ5tX6m0fbnpS
 hbltxv5O0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRRZqMDOs3JJY+k65a7/LB
 xMfJYNOLhWrzYsMOz2d7ueDLhDX/2hcy/PeoU1p0Vn3f/eZJcSmsP9+Fcstv0d8ey2MlUOnGuET
 +FicA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Userfaultfd often causes unexpected interactions within mm, and does so at
the intersection of uffd, mremap() and VMA merging.

When an mremap of a VMA occurs, copy_vma_and_data() calls
mremap_userfaultfd_prep() to notify uffd of this.

However, mremap_userfaultfd_prep() simply drops the UFFD context for the
VMA if the user did not register it for remap, i.e. didn't specify the
UFFD_FEATURE_EVENT_REMAP flag.

This is OK for the VMA itself, as upon page table move, move_ptes() clears
UFFD page table flags, using vma_has_uffd_without_event_remap() to
determine whether to do so.

However, this doesn't account for merging with adjacent VMAs, whose page
tables won't have received this treatment, and thus latent UFFD markers
will be left around.

Worse, it'll break UFFD for any VMAs it is merged with. This is very
surprising behaviour for a user, who will then simply not receive UFFD
events for VMAs they ought to.

Resolve the issue by explicitly checking for this case via
vma_has_uffd_without_event_remap() in vma_merge_copied_range(), the merge
function explicitly designated for mremap() operations.

Also update the userland VMA tests accordingly.

Reported-by: shaos <shawnq1@163.com>
Closes: https://lore.kernel.org/all/20261020110748.959870-1-shawnq1@163.com/
Fixes: 3cfd22be0ad6 ("userfaultfd: clear flag if remap event not enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/vma.c                          | 5 +++++
 tools/testing/vma/include/stubs.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/mm/vma.c b/mm/vma.c
index de5ebc57e7a5..1be613044b4a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1211,6 +1211,11 @@ static struct vm_area_struct *vma_merge_copied_range(struct vma_merge_struct *vm
 
 	vmg->copied_from = vmg->middle;
 	vmg->middle = NULL;
+
+	/* If not registered for remap, uffd context will be cleared. */
+	if (vma_has_uffd_without_event_remap(vmg->copied_from))
+		return NULL;
+
 	return vma_merge_new_range(vmg);
 }
 
diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
index be8f5161f92a..f786a585caf0 100644
--- a/tools/testing/vma/include/stubs.h
+++ b/tools/testing/vma/include/stubs.h
@@ -386,6 +386,11 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 	return true;
 }
 
+static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 				    struct anon_vma_name *anon_name2)
 {

---
base-commit: 3eb3e848d72cde2156447cc960ca321bb2ac41a9
change-id: 20261020-uffd-remap-fix-97626873b5c7

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

