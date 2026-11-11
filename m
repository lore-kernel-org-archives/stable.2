Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418284;
	b=uWcZqoZtA3X2ndIETeU2X221lf/w4Ee85FoxSBEGnM0yBIhMLOel64mRgrbVhpSW7Ci9
	 yXFOWpQu9RQOULwIMaJaekgLpeyBhWNKsCquvpxjcULx0Ly74zfuqaDa1u+qiMrFM9W2n
	 Fzd/i7iPnMnNNt/YPZzwMSydUljVyYZcfHLLQnDhkCjJwiiy6LG4CLo2P5RySuFOM3vyo
	 1rmcnLdaTlerubehRBzpIOCB8DKy11RGdd1bL0VifcZ7gHzoziEoA/KgE+CV0SFX5frYe
	 proexvcHY6tE1tyrA/XJMCTxQbAQRFnnrNr9wxDpbu036SIBqKwlae3lEnb0yuUoNlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bUqCnir8HEWO8avHJ9tNwjS9AQ1UjYJhRCrovDX3rJo=;
	b=gVMh8UEZ0U3b9m4hcZHy6LGHeNU8AnxNPCle8AoyXPYCRy1gtzqktufxF8xgeLUgXoF8
	 g3cpCW0WCUjZpUr7nyD4k/uZVphA8nOxRmr1TYFXUdMDVJP5YggVGfRVySeTjy+nrplmC
	 nnvQWWB3TmU4T6snKZJ3piXc2iQjKt8/phUwNhFvuMJEvcMVQi8i7rfofhZPMMTwJ0ecU
	 93yI5o/fMtON8LNrt7aWZEIjZIWarQkihXHDQAqQ8ogHWZ2BO7AiN5N9/5h+7jyAGpoM1
	 iUMwxggRSgvtOITLXADO5KXAC0rin72PcdVMlnFO+ABHzyNM0PphcJx1uQT7e3KnJYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezHvQebX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B14606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezHvQebX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01B91F00A05;
	Wed, 11 Nov 2026 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418284;
	bh=bUqCnir8HEWO8avHJ9tNwjS9AQ1UjYJhRCrovDX3rJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ezHvQebX3BRqpLiHx30njYHZChonSz/lesj2cGVV8t/cI1K3mgETleOpEte8iwAgu
	 5CReqhIbhTWdxWqwKJ02ilRKhoBPnCUcqrdTkIRR6QZRFqg25f1CRsEI80D4bIy2rM
	 Dzrzy21pySaCxASHi73yDI+BpCagBv0rco+hR4G4KshpR1CS6cd+gzdTaOOlgcOZzc
	 WUx41z9W80tZk0xm5Sb8oYkFPWx8mIV7btijdWZGdP8jb0w3n77tqC4qi6shkyVEB+
	 1iiUM83voe9ftvUBYuuhBfx60Ty16tHH31alAZAHAMAvA7k7ZpKGACVFScvv/K/UcG
	 Uky+eUNg9hp/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	shaos <shawnq1@163.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/vma: avoid broken uffd merge on mremap
Date: Wed, 11 Nov 2026 12:31:21 -0500
Message-ID: <20261111173111.3576650-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052628-failed-6.12-68cb098eadda@kernel.org>
References: <20261107052628-failed-6.12-68cb098eadda@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 68cb098eadda190783f8f8bdf9fe764df59f7d32 ]

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

Link: https://lore.kernel.org/20261020-uffd-remap-fix-v1-1-0f34fc181f0a@kernel.org
Fixes: 3cfd22be0ad6 ("userfaultfd: clear flag if remap event not enabled")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: shaos <shawnq1@163.com>
Closes: https://lore.kernel.org/all/20261020110748.959870-1-shawnq1@163.com/
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: moved the merge guard into copy_vma() because vma_merge_copied_range() is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c                         | 5 ++++-
 tools/testing/vma/vma_internal.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 66b0472b7d8a6..85660d67b7942 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1694,7 +1694,10 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		faulted_in_anon_vma = true;
 	}
 
-	new_vma = vma_merge_new_range(&vmg);
+	/* If not registered for remap, uffd context will be cleared. */
+	new_vma = NULL;
+	if (!vma_has_uffd_without_event_remap(vma))
+		new_vma = vma_merge_new_range(&vmg);
 
 	if (new_vma) {
 		/*
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 0a95dbb0346fb..213e40afa8ee3 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -605,6 +605,8 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 	return true;
 }
 
+#define vma_has_uffd_without_event_remap(vma) false
+
 static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 				    struct anon_vma_name *anon_name2)
 {
-- 
2.53.0

