Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417746;
	b=kwm4hq6pK4x6xE7dMeUzVerjIgY+MzA8UL6Cvbp5UMGq+iE+zbkgSNEBfHejt7T1PSci
	 BnmVfn4Fc0IanXJYfNgB62UPBvu1aO+DmFTZxQXxl+LHuUt3MFnVE6cg5RcQYSOUpP2yS
	 TKnZDicr9QWbrDtBfnqPbrQwx9WNYiavcjRW4ByIw5RjYwUhCW6YmGA4ovj8R0DYTF8W9
	 tEbmUS2DIEP1uYYn98I+nknuqG8dzhT23Uv32pcA2PlLklA9vjPLNdmMpGALvyoA3MOSN
	 uXX5v/LPtsnDXc4FKlUKsRnx5ZDt4Jc5f4Pzib6GNouMM07AGClJzP6DhTooZxYns+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417746;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lt8a9XSiyuQGhK4GZJrzOjlDTaWqozdq9+trvXVMOLI=;
	b=p13ogNBrUtyA9/RyxwLwXsD5+VFnFsKuUL3Ex6Qwbost+4WH/a0Rq4000GffrCRVKM6q
	 UfNuCV2Zh45HyG1G7ZJO9cZxGaRJABQ5hBCEE8kuNoYKjGxDcrtsgHVOHomZv5aEUtiJG
	 aTGvXBjIYCzq5Qkx/13EcdNADPgXYb0g1ZVnmkT/riFym9WMZdWb8rVbbhcGLxZW8AQTf
	 SeFWnyZPuDoFRHmV5nzgCDqR0bWAfSifXCIW8DjgcfcBUzUWigb7MylY9WTTD8WqIIAzc
	 uvc8zd9pKl9iXF/D0TUr/WOjaJb4zbJneqpkN+sslaGFoqrS5nlGmJWQR7Ooyd/h2Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ST88QuUt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F5606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ST88QuUt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E161F00A05;
	Wed, 11 Nov 2026 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417746;
	bh=Lt8a9XSiyuQGhK4GZJrzOjlDTaWqozdq9+trvXVMOLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ST88QuUtJCz7qsT5x0wjMEzqNtAgPER6iuvrovEiWkVq6kFoh5BKeBE/LAxSW+CiH
	 hNlxlf594nX8JG6Hio9TOcZ4zBG9zTYn+kxqxgVIgZrfjHE4J3jDFv46y3CTuo6EbQ
	 H88qXWctAUh6qb+XHBFwIjK0EfsTgNlGqO7porxDu4jGPvlvuj4KEqxuppUMPy8IhJ
	 ma2skRqo14AkLz6qP7ULPT/ptbHyoZPFkhAVg2fjmaR6PzsnE6TAbcfw4ccevLoL1F
	 8c0oY4P3n7XH/jRfLJ6M7c5Krn8dKe8w1g/0ZLQOjrfEtuFirtWdUClkKaUOuWqG3U
	 Jr8vvkIvOIT5w==
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
Subject: [PATCH 6.18.y] mm/vma: avoid broken uffd merge on mremap
Date: Wed, 11 Nov 2026 12:22:23 -0500
Message-ID: <20261111172211.3531021-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051435-failed-6.18-68cb098eadda@kernel.org>
References: <20261107051435-failed-6.18-68cb098eadda@kernel.org>
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
[ sashal: replaced the inline test stub with a constant-false macro in the existing test harness header ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c                         | 5 +++++
 tools/testing/vma/vma_internal.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/mm/vma.c b/mm/vma.c
index 8669da66edc5c..2a4daf7905e8b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1145,6 +1145,11 @@ static struct vm_area_struct *vma_merge_copied_range(struct vma_merge_struct *vm
 
 	vmg->copied_from = vmg->middle;
 	vmg->middle = NULL;
+
+	/* If not registered for remap, uffd context will be cleared. */
+	if (vma_has_uffd_without_event_remap(vmg->copied_from))
+		return NULL;
+
 	return vma_merge_new_range(vmg);
 }
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index f64064ee48587..b736528815bd8 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -802,6 +802,8 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 	return true;
 }
 
+#define vma_has_uffd_without_event_remap(vma) false
+
 static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 				    struct anon_vma_name *anon_name2)
 {
-- 
2.53.0

