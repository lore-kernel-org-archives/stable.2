Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471B1DF980;
	Sun, 20 Sep 2026 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789913614; cv=none; b=HeIRqSk4SQpOU6tH0CORYW2q51co112n3gV4pDCJaMz9GzB8DbkiLw4rYwbnJSzsphIm1o153bPAS4RlStghDLsZrNjFZTmhQ3vbvTXeF2CLjeD04k0IzMhOVxdtnoha+MRmgfjgyP22iUoR+7pYRu5RcarTtOD6KYm/z/GKNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789913614; c=relaxed/simple;
	bh=+YcSOEfVDCNh71cR2TvPJ/PfisjjjYVWPIECl69VL7E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BZxCFKAtsDpQR72yZ0jeDChOzpvKuy2YMZnzypj3FUzjbHBH5J4mh5SW1A509pdcK3kLy/LmXTe/q5wcbGr01v1z3S5ngPnepPF15gj1+UYWZvGnOhExzooAHa5tr9u8+N8MquQlu/oq8oXKlajte8Kh9akW/4diVUKGzeWapPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AngTpMas; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AngTpMas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BECF1F000FF;
	Sun, 20 Sep 2026 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789913613;
	bh=A5dVatuJb8nLIceYIpRqrGfNVuiP4W5dL3y+DyE7U2Q=;
	h=From:Subject:Date:To:Cc;
	b=AngTpMasXlSp6bp26zJSCHmpf2pJfGNPOQSHmrAamM2Fnn3S7iq94uM3opNjpcTqj
	 YXrm/Pv3IrE9iWImSYOFv+rekOfHwmChKJvD3uVuOgkCT9BfIhiegOyS+sAqLdMlTj
	 9JUTW/WhduGPicSKAPloP7z2iqRWwZtiMkPSpj+b7lCoK1JDqB33tpgpAfEtHJVJB5
	 Y9Y9lsrUpV50t1ix7PgLAPmt+6W78uuVVMnJ2hh5z/HRDUG2BBg0IBTPWbbPyphYjf
	 WQyrhfXhUp+qzbM1bZlYCes4kRAa2cIGAx3FN2yP3iPcwd10MZGqPC/IkQLokoExv1
	 fSWaxha0cV8yw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 0/2] mm/mremap: fix two issues with MREMAP_DONTUNMAP
Date: Sun, 20 Sep 2026 15:13:09 +0100
Message-Id: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqDQAxFryJZNzAOatWrFBepE9uAjkNGpSDe3
 dDlg//+OyGzCmfoixOUD8myRoPyUcD4pfhhlGAM3vnGdd7hJD8Ma9z2uFDCRLoJzZh5nnBhtf2
 zoq59l6Gmpga7Scrm/BOv4bpuBXda73IAAAA=
X-Change-ID: 20260920-fix-dontunmap-partial-self-merge-74a98b1d5a65
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
 Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334; i=ljs@kernel.org;
 h=from:subject:message-id; bh=+YcSOEfVDCNh71cR2TvPJ/PfisjjjYVWPIECl69VL7E=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLWv+Lkyo2M23mq3/meP/sjkZSvzXw3HcxvfAu4wXwrl
 MH4w46IjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAExkdiojw8TMoBS5ik0Hp78S
 upi/pGF99p3cnk8qOzL73RWvNlu8MGL4799TIJzNcNjxA+viTzkpHy8d2OMg//XiBo59Els/XnJ
 XZAMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
operations that keep the original VMA in place.

Historically this has led to a lot of bugs where non-obvious interactions
occur between existing mremap() operations and the original VMA.

Commit 397432cab17b ("mm/mremap: account mm->locked_vm correctly for
MREMAP_DONTUNMAP") fixed an accidentally introduced bug around
mm->locked_vm accounting, but this wasn't the only issue.

And thus history repeats itself, as it turns out that mm->locked_vm
accounting is broken by MREMAP_DONTUNMAP yet again by two further cases,
and has been broken ever since the feature was introduced.

Both relate to the fact that VMA_LOCKED_BIT is cleared on the source
VMA (it has to be as all page tables are moved):

1. If an unfaulted VMA_LOCKONFAULT_BIT anonymous VMA self-merges it
   clears the VMA_LOCKED_BIT flag and permanently leaks mm->locked_vm
   pages.

2. If a partial mremap() is performed on a locked VMA there is a leak equal
   to the number of pages not copied.

(Both for MREMAP_DONTUNMAP operations only)

Both issues can be fixed by treating the source range as distinct from the
destination range, which is the definition of what MREMAP_DONTUNMAP does so
is appropriate.

In case 1, simply disallow the self-merge, keeping adjacent source and
destination VMAs distinct.

In case 2, split the source range ahead of time, so accounting is always
correct.

Both changes were tested locally and confirmed to fix the issues.

For the purposes of a backport, the fixes are kept distinct, a follow-up
series can add self-tests.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (2):
      mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
      mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP

 mm/mremap.c                   | 87 +++++++++++++++++++++++++++----------------
 mm/vma.c                      | 19 +++++++++-
 mm/vma.h                      |  7 +++-
 tools/testing/vma/tests/vma.c | 10 ++---
 4 files changed, 83 insertions(+), 40 deletions(-)
---
base-commit: a3d0117e02bfa1c3bb6c50e7afe42bbecdbb3459
change-id: 20260920-fix-dontunmap-partial-self-merge-74a98b1d5a65

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

