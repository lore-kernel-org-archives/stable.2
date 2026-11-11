Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418841;
	b=kUNURgjTqvuOJuJrUpdsrBOnTvkGQwEJ5XKegCVCUK6MeRm7tnqo1AUWw3lqXeAn4P+h
	 51dki4YvobTYFg0amN88AFd1DBS/GF9YsB9bqMRj7yQO9nElNHl+6QfysIDz2qzZSxJtj
	 N7x3Wmdjv7wOq3n60iUw1IAJTg6Tz9CDENi4YjomztxI7Id7YsYFaiq3jMP93kWQbuyOR
	 mGs8ZJUQg4hWxuLF1y+0X+ZJPEvYwMeDUJ28sYWqZNs1X2h0YQjFKFaxJUMurSzGnJhHz
	 5B6AZP+esUNivf2TJWaVkYp+W6MCu0pjdClKOQjj1X7gfK2bLFym1acXI6lstY0r9NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GtpazhxHVGSqSmON1ZdBhUdGDg0vagSnfXd+dbRYIb0=;
	b=0jtL+6ncWE9ZZftuVa+Vs2QVerHZbg+W8NNXyfy6otfns5h4Y64D7RMuuBmngzHsrang
	 a81ht+nLMxQldzsuc4j9f4tW6uh2T1D5Z6xLeDui0Tkv1BWM1LjlEwi86sAMqAFbe7PJd
	 /bswXIq0t2fomeIoGNtRv9BtA+A7bVCTadzfx08SKg70ffeOovezgKm9U82a8p4pAs0Sn
	 fXVcVBvAq/t2jZmTYabSwCnELJAnUaxpLL1XRJg2kdjy+ZrITNWd1CRoxE/VIceDGh+G6
	 RKA7YTn7OK9v193FVM0MXPbKO6DHrVP0kP0/GBH3BoKGURFDY2K5FCwe5v6qMDCP0GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VEF/aipc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A971606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEF/aipc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6711F00A05;
	Wed, 11 Nov 2026 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418840;
	bh=GtpazhxHVGSqSmON1ZdBhUdGDg0vagSnfXd+dbRYIb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VEF/aipcaytmgAj2FIJjeDXk1K6IT0QvWeODW1sgCVM25tDwWo6TWTIG37RHOlGYQ
	 FwqVWdvuPleaQn0Z7aItiJf4iE+2MYjPJ2ZDDfj+HIrAn25u2W81oNnKGLbGGt/33x
	 t1S+YhqLGyrVtb8TwZo1sL4uyW7z5p0NHSFs1iteTV7NyY+Nac2cGsndUcog9QBf01
	 OQrxN1F2rB19B/MnA9B/OJVhI85AYnjfKO2eRO70FsjcPLBi76p5UtdTER/0u/oZAU
	 Z+Qu7m8fAbhG9URm7yDdL5yQ4YxgU90pFfmjI/0OD5JOZ8yG3sDaT8335xMQX0eqQk
	 CcU4eCP9pFv/A==
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
Subject: [PATCH 6.6.y] mm/vma: avoid broken uffd merge on mremap
Date: Wed, 11 Nov 2026 12:40:38 -0500
Message-ID: <20261111174015.3620118-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053917-failed-6.6-68cb098eadda@kernel.org>
References: <20261107053917-failed-6.6-68cb098eadda@kernel.org>
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
[ sashal: Adapted the guard from vma_merge_copied_range() to copy_vma(), assigning new_vma = NULL instead of returning NULL. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4fb3f7156dc35..10d5e416e80d1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3426,6 +3426,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (can_self_merge && keep_source &&
 	    (addr == vma->vm_end || vma->vm_start == addr + len))
 		new_vma = NULL;
+	else if (vma_has_uffd_without_event_remap(vma))
+		/* If not registered for remap, uffd context will be cleared. */
+		new_vma = NULL;
 	else
 		new_vma = vma_merge(&vmi, mm, prev, addr, addr + len,
 				    vma->vm_flags, vma->anon_vma, vma->vm_file,
-- 
2.53.0

