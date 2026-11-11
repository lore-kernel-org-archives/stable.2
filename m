Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419072;
	b=KHS+HAKgety1Frj2JZofxB3kOW145AFK+cmrVcN5fyfIreHRDOb9taaQ9y87u0d5MolW
	 W5aWfCCzcccl4760zmv/puOWeM01TaKpswMCOhcWsHwDxpelTibsPIa8y8X3UktaLySqc
	 1RC3ehOOjyspK2ptYEvyD9qavNwaz1rOeZy81N7Sr5VL02GS+dP2WZqFh7iV8NH1Z3Ylq
	 bzgsz70TvNQTJcm+O3nzSgGyT8BVq4j952tzV37/w9tSrfQoXq4uF8LG252sYg/IBjW03
	 lzUwaBvDYm5MUWRtBR15EPas8i4ARzX28v3/o7hW6GgFA5sIvKVZ3442jmdB09RAKbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419072;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eu1pudR9LJS/ojkSFIUq+Sbnrk2DIHq1hwSbTk2WBrM=;
	b=fWqxitnZoEekESJRVahMal9M6xWlKbYet1NBHIIUGWqgwOuT+LIAF1EFDeZ6YGOSCKgF
	 8GJxv6pi2oVbLyQ4dqxh/ZIPROyQ1g8RyFfUkVB2ADsCXWEN92/7z1asGr7ULyRVexw0f
	 VDxN6sn1gJCFKtefSTsjkWcDhFfvb5KDw7nzcM0DAjhDNFHVACCrQ+hJFzQOUQn3o6RHr
	 Ux1K6Fbo60x8guUfO8GJnPn2zN+7jtzL0hljtJfXiuVnVfILntIUUhvzx7hWmGB/mBUbI
	 JXozu7R9P+RlsNVPvOsQgl/iUSjdxaTs7+ycS5okJ5/KbetXgmDKhvfATlq/eYMrdtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYbFK9PX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CFF606A331
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYbFK9PX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCF31F00A05;
	Wed, 11 Nov 2026 17:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419072;
	bh=eu1pudR9LJS/ojkSFIUq+Sbnrk2DIHq1hwSbTk2WBrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GYbFK9PXKUlGgLgtQV6oND+1K5eFNKljMGePAt8Q39CPGNVbwHpukL3vrUT5XalHr
	 8OUnuKxD1KNYn1NrA1OUZexpSFtfXCyhiOqchv9WJTRSC+UAGVC8PMqFZ0Vq0a6Zpr
	 XQvrWG4DhY0zsruJunPNpxqOaj7/BapRHhAj7gQKRNnKf3uIZiPVzxhLw1tVbhAmZ/
	 F+89BN4G8rhLgNW5ge0yS5cxoI/5xKaNXWlivbfE9wnCo8nfnERq5nE7FNE/rJ1JBK
	 h75iK8XKO0qL6PPZ3JsU8dwSkwFAEXMNrCYzj0l4O+LPIKNPUkwWsWeCycBJCL6RUY
	 CANC81lrXzdbw==
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
Subject: [PATCH 6.1.y] mm/vma: avoid broken uffd merge on mremap
Date: Wed, 11 Nov 2026 12:44:29 -0500
Message-ID: <20261111174404.3673245-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055457-failed-6.1-68cb098eadda@kernel.org>
References: <20261107055457-failed-6.1-68cb098eadda@kernel.org>
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
[ sashal: Moved the merge guard from vma_merge_copied_range() into copy_vma(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 17ec4d40edc11..471dbff3e11de 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3414,6 +3414,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (can_self_merge && keep_source &&
 	    (addr == vma->vm_end || vma->vm_start == addr + len))
 		new_vma = NULL;
+	else if (vma_has_uffd_without_event_remap(vma))
+		/* If not registered for remap, uffd context will be cleared. */
+		new_vma = NULL;
 	else
 		new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 				    vma->anon_vma, vma->vm_file, pgoff,
-- 
2.53.0

