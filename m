Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B89223DE5;
	Wed, 30 Sep 2026 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794050; cv=none; b=e+miEeRyRYd0N0B/xZSKNqbhlBv8cZjeCQCvp8LKUfLaLHrYdX8oQ+sIpbU97cmD/dRQrrOiZlTRfRA0hKv0Eyzw1vFY0JAgpyXLbNrcqgb6b5ESVQYZoQ7o8tpBKtuyxUjC7PKK1gEDaRLWl2mdqsUa2N8SKIV+1fuMCqDEUAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794050; c=relaxed/simple;
	bh=5wUqWsURO4rs1oMkv+4uI03AHJwb7y6msO+KHQvbPDo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lv9A7kcz4+LCehHQ9yF0HiOHp+ts+yC10OMTNk80/zdqPbSICwbsrCq4xuIkyMlHOVyLB042kKs8n16g4NOyq0/K7UmS5KTkn9xho5jK+iAfhCj2zloN96jF4tqBJNEQoBfv8zGMJ/wzqYlLK/fuZThP6PC9QmDTYOvYRi2UwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADxd7IJg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADxd7IJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451E61F00898;
	Wed, 30 Sep 2026 18:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790794049;
	bh=yD+kiY0HoTfxu66erBXAF33xLs4HT8xVVKYchh0t2N0=;
	h=From:Subject:Date:To:Cc;
	b=ADxd7IJgoc5YI2gZqwnPdRQnBd2GhhLLKqu6VNKYetbeqpEDWnafR09CiVwl391ok
	 2LeVaPvqivS45qptH6cB0DzCJJ1a7T1RBohe3a+1cWt3ibs9edPEFRi9N/ENoJiGUY
	 0937Bi5vVgx6udRaN2VRTvP5SjL2CG/9SRQIM+fiikTi9xDNVKiEA9ip4rnc9u3Dob
	 Ut8eZ+texE13OAr/+PpznWs2ms1IBz7M7DcYcjOL75fknGaybDkDx90nnaCvDi/EdI
	 TOuY377A23mWLOeE/tvXlRyVLvS2cyUaOIY0ewOMo5wLg9iaRsHOhDVXxETFpnm4Jv
	 bA0s5K0ofMMbw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v2 0/2] mm/mremap: fix two issues with MREMAP_DONTUNMAP
Date: Wed, 30 Sep 2026 19:47:08 +0100
Message-Id: <20260930-fix-dontunmap-partial-self-merge-v2-0-f388985a0f0a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNQQ6CMBBFr0Jm7ZjS2AquvIdhUWQKE7ElUyQaw
 t2t3MDl+/n//RUSCVOCS7GC0MKJY8igDwXcBxd6Qu4yg1baqlor9PzGLob5FZ5uwsnJzG7ERKP
 HJ0nun0+urtqyM84ayJpJKG/2i1uTeeA0R/nsj0v5S/+QLyUqtN63xlhf+aq9PkgCjccoPTTbt
 n0BbkGHcdEAAAA=
X-Change-ID: 20260920-fix-dontunmap-partial-self-merge-74a98b1d5a65
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
 Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2742; i=ljs@kernel.org;
 h=from:subject:message-id; bh=5wUqWsURO4rs1oMkv+4uI03AHJwb7y6msO+KHQvbPDo=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLL2RtqK7lFwSchj92X9fXVG8fZ7pv8ltG7Mmi5RsUwih
 dGmt42ro5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABNhf87wV/z9xNtfvWfpcBy4
 viP38oq84i3y9x2iPWK9tUwfuJbrTmH4p2Vtfq3eeUL1iW8s/EXfSx7Je4vqZX71Srp0/dL7x5x
 V/AA=
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

In case 2, split the source range ahead of time if the VMA is mlock()'d, so
accounting is always correct.

Both changes were tested locally and confirmed to fix the issues.

For the purposes of a backport, the fixes are kept distinct, a follow-up
series can add self-tests.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
v2:
* Added tags (thanks everybody!)
* Updated 2/2 to avoid splitting the VMA if the VMA was not mlock()'d. It
  is only meaningful and necessary to perform the split in this case. This
  also fixes the proc_maps_race selftests that broke, as reported by
  Anirudh.

v1:
https://lore.kernel.org/r/20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org

---
Lorenzo Stoakes (ARM) (2):
      mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
      mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP

 mm/mremap.c                   | 70 ++++++++++++++++++++++++++++++++-----------
 mm/vma.c                      | 21 +++++++++++--
 mm/vma.h                      |  7 ++++-
 tools/testing/vma/tests/vma.c | 10 +++----
 4 files changed, 81 insertions(+), 27 deletions(-)
---
base-commit: a3d0117e02bfa1c3bb6c50e7afe42bbecdbb3459
change-id: 20260920-fix-dontunmap-partial-self-merge-74a98b1d5a65

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

